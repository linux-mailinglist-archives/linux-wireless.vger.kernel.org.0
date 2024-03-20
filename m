Return-Path: <linux-wireless+bounces-4994-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA6488161B
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 18:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCA82284459
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 17:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B726A01D;
	Wed, 20 Mar 2024 17:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sg94xf0y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCAB6A01C
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 17:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710954421; cv=none; b=B10PJ3WfZBILFL4NbtxStS5Zg1Fd1T+8DxU64X8Blhi6SVaVgYJdfW37o81lnPe6cz55Ums745qtu46/z9o2vlg+sGIuqXBrri2EY/E2GtvhuYR662UAxMMWWsOgrfOyKqOcTQ82uzrLBqNBXZKiLnWcHTEPCGP32M9qjaKTezY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710954421; c=relaxed/simple;
	bh=3oVIDyfU9AbyJddK/V9yEYzg8fnE5awHx0dwfTl+eSI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lwIpWL3JQDmj9nDLbKR6VXUotSCODoDydsp/jyq/9Ci8t6FKZpz8YAZZOTS+RX+pTEikBjQin1+EiZbzxHuYAIr7AGjUZs7zOx0nVtW6wWEqkjK8gqOdyr6UfGLQtrVHacH6w0tnEUCcYYQ6QDdOuPj/OjrTW7HTgR6MUjfunsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sg94xf0y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60BF3C43390;
	Wed, 20 Mar 2024 17:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710954421;
	bh=3oVIDyfU9AbyJddK/V9yEYzg8fnE5awHx0dwfTl+eSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sg94xf0ySjDMK9MX/8mc/o3Vu++gqnoX/AzSarvDazcAzDY2spxdPeo2Cf/uHOXQf
	 u50arUGCX/3ImY12ooHndlQJ0G0+kCATvRa7EOij2XwaoajYhjivWH2k/f3iUk2y4+
	 akfNiSQAZFA5KyT0la7xesK/zrOu3eY0plgILodiWq4GXzyVOvEdy5RO43Uu2fC7vY
	 rO/PhU0DDYn2Qor+T4sEIEPwek3sESHYkz8ZxI0jHp48StR1CAsn/sXYrhnlUmsLZc
	 PEGBRZXhPQtBQL/hJ9nptqLnlkGU2Je/PPSzVKJEyzdR/xAQe2YS61yOOZmDAU0Dfc
	 TYHecGClJixRQ==
From: Kalle Valo <kvalo@kernel.org>
To: toke@toke.dk
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 2/3] wifi: ath9k: fix ath9k_use_msi declaration
Date: Wed, 20 Mar 2024 19:06:55 +0200
Message-Id: <20240320170656.3534265-3-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240320170656.3534265-1-kvalo@kernel.org>
References: <20240320170656.3534265-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kalle Valo <quic_kvalo@quicinc.com>

Sparse warns:

drivers/net/wireless/ath/ath9k/init.c:79:5: warning: symbol 'ath9k_use_msi' was not declared. Should it be static?

Move the extern to ath9k.h so that it's visible in init.c.

Compile tested only.

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath9k/ath9k.h | 1 +
 drivers/net/wireless/ath/ath9k/pci.c   | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ath9k.h b/drivers/net/wireless/ath/ath9k/ath9k.h
index 668fc07b3073..29ca65a732a6 100644
--- a/drivers/net/wireless/ath/ath9k/ath9k.h
+++ b/drivers/net/wireless/ath/ath9k/ath9k.h
@@ -39,6 +39,7 @@ extern int ath9k_modparam_nohwcrypt;
 extern int ath9k_led_blink;
 extern bool is_ath9k_unloaded;
 extern int ath9k_use_chanctx;
+extern int ath9k_use_msi;
 
 /*************************/
 /* Descriptor Management */
diff --git a/drivers/net/wireless/ath/ath9k/pci.c b/drivers/net/wireless/ath/ath9k/pci.c
index e655cd8bbf94..1ff53520f0a3 100644
--- a/drivers/net/wireless/ath/ath9k/pci.c
+++ b/drivers/net/wireless/ath/ath9k/pci.c
@@ -21,8 +21,6 @@
 #include <linux/module.h>
 #include "ath9k.h"
 
-extern int ath9k_use_msi;
-
 static const struct pci_device_id ath_pci_id_table[] = {
 	{ PCI_VDEVICE(ATHEROS, 0x0023) }, /* PCI   */
 	{ PCI_VDEVICE(ATHEROS, 0x0024) }, /* PCI-E */
-- 
2.39.2


