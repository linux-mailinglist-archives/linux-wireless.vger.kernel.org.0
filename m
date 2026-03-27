Return-Path: <linux-wireless+bounces-34056-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id II7WIGxkxmnnJgUAu9opvQ
	(envelope-from <linux-wireless+bounces-34056-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 12:05:16 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F41E134311E
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 12:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D2D9B3178AD8
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 10:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E7D2DE709;
	Fri, 27 Mar 2026 10:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KS6eEbCc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101DF33A718
	for <linux-wireless@vger.kernel.org>; Fri, 27 Mar 2026 10:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774608770; cv=none; b=oSqvSzpBObMD7AioLCfQyhJ922+pge9Z9KvFE7hQFJ0QVPcWJYr9TdG0sy60Elzo77EtRDCJtf6ShDpkIbSCWvXzZvklSAJ8juXi3qenL8Z+FBcxcGRWTIf/7yh+NxcRKl7hQOnAz1Q3RqI/xjv6ZI4V3MkRYpEU41BxviWyQ+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774608770; c=relaxed/simple;
	bh=Xs0sUa4Fn+F1a2TYuZU7L6OtoWift4ZDNFfAdvnaqFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aXFuPa6Vli4RP9Ng6AdpZw/DsgqrgJs2anpd4h/Oz6zhFbchUg5GktK/3DBBTPMldPMPQa5etjzMqJBd4YVmwxwkzeq4bTkieGNFIgNGnYzjobs8g0ittAOLUmeRp3BFsO/zvfz5ifhToPBDjz4BkzXJPVWwyUMPyRgzxMXQSV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KS6eEbCc; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48704db565eso28083815e9.1
        for <linux-wireless@vger.kernel.org>; Fri, 27 Mar 2026 03:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774608767; x=1775213567; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O1pNU6dCeyGbc7RtcqSxu9UHHKgcZK1h4u5Ct1z0Esc=;
        b=KS6eEbCcBPPYocDia/rW+XAgqRcgHs3wsdZBXRaMTQb5MbjmP7GkTmOKIhvFkI7uHm
         YbHYr8CBzYWMnpDl5Rhf67xRe9VvtlAEY0gALI+nPDfva6n1tRHXwTAjUd5kXwBWX/yX
         kGuIdmSaUfYTcM3kAheAVljz57EWSek/eyXZschOrOk83qS80cCqPLUj1D/9Lw6XijLj
         xp+3b6gL1GQ1cQWfss+Zkd8lTa+5eA3OhcYj+Do3W/3ddan2qnnNnoTIABE5HoEW5KlP
         Tinsi7aFzc75zQZgRDzkwpuCI15MhPBxIwvHGSYBYPX+w50/iHb3s9bLOrAYWrHpwVTh
         rK4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774608767; x=1775213567;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O1pNU6dCeyGbc7RtcqSxu9UHHKgcZK1h4u5Ct1z0Esc=;
        b=TspwrnCM6SLhWD+kzcBGM4EILLi6rQmIIh6jPrcZz/ooVPWwl30HaDw/WoCY4VJF/x
         38ZtqeJykHFLPG6VTest0WS6aHTPz4uCEMO4WruEcjFqjaHM7HUppKeCG92gYJfsrj9l
         UrJonzfSZgKaMIXCwfSqz2xYKpcsuAfYMoeIVkGejyLYtVry9HK8g9MmMuV+z1/0aD6p
         dsQ6NyKMDoZ5tu6wVw/YdxogNP4oDcTHsU8ToKgdZH61zVs0yibMvPYU7H4/axBblrO8
         REHQPW+i065dXiyySGmJxYCNeX1OXWAeUM52y9AfNPb0IuXQDpforuw8dSk/lM0Iwltf
         SW9Q==
X-Gm-Message-State: AOJu0Yw6DFDfsr9fZ5uXgKR7ai+y1ypoKLW3ee6RozUHMbsoxlqppz1L
	BTZW7TgTsB0+zxTXiZzHlqGWezWARnNmxqaZsD3Vzb+UtWOt+iSM/SCa
X-Gm-Gg: ATEYQzyjWoLilBmGvlyfQj0uoKY0XrVUpF5LhL6/g6zEW+xCEHfB8MEIe2ymVFiOraz
	ODKeUCjXKGJsQxjRFwH+kToc1U6Kp83QVL1SJPpLSG5jLcPA6s8blK6ud/KbDBOs3jUQOvN2V2l
	FWf+yiCOEPUjUNyzLnH0l8zVGxoYjxel0MAYwQpgREb+MSTjvCvigjWdlN9oSB4BycoMn5cP6TI
	AMXFo2PnRqNb/iMCtiH5u7l4turHXtIIykMBuL2T3bwWHjS+PlZvCwz+ej0za9j0Z4EhnMM6e+A
	2x8q4lbML6YioexLNdRb/wMDL5S8gynfAB63spUMFgrKVvtx44OyuLWUopQCPSA3EKiw5QiV8Kw
	xa9rNB/aRTgXegGffdcIY0EmsN3crjjYz9RJQj/yn1m2MpBw8lQ+61FzGua9uQmeArflu2KPapm
	kAg9JCtZfsfQwYu13JEFIbJX9pzeB5IQ==
X-Received: by 2002:a05:600c:6387:b0:487:cd8:4c9 with SMTP id 5b1f17b1804b1-48727ed5618mr29854465e9.27.1774608767051;
        Fri, 27 Mar 2026 03:52:47 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b919e722dsm12999210f8f.35.2026.03.27.03.52.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2026 03:52:46 -0700 (PDT)
Message-ID: <da30a61b-dad0-48ff-a283-3dd8e9bdf91d@gmail.com>
Date: Fri, 27 Mar 2026 12:52:45 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] wifi: rtw88: Hard system freeze on RTL8821CE when
 power_save is enabled (LPS/ASPM conflict)
