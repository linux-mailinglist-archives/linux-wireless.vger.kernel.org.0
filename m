Return-Path: <linux-wireless+bounces-27433-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA879B7C631
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 14:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EAA61B27B0C
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 07:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8CF2E06EA;
	Wed, 17 Sep 2025 07:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PMGvC/8/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36F8270EBC
	for <linux-wireless@vger.kernel.org>; Wed, 17 Sep 2025 07:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758093151; cv=none; b=Kc4dhti12EX/RcbzTSw3U2fSv+x9SYnEI3hFIEdnFTutNKU22vo3Mqqe+x01UpeU968VKKX9aohe8VGyHFpTBwTsrTOjgZKPtKom7C94YmmJi0lnFfy0TqYhKFz7xxwIjW8BolvBrDhlm/ixVo7D2K5fY9qNtLpHxSzOvDxzVC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758093151; c=relaxed/simple;
	bh=1v/2XmWqGwM2u9PLWsCYIkpcOJ4SUG9gSs/onElCEW8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Zcky0HIGtcA1W8R4qDO0h8cXkM0sFjZQl8mqlOR0KHUYU7fM8drtnrS4kZbTmSAWxYucTVX7gelZEI4rLrEX7vxrY/7lj9pH2mOoNTxlent2PQDWpAJg8swIU5RglcnjCJcwo/NktLOj0tCKiFVYOKdavzPUAsWZFyWiUaIRnfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PMGvC/8/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58H5QZw1005924
	for <linux-wireless@vger.kernel.org>; Wed, 17 Sep 2025 07:12:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=J66hhgFImcuxqKmHSOmYrm
	l7vtoJyywpC9SEBjrvC1w=; b=PMGvC/8/SgrzE5tFBYKwU6fBmm5Wbqdac62gmB
	9rJPpaalhJK1eml27Tek3AN7BbsYya0GpuRRAcBvn5DIPH5d6s+rMk6bRLvio/ll
	c4U9/oGIH0rZbce9GrWQXTtJScg9UYLvg3WEXBdfsv0BdZ/rS0se/gmLphOfmD79
	T3YmKT5SZdYsVb+DbEXBY7N2/4Gm22vnLm0fA6r7ahnGkM6hH+zMox3X8yTM5ePr
	mO1+NTgXgDM7HR4UK3S7ky5222WwF9AunW9V+Z1yVHievg6lgusOTn76FSLodNlV
	i4rOcWqeggKAUmh56mlZIOwGLBTnYYGdnSvzN/shOW8jDXUw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxx9bnm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 17 Sep 2025 07:12:27 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7723d779674so5536326b3a.3
        for <linux-wireless@vger.kernel.org>; Wed, 17 Sep 2025 00:12:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758093146; x=1758697946;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J66hhgFImcuxqKmHSOmYrml7vtoJyywpC9SEBjrvC1w=;
        b=w2BuX3FhuaOxz/0xHzabblNBldC4oUVIIiwwgDOTXDbmHJw1zqEPvQi64UxHOJ59qv
         3z1FDPsalhgHz6u3dum03hOqrR4sOk2JCrjg9NI+uofKZuFcq3640/v66L549hv7EqK4
         ns0wfMBEn+kcILib5Qtz5Z0GzlDAdrBXjJVC+0ihXzE/Vmec07MbzQFVQ/iMuQ6K0pDn
         4EXMOKBYMWN/TZllwRUKg9VTXWobYpRIwKK3V8hWzr9j1M7M2MpUPc6g1OUb9KiC1pDg
         EKyqeqOzllcbOKJOYLRkfqqLFN88OLUhs2lnkYS6GQ087u6LCZY4Fjt2G8pQFkFB/ByH
         wDpA==
