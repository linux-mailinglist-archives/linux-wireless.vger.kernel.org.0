Return-Path: <linux-wireless+bounces-14311-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A269AA0D5
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 13:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D29D4283B5F
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 11:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD01199EB7;
	Tue, 22 Oct 2024 11:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IqQrw4YV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7156B18BBA9
	for <linux-wireless@vger.kernel.org>; Tue, 22 Oct 2024 11:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729595341; cv=none; b=tFDq9OUmaPOwi0eitvu7KnOAXzX45wvpvTKbT2HiKI75CNwNj/NviIQmlI7qL8dDvz8PpJ46fTzzLvP9WgipYuExk+DYhk1f6CaOLimX+Fp8zXlkJDTeM4cUvmcHoFQrU1ahL/7o/RO1QSRpUIfgCIguOHS0Sok6FITverm86Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729595341; c=relaxed/simple;
	bh=EjFOXPExtp7FI9TjsAR9dH3M80pJD8vwlhnwqCKJwt0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DoRineE3jfGf2VEF8R6Fy62+EV4IDqaVM+9LxFPVbUhS7ZblSdLj6KK1N/RN05CPgJGaSOH+QxQQUERCpfkI9WfK486/4kDJUuv5JNHxoa5RxMpytc9xrxxbAHMYlMnY48D3Ufm0LtlF82HuTVunNv+8FrhDPOEKqDXBP8Ms5hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IqQrw4YV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49M9QxS5023350;
	Tue, 22 Oct 2024 11:08:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=hPO3xKSoekFunDZjeYcBia
	l9uhKJQ5IA7vgGbwupwMs=; b=IqQrw4YV+Q6TYr/7STfyPkoW2kz5Rsw8QGPIpZ
	e0HAyW2+YJkX2LOOdIlHimVKKyMdPFml2L/cOnKc+rywjtMFl/exugaeLFlX5AAT
	AcGONdvFEodWVMfPPrZBL6OdwlJmLuKD5Ax74teW21U7CYFBGa8lhAm7TmiRxNFG
	sVqMEUv56WELchHl0kZiGSD8WidykhVBOZPwuyztuu/5TaaEMhWFDp2GIdAbaOD9
	0MYOnwwZlbuha0Bz+h/wW4gfU1hkRHKwzuXXbd08hXd8bUhe1B9fV7UEXMEp9UXC
	p43hlJCwv41ZV5MZLl+rFvimHi17DjcCTftpvoUMoc6dAWZg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42c6vv018y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 11:08:53 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49MB8q6t010547
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 11:08:52 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 22 Oct 2024 04:08:51 -0700
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v6 0/8] wifi: ath12k: some fixes and clean up for monitor mode
Date: Tue, 22 Oct 2024 19:08:23 +0800
Message-ID: <20241022110831.974-1-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1.windows.1
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
X-Proofpoint-ORIG-GUID: qu_31RpAgjggxNQVSo-twGEtFNGfLyHp
X-Proofpoint-GUID: qu_31RpAgjggxNQVSo-twGEtFNGfLyHp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxlogscore=962 bulkscore=0 spamscore=0 mlxscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410220071

This patch set does some fixes and clean up for monitor mode.

v6:
    1. mention the change is also needed by QCN9274 in patch 2-5.
    2. mention the change is cleanup for patch 6.
v5:
    1. rebase on tag: ath/ath12k-mlo.
    2. remove patches which have conflicts with MLO branch.
v4: rebase on tag: ath/main(ath-202410161539).
v3: rebase on tag: ath/main(ath-202410111606).
v2: rebase on tag: ath-202410072115.

Kang Yang (8):
  wifi: ath12k: remove unused variable monitor_present
  wifi: ath12k: fix struct hal_rx_ppdu_end_user_stats
  wifi: ath12k: fix struct hal_rx_ppdu_start
  wifi: ath12k: fix struct hal_rx_phyrx_rssi_legacy_info
  wifi: ath12k: fix struct hal_rx_mpdu_start
  wifi: ath12k: delete NSS and TX power setting for monitor vdev
  wifi: ath12k: use tail MSDU to get MSDU information
  wifi: ath12k: fix A-MSDU indication in monitor mode

 drivers/net/wireless/ath/ath12k/core.h        |   9 +-
 .../wireless/ath/ath12k/debugfs_htt_stats.c   |   8 --
 drivers/net/wireless/ath/ath12k/dp_mon.c      | 108 ++++++++++--------
 drivers/net/wireless/ath/ath12k/hal_rx.h      |  53 +++++----
 drivers/net/wireless/ath/ath12k/mac.c         |  14 ---
 5 files changed, 97 insertions(+), 95 deletions(-)


base-commit: d9a3c1c3649e000fe709b6fdbf94b1069a5d6778
-- 
2.34.1


