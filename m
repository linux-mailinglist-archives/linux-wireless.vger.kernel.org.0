Return-Path: <linux-wireless+bounces-21111-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5515DA79ACC
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Apr 2025 06:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 054AA3B12CE
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Apr 2025 04:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0472014B959;
	Thu,  3 Apr 2025 04:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BRa1uJ9u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573C72E3387
	for <linux-wireless@vger.kernel.org>; Thu,  3 Apr 2025 04:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743654159; cv=none; b=tXDVhDuw3e3p4+ebOxHh13NtvLWDLFetC5XVAUG560UwIXICmQcG2Wei1boTMHOOZwSQVXTkYtb61J+ihcs+Q53fA2gp0BMNXiwYQEEAn/VSOGCtGr9sw+NPDWRvMIWwo+/CjOoE9obLcoaZpisy1JcujrS0Y6FDpdOTKO1LoM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743654159; c=relaxed/simple;
	bh=h6bPHjBGAbExfAQLSr5rgR36tRhQ3yd8Mmy3YjWW5oY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QP92a1xqxqZ2yzFtKBTD1qHliZr8ZOs0fShF8rBgaUpa+Kzgq+7X9SbYgdgxk+xrcJHs4zAAS+Ep7Co+deqUv5XlGQ0yOTzLytbMvzZ/4xYcwHmd3PfftEwsDfDkOUH0+o4nLVnSGW3ikNzCXrnew9ZsL2hh47C+BKSIaqlwVJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BRa1uJ9u; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5333mn3o027458
	for <linux-wireless@vger.kernel.org>; Thu, 3 Apr 2025 04:22:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=xd2g+ceJ5l8BEhdDTCbh7lS7CcWUwmAVw8C
	+dbVGocw=; b=BRa1uJ9uQuZ2OQSunvKpeDxfjPAhywOrJeXG96oRspoRdDCEFo4
	Jwnlt94rdloY0QQi3yf804QLcQz4fg2jxjAjaiwOATYodTvC+ZEK2j/vcB/4ZvrK
	j7gAA1Wqj25RdcZOoID8GO7Y6s80Enru5yhgURrk9c4XyjJYDEWG1Cz9XrZ4HItD
	exuoWAPeKTmPjTfi1mT0HG9a9pGGqbHIxPyvWB3yCVicrDE40ObJ7kvmAhCSurra
	OWwNb6faT6JM6A5zpfhaWRI6N2Y6TKpMx7bQMdYTe41FFqzcNZBQMyG+0s5LTWR0
	00KQmfU8ssuWYIguVkMkhVMLU6WP4y3uFRA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45rxbf3c0b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 03 Apr 2025 04:22:36 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-736c7df9b6cso740233b3a.3
        for <linux-wireless@vger.kernel.org>; Wed, 02 Apr 2025 21:22:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743654155; x=1744258955;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xd2g+ceJ5l8BEhdDTCbh7lS7CcWUwmAVw8C+dbVGocw=;
        b=IqkYGo8TlXKeAJiW/OG5voL/J9gbCB0GwxVcAdmfc8spn5GCWWn92nm0nNQOvtafnc
         WOjtpZFAx5YejwwTEiay02WknBVFDd5qI44dtgQ8l1XDLsV7mMOLhKrj0+nffY9o2zyf
         8Ctz+XhaE1daCpxtdHULQ/xGxA69UXtirhdR6+83sHc7MKNxUywBqKOz5g7oFCzeQ6X/
         01Qr0ucx2R2GdzkJULFXPIJr5BmZfrkb4f20bMemMPaZIDsL2HeIC9SRPEd/48/ed6ZP
         P3HbA/zVYysXbbis88e9OFNKHUAFzdNarfJPJK3hF9QeiKPSwAR9tPZQn6UfPIIcgtgI
         RKPA==
X-Gm-Message-State: AOJu0YzDG+Uw6rE8cV/Y72pcB3kDu3G93DAVl3o4h9LXY1fsnGo90k+6
	5xTk3F9uSocQSZ9BaL8yD3tAnBx/jOD/ec/JaCn5KC2LssQqJJ2Yx6zHaP4eV13HP5ZSzECvGc4
	ClBn8gkGieVnGXSzZKqrXjMKsTL8iqG0rxxrMXQiZhRrKaKdNP/I2fhYTJo+Jbxzb4A==
