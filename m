Return-Path: <linux-wireless+bounces-7043-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAED68B7583
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 14:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91E7728344B
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 12:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F8713D273;
	Tue, 30 Apr 2024 12:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVqC0uCn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0285813D633
	for <linux-wireless@vger.kernel.org>; Tue, 30 Apr 2024 12:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714479274; cv=none; b=Fqk3ArFUzgq/dwfg7HYMtkwV2d2TuihzMHOUGlxbDXPpTWt7FNVQZx52RWjM+r0ObUlJmvN2eCl8cJphA9W/6GQE92LloAoikCOmZip2RPH977ZIiN8+wbxqF/z0XAVUYNr+PpzF/wYjFo6yXOdC6ctuR7f+iIvtB5ThScFZFxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714479274; c=relaxed/simple;
	bh=GYfQMSoiTaIElWv7VL8BMLdrosaTV8Yt0f5EDDn7pnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tZHoVBKM2d+Q79XV7SR03CRY1CaNIVNIPxAoikFSLoWW4ej8OgF4LxTbyQ+g0OtvqDlPqH+SV2z83hIftdv4nHg0Fb2iPuKV5VdStItO1wA86RT6HFfGAtcGzGnXKEPmByl5EMMPYKCRpQckZGvLG9Ewn6M81mQ7R0OdTMWl8B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hVqC0uCn; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-34da84cb755so131611f8f.2
        for <linux-wireless@vger.kernel.org>; Tue, 30 Apr 2024 05:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714479270; x=1715084070; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AhevxVct59ABKL34JMLXHoNxGSUEnsHrKrEgMFZg7c4=;
        b=hVqC0uCnDShRGo9r/cFtZcno5Vk021BPsJdPcaGhDZ4nIMeEtD/ziUewX1VcJcAcO1
         Ak3Ja0UThXVaXduqOLRF/f+FZ+n6x0D/4xypTngyJBUsPZYdZa4Prz+nxuDjOHFyCQ2s
         on5UYiQmckhf/79vT6rE7xeA4/yOEdjncCxln7xv9N2lhwojtykzHf5R6vZO1VVMV8S2
         eGZI236gnY8pD1QoMsjDrNxI0C9RRWBWqwd/GRTfiyJWFNOc+gJeFV3pyYQxbp2nXnie
         HZ952RXbSgO4ojk4M08un5aKnpxJJHjVq5LnxUQ+5louelFd/FrdkQvehkQujZOMCBu0
         AZfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714479270; x=1715084070;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AhevxVct59ABKL34JMLXHoNxGSUEnsHrKrEgMFZg7c4=;
        b=A3mRoCDwso3xoohMEGoZP+g3GSY1QHF9hAO1GqkS5AjdHqVWGUsxGSV6wWlyxOolZP
         lwzanoZYbyRdNyipdT3zsHvsTJ4gAigAjNJxn6hWWu7fHihdjJvgxAcJpROIxSnqBIJ0
         Z0FCAMIdR7Riqqg1gxD9oHxhWjwtV/R7vSV+NnASHnfhBgzsCfGgq119C5UJ2KfwElCz
         3mTWa/lP2MA9w8/ZjXpI86+OG8nY36+BwjRhToVqloBSOh4PzMDOVKyUNsYEVgk0AbLs
         dz2sDUyqgxeLrtcxkuqdf+ahIpCTa11aQNPPoSiGQCo5HQBvgd3jxO4AA+KyCc7zDALW
         ZNHA==
X-Forwarded-Encrypted: i=1; AJvYcCXg9FQDkAQzUTuwfg3cs9Yympl5UF1CXa0q0I58IWX/mgb775bObg3uuwKSGZDHuImbx5DYt5/b2DtYYJ2H50I5R6IZqoxJ8aCcil/CM7E=
X-Gm-Message-State: AOJu0YxO4ZW0ackBNM3Tk9H4dPqC36lpuLxSvsBxoeGqRmz0kGW34238
	ax79jOcTz8sOEDQfEL6sYthFIjw/ivQZdsjWK1gbgNnIjxnhFYBvny1CIsMF
X-Google-Smtp-Source: AGHT+IGEC2SKxIXy1Y82Vgw6FYryhQr8dRMzmWsx28Vqy4L6Unay/htzl1uVoVEin72DpcFUoEVNhA==
X-Received: by 2002:a5d:5284:0:b0:34d:8e21:556b with SMTP id c4-20020a5d5284000000b0034d8e21556bmr964679wrv.46.1714479269934;
        Tue, 30 Apr 2024 05:14:29 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.154.240])
        by smtp.gmail.com with ESMTPSA id c11-20020adffb0b000000b0034b1a91be72sm20021522wrr.14.2024.04.30.05.14.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 05:14:29 -0700 (PDT)
