Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8428C350E12
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Apr 2021 06:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbhDAE1T (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Apr 2021 00:27:19 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:38384 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbhDAE0Y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Apr 2021 00:26:24 -0400
Received: from [192.168.254.6] (unknown [50.34.172.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 7EA9A13C2B0
        for <linux-wireless@vger.kernel.org>; Wed, 31 Mar 2021 21:26:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 7EA9A13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1617251175;
        bh=ywatSzwVb4ZDryZeQ/2mLyNDdILr9YfwkSG/IXBfFMU=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=sdrP4y36HbWCdXObgpILJ8qtKvJqkRKSiIXvQfr+e/sgMF99uoBiYXQx98ggrtRx2
         9DSyZpIP1MtthXRbnzNv2rKNz9uGPHmIiS/Be+Wv6rY6oic+AF3EnKNasMPSOXCR+z
         iiHN1terZq7tmEUHwM47Z4uqf/AoQa3LlIG1wFSw=
Subject: Re: [PATCH-v2 1/6] mac80211: Fix station rx-packets counters.
To:     linux-wireless@vger.kernel.org
References: <20210324181441.13755-1-greearb@candelatech.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <e6efe308-6359-a715-7766-b1bcc992d828@candelatech.com>
Date:   Wed, 31 Mar 2021 21:26:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210324181441.13755-1-greearb@candelatech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 3/24/21 11:14 AM, greearb@candelatech.com wrote:
> From: Ben Greear <greearb@candelatech.com>
> 
> I noticed 'iw dev wlan6 station dump' showed almost no rx-packets
> one one of my radios.  The rx-amsdu path did not appear to gather
> any stats, and after code inspection, neither did the rx-data
> handler.
> 
> Add common method to deal with these stats.  Verified in AX
> and /a mode, stats look at least generally correct now.
> 
> Signed-off-by: Ben Greear <greearb@candelatech.com>
> ---

> @@ -2706,6 +2727,8 @@ ieee80211_rx_h_amsdu(struct ieee80211_rx_data *rx)
>   	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
>   	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
>   	__le16 fc = hdr->frame_control;
> +	ieee80211_rx_result rv;
> +	int orig_len = skb->len;
>   
>   	if (!(status->rx_flags & IEEE80211_RX_AMSDU))
>   		return RX_CONTINUE;
> @@ -2734,7 +2757,12 @@ ieee80211_rx_h_amsdu(struct ieee80211_rx_data *rx)
>   	if (is_multicast_ether_addr(hdr->addr1))
>   		return RX_DROP_UNUSABLE;
>   
> -	return __ieee80211_rx_h_amsdu(rx, 0);
> +	rv = __ieee80211_rx_h_amsdu(rx, 0);
> +	if ((rv == RX_QUEUED) && (rx->sta)) {
> +		struct ieee80211_sta_rx_stats *stats = &rx->sta->rx_stats;
> +		ieee80211_update_data_rx_stats(rx, stats, status, orig_len);
> +	}
> +	return rv;
>   }

I noticed this is buggy in several ways (potential use-after-free, bogus
status field).

I noticed too that upcoming changes changed some API that made later patches
in this series not apply cleanly..needed a bit of re-work.

Maybe best if I wait and rebase it against 5.13 when it is ready, unless
someone is actually interested enough in this to want to apply it earlier?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
