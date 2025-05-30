Return-Path: <linux-wireless+bounces-23500-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4A5AC8715
	for <lists+linux-wireless@lfdr.de>; Fri, 30 May 2025 05:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77E184A3B25
	for <lists+linux-wireless@lfdr.de>; Fri, 30 May 2025 03:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F192254652;
	Fri, 30 May 2025 03:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EY+qoztZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FECB1A5B92
	for <linux-wireless@vger.kernel.org>; Fri, 30 May 2025 03:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748577419; cv=none; b=H4W8+AMfObDPPMM+fqmxwKdQAVkV0zZH/7IgfLXiUAlOcmfBOiIQvzcEFHwuOAJ6X/CU1akT54z9zSxlcRhA/LT4EX/hYIx73VSTRstfC2GnltZIc4h5ho50WEjYWW4rxp4XgF2Yh/9B2cpKp70+ntv2FQMYps9QAm7UZdXXpyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748577419; c=relaxed/simple;
	bh=vBhD3vQL58QYJRbAPlg7dvfo8T5loW4rBGSMs3HG2lo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kA/HkmDx9zzwgMvgbA7STfMCLxWNM59EboL9EbnYlJ5v1UX1HfPdtWCcbnMtIOfj99/8ouHAA5np1u0bQ3U54NHbSTtpI0y94DRV7CPVcM03mBqiraT47IDwsjPhyO5SmVTnxxISpAdKT0lyNr5gIzE7NNEpdbXMwSwa9lEY970=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EY+qoztZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54U0ePQ9004885
	for <linux-wireless@vger.kernel.org>; Fri, 30 May 2025 03:56:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=LnLydFVJZUo
	t5z+c5Is9dilBnJF30AZGWpIs1hJLjiI=; b=EY+qoztZl4aEzBP3MQNGqjVZE7E
	KX/Pq/BmklpXCnVuCL5lu4cnYM5mVdJntK0MJ+AmFh3uS60O4YG5E0m8Id1/DIqf
	QsnDXvg9nbqTMNJwoMuexESCRKsm/m6HZmtDKTccRvLQhSNMaZf163qM85FHdBKo
	v/UZJllaHMNdChgevDnVtka4sBCmOSORTzFwzrhzxNeT4fHxEXVm3XhHZ5tYbrgg
	AfBtddUtPWvLoW1yCCNDxHnSlcjC7xsviYN3aYqWhhwHL+WXwlgTFeOTsi8x9+G5
	MW7QRO05rM4Xe+NigcyQkavDSp4EssBTTtourw475Cd0BMVElJaLysShnJw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46u5ek7hqf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 30 May 2025 03:56:56 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7429f7f9ee3so1266996b3a.2
        for <linux-wireless@vger.kernel.org>; Thu, 29 May 2025 20:56:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748577415; x=1749182215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LnLydFVJZUot5z+c5Is9dilBnJF30AZGWpIs1hJLjiI=;
        b=lWeh3C4Acg8VWWdHJigdjsecDs0fCM0+kWbNaqcpdsy0899SWKOOxF42bRF5gHAl+8
         vR3moUpHBmbpnH0gGFHo+ZtO3pZKsPrnVkW1nV5uAYGzQ77PNaaQtF0+F+0oI5Z2oXJM
         Vp/vhIILrhyxBizA/Ei5+zyyLjQ8BmpEx2CES4pgtUfWqCdAKKEKzAn0yQXYf3cvTvGN
         ap4KyzQwaEMJII4FIAeJt34NwlCMWFlXt8S1ENYj2Ru6OBbq0CMY3Q0CmtEVpzL9WqmQ
         no9bz5Te2e/iY3vSaTBGrHu3tgw9u0npsAZVlo4pH1h/g3SkJf/UPb4saWxvCFCiOBvS
         VyiA==
X-Gm-Message-State: AOJu0YwtIK3Kb6tsPmnTwdA1kh+8FyXgmonjRvFW6BWVOfR/414WGxJ0
	gNWGLFHsjlpYGWLBo0NeQMWau5hOXhERsQfhDkFyFKdpoKzGGputwRCC6ZisPlVIzbAb6iuaWhQ
	8VN2JhWvxtVWA2JCNkDa53t9gOZMWG8ceEM5fj/WXT54OfrpJ0BUrT/Q1TVask927m8YBgw==
