Return-Path: <linux-wireless+bounces-21172-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CE5A7CEFF
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Apr 2025 18:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 613BE188BD0D
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Apr 2025 16:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E6A15667D;
	Sun,  6 Apr 2025 16:42:49 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58434178395;
	Sun,  6 Apr 2025 16:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743957769; cv=none; b=GZ/Wh5wsjvVLLsVbkLkTneBDq8B2dFOo13V+SKqxhRCLcOysUi9k9p/kAmk5SC80YWfA2ZyCcVA7ipZ/YDqMtBJ2QFzsrkSK5oLXQ2w+npLrp9B26BqNqemOGDFmJwfqH2mLUmP7KpJCUYPwPbNmZPRMJML17nKwqh4R0Kj1oIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743957769; c=relaxed/simple;
	bh=weD6ltxNPcxizP1iukbR5APvJ4Dc3ZlN/zs6N0kWAMA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jnQOcPC5aKYeiEjnzFhGjHeEjb1I+3gpi04PTad5IwirnkpxmCzNIlvevjozNDIdjNHOy4grvpgEekamiFYb2q5XGvkl5kE0/3SzN8Z7iTRxMS/s5qyQHoZQH5jjKYVw3Jay2tWAqtLT3R9Y9m5n/FE5R+RgyxWTf8wkRH7E+og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.199.70.239])
	by APP-05 (Coremail) with SMTP id zQCowAAXUgrwrvJnPISqBg--.17438S2;
	Mon, 07 Apr 2025 00:42:27 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: miriam.rachel.korenblit@intel.com,
	kvalo@kernel.org
Cc: johannes.berg@intel.com,
	emmanuel.grumbach@intel.com,
	golan.ben.ami@intel.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>
Subject: [PATCH] wifi: iwlwifi: mvm: Add error logging for iwl_finish_nic_init()
Date: Mon,  7 Apr 2025 00:42:05 +0800
Message-ID: <20250406164206.1120-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAXUgrwrvJnPISqBg--.17438S2
X-Coremail-Antispam: 1UD129KBjvJXoW7try3ZF47Jw13WrW7WryxuFg_yoW8WF1UpF
	4qgFW2krZ5Ka92ka48ta1SvF90ya1Fk39rKF92kws5urs7Jry5JF95XFyUta40grW8Xa4S
	qF1jka4fCr1DZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
	6r4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbSfO7UUUU
	U==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAYEA2fyGc3xhwAAs6

The function iwl_pci_resume() calls the function iwl_finish_nic_init(),
but does not check their return values.

Log a detailed error message with the error code to aid in diagnosing
root causes if encountering irreparable errors. While this does not fix
the underlying problem, it avoids silent failures by making the failure
visible in logs.

Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 8fb2aa282242..f577f8c1d5b0 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1616,6 +1616,7 @@ static int _iwl_pci_resume(struct device *device, bool restore)
 	struct iwl_trans *trans = pci_get_drvdata(pdev);
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	bool device_was_powered_off = false;
+	int err;
 
 	/* Before you put code here, think about WoWLAN. You cannot check here
 	 * whether WoWLAN is enabled or not, and your code will run even if
@@ -1647,7 +1648,9 @@ static int _iwl_pci_resume(struct device *device, bool restore)
 		 * won't really know how to recover.
 		 */
 		iwl_pcie_prepare_card_hw(trans);
-		iwl_finish_nic_init(trans);
+		err = iwl_finish_nic_init(trans);
+		if (err)
+			pr_err("NIC initialization failed after power-off (error %d).", err);
 		iwl_op_mode_device_powered_off(trans->op_mode);
 	}
 
-- 
2.42.0.windows.2


