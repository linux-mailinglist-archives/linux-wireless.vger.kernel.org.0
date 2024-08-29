Return-Path: <linux-wireless+bounces-12202-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37326963E43
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Aug 2024 10:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56CBA1C21A9D
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Aug 2024 08:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE2918C025;
	Thu, 29 Aug 2024 08:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="Q9Z2J8aW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCCD18C022;
	Thu, 29 Aug 2024 08:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724919746; cv=none; b=DctCz0QNCtHtnFGX/GN2BwvhvN+M8f/JG/DPouEllCkVAsP99qYEbMY6NjWE8lweoE5BN2aZMDmL4JsubojHkjgWZc3XaxTbOWWziouRAZzrLiVr4A/ZhaGI0Ue+d9542bDPTq3xouHmDyJZGqA+P72BAf/ocV3AZud1ZaBIKXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724919746; c=relaxed/simple;
	bh=bVjOsFHlUAm9nepEgGhZ++5jXEtWJ/2Y9LASG1bvx2w=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=UfW67UfKGlJDxbQIplh5x6gCF73TjYhjktDWTMwSfyaOpYAG+mZXs8dOoIDmUNRCVM5sOwn2S6p9AWRqE9c6OwZl5YuQ4XYvGa2IG5uBNzehkp+7/g+svCaCHRWuaUfMJKt3cXd/3JwPb11Dph0JLNGJFHUN/ERZGQJSOTR8/i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=Q9Z2J8aW; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1724919431;
	bh=G6OG4H1WLyacS5PMKfxonqfaFSFAIEY1UFXEdN/73bE=;
	h=From:To:Cc:Subject:Date;
	b=Q9Z2J8aWWKkioeEIgjxZTApApfKju9NwR0N69UzSWsb+awbbV677oqP1/PGuolpJu
	 DpoZeFb9BKOBm+PG4lQU6aqFNcFnslYdE3nia5+oqphfm6dqT1bdU2xAwx17tJjRuS
	 PeqF9k8fEh3m6xMomPpnBaurKiH2LQeR2RncPaxM=
Received: from localhost.localdomain ([114.246.200.160])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id 44912C98; Thu, 29 Aug 2024 16:17:09 +0800
X-QQ-mid: xmsmtpt1724919429tbzim1qcm
Message-ID: <tencent_466225AA599BA49627FB26F707EE17BC5407@qq.com>
X-QQ-XMAILINFO: NBOcPERDMH3ANhqjOvm1DeQFsdKqp07qfgxDzpB49ygQAEIA/97qtGiz20yUf0
	 5C2YwHKUUE2IrBmFNS4CDIoihaZV4Er+1oWFqqlB/x/ozWqOLziTEr2oRiDL1xNGZ45L4+sTx1Zi
	 lpCj1j2Yp4WLHPbHlOtxhf2UuS0s9p3iQnQqCdHa0SNeoCxI+vbKnJueLAioqu1+jSyi485CgAj+
	 tO3VLjYe1hixv4sc2zQvOnbVlMHR1ojGVR7Zcp9vR3nkdPZJNzjDXutgc6T9axSDlJzyS0oOkvI4
	 aD8Nc7MCUy93YaC71YZH1syiqD6WSaLNQ3VLvpDlStjj67pzjT0banP77UMgZHmrAro00moEmKxv
	 LEz9qfP9iyZDXXIozcSBKhan3xb4PS1hhU+6RNfEYAJIyvhsefXu8chq/GsRK/UnovpGBNZrmzbg
	 XXLXO0CQfbRqSyAGzpes7ZPjsLpSCJhVFBQtmtkVy2gCbFtySg0IjOSkmQkD0BOGrY79MZtTxQ2N
	 pUgDf36mfWFr0nRERytAywNnzLF3YyAbDfOVGyT4X92J66LI3bFKnmfA+mw6oaCNgXN57nnekVOC
	 51xk/yYQ0j/6NQeyXvKBsg3HTmCQZJha0UF29hA9DDGqNaidlhR7oJzqtLjWiUSDg6x4W0w92v2W
	 Fq1eaZlaPFSLZdyiqZlaCj2FzOjaBUY4MQYNLnxvBNNUtIKxJ9KhJPmT0YBVtL8M9Hw1GhGWKSgj
	 VLUa+BbHP6QpZVH46tjumJlWwVCxIcX/pANi+SCz8Bvr0P7r/88u5LoGvAUFBLV1bFWHeCvCTMmk
	 i5fFV3i5XY5EoZ5jqzsM0+L3mErlqdF6NdwPG3ZzzQcQFlp4xgV2Lyw/qqjW69ylVBKT3WZSwtpd
	 x16CrP8/YiCQfzjwMOYxvDzJKOKOYkjB5ucTttsxW90ObFDWgpRdTrLc8QA4qaA1xTNEMLKIbIm+
	 JcHBeR3P/9KnEgKlYGUFhFHJVmx9t/F53rXaaEBxXJ08k3+2h7TFR//zYsVgm+UEmgYmzV0y5ykC
	 kh/0XqA3Qn8t3txI9T9VRAkLCQpy6a/PR0gXRLmsBRAPrMBM89v3qCfDyPpmzAI5BLzRHWug==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Jiawei Ye <jiawei.ye@foxmail.com>
