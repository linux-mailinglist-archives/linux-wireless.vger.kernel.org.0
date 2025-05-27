Return-Path: <linux-wireless+bounces-23436-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE606AC49DD
	for <lists+linux-wireless@lfdr.de>; Tue, 27 May 2025 10:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8879C171EA3
	for <lists+linux-wireless@lfdr.de>; Tue, 27 May 2025 08:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA0723DEB6;
	Tue, 27 May 2025 08:04:19 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7181C6FFE;
	Tue, 27 May 2025 08:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748333059; cv=none; b=nZMoEAGuEd0Ih7zUg2RzfLkGudQr1tWTiofnsLzREL5yMZU0dFF07d8F+zyVPJscyCkPIyzw/5H2y3iwpRZzjmavWMfyd1os9Qg3iHXAsPwGWZguoSlQE+Cvl/e+1kbiyaOv4j2sbq/9ViomOpHn2EXLQVT+LTwnnoIPkhtCGb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748333059; c=relaxed/simple;
	bh=wMXqsnC04f3eA9JrWhsMw8ctnhdT+ZgnkM8z3aQak24=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pG0TyJpBss6D3IwNnciiS8BNion/m5NdeOYyql4ThYrPrRWmsABg3nSGCk//eLk5/NYpi30l0FL4cVXMAOr0e+cfxF40QTuVyuWI7Upm1X/KrhOKtIcnmoClVdN0UpDgi+3OpD+mjzf/EgZRZZr60u0P4SqjFhLfhVm0tBTN7EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 25e3e3383ad111f0b29709d653e92f7d-20250527
X-CTIC-Tags:
	HR_CC_AS_FROM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_DIGIT_LEN
	HR_FROM_NAME, HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER
	HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT
	HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED
	SA_TRUSTED, SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS
	DKIM_NOPASS, DMARC_NOPASS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:430fe6b6-c717-4130-a8d5-b87a3da13ead,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-INFO: VERSION:1.1.45,REQID:430fe6b6-c717-4130-a8d5-b87a3da13ead,IP:0,URL
	:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:20
X-CID-META: VersionHash:6493067,CLOUDID:0a3e5fd3c7b86344b70babc19b985428,BulkI
	D:2505271604021D5AQ85T,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|102,TC:n
	il,Content:0|50,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil
	,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 25e3e3383ad111f0b29709d653e92f7d-20250527
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2038246648; Tue, 27 May 2025 16:04:00 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH v2] wifi: iwlwifi: cfg:  Limit cb_size to valid range
Date: Tue, 27 May 2025 16:03:55 +0800
Message-Id: <7b373a4426070d50b5afb3269fd116c18ce3aea8.1748332709.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

on arm64 defconfig build failed with gcc-8:

drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c:208:3:
include/linux/bitfield.h:195:3: error: call to '__field_overflow'
declared with attribute error: value doesn't fit into mask
   __field_overflow();     \
   ^~~~~~~~~~~~~~~~~~
include/linux/bitfield.h:215:2: note: in expansion of macro '____MAKE_OP'
  ____MAKE_OP(u##size,u##size,,)
  ^~~~~~~~~~~
include/linux/bitfield.h:218:1: note: in expansion of macro '__MAKE_OP'
 __MAKE_OP(32)

Limit cb_size to valid range to fix it.

Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
Changes in v2:
use if(WARN_ON())
---
 drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
index cb36baac14da..4f2be0c1bd97 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
@@ -166,7 +166,7 @@ int iwl_pcie_ctxt_info_init(struct iwl_trans *trans,
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct iwl_context_info *ctxt_info;
 	struct iwl_context_info_rbd_cfg *rx_cfg;
-	u32 control_flags = 0, rb_size;
+	u32 control_flags = 0, rb_size, cb_size;
 	dma_addr_t phys;
 	int ret;
 
@@ -202,11 +202,12 @@ int iwl_pcie_ctxt_info_init(struct iwl_trans *trans,
 		rb_size = IWL_CTXT_INFO_RB_SIZE_4K;
 	}
 
-	WARN_ON(RX_QUEUE_CB_SIZE(iwl_trans_get_num_rbds(trans)) > 12);
+	cb_size = RX_QUEUE_CB_SIZE(iwl_trans_get_num_rbds(trans));
+	if (WARN_ON(cb_size > 12))
+		cb_size = 12;
+
 	control_flags = IWL_CTXT_INFO_TFD_FORMAT_LONG;
-	control_flags |=
-		u32_encode_bits(RX_QUEUE_CB_SIZE(iwl_trans_get_num_rbds(trans)),
-				IWL_CTXT_INFO_RB_CB_SIZE);
+	control_flags |= u32_encode_bits(cb_size, IWL_CTXT_INFO_RB_CB_SIZE);
 	control_flags |= u32_encode_bits(rb_size, IWL_CTXT_INFO_RB_SIZE);
 	ctxt_info->control.control_flags = cpu_to_le32(control_flags);
 
-- 
2.25.1


