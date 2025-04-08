Return-Path: <linux-wireless+bounces-21267-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC33A80BCB
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 15:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C00358C42F7
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 13:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6096A26E142;
	Tue,  8 Apr 2025 12:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHLCtdfO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B66C2676FA;
	Tue,  8 Apr 2025 12:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744116823; cv=none; b=DTO/sVPlRoB4cIrRbCOnEMmHM0ybig/bipFNpfwdK54E+5+W4xW9l5WtvNqBvg3TSWbz5vBj9XQAvVX9YIy8RmDfemIsw1cLfDB+I8arhaWD9bFQEI1SwEB3yWteseardN+3FTVP1dtpTlbZzLsPc2RknEXDlMlngYLahDOlP60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744116823; c=relaxed/simple;
	bh=ANRuPSUX1yQYlirs/55RG2vUbIaqAiDgBcLWkS79nlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FwnLbkkc4SCCyrjZl9+LYENx2ASS6/6CDmmZQ/MeI5LLiknU/XBRFHlNH7L/9CfkvY/ldlcGFAKpeo/geQFlYH3YkPRQk3WOXddbK18bEhwZfavR1KrwE/yRlYzj2cQCk4ppO5I/2xLfbHZwTlhTEw67Oma6dxfwL5nxbHCUwKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nHLCtdfO; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ac2963dc379so915846466b.2;
        Tue, 08 Apr 2025 05:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744116818; x=1744721618; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=23H5BtSYVmOZ7yC+0VeF4pw/eWnuPDNyjqSPU4O+LQE=;
        b=nHLCtdfOoYqDgifY58NAR3Gl+KxLdpoziAFZRQS3sEr/RgIRbGDNhV+QuTbpJBNiiB
         XpY/NNopeleCRv5Tn8VtH8Dfe7yuuwMAF7krlwGiD6gvgKV7Vr4m9c+pcUOFh9/79ZtF
         KYujUSY3gwsxDP2shEsvOLvRHS+pOWl1V9loPgq8nXmyqdSn5CtcJDmpRfvxBiWDKMl2
         Whj/j7d/cJNgSH6aJi+71TRZ1nSsSqYwbB5gXkcTCP7tjZ2BnFY+sIGCl5qr9yQL2YBz
         f21npHnByTf/jcmNxHqKFHky//GuAeeR97lT6mIOEHge4wkkvg9EFGXKivpt6ymRW4HP
         dfzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744116818; x=1744721618;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=23H5BtSYVmOZ7yC+0VeF4pw/eWnuPDNyjqSPU4O+LQE=;
        b=JpWorw/3LVooKVRK4pxBTezTa/o3737945zTTM5n2UY9Kj9aH4nSNdA2/hV3CJL/NL
         2mArclEgxn9Cysoetk2tpO4Ir6Zc/w+5JeqlJWsDBjl44uKNO38zW9YKJ3fRUCXe/H9H
         qROnLFnfDaKDRcQg1EQ2WCdKwyP71jLxQthcU0KSFh9eLARhtaLo4cDrSFzH8NJwVNMv
         UxcZSDN2nEGdrKm3UMYiSIaxoA6Z4SW+LBh6BQydLe6ZJrvKTMCown5+ly9CGgYUzVcl
         t6puW67G4FDsxhYQr4GARZJFOun+9PgcEp9cnSbaehcvJoYZZJSTMyiVkgCeSKbOfTQ6
         oavA==
X-Forwarded-Encrypted: i=1; AJvYcCWPNzuaP3ABFfjWejstCPBBG83T8pVyrKKJiKi+KifrxvQtI2jN+bnob6M+w4QuKjLLw8N88ZE/5nitYYg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6CCz9VbgZ3u4nEz06aVgU92GDyMRGcTSy7AqAPNVXPzl8Y9Gz
	K5pjGQCEIQHDWLH13ow650CFY4EbSYlm+WNrI3WVtmT7HqJRNvcZ
X-Gm-Gg: ASbGncv/I6Acz5ShTQdQSVyweRaXGQnYcFFz2vpeii25hrconh9wEeIbbu4ZWlxRyZH
	k4Oib4AainZUu5OYUVU35WKpDHcZYsXtNfmvRj54HbTeM11QWK+t+SJ2x2bvqsQXu1eDzgPSkAf
	9Ho1UULXtKkQTW6JLqy9h+Zg+bVbZd4r00Xj/HRNlSRG7y/0w96KJzcgIs9+UmUxcvqOy0a4gvh
	T1aW6/69CTpBUX4wAbip3WFWzjI4DwwZG5EkEhJhVgQxb4XQbcMwgQ5GW4ulb7TUaAdsAN/7zNX
	DznysGlvi/bwW/keMT3FfEKfIwBzwd/+iB3pef362GC8q1kpk674bQ==
