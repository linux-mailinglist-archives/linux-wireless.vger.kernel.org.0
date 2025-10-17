Return-Path: <linux-wireless+bounces-28009-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE83BE6454
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 06:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D7C203506B1
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 04:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F68E246799;
	Fri, 17 Oct 2025 04:11:41 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636512AD11;
	Fri, 17 Oct 2025 04:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760674301; cv=none; b=LbII9wL8AKXdF23PFVce5ky3OppypalTw5BpuKnJIJw7gFWe65a09BEOJAlTcwtbv3JPelrxxpdoOcbEN3fE2lgTLvHwKx8GvOIhQWZamnC6/VIM6p1lN0gqnAyIdZUDUV7TTsAGisVxPsB3vm8T63wfN5jYmMNweR2uBjPk2DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760674301; c=relaxed/simple;
	bh=3DBTrmpSoQPz0qwYohA6Ub/8HY9k/rKP4hodqUP2sPk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DC3GE/adhZ7fs3LXSSz32ZEvAntp7LdCGzVb4mkHHGj9dY1AsVhovgh9ad5SnU/zvfjLGtSBt92lsXl1RPwhw8Y0i5iqYMVRiGFU1Yu/oQCmR5UK1Yxt345gOkcgfjmfk1xC0N/6Q9eo0tDrtO9kncbWjrks7So/E5yBtDTdWVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5d074234ab0f11f0a38c85956e01ac42-20251017
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:30e60bda-c7be-4f75-bed1-ad962732147d,IP:0,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:25
X-CID-META: VersionHash:a9d874c,CLOUDID:038a3ebec05791a9b37a49a4422c88d9,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850,TC:nil,Content:0|50,EDM:5,IP:nil
	,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:
	1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5d074234ab0f11f0a38c85956e01ac42-20251017
X-User: liqiang01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liqiang01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1469670305; Fri, 17 Oct 2025 12:11:32 +0800
From: Li Qiang <liqiang01@kylinos.cn>
To: miriam.rachel.korenblit@intel.com,
	johannes.berg@intel.com,
	emmanuel.grumbach@intel.com,
	rotem.kerem@intel.com,
	yedidya.ben.shimol@intel.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Qiang <liqiang01@kylinos.cn>
Subject: [PATCH] wifi: iwlwifi: mld: add null check for kzalloc() in iwl_mld_send_proto_offload()
Date: Fri, 17 Oct 2025 12:11:28 +0800
Message-Id: <20251017041128.1379715-1-liqiang01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a missing NULL pointer check after kzalloc() in
iwl_mld_send_proto_offload(). Without this check, a failed
allocation could lead to a NULL dereference.

Fixes: d1e879ec600f9 ("wifi: iwlwifi: add iwlmld sub-driver")
Signed-off-by: Li Qiang <liqiang01@kylinos.cn>
---
 drivers/net/wireless/intel/iwlwifi/mld/d3.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/d3.c b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
index 1d4282a21f09..dd85be94433c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
@@ -1794,6 +1794,10 @@ iwl_mld_send_proto_offload(struct iwl_mld *mld,
 	u32 enabled = 0;
 
 	cmd = kzalloc(hcmd.len[0], GFP_KERNEL);
+	if (!cmd) {
+		IWL_DEBUG_WOWLAN(mld, "Failed to allocate proto offload cmd\n");
+		return -ENOMEM;
+	}
 
 #if IS_ENABLED(CONFIG_IPV6)
 	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
-- 
2.25.1


