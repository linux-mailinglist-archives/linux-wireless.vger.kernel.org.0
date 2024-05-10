Return-Path: <linux-wireless+bounces-7429-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9498C1E5A
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 08:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED8BF2853C5
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 06:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66345490E;
	Fri, 10 May 2024 06:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="d+H8vLcJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6CD1361
	for <linux-wireless@vger.kernel.org>; Fri, 10 May 2024 06:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715323689; cv=none; b=MoPIMNruUhrJCIUClFK36e0UwDVVXP6yo3sb2EeEcCW28UkSlUdU8Lwwish68sFBIL6LszQD2A2hzo+Mh/EewnNzSB2peG82SLWaeuYhR5bOAIMkfeFmHGzupQ32I2xr4EHRX696uuE7cRUG8ncYofrSto8XIudk0+c74yAYuV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715323689; c=relaxed/simple;
	bh=qBEdZwApaXD5+TNs+yal6aONsvFGrT1UHDMfcIAobPg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DTrB874Lx/7vZtgKu4NplJrk7DfgNrbMi65hHNiUs+FbLFnHtbj9zugwtWIY9ksiNJ/88eQLpdkbfc2ADZiJ5ZiKz0W/KOGrjW3E5S+WwFbCzMV0PhRCkmpQpbIpLSBIBtUuBkLkdqRCPFrOHLvQ+cTM21GIrT8nf/WACTl16t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=d+H8vLcJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44A2ua4F014570;
	Fri, 10 May 2024 06:48:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=Pd1wYFZ
	VI4nWz8fO2Y1exIIfp70OFjIwe33JKa1CruU=; b=d+H8vLcJC3wiyUugTyCDn2N
	BmC+m2A2rZjoaJCbyhWoVUhhbMzl1x+VMEq4BKBc1on0VXikjghL9gSu/gulhzMD
	CHK4AvOq4Al8VBwbGSq7JmuTZ4cqEZDaLOLL0z+eabcPWf7/NpUuhnLBBLmATqSa
	32+paY7tHKEGyOXxirezF0YNoaWHLdZO/98I6Zv6RscvqqL91YIKV761ON2IIzGv
	3QrX9Y/wb6BP55+sctLUfHxfjISxbUdmJ7272b2dvTrqJQaL+9yJyOkJhrPLXQOC
	XEvdRzqDvlQX2r7KJM0guo4FmCDsF9IJx8Pndybfp1E07andCnKr5KyamGBA99w=
	=
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y16w10se1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 06:48:00 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44A6lxRN011550
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 06:47:59 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 9 May 2024 23:47:58 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH 0/7] wifi: ath12k: add support for WoW
Date: Fri, 10 May 2024 14:47:41 +0800
Message-ID: <20240510064748.369452-1-quic_bqiang@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 54h8vDxdgkmYEiHe23lOTZW6YA72YSrt
X-Proofpoint-GUID: 54h8vDxdgkmYEiHe23lOTZW6YA72YSrt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_04,2024-05-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=494
 lowpriorityscore=0 impostorscore=0 clxscore=1011 mlxscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405010000 definitions=main-2405100047

Add support for WoW (Wakeup on Wireless) funtionalities, this including
magic-pattern, net-detect, disconnect and patterns, HW data filter, ARP
and NS offload, GTK rekey offload.

Also enable keepalive before suspend to avoid unexpected kick out by AP.

Baochen Qiang (7):
  wifi: ath12k: implement WoW enable and wakeup commands
  wifi: ath12k: add basic WoW functionalities
  wifi: ath12k: add WoW net-detect functionality
  wifi: ath12k: implement hardware data filter
  wifi: ath12k: support ARP and NS offload
  wifi: ath12k: support GTK rekey offload
  wifi: ath12k: handle keepalive during WoWLAN suspend and resume

 drivers/net/wireless/ath/ath12k/Makefile |   1 +
 drivers/net/wireless/ath/ath12k/core.c   |  48 +-
 drivers/net/wireless/ath/ath12k/core.h   |  37 +
 drivers/net/wireless/ath/ath12k/htc.c    |   6 +
 drivers/net/wireless/ath/ath12k/mac.c    | 252 ++++++-
 drivers/net/wireless/ath/ath12k/mac.h    |   4 +
 drivers/net/wireless/ath/ath12k/wmi.c    | 719 +++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h    | 559 +++++++++++++++
 drivers/net/wireless/ath/ath12k/wow.c    | 878 +++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wow.h    |  62 ++
 10 files changed, 2557 insertions(+), 9 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath12k/wow.c
 create mode 100644 drivers/net/wireless/ath/ath12k/wow.h


base-commit: 1025c616ee13372f3803b158abb1d87ef368ae3d
-- 
2.25.1


