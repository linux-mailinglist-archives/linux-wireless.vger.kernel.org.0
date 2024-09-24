Return-Path: <linux-wireless+bounces-13118-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CD4984597
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2024 14:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97A051F21488
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2024 12:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B2719B3E4;
	Tue, 24 Sep 2024 12:09:45 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from weierstrass.telenet-ops.be (weierstrass.telenet-ops.be [195.130.137.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5CE145B2E
	for <linux-wireless@vger.kernel.org>; Tue, 24 Sep 2024 12:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727179785; cv=none; b=r/DGxfYF/9EqzgpRbO3dWXeKtyzG2zc0DTOBmP0H/+GyflNKyq9qP87oHXUOkkWc2zHUrAn+68nZ5ID9GYC5A+GiCBT3RPSx+o4eXAIfPcCXP9na55IrSnewdAgb4gkp234QxTsNuihJy7xV5jMcwbX5FxuW2tRGf9BIHwNNlpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727179785; c=relaxed/simple;
	bh=veKkp8CG3VFXFr0Z3odf3+jzGjGnsTggAkUJYuMiK0k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lfDUFM6/XIVAknunxGXexiZA44eDEqDD7WUMaXSiV8ISkKhV6HrabxzbYsbHROmYnARZbWnMcfW6gliswIhMm6qNHDmL6pxmLVuAJ1o7Aohh01I7ALf/L24LMgR5ZKUw8fVnDnVcU5os3i2oian9WZMB1KmgI2KeH0WSuU4z7vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
	by weierstrass.telenet-ops.be (Postfix) with ESMTPS id 4XCdvn2Q9Tz4wwdD
	for <linux-wireless@vger.kernel.org>; Tue, 24 Sep 2024 14:09:41 +0200 (CEST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:beb3:bbd4:b9cd:84ae])
	by andre.telenet-ops.be with cmsmtp
	id GC9Z2D0033rtkie01C9Zk1; Tue, 24 Sep 2024 14:09:34 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1st4MD-000Suq-77;
	Tue, 24 Sep 2024 14:09:33 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1st4MH-005j2d-2R;
	Tue, 24 Sep 2024 14:09:33 +0200
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
	Kalle Valo <kvalo@kernel.org>,
	"John W . Linville" <linville@tuxdriver.com>,
	Seth Forshee <sforshee@kernel.org>,
	Pieter-Paul Giesberts <pieterpg@broadcom.com>
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] brcm80211: BRCM_TRACING should depend on TRACING
Date: Tue, 24 Sep 2024 14:09:32 +0200
Message-Id: <81a29b15eaacc1ac1fb421bdace9ac0c3385f40f.1727179742.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When tracing is disabled, there is no point in asking the user about
enabling Broadcom wireless device tracing.

Fixes: f5c4f10852d42012 ("brcm80211: Allow trace support to be enabled separately from debug")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/net/wireless/broadcom/brcm80211/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/Kconfig b/drivers/net/wireless/broadcom/brcm80211/Kconfig
index 3a1a35b5672f1a27..19d0c003f6262675 100644
--- a/drivers/net/wireless/broadcom/brcm80211/Kconfig
+++ b/drivers/net/wireless/broadcom/brcm80211/Kconfig
@@ -27,6 +27,7 @@ source "drivers/net/wireless/broadcom/brcm80211/brcmfmac/Kconfig"
 config BRCM_TRACING
 	bool "Broadcom device tracing"
 	depends on BRCMSMAC || BRCMFMAC
+	depends on TRACING
 	help
 	  If you say Y here, the Broadcom wireless drivers will register
 	  with ftrace to dump event information into the trace ringbuffer.
-- 
2.34.1


