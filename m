Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E979058274A
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Jul 2022 15:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbiG0NBR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Jul 2022 09:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233653AbiG0NBO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Jul 2022 09:01:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6417E2A41F
        for <linux-wireless@vger.kernel.org>; Wed, 27 Jul 2022 06:01:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF64061653
        for <linux-wireless@vger.kernel.org>; Wed, 27 Jul 2022 13:01:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 247D1C433D6;
        Wed, 27 Jul 2022 13:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658926861;
        bh=AuyLDF/bGBX6SlY1EuvG2PHzh7nWKo+OqM+4RbhUvA4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=rF8z9H+xtLdCgeAhxzvlptZIMPygRnP7DuCG2t2kl37ajGU82+oJUAtqDT3OFUxci
         /mTE4mTuPkSoIcU38OEi/5BUrZk8NkPfPhqbcWDpoJlLnPMHQWhwlBuj0fI17zAw+R
         zcWOCi+mZY1HfMAcdxLYhcpPTA37DACBTbNExPdSnZtKUxKuv9eXVLnfGcf+EnLRpR
         DKnNWuv+gbT1sBQ+2arvSuNSHIiBQctWyF4gYw0HWsoKw8vto1N6f6U4K3rgAVJs9z
         Rfl0LBbFtJoEa4QnVQau4f8SLmp5v911f+rzNExttSDy7w7KjL3Llw5sZRetiul8eo
         REgscfJUIbO1w==
From:   Kalle Valo <kvalo@kernel.org>
To:     <Ajay.Kathat@microchip.com>
Cc:     <linux-wireless@vger.kernel.org>, <Claudiu.Beznea@microchip.com>,
        <Sripad.Balwadgi@microchip.com>, <lkp@intel.com>
Subject: Re: [PATCH 1/8] wifi: wilc1000: fix incorrect type assignment sparse warning
References: <20220720160302.231516-1-ajay.kathat@microchip.com>
Date:   Wed, 27 Jul 2022 16:00:58 +0300
In-Reply-To: <20220720160302.231516-1-ajay.kathat@microchip.com> (Ajay
        Kathat's message of "Wed, 20 Jul 2022 16:03:02 +0000")
Message-ID: <87v8rik8vp.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<Ajay.Kathat@microchip.com> writes:

> From: Ajay Singh <ajay.kathat@microchip.com>
>
> Sparse reported below warning
>>> drivers/net/wireless/microchip/wilc1000/cfg80211.c:361:42: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int key_mgmt_suite @@     got restricted __be32 [usertype] @@
>
> 'key_mgmt_suite' value is expected in big-endian format. After receiving
> mgmt_suite value from wpa_s convert to cpu endianness because the same
> value is return back using cfg80211_external_auth_request(). Use
> be32_to_cpu() conversion API to avoid the sparse warning.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: c5b331d4f550fb78 ("wifi: wilc1000: add WPA3 SAE support")
> Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
> ---
>  drivers/net/wireless/microchip/wilc1000/cfg80211.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
> index 5c2c7f1dbffd..19862d932f1f 100644
> --- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
> +++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
> @@ -359,7 +359,7 @@ static int connect(struct wiphy *wiphy, struct net_device *dev,
>  			memcpy(vif->auth.ssid.ssid, sme->ssid, sme->ssid_len);
>  			vif->auth.ssid.ssid_len = sme->ssid_len;
>  		}
> -		vif->auth.key_mgmt_suite = cpu_to_be32(sme->crypto.akm_suites[0]);
> +		vif->auth.key_mgmt_suite = be32_to_cpu((__force __be32)sme->crypto.akm_suites[0]);

No time to investigate in detail but the cast is just ugly. Isn't there
a better way to fix this?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
