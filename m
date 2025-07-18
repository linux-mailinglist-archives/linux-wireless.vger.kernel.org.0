Return-Path: <linux-wireless+bounces-25629-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9A6B099FA
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 04:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 527BF3BB822
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 02:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAEB1CDFCA;
	Fri, 18 Jul 2025 02:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nR1eenO7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1AE1CAA6D
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 02:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752807335; cv=none; b=CiF++PZjR7bNi1coW/iuxGbYIaNyTygg55Ube5gBOLFnw6KlaJkx1pGW5hKhyIc7IV2Fw1nORIa9IDNHqSw2/kCOJghikRe8jdCpr0DLLNTsnVetDAzeGpLGHBqMr2HMs/UsTy2BgdY95x++8kGujfjn/qJt5ml/mIN+Tb2vnCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752807335; c=relaxed/simple;
	bh=OzppL80KGkJITPatF1k9pEkVNiXZVfqjJAPd+CjgH5s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=rxve1AuT9Cbo2T3uIBqmaIrlgls4CoLrIRlQWKSIaXydvp0nYinAc4e0aPmQJ77qV7pGrWrk8VVHbp3kVTEFVFsgxIAUK2/pXJ8SZEH8wBZBY6MU87l7mAh0r63GNc3hkqeEMAaG7sU7C6ZMRb8WPY0N+xG9mtaDRadZeqJDgpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nR1eenO7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HKnP4c016545
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 02:55:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:in-reply-to:message-id:references:subject:to; s=
	qcppdkim1; bh=xZ4quxnAfEGIRYmWpsGwZnlE5rPMKoZOdNyssF8d8W4=; b=nR
	1eenO7AU4t96hIQwgdtPk/sZSvENJS5m9BRJ7kIAqjUEeNTpLA3fZlN9WT/gnxj4
	KoPZ0qRW3Uc1uXaqkyqbpQTINod8Mi+wnnblazDWn2Dutg39YUMkIDR4pZ1AYt5/
	91ELsIvrlEMSy3ftzaRC+BwX2aI0myl8A2eUK0Yfu4EEzfB8DCi/G/OQwmv3Qrzw
	SZueBL3hTA8cJitVfLBaMVJR7n8tuTspbrSiukxfq1Zd6kuwgQE/poWmebVXSt7D
	gNIG5h8IGArvluy2b7Rt9BDasbUSeDrk5wSEsj5ZmUuo+9BUroB5NQGbNgrwQbME
	/OKV1HWzw948tKJiG2ww==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dyvw1a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 02:55:33 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-748efefedb5so1495346b3a.2
        for <linux-wireless@vger.kernel.org>; Thu, 17 Jul 2025 19:55:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752807332; x=1753412132;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xZ4quxnAfEGIRYmWpsGwZnlE5rPMKoZOdNyssF8d8W4=;
        b=ror7xKDTECM5ig9Tqa/Cp+5cPkhMcJsy6PktgbF4IDlsgtz8izIY0D6e7LILjvzXZG
         NDSadJ5o67N3vrHAh6uq0g3fVMtAGQc8CR7SDy/om/hEZcSCQ+ycV2QkK6vbtww94xR5
         m4Bm1fvuEqX+Dsvap9RmpW23WJ6TincY9XSgz2YsL/V2q4gwNorg3Wbnwn5+x5BODAM6
         B8CSObe7c9I8R+x/FQXAk0QWfdZBOMmcB98xi79lMv96iMUdjjy3My39TcCXLAmougCJ
         S58yE3V0ZoK3e50JhPvpuDT6drW0Uqcne7k/gsTBwhiKfDzLY4HNHU1IqW+yec+iuvle
         9KIg==
X-Gm-Message-State: AOJu0Yzam8sEj8fyTDh1hCf/f+nMfxg9SDHAG1YN9szCj+dN1HM0Yw7b
	WHHLSEV6/x+5K+k9rRlb0fhi0AKoVPGz4TFbXNe73LCekLnYA+L8F8Po1ntzd3OmiPV8kikutPm
	yxRR9Gx61YgZeKjmpGUnakIHEJfyyTWJRp5MEIDvaZgYl3nV8aFajDnIV6EUhFkvQNAFLJw==
X-Gm-Gg: ASbGnctFhIBOF9sBhnZTp1rqDbAZFyC0/bI+0DHjoT50tN1PC8GDtaIhJsznjQ6vvXg
	65SkfdcT1HgfFr+b1QkNr7ephVmmiE71fad4QO0NTIdwgybMFMzzNH8RObVtAj+g16Hgu/jf5FV
	pBKPsZI5I0QcoD2+F0evVgw0GYgsw8ovIs11gi/qnnBMshP2EcojYD2VO6BgjFzngcYiRsolp57
	vMTZ5ob2EVMHxgoky1upRDzjsYexAbc3vQQo9XdcX8L8bjhRT7aBXh4wCdndZRLQcuLij6tvnC7
	pvAlzgqVAoCFZcvnUt1/TxmTNLf/mgIDR7stLCPTnNVwik2UpWqUv+gKNjhr8lVTPQyQ/OY+PNE
	YHqL8wt/S1Ff6rStehSu8ch8uowVpv/LuJSsSSrm2o18joL39kVUNgkOfuTVZK54Sv+iay9h6dw
	==
