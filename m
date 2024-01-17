Return-Path: <linux-wireless+bounces-2076-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C8A830017
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jan 2024 07:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 618A71C22BC8
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jan 2024 06:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5D38C09;
	Wed, 17 Jan 2024 06:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lTnZ0g1E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1475E8F44
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jan 2024 06:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705472819; cv=none; b=FV0DVmLuhI6GDgpq2SWX7PQFoNF1HOzir4EJFtJ95Q4GGiZF8VPVQKECVmGOz8IXqwtRMqDPiyWDsEvj1wC1Rk9joPXg5NCk+le7EzL1ZdDPoVHnJ3kMPkCVji3VRmFlpUA/7oykKyslr91ajz25fjAvab2a8TYXfmGNx1o6BeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705472819; c=relaxed/simple;
	bh=7y4EVLLg0tYC7F0/noB3coutobovnsPOKfgLaBjYlM8=;
	h=Received:DKIM-Signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-QCInternal:
	 X-Proofpoint-Virus-Version:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=YpaBN86JahYxdcMh88WkazutB702ng4f8AVTdbA0vNypfxA1cHagTautaueBd32+v+WAGp7qCSoHer7edH0sj4ymj0Edtvu5yR3UoLWg2z06kRYvyngMgsgIE1onc6crnl6IFH+UuJL2MGcQXBE7WUSzbOHDP1bXm8zft8EsqWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lTnZ0g1E; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40H6DCdU029350;
	Wed, 17 Jan 2024 06:26:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=QJxBJ2V0sHfs5z0Xv80yrz91TbPdoZ2W+luMW+akxHE=; b=lT
	nZ0g1EqnjWTiHkSVSVs+tVAnfYKL60w6U4HeZePQbe7Gs1X7fitNMuCugYsTyiCk
	YpsZpgjrZg/yToJ2yQ63QDKbBqbCvo/0NcxT55QhdapCiMPXvHkmDDCq60hdeVRo
	sdTpmGhnzC9ZRsTbwUvYXPvrOaeCB/MClXRXJ2GVgb4LFmQ0xfbC+7vh1uf+8Acp
	KhWIIJO6rYs0rZOrq9zRvWL81UWKQy2hwgiFZ0EdMZFqiM8cwQHP6zTEf8Z+xeAc
	m4r3hfid3slxQT4yZEPQHkDgRZ0ew30lnCI6tkxP/bn2YYr/Fa2BxownqcCWMq6R
	7KXtK29PCdkz0bnRCF6Q==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vnmq0jy36-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 06:26:52 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40H6Qpbr001450
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 06:26:51 GMT
Received: from srirrama-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 16 Jan 2024 22:26:49 -0800
From: Sriram R <quic_srirrama@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>
Subject: [PATCH] wifi: ath12k: Fix issues in channel list update
Date: Wed, 17 Jan 2024 11:56:28 +0530
Message-ID: <20240117062628.8260-1-quic_srirrama@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BJ71lD-O0RdSrxFguicQL4SbyveRGJME
X-Proofpoint-ORIG-GUID: BJ71lD-O0RdSrxFguicQL4SbyveRGJME
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_02,2024-01-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 mlxlogscore=859 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401170043

Currently, the logic used to select the 6 GHz band is incorrect,
which may cause 6 GHz supported channels to not be updated properly.
This is because the 6 GHz Max frequency supported by the driver is
being compared to the Max frequency supported on the board. If in
some cases, the 6 GHz Max frequency supported on the board is less
than the defined 6 GHz Max frequency, all 6 GHz channels are disabled.
To address this, compare the max frequency supported by the board to
the defined 6 GHz Minimum frequency by the driver.

Similarly, when a dual mac card supports both 6 GHz and 5 GHz radios,
if the 5 GHz radio gets enumerated first before 6 GHz, the checks in
ath12k_mac_setup_channels_rates() can cause the 5 GHz channels which
were enabled earlier to get disabled when the 6 GHz channel list is
updated. This is because the Min 6 GHz frequency defined in the driver
is 5945 MHz, which should be 5925 MHz since channel 2 is not considered
currently, but the firmware can pass 5925 MHz as the minimum.
Hence, update the Min frequency supported by the driver to 5925 MHz.

In addition, ensure that the channel list update to firmware updates
only the channels that the current radio (ar) supports rather than
considering the wiphy support. This would be required when multiple pdevs
are supported in a wiphy and they support different ranges of frequencies
or bands as in single wiphy support.

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h | 2 +-
 drivers/net/wireless/ath/ath12k/mac.c  | 2 +-
 drivers/net/wireless/ath/ath12k/reg.c  | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index ba0a30f1ea29..41e8bf1af169 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -425,7 +425,7 @@ struct ath12k_sta {
 };
 
 #define ATH12K_MIN_5G_FREQ 4150
-#define ATH12K_MIN_6G_FREQ 5945
+#define ATH12K_MIN_6G_FREQ 5925
 #define ATH12K_MAX_6G_FREQ 7115
 #define ATH12K_NUM_CHANS 100
 #define ATH12K_MAX_5G_CHAN 173
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 88cec54c6c2e..f4e5dc363472 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -7198,7 +7198,7 @@ static int ath12k_mac_setup_channels_rates(struct ath12k *ar,
 	}
 
 	if (supported_bands & WMI_HOST_WLAN_5G_CAP) {
-		if (reg_cap->high_5ghz_chan >= ATH12K_MAX_6G_FREQ) {
+		if (reg_cap->high_5ghz_chan >= ATH12K_MIN_6G_FREQ) {
 			channels = kmemdup(ath12k_6ghz_channels,
 					   sizeof(ath12k_6ghz_channels), GFP_KERNEL);
 			if (!channels) {
diff --git a/drivers/net/wireless/ath/ath12k/reg.c b/drivers/net/wireless/ath/ath12k/reg.c
index f924bc13ccff..29542c46b094 100644
--- a/drivers/net/wireless/ath/ath12k/reg.c
+++ b/drivers/net/wireless/ath/ath12k/reg.c
@@ -103,7 +103,7 @@ int ath12k_reg_update_chan_list(struct ath12k *ar)
 
 	bands = hw->wiphy->bands;
 	for (band = 0; band < NUM_NL80211_BANDS; band++) {
-		if (!bands[band])
+		if (!(ar->mac.sbands[band].channels && bands[band]))
 			continue;
 
 		for (i = 0; i < bands[band]->n_channels; i++) {
@@ -129,7 +129,7 @@ int ath12k_reg_update_chan_list(struct ath12k *ar)
 	ch = arg->channel;
 
 	for (band = 0; band < NUM_NL80211_BANDS; band++) {
-		if (!bands[band])
+		if (!(ar->mac.sbands[band].channels && bands[band]))
 			continue;
 
 		for (i = 0; i < bands[band]->n_channels; i++) {
-- 
2.17.1


