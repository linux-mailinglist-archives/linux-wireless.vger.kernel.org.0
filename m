Return-Path: <linux-wireless+bounces-27622-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CABEB97AEC
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Sep 2025 00:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0204E4A7052
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Sep 2025 22:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069AC2820A9;
	Tue, 23 Sep 2025 22:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Yqm7zph3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7561D8E01
	for <linux-wireless@vger.kernel.org>; Tue, 23 Sep 2025 22:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758665004; cv=none; b=E2iIqrvljwPbZU+K6NhZSAhtt6jdLyPHsHfLeC1b5rufUWH/EYQfxRunP6Ta/cHJfwT5zQzm5NHq3qVgjzN/7NKK2rMsAXloCZshn5504pNuJYR75cZb2LECU4p7ySwZEkICsCkaF8OCX3aDeY8YI58fe9uKxt1fJQVm8+GXXxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758665004; c=relaxed/simple;
	bh=D2wuBQycpXncni9MmrBpkPuINpYNU7pKsx+K82zQDDY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WrKDbD/bDVfBDdcULiIEXtIh8rJ9WfkpBdYOWEtUIW+5AjWMX7j+lKGXV5iT6PiioOB0fE4XUZ0uprOY5TXeEnru6AK3gujWFumIZ17nho0BkkU2O/AmNan6nmytUvyUKaZTV+2GK6jkNsXwdpa+iQYQEy4lIH8khmzwMyRBj2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Yqm7zph3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58NEox2m013587
	for <linux-wireless@vger.kernel.org>; Tue, 23 Sep 2025 22:03:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Uc1pbnhzdQKbs99YbruR9OK0hcEX16w/DIB
	cbHtd1lM=; b=Yqm7zph3z+mlv6EVIydn340IzGzza6b93moSJ4NMGgwLNkREWlU
	Mu+GDvjjYhfwwlFdCZ+8WkfQof6/ShwQmA9X5s+se6XOZ5wbUUJWAkyDOKkDKJjy
	1CScUvpoFRkQI4vRRda97vWxSUOwAwKkukR3AvnaSpsSRvWaOWvqoxjiL9ib3ppw
	Zp8zY4gg5H7hvxPAz8nDz1ttVQo51ta5l9akViCaXqW7AFYZyM/IuhY+UtZi46en
	ywf3m0FTTk52OmhB+7HWSa8Hb0Va1XnVYunOfoCl7gkkreqrNMRiX2XnRlyCUbuK
	n6Ph+UaaAaTnxSKsbhpxWA6/giXKI3mQdbg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bwp096e3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 23 Sep 2025 22:03:21 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-77f2f0c3e62so2089591b3a.3
        for <linux-wireless@vger.kernel.org>; Tue, 23 Sep 2025 15:03:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758665001; x=1759269801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uc1pbnhzdQKbs99YbruR9OK0hcEX16w/DIBcbHtd1lM=;
        b=BSSR13UJCIkXlR+Nbjx3RU+PmfmnQPpJ2/57UmSEn+yFpKI16ysj1a/J/jYhDnih8K
         mUBjkyHMIBUjHf/P6oqceAmxt8VLkRHt2uaLx78CCvUaZ+6jf1BK1sam8EApVC0j++Vt
         fvcRCLabLMOzL8B/XkZTiakIIqPfJv3dI6zxK86PI97ArkodGWhBoZz/4AQ9LhqFRXL9
         U1KyX8XMlaJOTqT/HsLRV2dLY380I4m0OCyhFPScM7mLduBI3IcOoNLc7ZMWQ6rzkZJM
         HvuzlrVV/MCR+VMliaGU9ov7M0aDl3V3fSiVnU4EccpvJs6pHEHLSMLMfIzBiMlYS3Yh
         mSTQ==
X-Gm-Message-State: AOJu0YyoTz6C8rQ5gXpZFPFYHmQlNPqWw+9jpCH32CTT34rYcEUhbDjx
	wZausD7qx4ygXxomcN8DmHiG8D9+rU1Ww0M21xyArhHeX/NlEzQBwqBnM5g2/hwk5rPNlFetRay
	rifDB8I0kAOFMRwdlGJF88HUtQ28BPzcvwGfr5Np8BalsyIPJ1C5lZgKK64VQe2LXp6USNA==