X-Received: by 2002:a05:6a21:b94:b0:224:654a:4461 with SMTP id adf61e73a8af0-237d896b51dmr13655168637.41.1752807332059;
        Thu, 17 Jul 2025 19:55:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgG+AmfAZAOqo/kKS3DXtkNwhlm/lCb6RkZu+uE3HLcz6TXmGm9U3TyzO4AbtWaLjggjMjBQ==
X-Received: by 2002:a05:6a21:b94:b0:224:654a:4461 with SMTP id adf61e73a8af0-237d896b51dmr13655129637.41.1752807331518;
        Thu, 17 Jul 2025 19:55:31 -0700 (PDT)
Received: from hu-nithp-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cbc68095sm255334b3a.139.2025.07.17.19.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 19:55:31 -0700 (PDT)
From: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
Subject: [PATCH ath-next v2 3/3] wifi: ath12k: Advertise encapsulation/decapsulation offload support to mac80211
Date: Fri, 18 Jul 2025 08:25:13 +0530
Message-Id: <20250718025513.32982-4-nithyanantham.paramasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250718025513.32982-1-nithyanantham.paramasivam@oss.qualcomm.com>
References: <20250718025513.32982-1-nithyanantham.paramasivam@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: b4Q6xQD-NZzFuYPaDxdmaOVKkdZ2cA6i
X-Authority-Analysis: v=2.4 cv=RtXFLDmK c=1 sm=1 tr=0 ts=6879b7a5 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=xNSR-wY7Tz068C_b7HkA:9
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDAyMiBTYWx0ZWRfX7LyI7o6P0KHV
 gDUkO7b0MUEa4bWMgjvrBa5RZz+d0OO8zjHwct9V6SW++rY0TlCPTqW228XTQ+yM2jBMowEIAOt
 ikGfsUW8XIGWPThAxvIRqtqv/26es/34SHacTlVRmkIC41S0gYMUBj8nRtoA1yjWlpvmlkqaF9o
 e/9N61+tCdSVgTNciYeG7QbJ4AN/Jz6YETXdIDuB4XyhXUO6vSVeMhJTKD7xgcHvgzYhsnj8i1G
 a5F0xPUC0dqk2uanVHjS18x/3v1ZOa+SudL6tIzsSJKav50bNjMQu7HvqhYu3MparXfX7xkwwAT
 RbIhkAbcw6oANkIW7oynqDOy7UE385biR6XS8RKrzyToryDDnORpo8p+6XXo93Nn9BVmc31++Cd
 VxzJTWMJEwxZUXP+Ny1rvp6MhW0RaHk4n+ljRjksnDBOj9VHwxd1Esw65WoFQOhA6tNPqKn2
X-Proofpoint-GUID: b4Q6xQD-NZzFuYPaDxdmaOVKkdZ2cA6i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 phishscore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507180022
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

Currently, the mac80211 layer handles construction and parsing
of 802.11 headers during packet transmission and reception.
Offloading encapsulation and decapsulation to hardware can
significantly enhance performance. Check the service bit to determine
if the firmware supports Ethernet offload. If supported, advertise the
capability to mac80211 to bypass software-based 802.11 header
processing.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00217-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 5 +++++
 drivers/net/wireless/ath/ath12k/wmi.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 3a33eccc0d1d..93ae76daa549 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -13726,6 +13726,11 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
 	ieee80211_hw_set(hw, REPORTS_LOW_ACK);
 	ieee80211_hw_set(hw, NO_VIRTUAL_MONITOR);
 
+	if (test_bit(WMI_TLV_SERVICE_ETH_OFFLOAD, ar->wmi->wmi_ab->svc_map)) {
+		ieee80211_hw_set(hw, SUPPORTS_TX_ENCAP_OFFLOAD);
+		ieee80211_hw_set(hw, SUPPORTS_RX_DECAP_OFFLOAD);
+	}
+
 	if (cap->nss_ratio_enabled)
 		ieee80211_hw_set(hw, SUPPORTS_VHT_EXT_NSS_BW);
 
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index ed9b4324a7b8..f1283b8444f9 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -2254,6 +2254,7 @@ enum wmi_tlv_service {
 	WMI_TLV_SERVICE_WMSK_COMPACTION_RX_TLVS = 361,
 
 	WMI_TLV_SERVICE_PEER_METADATA_V1A_V1B_SUPPORT = 365,
+	WMI_TLV_SERVICE_ETH_OFFLOAD = 461,
 
 	WMI_MAX_EXT2_SERVICE,
 };
-- 
2.17.1


