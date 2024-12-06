Return-Path: <linux-wireless+bounces-15984-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 715169E7784
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 18:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BDB5169D07
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 17:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4569A220681;
	Fri,  6 Dec 2024 17:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="e8QQc0JJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA44220683
	for <linux-wireless@vger.kernel.org>; Fri,  6 Dec 2024 17:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733506646; cv=none; b=SDNyemjZSYveCxjBtVz/3RuEoVp0GuZ8f1TahSxA9wzpi66Za6WM2k2IU8H4SAnD23LckqANGCuI+PwT4KrGTmZIuhz1taDxt4isJU3MOAaiSv0tWrW5KyUm+C4YtUr3OmFhrHLktfIFuDCS9QjGcdNM80eWC5vMo0ajCBwtdcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733506646; c=relaxed/simple;
	bh=UfFWXaPVC0bfUP/1s8ItYWhAMReLSW5RylyWEpobKxg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q7HGooISjZA06OF3AXSK5Cc7YuTssS0sNgAENhIbnBZDnki369URufn+QkFKXiwTT0d0AqV0O3yhjaqfMxOjRwrbyVZ/BEVaFI/Dkn8XVMQt7TIehD86PPz9RnM5K95ASGU+B/kmQgRJAypGJEhxN22UT2T9ral+ZOlnZFwhHZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=e8QQc0JJ; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=CD75SrY+/WDHZ0uNnC+bTLhXtZHhMv8Mb/uthBReaBY=; b=e8QQc0JJ5hTHsjCstKB2uasLMC
	jNsOVC9Zt3A5k+8btv7stlkXTxX5z0GwyOky2YS+dTKLdxJhHfQzjiJ5WA4paP2sELwaW7N/BJwi+
	UHYICB0b3A/iQvDw0+WdDsqOGQQhklwVSlNSl1vM/P9Pz8GDbc+7N3Hlja0y8ij9oqCFoopU/MK4T
	8LlzXmm0Pw/oZeoJOpWd7K4AKUcL7rbz+XU2gs7KPwiLVxcvbEBGvMfMXxMA/YwBmyo1mDCOkOMFt
	w5dPEuLS4sqJc4HJnzXVrRBFSm21vggRAJpunzWpNYGg9BCTQbAoR3ywQl5RA/5020rxmWI11p5e6
	ZQbIdZew==;
Received: from 179-125-79-245-dinamico.pombonet.net.br ([179.125.79.245] helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tJcGV-00HUvD-Uf; Fri, 06 Dec 2024 18:37:20 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: linux-wireless@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	kernel-dev@igalia.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH v2 0/4] wifi: rtlwifi probe error path fixes
Date: Fri,  6 Dec 2024 14:37:09 -0300
Message-Id: <20241206173713.3222187-1-cascardo@igalia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These fix different bugs when the probe fails. One of them is the addition
to a global list, which is not removed during the error path. That list has
been removed.

Then, some memory leaks are fixed, which require a change in where the
workqueue is destroyed.

Finally, the firmware completion is waited to prevent its callback from
accessing freed data.

These were tested against an "emulated" rtl8192se. It was a changed rtl8139
device under qemu with the rtl8192se PCI ID. Memory allocation failures
were injected over 4 different places: init_sw_vars, rtl_pci_init,
rtl_init_core and ieee80211_register_hw.

v2:
* add blank line after declarations
* fix rltwifi typo in subject of patch 2

Thadeu Lima de Souza Cascardo (4):
  wifi: rtlwifi: remove unused check_buddy_priv
  wifi: rtlwifi: destroy workqueue at rtl_deinit_core
  wifi: rtlwifi: fix memory leaks and invalid acess at probe error path
  wifi: rtlwifi: pci: wait for firmware loading before releasing memory

 drivers/net/wireless/realtek/rtlwifi/base.c | 13 +++--
 drivers/net/wireless/realtek/rtlwifi/base.h |  1 -
 drivers/net/wireless/realtek/rtlwifi/pci.c  | 60 ++++-----------------
 drivers/net/wireless/realtek/rtlwifi/usb.c  |  5 --
 drivers/net/wireless/realtek/rtlwifi/wifi.h | 12 -----
 5 files changed, 15 insertions(+), 76 deletions(-)

-- 
2.34.1


