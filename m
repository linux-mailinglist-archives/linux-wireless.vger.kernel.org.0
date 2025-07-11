Return-Path: <linux-wireless+bounces-25242-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 795B3B011C8
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 05:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52C231897B63
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 03:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36ACB19F130;
	Fri, 11 Jul 2025 03:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oHKJlgjo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7378F195B1A
	for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 03:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752206069; cv=none; b=hWZB3PRgjQjriaXjGhzFZdPUNro2DB9FNlAp2Z+ga+e+Bu1eXQn9/D+Q1aHh/uUOeZVUdvp0iDNfw3xPC0/6C1hXuLPWLBU6OlExnkPJMWNqZt79InkqDgcPxNMA6n3rMU40m9OJePwtAh60GoOBxBTebs4sF1sRiE6SqXMRku8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752206069; c=relaxed/simple;
	bh=qWE+fDx7coJWODyqvzFLh1+LoYyA0KOL+DjKUGO9p2U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=vB6KewenBrc5VWDyOQvnG7QQlMKnDK0m7DP2aZ77fsnNqa6Erbues6Hn8a1E5yAz9WspBhh0yP3cBRaKKou+CzxptuIMzz70iQe2La0g8dwYmvDQ2JyF0DcxHA2gi16nEbgmsjy9pCPPMId84qbZhqfdhj7HSnh+62dr+htgUcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oHKJlgjo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56B1X7SS029937
	for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 03:54:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=0rDiNYqRIxxdKLlgResYs6wz+SsoXhWzio/
	nAwtikfg=; b=oHKJlgjoWq7lJ2VQlvWT5VcNHa75uy0NhyWOfUO/urWka1geMxs
	rGte/2TBpNEqobc+lP4AOFEvjotZIvciTyqRjAxzpmGTG/RgcWrKZBHJYnkeXWcu
	GHrA+LRL0l95yTN2lNTKuZXfCjHqxXC95Ys9Y5MZg3R6D5NeyebLDH3zzKOpDCLA
	SycMOEGlsKXSoKbivfl5c+cYJMZHBLKQv+ddrLScILexfV9xb06KqqENZ1U94l+P
	ygg0DsHQpCLwxr03OehLyLEhDat0yD+SIY/dPlZ36MS5XjmQT003GSU0e0gY+tnl
	hAiOOjHZoF4LKIUMEIcPd1LoS65RdUUDuvA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smbeq8d3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 03:54:26 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-23507382e64so16806705ad.2
        for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 20:54:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752206065; x=1752810865;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0rDiNYqRIxxdKLlgResYs6wz+SsoXhWzio/nAwtikfg=;
        b=iP6jr9nVf23j4nzEzLCBVFbSesO4HrvNWYRGcrM7gtnt2/Vt+FHD6AYSMDjnaVpWP/
         k3Cpu70qpjCV+54lwXJy1/11RSVjLmFa26da73FGWhdqxUszcRNWLFnjUdTXFLTy7Qa9
         Mv6zBusYtFHp4is99tOUNxc2UTJUa7unXGLc7KOAss7nhdxnqOXtDBG7x09+NWF6xN4t
         KVdpR6jlZQLdwFIb4qX+xIFuxv7a5SgKbY7aTC7gU6vuLCgWPhaYc5wy0Vg73aIijYgi
         7/iSY8p4epPu4DE9hlT2GOfIwcrqD9KUoN5xCB8/pxy61cO95QqM9l135+55+tBPGzrX
         FCWw==
X-Gm-Message-State: AOJu0YzTx6H8XryDP0j/ddIjTRGJZOqPI/1LM3dOE5ImBChP4TgJ9Rvz
	SFva1JUKhGxLjpNgIRVfjFHLlstsRAoSUat9wpbG8M5pGLRF+LUzZzpdMpTVv48l7MRsGEPwfBz
	BmSzXh79g1QlpG0rmi530GCE5vBZtceTxqyM2H4bmO6ACCbA2/0yki1zHtnOuP5/voUy3Mw1UlB
	Iqxw==
X-Gm-Gg: ASbGnctHpSjcyPBOWcMDsFwRXC1BOAY+DLn8yh2Iej0Y2LTr/YAoko6VWVC1QnAFQwS
	rQRSjAvQV62eW4ztsuiYYihQDL25bzkzO+WjkBZAsjDpgQAK47W2k8eXlGiHl40rlhN8rPj+SVr
	4UCmyu2xwhQVwNuSzFem3Z8aZ4WZAsOZXI6+FSfk+FbK4vyHl+rZeea5dKZnNkjX3FTCTK/XWry
	QcyO3/DI5IJuWSUNuOTtfPAFs23Otlh6UxUPVMVMTQVtVuWC3QYQO4y2kFhj4GL3o/Iyw+4cq3C
	zIJdoatesvwPf3zHfd6a5frZGjVhkuASAcMCwe7F+Tq54V4WUeNbQDwLXO6PRTKE7TBDG7c+Etn
	JRhOoIXly7FJZlK/SGWCBesghNpVATJQM0tSoNCk6o/k/UTp8D9Bo7pyuVeqFHdk=
X-Received: by 2002:a17:902:db0d:b0:232:59b:58fe with SMTP id d9443c01a7336-23dee188917mr27510955ad.1.1752206065238;
        Thu, 10 Jul 2025 20:54:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyl6CXQ0tPOFGk7bRBeDKH7D1Us/qoeAmGvTAxvCVFhFU5ynuL7qB0MY/R1EA6oPs6a/HUxg==
