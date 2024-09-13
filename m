Return-Path: <linux-wireless+bounces-12844-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0190977CE9
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2024 12:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EA8D1C213FF
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2024 10:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F59A1D7E33;
	Fri, 13 Sep 2024 10:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="E75AKj5b"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7081D6C47
	for <linux-wireless@vger.kernel.org>; Fri, 13 Sep 2024 10:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726222076; cv=none; b=mYstyeY0UArzIqOsP5LkToXibn924HgFI114T5mHdp9q+FSx1uACpPfVgRLfoDYmbmGIgAiUGRambGWfIi3o2rCJ7C50l9aTQG2wJinufS/LOwbb8/9IL64yYQzVRCfiQN8WfojLHNYUVeLwJTByF5qJWPNdFEe3SQarSD12IHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726222076; c=relaxed/simple;
	bh=v+CLiHqPAuolaE2BbaxzCMnAwXVcXhSzXh3q9LLu9W4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mBydtOdQzbX78dkYrhA6hb5r2XTx2Rh9Bo/JTWyVujFG3qD8sAEvNCJstCsLLYoMMSoK60OTPhm+0ldSGfqCJVjYKiYKsWcg9qBfADXHSOKl6c7QiK8bas1wQqpXnE4FUHTZ565HYOboMCPaTnGPQDhx7bmbPJX+y9s4RwjbUeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=E75AKj5b; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48D9iJgK004004;
	Fri, 13 Sep 2024 10:07:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=iXUNVmeaFT0h/18epsogM6
	Zum1NUrf14kSHlNYHMCnA=; b=E75AKj5b0mfSOy35nuYxREsOmzCJR1AjeCw+YU
	ElrmJmcp03Ee0zDbadKnHp93m0+zkiqoB56iZE1jpi9krZO+FTpLj6fbZVdKB5Ib
	5yDQznaO927Y2YQc+Hw6azizy4sWbkCZW/Nkn0tMJcVdAb5XYkRz/74R5XO6AFjk
	oWkuZ3vdkNkyJWYZIbPqdo5qjMqoWR/7yaA9JCWryE6Z709aIlObraHMoYg4uPVg
	35F3EV7Vzqoxjy6mEqL60++Krff/jVzf+AQ8S6G2zDCs8t6xtVBzPDyxQk5iWH6x
	AtQyQjdIRIYEGL7BCG4fkiey+Q7xpsgy7GmIzYETr4ufo+pw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41kvma3yb7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Sep 2024 10:07:43 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48DA7gev016199
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Sep 2024 10:07:42 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 13 Sep 2024 03:07:40 -0700
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH 0/2] wifi: ath11k: fix full monitor mode
Date: Fri, 13 Sep 2024 18:07:06 +0800
Message-ID: <20240913100708.756-1-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1.windows.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: mR92xQyFFtEWQHuRBfRV4SMuaq5tOd-8
X-Proofpoint-GUID: mR92xQyFFtEWQHuRBfRV4SMuaq5tOd-8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 phishscore=0 mlxlogscore=723 bulkscore=0 priorityscore=1501 adultscore=0
 mlxscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409130070

Fix a warning and a bug for full monitor mode. With these two fixes,
full monitor mode can work properly to capture packets.

Kang Yang (1):
  wifi: ath11k: add srng->lock for ath11k_hal_srng_* in monitor mode

P Praneesh (1):
  wifi: ath11k: fix RCU stall while reaping monitor destination ring

 drivers/net/wireless/ath/ath11k/dp_rx.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)


base-commit: 0606024b89d4ba59586cc7023d361a22065da8fa
-- 
2.34.1