X-Gm-Gg: ASbGncuL4PIHOnFcPu8LPF4QBvW+4D1D5ZdFYH/DAMR6rhrxNZ97S+lZDRkxWLf5iGi
	ZouaWB+ULm++J5xiXc9xBnS0ALBkscQ8oC8H15B75cvRQYhpzK/eSEurGfPjooxc5aULYsw5XvH
	fIAYWDroydnfMiigqDBblFuOKhX753t2tcvkO8NYzWr40Lrv7EeDv3lAN8tsM8k63V//tMmBGwg
	YxI0HDv3aqP4X+gZpBVtuLyoCXDLCTc3TCALey8DMs4rYyMgoEnKLeKOKVGbnyzRnDbr0JN0qxC
	ckUMb0u1E211fQK9vWkjzMdTUvRS0j0hoz6QaoKaKVaVIJG8T3Oo/+iMQArrLnaVVZwp8j+uXxp
	n6Jhct2TeWyo6PYjp1Q3U
X-Received: by 2002:a05:6a00:3c8b:b0:772:5b74:c270 with SMTP id d2e1a72fcca58-77f53a84587mr4180009b3a.20.1758665000535;
        Tue, 23 Sep 2025 15:03:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEinvX1Hnftmz6nTwHZivIr39eTOTRQqEhyM1sVpp6OJZ+UGYVB63E4dDrJtLcO3INkUfbhIQ==
X-Received: by 2002:a05:6a00:3c8b:b0:772:5b74:c270 with SMTP id d2e1a72fcca58-77f53a84587mr4179992b3a.20.1758665000059;
        Tue, 23 Sep 2025 15:03:20 -0700 (PDT)
Received: from msinada-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f254f8f68sm9202214b3a.56.2025.09.23.15.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 15:03:19 -0700 (PDT)
From: Muna Sinada <muna.sinada@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Karthik M <quic_karm@quicinc.com>,
        Muna Sinada <muna.sinada@oss.qualcomm.com>
Subject: [PATCH ath-next] wifi: ath12k: free skb during idr cleanup callback
Date: Tue, 23 Sep 2025 15:03:16 -0700
Message-Id: <20250923220316.1595758-1-muna.sinada@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KNxaDEFo c=1 sm=1 tr=0 ts=68d31929 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=f__cQE-5ugF2exXfO0kA:9 a=IoOABgeZipijB_acs4fv:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: EAurCiowqKs_mxD7H-0MS3zt0VY5Kw3x
X-Proofpoint-ORIG-GUID: EAurCiowqKs_mxD7H-0MS3zt0VY5Kw3x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDEzOCBTYWx0ZWRfX6fXn4BD6LX6c
 xNXZ3swxrccpSINo7g4HbPjbkWyY+A1828Zg95FyunLERjL0QJToHNEwzw1opRibW2/7O1mQLPt
 82GA81HMvHR0/jWpFi1i0gpN2hUes0+nsxtmPyK8Uo3PPWMOZttzRgLXISuIfoIY5UWV7agWz8r
 RROj+nbqrmoQ3McHjH8p3Sn0nXlloh4w7rxRzjRUPODxtHJoaV4zfjK1Jus08SRhIKEgsAXpMzD
 ia62KCLLmiO9oTKQe/keBDtqa3DozvNsxXm5F5/YO1Q7iiFUznt2S/IAbzpHqqNcWeNc04tLJbA
 94ruoq1YzwJpr+8TOK3gqY8dOOq9224ZYdSA69IShbo88LnoQEu7LAf4fL1KNcfc11Zb7chD+As
 p/gnaTEC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_06,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 clxscore=1011 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509230138

From: Karthik M <quic_karm@quicinc.com>

