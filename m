Return-Path: <linux-wireless+bounces-14312-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5434B9AA0D7
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 13:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3E7BB213CE
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 11:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D8919AA46;
	Tue, 22 Oct 2024 11:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fHQugz9H"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24EE1993AF
	for <linux-wireless@vger.kernel.org>; Tue, 22 Oct 2024 11:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729595341; cv=none; b=Q21XANyoRsTcMt6nejkT0f3l+WmlePUny8y7/76HbPJrm6ta3Qpj6Zm9LlDhn0RjCb3UXM/jLYor576vRyU7enSj6OXSIvwBqfoIiImcUgZBoUdxrBgL7yDjDeHmOgzg8UTbuiLpCaQOhWAaznF6taO2MIhyuhnNmAUMvX2MPIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729595341; c=relaxed/simple;
	bh=mOVpCyWWQZZQ6fF34QjPWupQkTU5DjHr9L6KhXJGfHo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XP8MjtPdKrv/iBfn4iyx+q2RbVJ2+C5dElqpmP3rI0yPNBe+3Yo7H3hkdzs+yA3hk8zERW17ml2vvCP7L+8o0DxuwVKd3V0hQKRKrTQp7PbhgV1vFUG3/NlfSEHQYz/9ODBPrN2q2gkuEBdeM+Ro7km/b7SIiIz28DJUygoBmsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fHQugz9H; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49M8j8dE017139;
	Tue, 22 Oct 2024 11:08:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AT8IM7dGlh4w7Wm/i4xqTehVvmW0MDupNWwi7S4xI0o=; b=fHQugz9Hyxd70wAp
	JIOac+Dz8SZKUMxOpPi/qRYnQlj+f+V55trfluZtZw1ShwgrzLrE250G6ekvpLpX
	p+oxlmEPBubb5bbJXrLMDHRWQazwd1ZNETiMQvgOfZrff0Tc1pd4459GCaNwW4bX
	IStrghM1LQBBIiy66OEyBkr81Sfn8G79++flyCuPXuIG9EPnoDGd8OufSeLkafVQ
	T5dwfMTTl5z58z9TtTSrideL8rhcVLbWw+9U0Yb7nUUj5fCBQjVNFiwf1NLtAoso
	GwxNaINK3kGbiTu1nX9gjV9gQiAHJEgHq4Xgz4MuiWTE3oHq1Wx0WetLiP9VkuAG
	IJdS5A==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42dmdqbwbd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 11:08:55 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49MB8sUH012118
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 11:08:54 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 22 Oct 2024 04:08:52 -0700
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v6 1/8] wifi: ath12k: remove unused variable monitor_present
Date: Tue, 22 Oct 2024 19:08:24 +0800
Message-ID: <20241022110831.974-2-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1.windows.1
In-Reply-To: <20241022110831.974-1-quic_kangyang@quicinc.com>
References: <20241022110831.974-1-quic_kangyang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: e2EedMZrcQF-Q05NSDp6113X6GNnDYsC
X-Proofpoint-GUID: e2EedMZrcQF-Q05NSDp6113X6GNnDYsC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 adultscore=0 mlxlogscore=739 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410220071

Variable monitor_present is not used yet and will not be used in future
monitor mode. So delete it as cleanup.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 23283ec3a81c..3410fcaac128 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -610,7 +610,6 @@ struct ath12k {
 	u32 chan_tx_pwr;
 	u32 num_stations;
 	u32 max_num_stations;
-	bool monitor_present;
 
 	/* protects the radio specific data like debug stats, ppdu_stats_info stats,
 	 * vdev_stop_status info, scan data, ath12k_sta info, ath12k_link_vif info,
-- 
2.34.1


