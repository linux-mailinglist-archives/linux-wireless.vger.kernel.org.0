Return-Path: <linux-wireless+bounces-27450-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F90B82DB2
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 06:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69529320F5D
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 04:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D08D246793;
	Thu, 18 Sep 2025 04:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="V+5Ieq6r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF88C244186
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 04:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758168555; cv=none; b=PDFP2N1BAZu6awwdqfx+/KEi/0NcP6dvVCR3CGQ2WqNfSb0Owx67ztjoh0FXp2puCLJ7+8+AFY/A99Y8yviuFFZacl6ZqV26T7gBYgVyKvW35wUYNAHjnsEgkPmV3gn1ukSiRlL4drxTifoP7ZaG8EcpDa8A1d+CTHxpLVUOvwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758168555; c=relaxed/simple;
	bh=v1RM3E+blwIXlxBl0SdqEuSUkCwztJrZBAydGsIzJsQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Gt5whsF4ty/jFQWmEO/L0BpMslM9aQpsee8VxY8g7u9+DSDOmebxRx6unH1zsKknp1lATbeGKiz++cxdZbfljMCytQOwqrPsoXixrpWhxwDdAXLcFU+Bhek6peGVWrTMF/tmShJqcrxvnJVGNrkuutOKqhBGhuBZLpZ5L8T6Dpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=V+5Ieq6r; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HIaP5v017934;
	Thu, 18 Sep 2025 04:09:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=qjXr/r2ZCmksP4n9uGkpBB
	r8knOKz6sqqB9Kvir0kx0=; b=V+5Ieq6ryW5hIR7qR8RYdoRB7b13/VE4l8FInB
	jsXo+A8acBnQgEKZ1EAPd1zOp2FyzdHUe0g7RbuGGX4xCRaOrD88g0v+06P35g2p
	lNaE9yt6DQG8v1mcNNsDd/+HF+d6zuImZ5x81FfgnEqUjQePAgzZbowDM5Kla9id
	mCsEiH9CWJab3OzI8IeeMa75L+DTH2UAs9aTRJEzvzsPaC1aCSlX2wAOGvZ1n7H3
	lqN/QZaFXtQdRB4FVM5KLYzucNB9wc2IQQ9o1tHSk52oKsx0oJxUAbtK6ziaKWfo
	gjeLceIoMjO3oM1hm6ncFNlC93JhtEDcWdKl9ER+Ba62lndg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4982de9c9r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 04:09:08 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 58I497hP016409
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 04:09:07 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Wed, 17 Sep 2025 21:09:05 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH wireless-next] wifi: mac80211: remove tx_handlers_drop debugfs stats
Date: Thu, 18 Sep 2025 09:38:46 +0530
Message-ID: <20250918040846.4032734-1-quic_sarishar@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=YfO95xRf c=1 sm=1 tr=0 ts=68cb85e4 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=stkexhm8AAAA:8
 a=COk6AnOGAAAA:8 a=2Y5QkluZrtKIm-oZjmMA:9 a=pIW3pCRaVxJDc-hWtpF8:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: c26V6fUOodFityOeiC_VD_MblSNqscAK
X-Proofpoint-ORIG-GUID: c26V6fUOodFityOeiC_VD_MblSNqscAK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDE4MiBTYWx0ZWRfX5utq8YK5/XGv
 UQi6pMNClmFwcPCjESmEnJQa8Z5asYYF6Yd4DfHeInfMp0BtkPgfMPuET3kNWYVZRJPNerOfg0s
 NP8DuCKrkjAqpWQBYtOshBzIrQg/8g8rJad3T0xmk2n/nSMXX2l4ME4rl+nOWD4IECZf8aXKeqH
 ibFHB8uPlGyQcWW8sJhn2W6mkiAm3Jl1kIBjxe3Xuh9r2lMqOgLonJ03+RvsLxhfap3WkK607Rc
 0iuGXkF+++8Xh551GQNA6ybTycQxT3lwcWD3cWaAgv88snFX7h+c9lFpeF+Vl5zqgSu+YCWsyZ8
 E/5tbtNFntD+3NTAbzmmUB3O/ngRLb3gPBo3LtuX7zDRTzRttM4ixf1/J0U+B668DmbK7UZgCPp
 a+3K5bDX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509170182

Commit 906a5a8c7152 ("wifi: mac80211: add tx_handlers_drop statistics
to ethtool") added a tx_handlers_drop counter to ethtool stats.
During review [1], Johannes noted that the existing debugfs counter
is now redundant. Remove the debugfs stat to avoid duplication and
streamline statistics reporting.

Link: https://lore.kernel.org/linux-wireless/ce5f2bd899caa2de32f36ce554d9cada073979c0.camel@sipsolutions.net/ # [1]
Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
---
 net/mac80211/debugfs.c     | 1 -
 net/mac80211/ieee80211_i.h | 1 -
 net/mac80211/tx.c          | 2 --
 3 files changed, 4 deletions(-)

diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index e8b78ec682da..0528ddfc7bb8 100644
--- a/net/mac80211/debugfs.c
+++ b/net/mac80211/debugfs.c
@@ -717,7 +717,6 @@ void debugfs_hw_add(struct ieee80211_local *local)
 	DEBUGFS_STATS_ADD(dot11ReceivedFragmentCount);
 	DEBUGFS_STATS_ADD(dot11MulticastReceivedFrameCount);
 	DEBUGFS_STATS_ADD(dot11TransmittedFrameCount);
-	DEBUGFS_STATS_ADD(tx_handlers_drop);
 	DEBUGFS_STATS_ADD(tx_handlers_queued);
 	DEBUGFS_STATS_ADD(tx_handlers_drop_wep);
 	DEBUGFS_STATS_ADD(tx_handlers_drop_not_assoc);
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 8a666faeb1ec..f49e9d858776 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1608,7 +1608,6 @@ struct ieee80211_local {
 	u32 dot11TransmittedFrameCount;
 
 	/* TX/RX handler statistics */
-	unsigned int tx_handlers_drop;
 	unsigned int tx_handlers_queued;
 	unsigned int tx_handlers_drop_wep;
 	unsigned int tx_handlers_drop_not_assoc;
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index a27e2af5d569..d405927d1ded 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -1815,7 +1815,6 @@ static int invoke_tx_handlers_early(struct ieee80211_tx_data *tx)
  txh_done:
 	if (unlikely(res == TX_DROP)) {
 		tx->sdata->tx_handlers_drop++;
-		I802_DEBUG_INC(tx->local->tx_handlers_drop);
 		if (tx->skb)
 			ieee80211_free_txskb(&tx->local->hw, tx->skb);
 		else
@@ -1860,7 +1859,6 @@ static int invoke_tx_handlers_late(struct ieee80211_tx_data *tx)
  txh_done:
 	if (unlikely(res == TX_DROP)) {
 		tx->sdata->tx_handlers_drop++;
-		I802_DEBUG_INC(tx->local->tx_handlers_drop);
 		if (tx->skb)
 			ieee80211_free_txskb(&tx->local->hw, tx->skb);
 		else

base-commit: d103f26a5c8599385acb2d2e01dfbaedb00fdc0a
-- 
2.34.1


