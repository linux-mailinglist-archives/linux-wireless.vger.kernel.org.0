Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E95F611ED45
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2019 22:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725818AbfLMVzS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Dec 2019 16:55:18 -0500
Received: from mail2.candelatech.com ([208.74.158.173]:49438 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfLMVzS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Dec 2019 16:55:18 -0500
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 7D83613C283;
        Fri, 13 Dec 2019 13:55:17 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 7D83613C283
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1576274117;
        bh=4szHi+Zqi/fnAkmicSE92CGsgNoa8Cm6HneEOhWlswA=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=lomPBRW/I9iTmHPP3lUQsItjKmAzX3JWGh1iFc1fZd4HpzNczNVuK0KY1CmOOYLqV
         5FdgOkmndpTk0pLGI1DuIvgNiIrVxDjzKpkZmj0qOgz48xnwkwonDafPzEiC6YmUJQ
         w6lssIq0iqrQW5IHSbV9gyhB8eUndtXtCVBJAfrc=
Subject: Re: [PATCH] ath10k: Fix setting txpower to zero.
To:     linux-wireless@vger.kernel.org, kvalo@qca.qualcomm.com,
        ath10k@lists.infradead.org
References: <20191212171409.21041-1-greearb@candelatech.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <a56bee1a-e3b9-2999-f643-d10ebe5d4726@candelatech.com>
Date:   Fri, 13 Dec 2019 13:55:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191212171409.21041-1-greearb@candelatech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 12/12/19 9:14 AM, greearb@candelatech.com wrote:
> From: Ben Greear <greearb@candelatech.com>
> 
> Do not ignore 0 txpower setting unless the vif is of type p2p.

My patch has problems I think:  secondary stations also have un-init
txpower when they are first built and start scanning.

So, I'm going to try setting txpower to -1 in mac80211 and use that
to mean 'unset'.

Thanks,
Ben

> 
> This should fix regression in:
> 
> commit 88407beb1b1462f706a1950a355fd086e1c450b6
> Author: Ryan Hsu <ryanhsu@qca.qualcomm.com>
> Date:   Tue Dec 13 14:55:19 2016 -0800
> 
>      ath10k: fix incorrect txpower set by P2P_DEVICE interface
> 
> Tested (without p2p in use) on 9984 with ath10k-ct firmware, but I don't think
> this is firmware specific.
> 
> Signed-off-by: Ben Greear <greearb@candelatech.com>
> ---
>   drivers/net/wireless/ath/ath10k/mac.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
> index 289d03da14b2..1c5e1b5570f8 100644
> --- a/drivers/net/wireless/ath/ath10k/mac.c
> +++ b/drivers/net/wireless/ath/ath10k/mac.c
> @@ -5902,11 +5902,18 @@ static int ath10k_mac_txpower_recalc(struct ath10k *ar)
>   {
>   	struct ath10k_vif *arvif;
>   	int ret, txpower = -1;
> +	int p2p_st;
> +
> +	p2p_st = ath10k_wmi_get_vdev_subtype(ar, WMI_VDEV_SUBTYPE_P2P_DEVICE);
>   
>   	lockdep_assert_held(&ar->conf_mutex);
>   
>   	list_for_each_entry(arvif, &ar->arvifs, list) {
> -		if (arvif->txpower <= 0)
> +		/* p2p may not initialize txpower, and we should ignore it
> +		 * in that case.
> +		 */
> +		if ((arvif->txpower < 0) ||
> +		    ((arvif->txpower == 0) && (arvif->vdev_subtype == p2p_st)))
>   			continue;
>   
>   		if (txpower == -1)
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

