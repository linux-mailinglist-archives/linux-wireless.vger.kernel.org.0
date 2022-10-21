Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10C2607664
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Oct 2022 13:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbiJULml (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Oct 2022 07:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiJULml (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Oct 2022 07:42:41 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584FF2625CF
        for <linux-wireless@vger.kernel.org>; Fri, 21 Oct 2022 04:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=0kzAkD7MkQo5aEPd4tJHszMQy2V5Wtxw/Q64vLPsD8E=;
        t=1666352559; x=1667562159; b=xTQG/alrA0YEw/bdetvkf7fI2QCAiX80HE1Ywtx+BPSODUO
        ijgpINzAI/GXRtEhEbNcrL6XdzLWRJvcjNx16dFp5zS24lJ0WOUjVYZQBSBZB3ckHTnvFNbv3+myM
        Lk/xNUQb6Kn9hg5RkEo27e1YsQfa50fuhAEB9J2Naf/Fi1kC5AC+uN8UOlOCjI9cYeugZRhdw39XK
        7pGAelcIUgfSytwPw61EUYq9JNv0rG64Y7CXD4EN46u9CRVE4lbl/9/JXU7HY5OMjm31/qHIZxolM
        bF1zxjUAKZjQA8ARmnB2fZsGcMfLNV6adsmPOTNHXPzNu7vES0XJypqUwk1tB8DA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1olqQ8-00CqUC-2A;
        Fri, 21 Oct 2022 13:42:36 +0200
Message-ID: <b763a390dedff804015a540f097bf804ed0e1436.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: Allow NSS change only up to capability
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Rameshkumar Sundaram <quic_ramess@quicinc.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 21 Oct 2022 13:42:35 +0200
In-Reply-To: <20221018044341.5453-1-quic_ramess@quicinc.com>
References: <20221018044341.5453-1-quic_ramess@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2022-10-18 at 10:13 +0530, Rameshkumar Sundaram wrote:
> Stations can update bandwidth/NSS change in
> VHT action frame with action type Operating Mode Notification.
> (IEEE Std 802.11-2020 - 9.4.1.53 Operating Mode field)
>=20
> For Operating Mode Notification, an RX NSS change to a value
> greater than AP's maximum NSS should not be allowed.
> Hence allow NSS change only up to maximum NSS that is negotiated
> and capped to AP's capability during association.

That seems reasonable. Might be worth noting in a comment in the code
which AP has such bugs though, just so we know it later.

>  	if (link_sta->pub->rx_nss !=3D nss) {
> -		link_sta->pub->rx_nss =3D nss;
> -		sta_opmode.rx_nss =3D nss;
> -		changed |=3D IEEE80211_RC_NSS_CHANGED;
> -		sta_opmode.changed |=3D STA_OPMODE_N_SS_CHANGED;
> +		cur_nss =3D link_sta->pub->rx_nss;
> +		link_sta->pub->rx_nss =3D 0;
> +		ieee80211_sta_set_rx_nss(link_sta);
> +		/* Do not allow an nss change to rx_nss greater than max_nss
> +		 * negotiated and capped to APs capability during association.
> +		 */
> +		if (nss <=3D link_sta->pub->rx_nss) {
> +			link_sta->pub->rx_nss =3D nss;

That, however, doesn't seem right. It means that you can only ever
reduce the RX NSS, not switch it around within the originally negotiated
range.

johannes
