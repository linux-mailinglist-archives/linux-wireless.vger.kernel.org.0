Return-Path: <linux-wireless+bounces-36224-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKZGDTa2AWr2igEAu9opvQ
	(envelope-from <linux-wireless+bounces-36224-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 12:57:58 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC4F50C5E7
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 12:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F40583019FE2
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 10:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6FD43C7E1B;
	Mon, 11 May 2026 10:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2yG9bHy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB87E346E5A
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 10:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778496924; cv=none; b=bgUGjSx4DBzAhVuRRNYrgLY3il6KVo5GCxGgh3UIFiSnIj2vunuMefdp4TEsRLbTjNKLSgV8ERAjOJ1TiP+zZ7K/NPw5gihLevA+V4RQkdjh8Ga8qaT9GVtT8XN3KF0+drWrISBnOF8sFYLYI1WCBy8tpyMQIVnYOZR9La1usVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778496924; c=relaxed/simple;
	bh=jY/4U4NvAuCXUM8W1XcxHDLJhhLC1SsxoRTCHwOhFD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lX2WG0ZQzn7wLZLPhg1ICPJQ+5pZN7cOErk5qgGys/+SsNoarhmzcxO+ag2TMSMql+K9BwaPPpNfMkBbpp2qpnHwMOvR+B1TbIDjNFCcYu7uKDzkjxLWK+bGXKkWkPeiEXA7r9Owmye2lb3VsJVqj6Ca27X+6rdPIGPdMd5xhHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2yG9bHy; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-67b6a6bd7b8so8618241a12.0
        for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 03:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778496921; x=1779101721; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pRz3ZIzUquJZrfpxHjLbsp8xXHQjqMlXKjZ8oqjwmrY=;
        b=Y2yG9bHyfe0wHrRRvdbzBofbpieHe+7qB/ezxV+E1xTNW9Jcfmrl+VMJSfsGWJXRwG
         CFcpT4LqPbVcnfmoZqS9JqGtfULJHoukLC2uZyIUSuBadJIoQVnNirMsg96bidViPlDh
         3I9Ve/4H+L0XO+h7+0lkVrlgXXqC/OfLZfgMMvFgxyd4yP3r2HVSgwytqv5+DR5w/Uf4
         lV6K4o9lPgKP4xjV7WDTz+jnxv78TczVTLLUo1/9YVp46JeanB8tTNHEOmK+xU9bDsOe
         7omBLbFedR6f/5kWGC+Gq5Duo2VA77QJg50pYd0UZXjVHFU9m9Cn1QlN9RgQAhH5dLcs
         tRhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778496921; x=1779101721;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pRz3ZIzUquJZrfpxHjLbsp8xXHQjqMlXKjZ8oqjwmrY=;
        b=mdHZz/DUWoI4Mfr0b5lLJRR+KpY2bOWCfNeMRPNGMlPPB1bsYTPg/+AiGw+hE0ohd1
         Ara72N7+j3nQfK/xc9m1wmYAqmxI/d6CoSnQQMB7DaxsJcFnP3RVhNCL4DzeMT0H4/gA
         X36flPe676JEniBV755o9JIMpJx4+62o2ZRIa9uFtkX81x/+NTSnpSsjppLmNreIjfbT
         Ro7eITKyKDw0X31B3BMqM0YEwUcsFjh+sGY78k4tHBdGPngMW68RdPoTDTC2A1Lv6G9m
         K+hnI3qIPI86JjxryzXlqB8UCoOfe2IeBuHpbqSJ0CLIzB6glrOfTu53+BZxmuMcHFEZ
         1qkA==
X-Forwarded-Encrypted: i=1; AFNElJ9kbmtt/fH6q7jGKxO/NSi9RFTe5ElhRuapxFbFlYS88BL+rg4nMzsBnbYrf1L9DTa9PTooOSBATZNMBs5vPA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGlaMui1VpUoS2sYo0aYtJ8QGW1KKOZtf9gRxI/Irwfmza+1QZ
	deeQOUhQPKLbN9C5ivoyGrTZpR4hjB147iPvaxa3Hw9iNqUUpGcYBfES
X-Gm-Gg: Acq92OH8W4dHH28hNuvPUJdDaSDyXewIIZ0YhLoeFoLH2yBofeodIRsMj8PDJlCWQp/
	NR0A0oUa+j4u86YxZoDjpra9bxaFUin02C7ui6LUn8Vx+5C6JATrHH7AY0cXrmARYnnmUxorkdH
	9gWQDuhyHrlFwjzTXDJbG/c/poDrlt+KgWCd9jAPA4dGs3ebbYBBVe/jIFN+lwFaG32RgDIT7Gi
	CRnKUJKWrOeoAg5XEF5uHGCIN58DVpUiiiBgTSGTGNNFLJd9C8M0rjAc8FQDuRt90E/wrRoi46D
	9aLVu9X5FxQkZVRbNtcPGR6wVYQW7mWK9YfA0xzQR5v4BWTcXL/Nu9/6je/8QiFPLD68Cgqokdy
	dSMEUnQgsraU170qfqkdEdK80MY/g4rrRr45cwMHYXyZO3VB9URUg8Spy/HaYxuFpNC0VzvNWVI
	gJvvReOnvnzeTg0K6L1SuAZqDUO4UmuQ==
X-Received: by 2002:a05:6402:4506:b0:676:5872:c686 with SMTP id 4fb4d7f45d1cf-67e0dbfa7cfmr7937110a12.2.1778496921031;
        Mon, 11 May 2026 03:55:21 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.93])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67ef0b3b904sm3472736a12.1.2026.05.11.03.55.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 03:55:20 -0700 (PDT)
