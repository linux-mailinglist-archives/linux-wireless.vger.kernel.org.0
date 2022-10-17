Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2902C600809
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Oct 2022 09:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiJQHsq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Oct 2022 03:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbiJQHsm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Oct 2022 03:48:42 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAD35B065
        for <linux-wireless@vger.kernel.org>; Mon, 17 Oct 2022 00:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=9a7NNq4YADpNDCpXpx4tyUPrdXcESkXViOGoN7CNADI=;
        t=1665992916; x=1667202516; b=kl36AAH35vFAuIaMzo5get2PH7FBKeqdyHxBsMMm7tZCwMO
        UQV6UM03/A+BY8OP/BF9I/tEcYGhervfn1o0OPSsEXqjL1NuDWsl3WRX0kPKz+rfmUmliy5tmkJf7
        nBBcX9wPtCIC3ueiw4LfYIK0tRIJchzfSGYYTmah0wVjvmFRtzMd/7vVevrzjT1Lw3iPXwV6BpiNQ
        qA8FoHyxb+Cbp5jCTxestx6fuh+k0TE3+CN+m8ml1XUFqItthTzmUyFAOZynMa+dSAMe0b6wnw1iD
        GJHKkRXbJrvm7BiRJjRiL5jeYfFjUBfYHUcazDH0SvksprLtTnSQHOXUYOu9FnZQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1okKrS-009BM9-0J;
        Mon, 17 Oct 2022 09:48:34 +0200
Message-ID: <91b975e2116521cfa9f9371a976039a53ed9a85c.camel@sipsolutions.net>
Subject: Re: wifi: mac80211: mlo rx nss value 0 of wifi
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <quic_wgong@quicinc.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Cc:     ath11k@lists.infradead.org
Date:   Mon, 17 Oct 2022 09:48:33 +0200
In-Reply-To: <1a440c62-ffd0-9602-9454-f08765beadf0@quicinc.com>
References: <913ee04f-a16f-f765-96c2-0586282831b4@quicinc.com>
         <1a440c62-ffd0-9602-9454-f08765beadf0@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

> > Currently for MLO test, the others links's rx_nss of struct
> > ieee80211_link_sta is still value 0 in ieee80211_set_associated(),
> > becaue they are not pass into ieee80211_sta_set_rx_nss() in
> > mac80211 except the deflink which means the primary link in
> > rate_control_rate_init(). This lead driver get nss =3D 0 for
> > other links. Will you fix it or is it design by default?
> >=20
> > Only primary link has valid rx_nss value which is not 0 by below call=
=20
> > stack.
> > ieee80211_assoc_success()
> > =C2=A0=C2=A0=C2=A0 ->rate_control_rate_init(sta);
> > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 ->ieee80211_sta_set_rx_nss(&sta->=
deflink);

Right, none of the rate scaling related stuff was updated yet.

Want to work on it? :)

johannes
