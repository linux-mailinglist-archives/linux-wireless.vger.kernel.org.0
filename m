Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAFCB69823E
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Feb 2023 18:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjBORfz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Feb 2023 12:35:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjBORfz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Feb 2023 12:35:55 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D20030DA
        for <linux-wireless@vger.kernel.org>; Wed, 15 Feb 2023 09:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Yxxd4SRBeMcxv/d15Lefe27giEN1CCN93R+1EThdVBw=;
        t=1676482554; x=1677692154; b=bRmborXmswt6KhgJtp/B0fcdytMDVun/9xIH3SmPwiWAy2o
        B5G5Cf+cvQQKpx9qnzC85sA1qLFB75aGVuCVqwJQown77dpWTFnzVVPO0oSNhNrimgwAzGtrDZ5VQ
        9SnCh8H8p/1P8wavGls9GzRU0LPtfjaqrS076uHgU59kngYFQ0V91Kb/x+y7L5ErZKjgTMu4wFRj0
        IgWAJsoiJS1RG+hEIE8f//C/lgRM1tXEs9rihg0SBBt9M8dfkTl1ZbVghLU5psRTewFXE0oEdCPW2
        IT91R2A6S9RMSR7Vwzj5mJE1T6gJ7CKwPPsCr/iKMpvWXI4bc5I2q5/GRlzr/NPA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pSLh7-00D9K3-2H;
        Wed, 15 Feb 2023 18:35:49 +0100
Message-ID: <5dadf98596e71485155225368c68eb71ee69e89e.camel@sipsolutions.net>
Subject: Re: [PATCH v3 2/3] wifi: mac80211: Avoid BSS color collision
 detection if its disabled
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 15 Feb 2023 18:35:48 +0100
In-Reply-To: <20230201065638.25990-3-quic_ramess@quicinc.com>
References: <20230201065638.25990-1-quic_ramess@quicinc.com>
         <20230201065638.25990-3-quic_ramess@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
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

On Wed, 2023-02-01 at 12:26 +0530, Rameshkumar Sundaram wrote:
> Don't detect BSS color collision and send collision events
> to userspace if it is disabled.
>=20
> Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
> ---
>  net/mac80211/rx.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
> index e284897ba5e9..5588067b2af2 100644
> --- a/net/mac80211/rx.c
> +++ b/net/mac80211/rx.c
> @@ -3195,7 +3195,8 @@ ieee80211_rx_check_bss_color_collision(struct ieee8=
0211_rx_data *rx)
>  	if (ieee80211_hw_check(&rx->local->hw, DETECTS_COLOR_COLLISION))
>  		return;
> =20
> -	if (rx->sdata->vif.bss_conf.csa_active)
> +	if (rx->sdata->vif.bss_conf.csa_active ||
> +	    rx->sdata->vif.bss_conf.he_bss_color.collision_detection_enabled)
>  		return;

And this kind of answers my question on the previous patch ...

???

johannes
