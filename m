Return-Path: <linux-wireless+bounces-4164-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB1E86AB68
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 10:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A3ADB275AF
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 09:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAFB2D054;
	Wed, 28 Feb 2024 09:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LpIX4yea"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6882A15C8
	for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 09:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709112961; cv=none; b=lgSdQEJNGH9a31L507+vNpn7AqA1fAzXUhHXlR08K1StIDxcOE1CNutdrxkYxbgOdu2O6g+nlW+/OT+vipqQAK43AoxBfZZ6LnqexDD1aSDD5ZgFhpBmEm0fQh2VeLBThcl9kbMD2Z02RlufgVSfXzfnoNAYH24Efy/5fQZ/Bhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709112961; c=relaxed/simple;
	bh=tXI6m/5NmyjiibanFPcqpvba2Ycv0ByX7O46+TiuovM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Jg43V9gcdMz8hL6sXAPHU2j7WMH8eEeoPCbI9n0CV75DOTIL47KEwEocJ6tkUDQaETLb3h09iSClBzzpARNmoY6GEMcRtnLjMk+oCE+yfqsFlPIP21o8FCO8Bq1m8DcTxTmr0GmX0EaXjQqnRrEDhCy/62pR9Qk3TicAdw2XSww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LpIX4yea; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41S7xUb4023927;
	Wed, 28 Feb 2024 09:35:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=FkUitav
	nXInlvn9mmoXHDT+ZM8Fr/n/rQceqexwarDA=; b=LpIX4yeaROvgbJ4FCjLslOi
	R7/T+KwWg+dFfLNvUQegdV3u3iUDKpeVIy9FLgrPwWdLsCcuGqDNaZTkaWeMQyB4
	ZHjQzZUX/AG+ZlsHhCTayLCg0cBnbfMosN6AZwvbnHzPG00wVFOUXzApjGNv93VR
	4TrCJ23+6M8B3sjqgSleImPFsfHiLbZPa6VOBxl22haIHvNQgzBWfQQ6Eay44Zzw
	Jj4xMbbGVaH67UO4qZ9zhBQRe8905DoTMCZDh3VjX3h7wJB7i4u4I6TtOduPtFS7
	dzxfxGbB1sWFHLbgJSIB0gCuXQOYXFNYXtRpw288Wht6rmGNTm94m9QR/0Tpcng=
	=
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3whv1frq9f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 09:35:55 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41S9Zs0Y029014
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 09:35:54 GMT
Received: from Mayan.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 28 Feb 2024 01:35:53 -0800
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v2 0/6] wifi: ath11k: P2P support for QCA6390/WCN6855/QCA2066
Date: Wed, 28 Feb 2024 17:35:31 +0800
Message-ID: <20240228093537.25052-1-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-GUID: 6WyN4IFU0aUHyCLWNLODbkiv5a9R1Svl
X-Proofpoint-ORIG-GUID: 6WyN4IFU0aUHyCLWNLODbkiv5a9R1Svl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_04,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 mlxlogscore=650 impostorscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402280074

Add P2P support for QCA6390/WCN6855/QCA2066.

v2:
    1. patch #1, #4 and #6 have already been acked by Jeff.
    2. patch #2: remove unnecessary initializer in
ath11k_mac_setup_bcn_p2p_ie() and change judgement for P2P GO.
    3. patch #3: verify the validity of descriptors number and remove
blank line.
    4. patch #5: change scan flag filter before
ath11k_wmi_send_scan_start_cmd().

Kang Yang (6):
  wifi: ath11k: change interface combination for P2P mode
  wifi: ath11k: add P2P IE in beacon template
  wifi: ath11k: implement handling of P2P NoA event
  wifi: ath11k: change WLAN_SCAN_PARAMS_MAX_IE_LEN from 256 to 512
  wifi: ath11k: change scan flag scan_f_filter_prb_req for
    QCA6390/WCN6855/QCA2066
  wifi: ath11k: advertise P2P dev support for QCA6390/WCN6855/QCA2066

 drivers/net/wireless/ath/ath11k/Makefile |   3 +-
 drivers/net/wireless/ath/ath11k/core.c   |  20 ++-
 drivers/net/wireless/ath/ath11k/mac.c    | 166 ++++++++++++++++++-----
 drivers/net/wireless/ath/ath11k/p2p.c    | 149 ++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/p2p.h    |  22 +++
 drivers/net/wireless/ath/ath11k/wmi.c    | 107 ++++++++++++++-
 drivers/net/wireless/ath/ath11k/wmi.h    |  42 +++++-
 7 files changed, 471 insertions(+), 38 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath11k/p2p.c
 create mode 100644 drivers/net/wireless/ath/ath11k/p2p.h


base-commit: c39a5cfa0448f3afbee78373f16d87815a674f11
-- 
2.34.1


