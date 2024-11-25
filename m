Return-Path: <linux-wireless+bounces-15680-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D429D7CF1
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2024 09:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D363A281C43
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2024 08:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39ECA2A1BA;
	Mon, 25 Nov 2024 08:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aKqsdE9H"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4AA376
	for <linux-wireless@vger.kernel.org>; Mon, 25 Nov 2024 08:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732523571; cv=none; b=m2tOQIh+iKUSdKQ5h72ONo7KUIK5h9nKERPUBgBExZiTT0fGlTRo1mj8AqpFQnUVFwT7yamu8RmYDMM0g6MEekwJdkLpzDr35LZUIZaFQVp6HnVeWoCdXj61q1bKVT3/bXiVJYl6rJVSjCba4s7BdnLuTeMOuSg+Z46bK66zY6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732523571; c=relaxed/simple;
	bh=XtkdSfxc8++8CZEFNG6yYreZiOGRmhl6JC1fPFGumCo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BEJA/XzZDDqiME7lv3Lbm1z0GHP8vVp9W0kZCGwKCSV8v6PQ30RDeHWZyOo5qj3SixS4LbnunJq1sN14/M2ZFjIuXxkJ5dUTJuI7SHRY7SG28tFs82ob32iEiNo+iO76ABXX4ejoH6j/db9EHGG37+Zgnd96n2EfhDML6gqbEQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aKqsdE9H; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AOMOU6P013724;
	Mon, 25 Nov 2024 08:32:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Vclhx5fiO9uM8dQAzFf0xQ
	zIIUMY2WAMzo07tDdSYy0=; b=aKqsdE9HmJOV06YOJlu9fUJxDxDvWGBxk9J4Zx
	LMizFhSTAhVvzFs91yn+geeEBV7goGk7CyIsn+osLGmvkPigtLmnXf+qj/sgur8L
	mwnVf39z942A20AObU8vEWSo6b4ys7ZHGbIAs6Pfi6F8tcK7lplFlH8ZzX6QxTy+
	JA9WYr6Tz6PEqVq9fJECDtVl2yuStdKcicdDL6Ec1nr9B6oFOfzKsdaUqpUUHUWB
	KYS7kzREf4wEWhmip3R+zwwFqMDnNhtXYsmZpWxwKwnuRv4RJaStxSTy1wuslimn
	MQ8UPOLjcCP3xHP7za2PTUHWzkhe5uByOrZTX3kACxlvaaRw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4338b8buyw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 08:32:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AP8Wif5008591
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 08:32:44 GMT
Received: from hu-ramess-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 25 Nov 2024 00:32:43 -0800
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Rameshkumar Sundaram
	<quic_ramess@quicinc.com>
Subject: [PATCH 0/2] wifi: cfg80211: add support for fetch tx power for MLD
Date: Mon, 25 Nov 2024 14:02:15 +0530
Message-ID: <20241125083217.216095-1-quic_ramess@quicinc.com>
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
X-Proofpoint-ORIG-GUID: ynTyxoa9SZJceoUvjExVjY5X-NL1WwyE
X-Proofpoint-GUID: ynTyxoa9SZJceoUvjExVjY5X-NL1WwyE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 adultscore=0 mlxscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=547 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411250072

Currently tx power get requests doesn't carry any
link information, but multiple links can be affiliated
to an MLD and hence there is a need to do get tx power
per link.
Add support to get tx power for all valid links of an MLD
and report them as part of GET_INTERFACE command.

Rameshkumar Sundaram (2):
  wifi: cfg80211: send MLO links tx power info in GET_INTERFACE
  wifi: mac80211: get tx power per link

 drivers/net/wireless/ath/ath11k/mac.c         |  1 +
 drivers/net/wireless/ath/ath6kl/cfg80211.c    |  1 +
 drivers/net/wireless/ath/ath9k/main.c         |  2 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    |  2 +-
 .../net/wireless/marvell/mwifiex/cfg80211.c   |  2 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c |  2 +-
 drivers/net/wireless/mediatek/mt76/mt76.h     |  2 +-
 .../wireless/microchip/wilc1000/cfg80211.c    |  2 +-
 .../net/wireless/quantenna/qtnfmac/cfg80211.c |  2 +-
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c |  3 +-
 include/net/cfg80211.h                        |  2 +-
 include/net/mac80211.h                        |  2 +-
 net/mac80211/cfg.c                            | 16 +++++--
 net/mac80211/driver-ops.h                     |  7 +--
 net/mac80211/trace.h                          | 10 +++--
 net/wireless/nl80211.c                        | 13 +++++-
 net/wireless/rdev-ops.h                       |  7 +--
 net/wireless/trace.h                          | 44 +++++++++----------
 net/wireless/wext-compat.c                    |  2 +-
 19 files changed, 73 insertions(+), 49 deletions(-)


base-commit: dfc14664794a4706e0c2186a0c082386e6b14c4d
-- 
2.34.1


