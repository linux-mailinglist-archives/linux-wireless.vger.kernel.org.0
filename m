Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9FF725546F
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Aug 2020 08:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbgH1GVL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Aug 2020 02:21:11 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:55458 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725849AbgH1GVL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Aug 2020 02:21:11 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id CBC3A4EDBAB;
        Fri, 28 Aug 2020 06:21:10 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id yGKxvOlWykmu; Fri, 28 Aug 2020 06:21:08 +0000 (UTC)
Received: from mail.ibsgaard.io (c-73-223-60-234.hsd1.ca.comcast.net [73.223.60.234])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 1ED8A4E74EB;
        Fri, 28 Aug 2020 06:21:07 +0000 (UTC)
MIME-Version: 1.0
Date:   Thu, 27 Aug 2020 23:21:07 -0700
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 02/22] cfg80211: regulatory: pass min. bandwidth to
 regulatory rule extractor
In-Reply-To: <20200827223304.16155-3-thomas@adapt-ip.com>
References: <20200827223304.16155-1-thomas@adapt-ip.com>
 <20200827223304.16155-3-thomas@adapt-ip.com>
User-Agent: Roundcube Webmail/1.4.7
Message-ID: <1b52e7f240136d13f144b9d5b7744880@adapt-ip.com>
X-Sender: thomas@adapt-ip.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-08-27 15:32, Thomas Pedersen wrote:

> diff --git a/net/wireless/reg.c b/net/wireless/reg.c
> index 35b8847a2f6d..6c130cec22c3 100644
> --- a/net/wireless/reg.c
> +++ b/net/wireless/reg.c
> @@ -1629,9 +1629,10 @@ __freq_reg_info(struct wiphy *wiphy, u32
> center_freq, u32 min_bw)
>  }
> 
>  const struct ieee80211_reg_rule *freq_reg_info(struct wiphy *wiphy,
> -					       u32 center_freq)
> +					       u32 center_freq,
> +					       u32 min_bw)
>  {
> -	return __freq_reg_info(wiphy, center_freq, MHZ_TO_KHZ(20));
> +	return __freq_reg_info(wiphy, center_freq, MHZ_TO_KHZ(min_bw));
>  }
>  EXPORT_SYMBOL(freq_reg_info);

Actually, it would be cleaner to keep the freq_reg_info() interface 
intact,
then set min_bw = 1 if center_freq is in the S1G band. The call to
freq_reg_info() for successively smaller bandwidths in the next patch 
could
just call __freq_reg_info() directly. Will fix in v2.

-- 
thomas