Message-ID: <fe81de61-f22b-4331-9ef2-fe602f9880ea@gmail.com>
Date: Mon, 11 May 2026 13:55:19 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] wifi: rtw89: usb: Support switching to USB 3 mode
To: Lucid Duck <lucid_duck@justthetip.ca>, linux-wireless@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>, linux-kernel@vger.kernel.org
References: <20260508054421.128938-1-lucid_duck@justthetip.ca>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <20260508054421.128938-1-lucid_duck@justthetip.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9DC4F50C5E7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36224-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,justthetip.ca:email,checkpatch.pl:url]
X-Rspamd-Action: no action

On 08/05/2026 08:44, Lucid Duck wrote:
> From: Devin Wittmayer <lucid_duck@justthetip.ca>
> 
> This patch adds USB 2 to USB 3 mode switching for the AX-generation
> chips in the rtw89 USB driver (8852AU, 8852BU, 8852CU and helper
> variants). Without it, those adapters enumerate at USB 2.0
> high-speed on first plug and stay there, capping real-world
> throughput around 260 Mbps TCP regardless of radio capability.
> 
> It is Bitterblue Smith's morrownr/rtw89 commit cd287ccf544b
> (2025-07-16) rebased onto wireless-next without code changes:
> author's Signed-off-by preserved, my Signed-off-by added as
> relayer, Tested-by per chip based on the matrix below.
> 
> The bug
> =======
> 
> These chips present as USB 2 devices on first plug. The driver is
> expected to send a switch-mode register write to make them disappear
> and re-enumerate as USB 3 SuperSpeed. Mainline rtw89 does not issue
> these commands anywhere. Every user with one of these adapters on
> a mainline-derived distribution sits at the USB 2.0 ceiling for
> the life of the plug, regardless of negotiated radio rate.
> 
> The fix
> =======
> 
> The patch covers AX-generation chips (8852AU, 8852BU, 8852CU and
> helper variants) via R_AX_PAD_CTRL2. It also adds the
> switch_usb_mode module parameter (default on) for users who
> experience 2.4 GHz interference under USB 3.
> 
> Mainline precedent
> ==================
> 
> The same mechanism is in mainline rtw88 across three commits
> between July 2024 and April 2025, all authored by Bitterblue Smith:
> 
>   commit 315c23a64e99 ("wifi: rtw88: usb: Support USB 3 with RTL8822CU/RTL8822BU")
>   commit 82a35723a67c ("wifi: rtw88: usb: Support USB 3 with RTL8812AU")
>   commit bf1103654df9 ("wifi: rtw88: usb: Enable switching the RTL8814AU to USB 3")
> 
> Reviewer of record: Ping-Ke Shih, current rtw89 maintainer.
> 
> Test results
> ============
> 
> 60 plug-cycles + 30+ gated throughput cells captured 2026-04-11
> to 2026-05-07. Both x86_64 (Tiger Lake xHCI) and aarch64
> (Broadcom RP1 xHCI) reproductions confirm the bug and the fix.
> 
>   Hosts:    Framework 13 (x86_64, Fedora 43 / 6.19.13, Tiger Lake xHCI)
>             NucBox K8 Plus (x86_64, Arch Linux / 6.17.9, AMD F19h USB)
>             Raspberry Pi 5 (aarch64, Pi OS / 6.12.47, BCM2712 + RP1)
>             Banana Pi BPi-R4 Pro (aarch64, OpenWrt / 6.6.93, MT7988A;
>                                   also used as a controlled lab AP)
>   Adapters: D-Link DWA-X1850 A1 / B1 (RTL8852AU)
>             BrosTrend AX1L compact / AX4L high-gain (RTL8852BU)
>             BrosTrend AX8L AXE5400 / EDUP AXE5400 (RTL8852CU)
>   APs:      consumer multi-band router (WPA3-SAE / WPA2-PSK)
>             BPi-R4 Pro single-band lab AP (WPA3-SAE)
>   Server:   Linux iperf3 host on 2.5 GbE wired Ethernet
> 
> Full per-cell evidence (raw iperf3 stdout, dmesg captures, sysfs
> snapshots, iw link snapshots, byte-counter deltas, per-host detail)
> at https://github.com/Lucid-Duck/rtw89-usb3-gap.
> 
> Plug-cycle. N=10 cycles per (chip, host) cell. Pass = post-plug
> /sys/bus/usb/devices/<id>/speed reads 5000 (USB 3 SuperSpeed),
> zero WARN/BUG/Oops in cycle-bracketed dmesg, non-empty association
> BSSID after settle.
> 
>   Adapter (chip)               FW13 6.19      K8 Plus 6.17
>   ---------------------------  -------------  --------------
>   DWA-X1850 A1 (RTL8852AU)     10/10 PASS     10/10 PASS
>   BrosTrend AX1L (RTL8852BU)   10/10 PASS     10/10 PASS
> 
>   FW13:    Fedora 43, 6.19.13, wireless-next + this patch
>   K8 Plus: Arch Linux, 6.17.9-arch1-1, morrownr/rtw89 (upstream
>            fork; identical AX-gen behavior to this patch)
> 
> Throughput. TCP iperf3, N=10 30-second iterations per sub-cell,
> four sub-cells per cell (P=8 and P=1, each direction), to a Linux
> 2.5 GbE host. Per-cell /32 host route forces traffic onto the WiFi
> adapter; per-iteration byte-counter cross-check on every cited cell
> shows wireless tx/rx delta at 103-108% of iperf3 reported bytes
> (excess is normal TCP/IP framing), so wired-NIC bleed is ruled out.
> Linux tuning applied (rmem 32 MB, RPS=ff on the WiFi RX queue).
> 
> FW13 stock (in-kernel rtw89, USB 2 stuck) vs patched (USB 3
> SuperSpeed), same adapter / AP / kernel / capture script, P=8 mean
> Mbps, AP is the consumer multi-band router:
> 
>   Adapter (chip)              Band, width      UL stock  UL patched  DL stock  DL patched
>   --------------------------  ---------------  --------  ----------  --------  ----------
>   EDUP AXE5400 (RTL8852CU)    6 GHz, 160 MHz       269        1364       327         579
>   AX8L AXE5400 (RTL8852CU)    6 GHz, 160 MHz       269        1440       324         510
>   AX4L AX1800 (RTL8852BU)     5 GHz,  80 MHz       208         597       293         695
>   AX1L AX1800 (RTL8852BU)     5 GHz,  80 MHz       235         608       273         843
>   DWA-X1850 A1 (RTL8852AU)    5 GHz,  80 MHz       254         748       264         707
>   DWA-X1850 B1 (RTL8852AU)    5 GHz,  80 MHz       248         706       265         679
> 
> USB enumeration verified at SuperSpeed (5000 Mbps) on every
> patched cell, both pre and post.
> 
> K8 Plus second-rig spot check, kernel 6.17.9-arch1-1, consumer
> multi-band router, single-link 5 GHz 80 MHz, TCP P=1, N=10:
> 
>   DWA-X1850 A1 (RTL8852AU)    788 UL / 693 DL Mbps (sigma 16 / 54)
> 
> For comparison, every stock cell above caps at 208-327 Mbps, the
> USB 2.0 ceiling.
> 
> Future work: BE-generation (RTL8922AU) USB switch-mode
> ======================================================
> 
> The same mechanism applies to BE-generation chips (RTL8922AU) via
> R_BE_PAD_CTRL2.
> The implementation is in morrownr/rtw89 commit c8a8ac49996b
> ("wifi: rtw89: usb: USB 3 switching for RTL8922AU", 2025-08-07)
> by Bitterblue Smith, but that commit has no Signed-off-by; the
> public two-week notice in
> https://github.com/morrownr/rtw89/issues/82 (2026-04-21,
> deadline 2026-05-05) did not produce one. checkpatch --strict
> rejects third-party submission on the missing trailer.
> 