To: ajay.kathat@microchip.com,
	claudiu.beznea@tuxon.dev,
	kvalo@kernel.org,
	alexis.lothore@bootlin.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: wilc1000: fix potential RCU dereference issue in wilc_parse_join_bss_param
Date: Thu, 29 Aug 2024 08:17:09 +0000
X-OQ-MSGID: <20240829081709.35856-1-jiawei.ye@foxmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the `wilc_parse_join_bss_param` function, the TSF field of the `ies`
structure is accessed after the RCU read-side critical section is
unlocked. According to RCU usage rules, this is illegal. Reusing this
pointer can lead to unpredictable behavior, including accessing memory
that has been updated or causing use-after-free issues.

This possible bug was identified using a static analysis tool developed
by myself, specifically designed to detect RCU-related issues.

To address this, the TSF value is now stored in a local variable
`ies_tsf` before the RCU lock is released. The `param->tsf_lo` field is
then assigned using this local variable, ensuring that the TSF value is
safely accessed.

Fixes: 205c50306acf ("wifi: wilc1000: fix RCU usage in connect path")
Signed-off-by: Jiawei Ye <jiawei.ye@foxmail.com>
---
 drivers/net/wireless/microchip/wilc1000/hif.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/hif.c b/drivers/net/wireless/microchip/wilc1000/hif.c
index 3c48e1a57b24..bba53307b960 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.c
+++ b/drivers/net/wireless/microchip/wilc1000/hif.c
@@ -384,6 +384,7 @@ wilc_parse_join_bss_param(struct cfg80211_bss *bss,
 	struct wilc_join_bss_param *param;
 	u8 rates_len = 0;
 	int ies_len;
+	u64 ies_tsf;
 	int ret;
 
 	param = kzalloc(sizeof(*param), GFP_KERNEL);
@@ -399,6 +400,7 @@ wilc_parse_join_bss_param(struct cfg80211_bss *bss,
 		return NULL;
 	}
 	ies_len = ies->len;
+	ies_tsf = ies->tsf;
 	rcu_read_unlock();
 
 	param->beacon_period = cpu_to_le16(bss->beacon_interval);
@@ -454,7 +456,7 @@ wilc_parse_join_bss_param(struct cfg80211_bss *bss,
 				    IEEE80211_P2P_ATTR_ABSENCE_NOTICE,
 				    (u8 *)&noa_attr, sizeof(noa_attr));
 	if (ret > 0) {
-		param->tsf_lo = cpu_to_le32(ies->tsf);
+		param->tsf_lo = cpu_to_le32(ies_tsf);
 		param->noa_enabled = 1;
 		param->idx = noa_attr.index;
 		if (noa_attr.oppps_ctwindow & IEEE80211_P2P_OPPPS_ENABLE_BIT) {


