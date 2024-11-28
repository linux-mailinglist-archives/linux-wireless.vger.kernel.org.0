Return-Path: <linux-wireless+bounces-15778-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 267CA9DB64A
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Nov 2024 12:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFF1C164A8E
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Nov 2024 11:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7A81957E4;
	Thu, 28 Nov 2024 11:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="m1FT76Eg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DCF19342B
	for <linux-wireless@vger.kernel.org>; Thu, 28 Nov 2024 11:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732792217; cv=none; b=Yd7Yyj1loSlhs34JnbuJXFEuYLIr6jlM2yq1L+y/6GTzr0gCZDmXYPdWElNf4wO1/eBufKG2g+lF6uQ6oCO9P6GGutTI+66UdirpnO0U4IJR4mrWLEdDhLSZgVNvpfud6k5NkpAn4PQfWGAx/CZZB8Jymb5QFhaJBZgiA/hhL8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732792217; c=relaxed/simple;
	bh=rfz+xyVxvZiE3ojOgK5Yr+T+B15vcbbDGG5o4SKe++M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ObXrhbfdwwIswTyibmMBXL7yMM7WUjA+6fUob09AyF7kuvOcIUAiMWeGGkgk+qN4rAKYSrOksfMfv8KSY369SRsW+IbNvOflZpFZWgQIYjpupHMi8fEw/GVQP5Bh15fK8DuNiwdDVHDtWDnGjNl92IfwVbx99zJobneQ6ITfZgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=m1FT76Eg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AS8gxD8020148;
	Thu, 28 Nov 2024 11:10:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=amhivvQN9SZICnCYujA8p9
	Yz6VVkamJGmYrZtVY+8rw=; b=m1FT76Eg/wVtAV9B6xt3OWMh0CHfLTGp7x7ofk
	iXx2gp0FEFjAGFnQs7xAD5eymZHNpSuNaCmpA1oBWoYN3TS32MQ0y0lLmf0t6c72
	tUu4B01VfjlgCnTHxpDY84z4ZSazQrJ97D7hYO4kIH2H0wgvODSPMbEbsEIlvGbZ
	cMP5flZAS9wV7SyYKsvDYfWlAgm5j137id5IrAzIpwtEmO0Wowha8hOW8htBPFpu
	AigXEeayJ+BKaSQiQ4k3En/7glLb1Pu+200YCfxbK85NDvSH1Lwi1zOG/YmbkGz1
	j7IRb5jRId0aojyGe61qvhgj6lJGEa/PXSR/+s12eLi+sA0g==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4366y02cef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Nov 2024 11:10:09 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ASBA8rh012991
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Nov 2024 11:10:08 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 28 Nov 2024 03:10:06 -0800
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
Subject: [PATCH 0/2] wifi: ath12k: Support Rate and OFDMA Stats
Date: Thu, 28 Nov 2024 16:39:47 +0530
Message-ID: <20241128110949.3672364-1-quic_rdevanat@quicinc.com>
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
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -cUttUm1PFF9HHVwxhKu5X9QCZzgOqwM
X-Proofpoint-GUID: -cUttUm1PFF9HHVwxhKu5X9QCZzgOqwM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0
 mlxlogscore=688 spamscore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2411280088

Add support to request HTT stats type 31 and 32 from firmware,
respectively. These stat types give transmit rate buffer stats and
transmit buffer OFDMA stats, respectively.

Pradeep Kumar Chitrapu (2):
  wifi: ath12k: Support Transmit Rate Buffer Stats
  wifi: ath12k: Support Transmit Buffer OFDMA Stats

 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 345 ++++++++++++++++++
 .../wireless/ath/ath12k/debugfs_htt_stats.h   |  99 +++++
 2 files changed, 444 insertions(+)


base-commit: 175616a7658cd5d53389d1f9c1ce22debd4595a5
-- 
2.25.1


