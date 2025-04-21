Return-Path: <linux-wireless+bounces-21774-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCABA94B0D
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Apr 2025 04:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89EB03AF484
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Apr 2025 02:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92EC2571D0;
	Mon, 21 Apr 2025 02:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GcI3AIdt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CA12571C2
	for <linux-wireless@vger.kernel.org>; Mon, 21 Apr 2025 02:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745202942; cv=none; b=swwQtqeQJ5RaX4YV2XDTH7ECvSXIuQ4yEEfNlmwahZqWnyVwQl1SfFQg8Ila3Fte3bxDCMEqE/zeCfKg45NgINv84+hJc9xNH9RNsMW7j/WZSyVqpSlIiBrmKtqgBN5kpYYcYcA07g39bFjJZiWWKLeRSGwvJCzRPTfo4HnsiIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745202942; c=relaxed/simple;
	bh=6ZRCAQy74mqdlcD0r7p9usxUb7s25/gqFayl9NRhqc4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Uo8ohmAl6FthVeB7VEFdAcL+8zbn5AT0BNEQ174PEIiNYFm3vn9POQ2gLfjI6457K/iwAJuzdZzK8eBw4uflCxA7rMb7qHPLMYUFmDf9dGZGUkJ23EJAXBSZhXkyQM15oq4Or2sPkVSADOR0m9uZIIHBGVjeQc3BFJbLt9h2WI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GcI3AIdt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53KNUEIG021028
	for <linux-wireless@vger.kernel.org>; Mon, 21 Apr 2025 02:35:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=GA1lrpT9l+o
	2pnM4sMy4XwztzBfcvCUtl1XzLmQjkgc=; b=GcI3AIdt71etcO9hXv+5EFOmpKV
	CMnwlFtoX8Bz8ZFU2M9kwSBh+ZlFC2RMYU3sUHb1r0Kf49rNHC511wOzZUAUomdR
	iAJqYDZpr6905r9L4QarLlB12al/P9Sz6gU/iE41mQ70sZToDCRcxiMmp4ORkgox
	CltAaEH++uH7ZUi0Rx7l+cHVfVm7Ilz3nIrzh1uX8kCCh/pdfX1RpLjZ3lzpavJ9
	l+//FYCZbO0jZ4A5rETj5pWVepj8ph+LbWCglvw3aqlUlnc+3+htU8aCUwDZsP8U
	Iq46Qv6WDRqXD3E+aStv0MI9VVfshtjKbnl6L28zVRyJ8QAB/b8A/m286KA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 464426jqvv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 21 Apr 2025 02:35:40 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2240a7aceeaso35068165ad.0
        for <linux-wireless@vger.kernel.org>; Sun, 20 Apr 2025 19:35:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745202940; x=1745807740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GA1lrpT9l+o2pnM4sMy4XwztzBfcvCUtl1XzLmQjkgc=;
        b=RRJNowVMuJbiK4FPgBX3AKs8KJcnQCq0fW3UinqhiB6hg3LCFBfAqrHdLHsNG8u4IH
         XlSRGQcT7X2GoRbx4qkc7nkZuAAtwugBDb+HD3MmXvpfdUq7Oj9DtWot5WMm6oZwEjBA
         KlPOrPig8j9q0MeBeHzH0rlO/pNH+NwlcEOqKvFYfXT/m9XJmgvd9SrNXELIVuSAIAxP
         886DKn/uL9B78CQXDhwiGSrj9uyNP9w45+avrCoc9gvl6a+xaZ5zTnns2ZtiXycmjQum
         CVv/p6fAFqhfDXeSPo+7vcgqt0BKQcx3oq7q9rg3SgZ+TkN+9CMLf+HJ3iPcj6aljwf5
         Qgyg==
X-Gm-Message-State: AOJu0YxD9r/7rNHIt1Pp1QhMrt2mgF19VMiFCslXJIufMjv7hBBoWv6E
	1/mNMXuv54uYvcaXcHZjBCvKxmM9C60HhYOjLma4FKmvclcSLI46Io69DrETP4RtTReRP6sYmTg
	j5RGSUyuHD3jtgHKpCblHtR/w16J5vVDJ0g1uKcdqOiFPHwOb0YwGsDwxn9xjmUZtzQ==
X-Gm-Gg: ASbGncukX6LtXajkcgkOkzbjpdd5LpaeEhfIc5LsFYJd7m96GlAFPxWGCm1Q+sL8qua
	Cx5gpM+tBkyL6pN6u7yKbA6TuJ1ZzMe9MjxM9C/RjXh/yFGw0Sla5RYDtT4t2gJXtIdD6ikMctu
	WyA0QnPCRSHVB8MKE0fT9SmOCe8b1ior4D2yPA3JZef9Gj3T2V8QZqkias73jBQY2PrYWp8E5JV
	mk6vFz/HmrDmII2t0gQj8FuJqMJKbc/ManQ8s2J5UISpaUdrPdm0vEsjBqfmWL4n9EupSlBruAg
	XBmxhFHR2IDw7P3P+8PiiiAU4EBwf/LtCIEX5seBUUWvsc2n6kTxRM1nuAxgRsMCDYFKRPm3thG
	CT5Q02oQSw/A=
X-Received: by 2002:a17:902:da88:b0:229:1717:882a with SMTP id d9443c01a7336-22c5337a225mr157585085ad.4.1745202939814;
        Sun, 20 Apr 2025 19:35:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdLl7lCQqDVDymY6ITzNYTFiSixMKbu9+gmtkXWRPhTpOEw7BGtsDW4aEhlFZUweVOzRjm6A==
X-Received: by 2002:a17:902:da88:b0:229:1717:882a with SMTP id d9443c01a7336-22c5337a225mr157584925ad.4.1745202939499;
        Sun, 20 Apr 2025 19:35:39 -0700 (PDT)
Received: from kangyang.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50eb4287sm54631685ad.130.2025.04.20.19.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 19:35:39 -0700 (PDT)
From: Kang Yang <kang.yang@oss.qualcomm.com>
To: ath12k@lists.infradead.org, kang.yang@oss.qualcomm.com
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH ath-next 13/13] wifi: ath12k: enable monitor mode for WCN7850
Date: Mon, 21 Apr 2025 10:34:44 +0800
Message-Id: <20250421023444.1778-14-kang.yang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1.windows.1
In-Reply-To: <20250421023444.1778-1-kang.yang@oss.qualcomm.com>
References: <20250421023444.1778-1-kang.yang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Iohh6RPvi_wc6iDoHmEjITwApMHUeZ4k
X-Proofpoint-GUID: Iohh6RPvi_wc6iDoHmEjITwApMHUeZ4k
X-Authority-Analysis: v=2.4 cv=IP8CChvG c=1 sm=1 tr=0 ts=6805aefc cx=c_pps a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=VG1Z7HIe-OYZGDrRaVgA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-21_01,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 mlxscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504210018

Enable monitor mode for WCN7850.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Kang Yang <kang.yang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/ath/ath12k/hw.c
index 482b0f4e8f95..7e2cf0fb2085 100644
--- a/drivers/net/wireless/ath/ath12k/hw.c
+++ b/drivers/net/wireless/ath/ath12k/hw.c
@@ -1380,7 +1380,7 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 				   BIT(NL80211_IFTYPE_P2P_DEVICE) |
 				   BIT(NL80211_IFTYPE_P2P_CLIENT) |
 				   BIT(NL80211_IFTYPE_P2P_GO),
-		.supports_monitor = false,
+		.supports_monitor = true,
 
 		.idle_ps = true,
 		.download_calib = false,
-- 
2.34.1