This is what's stopping you? Haha.

> I tested c8a8ac49996b on a BrosTrend BE6500 (RTL8922AU): plug-
> cycle 10/10 PASS on both FW13 and K8 Plus; consumer-router MLO
> 3-link 1430 UL / 995 DL Mbps P=8; BPi-R4 Pro single-link 5 GHz
> 160 MHz EHT 1335 UL / 1058 DL Mbps P=8; switch_usb_mode=N forces
> USB 2 at 255 UL / 311 DL Mbps. Detail in the rtw89-usb3-gap repo
> above.
> 
> Adding the BE-gen switch-mode to mainline today cannot yet help
> RTL8922AU users on its own, because mainline rtw89 has no
> in-kernel rtw89_8922au USB driver: RTL8922AU adapters do not
> attach to mainline at all. Switch-mode becomes load-bearing for
> BE-gen the moment the rtw89_8922au USB driver lands upstream;
> until then it would sit as dormant code. The path upstream for
> the switch-mode itself is either Bitterblue's Signed-off-by on
> c8a8ac49996b, or a Realtek developer carrying it as part of the
> broader 8922au USB enablement.
> 
> (The AX-gen gap that this patch fixes does affect every mainline
> user with an RTL8852AU/BU/CU adapter today. BE-gen is a separate,
> strictly forward-looking concern.)
> 
> Submission notes
> ================
> 
> Applies cleanly on wireless-next HEAD 7baf5857e15d.
> checkpatch.pl --strict: zero errors, zero warnings, zero checks.
> 

Realtek wifi patches should be based on rtw-next (or rtw if it's an
urgent bug fix):

https://github.com/pkshih/rtw/

The subject should include the tree: "[PATCH rtw-next 0/1]"

> Bitterblue Smith (1):
>   wifi: rtw89: usb: Support switching to USB 3 mode
> 
>  drivers/net/wireless/realtek/rtw89/reg.h |  4 +++
>  drivers/net/wireless/realtek/rtw89/usb.c | 41 ++++++++++++++++++++++++
>  2 files changed, 45 insertions(+)
> 
> --
> 2.53.0
> 


