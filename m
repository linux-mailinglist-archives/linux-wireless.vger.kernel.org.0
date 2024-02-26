Return-Path: <linux-wireless+bounces-3993-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1D28669DA
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Feb 2024 07:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E189B2811F8
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Feb 2024 06:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52B01BF20;
	Mon, 26 Feb 2024 06:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EGJzf/tL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410371BDED
	for <linux-wireless@vger.kernel.org>; Mon, 26 Feb 2024 06:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708927382; cv=none; b=J82HgLSyl6c7HTw1eJUbSaJl9AEHqjNbHACcXfMeJSYz7ZXdPk2Q4brUsUtFC5pFuVw360aXHYPByUpE6qwM6fysLL8DRN3TvNKLcqtIuWXeOv/37eXg3pRfTttY7okSKvPQg5g8hyt9rL0zzrP42bS5mRhGrxQsUnVjsrZL1JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708927382; c=relaxed/simple;
	bh=9pde5lWmm05C0gu/BaoB3SWGzC9XpEcTMlOd0r08Qu4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pRn7Nuq0kIBA0N+M2EwO3GtW2xO6sztoHcXImVB8m035XjnHeD8OUIV2+w+0pGbYchmx7EjFjeE1eIXHJ9Y79u7p9fxgoBnuLcohNHCQ2dY9QeIsDJWQ6UnU5qcNjuh7Rxnu/zT7TEfhk+qMifHgjxDQfZZ1q/p9GkF7J09FpLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EGJzf/tL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41Q5ed6w004214;
	Mon, 26 Feb 2024 06:02:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=fN93o1wtop/WVkkWFpnTHqAVl92x6hChVy4BtYnUZ4c=; b=EG
	Jzf/tLmnJxawH2WC3mGfmA9L7GuKgRgeNivov0aKSdnNooZBsFX5740V4SDXBS40
	uEKBMBqp2+rS0xd+UPpdhwWcEi/fBUlPKvx5BShd8KBVBMPxY+sVW+5Fp2M8Bfg0
	kGbZtFCyKdpywnHLhARBxr9VllUf5y7qREX8j9F5TF8oudftvOeVmJMaNi5c/97C
	AkW7GPTGGsnOnqvwxlqkmSpfJoAP9fB2+LxuKehhf4nUNAyX7zHbNtBe7gaMzjfF
	9NXqTRAxQ+DDEsL2ySxVlg3VUYR6rrS6Y7U7U8HaWjVWEMvKiv8FZooKoCq8Y0La
	cSRQ2SIESTBmsow0/owQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wgkxp83k1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 06:02:58 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41Q62QKg013411
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 06:02:26 GMT
Received: from Mayan.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 25 Feb 2024 22:02:24 -0800
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH 4/6] wifi: ath11k: change WLAN_SCAN_PARAMS_MAX_IE_LEN from 256 to 512
Date: Mon, 26 Feb 2024 14:02:01 +0800
Message-ID: <20240226060203.2040444-5-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240226060203.2040444-1-quic_kangyang@quicinc.com>
References: <20240226060203.2040444-1-quic_kangyang@quicinc.com>
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
X-Proofpoint-ORIG-GUID: KPXGdGY5cmqNUBN4wDqIgLApLvbtAIXQ
X-Proofpoint-GUID: KPXGdGY5cmqNUBN4wDqIgLApLvbtAIXQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_03,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402260044

Mac80211 needs more space for P2P scan ie in P2P mode, 256 is not
enough, resize it to 512.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.37
Tested-on: QCA2066 hw2.1 PCI WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.2

Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/wmi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 564f4a9ac8ce..ae788949bf40 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -66,7 +66,7 @@ struct wmi_tlv {
 
 #define WLAN_SCAN_PARAMS_MAX_SSID    16
 #define WLAN_SCAN_PARAMS_MAX_BSSID   4
-#define WLAN_SCAN_PARAMS_MAX_IE_LEN  256
+#define WLAN_SCAN_PARAMS_MAX_IE_LEN  512
 
 #define WMI_APPEND_TO_EXISTING_CHAN_LIST_FLAG 1
 
-- 
2.34.1


