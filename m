Return-Path: <linux-wireless+bounces-17714-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E931A1636E
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Jan 2025 18:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91A60164538
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Jan 2025 17:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE601DF73B;
	Sun, 19 Jan 2025 17:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="pka/KkmX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-81.smtpout.orange.fr [80.12.242.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6F613C9B3;
	Sun, 19 Jan 2025 17:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737309005; cv=none; b=o3WGGd5SJl0IGCawOwrTplhpwkHiYNLPLhfFQ1LJc1zg3Tz0l2sdNP86Rh6Uv52bsG7s98xvy0Psli3HS3mrxkosfzfWqEcJrZOR5PGoUWYzdKdwn2n3ym0UqhWiYNPO9z6H4C0dOijR1wkbI1mOcuwdM+fEI19I4sRDw87GPZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737309005; c=relaxed/simple;
	bh=MQoZlToE3/Q2RW3XgUPpw2fb50IMF2dkeQPupjYQoCg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BD5YNa6gtm+X1edK/3X1unIjcxm2XZFaHBim8d473RaDrsmnfAcQ03L3mPTM17Rvd/Svtk8IBb/yfwJzuNjIs3Kc0ZicQ5KnsRCgGR6LaBt1UkeQFek4Mv3CCtmavVvtQ0Y3HqtRoEVmbBv1SflLeWa4PMbVwC+W+JBYyrGk50Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=pka/KkmX; arc=none smtp.client-ip=80.12.242.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id ZZPjtGLyU45fFZZPmtGw4d; Sun, 19 Jan 2025 18:48:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1737308931;
	bh=+iX2S2TglzCp8jiKgZur7Ohvf+vLaMM23LaoBPamAEc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=pka/KkmXQAiRsOX95pZX/2jmbSXs09zW2/60KraNnZEj4KXXO4FQD2kfi3dWfQycM
	 KAd1KiDXX+HQq623t92I17+uNrtN+59vzxqNjU7g8BnYzpyb6uJUZu7XXLqEd7Y0+j
	 nuJR0V3on6bJ08/G0XMGXFyJFjdVZbroJHk+5EncTvt7rFrgF/xbvYJjyG5lZUIBBn
	 zy+3U+viera5QpydFLAq4STi5zBjz+k6ajjEk/sWYedngCGFMyUqxtbcw+h0wqxdhD
	 lYqbLTtVBAHehLWin1FETOOgU9sWS9xPkdxm3UH1V7qXLqFclCNlrXrnOp7lK/g5uR
	 oajbTJGGChSvA==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 19 Jan 2025 18:48:51 +0100
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Kalle Valo <kvalo@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: mwifiex: Constify struct mwifiex_if_ops
Date: Sun, 19 Jan 2025 18:48:39 +0100
Message-ID: <03d524b72f20a0302e4de5e0ebdc20ab69469dec.1737308889.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct mwifiex_if_ops' are not modified in these drivers.

Constifying these structures moves some data to a read-only section, so
increase overall security, especially when the structure holds some
function pointers.

On a x86_64, with allmodconfig, as an example:
Before:
======
   text	   data	    bss	    dec	    hex	filename
  61439	   4367	     32	  65838	  1012e	drivers/net/wireless/marvell/mwifiex/pcie.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  61699	   4127	     32	  65858	  10142	drivers/net/wireless/marvell/mwifiex/pcie.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested-only.