X-Gm-Gg: ASbGncvalEnqBteONL8O67nchYmeK/9GxVxw5PfkJNOp5fa/vRGwN/AZk9sMBdGfyEg
	SjHCqnuXnHdejZhrcl/uaf0cpS8VKRHn7Ci4QFIMITEuo90A8q3dxyMLi1IdjBiYLL4RuuqXoH7
	xKDbIlSPOYDTDoJWwhhdshOMs56wt04IDwdP7MJxs1tcI77CNbCicBy189uduUfSmMtGKPsO9E2
	6RQOqKVqgFzL41TYQmaQJoaTXFLhLsxnpbVwnyynemNjKPdFig1e/pLRJNQSDDTmRmoSivVbmOB
	oS4Cois10CR02YHuO57LQhCaYG2D7jOD5hZOuwNMX/+6txzIHlwVWGcXDszS+BmXFzHqsv/AGzW
	MSSeBgjAQeS+CziO7zpRqgNlB1IcLwDfH1wNnpG0H
X-Received: by 2002:a05:6a21:2d8c:b0:203:bb3b:5f03 with SMTP id adf61e73a8af0-21ad94e20aamr3346493637.6.1748577415168;
        Thu, 29 May 2025 20:56:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHYzR86d/0VVQ6l0O0L351Zs1467IxLWVb+m5KUlGsppEWboX/Of0JElOahDkEMxYiPdb1vg==
X-Received: by 2002:a05:6a21:2d8c:b0:203:bb3b:5f03 with SMTP id adf61e73a8af0-21ad94e20aamr3346458637.6.1748577414755;
        Thu, 29 May 2025 20:56:54 -0700 (PDT)
Received: from hu-ramess-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2eceb96fe8sm705274a12.59.2025.05.29.20.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 20:56:54 -0700 (PDT)
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Hari Chandrakanthan <quic_haric@quicinc.com>,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Subject: [PATCH ath-next 1/2] wifi: ath12k: Fix station association with MBSSID Non-TX BSS
Date: Fri, 30 May 2025 09:26:14 +0530
Message-Id: <20250530035615.3178480-2-rameshkumar.sundaram@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250530035615.3178480-1-rameshkumar.sundaram@oss.qualcomm.com>
References: <20250530035615.3178480-1-rameshkumar.sundaram@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GIgIEvNK c=1 sm=1 tr=0 ts=68392c88 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=yksjwJa0xvd5-aT1PIcA:9
 a=OpyuDcXvxspvyRM73sMx:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: JdIQHHKlNaKLHgMDVd_mH0fNv2Yeku8k
X-Proofpoint-GUID: JdIQHHKlNaKLHgMDVd_mH0fNv2Yeku8k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTMwMDAzMCBTYWx0ZWRfXx+t1YtLc+Tqr
 AJqVS274xLfByl3CocZStC8Yc21/a4B9VZIZHZooEH9Dy8oEaIU1kEdZ3wnd3Opb3ydh+7pGEzp
 hisg9MwygWx5dWHIgla6iVoVamSS8fxU4VJ/BDbmVE4x+vjHYN37+ZldRKbrbdJIvoH0HXT4NSj
 fFXPDt2dw+NqYZXPWfQSA2AiKRzhCKUbxS8Q0ONhPSaSIkPymSTFr8OVuyxyphuGmyhkyOFkq9m
 pkWEQhaxFElRTbUpE7cQoPu6G+VHg78fBb/Ly5agC1+QsNZPinUr8b+culjHNJeUhiwJ2f/Rzji
 hvepsMDhFfvr9xvtpgatUh8zRG8yU18ojHdVVjrukZourIdKem9yqVbiNNFSghHvQkkQ2ic8H9z
 FCXL9C1QckXoYum/ap+R7DJ4x8BnOnVVjd/KifHJt2bN6HQYbUWiBQZGK7z5j+0HIfMo+7g9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-30_01,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 phishscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505300030

From: Hari Chandrakanthan <quic_haric@quicinc.com>

ath12k station is unable to associate with non-transmitting BSSes
in a Multiple BSS set because the user-space does not receive
information about the non-transmitting BSSes from mac80211's
scan results.

The ath12k driver does not advertise its MBSSID capability to mac80211,
resulting in wiphy->support_mbssid not being set. Consequently, the
information about non-transmitting BSS is not parsed from received
Beacon/Probe response frames and is therefore not included in the
scan results.

Fix this by advertising the MBSSID capability of ath12k driver to
mac80211.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00284-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1

Signed-off-by: Hari Chandrakanthan <quic_haric@quicinc.com>
Signed-off-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 81ff32d2ce5a..5183a7e43e51 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -12078,6 +12078,7 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
 
 	wiphy->mbssid_max_interfaces = mbssid_max_interfaces;
 	wiphy->ema_max_profile_periodicity = TARGET_EMA_MAX_PROFILE_PERIOD;
+	ieee80211_hw_set(hw, SUPPORTS_MULTI_BSSID);
 
 	if (is_6ghz) {
 		wiphy_ext_feature_set(wiphy,
-- 
2.34.1


