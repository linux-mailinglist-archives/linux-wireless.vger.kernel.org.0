Return-Path: <linux-wireless+bounces-18376-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D6AA26B6D
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 06:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F8283A6BD2
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 05:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB431E7C3A;
	Tue,  4 Feb 2025 05:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZFpPJPtn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1891F19ADA4
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 05:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738647328; cv=none; b=KTgSrPwnxLuDS/fy/c2yREj1oWzYJVvglqoc4Xghzvds5ZiugSNmfvFwNsG7U6tYuKhFOE+oHU7gussnAuh+I7wk+ZL9CzZb3uGv0gNSVULYAwWxU7dHXdpPEzMyFxemrO5jjWwqdrn4zmtyIyDSoC4rg42c4/7vKr1GYAms3Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738647328; c=relaxed/simple;
	bh=mF66OwhkKnhAlxYZ6nAf3WS/q2ZRZB09JI+RiCVnQ0M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SAZL+ZePQk4H4VPMtZwmM1LHXWtAlqsKr+p7L/QmI+DPJclhW2CNprTW2+kDv6dKITtU2rI50ypIDIen827+5/kLzbpyQkh4TKCIuVvpWpFQqEkDj4cpvIkxU/OlcWGN0aSzfIeF6YNJMAmNXMYqz9RrGF3xwZRwLEgwh5MwHC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZFpPJPtn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514586o2008404;
	Tue, 4 Feb 2025 05:35:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=bQ4V0VCj7hMWrM3BocVp6f
	IFc3eDUH6lzkPJd4TQxUE=; b=ZFpPJPtnmS2TuNsa5myOZ1RW728LXbjkGbiQbA
	5xknSSN/Zy6ZEzlOBX4BsLefrCqQeVPhrRcH3BQBlE1FtrDZmNYkRL72opmgmzE+
	efwTBDItOnkj+tL+5vAN8pkGQryRTDXyZN/CbO9Jix5vbwfAE8hh4TQUue9626Kg
	m/fguZpp9CDgVUlO6mM9CEgoOB6sEb/lTYxDfV6xWQWHcmzOeT7Ccz+9rKjhkd8o
	bc/b0X6mGRwHVODYj+TWzF8WcM1WqUc3Q4gPcT2KZMCMna7tBH5nPweNSe+we+Qf
	JCKsaeVmQqy8DsnAc+oBQqe+JkIiLGw9fcKtgJLB7rYTeD7A==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44kcfp01rd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 05:35:23 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5145ZMHf026788
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 4 Feb 2025 05:35:22 GMT
Received: from hu-surapk-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 3 Feb 2025 21:35:20 -0800
From: Suraj P Kizhakkethil <quic_surapk@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Suraj P Kizhakkethil
	<quic_surapk@quicinc.com>
Subject: [PATCH 0/2] wifi: ath12k: Pass correct channel frequency parameters
Date: Tue, 4 Feb 2025 11:04:49 +0530
Message-ID: <20250204053451.2703834-1-quic_surapk@quicinc.com>
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
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Z8PBsYUOx8heEifo2CmIPsE_XXQ5tgNR
X-Proofpoint-ORIG-GUID: Z8PBsYUOx8heEifo2CmIPsE_XXQ5tgNR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_02,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1011 mlxlogscore=861 malwarescore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502040043

For higher bandwidths, the channel frequency parameters passed to 
the firmware are incorrect. Pass correct values of channel 
frequency parameters.

Sriram R (1):
  wifi: ath12k: Pass correct values of center freq1 and center freq2 for
    320 MHz

Suraj P Kizhakkethil (1):
  wifi: ath12k: Pass correct values of center freq1 and center freq2 for
    160 MHz

 drivers/net/wireless/ath/ath12k/wmi.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)


base-commit: 48a62436540224f57013c27519dd2aa3ddd714c9
-- 
2.34.1


