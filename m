Return-Path: <linux-wireless+bounces-31822-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHktN3Wyj2k4SwEAu9opvQ
	(envelope-from <linux-wireless+bounces-31822-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 00:23:33 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AAF139F96
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 00:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 626783007BB9
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 23:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4649299A87;
	Fri, 13 Feb 2026 23:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLzXyGLm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6C61519AC
	for <linux-wireless@vger.kernel.org>; Fri, 13 Feb 2026 23:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771025009; cv=none; b=GMtc2W9jPK3X98SoyAUyPBDXhH4cEINgeHqF3VE+nS1xkJKQNDsWV07nhVolJmluK/3G6QHhz9HbcsN5h9whNJz6BIUviCb08E9ZgD8wO8b4RHpoGYn5IF1BiX0ZfGqDmKQSR/UHaj7YtP1zubHf4jakbx5eN0BFqtNoG5tO4C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771025009; c=relaxed/simple;
	bh=N2DqkNZhZ2dt82VabCybovJZ00CtASVLYO9W6M27yYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=go/vaBWnWBjNnPL8O29dOAf9nEjVI/q8zZMa8bee1BpPYfUoDJhK5qGI5plIt4NgHj5XLmQN+PgtRvHmTnjwz9Rspi2SIwmWfn0kV/w0/hH3Sq9rL3q0LC3FLd5Hbhm2T1lL7hR/EUOw50iUC+59I5rcpF0pfg7dfN6GLjxNikk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XLzXyGLm; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-483770e0b25so8234005e9.0
        for <linux-wireless@vger.kernel.org>; Fri, 13 Feb 2026 15:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771025006; x=1771629806; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gUQCNy51k5rSRdhWlMpQt48P36W8NImbDRr4G+awct8=;
        b=XLzXyGLmfMZ+pbTa67QdHaxTVhkLb11+wAMdHz14Y6kZYjdLL1uz3jUggP6n2Q7O8J
         1l4o49GK7+iHOVZPsDPpqM2YGyBJONC6uVxFV8Qy3PCOteuYRas5VpJTO/jNKL4QuuKW
         dcoLf49cg35CSXs1jhKiUHLXlGnPeQw12ReRCvhCIZ/iaEPoKohmpi0/fgaGrHL1Sxx1
         o1bGx5mkLYfEJ9GaujbUrG18cXKvffzHLnBa+CVeuL2eZzINqcVdzppCN4KPrgM7BqhJ
         m+LwlVGboPyRpxb/b8+JD9avAMKhCt9rz8ogbtzm5kwX0jCl3qsn0RgS0/YNl0QjowMa
         yRkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771025006; x=1771629806;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gUQCNy51k5rSRdhWlMpQt48P36W8NImbDRr4G+awct8=;
        b=QDt7Qb66YlUF3mr+4dPYFgjEj/Xz4OTFK88tRa1zfYJvYU1kfMNgthKO9JsgUmIO3f
         sn7KFqSJLEyegGhJ+FdyOCAqGCcGAwaPtJF3s6fN5krarH3bL5kaeTiB5szOZxmH2j9K
         gKQ/iOCzS8lrF4G7ixrmLk+jYEtp9ArKQKTic5JZGJIwLW+4Gdsqv/yVBDTqI7UyuBvD
         3y2yRXvJgAle6K+Ezg5lv6Jd8aquCGsT4LBRPkuWorxx9rzH2oMl8raT5NHD9r2NAXH0
         nE10FTAKLxtq/F6n28hVqGvWNoz1yjPEARqFPhagWh9WCFwimSFf608Dd79sK43+2f0C
         ptzg==
X-Forwarded-Encrypted: i=1; AJvYcCVUZwg2Ur4ZMCV9QrFRTXKP2U9EVwsGaJrnF/n/NAX2d7yof6Pn1Eo7O4ZhH/dT2aDf2o1Kp4nz9MO3jHMmmw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2WGNgbojYWA8wZNdSP93sPpeCgXWrucVafc/ZIIGq3vWKGCC8
	8wbBOVHdn1h38f4gU6gVgzRxkCl51KENJEQEo/x0rOQhNZOLarKl5vlU
X-Gm-Gg: AZuq6aJsW+XiKwdYMEmL5Lf7pjEYHo2WlGcy6iyS6iCq3WCNLcZl+Rf3lr18UhQ/JeX
	q2K5chUQx5j5y1uef7kqJkF2kND2PXnhVrdIpXNB+gUz2jtdOcVKScOxOUSBnz1UjO5LDorgTiv
	hJN9um1Ry44t3yzxhbUzOG+gHmcihNIJP5Vm5w4C3XWc30EA6KCczY7Cz/5b586DOX8vpgXrPTt
	Udk7Sy6JZVvFawM/6/LIe6ctnbmjpS08DwGeUte1iakM/CphXBY9J63vaUmY1fBvQeUXi87MyWx
	q80yOotxF/LOwTVCcN5lSlgF29p+YOlg4B2xC97vIgHPOtjeOLgxfFpB1f6kFzFLw+STupVYUd8
	cB8xxJpRce1478XXwIwWAJXRhMuiL5RBd/Hqc5smqfoAEMPCKJXX0kKWNbmy5acAZhipl73pzuZ
	IX2Mdi8ghvqK//cKg31CZ0Yu1SuvTxNtFz0Qom/L0I
X-Received: by 2002:a05:600c:608f:b0:477:9dc1:b706 with SMTP id 5b1f17b1804b1-4837108573amr57903225e9.19.1771025006225;
        Fri, 13 Feb 2026 15:23:26 -0800 (PST)
Received: from [192.168.1.50] ([81.196.40.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d82a4afsm523565305e9.11.2026.02.13.15.23.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Feb 2026 15:23:25 -0800 (PST)
Message-ID: <784b3e55-ba5c-477c-8595-3238edfb7855@gmail.com>
Date: Sat, 14 Feb 2026 01:23:24 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rtw-next] wifi: rtw88: Ignore TX report sequence number
 from the 8051 chips
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <4fc30feb-5616-4e2e-86d8-0d96e4f191c2@gmail.com>
 <04799d469547468abe15eadb2ec74255@realtek.com>
 <a95d43dc-58c7-4c9c-9b42-204f2134f099@gmail.com>
 <442b0555b369487b81ba96dcf410cf7d@realtek.com>
 <9110568d-419b-46a7-b0f0-808f958a6efc@gmail.com>
 <f9652882eeb042f89463e0fa864f1412@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <f9652882eeb042f89463e0fa864f1412@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-31822-lists,linux-wireless=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 52AAF139F96
X-Rspamd-Action: no action

On 11/02/2026 04:03, Ping-Ke Shih wrote:
> 
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> On 10/02/2026 08:44, Ping-Ke Shih wrote:
>>> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>>>> On 09/02/2026 10:19, Ping-Ke Shih wrote:
>>>>> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>>>>>> When connected to a network in the 2.4 GHz band, wpa_supplicant (or
>>>>>> NetworkManager?) triggers a scan every five minutes. During these scans
>>>>>> mac80211 transmits many QoS Null frames in quick succession. Because
>>>>>> these frames are marked with IEEE80211_TX_CTL_REQ_TX_STATUS, rtw88
>>>>>> asks the firmware to report the TX ACK status for each of these frames.
>>>>>> Sometimes the firmware can't process the TX status requests quickly
>>>>>> enough, they add up, it only processes some of them, and then marks
>>>>>> every subsequent TX status report with the wrong number.
>>>>>
>>>>> Does it mean number of reports is correct? But with incorrect sequence number?
>>>>> Then, you just ignore checking 'sn' but assume 'st' is correct.
>>>>>
>>>>
>>>> The number of reports is correct most of the time. Only when the firmware
>>>> is overwhelmed (?) it doesn't provide every report, but later it recovers.
>>>>
>>>
>>> I was not aware that this happened while scanning, so we might apply this loose
>>> checking under scan condition -- test_bit(RTW_FLAG_SCANNING, rtwdev->flags)"?
>>> If TX report is because of re-key, it can still use original rule.
>>>
>>> [...]
>>>
>>
>> We can't do that because the sequence number is permanently messed up.
> 
> Indeed...
> 
>>
>> I thought about ignoring IEEE80211_TX_CTL_REQ_TX_STATUS on null frames
>> sent during scans, but unfortunately the last 2 or 3 QOS Null frames
>> are sent after RTW_FLAG_SCANNING is unset, and they still trigger the
>> problem.
>>
>> While poking around today I noticed that only non-QOS null frames are
>> treated like management frames. QOS null frames are treated like data
>> frames. So I tried this change:
>>
>> diff --git a/drivers/net/wireless/realtek/rtw88/tx.c b/drivers/net/wireless/realtek/rtw88/tx.c
>> index 783975acdcff..ea83daa9d60d 100644
>> --- a/drivers/net/wireless/realtek/rtw88/tx.c
>> +++ b/drivers/net/wireless/realtek/rtw88/tx.c
>> @@ -424,7 +424,7 @@ void rtw_tx_pkt_info_update(struct rtw_dev *rtwdev,
>>                 pkt_info->mac_id = rtwvif->mac_id;
>>         }
>>
>> -       if (ieee80211_is_mgmt(fc) || ieee80211_is_nullfunc(fc))
>> +       if (ieee80211_is_mgmt(fc) || ieee80211_is_any_nullfunc(fc))
>>                 rtw_tx_mgmt_pkt_info_update(rtwdev, pkt_info, sta, skb);
>>         else if (ieee80211_is_data(fc))
>>                 rtw_tx_data_pkt_info_update(rtwdev, pkt_info, sta, skb);
>>
>> With this I can't trigger the problem anymore. The sequence numbers
>> are normal every time. Well, it's too soon to be sure, so I will keep
>> testing for a few days.
> 
> Good finding. Please keep testing it.
> 

Still no problem two days later.

> FYI. Having the lunar New Year next week, I will not reply your mail soon.
> 

Have a good holiday!

>>
>>>>
>>>>>>
>>>>>> The symptom is that after a while the warning "failed to get tx report
>>>>>> from firmware" appears every five minutes.
>>>>>>
>>>>>> This problem apparently happens only with the older RTL8723D, RTL8821A,
>>>>>> RTL8812A, and probably RTL8703B chips. Ignore the TX report sequence
>>>>>> number reported by these chips and match the reports with the requests
>>>>>> in the order they come in.
>>>>>>
>>>>>> Tested with RTL8821AU and RTL8723DU.
>>>>>>
>>>>>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>>>>>> ---
>>>>>>  drivers/net/wireless/realtek/rtw88/tx.c | 2 +-
>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/net/wireless/realtek/rtw88/tx.c b/drivers/net/wireless/realtek/rtw88/tx.c
>>>>>> index c04ff31d0f1e..98215ecc884a 100644
>>>>>> --- a/drivers/net/wireless/realtek/rtw88/tx.c
>>>>>> +++ b/drivers/net/wireless/realtek/rtw88/tx.c
>>>>>> @@ -248,7 +248,7 @@ void rtw_tx_report_handle(struct rtw_dev *rtwdev, struct sk_buff *skb, int src)
>>>>>>         spin_lock_irqsave(&tx_report->q_lock, flags);
>>>>>>         skb_queue_walk_safe(&tx_report->queue, cur, tmp) {
>>>>>>                 n = (u8 *)IEEE80211_SKB_CB(cur)->status.status_driver_data;
>>>>>> -               if (*n == sn) {
>>>>>> +               if (*n == sn || rtw_chip_wcpu_8051(rtwdev)) {
>>>>>
>>>>> Can we only limit to USB devices (or non-PCI devices)?
>>>>>
>>>>
>>>> I don't think so. RTL8821AE also has this problem. I didn't mention it
>>>> in the commit message because support for RTL8821AE in rtw88 is
>>>> unofficial. (I modified rtw88_pci to handle the older generation, see
>>>> the use_new_trx_flow=false code path in rtlwifi.)
>>>
>>> How about official RTL8723DE?
>>>
>>
>> I don't have RTL8723DE. I can try with RTL8723DS, although it's annoying
>> to use. (The host is some kind of single board computer. It has only a
>> serial interface and when I connect that to my laptop it makes the
>> touchpad slow for some reason.)
> 
> I found a RTL8723DE and tested scan during connection over 10 times
> (with local modification to print TX-sn/RX-sn).
> I'd say RTL8723DE doesn't have this problem.
> 

It can take hours, although with RTL8821AE it happens in just a few
minutes.

>>
>>>>
>>>>>>                         __skb_unlink(cur, &tx_report->queue);
>>>>>>                         rtw_tx_report_tx_status(rtwdev, cur, st == 0);
>>>>>>                         break;
>>>>>> --
>>>>>> 2.52.0
>>>>>
>>>
> 


