Return-Path: <linux-wireless+bounces-687-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A01680E4C0
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Dec 2023 08:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41D6AB220BE
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Dec 2023 07:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595D71642E;
	Tue, 12 Dec 2023 07:20:07 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6485A1;
	Mon, 11 Dec 2023 23:19:58 -0800 (PST)
X-UUID: 5b8d87fd12064b718bfe91c22cbc4b51-20231212
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:1272927b-c14b-423b-965e-88a0f32fa671,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-INFO: VERSION:1.1.33,REQID:1272927b-c14b-423b-965e-88a0f32fa671,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:20281961-c89d-4129-91cb-8ebfae4653fc,B
	ulkID:231212151949FMQZSAO8,BulkQuantity:0,Recheck:0,SF:66|38|24|17|19|44|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 5b8d87fd12064b718bfe91c22cbc4b51-20231212
X-User: shitao@kylinos.cn
Received: from kylin-pc.. [(112.64.161.44)] by mailgw
	(envelope-from <shitao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 180846737; Tue, 12 Dec 2023 15:19:46 +0800
From: shitao <shitao@kylinos.cn>
To: gregory.greenman@intel.com,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: shitao <shitao@kylinos.cn>,
	k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH] net: Fix spelling typo in comment
Date: Tue, 12 Dec 2023 15:19:35 +0800
Message-Id: <20231212071935.3098275-1-shitao@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix spelling typo in iwl-context-info.h comment.

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: shitao <shitao@kylinos.cn>
---
 drivers/net/wireless/intel/iwlwifi/iwl-context-info.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-context-info.h b/drivers/net/wireless/intel/iwlwifi/iwl-context-info.h
index 1a1321db137c..3ab6f127041f 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-context-info.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-context-info.h
@@ -6,7 +6,7 @@
 #ifndef __iwl_context_info_file_h__
 #define __iwl_context_info_file_h__
 
-/* maximmum number of DRAM map entries supported by FW */
+/* maximum number of DRAM map entries supported by FW */
 #define IWL_MAX_DRAM_ENTRY	64
 #define CSR_CTXT_INFO_BA	0x40
 
-- 
2.34.1


