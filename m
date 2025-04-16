Return-Path: <linux-wireless+bounces-21579-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C34E2A8ADCC
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 04:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 566FE3B0A18
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 02:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A72161302;
	Wed, 16 Apr 2025 02:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cv+Mcc9D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C93B15E96
	for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 02:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744769007; cv=none; b=gDFXKEbMRr89v0uZ7umxUiuZrOc1UZKaQJk3c0fq6SOYe+Adty7zjj2PuV4PUrI621apO97r/RGqdHS9QsxA12JBcmPqT9lv2YOBwTkMta0vVGSjzqkdjqazny6hHvwpEMSHFtoZwEbt8M1vn9PLKk9wKQknq9IjB+ty60PWD7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744769007; c=relaxed/simple;
	bh=jqWgydFg6Nxrga8iuOo+1D/DAwSD0PZZpA6l8kDCEAc=;
	h=From:To:Cc:Subject:Date:Message-Id; b=LCXy3f6JpN5CCL3Er99bKQG8RfPpLh/hUxXuzTimfG/ZEO5JeZsGWOydgTcswc0mywsvZxuQH3iYFteZFIOmZKEk2y8Lz4PWYz80lYdnGLrQbPIW980jjZC+hoIsxfUENcJ/NPWzdSUF3WJR2nGKDumkX5fCy3cGo19dmd0V0jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cv+Mcc9D; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53FI3VoC013134
	for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 02:03:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:message-id:subject:to; s=qcppdkim1; bh=oUXs6/gT0zqE
	YDTtq6//pBYfvpU5FJFfhhoCoQYsQl8=; b=cv+Mcc9DQ+yI/RJLNKLxaIBBi18x
	X7XqVmLfvDuD/KIy+0MSAahPmjt31kSpPIlxJOINcJYw9A862KO3g9GadH2edd5D
	/wwJ/iRfm/xIFcQvpcElo/uH6GEW8PObiau/4YZcz3iBytKu9MoBkaRkmbWInjeH
	yIClk/J+1+6Zd9J8ozNc0dzerAvFgj6ijWDFUfrRL7qxgKrx/aZiACAG9EZa1bN/
	x77w4kDrEEPJQ8ZRSpZpefQYxU8DNiqXqIbGo+Kd8y7JE6JzbwqAlvQbuZp9DKbi
	kDa1qWEmvPrPpIg0im/gEfJMx5KYhk+wQtzB/egwQAAtk5OXJAhwMVcI7w==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ygd6j0se-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 02:03:25 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2242f3fd213so50433165ad.1
        for <linux-wireless@vger.kernel.org>; Tue, 15 Apr 2025 19:03:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744769004; x=1745373804;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oUXs6/gT0zqEYDTtq6//pBYfvpU5FJFfhhoCoQYsQl8=;
        b=MaJi3uKaaCtQ8sZ0BXAayM2yAHuz0qNjBSwct5z//lBlunQ7buHmhK/qYINkLZDx4E
         nC4iHM48oS0egwGHih7OdZTvkWDhMJVXRfYRTajM4C8GzdDjFLO9Spxs00B7JewdgRZ/
         htFoJIAvokKScrFgCRKMjoUQ4f9hJDGEAOLkSSZLAfciwT3aAp7SEOgPxt0DciNpxgk3
         4YCUcQhdxrQiPcl87V9ciIuUUPN6sDl2c7gAMAKIaoS7ogSiprTizdFY0UAUmTOy3cyq
         5cdbUPqBuZDiC5QVfPUTc2J1tUvEfm6foH7ehO2PDKsF1rp0FQ2uUg+ld2Vrnz0RSxu/
         UWzw==
X-Gm-Message-State: AOJu0YxuO5lN62yvwaEaRBn+t88gIjm3GtCSenbMkvxkKN4XWDZN8P/9
	qJfcs61G9BYVMldbIgfJGJhPDfzyZ2V2CKiyk27RZ5vv1MWRO/lPUA9f/bxKfou0CqcKvGOqY3z
	F1N32u0obS/ffS9FOzXSyBxCvMag/ht77vJf1rzp8TkD2yOW6iu3WG2IY85XNgSLHww==