To: LB F <goainwo@gmail.com>, Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CALdGYqSQ1Ko2TTBhUizMu_FvLMUAuQfFrVwS10n_C-LSQJQQkQ@mail.gmail.com>
 <CALdGYqSMUPnPfW-_q1RgYr0_SjoXUejAaJJr-o+jpwCk1S7ndQ@mail.gmail.com>
 <e5f00d0a42994812b42df867718fa087@realtek.com>
 <CALdGYqRbkV7_w7WDiqD-vYMa8MUFV7nSYz-=q2FzotgLHRy=HA@mail.gmail.com>
 <cb32c1eefb614a8bb96ef6fe2c4f4989@realtek.com>
 <CALdGYqQ3tS_aQpmf7xLkaCG9W55ATQXP=tnRNdjBAG8waqg8yA@mail.gmail.com>
 <dbe78a09fafe4a0ab16cd691049896a8@realtek.com>
 <CALdGYqQ3JQgFvvjiqh-ck8UqUQpAoJ0zeUzEL4i4Un8qPmqxJA@mail.gmail.com>
 <CALdGYqQuS5EOWCaeimr6PY758feF-DPo5i3XFwoQ8ewf4xnm7A@mail.gmail.com>
 <b231d63665334ac786e808610fe4a1e9@realtek.com>
 <CALdGYqSd61wxNrPDui+m-S+Na_is-RM18-=L6xm-Jf4QQ+-DOg@mail.gmail.com>
 <a8e187e1b40e4a35bbeb3bc3a3d21821@realtek.com>
 <CALdGYqRPcDRctCpNSJFatXvqMKLFiiRGXZoQa3KJwfwutHJEwA@mail.gmail.com>
 <ba9790526e4e42c386642a05fcbc2f34@realtek.com>
 <CALdGYqQ5U2USCqVEixoDda1Xd2ugBakh1K1QkaKAU7HPSTTNWg@mail.gmail.com>
 <CALdGYqQ_RCOwa2J-GsEyCxCQ4bztyxSzbc+6eYNesBSaY3Nt-w@mail.gmail.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <CALdGYqQ_RCOwa2J-GsEyCxCQ4bztyxSzbc+6eYNesBSaY3Nt-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34056-lists,linux-wireless=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F41E134311E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 27/03/2026 01:52, LB F wrote:
