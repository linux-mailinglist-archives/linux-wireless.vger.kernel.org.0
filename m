Return-Path: <linux-wireless+bounces-11422-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F679518E1
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 12:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54375282C6A
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 10:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76F41684A6;
	Wed, 14 Aug 2024 10:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GpTkEf+V"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634A23D552
	for <linux-wireless@vger.kernel.org>; Wed, 14 Aug 2024 10:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723631684; cv=none; b=QoSfHjwYLeXb43OOArWCDRV1seUMcH8Rc7WelULfC6nJO1j89xuWtxB51JAZK0w+oYkHtFiqoh+Xh7ow5oNO1Xg/KB5r1CXxiip14+vq96psAgIObihn3fiLSC9CUy+QijkuJYLXWFw+OuhDixg6+G21nwUbFc4YfU8fOOdxhgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723631684; c=relaxed/simple;
	bh=ofcEBqN7CYOGulAMNB9vhyeh3+pgXikOmOnap0tByts=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X1SezEnCtn+GFHzwx5Q2JGqk0ua5T4X+F4XsBLaSR3Yd0AMmLHLOIll0nIyaHVEWIYVMreYL+9t17MSyz1BgGoM3q1fq6m4AZfk2uXMovB85PKtqWXmtKPxozarhx0++xnNry++247aG3ymwX2RPVVBIJs3Hqwqk7/kQC1fFVGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GpTkEf+V; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47E2i6wc021543;
	Wed, 14 Aug 2024 10:34:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=urEOtMyYCJIrniggQnSAI0
	GhBA/ck8b0APD6KK0PlBs=; b=GpTkEf+VjcxNFQH74YedcO1A50ZuyDbNQhbc2C
	BZRHYfK0dgrS2nd4HbOZPkahwevfwY82CKPtMJ6CHzzh/9YFj0CWnFVrNSf3OX7L
	k1+geqhvGr8Vfuc1DcnLNLVq9Ge3Tnjy9HpQeJ587qYacKfrWfVpF/7qoyG9ICc+
	sil2CX/pf5aNt9oZ/Loc4Rs1Pk8qNY7SV2xIZpwlcEoiNVYNo8MuB320BsRdQg3p
	d82BQh+w7UMMMToI0T5ngmdW6khlzp2aAsGiX6EyO4mrbgdHHXmqMlrKw8JeGnZa
	wOhIDbEDr2K5D/LNBhZq8YmnoL9uFHFWKXo6BEBDvvCmy9cA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 410m291415-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 10:34:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47EAYdWh002518
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 10:34:40 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 14 Aug 2024 03:34:38 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 0/3] wifi: ath12k: Add multi radio iface combination support
Date: Wed, 14 Aug 2024 16:04:20 +0530
Message-ID: <20240814103423.3980958-1-quic_periyasa@quicinc.com>
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
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GARY9vHkOgO1XePeyC38oo8nChcgsEox
X-Proofpoint-ORIG-GUID: GARY9vHkOgO1XePeyC38oo8nChcgsEox
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-14_08,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 spamscore=0 priorityscore=1501 mlxscore=0 bulkscore=0 adultscore=0
 impostorscore=0 phishscore=0 malwarescore=0 mlxlogscore=487
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408140073

Refactor the interface combination procedure and add support to advertise
multi-radio interface combinations when multiple radios are combined to
achieve Multi-Link Operation (MLO).

Karthikeyan Periyasamy (3):
  wifi: ath12k: Introduce iface combination cleanup helper
  wifi: ath12k: Refactor radio freq low and high information
  wifi: ath12k: Advertise multi device iface combination

 drivers/net/wireless/ath/ath12k/core.h |   3 +-
 drivers/net/wireless/ath/ath12k/mac.c  | 225 ++++++++++++++++++++-----
 2 files changed, 185 insertions(+), 43 deletions(-)


base-commit: 1462e8e1c93ecb96b5820ec28f7cbbb8a5aeb732
-- 
2.34.1


