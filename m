Return-Path: <linux-wireless+bounces-35761-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHnUHRcb9WkVIgIAu9opvQ
	(envelope-from <linux-wireless+bounces-35761-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 01 May 2026 23:28:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE544AFCF0
	for <lists+linux-wireless@lfdr.de>; Fri, 01 May 2026 23:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96F7A300A396
	for <lists+linux-wireless@lfdr.de>; Fri,  1 May 2026 21:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F5736D9F9;
	Fri,  1 May 2026 21:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+DhV/62"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0B01A9F8D
	for <linux-wireless@vger.kernel.org>; Fri,  1 May 2026 21:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777670923; cv=none; b=tSmHdgm92eHZZ7NPr0sle5gSBWZbkXr09U4wayeGxiGG6DZ8EtOPqbyED4OQ10tHswjMz7vB2LdVg362VLYpBaU32FKoDcj8aMWHMF0DZMiOIfKMwN8gfW1pUGzkPhj0PaA+Yj8prhQgLUFdguyb/q4LCWUeKLLZFC+9PmFhPCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777670923; c=relaxed/simple;
	bh=Qwwy+DUf6iPTgesOu7Pi9+zFZbkCGqSm+hqB/dFkyOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CZV85fJJAYSzywsiRbRYrlGfokD1y42d+PTXfmolAHWo0rGm4j+q/aYgT44cSDFiWOnbPzmIqxGwHVykaIrEu9zBHmX+hxsbiG/IGkvfglS0gnMblPuhoc7+kkIXdzsGnk9EyFpi4oiSg0dUR6nUCVMlipKk8F1Gg+xF9nzg1TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+DhV/62; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488b0046078so18317985e9.1
        for <linux-wireless@vger.kernel.org>; Fri, 01 May 2026 14:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777670921; x=1778275721; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q93wGvbwq5yzcLn4p5cmncjwFXks3Eo2eFbWnIa1BT4=;
        b=Y+DhV/62fEsNG9HMuiV/3+W6m9eu3hxlZJji5WoAw6w9Ih0m0pkLdtxgjTVEmEp7+N
         FcWS17+1Me2Wn0egz0jYz3VEgUpAdsRgsk/KI9Z9ZYGzfyboMD5nmYxAHMgI/F+e5Y6f
         7icya+ljIwHIG3vrTEeiCr4kifW8BqBrsv4k+GTZdPPlaSMYmrGUpSphbkyPThTn7YKv
         PGxgEAV7Rb0hV7y9CC6z4dllebNQVJI0TbM1t8vuJE23xWEggvtiFErr3nLg4Ju1rleJ
         SLlCYQ+yf9CPb8YsmW83jR+Cp1AX5IBvQw5Eis4LeICV758wIaam/4rNtTepCYGV7fhe
         xMcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777670921; x=1778275721;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q93wGvbwq5yzcLn4p5cmncjwFXks3Eo2eFbWnIa1BT4=;
        b=JjMxeYmM248bwgCA5AS0Vew9xKZ+FjMhRX0RCnUpkchrD05n68iP6tmzB7SDkVOpns
         7p6qPE/LqbOoiOLmwQuhN3+0HnEN5w6xtXOGIYHr4sWHFRJ9TsQBdeKSfrFYlAHEE6In
         MGQ3h2pANpnBNbGfIacaW8SQgy5HJaANYNKfLbhmFxL5EXVyB5xy1yFJBOSnsoC6OALV
         DY6qIzgNwSuy9poUioFNTw4SVfQ3u4TzME7jF8L+91e1IlGkkHRGAcZsxKSo3MkuvhdD
         BDSVkc7LHOqKDq223rO4HfKFD2bBN47Wc1HNJQDn6S5No8ofcmE+6/8uJK7vMu0xBhw1
         xeHw==
X-Forwarded-Encrypted: i=1; AFNElJ9XctKKwhaMRev216AYqmh5A37Nj0FgLDM4WQ0ndOs4GmSceuVyyYF/GTvxEHgisSBtlYvCkRZjr3JJATaX6w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzLmKXWfS0Adgqvp1sSn4O/Q7M791lefPjsem8fnBOHcsTcMcJD
	XpsLZbYAabjCucn7COesyqnYZug0p/jkXfQxnWHqmKX6XNcoiNSWWj/f
X-Gm-Gg: AeBDiesWVaBwllxuKc3uBjI8ZMbJ+JPyDWwkmg4pdGNz+eNCbTEYYvMSBIcukTRLQsZ
	EWACWE1cSKvq8VQq4hfI9mtx6vJDMccrA+V0t0G1/o9xhaYikVuWMBO0ZDUQsEmTTC43/zXmYpE
	mVKkOvmB4lGITYLoy0LKnziuMJoZkCPq343jftU2N3oKJh4dk/lnaGay2aAvU7XKpl0IK053qZD
	+mbjzaqU8TTcwcV2BGs0hJPanS/wfnxORc2HWszfR3gMjfxgPf1+jt8csTM/bVT876te3oR+4Wt
	ht4O6hL7i8IZeGB99VE2ehB2bltzwtu/2KkVdwwCQ35YU9S1Lvwr75wxoxX9xtkJwF170SceCkV
	KN6I72BruC5//AgQdf+1v6vKKg+bD5EVcU+UQtjQ0Wd3Ge+eNbSdCFyUerxBW+1CxXaOn434UXO
	8ot6OzqAeCcmuNQ9FSWeixN6kUMXDBXCUFY1eoNPEn
X-Received: by 2002:a05:600c:c0c2:b0:48a:76a3:2b9b with SMTP id 5b1f17b1804b1-48a9865ea56mr8151665e9.17.1777670920716;
        Fri, 01 May 2026 14:28:40 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a81b99127sm149092285e9.0.2026.05.01.14.28.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2026 14:28:40 -0700 (PDT)
Message-ID: <bc0a9969-b386-42d1-ada2-99ac39e394f3@gmail.com>
Date: Sat, 2 May 2026 00:28:38 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: rtw88: increase TX report timeout to fix race
 condition
To: Luka Gejak <luka.gejak@linux.dev>, Ping-Ke Shih <pkshih@realtek.com>,
 Kalle Valo <kvalo@kernel.org>
Cc: Yan-Hsuan Chuang <yhchuang@realtek.com>,
 Brian Norris <briannorris@chromium.org>,
 Stanislaw Gruszka <sgruszka@redhat.com>, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260501150402.227788-1-luka.gejak@linux.dev>
 <72f6fffd-bd77-437f-a9d9-6a542a8b365b@gmail.com>
 <6CD170FE-CAED-4B91-AEED-A1AFB98FFE8A@linux.dev>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <6CD170FE-CAED-4B91-AEED-A1AFB98FFE8A@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: DCE544AFCF0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-35761-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	SEM_URIBL_UNKNOWN_FAIL(0.00)[linux.dev:query timed out];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com]

