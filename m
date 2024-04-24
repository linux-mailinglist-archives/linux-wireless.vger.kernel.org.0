Return-Path: <linux-wireless+bounces-6788-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 560DF8B146B
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Apr 2024 22:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D501C283466
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Apr 2024 20:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4379714265E;
	Wed, 24 Apr 2024 20:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XaKnCRLl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1104413C9C6
	for <linux-wireless@vger.kernel.org>; Wed, 24 Apr 2024 20:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713990021; cv=none; b=Dvpaef/aMdVPj+H//So2qjyD62arN72TfBG9jnF5FnRKZXHKrURnd7IsXrTG8C47Tm9MpTgxuHIvbH8XtPlhpBhcUAiy0lQgnUuY206/tStRls+n5K/0op6GT3oDkgK/bsprNO6Pok+k4c8+3zaRrrcwG5PgPExP6hDLksTnUWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713990021; c=relaxed/simple;
	bh=fI/S7k2jDjWlPtCswYf72yH96T8WB2USDUjWD32S1Hs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OdJZ9MADhDn1CsT0X1+DIX6MOxexZBBhnUq93AxY2fBGUObttFsHQS/lzOdRY9fEgNCTxDb5iu+fXwPRC0fBt+ktrJJGfaRfXvw2P52VJWSU6poeLEcIsk6QkadPS9uQhW0YJrKfgtTNq8Eo8HvD2IPQYjSmtXF7i6rjiwd5cMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XaKnCRLl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43OJDEt4004615;
	Wed, 24 Apr 2024 20:20:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=IznUM1KaJFLBtlqZQK6fWICbBdx9BMGr92EkCwie1xY=; b=Xa
	KnCRLlTK6wbIAIW117xKvQcTkMNoFRd8k+np4h/2iOhawv+A1olTw30RdCjveowD
	+LcYJrjw92m0v9KhWvR9bINA+iCctUdHqOHWNePAaz04en3/HdCn3O/ajY5LUes+
	GoRV5Pu0MUtVoNnTMHPxhRJoO0XhhLi9VXVkgxsZKm7LK4HgbsJ++3M+FGdgWx7R
	PsFxhU3VsW7JnScAwZKOhCpuC0oMCtHG3VpjIpsd/2ak6WPliElVvb9yKv5R/6Ey
	hWxAdvP35SSvhewADNp8mIDFxOQ3D2pnOMY+yrXa6yKHnCrplTKAGom7vlOgRXHq
	g/JMPk0BKyMtY7Up26pA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xpv9pj3ep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 20:20:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43OKKAxs004254
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 20:20:10 GMT
Received: from pradeepc2-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 24 Apr 2024 13:20:09 -0700
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu
	<quic_pradeepc@quicinc.com>
Subject: [PATCH v3 00/10] wifi: ath12k: add MU-MIMO and 160 MHz bandwidth support
Date: Wed, 24 Apr 2024 13:19:49 -0700
Message-ID: <20240424201959.935-1-quic_pradeepc@quicinc.com>
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
X-Proofpoint-GUID: arSF5yNNjHpmaVSpTAeJMhxlEHpNtTdN
X-Proofpoint-ORIG-GUID: arSF5yNNjHpmaVSpTAeJMhxlEHpNtTdN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_17,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 mlxlogscore=999 clxscore=1015
 adultscore=0 malwarescore=0 bulkscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404240101

Add support for
1. enabling MU-MIMO in HE and EHT modes from hardware
2. setting fixed HE rate/GI/LTF
3. 160 MHz bandwidth in HE mode
4. extended NSS bandwidth support

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

changes in v3:
 - address review comments for fixing ath12k-check issues.

changes in v2:
 - Amend mac80211 patch description as the patch is not specific
   to AP mode.
 - Amend EHT MU-MIMO patch description to specify future support
   for STA mode.

Pradeep Kumar Chitrapu (10):
  wifi: mac80211: Add EHT UL MU-MIMO flag in ieee80211_bss_conf
  wifi: ath12k: push HE MU-MIMO params from hostapd to hardware
  wifi: ath12k: push EHT MU-MIMO params from hostapd to hardware
  wifi: ath12k: move HE MCS mapper to a separate function
  wifi: ath12k: generate rx and tx mcs maps for supported HE mcs
  wifi: ath12k: fix TX and RX MCS rate configurations in HE mode
  wifi: ath12k: add support for setting fixed HE rate/GI/LTF
  wifi: ath12k: clean up 80P80 support
  wifi: ath12k: add support for 160 MHz bandwidth
  wifi: ath12k: add extended NSS bandwidth support for 160 MHz

 drivers/net/wireless/ath/ath12k/core.h |    2 +
 drivers/net/wireless/ath/ath12k/mac.c  | 1043 ++++++++++++++++++++----
 drivers/net/wireless/ath/ath12k/mac.h  |   17 +
 drivers/net/wireless/ath/ath12k/wmi.c  |   24 +-
 drivers/net/wireless/ath/ath12k/wmi.h  |   98 ++-
 include/net/mac80211.h                 |    4 +
 net/mac80211/cfg.c                     |    5 +
 7 files changed, 986 insertions(+), 207 deletions(-)


