Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47411277EC
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2019 10:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729679AbfEWI1i (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 May 2019 04:27:38 -0400
Received: from nbd.name ([46.4.11.11]:40916 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726237AbfEWI1h (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 May 2019 04:27:37 -0400
Received: from pd95fd032.dip0.t-ipconnect.de ([217.95.208.50] helo=[192.168.45.104])
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1hTj4a-0005oC-BS; Thu, 23 May 2019 10:27:36 +0200
Subject: Re: [PATCH] mac80211: fix rate reporting inside
 cfg80211_calculate_bitrate_he()
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Shashidhar Lakkavalli <slakkavalli@datto.com>
References: <20190523080332.29173-1-john@phrozen.org>
From:   John Crispin <john@phrozen.org>
Message-ID: <04552f81-f8c7-bda6-d6e5-4bbd0163c1f0@phrozen.org>
Date:   Thu, 23 May 2019 10:27:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523080332.29173-1-john@phrozen.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 23/05/2019 10:03, John Crispin wrote:
> The reported rate is not scaled done correctly. After applying this patch, the
> function will behave just like the v/ht equivalents.

s/done/down/ ... sorry aspell obviously did not catch that one :-)

     John



> Signed-off-by: Shashidhar Lakkavalli <slakkavalli@datto.com>
> Signed-off-by: John Crispin <john@phrozen.org>
> ---
>   net/wireless/util.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/wireless/util.c b/net/wireless/util.c
> index 75899b62bdc9..5a03f38788e7 100644
> --- a/net/wireless/util.c
> +++ b/net/wireless/util.c
> @@ -1237,7 +1237,7 @@ static u32 cfg80211_calculate_bitrate_he(struct rate_info *rate)
>   	if (rate->he_dcm)
>   		result /= 2;
>   
> -	return result;
> +	return result / 10000;
>   }
>   
>   u32 cfg80211_calculate_bitrate(struct rate_info *rate)
