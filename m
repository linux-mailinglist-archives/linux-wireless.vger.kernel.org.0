Return-Path: <linux-wireless+bounces-31712-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eH/0MR6ki2ktXgAAu9opvQ
	(envelope-from <linux-wireless+bounces-31712-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 22:33:18 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 448F311F6DD
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 22:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 01D55304D171
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 21:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C18227AC4D;
	Tue, 10 Feb 2026 21:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBvAfg7E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C931727A904
	for <linux-wireless@vger.kernel.org>; Tue, 10 Feb 2026 21:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770759194; cv=none; b=hyhG38/kPHS/BZjGOd6FKI1fQJ9LJmQ9fJmomQsD1cxqexSXm4isuoLVuTsdLSqvm6z3oYqps5XRK4/p4hWOWqhoNPmxPe4fRlsC7ZG76jMy9VT8sApjuhzWo+jzLtGIJ8dGC8VOkWJPTlliu1Hedx1KJXxKdQm2EsCk4Ee5jYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770759194; c=relaxed/simple;
	bh=1p5lVHPNzKTYcm6Zu26IqSYShZzKxcgEjZNwgvpzikA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=ms7ufm2+FBHPnAcvrz5CSYQqU4y2L496HU5fMbb7OcRQqbk8U+HTl89ALXGGTWfyrJ4qEimBVIyxqGtSaSvIToCgA0fIcXBxsdqgE3SFCEECiD2ebch1m3wMO6ucqlwH9j1ikGyGsC3yFJIqA8xnMlHJDxDho820GPppOCm1wic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RBvAfg7E; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4801d7c72a5so37323005e9.0
        for <linux-wireless@vger.kernel.org>; Tue, 10 Feb 2026 13:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770759191; x=1771363991; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BaZiSjz0k1dcTE8KbZmnGNOHRyspSwL70lDHji8h8ck=;
        b=RBvAfg7EcHkYl1Q3v4krOPnrrL+4KFmWjKbfu/pZhcmwbmz/CueGNDoDmo4Gy1e1ha
         hvLHywox0BD3OZXQmrwRR5RyvAbnXXYX9s2FK/IXCmLtm5sRjQwEVX1UtVcrLv5g6xCl
         w6kBmlrRIYzChH453dPvvOSsZzEMJOMpCi9ld1FK7OxjKXH4iQHeo3Nu1vomGhx+catr
         Lk2P4N6lrEdQh+LIF/0p/8jXgTfYy7ol3GWITTQSNSyA9w4O0Jt/7BiHv7Y0ddUmXMfO
         z3dvKK8hxoDqvveL2UyB/23AB97ELEqv/X3H5zUGZ+XYCdXZ99cChuHme6td+GCDshC7
         vphA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770759191; x=1771363991;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BaZiSjz0k1dcTE8KbZmnGNOHRyspSwL70lDHji8h8ck=;
        b=SrHHs4xiVSswcRbJ2CVm7r/XT2nvwwbGs2SejA9AfO/d03bMDy5eG5mH4uuzulMvMi
         idse5/dc5rj8DwWDWyBwzEAAPJaQ6fbxftzeegLCK5BY9K8NWT2ofBtzHd7xbA8gCPf1
         Ivr0V6+Rc+V3vxf5rp4txjIRXyfv/SESi/eVMBMA8QLMhu87/edr8aMES0+DAfHvSiJx
         p6+yCdx5Bz1vezczvCscnKVqrGx40EifJo+lU1ut8k2zoQCwWdjfgKjOQM5RHbuQOZmy
         0Ug3qPplo6i+N2gbyTqAuz51UrFuqrne3OBEFCa8FxJEi0ReAYh2/JSCbMES97Y+zYsa
         5GdA==
X-Forwarded-Encrypted: i=1; AJvYcCX+YBHYp3QFbEVsWzLP4X3lmuA5+3S0SYyQSa707x/Y1TWy/b9d3KSUPxeNnOBcr4qNJg25AnA+jqapBklYUw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzBYNkzX2rBziRYRYuvuZrXdk0NTO9E+YjOreuagUzulGYNmBvI
	uBcRBByRJNeIQL45Mx4L0xyZshRHypUCY2WJhGYHMWtKq9XoCwRNdUc+
X-Gm-Gg: AZuq6aJ5tihd67n1LUa4jYlhuFpy30OMM2n1i02pbpycYjFsmKBjBkrP9R3/cEwSYbn
	UOizvEej/zH53KpPv8OdoLtIRq4D+OlcrbMyegcSNO5TTagcXHx541rcfVtH6uoDo3JMFd1w8Bk
	ixnBityKA9w4StWgqwGk/WHe3Zm7uAQeFdxmTvYnZpO2PZJRn8YP0lx29Q1xq6NJLPRukJvu8Yb
	4CHrM/Y1ju7nc5g3aunCqZXDNZNhrNWH+kkKDuwtEY3OR8goBgOskx3SMw7YFHI9asShcomf4pT
	VXJZume+Hrl3hrQkTZCy03gHGyGH6Zctm1xVtlVRzBa8sbTapbKQmDOIvc9Gfp6Kow3+rStU9Ux
	AdA8EmaNB4oCFJ06hontrpg3TiKVOQK3xqHbHPX2iKIU1DVkeK8B5EJd68luenJpb0JFjTVBWOR
	oQX8t/n8LY/hOC7JDppDzHvz6vZ5lYMavE3FbIds1q
X-Received: by 2002:a05:600c:1389:b0:47e:e779:36d with SMTP id 5b1f17b1804b1-4835b92bd7dmr4082925e9.23.1770759190712;
        Tue, 10 Feb 2026 13:33:10 -0800 (PST)
Received: from [192.168.1.50] ([81.196.40.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d7f1e4fsm111155215e9.15.2026.02.10.13.33.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Feb 2026 13:33:09 -0800 (PST)
Message-ID: <9110568d-419b-46a7-b0f0-808f958a6efc@gmail.com>
Date: Tue, 10 Feb 2026 23:33:08 +0200
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
Content-Language: en-US
In-Reply-To: <442b0555b369487b81ba96dcf410cf7d@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-31712-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 448F311F6DD
X-Rspamd-Action: no action

On 10/02/2026 08:44, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> On 09/02/2026 10:19, Ping-Ke Shih wrote:
>>> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>>>> When connected to a network in the 2.4 GHz band, wpa_supplicant (or
>>>> NetworkManager?) triggers a scan every five minutes. During these scans
>>>> mac80211 transmits many QoS Null frames in quick succession. Because
>>>> these frames are marked with IEEE80211_TX_CTL_REQ_TX_STATUS, rtw88
>>>> asks the firmware to report the TX ACK status for each of these frames.
>>>> Sometimes the firmware can't process the TX status requests quickly
>>>> enough, they add up, it only processes some of them, and then marks
>>>> every subsequent TX status report with the wrong number.
>>>
>>> Does it mean number of reports is correct? But with incorrect sequence number?
>>> Then, you just ignore checking 'sn' but assume 'st' is correct.
>>>
>>
>> The number of reports is correct most of the time. Only when the firmware
>> is overwhelmed (?) it doesn't provide every report, but later it recovers.
>>
> 
> I was not aware that this happened while scanning, so we might apply this loose
> checking under scan condition -- test_bit(RTW_FLAG_SCANNING, rtwdev->flags)"?
> If TX report is because of re-key, it can still use original rule. 
> 
> [...]
> 

We can't do that because the sequence number is permanently messed up.

I thought about ignoring IEEE80211_TX_CTL_REQ_TX_STATUS on null frames
sent during scans, but unfortunately the last 2 or 3 QOS Null frames
are sent after RTW_FLAG_SCANNING is unset, and they still trigger the
problem.

While poking around today I noticed that only non-QOS null frames are
treated like management frames. QOS null frames are treated like data
frames. So I tried this change:

diff --git a/drivers/net/wireless/realtek/rtw88/tx.c b/drivers/net/wireless/realtek/rtw88/tx.c
index 783975acdcff..ea83daa9d60d 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.c
+++ b/drivers/net/wireless/realtek/rtw88/tx.c
@@ -424,7 +424,7 @@ void rtw_tx_pkt_info_update(struct rtw_dev *rtwdev,
 		pkt_info->mac_id = rtwvif->mac_id;
 	}
 
-	if (ieee80211_is_mgmt(fc) || ieee80211_is_nullfunc(fc))
+	if (ieee80211_is_mgmt(fc) || ieee80211_is_any_nullfunc(fc))
 		rtw_tx_mgmt_pkt_info_update(rtwdev, pkt_info, sta, skb);
 	else if (ieee80211_is_data(fc))
 		rtw_tx_data_pkt_info_update(rtwdev, pkt_info, sta, skb);

With this I can't trigger the problem anymore. The sequence numbers
are normal every time. Well, it's too soon to be sure, so I will keep
testing for a few days.

>>
>>>>
>>>> The symptom is that after a while the warning "failed to get tx report
>>>> from firmware" appears every five minutes.
>>>>
>>>> This problem apparently happens only with the older RTL8723D, RTL8821A,
>>>> RTL8812A, and probably RTL8703B chips. Ignore the TX report sequence
>>>> number reported by these chips and match the reports with the requests
>>>> in the order they come in.
>>>>
>>>> Tested with RTL8821AU and RTL8723DU.
>>>>
>>>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>>>> ---
>>>>  drivers/net/wireless/realtek/rtw88/tx.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/net/wireless/realtek/rtw88/tx.c b/drivers/net/wireless/realtek/rtw88/tx.c
>>>> index c04ff31d0f1e..98215ecc884a 100644
>>>> --- a/drivers/net/wireless/realtek/rtw88/tx.c
>>>> +++ b/drivers/net/wireless/realtek/rtw88/tx.c
>>>> @@ -248,7 +248,7 @@ void rtw_tx_report_handle(struct rtw_dev *rtwdev, struct sk_buff *skb, int src)
>>>>         spin_lock_irqsave(&tx_report->q_lock, flags);
>>>>         skb_queue_walk_safe(&tx_report->queue, cur, tmp) {
>>>>                 n = (u8 *)IEEE80211_SKB_CB(cur)->status.status_driver_data;
>>>> -               if (*n == sn) {
>>>> +               if (*n == sn || rtw_chip_wcpu_8051(rtwdev)) {
>>>
>>> Can we only limit to USB devices (or non-PCI devices)?
>>>
>>
>> I don't think so. RTL8821AE also has this problem. I didn't mention it
>> in the commit message because support for RTL8821AE in rtw88 is
>> unofficial. (I modified rtw88_pci to handle the older generation, see
>> the use_new_trx_flow=false code path in rtlwifi.)
> 
> How about official RTL8723DE?
> 

I don't have RTL8723DE. I can try with RTL8723DS, although it's annoying
to use. (The host is some kind of single board computer. It has only a
serial interface and when I connect that to my laptop it makes the
touchpad slow for some reason.)

>>
>>>>                         __skb_unlink(cur, &tx_report->queue);
>>>>                         rtw_tx_report_tx_status(rtwdev, cur, st == 0);
>>>>                         break;
>>>> --
>>>> 2.52.0
>>>
> 


