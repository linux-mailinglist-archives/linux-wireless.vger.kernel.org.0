Return-Path: <linux-wireless+bounces-25365-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 519A9B03D16
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 13:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E76E16CF6C
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 11:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E2D2367D1;
	Mon, 14 Jul 2025 11:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T4tQwfc5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245EF1DE892
	for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 11:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752491769; cv=none; b=MHDDfLrKDntauj/52/PLZ8cJbac6UphHDLbcQmb2xE2hGSHe4wuyhJFsf7KOLWHsErWm5UjjDBmC3Ur+kIEyZzneODhJ+AJVBRLSvdplBP0V0L0ACLcGtHkYOuQwSPEtVKIdu/WIq9LnLcHTVw57hBJFZUXHLJKt937kCMjiF0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752491769; c=relaxed/simple;
	bh=hKnuJ2m4c5q5B+aSglUS2hu9NLHP0rtdb7MK7tOOMeU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QnOWfVqOFv1jxpGLl05/xZtm1PJkUos1rZDp8iSELWblbfmYDeTThj1psiJl1WiK8qwRFaPJ5Zt3AZPgCq5Go6Ft6qq/xXEukzF9rS7uOvWYtBIKWEb257XqOqa4mFpkVrE+LHpQhajiYgkoY/RIbldv6ATAKtZJYXU+oGEybuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T4tQwfc5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EA515j000421
	for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 11:16:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=dG+nMKWZ6wjAGzgGQE8bbK0jnDA48BfrJlJ
	t6VGsyR4=; b=T4tQwfc5EFSbNPp3P68WrDLXJFVtvJA/ol33mP1KXE/aqK4CHBm
	WPxQmHgqhYKuW7r5usoCJTNHx15+70lHogGqeP/m6M2EZnDF2o8+LAoNVObWLSgX
	3WBoCST53hQiZPZ3oBFF5krKFDaplRxJR4RJkPCvN9zFpnzlZBKQW0feoQIcQHLI
	fkArF5FyjBXlyiQB45lmqHoLDvUToNs5iVY0v4qdx1k59cAhZEGUqTgumLMZ8JWC
	jByRRKodEXEHhkZcb/Lb9Zw7Z1B1Z2UPF94An64f6QU9NB2RKqnqTdj/yus2P/Dj
	iPWb0hYZ1DQtiQWtuuRCUupfKOdhOL/OKWQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufu84dx4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 11:16:06 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3120682684cso945088a91.2
        for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 04:16:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752491765; x=1753096565;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dG+nMKWZ6wjAGzgGQE8bbK0jnDA48BfrJlJt6VGsyR4=;
        b=i+Vf63qG8/P1gzeDXh2hlN+vF6IO3XRQWaysuLR+xhqP4Y/XZWVqqklQ00z7KktTtH
         IwSUbK2/tis5C9YFpYtnIX+mYInvqt847dTT0IbPv8g+Bk1OfNqrwFHqkaJ4ghbDPfI6
         YqylzkTTn9WFRrnV6i1CX5vKQpOBccqEy3qpi6oVojmPXa5iqimoSIxqXaEuTvzZ9Y1C
         8VY+GYba0GR5egC+0VNGKhBPWeY+oVZYrQb/r3AJyzwZVDfTM/isSdtRRnPIuQVq/lF3
         8vFYegGZtgdL09GHngB/BnVK7WmtTiU9H6NNT9V63ryx6hFgJiTFwwBa0Yuzku9Zp/6e
         Xcdg==
X-Gm-Message-State: AOJu0YwUpwmHheJjoH2RVwtXfpPvC38cvtCZcVNrN/LBQg29P48HoZuG
	BwLPjMJP+LlLfrKtYKuEhGaB5sik+enD9AynEOkpy6/TwnCczGk33qoBgksZiUbsq7GG1KIVpuD
	oOHU/f0u2fFMKV9pD1OYT/83LCdnHLm1ikzKOmRUj2VGBskgwI2H6S6jd+z8sl/HDK5xcRg==
X-Gm-Gg: ASbGncuBdpBUKpqjuGd2F/mUPms7m7ytnTBZQ5tsRqMNThNAG+a5gAEP1rVWYwRauUz
	q+CxQ/bCc0RzRyWLWKuTEBvtJPcPd8Jf7ep8b9ZHITgrbhkGrggzlKpTAAECbVDadwt2w/mvIEy
	ylFDquDdxe2YMZ4303Czay3qslG9iC/VTGOZhZ+a6eCPjPggVuhQPsTJiUSeV8SVbKjavN573rM
	XtU4wD0x275CkHoq4nFRbfFmkiEaH2wmWERhLfg6QSODzxu9f2Df/GhIBw8yf+cgeqTkUklG2W7
	yN1NZtGLRI2mnwfiKjzyfUXkmUHv8gTimr67OO0dYsRe7DJKoeasppOPuihW8W8SL3uKxSa+i7H
	XLkzSAbKV8OFo1nZH9COqQg+zrR8wB4m20t6bVxZO/RL6aC/tGUJJpignCXNf9A==
