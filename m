Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1B756308B
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Jul 2022 11:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235435AbiGAJrM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Jul 2022 05:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235264AbiGAJrL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Jul 2022 05:47:11 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15F076943
        for <linux-wireless@vger.kernel.org>; Fri,  1 Jul 2022 02:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Q1IFvPtR6Gb6FXDalP2Y38jT4G16sdOHOihhoZBKivQ=;
        t=1656668830; x=1657878430; b=BDX2QkbbG/33CnVvGpYSTxj3dpXyxE1kMG/fYVHUs+sUZYE
        DZ/4Xh/kNao2SLrs1Dq5pGRJrq9aDceokjHICPcSs67TmQ3KuURrwdk0sk09ARQkj8LOthCd0KOer
        cOw3mW2aKs27CplVe3kLSpTc+ZqiDnQe/H2gwY9/2Mx6abtobGMmG1LCasJTqMZUT355dTb+54Z9f
        gv4hR+tXiEoay+/wJLUVVDEj8j/4ski9JHRCN+O4IV0aL37UmIGcKo9ud1wN/Hmb7+rld7Aem4i6c
        vH9o9W29pHHiT428IbCjDbIQHY8PbviVMcvflq/9NlKIqrGAadORfwEgMEYFQg1A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1o7DEz-003QmB-3p;
        Fri, 01 Jul 2022 11:47:09 +0200
Message-ID: <4dac4c5c118aab5a7f55a2e38b1e7f61dd94e008.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211 : Add support to track mesh peer beacon miss
 event
From:   Johannes Berg <johannes@sipsolutions.net>
To:     quic_haric@quicinc.com
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 01 Jul 2022 11:47:08 +0200
In-Reply-To: <1653893292-11092-1-git-send-email-quic_haric@quicinc.com>
References: <1653893292-11092-1-git-send-email-quic_haric@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2022-05-30 at 12:18 +0530, quic_haric@quicinc.com wrote:
>=20
> +++ b/include/net/mac80211.h
> @@ -1732,6 +1732,9 @@ enum ieee80211_offload_flags {
>   *	for read access.
>   * @color_change_color: the bss color that will be used after the change=
.
>   * @mbssid_tx_vif: Pointer to the transmitting interface if MBSSID is en=
abled.
> + * @bmiss_threshold: beacon miss threshold that is used to change the be=
acon miss
> + * timer value
> + *
>   */
>  struct ieee80211_vif {
>  	enum nl80211_iftype type;
> @@ -1764,6 +1767,7 @@ struct ieee80211_vif {
>  	u8 color_change_color;
> =20
>  	struct ieee80211_vif *mbssid_tx_vif;
> +	u8 bmiss_threshold;
>=20
>=20

Why should this be visible to the driver?

> @@ -2495,6 +2499,19 @@ enum ieee80211_hw_flags {
>  };
> =20
>  /**
> + * enum ieee80211_dbg_mask - Debug mask to enable and disable logs
> + * in runtime
> + *
> + * @IEEE80211_HW_DBG_BMISS_LOG - To enable/disable mesh beacon miss logs
> + *
> + * @IEEE80211_HW_MAX_DBG_MASK - Max debug mask value
> + */

same here

> @@ -2656,6 +2675,7 @@ struct ieee80211_hw {
>  	u8 tx_sk_pacing_shift;
>  	u8 weight_multiplier;
>  	u32 max_mtu;
> +	u32 dbg_mask;

and here.

>  /*
> + * mesh_bmiss_update - update beacon miss parameters such as

/** I guess, based on the comment formatting

You also have a bunch of robot comments.

johannes
