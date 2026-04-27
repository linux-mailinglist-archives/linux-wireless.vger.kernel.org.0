Return-Path: <linux-wireless+bounces-35326-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wL56JHat7mmdwgAAu9opvQ
	(envelope-from <linux-wireless+bounces-35326-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 02:27:34 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E0246BACD
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 02:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D7A963004C1E
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 00:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172BB1FBEA6;
	Mon, 27 Apr 2026 00:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1mc4TyA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE2F1F91D6
	for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 00:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777249652; cv=pass; b=KgkEe5fmNNMwTBy47Ss+9VfTvWjAc3pOyobyXHOSn5r0QMHKXnkgcw8TYaGEcRPtOv92lSVecw51AMNVr13CCeNcBQcSjehBB7yl4DWTC8ds0a+6rhws1hEcrS7GHa5aLQ+xwiLUL9LMaBsJey+O/TB2s6kRUJpTEGTNVgklGz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777249652; c=relaxed/simple;
	bh=naDIk0jSXKeAcd+/8PHQci5Rs8KRmvPPxBh4fKbPvzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ei7LcxkxQ7cemiKTZqhYJ4f/p23MGXfevuV2QwXS4N3klekyISnuIbGk1SGZKGfejVmFGYoUzDRIkl8BA7k6zzf5W579dQsMr4IxCxkuO8+MLuVDPrIDDjC8MgFsscH41lCBmJyTr7oColHHfmpnTr8rzTFIKLk2O0fYiUrlOJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B1mc4TyA; arc=pass smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7de4ebe10cbso2977378a34.3
        for <linux-wireless@vger.kernel.org>; Sun, 26 Apr 2026 17:27:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777249649; cv=none;
        d=google.com; s=arc-20240605;
        b=i80O7O+oEnDNFd6sbXvz++/L8CeF+hF9NK/0IF/ccwQ5+zEXnd2S8rQo0sHG51dDAs
         h7WUiKUpueafprxKmog2lgTgTMTohq7afl0aVhfdlabxoSwlShavp6YQoq2e7VW1i+xN
         Fp8Pn9Kre5zvR23g+nyeM6fvMPA4BwEyoRTyhjNK635BoQt4KQssxrFLywTygUgIvi1f
         GvDfl30mqqRUAgde50FNvu/I/ZG+iQ/bCcfsnZRI8GZPXT8Rzzhv78TKdhkTTZ4OWRIM
         fqxSbKjgU0vvkH1vMytMP+5R/TIv1ff/da/B6ioRRcvpjxGW/0zy3DNoOSqowWBx+5zQ
         ll3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Adq5JA/7T/lF4XCsRLgbY1Ee/MAnHaj2PDw8dTcEygA=;
        fh=vOZm6f3IbuZJiF/XuP8PGKeQHsrZ7qqJNQF64d356MA=;
        b=ONKciXvpnfSci1jQeBLJ3dHnSeS+T7q5ky85N4dPlXKma70sXxx/CLuu3YN+8xuhtd
         moQQM32V/zaOsBFWcV0+337zMbBKQfAsK3uz22+TG0n9WuO3g+CXR13CXSkqzTwW2B6v
         rdPTYUT1DE6wpgNhnnpy8Xj4Cm8uBPwrafe2fVvJdqwPwKQT9QnHUUZPFBBM5K7PZHAR
         1JomQWcrAPeRcbHM3M90sB2Z/YsgPUdBkjgtqNhLf/1aaelvPnHAd5bdGEmdDieafGcG
         QU830FEEaKu2xdjuQ81C4SOqsCK5cjQrLPzXQ6RKdlgRIDAfyGsQG2g/vasUViX1bKWg
         /Dag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777249649; x=1777854449; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Adq5JA/7T/lF4XCsRLgbY1Ee/MAnHaj2PDw8dTcEygA=;
        b=B1mc4TyA5oYRJUSA+1wLa10ck4DwuyyhcjCzT/cGmbneYX+f4jNsqV/BWOVbj0gYwO
         4erMCDjHSXOy/UeytP4sZz0B0ath7JiGiH0OSMdBAsAk1BzBy6VCZRDjBK1hpU0r7JZP
         iQDEngwOdlGPJ3I2166VQ1b/JQQhmpTE77FlV0jQFvvsvW13EfGKk/ZX+vvQ6QTft3WE
         jsfU73xGC2bZqgiv67Pe0vndXQrVyNTVPeeESXGN2qqPqKbN8oef/RgWew6BBXaqEUYo
         Z2+Cy/EO6pwiCZH0x/2Qwc/dhpd2ZfJJYv5/HzoAJMKUgJ2UNbjAzefEMMWGm5cA36+O
         OXQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777249649; x=1777854449;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Adq5JA/7T/lF4XCsRLgbY1Ee/MAnHaj2PDw8dTcEygA=;
        b=k33q1LXf8P4PZ6m0CmRBR7ViWJJu22EvTygA8Z0HWu4KWeyQQIRfMHwiQeWsSQmJYG
         Tp70d1CdVqz6rhBgIgPQXmP0UW7Tv0IIfb93T1Bv0nswKxMcoCQPT2nQQnPunMUHb9vh
         nEPPBDkEgSaJfdwvOthN1zbLKmgFYbgws8/6IS02mfXETXagPywG9D0XiD1ySVvHoC7A
         DaX7OxaX+dLk6Gg1OQbtjqfO9QZ9wwQrCynliJ9rQXRPFGBhO7j9MfZZGXq/ADG+Ky+i
         z5GqSVs5Mo1vh/w+an8Miek5P5kwWRwzXek8GFcoW6jX3q/7XNYGre497or03Ao/eHqj
         5D9g==
X-Forwarded-Encrypted: i=1; AFNElJ+P7mibfCgWNKZcKMj8T+PGC6zU+RU4RXK/obbO6OwrPUXJlImFd6kD8RwEOkj0LcmgrSi63y2xSLa8E/sO1w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzR3NrObAuDKmuE/5ny3vtmfcMNrKrrPLfhzxeXIAVUKuAou0ni
	wpcLAVbqNmTJ2hSnOhNHeQTVONTebdXceApVJ4f9W30kjFgEg9m6ig4revzSOUeUoFJHrtsuxpl
	IF/P9A+zQPmclRak2BbNyVzaIGLSeRBf/6sJ3cm/sCc2J
X-Gm-Gg: AeBDietOjf+PRdoc87H3b48elBeLi2+HAcswmy48PFlUrFcsJOwk5f6/Du9ITZbIA2m
	ukVkisJsEWzmi0LEn5g+PHFam4A9eQYn9BaTEJOfSKwTCYzvuXmwowm0uOEnf9HUHmiAg7SrNlI
	XuNwMIN5thVxkUeNfr4oMvgP/JDHRR62glpm0t22paiXZLOHs3XY8pweWwuZk+jJjkJk4eq0RKQ
	IitVMvlxQp4ZtDllXVI4HfK4CNPgCYXnxYqAtOb8X+6Vkcs5cnTHf4iKbFggULFcpQoDyn1DZ/t
	se1f4wyvPaU8Kn3YT/MQYN2jBqazUQ==
X-Received: by 2002:a05:6820:1907:b0:68a:f494:e8fc with SMTP id
 006d021491bc7-69462ef72f4mr23886783eaf.33.1777249649554; Sun, 26 Apr 2026
 17:27:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALdGYqSQ1Ko2TTBhUizMu_FvLMUAuQfFrVwS10n_C-LSQJQQkQ@mail.gmail.com>
 <b231d63665334ac786e808610fe4a1e9@realtek.com> <CALdGYqSd61wxNrPDui+m-S+Na_is-RM18-=L6xm-Jf4QQ+-DOg@mail.gmail.com>
 <a8e187e1b40e4a35bbeb3bc3a3d21821@realtek.com> <CALdGYqRPcDRctCpNSJFatXvqMKLFiiRGXZoQa3KJwfwutHJEwA@mail.gmail.com>
 <ba9790526e4e42c386642a05fcbc2f34@realtek.com> <CALdGYqQ5U2USCqVEixoDda1Xd2ugBakh1K1QkaKAU7HPSTTNWg@mail.gmail.com>
 <CALdGYqQ_RCOwa2J-GsEyCxCQ4bztyxSzbc+6eYNesBSaY3Nt-w@mail.gmail.com>
 <da30a61b-dad0-48ff-a283-3dd8e9bdf91d@gmail.com> <CALdGYqS53=MmG4yCLwgV+RJAZ=U8Aqi8QQZFZ5oFMernhSyxTg@mail.gmail.com>
 <5eb90d6d-e590-4c9e-91c8-1ba315f45304@gmail.com> <CALdGYqRkX8=XMOePeauxvSTDZFLEYyJZKCtoxCzqaNwdO6BNnw@mail.gmail.com>
 <a5ea6373-8c07-4fcd-95fc-d87ce6aef6d5@gmail.com> <6898154c58c84536a0dd4351b3b026fb@realtek.com>
 <CALdGYqT2e+jt+mK-o_bL8hfdEwqZ44fUt9_N6-H4jYp8FpqQJw@mail.gmail.com>
 <5fb2f699626b483b8a0a537960b274f0@realtek.com> <5f9003ca-3bfc-45aa-bf0e-35e9c991629d@gmail.com>
 <faa215f1-ac2c-4072-9603-4baca1d5e07b@gmail.com> <CALdGYqQ+Syz+6weTChA=aXe=DBZSi1c0-7OYhJgkj7ahpR4EUA@mail.gmail.com>
In-Reply-To: <CALdGYqQ+Syz+6weTChA=aXe=DBZSi1c0-7OYhJgkj7ahpR4EUA@mail.gmail.com>
From: LB F <goainwo@gmail.com>
Date: Mon, 27 Apr 2026 03:26:52 +0300
X-Gm-Features: AVHnY4K4-3IGzw5LWlFgOMe6_i6vStrWt-IUf8RKiYdjKPbX43HM8jNJysJxB5c
Message-ID: <CALdGYqSS1WXdqHi1rp+PznVOW9wCF3vDC6qkScUXNV5YHQ=Bjg@mail.gmail.com>
Subject: Re: [BUG] wifi: rtw88: Hard system freeze on RTL8821CE when
 power_save is enabled (LPS/ASPM conflict)
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: Ping-Ke Shih <pkshih@realtek.com>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 10E0246BACD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35326-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[goainwo@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]

Hi Bitterblue and Panagiotis,

A quick follow-up to my preliminary report from earlier today.

After ensuring the new module containing the `drv_info_sz` validation
patch was properly loaded via DKMS, I ran a much more aggressive
stress test suite. During a test where I rapidly toggled power saving
(`iw dev wlp19s0 set power_save on/off`) while concurrently
downloading a 10GB file, the hardware bug finally triggered.

The resulting logs revealed a fascinating edge case about the
corruption pattern:

1. The hardware emitted a corrupted RX DMA burst.
2. Interestingly, the `pr_err_once("drv_info_sz %d\n", ...)` trap from
your new patch did NOT trigger. This indicates that the corrupted
descriptor happened to have a `drv_info_sz` that exactly matched 24
(`PHY_STATUS_SIZE`) (or 0) purely by coincidence, bypassing the
validation check.
3. Because the descriptor bypassed the length check, the driver
considered it valid and handed it over to the mac80211 stack via NAPI.
The mac80211 stack immediately choked on the corrupted frame structure
and threw a WARNING.
4. About 1.3 seconds later, the subsequent garbage in the hardware
burst reached the PHY status processing logic, where Panagiotis's
patch stepped in.

Here is the exact kernel trace proving this sequence:

[ 1080.394531] WARNING: net/mac80211/rx.c:896 at
ieee80211_rx_list+0x8bd/0xf10 [mac80211], CPU#3: irq/51-rtw_pci/519
[ 1080.394802] CPU: 3 UID: 0 PID: 519 Comm: irq/51-rtw_pci Tainted: G
        IOE       6.19.12-1-default #1
[ 1080.394814] RIP: 0010:ieee80211_rx_list+0x8bd/0xf10 [mac80211]
[ 1080.394921] Call Trace:
[ 1080.394924]  <IRQ>
[ 1080.394941]  ieee80211_rx_napi+0x55/0xe0 [mac80211]
[ 1080.395025]  rtw_pci_rx_napi+0x269/0x360 [rtw_pci]
[ 1080.395038]  rtw_pci_napi_poll+0x5b/0x110 [rtw_pci]
[ 1080.395044]  __napi_poll+0x30/0x1e0
[ 1080.395050]  net_rx_action+0x2ec/0x380
[ 1080.395063]  handle_softirqs+0xcd/0x270
[ 1080.395068]  do_softirq.part.0+0x3b/0x60
[ 1080.395073]  </IRQ>
...
[ 1081.708220] rtw_8821ce 0000:13:00.0: unused phy status page (10)

Crucially, because Panagiotis's patch (`if (!edcca_th) return;`) was
active, the system cleanly dropped the PHY status garbage at [
1081.708220 ] instead of hitting the NULL pointer dereference.

The system survived perfectly. No Kernel Panic occurred, and the
driver recovered instantly and continued the 10GB download without
dropping the connection.

Conclusion:
This proves that checking `drv_info_sz` is an excellent primary
defense, but it is not 100% bulletproof because random hardware
garbage can coincidentally have a "valid" length. Panagiotis's NULL
check patch remains an absolutely vital secondary layer of defense
that safely neutralizes the garbage that inevitably slips past the
length validation.

Together, these two patches create a remarkably robust shield against
this hardware defect. The system is incredibly stable now.

Thank you both for your brilliant work on this!

Best regards,
Oleksandr Havrylov

