Return-Path: <linux-wireless+bounces-10761-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA62E943497
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 19:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7FDD1C22D08
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 17:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414A31B5AA;
	Wed, 31 Jul 2024 17:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6bfQd/C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EA912B8B
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jul 2024 17:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722445220; cv=none; b=eRPNHv09UXY9cywRVXhl796onQ/9d8VRHlaCZ0KOGQz3UgR2NBJJxLXsph04FhCi4GegEOpB22mb50lrlyjgyJV9ssSksntGs2eugGvn4hI7dmUSQRJcKANB38m+f6nMyJaPf33LMKiEc1myBHG5xQknsvF9rOfA3ErDJnUhlAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722445220; c=relaxed/simple;
	bh=d1Ma2OoJQ9QmO1MIlGGRJwqiX5v6uFJBcv/hbd1oIaM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fEWsse1P0/XHT/73qDexhMOzSWHLMhbee4D4M34DawloXcSnVOcVfM57qVVsVtmLQLxQ4qOvYWm+MTsdRUi4B9dw8I/pwVivD9H4rAyfK/1uv0ZrkmoXjSLq2M5PAWh5WoDmj4iqVB4E66hE2/RMwxx4N8pdgjTf+MWc+Q1oLlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X6bfQd/C; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5a1c496335aso5123399a12.1
        for <linux-wireless@vger.kernel.org>; Wed, 31 Jul 2024 10:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722445216; x=1723050016; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ckXCh0G+QrOaLvxiihcVU63YPiBuxvMcVkLjNAd34Eg=;
        b=X6bfQd/C06w1ivPU7FeFnEJTDpzGsC8Ujxs0lQNF2VCtUCqw2rH/pqNZOfPkEhqEDm
         zUUQ/fsPG+pkIdCCp49UPS97JZ8lqOUR8V/o1y11Lw7gYcC92cdkIdBbitjhbILqRyf4
         zvjzOA5bs2tjBs2dDRxBTLVFw6zjYWYsnYzVOQtvOKW4lnGOc11auk9uXZUotaYX/B0H
         5+UGqLlOU3IoK470bXzQyL3b95cU/K9lEO1k4np2EYhlUYgmEzEN/X+k3xbvR8kg7P2f
         sQatn8zy8n4hLwkuGm+HKwh+42H0j3YS7kC/ZPpKJGaPdsG0my3C+IkWv0tCd6yzK8Sc
         wr/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722445216; x=1723050016;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ckXCh0G+QrOaLvxiihcVU63YPiBuxvMcVkLjNAd34Eg=;
        b=shraqcJob09yztFxTPTyoUsj9odBRlvvSskPYHP0pUveZv1zuv05QOSm3BwFqFYE5o
         gy5NJsYL+lFhryYI+IfgFq2ZI/ai5loBAYv0tbbj2JJj+KQfa9S8bK+Z1+Z4uYvQhnMS
         BXny1HpFd1XYkjwuZAGxdth3N9H84DNbxVS0cLnrrbb03TzeymWyLWZz/97pN9Smly3b
         owwBlzBWu9jdnvoV2QXYtJVyaYXwdggUGK5YZTjUhg0RC9ECf0hhUzqe+9PeErK+s+lj
         6WdqgkdsMBU7Bif9Z2AhOigkOBOwC/yyUrVFcgA6wBndGw4v3ksnqOKg5qfalzmy0OlT
         o1Nw==
X-Forwarded-Encrypted: i=1; AJvYcCUkh8nGtvzdUJb2ZbEER25goqqiUmx79vQeBGt4p8N+XlaoAm9DzfejXkKnXrKhFXFv/5QLuXbX0bVIqgSsYm9NKjBx1eZHdxMd77Wa5z0=
X-Gm-Message-State: AOJu0YypAJtKkms7ItfZIyLWXUCAWkClMYnjy4R+Mi0dHjya4U2/uOvn
	/OG+S7RrhxaIgu4woXbWFChUZCcALxylly4JkYTHRguOiMWXKSPO
X-Google-Smtp-Source: AGHT+IGmIPhi2t9Bu005vyqjYhORwibW12e4jBjdDLfinNnsR0j3As2gU/Zjh3UB8mn1qts+EtDNsA==
X-Received: by 2002:a05:6402:50c7:b0:5a0:f9f7:6565 with SMTP id 4fb4d7f45d1cf-5b021e1745dmr14569218a12.21.1722445216187;
        Wed, 31 Jul 2024 10:00:16 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac63c50fdesm8861333a12.56.2024.07.31.10.00.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 10:00:15 -0700 (PDT)
