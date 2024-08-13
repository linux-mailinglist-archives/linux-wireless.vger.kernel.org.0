Return-Path: <linux-wireless+bounces-11340-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C77A94FFFE
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 10:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C62471F25632
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 08:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3605213A244;
	Tue, 13 Aug 2024 08:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SnNYeaPa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4A113A888
	for <linux-wireless@vger.kernel.org>; Tue, 13 Aug 2024 08:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723538309; cv=none; b=jBbHvFj7M+meKSml4k4PlOBTP+UJ7RAq0EisZZeC39axU7jTHFD75Qlsr05MRyu2MiHqPVCEhoArPVvjS0uc1vlTSc5YFMlmNzanKLdiCxsp7o8kuuHDn8d66H1dvh4M/05bU/K8psZ6VFV9tsqif4QpBZiRwkvEausTJsSgARw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723538309; c=relaxed/simple;
	bh=r0b1FjiKxq14dmo6Ji8sTs1m/fE0reZWN1rkHzhl3L4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NBqTdPQIkcWVACLtDMLK6DDn7kWpYscMXfhO804hip7M4EViFODr/FUM7+yfGYGTXuYtnE0lQR5vVUSfaNdaLoV+hDBb0QmQvwT2/6cGdC9+tO1PN0OQTEagM7q9jchpxiE3CTFyCNvWRKRzrExXI4Jyknvmnbs3TsTmlv8awTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SnNYeaPa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47D3tprC003693;
	Tue, 13 Aug 2024 08:38:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=I8wIVfjXOOTwLUjPgTAScn
	KaFhW7VjbjyVT+ndBv61A=; b=SnNYeaPal24E2YYgrwl+juK4IhkWRif1dRSlAp
	NnXPNvkxMT+d9Qs5rDD38f9rt40kA6VpzT+qL6wKknEM6RH+kxVFtbOc2S9jmqKy
	U8Q9lS7rvHQbweFtugSUjwYNz9uEPkPXDvPI1x92oNTzr1BCvQeLKguwmVPoRAlB
	aYXWsXX6tw0VMaGMwu+QTknJd8l/FC3ot69HcY/hTWxuTUf15uqmJSe7zDjuFnnl
	M1+9HvGmszRccrPGAAwDBVwZgXhXfWbB26/XWKYw98YS6bSTTAXYJw6+z/zbXQGY
	vhwRC22Jrcl89TfnO3sxTUQrmajolyI7lMZ76qAYzF0TstxQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40x17sewhj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 08:38:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47D8cLxB007036
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 08:38:21 GMT
Received: from bqiang-SFF.lan (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 13 Aug
 2024 01:38:19 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH ath-current] wifi: ath11k: fix NULL pointer dereference in ath11k_mac_get_eirp_power()
Date: Tue, 13 Aug 2024 16:38:08 +0800
Message-ID: <20240813083808.9224-1-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pYwA4Wm6ejphJ6t_sV8NHhjZoMggwEFf
X-Proofpoint-ORIG-GUID: pYwA4Wm6ejphJ6t_sV8NHhjZoMggwEFf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_01,2024-08-13_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxscore=0 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0
 spamscore=0 clxscore=1011 priorityscore=1501 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408130061

Commit 39dc8b8ea387 ("wifi: mac80211: pass parsed TPE data to drivers") breaks
ath11k, leading to kernel crash:

BUG: kernel NULL pointer dereference, address: 0000000000000018
RIP: 0010:ath11k_mac_get_eirp_power.isra.0+0x5b/0x80 [ath11k]
Call Trace:
 <TASK>
 ath11k_mac_fill_reg_tpc_info+0x3d6/0x800 [ath11k]
 ath11k_mac_vdev_start_restart+0x412/0x4d0 [ath11k]
 ath11k_mac_op_sta_state+0x7bc/0xbb0 [ath11k]
 drv_sta_state+0xf1/0x5f0 [mac80211]
 sta_info_insert_rcu+0x28d/0x530 [mac80211]
 sta_info_insert+0xf/0x20 [mac80211]
 ieee80211_prep_connection+0x3b4/0x4c0 [mac80211]
 ieee80211_mgd_auth+0x363/0x600 [mac80211]

The issue scenario is, AP advertises power spectral density (PSD) values in its
transmit power envelope (TPE) IE and supports 160 MHz bandwidth in 6 GHz. When
connecting to this AP, in ath11k_mac_parse_tx_pwr_env(), the local variable
psd is true and then reg_tpc_info.num_pwr_levels is set to 8 due to 160 MHz
bandwidth. Note here ath11k fails to set reg_tpc_info.is_psd_power as TRUE due
to above commit. Then in ath11k_mac_fill_reg_tpc_info(), for each of the 8
power levels, for a PSD channel, ath11k_mac_get_psd_channel() is expected to
be called to get required information. However due to invalid
reg_tpc_info.is_psd_power, it is ath11k_mac_get_eirp_power() that gets called
and passed with pwr_lvl_idx as one of the arguments. Note this function
implicitly requires pwr_lvl_idx to be no more than 3. So when pwr_lvl_idx is
larger than that ath11k_mac_get_seg_freq() returns invalid center frequency,
with which as the input ieee80211_get_channel() returns NULL, then kernel
crashes due to NULL pointer dereference.

Fix it by setting reg_tpc_info.is_psd_power properly.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30

Fixes: 39dc8b8ea387 ("wifi: mac80211: pass parsed TPE data to drivers")
Reported-by: Mikko Tiihonen <mikko.tiihonen@iki.fi>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219131
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 71ef89be823b..f8068d2e848c 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -7912,6 +7912,7 @@ static void ath11k_mac_parse_tx_pwr_env(struct ath11k *ar,
 	}
 
 	if (psd) {
+		arvif->reg_tpc_info.is_psd_power = true;
 		arvif->reg_tpc_info.num_pwr_levels = psd->count;
 
 		for (i = 0; i < arvif->reg_tpc_info.num_pwr_levels; i++) {

base-commit: 1462e8e1c93ecb96b5820ec28f7cbbb8a5aeb732
-- 
2.25.1


