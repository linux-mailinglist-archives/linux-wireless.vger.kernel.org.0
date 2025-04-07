Return-Path: <linux-wireless+bounces-21191-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B072A7D891
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 10:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4607416EEC6
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 08:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852551494CF;
	Mon,  7 Apr 2025 08:53:16 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054E3226883;
	Mon,  7 Apr 2025 08:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744015996; cv=none; b=AR8FB6CVujhuUzO++lUC0Pfn9f7lrNlHKmXmMnrN8sle1tMixUVrmVw+8/7wgWP5OdqpqtCWKdNr2+e/kQ2RmGMkGqPc14lbtfuembaFQVGPCi7jHCaSKO6bYVwUyC+INpI4NiaT0y9dbIjHGPE5dkC9l+k4Uh0/r4MH8XFd3GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744015996; c=relaxed/simple;
	bh=3CMcARXpGUUmojvbSQDkeLpdlzz+J7hS6Fy6CnPgn8o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fiG34I2FP4gCwsFCsDIxkF8jv2nJV1ujrEJAnJIbBZ8sIvcY6NSuM4FPODzXiO5jND80Zpx/5v6HyaJsjMd0b1LcslNn9y1IL08TJvEvefLIObMeDo82OxKF6SjPZznRNY5f69OlFzq8LITN+oudP/H1kof0uOSijSspzDodRtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-03 (Coremail) with SMTP id rQCowAB3JUJwkvNnIRXYBg--.33828S2;
	Mon, 07 Apr 2025 16:53:06 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: miriam.rachel.korenblit@intel.com,
	kvalo@kernel.org
Cc: johannes.berg@intel.com,
	emmanuel.grumbach@intel.com,
	golan.ben.ami@intel.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>
Subject: [PATCH v2] wifi: iwlwifi: mvm: Add error logging for iwl_finish_nic_init()
Date: Mon,  7 Apr 2025 16:52:47 +0800
Message-ID: <20250407085247.1992-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAB3JUJwkvNnIRXYBg--.33828S2
X-Coremail-Antispam: 1UD129KBjvJXoW7try7ur18tF48tw4kGw15Jwb_yoW8WFy3pF
	4UGFW2krZ5K397Ca48Ja1IyF98ta1Fk3yDKF92kws5urs7Jr98tF95XFy5ta40g3yrXa4S
	gF1jka4xGr1DZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUejjgDU
	UUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwkFA2fzgEpPvAABsk

The function iwl_pci_resume() calls the function iwl_finish_nic_init(),
but does not check their return values.

Log a detailed error message with the error code to aid in diagnosing
root causes if encountering irreparable errors. While this does not fix
the underlying problem, it assist debugging by making the failure
visible in logs.

Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
v2: Fix improper code.

 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 8fb2aa282242..34a7a3e4f7c0 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1616,6 +1616,7 @@ static int _iwl_pci_resume(struct device *device, bool restore)
 	struct iwl_trans *trans = pci_get_drvdata(pdev);
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	bool device_was_powered_off = false;
+	int err;
 
 	/* Before you put code here, think about WoWLAN. You cannot check here
 	 * whether WoWLAN is enabled or not, and your code will run even if
@@ -1647,7 +1648,11 @@ static int _iwl_pci_resume(struct device *device, bool restore)
 		 * won't really know how to recover.
 		 */
 		iwl_pcie_prepare_card_hw(trans);
-		iwl_finish_nic_init(trans);
+		err = iwl_finish_nic_init(trans);
+		if (err)
+			IWL_ERR(trans,
+				"NIC initialization failed after power-off (error %d).",
+				err);
 		iwl_op_mode_device_powered_off(trans->op_mode);
 	}
 
-- 
2.42.0.windows.2