On 01/05/2026 23:46, Luka Gejak wrote:
> On May 1, 2026 9:26:30 PM GMT+02:00, Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> On 01/05/2026 18:04, luka.gejak@linux.dev wrote:
>>> From: Luka Gejak <luka.gejak@linux.dev>
>>>
>>> The driver expects the firmware to report TX status within 500ms.
>>> However, a race condition exists when the hardware is under heavy TX
>>> load and is simultaneously interrupted by background scans or
>>> power-saving state transitions. During these events, the firmware may
>>> go off-channel for longer than 500ms, delaying the TX reports.
>>>
> Hi Bitterblue,
> thanks for the review.
>>
>> But power saving state transitions should not happen during heavy TX load.
>>
> You are absolutely right that power save transitions don't happen 
> during heavy TX. The issue is strictly tied to off-channel dwell time.
> I reliably trigger this on my rtl8723du (USB) by forcing background 
> scans (iw dev wlanX scan) while under heavy iperf3 load. The firmware 
> goes off-channel to scan, which delays the TX report well beyond the 
> current 500ms threshold.
> 
>>> When this happens, the purge timer fires prematurely, dropping the
>>> tracking skbs from the queue and spamming the kernel log with:
>>> "failed to get tx report from firmware". Dropping these tracking skbs
>>> prevents the driver from reporting TX status back to mac80211, which
>>> breaks rate control accounting and degrades performance.
>>>
>>
>> But mac80211 doesn't handle rate control for these chips. How much does
>> performance degrade?
>>
> 
> I understand the firmware handles that internally. The performance 
> degradation I am actually seeing is TCP window collapse, as the host 
> stack interprets the dropped tracking skbs as packet loss. In my 
> testing with iperf3, throughput drops from a steady 80-90 Mbps to 
> near-zero for nearly 2 seconds following the scan before recovery 
> begins.
> 
>>> Increase RTW_TX_PROBE_TIMEOUT to 2500ms. This timeout is large enough
>>> to comfortably accommodate the duration of full WiFi background scans
>>> and sleep transitions without incorrectly tripping the purge timer,
>>> while still eventually catching true firmware lockups.
>>>
>>
>> rtw88 supports many chips. Which one are you using?
>>
>> Perhaps provide a full description of the problem you encountered.
>>
> 
> ...
> 
> I also realize now that globally changing RTW_TX_PROBE_TIMEOUT to 
> 2500ms is too heavy-handed. Since this impacts all rtw88 chips, 
> including PCIe variants where 500ms might be exactly what is needed to
> catch a real firmware lockup, the blast radius is too large. How would
> you prefer I handle this for the v2 patch? I can either implement a 
> more conservative global bump, or make the timeout dynamic based on 
> the HCI interface so USB devices get a longer timeout to accommodate 
> the bus latency during scans.
> 
> Best regards,
> Luka Gejak

No idea, I'm just asking some questions...

Actually, I have one more: what version of the driver did you test?

My quick test with RTL8723DU doesn't show any "failed to get tx report
from firmware" when scanning while running iperf3. Does it take a long
time to trigger?

