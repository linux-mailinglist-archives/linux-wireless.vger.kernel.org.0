Return-Path: <linux-wireless+bounces-30719-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EF6D16597
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 03:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E6201301513D
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 02:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89E325B1FC;
	Tue, 13 Jan 2026 02:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="V9JGMbxw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4939D2F39A4
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 02:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768272305; cv=none; b=qnAk0f11QFAXIiDIBMOyHAFNsiAmi0Z4WElBDWZQgOpGwCX3SUUzZzHGOQqMuEhgvFxz7/GGN2hp1Pt5cRfMgPFDxgNTY9RZ5Gx2X3zzrFZHIg15GC+KDfSk0cSsZfFC+Dl2W+IgOSrdCCmOPZRTXWQGS4cX3RW+hNnjLnn09lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768272305; c=relaxed/simple;
	bh=nQbnu1pk2buJRFwNRRXek6+jCrnNRBFyU/pjDjP6ye8=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=GQ/X9LRDFaSfRck1xnH7IC38TGsOtjZWfeE/L7yHuSryp35QdwB6M0s/2KTuQbsy74qntwb4KbMvjzuYgxFmxsZyJ0kgMOX9YqwGOETW+C6zYjbT/fr6sTBZBANBuMqTY5uOLTtI5wid4EMy7oAEkLvAVVy9qhTpFdPgmDwWGY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=V9JGMbxw; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60D2j1KV12159570, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1768272301; bh=ae5mcSSzPm2ulrv2C+wbPayn2ALo5IfVWfPhGbbJyVE=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=V9JGMbxwd58DGnqaisrkj6Sh5ypg7fyi2rJYoc9n4sdSzc/KcsBktVdHXuTFGln/5
	 UHkGg3LKiYqpzXL/JXgerWZ5uP6gHJULJKZO5i538HFhRhzWdJynB5xsnm4lrTBRer
	 m1GCoO22qmWvcIqYNZ3BF0nc3o9PAPXvYzU3poaaIBks82tV6K9LcEn9PDWdztPZq0
	 um/k+UAzlNlNs4Vnc10UKE4by5vc7HJt+/UCifhB3KH9CNgzlg93Fj8zH08mpU1GXT
	 QNEowGvNN5GicSf+BL4gHXBXwlAkhXehDvRf9laApfGriKkqyUgaA3s+VwMGZWk3yE
	 fnlLXQH/bgQvQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60D2j1KV12159570
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 10:45:01 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 13 Jan 2026 10:45:01 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Tue, 13 Jan 2026 10:45:01 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <leo.li@realtek.com>
Subject: Re: [PATCH rtw-next 01/13] wifi: rtw89: coex: make coex scoreboard as chip info
In-Reply-To: <20260108120320.2217402-2-pkshih@realtek.com>
References: <20260108120320.2217402-1-pkshih@realtek.com> <20260108120320.2217402-2-pkshih@realtek.com>
Message-ID: <7d1f9e50-dad2-46dc-bd5a-6190e3dacd3a@RTKEXHMBS03.realtek.com.tw>
Date: Tue, 13 Jan 2026 10:45:01 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ping-Ke Shih <pkshih@realtek.com> wrote:

> The coex scoreboard is to exchange WiFi and BT profiles, and the coming
> chip 8922D changes the design including extend to two scoreboards and
> individual register for cfg/get. Follow the changes to abstract current
> code, but not change logic for existing chips at all.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

13 patch(es) applied to rtw-next branch of rtw.git, thanks.

95052ab2d794 wifi: rtw89: coex: make coex scoreboard as chip info
ed2feda12f36 wifi: rtw89: coex: update scoreboard value according to power state for two BT
286bb07889c1 wifi: rtw89: coex: update coex software control for RTL8922D
9d6a2a636c9f wifi: rtw89: mac: remove unnecessary return from rtw89_fwdl_secure_idmem_share_mode()
5afb451bb5e0 wifi: rtw89: mac: add dle_mem and ple_{min,max}_qt quota for RTL8922D
70cd273aae23 wifi: rtw89: mac: set quota 13 for PLE SNRPT
9cf039ee49b5 wifi: rtw89: mac: update MPDU quota according to chip DLE definition
a69c2c9a587d wifi: rtw89: mac: update WP quota for RTL8922D
7ded59e69ab3 wifi: rtw89: mac: define preload_init for generations
baf38631460b wifi: rtw89: mac: configure DMA_STOP1 by predefined mask
c16673247b40 wifi: rtw89: mac: separate functions of CMAC power and function enable
6996a4c97ad6 wifi: rtw89: mac: add an entry to enable MAC function in preinit
40714b8a2137 wifi: rtw89: mac: set EDCCA configurations for RTL8922D

---
https://github.com/pkshih/rtw.git


