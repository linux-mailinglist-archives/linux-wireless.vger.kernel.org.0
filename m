Return-Path: <linux-wireless+bounces-7321-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 218A48BF38D
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 02:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCD7E1F257E7
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 00:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CC07FD;
	Wed,  8 May 2024 00:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CPwZKkRH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3338F5B
	for <linux-wireless@vger.kernel.org>; Wed,  8 May 2024 00:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715127676; cv=none; b=dIidb5cQkEQyawpYMdyaeMGh2iZllV0wo4WNGkz2bQY5YFlXyDPGFe8OhrxtHTuxO+j1EkSVxUKK59Z0b1t9Gg+JVxSU5dtihBebUASTsX6K5d+AiEWAsPXgcMFmUEd4Llf4Z/UbKwY4dTXqZ05+5tcWvzgo0Bd6i3kNs89MweQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715127676; c=relaxed/simple;
	bh=/Ha/6nm/7eJ7pRrDIvHs/5svG4VvAribTgY9wDESIvs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BbbwFq15hi7IZE0BRSqaBAddgxzlX2UsFq3rlfxPJW/pbnl4Fww7NSyMMW9Qlfuo+/BEV5MBVvzBBXxuK2bCIszsl20GgLMALKrzWKGFEje8JdClqpB0xCokhs8hFyVds8l0NBjpqZgaCjPBMqelpRJytLFurJCmJL/ADh4Hiz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CPwZKkRH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 447MKcrF015960;
	Wed, 8 May 2024 00:21:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=Qwh/a5S8ULVuwap21l2v5pn9kX5ayh0r5pCCfMAkiyg=; b=CP
	wZKkRHZVGyqiRuLFQe8Ue4rVQgW5bud1XfU2rjqACudsWdp64G0IwXANjPJSvXkc
	RmDN5Xm8b/x96UI3bcuNg7Hpyba5roelZWMY17TTEwpso9UumXTVHo292Yc6F2Ze
	7c1dijCEG/wPKK/THKn/KqEcmVRnzuZO1tIuYDz1tMVAAdnLrxYu619JRK8f7J8O
	g9Eck4sdFLMvtjXQk2CzImrv8ZJEr+34zCfTLg9RYVt6h+XSywEIv+12lGaiwaAl
	ZsD8CDtJgxcD+J0Af8WOcD2Argfj0xjyc9iIeZG8SUBe9LapdkZuC1XlTvZ+HPGA
	OaqDwrOrySCFu/C9hDXQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xyste0hxc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 May 2024 00:21:06 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4480L5ij023320
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 8 May 2024 00:21:05 GMT
Received: from pradeepc2-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 7 May 2024 17:21:05 -0700
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu
	<quic_pradeepc@quicinc.com>
Subject: [PATCH V4 00/10] wifi: ath12k: add MU-MIMO and 160 MHz bandwidth support
Date: Tue, 7 May 2024 17:20:45 -0700
Message-ID: <20240508002055.17705-1-quic_pradeepc@quicinc.com>
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
X-Proofpoint-GUID: gYVsKEmCjg5SwsMfLGbNgmy6sSAA0Dza
X-Proofpoint-ORIG-GUID: gYVsKEmCjg5SwsMfLGbNgmy6sSAA0Dza
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_16,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 bulkscore=0 clxscore=1015
 mlxlogscore=999 spamscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405010000
 definitions=main-2405080001

Add support for
1. enabling MU-MIMO in HE and EHT modes from hardware
2. setting fixed HE rate/GI/LTF
3. 160 MHz bandwidth in HE mode
4. extended NSS bandwidth support

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

changes in v4:
 - Fix ath12k-check warnings in patch 2/10 and 7/10
 - remove "hostapd" reference in patches 2/10 and 3/10
 - remove redundant prerequisite-patch-id's in cover letter

changes in v3:
 - address review comments for fixing ath12k-check issues.

changes in v2:
 - Amend mac80211 patch description as the patch is not specific
   to AP mode.
 - Amend EHT MU-MIMO patch description to specify future support
   for STA mode.

Pradeep Kumar Chitrapu (10):
  wifi: mac80211: Add EHT UL MU-MIMO flag in ieee80211_bss_conf
  wifi: ath12k: push HE MU-MIMO params to hardware
  wifi: ath12k: push EHT MU-MIMO params to hardware
  wifi: ath12k: move HE MCS mapper to a separate function
  wifi: ath12k: generate rx and tx mcs maps for supported HE mcs
  wifi: ath12k: fix TX and RX MCS rate configurations in HE mode
  wifi: ath12k: add support for setting fixed HE rate/GI/LTF
  wifi: ath12k: clean up 80P80 support
  wifi: ath12k: add support for 160 MHz bandwidth
  wifi: ath12k: add extended NSS bandwidth support for 160 MHz

 drivers/net/wireless/ath/ath12k/core.h |    2 +
 drivers/net/wireless/ath/ath12k/mac.c  | 1052 ++++++++++++++++++++----
 drivers/net/wireless/ath/ath12k/mac.h  |   17 +
 drivers/net/wireless/ath/ath12k/wmi.c  |   24 +-
 drivers/net/wireless/ath/ath12k/wmi.h  |   98 ++-
 include/net/mac80211.h                 |    4 +
 net/mac80211/cfg.c                     |    5 +
 7 files changed, 994 insertions(+), 208 deletions(-)


base-commit: 74893410e635fc9a5c7f1a7cddd262b4a7ae624b
-- 
2.17.1


