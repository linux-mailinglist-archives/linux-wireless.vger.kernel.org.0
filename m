Return-Path: <linux-wireless+bounces-13485-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 655B098FBB3
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 02:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E4BB28349C
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 00:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003741876;
	Fri,  4 Oct 2024 00:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="MhGijVbP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6114C1B7E9;
	Fri,  4 Oct 2024 00:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728002583; cv=none; b=NCCvi6StO+cNpn8J1vl3RI3KDQE7PwjnT2g8zpVWP8/hIXAgi+/1RDFBxedReYpA7nobRwbbn838vWv/ZbFQx1AayJurqzdgyJzeZ5DoCV7SO8YFt1uI4chkMBFngBY30Ch2hOIhLCKUAIf+ku2n2LVgGggjUXUGL/o041zLzY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728002583; c=relaxed/simple;
	bh=Rtz2RkiW/OLsccqc3PDbUBNwvCK21hiRkbRO2wJUD24=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yp5aqFkxGXODOysM0SvcBDU9EU2X1xRM8LN1g5P6nlOeWVF6y8P1Z1YIPTPv++aSslTeBi2L2w+PH+H3vgWi7CZgQGfiMCOg9o9i1CG71tq4OcRcQtNkAh0JFOWOkJqZFAPgOLTnBmDigU+9sZtjf0asVzWZ+/hSSLceObpY4sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=MhGijVbP; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=lVgwWE6GyZ9ryVazC3efYVBhCMl8DxvEb6ve9xmwhHU=; b=MhGijVbPGuYX5k8u
	P571sfrn2aAvc7oZEvmMV54DSDvMio2Bk/IFdtUDf5+XG/YxOX88cDfR2EVTIAuEHrMxez7MU0S+6
	Ed8B1nkdc11NNN0G0aznYHUrrVu2J+mAB2uVeUvIA9Cc6gxpa//jLck9D0N2+sTkQf3tLGTIlRjly
	1ZNuBrtRQa8SpnosRTjJEX9RMpv4kx7Rdqme9xxh6xaV1TH7l2y5YWOv0uJujPg7WuhgnzHhBJ176
	hRyf7xCoHMWpiyt7CjBeB4qUDrBIclg/Lmw9ka15cIUMkPyBPfltnnibLselHgDxtZ6JeqOX+h2AS
	LhKavh6gbJb0C9kAzA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1swWPM-008lvh-15;
	Fri, 04 Oct 2024 00:43:00 +0000
From: linux@treblig.org
To: arend.vanspriel@broadcom.com,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org
Cc: brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] brcmsmac: Remove unused brcms_debugfs_get_devdir
Date: Fri,  4 Oct 2024 01:42:59 +0100
Message-ID: <20241004004259.470853-1-linux@treblig.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

brcms_debugfs_get_devdir() has been unused since it was added by commit
8e21df23894e ("brcmsmac: hardware info in debugfs")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/debug.c | 5 -----
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/debug.h | 1 -
 2 files changed, 6 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/debug.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/debug.c
index 6d776ef6ff54..81df41c7fbb5 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/debug.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/debug.c
@@ -56,11 +56,6 @@ void brcms_debugfs_detach(struct brcms_pub *drvr)
 	debugfs_remove_recursive(drvr->dbgfs_dir);
 }
 
-struct dentry *brcms_debugfs_get_devdir(struct brcms_pub *drvr)
-{
-	return drvr->dbgfs_dir;
-}
-
 static
 int brcms_debugfs_hardware_read(struct seq_file *s, void *data)
 {
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/debug.h b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/debug.h
index 56898e6d789d..d30a9fa30f1b 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/debug.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/debug.h
@@ -70,7 +70,6 @@ void brcms_debugfs_init(void);
 void brcms_debugfs_exit(void);
 void brcms_debugfs_attach(struct brcms_pub *drvr);
 void brcms_debugfs_detach(struct brcms_pub *drvr);
-struct dentry *brcms_debugfs_get_devdir(struct brcms_pub *drvr);
 void brcms_debugfs_create_files(struct brcms_pub *drvr);
 
 #endif /* _BRCMS_DEBUG_H_ */
-- 
2.46.2