X-Gm-Gg: ASbGncv2r7jZKyL6PDFT7quQhBSFBrhC3mkqe6ZEC7EGe0DhUgK60dE6Up6VjkjXSK4
	pfgRH6UtaxJhUSFCVI/5RBp2w+wXyEzjkJFpP6iJrmymw+G3C6lGLFy/reO4sTyos8KPwmJhHXV
	pzvqcadO4BpIcDqEvvrrwoZejQTdX3L6iz4TEP3LHaQFOciDcTW+vYNpVkqRF6lS7A2/lhTp0e3
	Kk8hJy0PZa2ZfQRd+K5PXDi3NQrITyZmCFGZpUiEE/nAubh8bMtgEZgPGlD2LNsUcbfREJ+GFae
	7EaqlZPeIpXgiuFdxREgzJaswrO2Wp27D8T9/2ItiP7z0oc9+9ulCp+5pjNzmtfkRlM4uYAFn6W
	XtyqcU3+mATxHfYvLI8u09hG1DnWrFkC5b7ZMwyo=
X-Received: by 2002:a05:6a00:1486:b0:739:b1df:2410 with SMTP id d2e1a72fcca58-739d85de28amr1634026b3a.20.1743654155485;
        Wed, 02 Apr 2025 21:22:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvZtR2GP0/ONm55Mb7sq79xJ1ITdYVhzgoqy+Czob613eeuQouLKgvuR7RDpUYtlTlrqN0bg==
X-Received: by 2002:a05:6a00:1486:b0:739:b1df:2410 with SMTP id d2e1a72fcca58-739d85de28amr1633995b3a.20.1743654155045;
        Wed, 02 Apr 2025 21:22:35 -0700 (PDT)
Received: from hu-aarasahu-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d9ea08a8sm422344b3a.100.2025.04.02.21.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 21:22:34 -0700 (PDT)
From: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Thomas Wu <quic_wthomas@quicinc.com>,
        Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
Subject: [PATCH ath-next] wifi: ath12k: Disable broadcast TWT feature in HE MAC capabilities
Date: Thu,  3 Apr 2025 09:52:29 +0530
Message-Id: <20250403042229.2917376-1-aaradhana.sahu@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: iTazdWAkIe99aG-f2F9pRC_B5-jLwriz
X-Proofpoint-ORIG-GUID: iTazdWAkIe99aG-f2F9pRC_B5-jLwriz
X-Authority-Analysis: v=2.4 cv=F/5XdrhN c=1 sm=1 tr=0 ts=67ee0d0c cx=c_pps a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=gFoxjFOL2NOmklpzGFIA:9 a=zc0IvFSfCIW2DFIPzwfm:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-03_01,2025-04-02_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501
 mlxscore=0 spamscore=0 bulkscore=0 clxscore=1011 adultscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504030021

From: Thomas Wu <quic_wthomas@quicinc.com>

Currently, the AP does not support the broadcast target wake time (TWT)
feature. Therefore, disable the broadcast TWT feature in the HE MAC
capabilities element field.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00209-QCAHKSWPL_SILICONZ-1

Signed-off-by: Thomas Wu <quic_wthomas@quicinc.com>
Signed-off-by: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index b19e30d95560..512af779cc02 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -6717,6 +6717,7 @@ static void ath12k_mac_copy_he_cap(struct ath12k_band_cap *band_cap,
 
 	switch (iftype) {
 	case NL80211_IFTYPE_AP:
+		he_cap_elem->mac_cap_info[2] &= ~IEEE80211_HE_MAC_CAP2_BCAST_TWT;
 		he_cap_elem->phy_cap_info[3] &=
 			~IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_TX_MASK;
 		he_cap_elem->phy_cap_info[9] |=

base-commit: c0d45354abf5763f3de37d0c59fd863d193c7275
-- 
2.34.1


