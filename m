Return-Path: <linux-wireless+bounces-23773-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D834ACF486
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 18:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 783193A23EE
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 16:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3564315A;
	Thu,  5 Jun 2025 16:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=abv.bg header.i=@abv.bg header.b="k1nHNQYb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp-out.abv.bg (smtp-out.abv.bg [194.153.145.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50AD26AD0
	for <linux-wireless@vger.kernel.org>; Thu,  5 Jun 2025 16:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.153.145.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749141646; cv=none; b=PSLv3cWMiYj+ZKBqdZZ7vOdZbEeF+VAhLATxOM+HzDLtfzUxgqfMTBKlF+f0NwZY7HcC1ME3s9lYWqQCrchnGN+n8dwkgy1fLiCBhk6CsI8joDwR1KWDNzchJjJ/BsN0BKBuLGBmy/keAhqxvETexdyORNUVfR0OhyGMFERgM90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749141646; c=relaxed/simple;
	bh=J7BO4cdNbl8xl2oTleEZqHYEaar+K6Gd6630e4lK1Hw=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=Qzv8gu/Tvj5HZ7J0au/ySeoLe6LYscg9G0Hv1OOdkQ9hsx89Poeg3vl3NiAfT9QTBsUKJbiQQAaRm42f1Z9Eu1YAhXXD/dvSJeioLgLur0fH1M+dTSppAZTS1s3bT/lQ4psAP3Oi9Qp7d1DhddxNuuhcQz1Zeq+NCfxvYoJYPJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=abv.bg; spf=pass smtp.mailfrom=abv.bg; dkim=pass (1024-bit key) header.d=abv.bg header.i=@abv.bg header.b=k1nHNQYb; arc=none smtp.client-ip=194.153.145.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=abv.bg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=abv.bg
Received: from nm51.abv.bg (nm51.ni.bg [192.168.151.47])
	by smtp-out.abv.bg (Postfix) with UTF8SMTP id 18B183320F
	for <linux-wireless@vger.kernel.org>; Thu,  5 Jun 2025 19:32:40 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=abv.bg; s=smtp-out;
	t=1749141160; bh=J7BO4cdNbl8xl2oTleEZqHYEaar+K6Gd6630e4lK1Hw=;
	h=Date:From:To:Subject:From;
	b=k1nHNQYbQfm+YQjOkRfx15U8dS+cRF7+m0TFmvXKWEYidbivLRi6PuorOtc1G1rJ+
	 XMfkgg8QVnTKOFResPeR2dBgWR5XEv2YTi0eeZtREmmBggrzQPUhjNgc0sKWReWEUL
	 I7YOUWEzspybT7tUpUyAdvRT8NjNi6xRkvbPMwjI=
Received: from nm51.abv.bg (localhost [127.0.0.1])
	by nm51.abv.bg (Postfix) with UTF8SMTP id 16E3576E89
	for <linux-wireless@vger.kernel.org>; Thu,  5 Jun 2025 19:32:40 +0300 (EEST)
Date: Thu, 5 Jun 2025 19:32:40 +0300 (EEST)
From: "M. Nikolov" <iwanowkolew@abv.bg>
To: linux-wireless@vger.kernel.org
Message-ID: <1420845070.839591.1749141160094@nm51.abv.bg>
Subject:  [mt76][mt7902] Inquiry about support for MediaTek MT7902 Wi-Fi chipset under Linux
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Mailer: AbvMail 3.0

Hello,


I’m reaching out to ask about current or planned support for the **MediaTek MT7902** Wi-Fi 6 (802.11ax) chipset in the Linux kernel, specifically in the `mt76` driver stack.


I’ve been attempting to get Wi-Fi working on a laptop (ASUS Vivobook) using this chipset, running Linux Mint 22.1 (based on Ubuntu 24.04) with kernel versions 6.8.x and 6.11.x. So far, the device is not automatically supported, and no official firmware appears to exist in the `linux-firmware.git` repository.


What has been tried:
- Installation of the community DKMS driver: [https://github.com/samveen/mt7902-dkms](https://github.com/samveen/mt7902-dkms)
- Firmware files extracted from the Acer Windows driver (e.g., `WIFI_MT7902_patch_mcu_1_1_hdr.bin`, `WIFI_RAM_CODE_MT7902_1.bin`)
- Module loading works (`mt7902`, `mt76`), but fails at firmware stage with:
  
mt792x_load_firmware(dev)->err : -11


- `dmesg` reports missing or invalid firmware, even though files are present in `/lib/firmware/mediatek/`


It seems the format of the Windows-derived firmware is not compatible with the expectations of the `mt76` driver stack.


So I’d like to ask the community:


1. Is there ongoing or planned support for **MT7902** in the `mt76` driver?
2. Is anyone currently working on a proper Linux-compatible firmware for this chipset?
3. Would it help if we tested patches, experimental firmware, or early driver code?


Any direction or guidance would be greatly appreciated. Thank you for your time and effort on this incredible project.


Best regards,  

Mark Nikolov

iwanowkolew@abv.bg