ath12k just like ath11k [1] did not handle skb cleanup during idr
cleanup callback. Both ath12k_mac_vif_txmgmt_idr_remove() and
ath12k_mac_tx_mgmt_pending_free() performed idr cleanup and DMA
unmapping for skb but only ath12k_mac_tx_mgmt_pending_free() freed
skb. As a result, during vdev deletion a memory leak occurs.

Refactor all clean up steps into a new function. New function
ath12k_mac_tx_mgmt_free() creates a centralized area where idr
cleanup, DMA unmapping for skb and freeing skb is performed. Utilize
skb pointer given by idr_remove(), instead of passed as a function
argument because IDR will be protected by locking. This will prevent
concurrent modification of the same IDR.

Now ath12k_mac_tx_mgmt_pending_free() and
ath12k_mac_vif_txmgmt_idr_remove() call ath12k_mac_tx_mgmt_free().

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Link: https://lore.kernel.org/r/1637832614-13831-1-git-send-email-quic_srirrama@quicinc.com > # [1]
Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: Karthik M <quic_karm@quicinc.com>
Signed-off-by: Muna Sinada <muna.sinada@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 34 ++++++++++++++-------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 1d7b60aa5cb0..eacab798630a 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -8290,23 +8290,32 @@ static void ath12k_mgmt_over_wmi_tx_drop(struct ath12k *ar, struct sk_buff *skb)
 		wake_up(&ar->txmgmt_empty_waitq);
 }
 
-int ath12k_mac_tx_mgmt_pending_free(int buf_id, void *skb, void *ctx)
+static void ath12k_mac_tx_mgmt_free(struct ath12k *ar, int buf_id)
 {
-	struct sk_buff *msdu = skb;
+	struct sk_buff *msdu;
 	struct ieee80211_tx_info *info;
-	struct ath12k *ar = ctx;
-	struct ath12k_base *ab = ar->ab;
 
 	spin_lock_bh(&ar->txmgmt_idr_lock);
-	idr_remove(&ar->txmgmt_idr, buf_id);
+	msdu = idr_remove(&ar->txmgmt_idr, buf_id);
 	spin_unlock_bh(&ar->txmgmt_idr_lock);
-	dma_unmap_single(ab->dev, ATH12K_SKB_CB(msdu)->paddr, msdu->len,
+
+	if (!msdu)
+		return;
+
+	dma_unmap_single(ar->ab->dev, ATH12K_SKB_CB(msdu)->paddr, msdu->len,
 			 DMA_TO_DEVICE);
 
 	info = IEEE80211_SKB_CB(msdu);
 	memset(&info->status, 0, sizeof(info->status));
 
-	ath12k_mgmt_over_wmi_tx_drop(ar, skb);
+	ath12k_mgmt_over_wmi_tx_drop(ar, msdu);
+}
+
+int ath12k_mac_tx_mgmt_pending_free(int buf_id, void *skb, void *ctx)
+{
+	struct ath12k *ar = ctx;
+
+	ath12k_mac_tx_mgmt_free(ar, buf_id);
 
 	return 0;
 }
@@ -8315,17 +8324,10 @@ static int ath12k_mac_vif_txmgmt_idr_remove(int buf_id, void *skb, void *ctx)
 {
 	struct ieee80211_vif *vif = ctx;
 	struct ath12k_skb_cb *skb_cb = ATH12K_SKB_CB(skb);
-	struct sk_buff *msdu = skb;
 	struct ath12k *ar = skb_cb->ar;
-	struct ath12k_base *ab = ar->ab;
 
-	if (skb_cb->vif == vif) {
-		spin_lock_bh(&ar->txmgmt_idr_lock);
-		idr_remove(&ar->txmgmt_idr, buf_id);
-		spin_unlock_bh(&ar->txmgmt_idr_lock);
-		dma_unmap_single(ab->dev, skb_cb->paddr, msdu->len,
-				 DMA_TO_DEVICE);
-	}
+	if (skb_cb->vif == vif)
+		ath12k_mac_tx_mgmt_free(ar, buf_id);
 
 	return 0;
 }

base-commit: 32be3ca4cf78b309dfe7ba52fe2d7cc3c23c5634
-- 
2.34.1


