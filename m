Return-Path: <linux-wireless+bounces-35325-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGSaMh+d7mkNwAAAu9opvQ
	(envelope-from <linux-wireless+bounces-35325-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 01:17:51 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CDD46B73E
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 01:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 20CDD3006526
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Apr 2026 23:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433832E541F;
	Sun, 26 Apr 2026 23:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="le7ct6gB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC500450F2
	for <linux-wireless@vger.kernel.org>; Sun, 26 Apr 2026 23:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777245463; cv=pass; b=oiI6HC4N+jkOJjbMXKUcybU6v7jSZGzVSOrocHsPS3VHOfGbYmJV11NLC0wRn+/xgUnSiNH2ML2fFW/2QyB1obpaWayLfMfeVghOz3nSrg8xLenWvxA9c939lwNfpVEkSXTDQYhUkWTQoihQ+LZm2F0MtGPGkUly6UIelIy7IHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777245463; c=relaxed/simple;
	bh=7oqTAtxkXpKKRTfrK/vl7t1LOXKFmEikGuLEOMBQjFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gw/1q1Wl++T56qnTleOWYi/KhA2qo0YgyyPSXZETaP2RoP54rHev5hBXGkjAiAni6rR4JRYfpdwCKVXdvBXF+mir1IK727LlB3TLlOivr43XuVKl6PusAL9Q80tGPpsmplzCptXR+7CpZkm06vSdyd7kKa7sB6NYlsObITG49Fg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=le7ct6gB; arc=pass smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7de431da8fbso3848184a34.1
        for <linux-wireless@vger.kernel.org>; Sun, 26 Apr 2026 16:17:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777245461; cv=none;
        d=google.com; s=arc-20240605;
        b=dCq6aZGK5FSNU5Wx0mjUCJBsTw9pUgaX8Ee8vcEntos8kMnFji2WTWycb7gFvHrw0O
         Jdp7TeaRneL5rvOqCMuiDfNgPUfjLvg6+tkKqK7cLbjO97jyfBLAu+5zzH6vNMB6kFH3
         FnGaCMWlE07XoGCF5HbatYOAnQxKiuJYcYyopVZJwXO45ClLLwbnN5vzOLrqTLdSn8tF
         y7o+KPVarRYwAQSB5BZlkrBTJ7jGC/Bah6tCjHLQQEJW0qIWWAnNN3FZgkZLglbMTisB
         NLfL6M9iowO9pn2+7DrlVLOAP+uNRK4NEpB9QqgGxXakivDpuZOZMT7QCxpm1ctCmgMO
         lrnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7oqTAtxkXpKKRTfrK/vl7t1LOXKFmEikGuLEOMBQjFA=;
        fh=GlioamkqIb6g4wqpotrHhDBeQdkVnw7DqhFVplvRZFA=;
        b=f246ewHq71IQrrU25AILUqcW1jeVdb6zj7385H+17FDgOkvuZ/XcfnKNJL0MHn1rnu
         JjGEbOn8zrre3uQbgiBWOSgxNwKWGswfM8RghrXv/Ou+n/b4xSIyTn3q8NkJr3WQxnuh
         0ks3qr1LujbJmHMZkrhrFoxm0uU0bTB2stFPTDL0gMk7kaFZ1Md+M9ESUkebMYvi4kZO
         hoJosLSPJNDGlcFTK3B2Y+hQcFsx5wtXNjEYHg+z2eCmr2e6+jlbWexceW8ZrDUIupXe
         Ks2GUSQodMvq3EXQMEeaOV9hts/zuzpWV/6LsWBj52m1SkykVtqOw/Ia9NrZ2uEWuE+n
         Ve9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777245461; x=1777850261; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7oqTAtxkXpKKRTfrK/vl7t1LOXKFmEikGuLEOMBQjFA=;
        b=le7ct6gBsqQda/Vc0A10EShruQVUqIBzUkqOPReq3EtEB2cl0i49F5z8nv/5zL9QEA
         w8xiCA9W5DlVKfhsKc+e/M/mIDGfkttTAC8ndw8prRKHqw5YDpd9r4tMtggjaSfTL/zv
         qCuVlw4n15HgK8R+GRK0GOh8WwbbInWquly1Rc+zj2imEm0giD4hlWjv5su4WFghn5Kg
         Z7CUNt1s/nMUocUJfwy3VthY/ZzSpHAX7o+aUqe2cRA3IJl+8UR4tCpEwFWpJYLU2e6n
         f1RK2bROK7RLQBCJN9ZeUTLeM8sbGxlgmWTLHy7ARUivtUDAKl860VxlahZGwnB0iILM
         ihFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777245461; x=1777850261;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7oqTAtxkXpKKRTfrK/vl7t1LOXKFmEikGuLEOMBQjFA=;
        b=U5Tz7twzIT5/T+kJqbgLgJmOdQayj5b+21niYQ10WrJzzwJLaXyNDD/3clyMNQ3d87
         K2flc5ECjSfpH8OcKqI8UlIu37CdP5Gfh4KL6++ADQlwsTWmBn7xnxYevulNpAjMO0+r
         Uig+2/RVkDGA9cw3uVB4S5VmBfv8PAnXHg5QG7/3IS1egKbt2yOaRO2V7gaoS41WZzoz
         zODw2DuqA/Sx/MtQIpquKzigAKXttMle6q4Jbhih0MWwTPjdE3a74tk7dQ4aGdDsuOiV
         m5H1mMmZV6dqYkOsSqKyIcck/uuUI26roziW4S4jnq34JuWWYEDqvdP8FttGTFWLqI/t
         Q5/g==
X-Forwarded-Encrypted: i=1; AFNElJ96KqSKXek3adCcgEA8crtLNgrTjP/gsq+/3FYeUnma74YgjrVRpTQBo56EqCqTfPrpXmqwU2XzkjeUXgmOCg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy395856dyrvB/XOf2R8tWB1FJL2mfE+3Zr4BXE+JdIVqyjkv7Y
	NTn75oClPrDXHGDr/CT9ns0sGAT+lpxQEdf6WC0bcGxL+/ouQb1d77vakuHxKr7iAkV3lkN4Wvg
	sqNpov8x+XYfABXn/TArVofKfNqjZLPI=
X-Gm-Gg: AeBDiev4EHVTVRRKRTA/SxQ8SIGQbd8H+bT2mFOGszJuJHk088FU5sODturRvARMQJz
	i6lEnN1NJyBjZiDBUMvUTeg6r8TUs5RuGS1t3HTrdu6dn7FWx5xSo1HNXynKqUhNqIqX8U1kX38
	9r8oqAQk2O2j0WvUrDsDl7x992Ba3EcPwKzazdlDMwpN2ubRuAb5E8uCyzdSwMaD+ADnW/3KV4b
	P2bgi4YkJ7PFJY3FsNCHQABGLOzdDASRP4A3pp1OpEmZ1oRL4/oMGnXUUUNeZqO8NZh/1zAxPT+
	sUyGgtTeCxQWxAtBqnZ+Q0nSDhRWgA==
X-Received: by 2002:a05:6820:1f03:b0:68b:bc93:1de with SMTP id
 006d021491bc7-69462ef7d6emr21855986eaf.35.1777245460838; Sun, 26 Apr 2026
 16:17:40 -0700 (PDT)
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
 <faa215f1-ac2c-4072-9603-4baca1d5e07b@gmail.com>
In-Reply-To: <faa215f1-ac2c-4072-9603-4baca1d5e07b@gmail.com>
From: LB F <goainwo@gmail.com>
Date: Mon, 27 Apr 2026 02:17:04 +0300
X-Gm-Features: AVHnY4IcIA4hZk_bcOtRjcUdvz5m1r4NgMWXljtcpVcC9VjZ6lzjQMaI_fMjxIM
Message-ID: <CALdGYqQ+Syz+6weTChA=aXe=DBZSi1c0-7OYhJgkj7ahpR4EUA@mail.gmail.com>
Subject: Re: [BUG] wifi: rtw88: Hard system freeze on RTL8821CE when
 power_save is enabled (LPS/ASPM conflict)
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: Ping-Ke Shih <pkshih@realtek.com>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 47CDD46B73E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35325-lists,linux-wireless=lfdr.de];
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

