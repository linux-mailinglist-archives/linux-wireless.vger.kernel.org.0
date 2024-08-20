Return-Path: <linux-wireless+bounces-11691-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEFD95866F
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 14:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC3951C24EDA
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 12:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D0C19006B;
	Tue, 20 Aug 2024 12:00:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBFD18FC70
	for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2024 12:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724155235; cv=none; b=i0ROaHOepsr9nEzaxpR+8n85m78JY5nzJi0QDh2otktkFMfIQe4kswiuphX8fZe9ommgRkgxwcTSrYnKqJ9nqX+I8VaTbvrVScAMhrLnNhxwpT/glG5qzauKiPDO6vJ6hbTsoTR6cNUqilfFcmEMJVw7tFBThG0lGUpscuRQCxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724155235; c=relaxed/simple;
	bh=VIe/hSx1leTJy1aMRk7uETdeFagGWs1Kgniihu+KNmk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FLNI9mnoiH6D2OgcNHBSWX74mUBock1vDs/hIa8R9a1QVrd3XDfh6jjw53R6G7JTWumEd6+Zb0pb+lfEvvi81zdWf+6UZZqIfWhqGJHx1zjXQf6NVwLzJj1JYxNaoV32++o7lC/RTL2IF/d1k6qGBp6+AE/KLrelwMFFF57mMwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNXH-0000x1-9x; Tue, 20 Aug 2024 14:00:27 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNXG-001lNk-Os; Tue, 20 Aug 2024 14:00:26 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNSR-00GnIQ-1Z;
	Tue, 20 Aug 2024 13:55:27 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Tue, 20 Aug 2024 13:55:54 +0200
Subject: [PATCH 29/31] wifi: mwifiex: pass adapter to
 mwifiex_fw_dump_event()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240820-mwifiex-cleanup-v1-29-320d8de4a4b7@pengutronix.de>
References: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
In-Reply-To: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724154927; l=2811;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=VIe/hSx1leTJy1aMRk7uETdeFagGWs1Kgniihu+KNmk=;
 b=Hu7L10w1+zGHo/HFg7a3vU7M68eoDu7BzD6Bscj/H+11MShSswULLac+uQqwRLBaYJMuX24Rz
 72nEZBmSje5BNAWasIishHYPD7LOd2bkPKFvOExNLv8fEK3xPeQgd4E
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

The only caller of mwifiex_fw_dump_event() gets the priv * by calling
mwifiex_get_priv(card->adapter, MWIFIEX_BSS_ROLE_ANY) which is the same
as mwifiex_adapter_send_cmd() does internally. Use this function instead
of mwifiex_send_cmd() and pass the adapter as context pointer to
mwifiex_fw_dump_event().

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/net/wireless/marvell/mwifiex/main.h | 2 +-
 drivers/net/wireless/marvell/mwifiex/usb.c  | 3 +--
 drivers/net/wireless/marvell/mwifiex/util.c | 6 +++---
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wireless/marvell/mwifiex/main.h
index 0098bae832885..e8aa498657c39 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -1640,7 +1640,7 @@ void mwifiex_drv_info_dump(struct mwifiex_adapter *adapter);
 void mwifiex_prepare_fw_dump_info(struct mwifiex_adapter *adapter);
 void mwifiex_upload_device_dump(struct mwifiex_adapter *adapter);
 void *mwifiex_alloc_dma_align_buf(int rx_len, gfp_t flags);
-void mwifiex_fw_dump_event(struct mwifiex_private *priv);
+void mwifiex_fw_dump_event(struct mwifiex_adapter *adapter);
 void mwifiex_queue_main_work(struct mwifiex_adapter *adapter);
 int mwifiex_get_wakeup_reason(struct mwifiex_private *priv, u16 action,
 			      int cmd_type,
diff --git a/drivers/net/wireless/marvell/mwifiex/usb.c b/drivers/net/wireless/marvell/mwifiex/usb.c
index e082c26003cd7..0a1a67fdaa59e 100644
--- a/drivers/net/wireless/marvell/mwifiex/usb.c
+++ b/drivers/net/wireless/marvell/mwifiex/usb.c
@@ -671,8 +671,7 @@ static void mwifiex_usb_coredump(struct device *dev)
 	struct usb_interface *intf = to_usb_interface(dev);
 	struct usb_card_rec *card = usb_get_intfdata(intf);
 
-	mwifiex_fw_dump_event(mwifiex_get_priv(card->adapter,
-					       MWIFIEX_BSS_ROLE_ANY));
+	mwifiex_fw_dump_event(card->adapter);
 }
 
 static struct usb_driver mwifiex_usb_driver = {
diff --git a/drivers/net/wireless/marvell/mwifiex/util.c b/drivers/net/wireless/marvell/mwifiex/util.c
index a8c44cc14f8a2..312a83327cac4 100644
--- a/drivers/net/wireless/marvell/mwifiex/util.c
+++ b/drivers/net/wireless/marvell/mwifiex/util.c
@@ -857,9 +857,9 @@ void *mwifiex_alloc_dma_align_buf(int rx_len, gfp_t flags)
 }
 EXPORT_SYMBOL_GPL(mwifiex_alloc_dma_align_buf);
 
-void mwifiex_fw_dump_event(struct mwifiex_private *priv)
+void mwifiex_fw_dump_event(struct mwifiex_adapter *adapter)
 {
-	mwifiex_send_cmd(priv, HostCmd_CMD_FW_DUMP_EVENT, HostCmd_ACT_GEN_SET,
-			 0, NULL, true);
+	mwifiex_adapter_send_cmd(adapter, HostCmd_CMD_FW_DUMP_EVENT,
+				 HostCmd_ACT_GEN_SET, 0, NULL, true);
 }
 EXPORT_SYMBOL_GPL(mwifiex_fw_dump_event);

-- 
2.39.2


