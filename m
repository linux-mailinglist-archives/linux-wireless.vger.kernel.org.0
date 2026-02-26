Return-Path: <linux-wireless+bounces-32196-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULcXO8vJn2lwdwQAu9opvQ
	(envelope-from <linux-wireless+bounces-32196-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 05:19:23 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 94EA71A0D47
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 05:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 01778303B92E
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 04:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB74328B75;
	Thu, 26 Feb 2026 04:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E0qEgyo9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RH7l5cWf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8951FE45D
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 04:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772079561; cv=none; b=ogbmEn/oLW7KsmPPjIRuMUda58C0IxFSAiuASgoK2YGGV/XPgpX2wpAFaiZIFHOkObeF1wDS4YveEaRncbRVSu8VsZZNHzBUDeYDIURfiI5hlef2067Cv7+4tLN6cOX0AW7xWwbitJ0SILwKlareskKP2VMG/SY7uwCfkM5cBpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772079561; c=relaxed/simple;
	bh=yQCfS+AWUYuEVzuHBb/WrX7PjRiGUB8t965WPm7YqvM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VUX38UrHzvlfWnB3entgSvBLsp+wTn7oZTJDRnjwosCGHbzV8uh7qzy4KJqjfn2AR+fyvTfAaVAH4peamC5EiPOB/kOS/FBX5dZcQX0P5IHpjRHqAomEuWPvnVsYjNLSj51+eAeWngI3XL1G+elyUW60qQiy6DOWbrrKipn/4Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E0qEgyo9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RH7l5cWf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61Q3lHBd3101023
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 04:19:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=qMgNgj2OchRl6KrTChErc9AIPXNOheHylxI
	ayzOk3Kw=; b=E0qEgyo9lS+bQwHbhKHXv2SoPsRaRJBaaB0b88o9BSjrhDGnvJy
	wo1VV31TGfvcrwJIhk5urRUneqmtxOG7eL5hnu7yoAZQ+ovKOiHGmh7QIGLBNhDd
	xKfa2Aw0+XydIh2txqCntb4TwdMydS1On5jaaHPJyggkYPtz9cuobyTdT4A7a/jp
	qlfJ3MRAGzD65XeDPaNiytQFMIw1PbDlwBSrLvG1mJBD4Pb0WP8Nr4GG0Om6LLXe
	v1UXZ3BrmtAFnm7v9Zwf3hkv5uA0SY71L5D22dzYP405s3iDB7z8I3MYCgmcvIKv
	fa4/qQr7agcB6ZW1TM9bp84z7t1cwmbgcVw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cj54p9rmb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 04:19:19 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c70eb4d56fcso258156a12.1
        for <linux-wireless@vger.kernel.org>; Wed, 25 Feb 2026 20:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772079558; x=1772684358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qMgNgj2OchRl6KrTChErc9AIPXNOheHylxIayzOk3Kw=;
        b=RH7l5cWfExguUT2AduHuey3yXMfm2WKIzxGH7Nf/oTpxIHmKC0L047Zo2Cf1o3rx+s
         qdUkFONdUcF/fNGFqQtf3m43ABEw0NCJctBDFCz7f53yPQKEH61U85fWnDFT+sg7BQYe
         uIzqxYjWR22FjCiyKY7y5AohyUe0NdL1Pii+D5VB1bqQxG+jKj9oY1AGhV7vDK6Mm0oN
         7qVIPSz8xQdKUxYowirywvh22oPt49ZHeJ5Wkx3z3dEEtzS77KiB4FBYkFnrigLcqAjn
         EYCTHgrqW9O5GpFUrtPvv1wiXNeRkbRIYjyEXjcJoEnTpFMX398mR3zyEu+qWxwKsaiO
         orxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772079558; x=1772684358;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qMgNgj2OchRl6KrTChErc9AIPXNOheHylxIayzOk3Kw=;
        b=Bwuo8EF1Vb4LwIDvQEb/bZnIW/L5owGQXhupLRI3zQi3PuZyt5TUqKFYLW7D7It8hW
         eeCJ3w/vpZu6jumCZkQcsY9Pe2kOlkMwsvPipTYlM9A7o2sIbuwUHbxs7CiMp/1OF+yc
         YR85iK4FvwDEhsdx0FDzMecfOHBj9dQQ3cgE+yIqBxF1YNaTmDCUsipuj2brDZ8Nw7SF
         43YzofnFrpBuo4PYRzFJFterkGkCxZGv12FbXX4e5OCF6HMJoI/J7g6nhiDjkAhF59PF
         Ukq+tjOk2hl84W/zBVikusVCJc+tPEae3R06kR+01pKzfTRFX8QD6r0//8aajI6XUBTj
         RQUA==
X-Gm-Message-State: AOJu0YwOue0yOTkwM3KzMCelgSUdCwCxQI/c96wp3L/cfaVSXNm6C6+7
	dNAo2/6hqNBlz/qtAY/xVJ3RcRhvz8wSXD0id6mojQcGv64OBnRqU6rnex2313qJ4ss6r0mvPYa
	FUr78TflXiXT6IFTyOCFEHmxFkkT7gvzZYrOqT/1g/pmCI07m28R5U0dkXx5EeU4cWGZJJQ==
X-Gm-Gg: ATEYQzw6qFzDPtGaZqzZvviz8NnWzsYsQplavWK0neoniUlbJ4444nT9L3D7HbZpmuT
	ldNW+xnHL6JZAkUvHqdZrYhkBMBok8vcdE34y4mH3rEqRYUIBsSA6zURvdOhWWSgtT9jiRv06fw
	XOdFiijV1AI1iCTkXNnCxF5RG9qbSALfuPJFWZrRU3s2FoHsomPrVYM9GJgTmIVhksnFZeXwPYv
	hZzfuEuSaRY+wMisyAXiBdXiHhl6Igr1nW8zwWRzTmxDVEtGU1BhxohT/47JexAV49XgQT4dxjb
	4U1IBL0NhHaWWU810iGqceUd4JUBdltF5PyBT2XeKdqBtFd8v4pjjXjijavgQMWwjEttIYEWfXH
	aHsI7Pm0QLof2NQlrKyXrYJMHSIYLsy7aVzGaIB9FVaZnLfd0f++muHKKUqs9A+DthboCKyWhHd
	h8XgThAhtccU4ZwrkIRvAcNso5Lncxzio/JKuefcP7Jz+m1k8Q
X-Received: by 2002:a05:6a20:6f91:b0:38d:efcb:2e84 with SMTP id adf61e73a8af0-395ad0f10b1mr2558576637.32.1772079558026;
        Wed, 25 Feb 2026 20:19:18 -0800 (PST)
X-Received: by 2002:a05:6a20:6f91:b0:38d:efcb:2e84 with SMTP id adf61e73a8af0-395ad0f10b1mr2558547637.32.1772079557508;
        Wed, 25 Feb 2026 20:19:17 -0800 (PST)
Received: from hu-rdevanat-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa5eab4esm522145a12.6.2026.02.25.20.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 20:19:17 -0800 (PST)
From: Roopni Devanathan <roopni.devanathan@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>,
        Roopni Devanathan <roopni.devanathan@oss.qualcomm.com>
Subject: [PATCH ath-next] wifi: ath12k: Fix the assignment of logical link index
Date: Thu, 26 Feb 2026 09:49:11 +0530
Message-Id: <20260226041911.2434999-1-roopni.devanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDAzNSBTYWx0ZWRfX/p/ceBjIQK+l
 JoFeDwhib/tsVCz+/8dpTxK/VN7Qtwme6sEcu/EfPp98B23nBHBy87/u8KmGMGlO13dM9zfcQQf
 PNiagMjoFJPxqft4WaRXbt9Xq+k4d0N78NdAcRCmFGDe8qZyc62Mw1XS/BFGirAW05/YRZyk5n8
 S2yE1gr8jLBekmMy8C4mn9S74elM/ta93BMdKGe61P9NZ5AE/sKyGh2K3UcI38ghZL3LuA5JpRS
 PvZ0nhE0U6oLs6BfN2ugqVnj7Cm8CrV27yistYg6xyl5TK/dQ0pSR8OC6WK24GglKcVwYzxZoDV
 Ihr5AyOuYoC3xeXHCGAu+pT3+qanp8lUFvLPQlFtAXWT4sIS+ETkDK8/Eb7PZ2tutBQ2ei4ToxG
 agS3Y1QeeEBgS7g7OwvE86GWYqOTiZmdQoybbSVLY7OoqQkJ7lVZurMQRYd7lbk4n8L7TOWizXl
 eOy65dbaAF1gIuIiAxw==
X-Proofpoint-GUID: xCOJpfpy_rGileBhZrsxfh22qnPzZb8A
X-Authority-Analysis: v=2.4 cv=I5Bohdgg c=1 sm=1 tr=0 ts=699fc9c7 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=KoRwW9U0jdfTxXC0uPgA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: xCOJpfpy_rGileBhZrsxfh22qnPzZb8A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-25_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 adultscore=0 malwarescore=0 impostorscore=0 phishscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602260035
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32196-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[roopni.devanathan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 94EA71A0D47
X-Rspamd-Action: no action

From: Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>

Per-link logical index is assigned from the global counter,
ahsta->num_peer. This logical index is sent to firmware during peer
association. If there is a failure in creating a link station,
ath12k_mac_free_unassign_link_sta() clears the link, but does not decrement
the logical link index. This will result in a higher logical link index for
the next link station created. Also, if there is a leak in logical link
index as we assign the incremented num_peer, then the index can exceed the
maximum valid value of 15.

As an example, let's say we have a 2 GHz + 5 GHz + 6 GHz MLO setup. So the
logical link indices that they have are 0, 1 and 2, respectively. If the
5 GHz link is removed, logical link index 1 becomes available, and num_peer
is not reduced to 2 and still remains at 3. If a new 5 GHz link is added
later, it gets the index 3, instead of reusing link index 1. Also,
num_peer is increased to 4, though only 3 links are present.

To resolve these, create a bitmap, free_logical_link_idx, that tracks the
available logical link indices. When a link station is created, select the
first free logical index and when a link station is removed, mark its
logical link index as available by setting the bit.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01181-QCAHKSWPL_SILICONZ-1

Signed-off-by: Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>
Signed-off-by: Roopni Devanathan <roopni.devanathan@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/core.h |  2 +-
 drivers/net/wireless/ath/ath12k/mac.c  | 16 ++++++++++++++--
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 990934ec92fc..5498ff285102 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -522,7 +522,7 @@ struct ath12k_sta {
 	u16 links_map;
 	u8 assoc_link_id;
 	u16 ml_peer_id;
-	u8 num_peer;
+	u16 free_logical_link_idx_map;
 
 	enum ieee80211_sta_state state;
 };
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 68431a0e128e..db1b098b67d0 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -6784,6 +6784,8 @@ static void ath12k_mac_free_unassign_link_sta(struct ath12k_hw *ah,
 		return;
 
 	ahsta->links_map &= ~BIT(link_id);
+	ahsta->free_logical_link_idx_map |= BIT(arsta->link_idx);
+
 	rcu_assign_pointer(ahsta->link[link_id], NULL);
 	synchronize_rcu();
 
@@ -7102,6 +7104,7 @@ static int ath12k_mac_assign_link_sta(struct ath12k_hw *ah,
 	struct ieee80211_sta *sta = ath12k_ahsta_to_sta(ahsta);
 	struct ieee80211_link_sta *link_sta;
 	struct ath12k_link_vif *arvif;
+	int link_idx;
 
 	lockdep_assert_wiphy(ah->hw->wiphy);
 
@@ -7120,8 +7123,16 @@ static int ath12k_mac_assign_link_sta(struct ath12k_hw *ah,
 
 	ether_addr_copy(arsta->addr, link_sta->addr);
 
-	/* logical index of the link sta in order of creation */
-	arsta->link_idx = ahsta->num_peer++;
+	if (!ahsta->free_logical_link_idx_map)
+		return -ENOSPC;
+
+	/*
+	 * Allocate a logical link index by selecting the first available bit
+	 * from the free logical index map
+	 */
+	link_idx = __ffs(ahsta->free_logical_link_idx_map);
+	ahsta->free_logical_link_idx_map &= ~BIT(link_idx);
+	arsta->link_idx = link_idx;
 
 	arsta->link_id = link_id;
 	ahsta->links_map |= BIT(arsta->link_id);
@@ -7630,6 +7641,7 @@ int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
 	if (old_state == IEEE80211_STA_NOTEXIST &&
 	    new_state == IEEE80211_STA_NONE) {
 		memset(ahsta, 0, sizeof(*ahsta));
+		ahsta->free_logical_link_idx_map = U16_MAX;
 
 		arsta = &ahsta->deflink;
 

base-commit: 62f9b9b19939138c34ce0ac1e5d4969d617ecbb6
-- 
2.43.0


