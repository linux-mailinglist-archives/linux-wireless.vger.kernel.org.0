Return-Path: <linux-wireless+bounces-10170-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E585192DE37
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jul 2024 04:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57F15B20FAE
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jul 2024 02:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78923201;
	Thu, 11 Jul 2024 02:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="c5x+LXqz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5C2383
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jul 2024 02:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720663443; cv=none; b=FdMaUBR8palCDXuSVycPs10cDE/VnqjL4Rn70bwBD2szGmjLT9xUVtO8wO5rZQuV3duEVYoh5kHsCqvzK+JcIl0fQkpAwxP4kcH12DcY8jL9vJDVlWR89DYbBnh9phxzBFFlmIQqgS6aa0e/4T3iQrePqiUJeTSaDs5YL00HZ04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720663443; c=relaxed/simple;
	bh=AoqeZ4AvqmzTGvhzSjvnkv7UwEjunf9duOuYIFuCXUY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FgsM96rVFbcGQMWXrwR72Fbzs059uwoHyBK7hxWqMkjDSTa2EidusR7jx9oWTMv09ZJjMnCtwgwb+Qg6jMPjh520cGYyKqQ+1Ej8wyV8wcA8jJOj7xei54H1wXh+VefSWKyaE7K0+Hk1sbwwVAtmzxDQZnVhPhz/SquWQcrb96c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=c5x+LXqz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46AKv75F023320;
	Thu, 11 Jul 2024 02:03:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LfMfUBJl7OBMOT3++1P4Z26+bZ+k1VaHOjDB21+Bems=; b=c5x+LXqztknlb+Lf
	G2BdLcpTzzP+lhytRZyKWNUsLH1qb1o4CUO/yj1RIREXVvVngxAgW+/0kIKFxSyT
	LiA/rJnUzqY0GSGu21oUFO6VBbO0b8hzSe1vBt1OxasM6mSb1gvfPE32haczDPjk
	0J7HaiDnjCMTN4YJPZhqVunfa8kh2duGA+xUCQ8QmnYcoSL81pfiHM6xFUWJ68D5
	IUDEqC0wXv4ywQo6wyklsdH18SjglV+I4WpQPf1GyI0flw0uqfQPX8Wtp0DZ8Bz+
	D0rDRMSsP9rEQj3YDH98uhbH8rIVYfPN1WeLFOUg5c1auS6m029bHPwVsmKQp7ma
	LwAbLA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406y3hjje8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 02:03:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46B23wgb001656
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 02:03:58 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 10 Jul 2024 19:03:56 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath10k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH 1/2] wifi: ath10k: fix invalid VHT parameters in supported_vht_mcs_rate_nss1
Date: Thu, 11 Jul 2024 10:03:43 +0800
Message-ID: <20240711020344.98040-2-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240711020344.98040-1-quic_bqiang@quicinc.com>
References: <20240711020344.98040-1-quic_bqiang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: dHvZnhozxAdSbF7qxIuVuoKd5iRlv9Vf
X-Proofpoint-GUID: dHvZnhozxAdSbF7qxIuVuoKd5iRlv9Vf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_20,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 spamscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=999 impostorscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407110012

In supported_vht_mcs_rate_nss1, the rate for MCS9 & VHT20 is defined as
{780,  867}, this does not align with firmware's definition and therefore
fails the verification in ath10k_mac_get_rate_flags_vht():

	invalid vht params rate 960 100kbps nss 1 mcs 9

Change it to {865,  960} to align with firmware, so this issue could be
fixed.

Since ath10k_hw_params::supports_peer_stats_info is enabled only for
QCA6174, this change does not affect other chips.

Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00309-QCARMSWPZ-1

Fixes: 3344b99d69ab ("ath10k: add bitrate parse for peer stats info")
Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Closes: https://lore.kernel.org/lkml/fba24cd3-4a1e-4072-8585-8402272788ff@molgen.mpg.de/
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath10k/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index a5da32e87106..3c34f3d8e555 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -9121,7 +9121,7 @@ static const struct ath10k_index_vht_data_rate_type supported_vht_mcs_rate_nss1[
 	{6,  {2633, 2925}, {1215, 1350}, {585,  650} },
 	{7,  {2925, 3250}, {1350, 1500}, {650,  722} },
 	{8,  {3510, 3900}, {1620, 1800}, {780,  867} },
-	{9,  {3900, 4333}, {1800, 2000}, {780,  867} }
+	{9,  {3900, 4333}, {1800, 2000}, {865,  960} }
 };
 
 /*MCS parameters with Nss = 2 */
-- 
2.25.1