X-Forwarded-Encrypted: i=1; AJvYcCUxAq1FLMduXNiqUxcdReCjHTjpMyL37CG/NSGRiQc/+/JTLcXb6xfjNmNczIvuaHgPsNI4xYG2QMjY3o+PNg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLgyNsbiwzn2PsrBTOZWXgmFJ6wqSRI6gyl/J9vrEMV1BfWthe
	zPyq16uZpG7awaFBgUY2FvQ5FH3s1C8qajNvm6NdHig6FbnoCG7EpnvByZ/Hsfy3Ney++kGBwaA
	yApEOsHThNOIXDJQakW6ARemXJsV2PXyDsOV3weSPO+usQM4mhqG0H3ImGNV0oDSpeDag+g==
X-Gm-Gg: ASbGncs0PlzAMD2zcWr8FHHZWxYl5iACoHKwYwaoPZYAq6qymoVYzMJVwX0sA7KaU21
	dmEBPMSWf0URRGnT/eMpJcDEgnyg8DsWATdP6+RNwvX4QpK0adsskc592ds4vCSi6kERfwBe/a0
	sJF5xreCFv0zcuRoa38E8GTFPM++Pzo5PM9JRj+cLO+DwZcL/1qQzj8XSe3I0m+PmS/opY3+rIT
	An5+Qh7b6XFDfv76AxvBAnc+N/AGkItIKTWLAoBqIVzQUVGKpbMjnRSo6ymRH6Kdd8bQ0ex5RcG
	GABJrg4VnEmQ4WwzqKXz3crUqWAMyXkI2yS/ZmyR5qA/2K8lTObt93Dgd+UYCEyj813XWYrD9ME
	yiuL9vYOO2e+iFNVJ3Q/BAzsyUZvdd8X1+91FByMUCrXHEtTNpPvEz5rAmgLsfspC
X-Received: by 2002:a05:6a00:3c89:b0:772:823b:78a4 with SMTP id d2e1a72fcca58-77bf72cbfacmr1204828b3a.13.1758093146283;
        Wed, 17 Sep 2025 00:12:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7JBMaCmWienhM3LJ0ua01BRfpXCCurcfLSQi+p94eow2PfjpS459E5bm+Gdb+zftvXBTOfA==
X-Received: by 2002:a05:6a00:3c89:b0:772:823b:78a4 with SMTP id d2e1a72fcca58-77bf72cbfacmr1204779b3a.13.1758093145788;
        Wed, 17 Sep 2025 00:12:25 -0700 (PDT)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607c49fe4sm18323639b3a.101.2025.09.17.00.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 00:12:25 -0700 (PDT)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Date: Wed, 17 Sep 2025 12:42:03 +0530
Subject: [PATCH wireless-next] wifi: mac80211: fix Rx packet handling when
 pubsta information is not available
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-fix_data_packet_rx_with_mlo_and_no_pubsta-v1-1-8cf971a958ac@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAEJfymgC/53OzYrCMBAA4FeRnI0kUWuyp30PkTBtRhtsk5qJt
 SJ9d0NPHrzsMjAwzM83L0aYPBL7Wb1YwtGTj6EUcr1iTQvhgty7UjMl1F4YYfjZT9ZBBjtAc8V
 s02QfPre276KF4GyIdrjXlIFXVWNQGTAoHSv3hoRlebGO7OETdkjEA06ZnUq79ZRjei6fjHIZ+
 gc6Sl5iK85Gai2hcr+RaHO7Q9fEvt+UtGCj+gCk+AugCmBU7Q4adK138gswz/MbxeSCCVkBAAA
 =
