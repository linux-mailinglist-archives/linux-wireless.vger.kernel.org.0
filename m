Return-Path: <linux-wireless+bounces-910-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 179518173BC
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 15:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C50D1C238FA
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 14:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCDF3787B;
	Mon, 18 Dec 2023 14:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EoDCHLOb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kjvaVfG9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD510D308
	for <linux-wireless@vger.kernel.org>; Mon, 18 Dec 2023 14:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702910226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=y5wR/t7KVf6ulWvrj1nbhoTnVW9Z+lHAr/N+sEU4FnY=;
	b=EoDCHLObS5UeHkiuakYZkxyMId6BNkHHK0CWrJO+iXuONDpAJZfjO1cwhxXs2fQEOnA+Mq
	VyoeCVxwOd76r1Xw8tfcaltZLmpk2evfKnmqZN1YcWUc68mXyLe6CDtbtTVfnn1n27oLGp
	BebuYD+e6YVbSppZvXZyVRfj9eyde3iCgUu7iYDoJYq9GEs2p308hqIORweFSUY8SMw7eC
	GPNiahXl1t7dw/Ys9vxAA1Al9aWoE/VG/36GbC6xBnk+T9JIHQVn8Y3qkxpR+pyEd6En6P
	Ud0ap7L9YlUM8oviI65Ao7tAxg9htlkmK94thT4Z/OhYm2d7syCS4MSAtmv/mQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702910226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=y5wR/t7KVf6ulWvrj1nbhoTnVW9Z+lHAr/N+sEU4FnY=;
	b=kjvaVfG9sstzNwBSJg7x/jrzfR6rBx0wi1ZbGexOWJ8jdS0fo0kisaRvebiEOAWxevfcxL
	qio/LrjV3BcPZoAg==
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 00/20] wifi: rtl8xxxu: Add concurrent mode for 8188f
Date: Mon, 18 Dec 2023 15:36:25 +0100
Message-Id: <20231218143645.433356-1-martin.kaistra@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds the possibility to use two virtual interfaces on the
same channel. Supported combinations are STA+STA and STA+AP. The
conversion of the driver to support multiple interfaces is split into
individual patches to hopefully make it easier to understand what is
going on.

Thanks,
  Martin

Martin Kaistra (20):
  wifi: rtl8xxxu: remove assignment of priv->vif in
    rtl8xxxu_bss_info_changed()
  wifi: rtl8xxxu: prepare supporting two virtual interfaces
  wifi: rtl8xxxu: support setting linktype for both interfaces
  wifi: rtl8xxxu: 8188e: convert usage of priv->vif to priv->vifs[0]
  wifi: rtl8xxxu: support setting mac address register for both
    interfaces
  wifi: rtl8xxxu: extend wifi connected check to both interfaces
  wifi: rtl8xxxu: extend check for matching bssid to both interfaces
  wifi: rtl8xxxu: support setting bssid register for multiple interfaces
  wifi: rtl8xxxu: support multiple interfaces in set_aifs()
  wifi: rtl8xxxu: support multiple interfaces in
    update_beacon_work_callback()
  wifi: rtl8xxxu: support multiple interfaces in configure_filter()
  wifi: rtl8xxxu: support multiple interfaces in watchdog_callback()
  wifi: rtl8xxxu: support multiple interfaces in
    {add,remove}_interface()
  wifi: rtl8xxxu: support multiple interfaces in bss_info_changed()
  wifi: rtl8xxxu: support multiple interface in start_ap()
  wifi: rtl8xxxu: support multiple interfaces in get_macid()
  wifi: rtl8xxxu: remove obsolete priv->vif
  wifi: rtl8xxxu: add hw crypto support for AP mode
  wifi: rtl8xxxu: make supporting AP mode only on port 0 transparent
  wifi: rtl8xxxu: declare concurrent mode support for 8188f

 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |  16 +-
 .../realtek/rtl8xxxu/rtl8xxxu_8188e.c         |   2 +-
 .../realtek/rtl8xxxu/rtl8xxxu_8188f.c         |   1 +
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 361 +++++++++++++-----
 4 files changed, 283 insertions(+), 97 deletions(-)

-- 
2.39.2


