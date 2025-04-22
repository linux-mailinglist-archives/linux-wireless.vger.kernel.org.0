Return-Path: <linux-wireless+bounces-21843-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5941FA96D56
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 15:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A1AA17D2E1
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 13:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06FB27CCF3;
	Tue, 22 Apr 2025 13:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Qb8oUm95"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B821E5B65
	for <linux-wireless@vger.kernel.org>; Tue, 22 Apr 2025 13:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745329607; cv=none; b=b6Cc8/s0rp3zpR5IZPJKauYOMuaMR7IMQsMvSCLSab/O5SiNnbt7vwOg58hSyi8RuBDS5JPDkyXrcLj3HKJqdRpkQC6WRvPV2fz7rrta90JfuudWzm+ZfNtXyCsdw0cIlyN8JrFIdb2KADHwi35jO/t/KcfdkN/ZtElNHys7/MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745329607; c=relaxed/simple;
	bh=u9Mn5GcpSdGecU0jyB1FujezXS+vojnfrtb/jgga2QE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pNYpUjZD1AVB1FPP7zqrIBxon7xMdnhiCsUOvKre1ol5x1dgo4I2JYrQo8SFW5fGBckxSf2d/V3rLM1VnRsoE+bKefJzdzxOVtEBP7DNZx/8VuOz22LGuLpgsN/CaAuGSld9hIhUyPM5kwkK+lvgeAXyWkieiThLIrzhWdFOL6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Qb8oUm95; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=70PDuupbmPCyKByhnb8v2eyvelkEWezqY+zURzqjAQY=; t=1745329606; x=1746539206; 
	b=Qb8oUm95YoBecKIyUIbso1yU8hdHuwu1XCQvM1h7iFC/KyNl3nxhfHkeeZNyrE5zbNH8nRZd9/a
	mg7qAKbZzpvEB2nTBXZHUDvJWUsV6k51gChKUeUWQ4RPO8+NTrscidIen0RfnHR18K8okiljipMdY
	OTtwXUxDWdxo8usOY6fIPtyian4eWqcKDJUCzW8MYsVj+Ty7nR2b/lj+CtPYcT55yByCnZwlVekrk
	dtVoMqkOHQfEvDGQESzBBH4qptZpqOaFR+6lU9CpiqIVfBP4Eu7PGgB3qVruv5e2rMagfLAHbMM3S
	429vEZGbaLMTeoXtCs7gFHjSvyuSUUHUC21w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1u7DxS-0000000CBiw-278X;
	Tue, 22 Apr 2025 15:46:42 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: miriam.rachel.korenblit@intel.com,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next] wifi: iwlwifi: mld: remove dead Makefile lines
Date: Tue, 22 Apr 2025 15:46:40 +0200
Message-ID: <20250422154640.2d73277dc523.Iaf09fec641cf5a0dda472441ac8ccbe08499fcdb@changeid>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

These are non-upstream things, they shouldn't be here, at
least for now. Remove them.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/Makefile | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/Makefile b/drivers/net/wireless/intel/iwlwifi/mld/Makefile
index ece66e7a9be4..c966e573f430 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/Makefile
+++ b/drivers/net/wireless/intel/iwlwifi/mld/Makefile
@@ -9,8 +9,4 @@ iwlmld-$(CONFIG_IWLWIFI_DEBUGFS) += debugfs.o
 iwlmld-$(CONFIG_IWLWIFI_LEDS) += led.o
 iwlmld-$(CONFIG_PM_SLEEP) += d3.o
 
-# non-upstream things
-iwlmld-$(CONFIG_IWL_VENDOR_CMDS) += vendor-cmd.o
-iwlmld-$(CONFIG_IWLMVM_AX_SOFTAP_TESTMODE) += ax-softap-testmode.o
-
 subdir-ccflags-y += -I$(src)/../
-- 
2.49.0