X-Change-ID: 20250909-fix_data_packet_rx_with_mlo_and_no_pubsta-66c9e29a9e1d
To: Johannes Berg <johannes@sipsolutions.net>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Cc: Johannes Berg <johannes.berg@intel.com>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: Sx39I4Cjc11tb_qTyawpsk9XiRbA_x0r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX/MYdMa32y9KW
 AkMlvwFzUaUft2CaaCM+jlpbK9oJ5PROj2SqMc3AN9fFeNwuTQXhmE/+GR/eMocvPXn3l4Nd0oW
 hZT2R4LlgGGyUIDPZyIZahvBPKlMl6QbxVnsPhI4gVGvoa5XoxINzZn77MZSxrseYU/73URHcH7
 Ef+obRdlwYQFCjDXDAoUqIhpal2aZQANXRJPoQID5tuBEhi4MxaUKOdd3ICotsLrgZbqWqfnt8A
 s2OJvGJpUqFNiP01znR0cZtdUqzL//iVbZk3COPRzEnpSrfLIIi9yVLWRH9bVHEMQzKIoGBCXlZ
 XBtghErWq0V73mX4LY5+4i6GB3ispoCGBKZDqFKLbBdm9TdHovWMUNSXHcwDOD1yaP7dOcb8Zie
 5s0otbJy
X-Authority-Analysis: v=2.4 cv=cq6bk04i c=1 sm=1 tr=0 ts=68ca5f5b cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=rm_eYm1gv3371dOiMRkA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: Sx39I4Cjc11tb_qTyawpsk9XiRbA_x0r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-16_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 phishscore=0 impostorscore=0
 clxscore=1015 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202

In ieee80211_rx_handle_packet(), if the caller does not provide pubsta
information, an attempt is made to find the station using the address 2
(source address) field in the header. Since pubsta is missing, link
information such as link_valid and link_id is also unavailable. Now if such
a situation comes, and if a matching ML station entry is found based on
the source address, currently the packet is dropped due to missing link ID
in the status field which is not correct.

Hence, to fix this issue, if link_valid is not set and the station is an
ML station, make an attempt to find a link station entry using the source
address. If a valid link station is found, derive the link ID and proceed
with packet processing. Otherwise, drop the packet as per the existing
flow.

Fixes: ea9d807b5642 ("wifi: mac80211: add link information in ieee80211_rx_status")
Suggested-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
---
 net/mac80211/rx.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 4d4ff4d4917a2564cdc109fec8ddd605a3b677d7..59baca24aa6b90212b739839e49714308a6c8fc2 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -5230,12 +5230,20 @@ static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
 			}
 
 			rx.sdata = prev_sta->sdata;
+			if (!status->link_valid && prev_sta->sta.mlo) {
+				struct link_sta_info *link_sta;
+
+				link_sta = link_sta_info_get_bss(rx.sdata,
+								 hdr->addr2);
+				if (!link_sta)
+					continue;
+
+				link_id = link_sta->link_id;
+			}
+
 			if (!ieee80211_rx_data_set_sta(&rx, prev_sta, link_id))
 				goto out;
 
-			if (!status->link_valid && prev_sta->sta.mlo)
-				continue;
-
 			ieee80211_prepare_and_rx_handle(&rx, skb, false);
 
 			prev_sta = sta;
@@ -5243,10 +5251,18 @@ static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
 
 		if (prev_sta) {
 			rx.sdata = prev_sta->sdata;
-			if (!ieee80211_rx_data_set_sta(&rx, prev_sta, link_id))
-				goto out;
+			if (!status->link_valid && prev_sta->sta.mlo) {
+				struct link_sta_info *link_sta;
 
-			if (!status->link_valid && prev_sta->sta.mlo)
+				link_sta = link_sta_info_get_bss(rx.sdata,
+								 hdr->addr2);
+				if (!link_sta)
+					goto out;
+
+				link_id = link_sta->link_id;
+			}
+
+			if (!ieee80211_rx_data_set_sta(&rx, prev_sta, link_id))
 				goto out;
 
 			if (ieee80211_prepare_and_rx_handle(&rx, skb, true))

---
base-commit: d103f26a5c8599385acb2d2e01dfbaedb00fdc0a
change-id: 20250909-fix_data_packet_rx_with_mlo_and_no_pubsta-66c9e29a9e1d