X-Gm-Gg: ASbGncszJj8rhZhQcB04Tt4S41GFDSkA4CWoiZBy+tXuxX9SEPAhl9isZzvlZrQEJW5
	wik14J6GCT+Kv3jsot9KyWGogjXw6y0YsGkZqm6Jxd8P7qX9LnuqBVrgLHJ4t9PgkPk1mEZVn3w
	5rOfVQCjRJGH4op2YtbJt3H4uDoSOSTbe04qrOQivQUiyhkuef82f4IZG4H5LCurQ+Ui8UubXbu
	qAYmjsn3lvQm4EEU20Kv+JYh00TnoTcNAdxfAZuKkO9388kYYgOgOTey6PwFWBt9Pl7wip+ka7l
	HkN1wfo23vi0diqVwY9s9YO+nIgrqHPHZ/GU027YBSf+tDzDTzwXfkqkrXQ9gytN4x7NoXNcieA
	KPImTxY6UmSo0d4FKNhtx5KrHhNIDnW/pI1wCcLHEH7vSZw==
X-Received: by 2002:a17:903:2f83:b0:21f:2a2:3c8b with SMTP id d9443c01a7336-22c358c5d8fmr845305ad.11.1744769004189;
        Tue, 15 Apr 2025 19:03:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwVcjY2E3/uliB2BY3uKDFb0cf+XAGREe6T225xViNYVMSw35L5LDl2ecPxyBmcHOq4bjixw==
X-Received: by 2002:a17:903:2f83:b0:21f:2a2:3c8b with SMTP id d9443c01a7336-22c358c5d8fmr845065ad.11.1744769003787;
        Tue, 15 Apr 2025 19:03:23 -0700 (PDT)
Received: from hu-nithp-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33fa7638sm2359235ad.142.2025.04.15.19.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 19:03:23 -0700 (PDT)
From: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, P Praneesh <quic_ppranees@quicinc.com>,
        Nithyanantham Paramasivam <quic_nithp@quicinc.com>
Subject: [PATCH ath-next] wifi: ath12k: Add MSDU length validation for tkip mic error
Date: Wed, 16 Apr 2025 07:33:17 +0530
Message-Id: <20250416020317.3167440-1-nithyanantham.paramasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-ORIG-GUID: _0QH9e7VKCYmrhPdq4DiN2XJzrlJEq31
X-Proofpoint-GUID: _0QH9e7VKCYmrhPdq4DiN2XJzrlJEq31
X-Authority-Analysis: v=2.4 cv=ANaQCy7k c=1 sm=1 tr=0 ts=67ff0fed cx=c_pps a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=7QbXSr-hkXkeXhD5LnUA:9 a=324X-CrmTo6CU4MGRt3R:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_01,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504160015
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

From: P Praneesh <quic_ppranees@quicinc.com>

In the WBM error path, while processing TKIP MIC errors, MSDU length
is fetched from the hal_rx_desc's msdu_end. This MSDU length is
directly passed to skb_put without validation. In stress test
scenarios, the WBM error ring may receive invalid descriptors, which
could lead to an invalid MSDU length.

To fix this, add a check to drop the skb when the calculated MSDU
length is greater than the skb size.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
Signed-off-by: Nithyanantham Paramasivam <quic_nithp@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_rx.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 96785d60d671..52ccafefd35e 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -3869,6 +3869,15 @@ static bool ath12k_dp_rx_h_tkip_mic_err(struct ath12k *ar, struct sk_buff *msdu,
 
 	l3pad_bytes = ath12k_dp_rx_h_l3pad(ab, desc);
 	msdu_len = ath12k_dp_rx_h_msdu_len(ab, desc);
+
+	if ((hal_rx_desc_sz + l3pad_bytes + msdu_len) > DP_RX_BUFFER_SIZE) {
+		ath12k_dbg(ab, ATH12K_DBG_DATA,
+			   "invalid msdu len in tkip mic err %u\n", msdu_len);
+		ath12k_dbg_dump(ab, ATH12K_DBG_DATA, NULL, "", desc,
+				sizeof(*desc));
+		return true;
+	}
+
 	skb_put(msdu, hal_rx_desc_sz + l3pad_bytes + msdu_len);
 	skb_pull(msdu, hal_rx_desc_sz + l3pad_bytes);
 

base-commit: d0bcc5eaaa611aacbffe6b2cc2fb64bfc3bdfcbc
-- 
2.17.1