Message-ID: <cae2d330-a4fb-4570-9dde-09684af23ffd@gmail.com>
Date: Tue, 30 Apr 2024 15:14:28 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: rtw88: usb: Fix disconnection after beacon loss
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Sascha Hauer <sha@pengutronix.de>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <ecbf0601-810d-4609-b8fc-8b0e38d2948d@gmail.com>
 <5b2e95cdac3d400eb2c9ef2eb20dc221@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <5b2e95cdac3d400eb2c9ef2eb20dc221@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/04/2024 03:50, Ping-Ke Shih wrote:
> +Cc: Martin for rtw88 SDIO that seems have the same problem 
> 
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> When there is beacon loss, for example due to unrelated Bluetooth
>> devices transmitting music nearby, the wifi connection dies soon
>> after the first beacon loss message:
>>
>> Apr 28 20:47:14 ideapad2 wpa_supplicant[1161]: wlp3s0f3u4:
>>  CTRL-EVENT-BEACON-LOSS
>> Apr 28 20:47:15 ideapad2 wpa_supplicant[1161]: wlp3s0f3u4:
>>  CTRL-EVENT-DISCONNECTED bssid=... reason=4 locally_generated=1
>>
>> Apr 28 20:47:24 ideapad2 wpa_supplicant[1161]: wlp3s0f3u4:
>>  CTRL-EVENT-BEACON-LOSS
>> Apr 28 20:47:25 ideapad2 wpa_supplicant[1161]: wlp3s0f3u4:
>>  CTRL-EVENT-DISCONNECTED bssid=... reason=4 locally_generated=1
>>
>> Apr 28 20:47:34 ideapad2 wpa_supplicant[1161]: wlp3s0f3u4:
>>  CTRL-EVENT-BEACON-LOSS
>> Apr 28 20:47:35 ideapad2 wpa_supplicant[1161]: wlp3s0f3u4:
>>  CTRL-EVENT-DISCONNECTED bssid=... reason=4 locally_generated=1
>>
>> When the beacon loss happens, mac80211 makes rtw88 transmit a QOS
>> NULL frame and asks to confirm the ACK status. Even though rtw88
>> confirms to mac80211 that the QOS NULL was transmitted successfully,
>> the connection still dies. This is because rtw88 is handing the QOS
>> NULL back to mac80211 with skb->data pointing to the headroom (the
>> TX descriptor) instead of ieee80211_hdr.
>>
>> Fix the disconnection by moving skb->data to the correct position
>> before ieee80211_tx_status_irqsafe().
>>
>> The problem was observed with RTL8811AU (TP-Link Archer T2U Nano)
>> and the potential future rtw88_8821au driver. Also tested with
>> RTL8811CU (Tenda U9).
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
>>  drivers/net/wireless/realtek/rtw88/usb.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
>> index 3ba7b81c6080..1dfe7c6ae4ba 100644
>> --- a/drivers/net/wireless/realtek/rtw88/usb.c
>> +++ b/drivers/net/wireless/realtek/rtw88/usb.c
>> @@ -278,6 +278,8 @@ static void rtw_usb_write_port_tx_complete(struct urb *urb)
>>                 info = IEEE80211_SKB_CB(skb);
>>                 tx_data = rtw_usb_get_tx_data(skb);
>>
>> +               skb_pull(skb, rtwdev->chip->tx_pkt_desc_sz);
>> +
> 
> There are two cases of arguments of skb_push() for USB: 
> 1. skb_push(skb, chip->tx_pkt_desc_sz);
> 2. skb_push(skb, headsize);
>    headsize = pkt_info->offset ? pkt_info->offset : desclen;
>       pkt_info->offset = chip->tx_pkt_desc_sz;
>       desclen = chip->tx_pkt_desc_sz;
> 
> Eventually all are chip->tx_pkt_desc_sz, but spend a little time to ensure this.
> Could you test and have another patch to change above case (2) to (1)?
> 

I see what you mean. I will make it another patch, because
the skb from case 2 is not sent to mac80211.

>>                 /* enqueue to wait for tx report */
>>                 if (info->flags & IEEE80211_TX_CTL_REQ_TX_STATUS) {
>>                         rtw_tx_report_enqueue(rtwdev, skb, tx_data->sn);
>> --
>> 2.44.0
> 


