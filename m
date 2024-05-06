Return-Path: <linux-wireless+bounces-7256-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D54F48BD6C7
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 23:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ABA41F24003
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 21:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499E6156258;
	Mon,  6 May 2024 21:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MGYjaG7t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B9115B553
	for <linux-wireless@vger.kernel.org>; Mon,  6 May 2024 21:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715030433; cv=none; b=NLmTkh9E9qeKGOQjEQlVplvFsdK5PapigXe6eWLBpJbUj0Occ5as321auQimqkwvbOUDadQUkqIh1gp1hcc0lwSenjW43sB+ZXOQaPDDaDpkVbnnDk2jaDq9jEhlRe0lb5WqSREJS8X5F+Wke/bndur1Cy1yQdkuHgGqiqPnzVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715030433; c=relaxed/simple;
	bh=Z8UjTnz5BAC2AgLjBkClsOpFXVkLf6DXP7ngjUEfYh0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=obw8LT/elqBqiX+exydb8AOz1E0D0rMyTg9Opff83gI35nnB71W+nl9JYEWXWuUHNeXpvqMeiMl/PlGbThp+MZvMdj/TeUGiszyl0+38eciDZuKv6mnI2H++UM+OJngbwdy/TfS3BRs/VmT+0OPwCvoeI64c4DKWMHewTH5SgQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MGYjaG7t; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 446J9x9n031767;
	Mon, 6 May 2024 21:20:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=lTgXVZ2
	M12/ebLSRTcLP5G68+Xc4vk749Y5vRzWCua4=; b=MGYjaG7ttKraVKGK2xlseS3
	IHtNUOqz5FFg8GDUkWC/XSMbRLfC/FjYrxUyz6qW4ED+QXMeqwTx+DffO5dfPubu
	fCbTWNnnOhSTXC4CAq65OvqPIXhqWZXKiOSHS83p7xfYtZFSzyQw4zBRxnPrGJCX
	hC3vcIGMdQ4kxyafx9g5ZZ4jiwkzoCvle6WQWizXDLY+XnDq2rnhrvyA5HI2sRCD
	pqxEMq4mTtXfpNCPzMaAHs8FI9x8GR8l4K2y+pQSApja0yG0fNXc0aOmIF6LG2Dv
	hqxof3WAtg7jCC9K9GiVWMkBQTu91/6bAkwdAJXVcscuCEw9mHODxEM6BcsCIqg=
	=
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xxwqds9cw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 May 2024 21:20:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 446LKQiF018531
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 6 May 2024 21:20:26 GMT
Received: from msinada-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 6 May 2024 14:20:26 -0700
From: Muna Sinada <quic_msinada@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, Muna Sinada <quic_msinada@quicinc.com>
Subject: [PATCH 0/2] Allow VLAN unicast packets to take 8023 xmit path
Date: Mon, 6 May 2024 14:20:12 -0700
Message-ID: <20240506212014.670423-1-quic_msinada@quicinc.com>
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
X-Proofpoint-ORIG-GUID: DSljRMfuu14XY76Q-o300jkEKXoytz86
X-Proofpoint-GUID: DSljRMfuu14XY76Q-o300jkEKXoytz86
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_15,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=410 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2405060155

Allow VLAN unicast packets to take the 8023 xmit path when
encapsulation offload is enabled. This allows AP VLAN unicast
packets to have encapsulation and encryption handled in hardware

Before doing so, relocate __ieee80211_subif_start_xmit() definition to
allow it to call ieee80211_8023_xmit()

Muna Sinada (2):
  wifi: mac80211: relocate __ieee80211_subif_start_xmit() definition
  wifi: mac80211: VLAN unicast packets take 8023 xmit path

 net/mac80211/tx.c | 177 +++++++++++++++++++++++++---------------------
 1 file changed, 95 insertions(+), 82 deletions(-)

-- 
2.34.1


