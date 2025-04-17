Return-Path: <linux-wireless+bounces-21641-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEC5A91EBC
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 15:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06ECC19E77DB
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 13:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDF924EA93;
	Thu, 17 Apr 2025 13:52:51 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1C824EAA4
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 13:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744897971; cv=none; b=SXLWsBU0DAnpZzFp/CIU+Q/Gnc9e/JP3BS2N3tjehdx49wiwZgZuwn5mIkVkswTzsM70KbQVMuaonfkHp3ZV6ajmt9cM1iGqPLzp9ChIfD8ZHakzohc58GtscbMlW15r3bGI8n/AtfDQXsyqKJbSiQgaXNtw4rtsSh/FN8vJPTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744897971; c=relaxed/simple;
	bh=53IOtVgFkFYEwZwYVFct7/9NhJvm/Y9iJnBNzLZnLE0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=NefF1LttHzEDqyfKtFscIHjpMs3YdHkVL3DQAq/8v5RBZ2tFXcuL515fJt+Vr7zOLEh/DobKVY5j+DuStPf63/PRuNfEq279a8hFlkVHSIDnuXU9G9DLAOj2eyW4jWgL/mQLhY0xs4g6aIJx/i57TIKD6kNzAScsOI3eqLj47oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: 7Kh3jNAPQjy3OKQYbJoUgw==
X-CSE-MsgGUID: a7+IvEJ6Tuq6wCYFr6hoHg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 17 Apr 2025 22:52:48 +0900
Received: from localhost.localdomain (unknown [10.14.100.3])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 175544006DE8;
	Thu, 17 Apr 2025 22:52:43 +0900 (JST)
From: Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
To: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Sergiy Petrov <sergiy.petrov.ue@bp.renesas.com>,
	Viktor Barna <viktor.barna.rj@bp.renesas.com>,
	Gal Gur <gal.gur.jx@renesas.com>,
	Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
Subject: [PATCH 01/38] wireless: add Renesas vendor
Date: Thu, 17 Apr 2025 16:51:59 +0300
Message-Id: <20250417135236.52410-2-oleksandr.savchenko.dn@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250417135236.52410-1-oleksandr.savchenko.dn@bp.renesas.com>
References: <20250417135236.52410-1-oleksandr.savchenko.dn@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

Part of the split. Please, take a look at the cover letter for more details

Reviewed-by: Viktor Barna <viktor.barna.rj@bp.renesas.com>
Reviewed-by: Gal Gur <gal.gur.jx@renesas.com>
Signed-off-by: Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
---
 drivers/net/wireless/Kconfig  | 1 +
 drivers/net/wireless/Makefile | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/wireless/Kconfig b/drivers/net/wireless/Kconfig
index c6599594dc99..7d865220cf59 100644
--- a/drivers/net/wireless/Kconfig
+++ b/drivers/net/wireless/Kconfig
@@ -30,6 +30,7 @@ source "drivers/net/wireless/microchip/Kconfig"
 source "drivers/net/wireless/purelifi/Kconfig"
 source "drivers/net/wireless/ralink/Kconfig"
 source "drivers/net/wireless/realtek/Kconfig"
+source "drivers/net/wireless/renesas/Kconfig"
 source "drivers/net/wireless/rsi/Kconfig"
 source "drivers/net/wireless/silabs/Kconfig"
 source "drivers/net/wireless/st/Kconfig"
diff --git a/drivers/net/wireless/Makefile b/drivers/net/wireless/Makefile
index e1c4141c6004..fcfb3ec09dee 100644
--- a/drivers/net/wireless/Makefile
+++ b/drivers/net/wireless/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_WLAN_VENDOR_PURELIFI) += purelifi/
 obj-$(CONFIG_WLAN_VENDOR_QUANTENNA) += quantenna/
 obj-$(CONFIG_WLAN_VENDOR_RALINK) += ralink/
 obj-$(CONFIG_WLAN_VENDOR_REALTEK) += realtek/
+obj-$(CONFIG_WLAN_VENDOR_RENESAS) += renesas/
 obj-$(CONFIG_WLAN_VENDOR_RSI) += rsi/
 obj-$(CONFIG_WLAN_VENDOR_SILABS) += silabs/
 obj-$(CONFIG_WLAN_VENDOR_ST) += st/
-- 
2.17.1


