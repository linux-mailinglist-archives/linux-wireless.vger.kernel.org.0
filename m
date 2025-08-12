Return-Path: <linux-wireless+bounces-26306-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9D9B225AD
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 13:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 483CC188D99F
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 11:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD772ECEAC;
	Tue, 12 Aug 2025 11:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D0URd982"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A042ECE9A
	for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 11:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754997443; cv=none; b=ZOom9UKHa5lM4v+o0tuJ1jNntjMEbvmUJFbK4tLcxjMrZdJyfdWdl7jjKuJmY63bZvxZs4KMRxLihF5MG+88EBu/oYLt8nrnoJcvQahwWGRoUdPmqjVR6T7mX9iHpqgFQ5Q70m3zH5HS++RjDHcNZWCbK5ViGy/DBCHHNbxZeM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754997443; c=relaxed/simple;
	bh=8X39SFRdFU9axiDLTbg1euxS+tHvhdSRuu7IOvQWvL4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=NiGE158hxIOjY9EcFTbHwO0iJeyLDIPvi9GEGAmi9LdsiF6J4xRJ3EP7kqaHs03fnAVV3AGUzHYMtbJqg7bX4GdK7AH+8rnnYxyyk/swj6jXRtgywYd9luVdiApDKtUKsIKcWhi+mDM0hbNEeHrx71/NOjYxbRCrngJyLon3tMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D0URd982; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CAvkZe003167
	for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 11:17:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:in-reply-to:message-id:references:subject:to; s=
	qcppdkim1; bh=xNky3PyY6gPSYVfZ5yCYQfZ5N5iM84SyiETWS9rhvLU=; b=D0
	URd982dIl1ef4McPk8EGjvrOtEQrqlYQcqXPysjrKI3O3WAsQUzC+rQvh8CZh8Uz
	FYzZC1I5jN+eVZSc47qK91TOAplOAmWpuH5e4IYcPiKvWStu3LjKYcAiQ4ZVMx8H
	yczgi2G+ToHthOQMsLZSHJKDIDEHjF4UXDBw+vHuft+T0MFjwNPoWfHbHY7qRLT8
	5IgotpBErEaCQZ+LyLNpi4PwaJjW/aW5fkTwbOVwugeRIoh8SZEros8Ly9z+VI1k
	fkWCqnq7KBfjxKNFZ1C66wJpOiTuwicIShYB9ayd7YG08hN4kHOvbdk3Wak4dqKB
	sjfMc+cdlkdIu68fDRNA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dupmr1hk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 11:17:20 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-240b9c0bddcso50591605ad.2
        for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 04:17:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754997439; x=1755602239;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xNky3PyY6gPSYVfZ5yCYQfZ5N5iM84SyiETWS9rhvLU=;
        b=czPmk1CVmv/zY96gD1OS43r5kUg9IqAGKWmrPM1pcpcuHY9ku7SpkPgD7CL3AYxMRy
         O1rd4davbqAZkvfMPT/o7ABPJciIVYy6UHu2TFBxg2cU3f/RUYRagxwlMvM7vXC1PIdw
         8A2XJWaX8kuQbaGH+lMAQVTZRCMsEZp4RfmiQOVq/ETfJIrx6qmteUy+lt85m44ZKmMj
         NDE8mCwzHZcPScIfd/z0iX1SBhxvw2NSBkdPLa+SYG+FFGrd3n+gGMs9usiUbb51NTPz
         laOE+eddHkUDaQwFC4F2jVtEZkQCK2uDmoyOM+c5nd068yTeLywsoMcrx6lNEWg2FwAE
         ooPg==
X-Gm-Message-State: AOJu0YzoCGItZhuEsUcp4zjVlsYCLqGJl/8TALNf8IpjtYSzwMPb1EZP
	vBWrrwa2SYeNVQKSHiegksjorS8TEYD1bOtumPC+7GV7OTlS98wv5Fl3uRDFRRBpFKQiUCxoXZm
	saPdsDKzveNcgMDIx4/HJhpYiYMlWCerVGtFgvLWszhPcB3ZUcARLT9thKv3nzB+JcsXE415TVC
	sH+Q==
X-Gm-Gg: ASbGncuWVwRz4RA9HcDvxU6LY3fOOq8SsosDsCrSB3PAWItEBdRdZpxZapu8kfjB9CH
	0gCxPLtGaUTpcFXYbjhWyJ+VGYbjwtWtMJE4qB8guLtZpTM2ocFyE6g4lo3h2+eFUy5EAKlf6gO
	wOZPB6Qxw95/zsBaZzmBpMYLChwwcGiPT90G/a+b5gIAqNug1XW8CYV7NTPxUcpfx/qE4lUCKUQ
	YpJmMnnm6P3HBXcA+aEsSQrAV6lSNDYcFe+4GNKE2TyYuRIZIVCCgB+zCk4ZdPcCIn8MuhjSB8v
	w2NVFyiKvBnt2weK79G1mqN/uPsWESidNQd+mArC2g6iGNsPnU8tSDm97zAgE2CqjAp4ErlJCAL
	fkilZNP4=
X-Received: by 2002:a17:902:ec91:b0:235:f143:9b07 with SMTP id d9443c01a7336-242c1ffd1f7mr214081315ad.5.1754997439168;
        Tue, 12 Aug 2025 04:17:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/MDLYmbx6MFyQb7CqcqL1isEOtvZ0dhyMqfrCAKiaeL95So9uEa5UEAe9Pe527mrC8YljJA==
