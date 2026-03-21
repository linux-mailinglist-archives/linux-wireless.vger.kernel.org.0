Return-Path: <linux-wireless+bounces-33623-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDJCLQJ8vmm8QwMAu9opvQ
	(envelope-from <linux-wireless+bounces-33623-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 12:07:46 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 616462E4F3B
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 12:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 71F95304F5D2
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 11:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B888D344024;
	Sat, 21 Mar 2026 11:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="gb23/m3R"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8248435949;
	Sat, 21 Mar 2026 11:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774090851; cv=none; b=a2XJ4UmNsWYAogkDVGZ613xL0AYs019OBuvhl8SYjjI58W6oLqfnfTT72uGpYXxsPHIPwoILIRpjBOjObInmqkpxwPVdzXTsrh6esksyg2mFM2L3axvTUlG+Sd71lhTGPvXOP9bKpEYrkkloE5UxqCOfP/DaDXiOe0Cp44D6QX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774090851; c=relaxed/simple;
	bh=u/JvpN/J/xE2HPRdbpOyyO2It4mAEDMbKBD5RxfqTfw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bvWS37F+jBKPt5uVnVGYwjdOlHKfsF+svzi9ZeE6eujF1aXoPXJMjWCKSUKJWSX2CKMd9xyOo0lRX3vSeCXdfxIjCpP410OyGO1EBsWz8pTWTvTCcdHd9FJ82T8hHcDfuCKT/0JTy6Lp69DoZ9nT8Req/dP/IxS86sFem8f74rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=gb23/m3R; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1774090824;
	bh=FWXH44yr3WXDFkSlyl3oxIpDco1Bm9mCtTk8gi5yxYs=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=gb23/m3RZs2D0HfzbTU+ARYPidKzcsVDsKgVihcaIaUeviJIyUc/cFj6qnpFx+r8S
	 Ap4hpmSTmaKt+T5qqIOnpaAzQ2r6eRSdnZjISfFG31PdBFNz63w9KEt5O8tr++cDO3
	 wWyrRylNtpGdYwfx2mtkUStRehMnWH/pFW8JgqmY=
X-QQ-mid: zesmtpgz4t1774090822t64eeb699
X-QQ-Originating-IP: iOUSNHpVdWD8qbSUIEldRV7GceL6S85yDHqTjEKo+kI=
Received: from localhost.localdomain ( [116.172.93.199])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 21 Mar 2026 19:00:20 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15896690706035518709
EX-QQ-RecipientCnt: 10
From: Kexin Sun <kexinsun@smail.nju.edu.cn>
To: miriam.rachel.korenblit@intel.com,
	johannes.berg@intel.com,
	ilan.peer@intel.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: julia.lawall@inria.fr,
	xutong.ma@inria.fr,
	kexinsun@smail.nju.edu.cn,
	yunbolyu@smu.edu.sg,
	ratnadiraw@smu.edu.sg
Subject: [PATCH] wifi: iwlwifi: mvm: update outdated comment for renamed ieee80211_tx_status()
Date: Sat, 21 Mar 2026 19:00:20 +0800
Message-Id: <20260321110020.8636-1-kexinsun@smail.nju.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:smail.nju.edu.cn:qybglogicsvrgz:qybglogicsvrgz5b-0
X-QQ-XMAILINFO: NSTsyPg8kQQYZog19g9BvHOfXbcNwHXqt46VKCuOiRmlP8IKc5kA8G/7
	0ojJ/lTt1nY/O5EL+T60+jHM5vvjoM1isXhfQsNDgVwyoXXy5rKH5rBloIWJsCmjqAYwMTH
	hneZKzsDcHkB/noOMQ6TO7KrOC9of7iDdEBGND9851A73xTcQe+dAnX8MpI2eKHLjedZ6Gx
	mdB+551jU8K4zWwXeqFOCSbr+9az8e+may3FtW7ltRd8N3XUxDsCkbrH5QBfNZCmwNReKQv
	WtAL2Hs3xLLf3awQxKkGOmLpjFWroZLSVcIaPSFLH+YaHL4qsHfuqT8rUnnKHahK8fN6bt7
	P6rDAm6/5PESgUVnRvuOwh9FAosDsGNH86EhiXGVb7bLZMlo08fw08qaHLg9BC077lfgIZa
	6QUMwlzJrII8in8Ewdy46FTbTiAk2g/dbGDyjIFgJHup4+0w58X+o268Ey9bXOTLtGwvPjC
	ljCe1sOrT8P0wyVI/GXxFcziG4XN2IbcNbIw4u6zjKba6FXrm3Oru82Uj+q8XPe4ggR/I9I
	sRUHj5VrexPIOk26j6itqTVU8i1ayX8MfgAQBs0EPx626oINt46io4DFlqnQL5UpjskRLvv
	ryfqDYDn6UrnTvRQEQ5qe3UegaLlCwgX9IrPn6865kwViZO/bjQTSZYyRioqhbOWatoTKxm
	MKDLVA6cQF+4UeLOzb/CrhDHFsqFvcdv2wjir+4N095wy18El6cg9+ifiKDCbmoTaUN746P
	YsqU0beHk7KkMM3b219ip3ShTXkL5/wLhTcSsO1g/5ehupr1mIAbCCwyAByxZ3NXttt3rfY
	amP+GV1jLRkQVHwLeTJ5iBhEOl9nDMG4C7vrf79zoG+5wnexVCROG6CMC/cVkpKRDQ8m7nP
	u5qZjx+WWOx5PnYL29o/vlI3Bgt3hT5RgCwaTsCKAzlXBa6zJ9+dgQ4xyjkV5uzDW/FqAm4
	R/ml8qHErPAQUC/f1ZEUBgcCc0KObX9hentvYGxUKSsxtmLiWliKGgq1bILzSfqF1tTqK8A
	Y04gJVOCyptGaBB5SIW2uQPDpe0BziezStDzn+SNEvR7kZLUc0TVQA7wffX2F4sAZ6ZsELA
	UAVvXIe00kXl+ykh8XbJGEDJ3xJbl8p2A==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[smail.nju.edu.cn,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[smail.nju.edu.cn:s=iohv2404];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33623-lists,linux-wireless=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kexinsun@smail.nju.edu.cn,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[smail.nju.edu.cn:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nju.edu.cn:email,smail.nju.edu.cn:dkim,smail.nju.edu.cn:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 616462E4F3B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The function ieee80211_tx_status() was renamed to
ieee80211_tx_status_skb() by commit 2703bc851399
("wifi: mac80211: rename ieee80211_tx_status() to
ieee80211_tx_status_skb()").  Update the stale reference
in rs_set_lq_ss_params().

Assisted-by: unnamed:deepseek-v3.2 coccinelle
Signed-off-by: Kexin Sun <kexinsun@smail.nju.edu.cn>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
index d1619a229d8f..2216a91cdc8f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
@@ -3553,7 +3553,7 @@ static void rs_set_lq_ss_params(struct iwl_mvm *mvm,
 
 	/* This code is safe as it doesn't run concurrently for different
 	 * stations. This is guaranteed by the fact that calls to
-	 * ieee80211_tx_status wouldn't run concurrently for a single HW.
+	 * ieee80211_tx_status_skb wouldn't run concurrently for a single HW.
 	 */
 	if (!bfer_mvmsta) {
 		IWL_DEBUG_RATE(mvm, "No sta with BFER allowed found. Allow\n");
-- 
2.25.1


