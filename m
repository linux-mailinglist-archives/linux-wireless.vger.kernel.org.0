Return-Path: <linux-wireless+bounces-15608-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEBF9D6310
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2024 18:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1431282B34
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2024 17:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15B61DED7F;
	Fri, 22 Nov 2024 17:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="XVxW5zgV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7FA1DF725
	for <linux-wireless@vger.kernel.org>; Fri, 22 Nov 2024 17:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732296517; cv=none; b=FXbZSK9fke0ChoCH89joTh/8G7DJ4M+nNztL+6/zBL4nB8Hby/KzLOkQnHr1K73pxkL0cMSdB5I3GjffnTCsxshPGQk79RYyrV+F3VehJFIB1JeMnJfGDLMk35xls6qOH1E8N48UqV7N3hwc2rzcA7JcmLaJxWDkErc+YVTX3ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732296517; c=relaxed/simple;
	bh=XGSFzxqydBr/BRLH3yl4/6KKfht8h5pvy2KmMtnb1iM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lx7ltD6zDsFpzsNNgKNwTqV23D0Zj2XKwbS9PPIDAKSeNa1ooP5IqZgAN0exiXWeAYL8QRY5hxlio6ddhfTcYtNVd6wLfltV4jnIxnehS0FQcW/7jji02gc3VnCC0Us2zw9xV/m4mnxDCoUdYmr6AWtetMgDiUrvZS8o4BB5nz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=XVxW5zgV; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=TbG1gmL3r5F6gkhA9wY7qJE5eGvrbMZAFMd1dwxoWQ4=; b=XVxW5zgVe/U19he7AaL1Il5sFD
	3hkI3rFTPtO91oNWuOxFGrlt7pwrTRWiJIxIg24j7JSrfJGCFxqszQd+Y+jyMWWseEP6z3EpPr7YT
	1F3GG9tik9fTJVylQcpuwOT5xAEq5Ca2gd5kJFijvO4+V27iJE16LWckaOEGHvk2pK/GmTdls+qwb
	fd67Ms8PZv19E7+O4UbwyhuHkH8Kotau2c0AReVvMqWduFjnrlVFvZuUst93ZLFqbLvVMaYFzhayP
	VxFDxl8xh6V5V189KyoBWJjo4I+VG7fhUovuoNv0gT2Pxe9I9kwdyyF3EaVodsOs/rWe+qHlC6E3A
	9A+yIH2g==;
Received: from 179-125-75-203-dinamico.pombonet.net.br ([179.125.75.203] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tEXSB-00B3IM-81; Fri, 22 Nov 2024 18:28:23 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: linux-wireless@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	kernel-dev@igalia.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 4/4] wifi: rtlwifi: pci: wait for firmware loading before releasing memory
Date: Fri, 22 Nov 2024 14:27:18 -0300
Message-Id: <20241122172718.465539-5-cascardo@igalia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241122172718.465539-1-cascardo@igalia.com>
References: <20241122172718.465539-1-cascardo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At probe error path, the firmware loading work may have already been
queued. In such a case, it will try to access memory allocated by the probe
function, which is about to be released. In such paths, wait for the
firmware worker to finish before releasing memory.

Fixes: 3d86b93064c7 ("rtlwifi: Fix PCI probe error path orphaned memory")
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 drivers/net/wireless/realtek/rtlwifi/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.c b/drivers/net/wireless/realtek/rtlwifi/pci.c
index a870117cf12a..0eafc4d125f9 100644
--- a/drivers/net/wireless/realtek/rtlwifi/pci.c
+++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
@@ -2218,6 +2218,7 @@ int rtl_pci_probe(struct pci_dev *pdev,
 fail4:
 	rtl_deinit_core(hw);
 fail3:
+	wait_for_completion(&rtlpriv->firmware_loading_complete);
 	rtlpriv->cfg->ops->deinit_sw_vars(hw);
 
 fail2:
-- 
2.34.1


