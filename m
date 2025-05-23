Return-Path: <linux-wireless+bounces-23339-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01398AC1CC4
	for <lists+linux-wireless@lfdr.de>; Fri, 23 May 2025 08:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 533501BC7ACD
	for <lists+linux-wireless@lfdr.de>; Fri, 23 May 2025 06:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7651898E9;
	Fri, 23 May 2025 06:05:06 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794317DA8C;
	Fri, 23 May 2025 06:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747980306; cv=none; b=f3PHwEesrZ1r/v6cWeCKki4TlkCoNMkHqwPzFs75Sw8VYfaj9PtfC2q8byaZ3zjCSwP+QH8+O2CqlSQVWG2LhiSoPogNrLsl8IfX4Rb2A32A/+g0Aa5SlsNaI40xT4sXfCY+C3QUXnElSOicxT7O9gy9tC8xFRMeW2MjpBxJPbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747980306; c=relaxed/simple;
	bh=4LSJK/iO+HdCrJDa0TaXMhGIbIu/V57f7n1KE8GmDeQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aEFY/rpJPtEKT3Jju5W8q6/zLJedwDQ1WEmbJRd0LjqvuHYk/Rl6/iSYqjOyADXeg7IG/h31ilivOQx1e86cqALY/AdarHtVxzxkFTO8QbMnmIai2kG+Y7Ef8zKedS/GUZAX0NuRCbGESAddQLIm/oKcWYV0CZ+CRSyRdau54N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d90fbf74379b11f0b29709d653e92f7d-20250523
X-CTIC-Tags:
	HR_CC_AS_FROM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_DIGIT_LEN
	HR_FROM_NAME, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:8e9eb471-4bd8-4b90-bb80-e6e9e87fb85a,IP:0,U
	RL:0,TC:0,Content:0,EDM:-30,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-35
X-CID-INFO: VERSION:1.1.45,REQID:8e9eb471-4bd8-4b90-bb80-e6e9e87fb85a,IP:0,URL
	:0,TC:0,Content:0,EDM:-30,RT:0,SF:-5,FILE:0,BULK:0,RULE:EDM_GN8D19FE,ACTIO
	N:release,TS:-35
X-CID-META: VersionHash:6493067,CLOUDID:da64e96358f60d14b2c95ea56af8eb48,BulkI
	D:25052314045684Q7ZX7A,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|102,TC:n
	il,Content:0|50,EDM:2,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil
	,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: d90fbf74379b11f0b29709d653e92f7d-20250523
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1243160250; Fri, 23 May 2025 14:04:54 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: miriam.rachel.korenblit@intel.com,
	johannes.berg@intel.com,
	emmanuel.grumbach@intel.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH] wifi: iwlwifi: cfg:  Limit cb_size to valid range
Date: Fri, 23 May 2025 14:04:50 +0800
Message-Id: <5a603a35a2d05ac9bd44c87efc605d35051d5d12.1747980220.git.xiaopei01@kylinos.cn>
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
 drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
index cb36baac14da..8437763dcf5a 100644
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
 
@@ -202,11 +202,14 @@ int iwl_pcie_ctxt_info_init(struct iwl_trans *trans,
 		rb_size = IWL_CTXT_INFO_RB_SIZE_4K;
 	}
 
-	WARN_ON(RX_QUEUE_CB_SIZE(iwl_trans_get_num_rbds(trans)) > 12);
+	cb_size = RX_QUEUE_CB_SIZE(iwl_trans_get_num_rbds(trans));
+	if (unlikely(cb_size > 12)) {
+		WARN_ON(1);
+		cb_size = 12;
+	}
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


