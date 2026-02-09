Return-Path: <linux-wireless+bounces-31671-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPS8KGtJimndJAAAu9opvQ
	(envelope-from <linux-wireless+bounces-31671-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Feb 2026 21:54:03 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EE01149E3
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Feb 2026 21:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 247E73007224
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Feb 2026 20:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95203217F31;
	Mon,  9 Feb 2026 20:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQ6MC5l2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36E424C676
	for <linux-wireless@vger.kernel.org>; Mon,  9 Feb 2026 20:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770670438; cv=none; b=SFvHxF90Fk/57U6bWWzRAR4SgeVMj2eQD1I7prTSjraZ/qdN9/HFPCyr48MqrdeVvDfYaKKXa1lrTakCIjUrbnZrYssMychWxFzIY4LGreNBbrXTMQpFbi4m1X3pqxa66SO920Ou2KVGfK3UGfwEwdc+kh9N+/FAgtilYl0jTOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770670438; c=relaxed/simple;
	bh=TQTvZT2RhZ4SBwCNJQBKXSIagRpfTwRNLLpa/I5m3hA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=PE1uiCJ8ySj0g1quHdQTA25TSZ7b5fenR5aoeuLxUZhkwjkERuzjI4NxjACiRL1BKqyjHbGElVWaoa8ssY/Cs1rlurpln9D4DxNrNpf0w5AAGbhmni9PeJjGRFPdIJQTlhpVSfSn0nO/zZKb4LzWyqUUaDpr3UTl8S4dXpGmBSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQ6MC5l2; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-794911acb04so33663237b3.0
        for <linux-wireless@vger.kernel.org>; Mon, 09 Feb 2026 12:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770670436; x=1771275236; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sRorfuLFjQCXyiI+4dVXx+sz2Vyg6ihyDfUf+cek5sg=;
        b=MQ6MC5l2VGM3PMWTz9EA27XVG+ysFhU9OgPI0boTs6t1kUSOyb/1Av7Np1H5+mOY6D
         TyP6tOAP5Zj5pVSKEsM11Gyeq7uKD9liE+4cSxD2RkTcb7X6bY8omEwqtrvsDJIKbdj8
         b5uQj3Hw4lz5xg/lNFoIbGs+preRkXEaat51/gCptS/7DE+BnyrP00T0PyxgSWe9vBrY
         EgPqYbE42V8cAjEfW+hRAzTelfuBbJ9wJ7Xb60YyEXf7HarTI8nnuG1nFeSR03k8fgeK
         8BfN9uNHczHt5X399y3uPsTyZ372c851whdDirykg5la/n5yW0kx3QiagKydhVi72JLl
         pIHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770670436; x=1771275236;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sRorfuLFjQCXyiI+4dVXx+sz2Vyg6ihyDfUf+cek5sg=;
        b=nyz+Fzx+5pVV9rcqtW0mvmFkG8icpApBXKI93lN9b51pRUDW1EKyc+L1fKfoDhHG9W
         ZRbuN+G30ZgaHvNpRsvwx5xVfpt7qOAfol0LQrysRzgfBsrcFCr0dsC+o4nWPj4Qdt4x
         gRPI0QiZftZ1aOymjVHdWUBcF3yEjEVzAcqHAtbrPNn9nRZN+3Rs/EGLKRSXYrXz7gAV
         QPyH1TJ/YkCr7MkPkRfz1Q8QtLN6PvyYI4DfbtGVCou/hyZWE81YA6ppoDfExymb6MuF
         h5s9kh7WB761rVr68FvYKI8KGG5xFgy/kAhGs01SBLVQhXGDIrKIWO8svDRlZYO+AJqX
         jBLA==
X-Forwarded-Encrypted: i=1; AJvYcCU3KzJblJAYcwjDnz3ZdbpgSrULjyyRe9m+GMuq8x6hVlMkvjO8DPO0fuSp2CpFIRRcTyfv0X5BqWvEIu8nrw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy96rJoKFImVxK8DYUUGWCL6AEWiskZuRCpU8huy5EBAax/XU+x
	culxhPkDZmb8DmKHAZ9m57LSGAQEr0Upj2CFbVdIAQqGPd/K/4xbtaa1
X-Gm-Gg: AZuq6aKMj7m85JACUQ8LUhQDQn7VI4+fIxUilqnfqg0V6BWhPHdaD0YlLlpUN3XtX6h
	53MSBKjgpJ4URrzSBJkfHVnHuHGCYXJOD/sA+G4Ziw7XfSo5tYQRxXNuruj0u1secK2NA2oGGSo
	bLp9TvzRVZk28X31oVBSvkNgqo8gW6zZZQCeX5flWSn6y2Yuv3pVcgCUE2xjp+eRRaXFiL+kAh1
	0UmbvCH8zpjWPlbN4m+bjzO1g7TKdjMRVMCpUXRiMvI2D4uhEQ7FG1mOWC1KFvenOrrJRKD3qg3
	z+/jnStk3ZVKtEHLrXaegNwReVdGREfcrvwEvrEtZueCjPGVxe9aifvNl177g8gfw+cBikukXzv
	wgleWfEoMvDcxhBmCtEcXZ1CEKISoMW2UHh1r2JaPHiVjaYhdlCWkAtzYJ+noXXwpsWWOcJGHHi
	MXIqUZqaFh5eJMmGRyhA==
X-Received: by 2002:a05:690c:81:b0:796:4b30:2351 with SMTP id 00721157ae682-7964b3028f2mr36762817b3.27.1770670435710;
        Mon, 09 Feb 2026 12:53:55 -0800 (PST)
Received: from [192.168.1.50] ([81.196.40.21])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7952a07a267sm102206187b3.24.2026.02.09.12.53.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 12:53:55 -0800 (PST)
Message-ID: <a95d43dc-58c7-4c9c-9b42-204f2134f099@gmail.com>
Date: Mon, 9 Feb 2026 22:53:52 +0200
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
Content-Language: en-US
In-Reply-To: <04799d469547468abe15eadb2ec74255@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-31671-lists,linux-wireless=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C2EE01149E3
X-Rspamd-Action: no action

On 09/02/2026 10:19, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> When connected to a network in the 2.4 GHz band, wpa_supplicant (or
>> NetworkManager?) triggers a scan every five minutes. During these scans
>> mac80211 transmits many QoS Null frames in quick succession. Because
>> these frames are marked with IEEE80211_TX_CTL_REQ_TX_STATUS, rtw88
>> asks the firmware to report the TX ACK status for each of these frames.
>> Sometimes the firmware can't process the TX status requests quickly
>> enough, they add up, it only processes some of them, and then marks
>> every subsequent TX status report with the wrong number.
> 
> Does it mean number of reports is correct? But with incorrect sequence number?
> Then, you just ignore checking 'sn' but assume 'st' is correct.
> 

The number of reports is correct most of the time. Only when the firmware
is overwhelmed (?) it doesn't provide every report, but later it recovers.

I added some debugging messages:

[...]
[ 1360.012011] queueing tx report request with sn 144
[ 1360.032820] received tx report with sn 144
[ 1360.157378] queueing tx report request with sn 148
[ 1360.158402] received tx report with sn 148
[ 1360.360006] queueing tx report request with sn 152
[ 1360.380687] received tx report with sn 152
[ 1360.505498] queueing tx report request with sn 156
[ 1360.507455] received tx report with sn 156
[ 1360.708000] queueing tx report request with sn 160
[ 1360.728808] received tx report with sn 160
[ 1360.853490] queueing tx report request with sn 164
[ 1360.857279] received tx report with sn 164
[ 1361.055993] queueing tx report request with sn 168
[ 1361.076800] received tx report with sn 168
[ 1361.201610] queueing tx report request with sn 172
[ 1361.203468] received tx report with sn 172
[ 1361.403988] queueing tx report request with sn 176
[ 1361.445670] received tx report with sn 176
[ 1361.601977] queueing tx report request with sn 180
[ 1361.605731] queueing tx report request with sn 184
[ 1361.611737] queueing tx report request with sn 188
[ 1361.612000] received tx report with sn 180
[ 1361.612090] received tx report with sn 184
[ 1361.615321] received tx report with sn 188

(5 minutes later, another scan:)

[ 1658.918266] queueing tx report request with sn 192
[ 1658.924667] received tx report with sn 192
[ 1659.069240] queueing tx report request with sn 196
[ 1659.075545] received tx report with sn 196
[ 1659.271741] queueing tx report request with sn 200
[ 1659.291789] received tx report with sn 200
[ 1659.417107] queueing tx report request with sn 204
[ 1659.421960] received tx report with sn 204
[ 1659.619861] queueing tx report request with sn 208
[ 1659.639910] received tx report with sn 208
[ 1659.765229] queueing tx report request with sn 212
[ 1659.770078] received tx report with sn 212
[ 1659.967855] queueing tx report request with sn 216
[ 1659.987905] received tx report with sn 216
[ 1660.113223] queueing tx report request with sn 220
[ 1660.118074] received tx report with sn 220
[ 1660.315852] queueing tx report request with sn 224
[ 1660.335900] received tx report with sn 224
[ 1660.461215] queueing tx report request with sn 228
[ 1660.466067] received tx report with sn 228
[ 1660.663845] queueing tx report request with sn 232
[ 1660.683895] received tx report with sn 232
[ 1660.809208] queueing tx report request with sn 236
[ 1660.814056] received tx report with sn 236
[ 1661.011840] queueing tx report request with sn 240
[ 1661.031886] received tx report with sn 240
[ 1661.157204] queueing tx report request with sn 244
[ 1661.158197] received tx report with sn 244
[ 1661.359836] queueing tx report request with sn 248
[ 1661.379878] received tx report with sn 248
[ 1661.528327] queueing tx report request with sn 252
[ 1661.528360] queueing tx report request with sn 0
[ 1661.528573] queueing tx report request with sn 4
[ 1661.530424] received tx report with sn 4
[ 1661.535689] received tx report with sn 252
[ 1662.058688] rtw_8723du 1-1:1.2: still have 1 unprocessed tx report requests

(5 minutes later, another scan:)

[ 1958.926214] queueing tx report request with sn 8
[ 1958.931871] received tx report with sn 0
[ 1959.077185] queueing tx report request with sn 12
[ 1959.081971] received tx report with sn 8
[ 1959.279810] queueing tx report request with sn 16
[ 1959.299858] received tx report with sn 12
[ 1959.425182] queueing tx report request with sn 20
[ 1959.429951] received tx report with sn 16
[ 1959.627801] queueing tx report request with sn 24
[ 1959.647852] received tx report with sn 20
[ 1959.773173] queueing tx report request with sn 28
[ 1959.777942] received tx report with sn 24
[ 1959.975800] queueing tx report request with sn 32
[ 1959.995844] received tx report with sn 216
[ 1960.121163] queueing tx report request with sn 36
[ 1960.125935] received tx report with sn 32
[ 1960.323788] queueing tx report request with sn 40
[ 1960.343840] received tx report with sn 36
[ 1960.469162] queueing tx report request with sn 44
[ 1960.473955] received tx report with sn 40
[ 1960.671784] queueing tx report request with sn 48
[ 1960.691711] received tx report with sn 44
[ 1960.817278] queueing tx report request with sn 52
[ 1960.822047] received tx report with sn 48
[ 1961.019780] queueing tx report request with sn 56
[ 1961.039704] received tx report with sn 52
[ 1961.165150] queueing tx report request with sn 60
[ 1961.169920] received tx report with sn 56
[ 1961.367772] queueing tx report request with sn 64
[ 1961.387701] received tx report with sn 60
[ 1961.535771] queueing tx report request with sn 68
[ 1961.535805] queueing tx report request with sn 72
[ 1961.536015] queueing tx report request with sn 76
[ 1961.537739] received tx report with sn 64
[ 1961.543622] received tx report with sn 76
[ 1961.543655] received tx report with sn 68
[ 1962.058691] rtw_8723du 1-1:1.2: still have 2 unprocessed tx report requests

Here the number of reports matches the number of requests.
I assume st is correct, but I'm not sure how to test that.

(5 minutes later, another scan:)

[ 2258.930888] queueing tx report request with sn 80
[ 2258.931968] received tx report with sn 72
[ 2259.074009] queueing tx report request with sn 84
[ 2259.075296] received tx report with sn 80
[ 2259.276268] queueing tx report request with sn 88
[ 2259.292578] received tx report with sn 84
[ 2259.417771] queueing tx report request with sn 92
[ 2259.421069] received tx report with sn 88
[ 2259.620249] queueing tx report request with sn 96
[ 2259.636439] received tx report with sn 0
[ 2259.761876] queueing tx report request with sn 100
[ 2259.763314] received tx report with sn 96
[ 2259.964239] queueing tx report request with sn 104
[ 2260.006304] received tx report with sn 100
[ 2260.129871] queueing tx report request with sn 108
[ 2260.131799] received tx report with sn 104
[ 2260.332240] queueing tx report request with sn 112
[ 2260.348426] received tx report with sn 108
[ 2260.473732] queueing tx report request with sn 116
[ 2260.475262] received tx report with sn 112
[ 2260.680223] queueing tx report request with sn 120
[ 2260.737903] received tx report with sn 116
[ 2260.870463] queueing tx report request with sn 124
[ 2260.885589] received tx report with sn 120
[ 2261.071970] queueing tx report request with sn 128
[ 2261.213583] queueing tx report request with sn 132
[ 2261.416138] queueing tx report request with sn 136
[ 2261.576217] queueing tx report request with sn 140
[ 2261.576323] queueing tx report request with sn 144
[ 2261.828937] received tx report with sn 124
[ 2262.090722] rtw_8723du 1-1:1.2: still have 6 unprocessed tx report requests
[ 2262.470953] queueing tx report request with sn 148
[ 2262.472454] received tx report with sn 144
[ 2262.986738] rtw_8723du 1-1:1.2: still have 1 unprocessed tx report requests

>>
>> The symptom is that after a while the warning "failed to get tx report
>> from firmware" appears every five minutes.
>>
>> This problem apparently happens only with the older RTL8723D, RTL8821A,
>> RTL8812A, and probably RTL8703B chips. Ignore the TX report sequence
>> number reported by these chips and match the reports with the requests
>> in the order they come in.
>>
>> Tested with RTL8821AU and RTL8723DU.
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
>>  drivers/net/wireless/realtek/rtw88/tx.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/wireless/realtek/rtw88/tx.c b/drivers/net/wireless/realtek/rtw88/tx.c
>> index c04ff31d0f1e..98215ecc884a 100644
>> --- a/drivers/net/wireless/realtek/rtw88/tx.c
>> +++ b/drivers/net/wireless/realtek/rtw88/tx.c
>> @@ -248,7 +248,7 @@ void rtw_tx_report_handle(struct rtw_dev *rtwdev, struct sk_buff *skb, int src)
>>         spin_lock_irqsave(&tx_report->q_lock, flags);
>>         skb_queue_walk_safe(&tx_report->queue, cur, tmp) {
>>                 n = (u8 *)IEEE80211_SKB_CB(cur)->status.status_driver_data;
>> -               if (*n == sn) {
>> +               if (*n == sn || rtw_chip_wcpu_8051(rtwdev)) {
> 
> Can we only limit to USB devices (or non-PCI devices)?
> 

I don't think so. RTL8821AE also has this problem. I didn't mention it
in the commit message because support for RTL8821AE in rtw88 is
unofficial. (I modified rtw88_pci to handle the older generation, see
the use_new_trx_flow=false code path in rtlwifi.)

>>                         __skb_unlink(cur, &tx_report->queue);
>>                         rtw_tx_report_tx_status(rtwdev, cur, st == 0);
>>                         break;
>> --
>> 2.52.0
> 


