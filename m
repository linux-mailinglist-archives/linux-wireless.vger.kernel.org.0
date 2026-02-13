Return-Path: <linux-wireless+bounces-31824-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QWeqJc6zj2l8SwEAu9opvQ
	(envelope-from <linux-wireless+bounces-31824-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 00:29:18 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E47D6139FBC
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 00:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 96C89301C919
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 23:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BED4299A87;
	Fri, 13 Feb 2026 23:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gg0TXiB8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8AD1519AC
	for <linux-wireless@vger.kernel.org>; Fri, 13 Feb 2026 23:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771025355; cv=none; b=BLS9PTuI0CuRw2QII1zgvW7lUSM5DEB3WPwxvOnKbKiybmEERgdtlnxpzAP+TFKZfw0OxDGmmCJvb3QIzl/WhmHIQahNBCPE3h5hMRaGBNQjaapidCZWkJE/etLSKjw4SsjOTvXX1F6JCR2LjXCf6fnrIxw/qmslICWRIkvcmh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771025355; c=relaxed/simple;
	bh=N2DqkNZhZ2dt82VabCybovJZ00CtASVLYO9W6M27yYs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=T4vO74OuzZaPxA5QtpKvvyPiF+sqieVKpbe4ncZVgbPeXeNBGqmfO2iiE/kY2Ys00qglSIFTDjhfw7r9xwiIYgYhGzU9x8VhnZZ0eM7xj8ry2cHUcpcIxlNwvwTojRlXoisk+VndgV+PIAcoDisZvoFgEYfd3iOpkpXuj8zCC2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gg0TXiB8; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48069a48629so12992645e9.0
        for <linux-wireless@vger.kernel.org>; Fri, 13 Feb 2026 15:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771025352; x=1771630152; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gUQCNy51k5rSRdhWlMpQt48P36W8NImbDRr4G+awct8=;
        b=gg0TXiB8haegBFlXA8CE3Gyw3VPKa+bd+6TAWws7iFyL6xxJ+AZp2O6/5ADdJBTpUb
         MpU623PeWNmXKC2qU+pOrRYM79DUgH5IYuDCgnAE7TJFUN7vEhHIWkZHGDahYjYByi/R
         oLGLa0F+Kxu+TptswyVV1cj41KZo5uqi76JoblALU3zwvm6X62fbNbRg6bUJLP0+0wHk
         zc3mgTxNXtWx2DUrKZsC3pljzq2hl2gsDJzRL+T9cwkChUw2puuAE7Depblk+fHVMNHc
         ry8QWhnGqaL1gM020NPibmuI+aFZkh4FeLcErhwGdQCPOIYWkncV1KF1O9JlbVPmKeUl
         N2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771025352; x=1771630152;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gUQCNy51k5rSRdhWlMpQt48P36W8NImbDRr4G+awct8=;
        b=U1GuoiLWFgkhtc7WTxIIaP3DPZoNGPIRXdXNn1NNa3PPe+ZIHIS8BOy946CE599vPv
         FbcL4ewj544nEtFiRt2O36j0A3y05vevvaIfOwQCIxpxQl0wJwfg0Az43+VBxPpIUnsL
         LVB6plIXdSggFxC8OiNOCEEDPROZYOFPgVBICSbAWputeNfrVneCVHDJfL2dfY5TQHGZ
         F4vItv97lcffUtqhyvAHcSqYcCuPtggeHX/8PFa2P2OQ0OV01aEcSan03Iuv7OCTBO6E
         ws6EkZuFZE97S5EdMn4dWOTgxjJKtEe4wfIRPY+v4FcXWZ65BrpgYdkQp5mHmFwixV1X
         bygQ==
X-Forwarded-Encrypted: i=1; AJvYcCU28+Re0gLG9IxPRj1rLo2Ay13YKPszt/6uv1wvWgmpXAl0m7OlQAiw1obnQEh9uvwTzH2WRmaCJbso1dDsmg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQYGoKUHxV1ZQiB7R2VMn8Q90+Ug4FwqXUHyqZT54GEeJ3KUNE
	PXRKuR+rUDyAJiOFd4y83Cq5an2OKregcAYvz7i5fbHofG17gXNOKKoW
X-Gm-Gg: AZuq6aLo+OXWqMUnS6zUmXoYNcwSbLCFEepVBChoLrtBsPMEAFapLy+rjp4uzthR1O1
	tdh+og+WmqxD1/sfq8vA25mEoeGwxmsH56DBr+fe5e/hXs724I5U59gCcMYPAdIby+nxRU+ahEM
	179OFRLnNWYwj3b8SOqBlCm0wlC+lfeoU/xFETCr1gaCtGW5O5vN7sOt8Tpshl0qK+zeWg1j/65
	pHlVUfz39Qr40csmq6QVSoHSjtIwMc6TQ67694vxYV+fstJg5unGr+0CTaSD0UbPA7XGGGLAdP2
	xHt8Ch6pu/dNSQ7RjGvZprAWdIO4Fanps2tMzMpdlASnh3pZe5G5hbspK2fmRyor+INHFToDO95
	nePPHe2NOF3yvwFFI59VubAs1kqkubvh92R8jYaFw8i5F9B7k0Bq0YdlFpY/izwJ4RXjbl+0PRy
	EALu2SRiCyO6g5lsuLqTh4fvuYUxSeRA==
X-Received: by 2002:a05:600c:3f0c:b0:47d:5e02:14e5 with SMTP id 5b1f17b1804b1-483739ffa1emr58363215e9.5.1771025351564;
        Fri, 13 Feb 2026 15:29:11 -0800 (PST)
Received: from [192.168.1.50] ([81.196.40.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796ad112bsm8817683f8f.36.2026.02.13.15.29.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Feb 2026 15:29:11 -0800 (PST)
Message-ID: <f397c14a-1bd5-4e8c-8e34-921ec3695f09@gmail.com>
Date: Sat, 14 Feb 2026 01:29:02 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
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
In-Reply-To: <f9652882eeb042f89463e0fa864f1412@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-31824-lists,linux-wireless=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E47D6139FBC
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