X-Received: by 2002:a17:902:db0d:b0:232:59b:58fe with SMTP id d9443c01a7336-23dee188917mr27510625ad.1.1752206064807;
        Thu, 10 Jul 2025 20:54:24 -0700 (PDT)
Received: from hu-aarasahu-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4287217sm34793605ad.9.2025.07.10.20.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 20:54:24 -0700 (PDT)
From: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
Subject: [PATCH ath-next] wifi: ath12k: Use HTT_TCL_METADATA_VER_V1 in FTM mode
Date: Fri, 11 Jul 2025 09:24:20 +0530
Message-Id: <20250711035420.1509029-1-aaradhana.sahu@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDAyNSBTYWx0ZWRfXza8ULzWMFKW5
 l/7uLYWRyqyURQzEnxJS3oO5sV8DhGg91y1dAjPSXLeLbGrTk612nfBivby4PECTJgmfnRm/vwK
 cM223sGsRwL4MdGNK9W43eSKHO0Lkvl8FLXVpNhicEHu5hd79MIbSzsOsBvxDtOFJuQxlNea+5f
 RnsMwgifAdxYL7OdkTkePa3t3Wp0oXg8qfl3YilkYWfphD4X7XLH14MdYn63TyWKEXPfTv83Keo
 NhRf5kAJtt3QvT1kLXPWvAavlgpDax8akGofnDm9PN2+/GbIrsqdzGALMUWcI2IjI5w0SQBpu7a
 0sDge6y8OWnJBGA0tkKQCvNkfEi89ZvvyqIK+3momm8qf2I2gsmB71Yt4mKywIreT+vqQIHore4
 ayW9jCzCiJRXbEZ21RJt7VaBt2pDI4mbVyfYtljlaO2P8iLY128w4PGrQ9VHGndGqKsVX8lm
X-Proofpoint-GUID: 4lzMMnjOrTVtXg5DGG9Lu60Rwf7d1eZA
X-Proofpoint-ORIG-GUID: 4lzMMnjOrTVtXg5DGG9Lu60Rwf7d1eZA
X-Authority-Analysis: v=2.4 cv=VpQjA/2n c=1 sm=1 tr=0 ts=68708af2 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=EiwlDgHpknFOdVPVacUA:9
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 suspectscore=0 clxscore=1015 impostorscore=0
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507110025

Currently host sends HTT_TCL_METADATA_VER_V2 to the firmware
regardless of the operating mode (Mission or FTM).

Firmware expects additional software information (like peer ID, vdev
ID, and link ID) in Tx packets when HTT_TCL_METADATA_VER_V2 is set.
However, in FTM (Factory Test Mode) mode, no vdev is created on the
host side (this is expected). As a result, the firmware fails to find
the expected vdev during packet processing and ends up dropping
packets.

To fix this, send HTT_TCL_METADATA_VER_V1 in FTM mode because FTM
mode doesn't support HTT_TCL_METADATA_VER_V2.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.5-01651-QCAHKSWPL_SILICONZ-1

Fixes: 5d964966bd3f ("wifi: ath12k: Update HTT_TCL_METADATA version and bit mask definitions")
Signed-off-by: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/dp.h    | 1 +
 drivers/net/wireless/ath/ath12k/dp_tx.c | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index 6df07b23b705..03cafd745c0f 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -469,6 +469,7 @@ enum htt_h2t_msg_type {
 };
 
 #define HTT_VER_REQ_INFO_MSG_ID		GENMASK(7, 0)
+#define HTT_OPTION_TCL_METADATA_VER_V1 1
 #define HTT_OPTION_TCL_METADATA_VER_V2	2
 #define HTT_OPTION_TAG			GENMASK(7, 0)
 #define HTT_OPTION_LEN			GENMASK(15, 8)
diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
index 1fa37cda1046..f568ea16eed8 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -1194,6 +1194,7 @@ int ath12k_dp_tx_htt_h2t_ver_req_msg(struct ath12k_base *ab)
 	struct sk_buff *skb;
 	struct htt_ver_req_cmd *cmd;
 	int len = sizeof(*cmd);
+	u32 metadata_version;
 	int ret;
 
 	init_completion(&dp->htt_tgt_version_received);
@@ -1206,12 +1207,14 @@ int ath12k_dp_tx_htt_h2t_ver_req_msg(struct ath12k_base *ab)
 	cmd = (struct htt_ver_req_cmd *)skb->data;
 	cmd->ver_reg_info = le32_encode_bits(HTT_H2T_MSG_TYPE_VERSION_REQ,
 					     HTT_OPTION_TAG);
+	metadata_version = ath12k_ftm_mode ? HTT_OPTION_TCL_METADATA_VER_V1 :
+			   HTT_OPTION_TCL_METADATA_VER_V2;
 
 	cmd->tcl_metadata_version = le32_encode_bits(HTT_TAG_TCL_METADATA_VERSION,
 						     HTT_OPTION_TAG) |
 				    le32_encode_bits(HTT_TCL_METADATA_VER_SZ,
 						     HTT_OPTION_LEN) |
-				    le32_encode_bits(HTT_OPTION_TCL_METADATA_VER_V2,
+				    le32_encode_bits(metadata_version,
 						     HTT_OPTION_VALUE);
 
 	ret = ath12k_htc_send(&ab->htc, dp->eid, skb);

base-commit: 3a6df1678acc3687d49ce94e23df7b6a289f27f9
-- 
2.34.1


