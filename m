Return-Path: <linux-wireless+bounces-21419-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B29A85400
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 08:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D5CD3B4ABA
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 06:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF781EDA05;
	Fri, 11 Apr 2025 06:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OSwJgHG9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52919367
	for <linux-wireless@vger.kernel.org>; Fri, 11 Apr 2025 06:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744352149; cv=none; b=iSlZl5TAvGF5N2A8lOZnr4yApq4TOrae6aMa2Mo6DBPiwjr4Wn+6GsJK0O/vpLkhfHqhe71fN3rtjTVOn1T7WZTnWFHiRcaci7F893uWrnwpIpNkWjIzV5LpZFa0KTPQZmzJaqcPKnjRr/vMUXY+PHXHyL8MMGKT8qYRHm42n+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744352149; c=relaxed/simple;
	bh=YVZ14CKPQMsqgrqGHzVe8Sq+v81R9Q02SXXkFt8rqK8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jUg97reZz1viKwYozOfrdJKdC50eDQrw6TbIKt8zuvu1CCDDGCeEBXJIMtsl6X+HT53bqK/N6orEaC6GPTWv4q3rYEbCPiZbxZtvmt1/pbj+v3Zs0wHfeTkfZR5gs316VJshdbe86/V1hqMKJ93E6X0k2jZk5y0Yp0feO0zRg20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OSwJgHG9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53B50xEV018797;
	Fri, 11 Apr 2025 06:15:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=LczO5m9Vdozc6Omm7oiHJB
	qtxBUALXTbZ5uRQEtqkhA=; b=OSwJgHG9ity+a23jHJa4veGbmTA8qUsQSD2fFh
	xcqp1o7T/XB3r6D5CvXBf1WmOGa1C4g+1AThCrQ4HpQ+ylFcM/KhWLB+/g6cw14Y
	wlkBl5mm0FY/qaEQcIXPgCq50Abb9IN6xsRqM+LN3TR7fbIdwIdqQLs8/ajP8oT0
	HUixyvIaS8a0BsCrxH/Gu6O1nuPEwmnKxRp+Sn2DrQBefrLrKC8PMI7nMz9UVnUU
	yFBN+Hyfd11YP3BX5azbYVaXTwP6Hg+0fCYMwHDrfOm7Das26JzrSm8CONzWvt0s
	jIxyPBJ1p3k217kxsWYdPaEUqfTUeqi+VElFyO9Kw0dQb4MQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twdgsj2s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 06:15:43 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53B6Fgch013932
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 06:15:42 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 10 Apr 2025 23:15:41 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH ath-next v2 0/2] wifi: ath12k: correctly check RX multicast bit
Date: Fri, 11 Apr 2025 11:45:21 +0530
Message-ID: <20250411061523.859387-1-quic_sarishar@quicinc.com>
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
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=PJgP+eqC c=1 sm=1 tr=0 ts=67f8b38f cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=0b8t2eLurJbve7txGXYA:9
X-Proofpoint-ORIG-GUID: KR_vogIUGGK9xbopECu4GkGWaryrVe2j
X-Proofpoint-GUID: KR_vogIUGGK9xbopECu4GkGWaryrVe2j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_02,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0 spamscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=523 bulkscore=0 mlxscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504110043

Currently, the RX multicast broadcast bit is fetched from the MPDU
start descriptor. However, in some scenarios, the value is not
accurate. Therefore, changing the process to fetch the bit from the
MSDU end descriptor for improved reliability.

Sarika Sharma (2):
  wifi: ath12k: using msdu end descriptor to check for rx multicast
    packets
  wifi: ath12k: correctly handle mcast packets for clients

 drivers/net/wireless/ath/ath12k/dp_rx.c | 5 +++++
 drivers/net/wireless/ath/ath12k/hal.c   | 8 ++++----
 drivers/net/wireless/ath/ath12k/peer.c  | 5 ++++-
 drivers/net/wireless/ath/ath12k/peer.h  | 3 ++-
 4 files changed, 15 insertions(+), 6 deletions(-)


base-commit: ac17b1211841c98a9b4c2900ba2a7f457c80cf90
-- 
2.34.1


