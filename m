Return-Path: <linux-wireless+bounces-17672-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 859CEA15AF2
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Jan 2025 02:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A1B2188AB05
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Jan 2025 01:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B0717C61;
	Sat, 18 Jan 2025 01:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="A/Krs/iX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A441078F
	for <linux-wireless@vger.kernel.org>; Sat, 18 Jan 2025 01:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737165265; cv=none; b=LvlcorkvMycjljcC8eABOjBaYSd49UFRhTnZFCb363pNMT275iY1sicFwOatyuZnkkD2qxvd1j6ezspOVCFt4CeH/Tkw0y60EzQ25yQOw1vlVMuG214Z87J0mhcL5EfBr94eXuLalRGiDnzkmOjh/83SgXM71qoNnVmIXS9lDLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737165265; c=relaxed/simple;
	bh=cjPiTn8UpyE8JjKnWCdiY1n89CfJ3uLTAeTWq5WdVII=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pgoNTh7N4EEqFKuv/pIOas3SUJlVTx03AVpkIfCajfXWRxzaAxtopWv/sLn/m1IdoTROiVde/8k5QkpgcF503tpxceVsf0uJiLy9YQ5w5xs6pz7N7+74PVO0Mh2JalIRFOYxP+8bGYVCkYovu/l5G6OP0wV2P8nw79Tr1oAURLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=A/Krs/iX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50I0gXJH011713;
	Sat, 18 Jan 2025 01:54:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=FfpycIEV6CYC5m7cr4JGl7
	PJFrRL24pKq3AXGKGOOUw=; b=A/Krs/iXp1T+y8RM7XLunkeudSE3W0c/J8DoBO
	jM9+BG2uiUtfNzurlLaOtfhPx1zf9vTV4jWJhVv4rhG5GWSPMGyAFC54M/kXPlLL
	+A8Zo7Vj7olW1nt1WhBBLIyhH4j1mmYWl98epVzKngVurLLm+cVt+hwSdAXpW9lX
	30TihCVp90gee38RMNFtiJHLypmWyuLjMhCWtDtQdBqqWzoZwfM7gSO0OD9F3BGL
	9thVR6W1lhosCdgVdsx3ZWEU5aKwrOVxUf1cTkNsYNreigGAcUYIsAdbiFDh9B6Q
	ukd03e1uab6/PP94pXpBikin1vJfeMLdZ5Kep8pq3shrHFzQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44820cg309-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 18 Jan 2025 01:54:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50I1sDZL021147
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 18 Jan 2025 01:54:13 GMT
Received: from msinada-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 17 Jan 2025 17:54:13 -0800
From: Muna Sinada <quic_msinada@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, Muna Sinada <quic_msinada@quicinc.com>
Subject: [PATCH 0/2] wifi: mac80211: MLO handling for Dynamic VLAN
Date: Fri, 17 Jan 2025 17:53:58 -0800
Message-ID: <20250118015400.1919688-1-quic_msinada@quicinc.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-ORIG-GUID: C7P5wZEYVv0sIGbyU7j8blcRxO4QfRZg
X-Proofpoint-GUID: C7P5wZEYVv0sIGbyU7j8blcRxO4QfRZg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-18_01,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 impostorscore=0 phishscore=0 mlxlogscore=384 suspectscore=0 bulkscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501180012

Currently for AP_VLAN interfaces that are a part of a MLD master AP,
links are not created for the interface. Additionally, mac80211
handles duplicating multicast traffic on each link when a driver/hw
is not handling such action.

With the introduction of MLO, there are two areas where additional
handling is needed to enable Dynamic VLAN traffic: creating separate
links for AP_VLAN interface and enabling mac80211 to send multicast
Dynamic VLAN traffic on each link.

4addr mode + MLO is not currently supported.

Muna Sinada (2):
  wifi: mac80211: Create separate links for VLAN interfaces
  wifi: mac80211: VLAN traffic in multicast path

 net/mac80211/chan.c        |  3 ++
 net/mac80211/ieee80211_i.h |  2 +
 net/mac80211/iface.c       | 23 +++++++++-
 net/mac80211/link.c        | 86 ++++++++++++++++++++++++++++++++++++--
 net/mac80211/tx.c          |  6 ++-
 5 files changed, 112 insertions(+), 8 deletions(-)

-- 
2.34.1