Hi Bitterblue,

I am writing to report preliminary testing results for your RTL8821CE
RX descriptor validation patch (addressing Bugzilla 221286). I have
successfully applied the patch to the out-of-tree rtw88 driver.

System Environment:

OS: openSUSE Tumbleweed-Slowroll
Kernel: 6.19.12-1-default (x86_64)
Hardware: HP Notebook 15-ay027ur (SKU: P3S95EA#ACB, Board: 81F0)
Wi-Fi Module: Realtek RTL8821CE (PCIe)
Firmware loaded: Firmware version 24.11.0, H2C version 12
Driver: Out-of-tree rtw88 (manually patched rx.c, pci.c, pci_old.c,
sdio.c, usb.c)
Note on Patch Baseline: This testing was conducted with the new RX
descriptor validation patch applied on top of the previous patches
we've discussed:

Quirks to disable PCI ASPM and deep LPS for this HP model.
NULL check for chip->edcca_th.
The diagnostic hex dump patch for unused phy status pages.
Testing Methodology: To intentionally trigger the hardware bug, I
performed the following stress tests:

Sustained high-throughput RX load (continuously downloading a 145MB
file to /dev/null at maximum bandwidth).
Toggling PCIe ASPM and interface power saving (iw dev wlp19s0 set
power_save on) under active network load.
Rapid software de-authentication and re-association via NetworkManager.
ACPI Power state transitions: Suspend to RAM (S3) and Suspend to Disk
(S4/Hibernation) while actively connected.
Results: Previously, resuming from S3/S4 or shifting ASPM states under
load would consistently trigger a hard system freeze or kernel panic
within minutes. With your patch applied, the system remained
completely stable across all test phases. The driver handled all power
state transitions and sustained network loads without any issues.

Log Analysis: A detailed review of dmesg and journalctl shows no
mac80211 warnings, no rtw_8821ce initialization errors, and no memory
corruption traces. Notably, the pr_err_once trap for the corrupted
descriptor (drv_info_sz != PHY_STATUS_SIZE or length mismatches) was
not triggered during these artificial tests. This suggests the
hardware did not emit a corrupted frame during this specific session.
However, the system's ability to survive heavy S3/S4 transitions
without crashing is a massive improvement.

Next Steps: Given the intermittent nature of the bug, I will use the
machine for standard daily workloads over the next several days
(longitudinal testing). If the pr_err_once trap is triggered or if any
instability occurs, I will immediately provide the logs. If the system
remains perfectly stable for a week, I will report back to confirm the
fix is solid.

Thank you for your time and for providing this patch.

Best regards, Oleksandr Havrylov