> Hi Ping-Ke,
> 
> This is Oleksandr Havrylov again. Thank you for the ASPM/LPS Deep
> quirk and the rate validation patches — they are both working correctly
> (zero h2c timeouts, zero lps failures, zero mac80211 warnings).
> 
> However, I'm experiencing a different, separate bug that causes kernel
> oops and makes the system completely unresponsive, requiring a hard
> power-off. After disassembling the crash site, I believe I've found
> the root cause.
> 
> == Summary ==
> 
> When firmware sends a C2H_ADAPTIVITY (0x37) command to an RTL8821CE
> adapter, rtw_fw_adaptivity_result() dereferences rtwdev->chip->edcca_th
> without a NULL check. The RTL8821C chip_info (rtw8821c_hw_spec) does
> not define edcca_th, so the pointer is NULL, causing a kernel oops.
> 
> The crash occurs on the phy0 workqueue while holding rtwdev->mutex,
> which never gets released. This causes all subsequent processes that
> touch the network stack to hang in uninterruptible D-state, making
> the system completely unresponsive and requiring a hard power-off.
> 
> == Root cause analysis ==
> 
> rtw_fw_adaptivity_result() in fw.c (line ~282):
> 
>   static void rtw_fw_adaptivity_result(struct rtw_dev *rtwdev, u8 *payload,
>                                        u8 length)
>   {
>       const struct rtw_hw_reg_offset *edcca_th = rtwdev->chip->edcca_th;
>       ...
>       rtw_dbg(rtwdev, RTW_DBG_ADAPTIVITY, "Reg Setting: L2H %x H2L %x\n",
>               rtw_read32_mask(rtwdev, edcca_th[EDCCA_TH_L2H_IDX].hw_reg.addr,
>                                              ^^^^^^^^^ NULL dereference here
>                               edcca_th[EDCCA_TH_L2H_IDX].hw_reg.mask),
>               ...
> 
> The RTL8822C defines .edcca_th = rtw8822c_edcca_th in its chip_info,
> but RTL8821C does not set this field at all — it remains NULL.
> 
> I verified this by disassembling the compiled rtw_core.ko module:
> 
>   Crash RIP: rtw_fw_c2h_cmd_handle+0x127
>   Address:   0x1d527 = movl (%r12), %esi
> 
>   R12 is loaded at +0xe5 (0x1d4e5):
>     movq 0x140(%rax), %r12    ; rax = rtwdev->chip
>                               ; 0x140 = offset of edcca_th in rtw_chip_info
>                               ; R12 = chip->edcca_th = NULL for 8821c
> 
>   The function is entered via:
>     +0xd8 (0x1d4d8): cmpl $0x37, %ecx  ; c2h->id == C2H_ADAPTIVITY (0x37)
> 
>   With R12 = 0, the instruction at +0x127:
>     movl (%r12), %esi   ; reads from address 0x0 → NULL pointer dereference
> 
> I also confirmed that rtw8821c_hw_spec in the mainline kernel
> (torvalds/linux master, rtw8821c.c) does NOT set .edcca_th.
> 
> == Reproduction ==
> 
> The crash is highly reproducible: it occurred in 4 out of 7 recent
> boots. It happens during normal active usage with no specific trigger.
> 
>   boot  date/time of crash         uptime at crash
>   -5    2026-03-25 00:58:06        ~2 min
>   -4    2026-03-25 21:32:00        ~6h
>   -3    2026-03-26 00:28:14        ~2.5h
>   -1    2026-03-27 00:56:58        ~23.5h
> 
> Both ASPM and LPS Deep are disabled via the DMI quirk. The crash
> occurs every time with the same pattern and same RIP offset (+0x127).
> 
> == Crash pattern ==
> 
> Every crash follows the same sequence:
> 
>   1) Burst of 50-60 "unused phy status page" messages in ~1 second:
> 
>      rtw_8821ce 0000:13:00.0: unused phy status page (8)
>      rtw_8821ce 0000:13:00.0: unused phy status page (2)
>      ... (50+ more within same second)
> 

It looks like the firmware is not sending C2H_ADAPTIVITY (unexpected
for RTL8821CE), but rather you are getting garbage RX data. I am
curious what kind of garbage it is. Can you try this?


diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index da67a6845fd5..aae246c2bc8e 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -665,6 +665,7 @@ static void query_phy_status(struct rtw_dev *rtwdev, u8 *phy_status,
 			     struct rtw_rx_pkt_stat *pkt_stat)
 {
 	u8 page;
+	u8 *rxdesc = phy_status - rtwdev->chip->rx_pkt_desc_sz - pkt_stat->shift;
 
 	page = *phy_status & 0xf;
 
@@ -677,6 +678,10 @@ static void query_phy_status(struct rtw_dev *rtwdev, u8 *phy_status,
 		break;
 	default:
 		rtw_warn(rtwdev, "unused phy status page (%d)\n", page);
+		print_hex_dump(KERN_INFO, "", DUMP_PREFIX_OFFSET, 4, 4,
+			       rxdesc, 56, true);
+		print_hex_dump(KERN_INFO, "", DUMP_PREFIX_OFFSET, 16, 1,
+			       rxdesc, 40, true);
 		return;
 	}
 }