Message-ID: <9e1c7288-775f-4f10-a6d4-c93b635a3c1b@gmail.com>
Date: Wed, 31 Jul 2024 20:00:14 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH 4/4] wifi: rtw88: Enable USB RX aggregation for
 8822c/8822b/8821c
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Sascha Hauer <sha@pengutronix.de>
References: <c03390ce-34c2-42dd-9bd6-b231bb1f2fae@gmail.com>
 <323190ee-5b88-4d37-bad0-b721cdfead1a@gmail.com>
 <a4e147a24d5d4165a336432d89773025@realtek.com>
Content-Language: en-US
In-Reply-To: <a4e147a24d5d4165a336432d89773025@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/07/2024 08:47, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>>
>> Enable USB RX aggregation when there is at least 1 Mbps RX or TX
>> traffic, otherwise disable it.
>>
>> USB RX aggregation improves the RX speed on certain ARM systems, like
>> the NanoPi NEO Core2. With RTL8811CU, before: 28 Mbps, after: 231 Mbps.
>>
>> The official drivers for these chips use the same logic for SDIO, but
>> for some reason rtw88_sdio always enables RX aggregation, so this patch
>> only toggles aggregation for USB devices.
>>
>> RTL8703B is likely not found in USB devices, and RTL8723DU doesn't like
>> aggregation.
> 
> Please explicitly set .rx_aggregation = NULL to these two chips, so
> we know these two chips don't have this feature.
> 
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
>>  drivers/net/wireless/realtek/rtw88/main.c     | 18 +++++++++++----
>>  drivers/net/wireless/realtek/rtw88/main.h     |  1 +
>>  drivers/net/wireless/realtek/rtw88/rtw8821c.c | 23 +++++++++++++++++++
>>  drivers/net/wireless/realtek/rtw88/rtw8822b.c | 23 +++++++++++++++++++
>>  drivers/net/wireless/realtek/rtw88/rtw8822c.c | 23 +++++++++++++++++++
>>  5 files changed, 84 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
>> index 9d9d33a4a503..b3a089b4f707 100644
>> --- a/drivers/net/wireless/realtek/rtw88/main.c
>> +++ b/drivers/net/wireless/realtek/rtw88/main.c
>> @@ -210,8 +210,10 @@ static void rtw_watch_dog_work(struct work_struct *work)
>>         struct rtw_dev *rtwdev = container_of(work, struct rtw_dev,
>>                                               watch_dog_work.work);
>>         struct rtw_traffic_stats *stats = &rtwdev->stats;
>> +       const struct rtw_chip_info *chip = rtwdev->chip;
>>         struct rtw_watch_dog_iter_data data = {};
>>         bool busy_traffic = test_bit(RTW_FLAG_BUSY_TRAFFIC, rtwdev->flags);
>> +       u32 tx_unicast_shift, rx_unicast_shift;
>>         bool ps_active;
>>
>>         mutex_lock(&rtwdev->mutex);
>> @@ -236,13 +238,21 @@ static void rtw_watch_dog_work(struct work_struct *work)
>>         else
>>                 ps_active = false;
>>
>> -       ewma_tp_add(&stats->tx_ewma_tp,
>> -                   (u32)(stats->tx_unicast >> RTW_TP_SHIFT));
>> -       ewma_tp_add(&stats->rx_ewma_tp,
>> -                   (u32)(stats->rx_unicast >> RTW_TP_SHIFT));
>> +       tx_unicast_shift = stats->tx_unicast >> RTW_TP_SHIFT;
>> +       rx_unicast_shift = stats->rx_unicast >> RTW_TP_SHIFT;
> 
> {tx,rx}_unicast_mbps because 'shift' is to get Mbps.
> 
>> +
>> +       ewma_tp_add(&stats->tx_ewma_tp, tx_unicast_shift);
>> +       ewma_tp_add(&stats->rx_ewma_tp, rx_unicast_shift);
>>         stats->tx_throughput = ewma_tp_read(&stats->tx_ewma_tp);
>>         stats->rx_throughput = ewma_tp_read(&stats->rx_ewma_tp);
>>
>> +       if (rtw_hci_type(rtwdev) == RTW_HCI_TYPE_USB && chip->ops->rx_aggregation) {
>> +               if (tx_unicast_shift < 1 && rx_unicast_shift < 1)
>> +                       chip->ops->rx_aggregation(rtwdev, false);
>> +               else
>> +                       chip->ops->rx_aggregation(rtwdev, true);
>> +       }
> 
> Move this chunk to a function with arguments {tx,rx}_unicast_mbps.
> The function name might be something like rtw_dynamic_usb_rx_aggregation().
> 
>> +
>>         /* reset tx/rx statictics */
>>         stats->tx_unicast = 0;
>>         stats->rx_unicast = 0;
>> diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
>> index 9d21637cf5d5..65bedd1668cc 100644
>> --- a/drivers/net/wireless/realtek/rtw88/main.h
>> +++ b/drivers/net/wireless/realtek/rtw88/main.h
>> @@ -888,6 +888,7 @@ struct rtw_chip_ops {
>>         void (*fill_txdesc_checksum)(struct rtw_dev *rtwdev,
>>                                      struct rtw_tx_pkt_info *pkt_info,
>>                                      u8 *txdesc);
>> +       void (*rx_aggregation)(struct rtw_dev *rtwdev, bool enable);
>>
>>         /* for coex */
>>         void (*coex_set_init)(struct rtw_dev *rtwdev);
>> diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
>> b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
>> index 55b6fe874710..3efdb41f22c5 100644
>> --- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
>> +++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
>> @@ -1276,6 +1276,28 @@ static void rtw8821c_fill_txdesc_checksum(struct rtw_dev *rtwdev,
>>         fill_txdesc_checksum_common(txdesc, 16);
>>  }
>>
>> +static void rtw8821c_rx_aggregation(struct rtw_dev *rtwdev, bool enable)
>> +{
>> +       u8 size, timeout;
>> +       u16 val16;
>> +
>> +       rtw_write32_set(rtwdev, REG_RXDMA_AGG_PG_TH, BIT_EN_PRE_CALC);
>> +       rtw_write8_set(rtwdev, REG_TXDMA_PQ_MAP, BIT_RXDMA_AGG_EN);
>> +       rtw_write8_clr(rtwdev, REG_RXDMA_AGG_PG_TH + 3, BIT(7));
>> +
>> +       if (enable) {
>> +               size = 0x5;
>> +               timeout = 0x20;
>> +       } else {
>> +               size = 0x0;
>> +               timeout = 0x1;
>> +       }
>> +       val16 = u16_encode_bits(size, BIT_RXDMA_AGG_PG_TH) |
>> +               u16_encode_bits(timeout, BIT_DMA_AGG_TO_V1);
>> +
>> +       rtw_write16(rtwdev, REG_RXDMA_AGG_PG_TH, val16);
>> +}
>> +
> 
> All use the same settings. Move this to rtw_usb_rx_aggregation() called by
> rtw_dynamic_usb_rx_aggregation().
> 

These three chips use the same settings. RTL8821AU/RTL8812AU
will be a bit different:

static void rtw8821au_rx_aggregation(struct rtw_dev *rtwdev, bool enable)
{
	struct rtw_usb *rtwusb = rtw_get_usb_priv(rtwdev);
	u8 rxagg_usb_size, rxagg_usb_timeout;
	u16 val16;

	if (rtwusb->udev->speed == USB_SPEED_SUPER) {
		rxagg_usb_size = 0x7;
		rxagg_usb_timeout = 0x1a;
	} else {
		rxagg_usb_size = 0x5;
		rxagg_usb_timeout = 0x20;
	}

	if (!enable) {
		rxagg_usb_size = 0x0;
		rxagg_usb_timeout = 0x1;
	}

	val16 = (rxagg_usb_timeout << 8) | rxagg_usb_size;
	rtw_write16(rtwdev, REG_RXDMA_AGG_PG_TH, val16);

	rtw_write8_set(rtwdev, REG_TXDMA_PQ_MAP, BIT_RXDMA_AGG_EN);
}

And RTL8814AU will be more different.

I suppose they can be moved to the same place, like the burst
stuff. Maybe struct rtw_hci_ops should have a new member called
rx_aggregation, in case someone decides to make the SDIO driver
use dynamic RX aggregation as well?