X-Received: by 2002:a17:902:ec91:b0:235:f143:9b07 with SMTP id d9443c01a7336-242c1ffd1f7mr214081055ad.5.1754997438702;
        Tue, 12 Aug 2025 04:17:18 -0700 (PDT)
Received: from che-ventolnx02.qualcomm.com ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f1ebc1sm296048935ad.67.2025.08.12.04.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 04:17:18 -0700 (PDT)
From: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Subject: [PATCH ath-next 1/3] wifi: ath12k: enhance the WMI_PEER_STA_KICKOUT event with reasons and RSSI reporting
Date: Tue, 12 Aug 2025 16:47:06 +0530
Message-Id: <20250812111708.3686-2-maharaja.kennadyrajan@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250812111708.3686-1-maharaja.kennadyrajan@oss.qualcomm.com>
References: <20250812111708.3686-1-maharaja.kennadyrajan@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=bY5rUPPB c=1 sm=1 tr=0 ts=689b22c0 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=R84Khl0NGm2auFzJyeIA:9
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: lH13on9eOe9ywJoAQYJc_4bzi87pTj8R
X-Proofpoint-ORIG-GUID: lH13on9eOe9ywJoAQYJc_4bzi87pTj8R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAwMCBTYWx0ZWRfX9svPHhGJKgwV
 XZIxnc9zTzou7/z24uoerYH2HLpsvzDtnw+WzXvkqINKJ5u99ZiqzxSwYRawKv3uuSVwhUwJZ8a
 vrmZOU9vQSAvvcRdtQnRvJMqZ5NqB7fClJBDA4zJKe3Z87UudvJhpstAne5gUjb+l+Mp5/ZLs4F
 ID+IJY7V8o61+x5I5F2NPzENPExbNfMEo8DsO55qCc/K4yGp/WN1/JPZJQsTh7GTKLJkP72GR+y
 U6V0pQBOdoJWCiSWqST/6TSNsobBqAYJ/h1ze95kxdCaUjkpvJBEuN5EmoMbJ3zD60/IL0TdqrU
 0TFzFMtY9vPY98XaXILcJYVqcjyFdcXGL1crwOo7y1GORpbnoCRVEeZaIzfP1ps2W4Myj0qW9Az
 MTBYs/+X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_06,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 clxscore=1015 phishscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090000
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

Enhance the WMI_PEER_STA_KICKOUT event by adding support for reporting the
kickout reason and RSSI value. The reason code will be used in the
following patches when the beacon miss handling is added.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Signed-off-by: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c |  7 +++++--
 drivers/net/wireless/ath/ath12k/wmi.h | 15 +++++++++++++++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index da85c28ec355..cb686c68987a 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -6461,6 +6461,8 @@ static int ath12k_pull_peer_sta_kickout_ev(struct ath12k_base *ab, struct sk_buf
 	}
 
 	arg->mac_addr = ev->peer_macaddr.addr;
+	arg->reason = le32_to_cpu(ev->reason);
+	arg->rssi = le32_to_cpu(ev->rssi);
 
 	kfree(tb);
 	return 0;
@@ -7333,8 +7335,9 @@ static void ath12k_peer_sta_kickout_event(struct ath12k_base *ab, struct sk_buff
 		goto exit;
 	}
 
-	ath12k_dbg(ab, ATH12K_DBG_WMI, "peer sta kickout event %pM",
-		   arg.mac_addr);
+	ath12k_dbg(ab, ATH12K_DBG_WMI,
+		   "peer sta kickout event %pM reason: %d rssi: %d\n",
+		   arg.mac_addr, arg.reason, arg.rssi);
 
 	ieee80211_report_low_ack(sta, 10);
 
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index f3b0a6f57ec2..211812c62f91 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -4548,12 +4548,27 @@ struct wmi_scan_event {
 	__le32 tsf_timestamp;
 } __packed;
 
+enum wmi_peer_sta_kickout_reason {
+	WMI_PEER_STA_KICKOUT_REASON_UNSPECIFIED = 0,
+	WMI_PEER_STA_KICKOUT_REASON_XRETRY = 1,
+	WMI_PEER_STA_KICKOUT_REASON_INACTIVITY = 2,
+	WMI_PEER_STA_KICKOUT_REASON_IBSS_DISCONNECT = 3,
+	WMI_PEER_STA_KICKOUT_REASON_TDLS_DISCONNECT = 4,
+	WMI_PEER_STA_KICKOUT_REASON_SA_QUERY_TIMEOUT = 5,
+	WMI_PEER_STA_KICKOUT_REASON_ROAMING_EVENT = 6,
+	WMI_PEER_STA_KICKOUT_REASON_PMF_ERROR = 7,
+};
+
 struct wmi_peer_sta_kickout_arg {
 	const u8 *mac_addr;
+	enum wmi_peer_sta_kickout_reason reason;
+	u32 rssi;
 };
 
 struct wmi_peer_sta_kickout_event {
 	struct ath12k_wmi_mac_addr_params peer_macaddr;
+	__le32 reason;
+	__le32 rssi;
 } __packed;
 
 #define WMI_ROAM_REASON_MASK		GENMASK(3, 0)
-- 
2.17.1


