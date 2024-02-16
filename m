Return-Path: <linux-wireless+bounces-3680-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4E0857FB0
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Feb 2024 15:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEB8F1F269D5
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Feb 2024 14:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE5912EBEE;
	Fri, 16 Feb 2024 14:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cjOkHVF4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED51012EBE9
	for <linux-wireless@vger.kernel.org>; Fri, 16 Feb 2024 14:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708094803; cv=none; b=bKTLFs25sBy2ZrS8AEm6oG9xt28NnBRVve+RButistY6eJhzpbyN51ggmPjwU90oH+U55zug0s6ywRZTIAzms2rzzwwlRbZ3mepFuTetreXU86SWYcIYuRkYua4hEtuBL923i63eMPigfmG+jIWkniy5H+EFvRegXlTl31NbWHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708094803; c=relaxed/simple;
	bh=o0oe8S4SGgx7LXkNEzePKou01Gn6DJFocErUNZeJ7rk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c6fKD270tR0+ai7b1da9x7rS3rAjx81iBgLZzkFFHAaHLh1m4B4oC5OU/AlEL0jQcc3THIt6RGs9U6y3pNp47BETWa7VGCwWfr67o2tyGo/f/x8CT9w1FSpcCPp05B6y+pRZaE8MupkwXqN2/aSXRitIk3ZkhxOD5uTojjiE7zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cjOkHVF4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41GBgubn011308;
	Fri, 16 Feb 2024 14:46:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=DBHJVFN
	rmuk1Lvrmjikcj96pmsT2KY3u48aJJ3LsYnA=; b=cjOkHVF4OUMb3XPIlQgmZWT
	rczzJ1m2vxiMV/yhE0YoSIeGaZzECaDss9LIpt81pGNiOZzyqC0aCvpjiBE2z9em
	lPalRjrY50CsglFcaannkaoqloF8ideAk+12aILxKUdx0KJwYhQMbcBXsLCFETjQ
	TiontRubvBd93Rumr4DEEtgcT4hkBKztiAN/Mt5XHJnbAePu9sSKLkCWo0Cmf98R
	QcyXKAs9gfSCjd5wQVZYi2AYw8ASM57ttSlKHdMQXGEl7zhg+3wDHtHtYhjXwi6w
	j4IIgYJaGC3JWAShHNE9qoW1IsYy6arOr1TEMEQ1NCvorKH2l0Hf39r2liJ3vLg=
	=
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w9wxf1afa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 14:46:38 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41GEkbEq008719
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 14:46:37 GMT
Received: from cdcwlex322514-lin.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 16 Feb 2024 06:46:35 -0800
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH v3 0/2] wifi: mac80211/mac80211_hwsim: support MLO CSA test case
Date: Fri, 16 Feb 2024 20:16:19 +0530
Message-ID: <20240216144621.514385-1-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.25.1
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
X-Proofpoint-GUID: sX3I06qAA-WKC_BzsuH7fe-D4hV_5Q3B
X-Proofpoint-ORIG-GUID: sX3I06qAA-WKC_BzsuH7fe-D4hV_5Q3B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_13,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=850
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402160118

Recently MLO CSA is enabled on the stack. Add test infra support in
mac80211_hwsim in order to support basic MLO CSA test case.

Aditya Kumar Singh (2):
  wifi: mac80211: check beacon countdown is complete on per link basis
  wifi: mac80211_hwsim: add support for switch_vif_chanctx callback
---
v3: proper patch in [2/2].

v2: handled all mode cases of channel contexts in [2/2].
---
 drivers/net/wireless/ath/ath10k/mac.c         |  2 +-
 drivers/net/wireless/ath/ath10k/wmi.c         |  2 +-
 drivers/net/wireless/ath/ath11k/mac.c         |  2 +-
 drivers/net/wireless/ath/ath9k/beacon.c       |  2 +-
 .../net/wireless/ath/ath9k/htc_drv_beacon.c   |  2 +-
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  2 +-
 .../wireless/intel/iwlwifi/mvm/time-event.c   |  2 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c |  4 +-
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c |  2 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c | 46 ++++++++++++++++++-
 include/net/mac80211.h                        |  4 +-
 net/mac80211/tx.c                             | 14 +++++-
 12 files changed, 69 insertions(+), 15 deletions(-)


base-commit: 42ffccd0a36e099dea3d3272c5d62a0454ded1f0
-- 
2.25.1