---
 drivers/net/wireless/marvell/mwifiex/main.c | 4 ++--
 drivers/net/wireless/marvell/mwifiex/main.h | 2 +-
 drivers/net/wireless/marvell/mwifiex/pcie.c | 4 ++--
 drivers/net/wireless/marvell/mwifiex/sdio.c | 4 ++--
 drivers/net/wireless/marvell/mwifiex/usb.c  | 4 ++--
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wireless/marvell/mwifiex/main.c
index 855019fe5485..45eecb5f643b 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.c
+++ b/drivers/net/wireless/marvell/mwifiex/main.c
@@ -54,7 +54,7 @@ const u16 mwifiex_1d_to_wmm_queue[8] = { 1, 0, 0, 1, 2, 2, 3, 3 };
  * proper cleanup before exiting.
  */
 static int mwifiex_register(void *card, struct device *dev,
-			    struct mwifiex_if_ops *if_ops, void **padapter)
+			    const struct mwifiex_if_ops *if_ops, void **padapter)
 {
 	struct mwifiex_adapter *adapter;
 	int i;
@@ -1713,7 +1713,7 @@ static void mwifiex_probe_of(struct mwifiex_adapter *adapter)
  */
 int
 mwifiex_add_card(void *card, struct completion *fw_done,
-		 struct mwifiex_if_ops *if_ops, u8 iface_type,
+		 const struct mwifiex_if_ops *if_ops, u8 iface_type,
 		 struct device *dev)
 {
 	struct mwifiex_adapter *adapter;
diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wireless/marvell/mwifiex/main.h
index 0674dcf7a537..fb15831201f7 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -1470,7 +1470,7 @@ int mwifiex_init_shutdown_fw(struct mwifiex_private *priv,
 			     u32 func_init_shutdown);
 
 int mwifiex_add_card(void *card, struct completion *fw_done,
-		     struct mwifiex_if_ops *if_ops, u8 iface_type,
+		     const struct mwifiex_if_ops *if_ops, u8 iface_type,
 		     struct device *dev);
 int mwifiex_remove_card(struct mwifiex_adapter *adapter);
 
diff --git a/drivers/net/wireless/marvell/mwifiex/pcie.c b/drivers/net/wireless/marvell/mwifiex/pcie.c
index 5f997becdbaa..e11458fd4d50 100644
--- a/drivers/net/wireless/marvell/mwifiex/pcie.c
+++ b/drivers/net/wireless/marvell/mwifiex/pcie.c
@@ -21,7 +21,7 @@
 #define PCIE_VERSION	"1.0"
 #define DRV_NAME        "Marvell mwifiex PCIe"
 
-static struct mwifiex_if_ops pcie_ops;
+static const struct mwifiex_if_ops pcie_ops;
 
 static const struct mwifiex_pcie_card_reg mwifiex_reg_8766 = {
 	.cmd_addr_lo = PCIE_SCRATCH_0_REG,
@@ -3240,7 +3240,7 @@ static void mwifiex_pcie_down_dev(struct mwifiex_adapter *adapter)
 	mwifiex_pcie_free_buffers(adapter);
 }
 
-static struct mwifiex_if_ops pcie_ops = {
+static const struct mwifiex_if_ops pcie_ops = {
 	.init_if =			mwifiex_init_pcie,
 	.cleanup_if =			mwifiex_cleanup_pcie,
 	.check_fw_status =		mwifiex_check_fw_status,
diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.c b/drivers/net/wireless/marvell/mwifiex/sdio.c
index 490ffd981164..c1fe48448839 100644
--- a/drivers/net/wireless/marvell/mwifiex/sdio.c
+++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
@@ -21,7 +21,7 @@
 
 static void mwifiex_sdio_work(struct work_struct *work);
 
-static struct mwifiex_if_ops sdio_ops;
+static const struct mwifiex_if_ops sdio_ops;
 
 static const struct mwifiex_sdio_card_reg mwifiex_reg_sd87xx = {
 	.start_rd_port = 1,
@@ -3167,7 +3167,7 @@ static void mwifiex_sdio_up_dev(struct mwifiex_adapter *adapter)
 		dev_err(&card->func->dev, "error enabling SDIO port\n");
 }
 
-static struct mwifiex_if_ops sdio_ops = {
+static const struct mwifiex_if_ops sdio_ops = {
 	.init_if = mwifiex_init_sdio,
 	.cleanup_if = mwifiex_cleanup_sdio,
 	.check_fw_status = mwifiex_check_fw_status,
diff --git a/drivers/net/wireless/marvell/mwifiex/usb.c b/drivers/net/wireless/marvell/mwifiex/usb.c
index 6085cd50970d..3034c4405cb5 100644
--- a/drivers/net/wireless/marvell/mwifiex/usb.c
+++ b/drivers/net/wireless/marvell/mwifiex/usb.c
@@ -10,7 +10,7 @@
 
 #define USB_VERSION	"1.0"
 
-static struct mwifiex_if_ops usb_ops;
+static const struct mwifiex_if_ops usb_ops;
 
 static const struct usb_device_id mwifiex_usb_table[] = {
 	/* 8766 */
@@ -1585,7 +1585,7 @@ mwifiex_pm_wakeup_card_complete(struct mwifiex_adapter *adapter)
 	return 0;
 }
 
-static struct mwifiex_if_ops usb_ops = {
+static const struct mwifiex_if_ops usb_ops = {
 	.register_dev =		mwifiex_register_dev,
 	.unregister_dev =	mwifiex_unregister_dev,
 	.wakeup =		mwifiex_pm_wakeup_card,
-- 
2.48.1


