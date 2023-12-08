Return-Path: <linux-wireless+bounces-586-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E89680AF6F
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Dec 2023 23:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 852A8B20B60
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Dec 2023 22:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8EF559166;
	Fri,  8 Dec 2023 22:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q+b/sW7v"
X-Original-To: linux-wireless@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0E810E0;
	Fri,  8 Dec 2023 14:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=KyoENoPUujGsQ/YpliautPG3lCbpkIJRcqfbmwEmYag=; b=Q+b/sW7vuJ6bW3h/AOtxNkzR/t
	zXsPLUGANjbdV6DFu2eyXJKrv8srB+0OK/RFmURgjgK4/K3nBXExmq1kT5CsZSCDwVBGAdJiv1q59
	DAOYazb0CDdKxlMbkyUQoe95IGYB4S3EsE6/RL7Wg9IPnjIk1ts4rKwzyoAkZ19cO7y2AXu8XRnZA
	aFet8AqOutrlWcif4ZYNzeBXW05Vo6cc/w6+qWnS2ydXpnnS0kVYEHrYhW1Fg0Jz/0ugS/eZoXhWf
	4sWKy6m50RReIMAAIgL7vFFnWcNA3unQe64SzgL4pV5aASYqCcYmC7ghGkV/WSZBXQVNqGkmMzEwz
	qLHS+3Ew==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rBj2Z-00Gf9Y-1i;
	Fri, 08 Dec 2023 22:09:47 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: netdev@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	kernel test robot <lkp@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	linux-wireless@vger.kernel.org,
	Kalle Valo <kvalo@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] wifi: iwlwifi: fw/dbg: fix all kernel-doc warnings
Date: Fri,  8 Dec 2023 14:09:45 -0800
Message-ID: <20231208220945.20628-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kernel test robot reports:
drivers/net/wireless/intel/iwlwifi/fw/dbg.c:86: warning: Excess struct/union/enum/typedef member 'trans_len' description in 'iwl_fw_dump_ptrs'

scripts/kernel-doc no longer emits the warning that is reported by
the 0-day kernel test robot, but the reported struct does contain the
Excess line, so remove that line as well as fix other kernel-doc
warnings in this source file:

dbg.c:1732: warning: contents before sections
dbg.c:1736: warning: No description found for return value of 'mask_apply_and_normalize'
dbg.c:2202: warning: missing initial short description on line:
 * iwl_dump_ini_mem
dbg.c:2207: warning: contents before sections
dbg.c:2215: warning: No description found for return value of 'iwl_dump_ini_mem'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202311250305.tf8Cus1Y-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202312060810.QT9zourt-lkp@intel.com/
Cc: Gregory Greenman <gregory.greenman@intel.com>
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org
Cc: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff -- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -19,7 +19,6 @@
  * @fwrt_ptr: pointer to the buffer coming from fwrt
  * @trans_ptr: pointer to struct %iwl_trans_dump_data which contains the
  *	transport's data.
- * @trans_len: length of the valid data in trans_ptr
  * @fwrt_len: length of the valid data in fwrt_ptr
  */
 struct iwl_fw_dump_ptrs {
@@ -1726,12 +1725,13 @@ iwl_dump_ini_mem_fill_header(struct iwl_
 }
 
 /**
- * mask_apply_and_normalize - applies mask on val and normalize the result
+ * mask_apply_and_normalize - applies mask on val and normalizes the result
+ * @val: value
+ * @mask: mask to apply and to normalize with
  *
  * The normalization is based on the first set bit in the mask
  *
- * @val: value
- * @mask: mask to apply and to normalize with
+ * Returns: the masked, normalized value
  */
 static u32 mask_apply_and_normalize(u32 val, u32 mask)
 {
@@ -2200,15 +2200,15 @@ struct iwl_dump_ini_mem_ops {
 };
 
 /**
- * iwl_dump_ini_mem
- *
- * Creates a dump tlv and copy a memory region into it.
- * Returns the size of the current dump tlv or 0 if failed
- *
+ * iwl_dump_ini_mem - copy ini memory region to a dump tlv
  * @fwrt: fw runtime struct
  * @list: list to add the dump tlv to
  * @reg_data: memory region
  * @ops: memory dump operations
+ *
+ * Creates a dump tlv and copies a memory region into it.
+ *
+ * Returns: the size of the current dump tlv or %0 if failed
  */
 static u32 iwl_dump_ini_mem(struct iwl_fw_runtime *fwrt, struct list_head *list,
 			    struct iwl_dump_ini_region_data *reg_data,

