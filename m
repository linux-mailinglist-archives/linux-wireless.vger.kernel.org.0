Return-Path: <linux-wireless+bounces-33301-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UE7gEt0QuGmIYgEAu9opvQ
	(envelope-from <linux-wireless+bounces-33301-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 15:17:01 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D339129B29B
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 15:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D43433007E31
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 14:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201F96FC5;
	Mon, 16 Mar 2026 14:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WISWDA+9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C410D220F3E
	for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 14:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773670240; cv=pass; b=oWsKDfjm08YvkeHbkj/kRpISLhRXUMWDmJ88rzMJX80qWMU3SN4VoASmqjLZ0FhfR6Vo7g5hbqgRdqfIswsssl/pCtlLm3H7yLzEJ7fdpQae8PhDKe9fGgYVop+tFZSGJixjQzysxye0zY+DSLs6Mh8uzoBf4XOign0KouPvje8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773670240; c=relaxed/simple;
	bh=MNntRCB5kVx6ko3nj28yNMu+IprGxz/Yhbdd3+8ErjI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=oDgjlE1yaR1vFsHSw3kWj3HCQLPdp64mvTutcBnqyD0qgsJtnVoSriY4xz7aFCu376NQP9WVTK+MF6GknQzaQiCb36HfKbIwcbCbE/EOwZMvN0mk0YOxMjPqCgk55DBK1A2tL6wtdocXJ/cWvsYaSWBLoXOuWm3TXVgYec4bdHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WISWDA+9; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-485410a0a8aso42880355e9.2
        for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 07:10:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773670237; cv=none;
        d=google.com; s=arc-20240605;
        b=lf+OjqK4AzdhHXPR/TeuKtC2lXaHt30O7ncQkakHH9YNlnDse3r+qry8LMsprjD7dL
         apBVL4UumQ5kQt1qoCkc3e+qb3bgxcrPrmlvUnUxOR8H95jVYbY4L1cCTNes5zDlYZi8
         KoUNnX9mnPuc2x8D6YtSzj8QqzuBHdYBaQqTlSS8Qf/+BXP1x+AhMixkuMtD/+V/qfBs
         9cy04AQprOQLmN8dMkFvqpXASgPDum7OAptCw5VfvKYXP/iDbMdgdvtPv+ewpiAHKzZ5
         8IfBx/tQIizxG7zy6aliA1uFwt+S0kBT8DolucwtNd7eZVjFpn2znWXR+SRCAWq20gA8
         P4Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=MNntRCB5kVx6ko3nj28yNMu+IprGxz/Yhbdd3+8ErjI=;
        fh=qW0phhq3fb3oiohK/Mu9j1KY1zyRNiiioKFc5anvatM=;
        b=GqR2PYAtu/J8llkBzw1bfdcy3XLQ/xIxlI0XeuHHANaJBYHD8slqpDD99pP8dnB9XJ
         piHFJXA0Qu16AvVOYPAqgdHCG8apWYahzsA3pJfK4Odw+GhIiQPapiGTVgXv31Rfaom9
         TRtfCyqf6ZDc+hBO2wXW/IA482NIgUTioPEqsbKDvmgIIfbwtR2zJXQzNoNfb8/tfh63
         1p4I9rrm7AnURMtaR8kaOT0qpiKBsTjqvqfCk6kVTEIabWyhF0Kk7ri7HyQEJ/GnyrFt
         SDrSI+3u+LpZC7seEWWVGylXr+1BL7yXJzF4JKW1Ba86VFa1LzFJfn7L4JaZWVTSTZNW
         C2Wg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773670237; x=1774275037; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MNntRCB5kVx6ko3nj28yNMu+IprGxz/Yhbdd3+8ErjI=;
        b=WISWDA+92OwRW+wrKGQbErCXJ/D1jWOt6QHhFqhvgiatc0MaavHRwM/0zylWThIjjB
         KUSktQMgElRtzXXBSLljUU3kn9bgd9A/XZESWYvB8mLJqDA6Mb97bkuY9X5pV6Eda5SF
         SCoS/ukM7wYkyBqN1xU4ZGbn3EauJKMeNY7+aXSgLFiGmvjtm0HBM/rS6lmfmZCB0oPY
         khFcSvu+yOBju/CERg4RvrSFsQnwFwe4zE88v3t/iN/2BbH95aaVIYav5MXmp/3kJBdO
         QWXS86dp/gbEPmd9bNQWSuQ0rC4JnSZAF40D65rfLXHr3txhaUx8oI4qC6eTBxw0NMYH
         Xjsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773670237; x=1774275037;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNntRCB5kVx6ko3nj28yNMu+IprGxz/Yhbdd3+8ErjI=;
        b=CammzMT04m5sgem41yb1MjkLq7CTmMkbaA5w8ZM4StNY/K2z1Pr3BcD7nFsojKt16T
         L4W2triKuXSocbiFl5lVkx+R4N+S2DYg0WSEq8LhVWwg3pca3Czn3k7oi2Sv5TaQz4wQ
         AdUNrB5f/a70FAM2Js2pBScvvwG3PE6XP6jbgLP7cWAPc5XEMHVYGtnReLwm+m6hL9qt
         U5zd5R4OTi9KJQvVfQw/Lxxn1rHUq2nrZemq1DNIfi/HPCFkA9eov5jMS93a28xiMbHQ
         tzLKMOvFyJDnECQrGdw+TBUDVGrQkPwX94/CGHrpLPxXd9GgY7Zi2fRpT3NY/Q8ZUHbO
         OclA==
X-Gm-Message-State: AOJu0YxrHdBruUescJWQNCQMBzFiJzYvOtoUktk5n+Io2oOG15eOul2o
	z2xaqqAIQ3WryD61GmsMBI+xHWZp8YhwZeBoDQc+vV+x1mmia7RVbH5uiOOO+XWYqmSRQFcS3K2
	gUn7MUbv+S9Ll8QS65hHUDJ3Imcenf7TZFag85m0=
X-Gm-Gg: ATEYQzzCBMTPdv6tGGavZHf6JhLrq/qve/FJXAj8gPD0bZSK5iE4FsMbECgfTzkYT7H
	+FfJzDSAlXX9ZUHfr70kbKQN/tASC8JeTyyl6+N/+3gGYU4kEg3R5TY7Bl1tyqwNls6TJkBwjxW
	Wsw9tt6dmyF4gdiz6m4IJ+DmZC9kvvzsV4C0mLJf8f2llqFLYLrKrCXaNTm0NpeZD0zqQzEe4Kz
	dg4vtJP03oeKJ7byikAjetAmLYAj8KlfFtSlESocPw92FcfatnLyydJg5vFVw7gLup93uzkJgzE
	F8KPYcFR
X-Received: by 2002:a05:600d:c:b0:485:17a7:ba0d with SMTP id
 5b1f17b1804b1-4855670e7ddmr161084665e9.32.1773670236720; Mon, 16 Mar 2026
 07:10:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jason Kakandris <ikakandris@gmail.com>
Date: Mon, 16 Mar 2026 16:10:24 +0200
X-Gm-Features: AaiRm52YwU5HABhtxNRHS-auBAj3whj6aZSJuQdgjhkVKjd5lfMWXqGVTCArVCc
Message-ID: <CAFR=mzkTDNVwypi_PvUw2PX0MM_ck0H61+PUAdJoo6h3yZfggw@mail.gmail.com>
Subject: RTL8852BE fails to power on: "xtal si not ready" on ASUS TUF GAMING
 B650-PLUS WIFI
To: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-33301-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ikakandris@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D339129B29B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

System Info

Distro: Linux Mint 22.3 Zena (Ubuntu 24.04 base)
Kernels tested: 6.14.0-37-generic, 6.17.0-14-generic (same failure on both)
Motherboard: ASUS TUF GAMING B650-PLUS WIFI (Rev 1.xx)
BIOS: v3827 (Feb 2026)
CPU: AMD Ryzen 7 7700X
Driver: rtw89 v7.0 (git commit d2f175e
https://github.com/morrownr/rtw89/commit/d2f175eafa0a4ef9cc65e7073a77e60238=
cae614)
WiFi works in Windows: Yes


Problem
The RTL8852BE WiFi card fails to initialize with xtal si not ready error. N=
o
wireless interface is created.


dmesg output

rtw89_8852be_git 0000:08:00.0: loaded firmware rtw89/rtw8852b_fw-1.bin
rtw89_8852be_git 0000:08:00.0: enabling device (0000 -> 0003)
rtw89_8852be_git 0000:08:00.0: xtal si not ready(R): offset=3D41
rtw89_8852be_git 0000:08:00.0: xtal si not ready(W): offset=3D90 val=3D10 m=
ask=3D10
rtw89_8852be_git 0000:08:00.0: failed to power on
rtw89_8852be_git 0000:08:00.0: failed to setup chip information
rtw89_8852be_git 0000:08:00.0: probe with driver rtw89_8852be_git failed wi=
th
error -110


lspci

08:00.0 Network controller [0280]: Realtek Semiconductor Co., Ltd. RTL8852B=
E
PCIe 802.11ax Wireless Network Controller [10ec:b852]
Subsystem: AzureWave RTL8852BE PCIe 802.11ax Wireless Network Controller
[1a3b:5471]

What I've tried

Kernel parameter pcie_aspm=3Doff
Module parameters: disable_clkreq=3DY disable_aspm_l1=3DY disable_aspm_l1ss=
=3DY
disable_ps_mode=3Dy
Updated BIOS from v3057 to v3827
Updated firmware files via make install_fw
Tested on kernels 6.14 and 6.17 =E2=80=94 same failure on both
In-kernel driver and morrownr out-of-tree driver =E2=80=94 same failure
WiFi works fine in Windows on the same hardware

