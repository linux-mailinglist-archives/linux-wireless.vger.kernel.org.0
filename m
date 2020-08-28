Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38F662555AB
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Aug 2020 09:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbgH1HwX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Aug 2020 03:52:23 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:42661 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728357AbgH1HwW (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Aug 2020 03:52:22 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598601141; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=5Mr9A8R1vuy2tj5FzjLEZl1XIcNeQCLvURlK4suozHM=; b=rC5snRhJ8KZ+Lav18sOBF4+i8W91EV6Jp2xMPXi7zDXfGEtFVl4JkHppJlCTgEMCvphgJ7sb
 mMyP+PEYDbqL7jxax1xzQZqRb9Eb9qfeya8Q7pM1O17o/9ZzFesM+F+tZenTyb4+JHhCaKwJ
 C72/24apUr2OiAp5aCMv/CIivnI=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5f48b7b515988fabe044961c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 28 Aug 2020 07:52:21
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3CC79C433CA; Fri, 28 Aug 2020 07:52:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 17D72C433C6;
        Fri, 28 Aug 2020 07:52:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 17D72C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Thomas Pedersen <thomas@adapt-ip.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 21/22] mac80211_hwsim: indicate support for S1G
References: <20200827223304.16155-1-thomas@adapt-ip.com>
        <20200827223304.16155-22-thomas@adapt-ip.com>
Date:   Fri, 28 Aug 2020 10:52:15 +0300
In-Reply-To: <20200827223304.16155-22-thomas@adapt-ip.com> (Thomas Pedersen's
        message of "Thu, 27 Aug 2020 15:33:03 -0700")
Message-ID: <87d03b6wcw.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Thomas Pedersen <thomas@adapt-ip.com> writes:

> Advertise S1G Capabilities and channels to mac80211.
>
> Requires a few fixups to account for missing
> sband->bitrates, and a custom regulatory db to actually
> enable the S1G channels.
>
> Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>
> ---
>  drivers/net/wireless/mac80211_hwsim.c | 80 ++++++++++++++++++++++++---
>  include/linux/ieee80211.h             | 12 +++-

IMHO a mac80211_hwsim patch should not touch ieee80211.h.

> --- a/include/linux/ieee80211.h
> +++ b/include/linux/ieee80211.h
> @@ -2385,6 +2385,9 @@ ieee80211_he_spr_size(const u8 *he_spr_ie)
>  	return spr_len;
>  }
>  
> +#define SM(f, v)	(((v) << f##_SHIFT) & f)
> +#define MS(f, v)	(((v) & f) >> f##_SHIFT)
> +
>  /* S1G Capabilities Information field */
>  #define S1G_CAPAB_B0_S1G_LONG BIT(0)
>  #define S1G_CAPAB_B0_SGI_1MHZ BIT(1)
> @@ -2392,9 +2395,16 @@ ieee80211_he_spr_size(const u8 *he_spr_ie)
>  #define S1G_CAPAB_B0_SGI_4MHZ BIT(3)
>  #define S1G_CAPAB_B0_SGI_8MHZ BIT(4)
>  #define S1G_CAPAB_B0_SGI_16MHZ BIT(5)
> -#define S1G_CAPAB_B0_SUPP_CH_WIDTH_MASK (BIT(6) | BIT(7))
> +#define S1G_CAPAB_B0_SUPP_CH_WIDTH	(BIT(6) | BIT(7))
>  #define S1G_CAPAB_B0_SUPP_CH_WIDTH_SHIFT 6
>  
> +#define S1G_SUPP_CH_WIDTH_2	0
> +#define S1G_SUPP_CH_WIDTH_4	1
> +#define S1G_SUPP_CH_WIDTH_8	2
> +#define S1G_SUPP_CH_WIDTH_16	3
> +#define S1G_SUPP_CH_WIDTH_MAX(cap) ((1 << MS(S1G_CAPAB_B0_SUPP_CH_WIDTH, \
> +					     cap[0])) << 1)

We have GENMASK(), FIELD_GET() & co nowadays so no need for custom
macros.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