X-Received: by 2002:a17:90b:3cc8:b0:30a:80bc:ad4 with SMTP id 98e67ed59e1d1-31c4f37b71cmr7265742a91.0.1752491765380;
        Mon, 14 Jul 2025 04:16:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHv/OlClj0gEg6nmhE3nbbzGQ6uf0+3P/T4VFdgktuSZauGzDCYeKjceM50MdLjmzzd9ZSqbQ==
X-Received: by 2002:a17:90b:3cc8:b0:30a:80bc:ad4 with SMTP id 98e67ed59e1d1-31c4f37b71cmr7265722a91.0.1752491764819;
        Mon, 14 Jul 2025 04:16:04 -0700 (PDT)
Received: from hu-nmaran-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c301ae5fesm13225269a91.38.2025.07.14.04.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 04:16:04 -0700 (PDT)
From: Nagarajan Maran <nagarajan.maran@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Sriram R <quic_srirrama@quicinc.com>,
        Nagarajan Maran <nagarajan.maran@oss.qualcomm.com>
Subject: [PATCH ath-next v2] wifi: ath12k: Validate peer_id before searching for peer
Date: Mon, 14 Jul 2025 16:44:38 +0530
Message-Id: <20250714111438.1134438-1-nagarajan.maran@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA2NiBTYWx0ZWRfXyR+DeWOyx2Ya
 QLkYY9suM8zE2W6iB/i9QWfbX2umTHFbTKOLWDXBkPlWuyJx/729Kh0WkAiq313s2jiztWvetvu
 nLUjvWx4JgIaPla2oj6LzYDvjcGK07s+KSEALB6JFwEzYVQWBUPILqMYHxsCrpoog90FHU2ZXLG
 DtXiC5axLIEei8fNif8GNypQ2oqpE0waszXtS9twgwZBPAFIruErb56VfhXyy0SHOpClJtJ4pV0
 2bJneL6bjx264iFgVkaCVYMI95s+3RubJKTVktsx8yc9G2kYasdhnNqR7WrbK3vsnJ6egiOwAs+
 OTeugytUT4Qu/t1IDUekOezQ/6LJly5O8nqGQaG0DjjzVtggiQnXFZMEsN7L3aVmsqaBZkXtYMD
 NC94TCspmpSmW6Q5HEcW8jvZre5ddnnLzMt9swtbyJyM0GBISJzSbJQnUEC5fE7lPnk/WGFH
X-Proofpoint-ORIG-GUID: 0ZFyUW7603v4xieTaDEpks1Oa_Omi3zA
X-Proofpoint-GUID: 0ZFyUW7603v4xieTaDEpks1Oa_Omi3zA
X-Authority-Analysis: v=2.4 cv=f59IBPyM c=1 sm=1 tr=0 ts=6874e6f6 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=0KvMerAzGZTWNi1JVVAA:9
 a=iS9zxrgQBfv6-_F4QbHw:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=801 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140066

From: Sriram R <quic_srirrama@quicinc.com>

In RX WBM error path, error packet is received with invalid
peer_id (0x3FFF) as there is no peer associated with that packet.
However, this invalid peer_id coincides with the ML peer_id valid
bit mask, causing an unnecessary search in the ML peer list.

Prevent searching the peer list for invalid peer_id and return NULL.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
Signed-off-by: Nagarajan Maran <nagarajan.maran@oss.qualcomm.com>
---
Changes in v2:
	- Corrected Signed-off-by tag
---
 drivers/net/wireless/ath/ath12k/peer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/peer.c b/drivers/net/wireless/ath/ath12k/peer.c
index ec7236bbccc0..1a098cb22933 100644
--- a/drivers/net/wireless/ath/ath12k/peer.c
+++ b/drivers/net/wireless/ath/ath12k/peer.c
@@ -100,6 +100,9 @@ struct ath12k_peer *ath12k_peer_find_by_id(struct ath12k_base *ab,
 
 	lockdep_assert_held(&ab->base_lock);
 
+	if (peer_id == HAL_INVALID_PEERID)
+		return NULL;
+
 	if (peer_id & ATH12K_PEER_ML_ID_VALID)
 		return ath12k_peer_find_by_ml_id(ab, peer_id);
 

base-commit: 7e22b60a8af12b81ff3d416ed4e7d21fb98e9f25
-- 
2.34.1


