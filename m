Return-Path: <linux-wireless+bounces-36625-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OvxJ0H9C2qrTAUAu9opvQ
	(envelope-from <linux-wireless+bounces-36625-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 08:03:45 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F22577B3A
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 08:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AC7903022860
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 06:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48067378821;
	Tue, 19 May 2026 06:03:41 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A56C37881C;
	Tue, 19 May 2026 06:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779170621; cv=none; b=irkaTH6NtmGJ4/G29G4j8WserKeLBR/T7hwsvylj4obCf9UKoQlHUb5Qz//qqUVj6k3YSTKfLDeH5ufPW1wXzWM79ZWVrioPC0CY+l+Ga+XL1OtSaGFj4VOUPCA6nheo2DIt5njuYPgV2QSsfKSfkDIAst2werEVGovF2u7BqTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779170621; c=relaxed/simple;
	bh=6FXVX0s/PgtlfqnKQ1Vnop5up4B9+sTiZYt+JfM8FPw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pwJaSLbtWVv9u1BBGwY4o1rPfpB7aRW8ILjn0/IQ1I8lR8TI+zJyqCybgqjBhZx6tbwLlXIQdw0FLdV3B0hC3h85GyD3aMjd5SbsCqaTClgvsGIMQf+pkl4WIooxVMYOE9Kr6V5PnqNIF7TkAifxG+/u3AVp7iNfZY2kLhPdoiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 75bb4532534811f1aa26b74ffac11d73-20260519
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:47ed8a00-1794-4843-8cac-dd69887ca58b,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:e7bac3a,CLOUDID:32275d4dc19db4aed5065d9c4b41e3e3,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:5,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
	SA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 75bb4532534811f1aa26b74ffac11d73-20260519
X-User: jindongyang@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <jindongyang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 729584784; Tue, 19 May 2026 14:03:30 +0800
From: Dongyang Jin <jindongyang@kylinos.cn>
To: miriam.rachel.korenblit@intel.com,
	johannes.berg@intel.com,
	emmanuel.grumbach@intel.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dongyang Jin <jindongyang@kylinos.cn>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] wifi: iwlwifi: mld: fix indentation in iwl_mld_fill_supp_rates()
Date: Tue, 19 May 2026 14:02:59 +0800
Message-Id: <20260519060259.2327712-1-jindongyang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DMARC_NA(0.00)[kylinos.cn];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jindongyang@kylinos.cn,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-36625-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:email]
X-Rspamd-Queue-Id: 06F22577B3A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fix the following inconsistent indentation warnings reported by smatch:

smatch warnings:
drivers/net/wireless/intel/iwlwifi/mld/tlc.c:454 iwl_mld_fill_supp_rates() warn: inconsistent indenting

There's an extra tab, remove it.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202605170928.yPTN7kOn-lkp@intel.com/
Signed-off-by: Dongyang Jin <jindongyang@kylinos.cn>
---
 drivers/net/wireless/intel/iwlwifi/mld/tlc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tlc.c b/drivers/net/wireless/intel/iwlwifi/mld/tlc.c
index fb68d8810e14..a03834d3ac65 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tlc.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tlc.c
@@ -451,7 +451,7 @@ iwl_mld_fill_supp_rates(struct iwl_mld *mld,
 		iwl_mld_fill_he_rates(capa, cmd);
 	} else if (capa->vht_cap && capa->vht_cap->vht_supported) {
 		cmd->mode = IWL_TLC_MNG_MODE_VHT;
-			iwl_mld_fill_vht_rates(capa, cmd);
+		iwl_mld_fill_vht_rates(capa, cmd);
 	} else if (capa->ht_cap && capa->ht_cap->ht_supported) {
 		cmd->mode = IWL_TLC_MNG_MODE_HT;
 		cmd->ht_rates[IWL_TLC_NSS_1][IWL_TLC_MCS_PER_BW_80] =
-- 
2.25.1