X-Google-Smtp-Source: AGHT+IGvmN1EO4VHRezExYMW/kUpvaSsqhCo9Bd2ESrlndGiMScDggYQTe9O53Y7t99TmRR9Zxt9lQ==
X-Received: by 2002:a17:907:98a:b0:ac1:791c:1532 with SMTP id a640c23a62f3a-ac7d19f4f5cmr1566313466b.51.1744116818364;
        Tue, 08 Apr 2025 05:53:38 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7bfe67e17sm915537466b.34.2025.04.08.05.53.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 05:53:37 -0700 (PDT)
Message-ID: <cc66d83c-fb1e-4982-ae68-d5ebd78bbbce@gmail.com>
Date: Tue, 8 Apr 2025 15:53:36 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] RE: [RFC -v1] wifi: rtw88: sdio: Tx status for
 management frames
To: Zhen XIN <zhen.xin@nokia-sbell.com>, Ping-Ke Shih <pkshih@realtek.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <b7651a17-afeb-4abd-ae23-29a85a2f6412@nokia-sbell.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <b7651a17-afeb-4abd-ae23-29a85a2f6412@nokia-sbell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 08/04/2025 06:29, Zhen XIN wrote:
> 
> On 1/1/1970 8:00 AM, Ping-Ke Shih wrote:
>> Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:
>>>>> @@ -1195,7 +1195,7 @@ static void rtw_sdio_indicate_tx_status(struct rtw_dev *rtwdev,
>>>>>          skb_pull(skb, rtwdev->chip->tx_pkt_desc_sz);
>>>>>
>>>>>          /* enqueue to wait for tx report */
>>>>> -       if (info->flags & IEEE80211_TX_CTL_REQ_TX_STATUS) {
>>>>> +       if (info->flags & IEEE80211_TX_CTL_REQ_TX_STATUS && queue
>>>>> + <= RTW_TX_QUEUE_VO) {
>>>> Is this because you have seen "failed to get tx report"?
>>>> Have you tried to increasing RTW_TX_PROBE_TIMEOUT?
>>>>
>>>> If it still can't get TX report, we might take this workaround with
>>>> comments to mention why we need it. Or a local variable with proper
>>>> naming to point out this, like
>>>>
>>>>          bool queue_has_no_tx_report = queue > RTW_TX_QUEUE_VO;
>>>>
>>>>
>>>> By the way, USB behavior is very like to SDIO, but TX report seems to work well.
>>> On my RTL8822CS I can confirm your thought:
>>> I don't notice any extra "failed to get tx report" messages regardless
>>> of whether I have "&& queue <= RTW_TX_QUEUE_VO" or not.
>>>
>> This workaround might need an chip attribute to enable then.
>> Not sure if people in the GitHub thread have experiments on all supported SDIO WiFi chips.
> 
> On my RTL8723DS, without condition"&& queue <= RTW_TX_QUEUE_VO", there are messages in the console:
> 
> [ 23.298425] rtw_8723ds mmc2:0001:1: failed to get tx report from firmware
> 
> Ever after I doubled the RTW_TX_PROBE_TIMEOUT (500 * 2), there messages were still there, and AP mode didn't work:
> 
> root@OpenWrt:~# iw dev phy0-ap0 station dump Station 04:ea:56:2f:6f:07 (on phy0-ap0) inactive time: 480 ms ... authorized: no authenticated: yes associated: yes
> 
> Seems tx status report didn't reach hostapd.
> 
> 

That's because management frames are going to the high queue instead
of the management queue:

static u8 rtw_sdio_get_tx_qsel(struct rtw_dev *rtwdev, struct sk_buff *skb,
			       u8 queue)
{
	switch (queue) {
	case RTW_TX_QUEUE_BCN:
		return TX_DESC_QSEL_BEACON;
	case RTW_TX_QUEUE_H2C:
		return TX_DESC_QSEL_H2C;
	case RTW_TX_QUEUE_MGMT:
		if (rtw_chip_wcpu_11n(rtwdev))
			return TX_DESC_QSEL_HIGH;
		else
			return TX_DESC_QSEL_MGMT;

And the chip is not configured to provide TX reports for the high
queue.

All the chips should be using the management queue for management
frames. What happens if you change it like this?

	case RTW_TX_QUEUE_MGMT:
		return TX_DESC_QSEL_MGMT;

If that doesn't work, try to change the rqpn table as well. Right now
it's like this:

static const struct rtw_rqpn rqpn_table_8723d[] = {
	{RTW_DMA_MAPPING_NORMAL, RTW_DMA_MAPPING_NORMAL,
	 RTW_DMA_MAPPING_LOW, RTW_DMA_MAPPING_LOW,
	 RTW_DMA_MAPPING_EXTRA, RTW_DMA_MAPPING_HIGH},

I think RTW_DMA_MAPPING_EXTRA for dma_map_mg is wrong for SDIO. This
is what the out of tree rtl8723ds driver does:

static const struct rtw_rqpn rqpn_table_8723d[] = {
	{RTW_DMA_MAPPING_HIGH, RTW_DMA_MAPPING_NORMAL,
	 RTW_DMA_MAPPING_LOW, RTW_DMA_MAPPING_LOW,
	 RTW_DMA_MAPPING_HIGH, RTW_DMA_MAPPING_HIGH},

