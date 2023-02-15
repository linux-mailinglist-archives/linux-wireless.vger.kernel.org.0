Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8143698249
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Feb 2023 18:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjBORhQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Feb 2023 12:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjBORhP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Feb 2023 12:37:15 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB893A5D4
        for <linux-wireless@vger.kernel.org>; Wed, 15 Feb 2023 09:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=G9D3YiOF4hNaUN5OWObMpcjVa4Z0GbPH9AWLkznpxxs=;
        t=1676482633; x=1677692233; b=gquhaMsFO+Cb+V89AcH5/50ZufbQFDblDqtZFHpx/CJRgL4
        4FPUIpgExGtFuWGDOtTeVP/oYAfDjLXNMUIDlMyLypnf8tSbQp2gOHmxBuudkmrgWV4ciyL9gDi9m
        DJAbkpX+td7RtkFyASlbY2eaQcUuCUdo9SDg9+M7D0XFVwaJ/qT1DUz3e0/FBHEbQsw/df5hsAes1
        yExa4aNNHaRXgiiooTBmu+JuivLBOPfa41Gj361UtWAU56D8yOpx4Rb9YsjgzsWfbk1qhqisU2T3N
        vjNBY9mkf7WB4T375tvFXpbUF08NjFVJCYe2PeGyxSlCdSou8+NkoDwpIvHTic3Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pSLiP-00D9LQ-0T;
        Wed, 15 Feb 2023 18:37:09 +0100
Message-ID: <107b5dcc63d9f421f0bd38b6fe8d1a4ae1ed0b33.camel@sipsolutions.net>
Subject: Re: [PATCH v3 2/3] wifi: mac80211: Avoid BSS color collision
 detection if its disabled
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 15 Feb 2023 18:37:08 +0100
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

Also, given this, it seems you should pass this setting down to the
hardware, bss change flag, etc.?

> -	if (rx->sdata->vif.bss_conf.csa_active)
> +	if (rx->sdata->vif.bss_conf.csa_active ||
> +	    rx->sdata->vif.bss_conf.he_bss_color.collision_detection_enabled)
>  		return;

and now that I read this again - clearly that's adding a multi-link
problem. I'd rather not add more of those.

johannes
