Return-Path: <linux-wireless+bounces-2563-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCC583DA2F
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 13:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 223EC1F26B2A
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 12:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FC81AACD;
	Fri, 26 Jan 2024 12:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="M3A/bvpb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04A41947E
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jan 2024 12:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706272125; cv=none; b=XyczAXGLM9Wv2ekmeybYAWraENA9FOyND39NP03dVlJNHTO1P4d9nG6t/bUTrxNnaDvOIHeqEN1mesqhI70UFWQfOVtK4sdPXbN/NZYiWnoxUUSUPEol10dAE+l6u7JzYudjUJ8OBaY2ZVOs3Zq0bZuHriSxNwo1gg1zwKP8UVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706272125; c=relaxed/simple;
	bh=qWAgCI38ARWEzEp9PQNem4JIzSbOxx0fsU3xhs2hL50=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iNAklCaK9AC2NmS1dVgxR/Gc3hnNRZhJXUy+d+cNM2P18AttfkIEUAf5pcsRVMf5g2J8A7kzK1bWZpMzWypu8g4jIq7lXSTbsnvwEv2ak5VCCXljAsdB+10qSRZeyObfQTmGXsXycK0ycXTnCnNNbcHumCoXFR4oFHOApgmj+vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=M3A/bvpb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40QBoIwe008873;
	Fri, 26 Jan 2024 11:52:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=9VOJP4N1WPqPfSI7bAKc2Ut2ziMxGqUAe3lJltFxDw0=; b=M3
	A/bvpb6nkvbcdYKCZbU90jfF8A2DndfT6e8xuhlffeklDM7SdtuaZwm4Lw6s6CJj
	T+FYKD4hKcd24dgYVTNtoV7PI3stsCDMayIRayWnesGydCp2jX+n+e+ggDC5TEVM
	+RiFmlnEWPHWD2O2PTtrln+trhB4vs2rJe8y/8KVDpxWTiBHni6A4DArCFkG5ON8
	/bzWq9R4Z3yJgV8SbGn403wSjjYgDUQiGaPvfpcmhUyDkFcBWrVhLutlW7Jx3kI9
	6fksyyhv/dtq4P65mABZRLWQF0lLs7Hp36SMpl/JCSjZrrIuNYWr3/9Zp99MenKJ
	NGCcbxebBhJCw77yXZJw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vv4v810b0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 11:52:57 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40QBqukv003973
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 11:52:56 GMT
Received: from yk-E5440.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 26 Jan 2024 03:52:55 -0800
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v4 05/11] wifi: ath12k: change WLAN_SCAN_PARAMS_MAX_IE_LEN from 256 to 512
Date: Fri, 26 Jan 2024 19:52:25 +0800
Message-ID: <20240126115231.356658-6-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240126115231.356658-1-quic_kangyang@quicinc.com>
References: <20240126115231.356658-1-quic_kangyang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: r3D4umQqZTKpoYyHl--2-hqs5CU4eeJl
X-Proofpoint-ORIG-GUID: r3D4umQqZTKpoYyHl--2-hqs5CU4eeJl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999
 adultscore=0 impostorscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401260087

Mac80211 needs more space for P2P scan ie in P2P mode, 256 is not
enough, resize it to 512.

Also delete the duplicate macro definitions in wmi.h.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---

v4: no change.
v3: no change.
v2: add Tested-on tag of QCN9274.

---
 drivers/net/wireless/ath/ath12k/wmi.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 0b8203bb5381..0efed12dd7ab 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -168,10 +168,6 @@ struct wmi_tlv {
 #define WLAN_SCAN_MAX_HINT_BSSID         10
 #define MAX_RNR_BSS                    5
 
-#define WLAN_SCAN_PARAMS_MAX_SSID    16
-#define WLAN_SCAN_PARAMS_MAX_BSSID   4
-#define WLAN_SCAN_PARAMS_MAX_IE_LEN  256
-
 #define WMI_APPEND_TO_EXISTING_CHAN_LIST_FLAG 1
 
 #define WMI_BA_MODE_BUFFER_SIZE_256  3
@@ -3146,7 +3142,7 @@ struct ath12k_wmi_element_info_arg {
 
 #define WLAN_SCAN_PARAMS_MAX_SSID    16
 #define WLAN_SCAN_PARAMS_MAX_BSSID   4
-#define WLAN_SCAN_PARAMS_MAX_IE_LEN  256
+#define WLAN_SCAN_PARAMS_MAX_IE_LEN  512
 
 /* Values lower than this may be refused by some firmware revisions with a scan
  * completion with a timedout reason.
-- 
2.34.1