base-commit: 1a17b8f9196db4d5b9f81f69cac885ba8c832da7
prerequisite-patch-id: 6cb82354d93f2d3d0e61dca59b7939e1bae2f263
prerequisite-patch-id: b93a6cfb7a9caa843eb4a1df2d400b56b548188f
prerequisite-patch-id: bbf8aa44334b11e860f4b68c22607110e81498a1
prerequisite-patch-id: 70140f291ade3c2db0a0f36fe1c7c7d93eedfdeb
prerequisite-patch-id: c52742e59bc5db2742ab66ec16175e983b88fb72
prerequisite-patch-id: 8f9c43d387ec6bcf807f53dc17dcaaaa21c8a03f
prerequisite-patch-id: a36bcb4e892019e5dcc39854088371e1c20e4ebf
prerequisite-patch-id: 42864cd08f6d37e14f1794d29e13f8a094e489cc
prerequisite-patch-id: 67eb3991126edab717635666297a6a910adbb8c1
prerequisite-patch-id: be513e07c8fbbc556d3b61f2356d0a4391901ba5
prerequisite-patch-id: 6dd663b6660f5f8d49fbd3e49023d0fd851100dc
prerequisite-patch-id: 77ba10656791f90eeeb88ef749829b1474de4280
prerequisite-patch-id: ec4c06aca44fecabfbdbf305581c60587cf23e63
prerequisite-patch-id: f24c686941a9136ff7d800a726fad8c5d5d3b1b1
prerequisite-patch-id: 14c827bfdc875273056194059bcd0cb042db123a
prerequisite-patch-id: c1adce3c611529902e3a19a74f775cfffbba69b3
prerequisite-patch-id: a4ff79eb14ba0e59508ce72e0d0eca56da2b6060
prerequisite-patch-id: 66d93f366737e1a4b1e3c0a10747994b39bdd49a
prerequisite-patch-id: 4890b86b151fad62b5a37688d813696f507cd9b1
prerequisite-patch-id: 58918f67d676fafe5c527c83d1401da8cd30cb41
prerequisite-patch-id: d6acc523424cd3049f471191406d456625a903ee
prerequisite-patch-id: ce6f394abfaa9dbf2e818379850b911ea380e8ff
prerequisite-patch-id: 92fc0dabdc596b6d1f4940a8be86f9558dabede9
prerequisite-patch-id: 34f4bf81393b8f035604eca6fb13a964dc933fb0
prerequisite-patch-id: d14a14bb3e1b22afdce181eab811e4151b837b7e
prerequisite-patch-id: 275f221e85124f4cccac788a2d109dd71bb611f8
prerequisite-patch-id: a68de371d003e45f93defbadaa164ce016f62b43
prerequisite-patch-id: d156ad9d641c02cb2b00bb2a9bb3952f1ee1eda5
prerequisite-patch-id: 022d675781d55b377befb1bfa73cdd13eb544919
prerequisite-patch-id: cd0f4fc60b3e60fd5daed4c4aef5ff836a1d6afe
prerequisite-patch-id: 2d8e31915fb462a006aa36a878afc722dae702f1
prerequisite-patch-id: 6db9ebc02e7aff5b0dd6a791bcb56b174b8f5075
prerequisite-patch-id: 8ab4b749c404278c6f3284e7626f7fc34f4c168c
prerequisite-patch-id: 3132da2b7c8c7c62e27c995c81a2805898bbecf5
prerequisite-patch-id: 47954405bc0dd7a3b89981a1f62b2942c6690321
prerequisite-patch-id: 9394e4f195275a48ccc6feb79a69391bd5a081ac
prerequisite-patch-id: 73a8dedb5b3270e36d08453ecde5a1eda1d488df
prerequisite-patch-id: 0b51e47032752aff3d731c060f9ec63de49d6efa
prerequisite-patch-id: de40f7811a733a0e14e2bb9e263e632a488c350a
prerequisite-patch-id: 018f54a2e185dac93eb3ff126a3dcfe830797da7
prerequisite-patch-id: 65c73a3902c82ed46fd45ba3e02477746b80f43f
prerequisite-patch-id: 0a3e374a2927cc6b36aa886562ea74197f3e31e1
prerequisite-patch-id: 197d9f2f52a4f397bcadfb097f66026aec7d8531
prerequisite-patch-id: 0d2aedbe585ef88c171a8e6e07c88cdbc4269194
prerequisite-patch-id: 445f5b16f72a183fcf92eadbd1329902267ecfc5
prerequisite-patch-id: c753615aebcfe5d7419d00f11ef94c41618032d1
prerequisite-patch-id: b15f736df11c88fb96a180e0d928a6e1cd0c0f34
prerequisite-patch-id: 6eb961cc481ac73a4e17b2338814fb2f86b02b2a
prerequisite-patch-id: fdddada4c012b7d7cc79d1e17caccac67ee63bef
prerequisite-patch-id: ffd8fb7974d49d06574ab4b97b0ca74a3b2e5e21
prerequisite-patch-id: d56eb0552657a692d6db25fb1badba1f06769c07
prerequisite-patch-id: 468fad8de3fef4b8c470408fb1db12edd4a195c0
prerequisite-patch-id: 9f816eb8e25fa683f06c2f5e5317ac7a51d57ab9
prerequisite-patch-id: 734bba56b6da8d0ba773c335e1da4926fe8b8035
prerequisite-patch-id: 8db71e2c9424eb2d1296c73100d34c8f9bcdde0b
prerequisite-patch-id: bdadfa11d95682aeb60202635ce434c98e451c20
prerequisite-patch-id: 3af02179828c0bb21ab1d4bd9ff61231ef091162
prerequisite-patch-id: 861aa5786a781f71cf5adfabc531ca6b61ef1c72
prerequisite-patch-id: b3df68b21838ded80f002482f69d7a458776cf99
prerequisite-patch-id: 11d0c8923fe6f22cebf2afcd57e3bf7c8f36b4f9
prerequisite-patch-id: 599e5c0a6a6c9e9a12ee422f4af9340c0b465f67
prerequisite-patch-id: 13952e429c380cd716c6f449df3dcedaae109479
prerequisite-patch-id: 07c9ff6fcaf4ba464be993caa19eb49113eedbdf
-- 
2.17.1


