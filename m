Return-Path: <linux-wireless+bounces-25566-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3B1B0853E
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 08:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6744CA45EB0
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 06:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E388B1D7E5B;
	Thu, 17 Jul 2025 06:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TuNSb1TP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54ED317B425
	for <linux-wireless@vger.kernel.org>; Thu, 17 Jul 2025 06:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752734745; cv=none; b=i+KnTXW0ZqLp+TlNSdmvACnuYYcwXNhNeimou8HvkM+5qvcpJr37c2lThJQN0z2yzQPtz165I9iXNY8/bk2fdNgYtZC+DlFD+V9EphQQAS+NohfPMcFh38SokLgjWGIIur9xVzjyoV38BP87bDPeq3uuCVPrjk5gljlOzrYsC88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752734745; c=relaxed/simple;
	bh=6vuhT4+AZlg+enoFyscX83RaCaQvx7LmAnR0yx1KhQ0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CHVItJW5OR0L2XgLH+r/HXPsQ57F2DiA4KNiRT+3NiGBqzz3E06im/bknUBGqLXYOuknZYRcSz575MUMYvkQ5iG1pihLEFf6A7ZGPmSgMQ1X4O0sT6b4Nt5tAi1DFgoY5nEPCywaizPUEabC738jIigmtn0ZJQyZWyVDz0KcxpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TuNSb1TP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56H448VX020649;
	Thu, 17 Jul 2025 06:45:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Gd45mCk4hMAW/JBS7YvwcU/6NeP4SFwZAvz
	TIld14T0=; b=TuNSb1TPaNIvJWSERUCj3QCNo5DrIQT3V+GUs4t4cS6Qq+e1eM9
	uNi8l1rz9GEh3J/QiVHAjSXgXjNHO7o2Vgjy13X1Y2KhR0evRSPlKD7wtjA5jNcc
	iS0r/xceW9mQQApnwiN22xzda67xjjFMI4NophjB7Kc0xGHgxSwYlUjOmxmXyX+8
	30MIC5XsmCEz1iLIRFJ3Gj3VW0lSRtBw3jhuwdxhU2SqLSLk4bLwwC1A1Xr6jhvd
	ahxHa6loR1nn9hGZQlBnJrcdZQ+Vt6JmPeS7kM3pvYAAy3MvHOXDFA7LZ6joLjir
	aVJIuRQUwGG9gIajD1Q7d1ieqhbi4yAqXPw==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dphk6r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 06:45:40 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 56H6jb07010445;
	Thu, 17 Jul 2025 06:45:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 47xuvs03jk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 06:45:37 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56H6jaC0010440;
	Thu, 17 Jul 2025 06:45:36 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-tamizhr-blr.qualcomm.com [10.190.110.180])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 56H6jakN010438
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 06:45:36 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 380741)
	id 67B03411A5; Thu, 17 Jul 2025 12:15:35 +0530 (+0530)
From: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
Subject: [PATCH ath-next 0/2] wifi: ath12k: Extend support to parse wmi service bit 
Date: Thu, 17 Jul 2025 12:15:25 +0530
Message-Id: <20250717064527.1829660-1-tamizh.raja@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDA1NyBTYWx0ZWRfX7jw0XHWE1cOP
 EDdt60qxmJtYlabABpuJs1qZjPm9mtUnJ8dSJR0L3jXLy+c39KmtQTvI/7F+tVSIdLQRuLnULfx
 NUhykmR/F27xkEzUt/DoMZQd+cNQjR7kWGOB3/RrbC1XaWwih/V5kLzKh2axzu7d0ajIgrKNhIg
 gLvVf0kLjcJX0coHrcBx65AjhpNkqYfTIzaqk2ejxeeVQloKaEQbcq6ccELt6otzL4P+taGUmvG
 cHwRS79VN3pXFFwjV+oYot7yXLbaL4dX8KxuEIqjBRVT5BhnwFZ6dhGapH6OrKExVbn7iQlmR43
 pd/P3pm6adyj66kAC75R2kcL3r29G/+f4Lsf4LrpqcEA6scDA+Knj4j9dmS7adfrko8i+m8yyBI
 TVMxJbPypfCA/93FG3CKQnVMfQRP7zZbqH56ASnbIxnzDLrHklUF79290K2obvVzqNRVle2T
X-Proofpoint-GUID: AiYdhNRfsR485x-2l1Y9qqeO2lArxUjX
X-Proofpoint-ORIG-GUID: AiYdhNRfsR485x-2l1Y9qqeO2lArxUjX
X-Authority-Analysis: v=2.4 cv=Y+r4sgeN c=1 sm=1 tr=0 ts=68789c14 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Wb1JkmetP80A:10 a=VqKXJ2bPb1k_lhZ8nysA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999 phishscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170057

Extend support to parse wmi service bit till the last value firmware
is advertising and use endian conversion while accessing the wmi_ext2_service_bitmap
value in ath12k_wmi_tlv_services_parser().

Tamizh Chelvam Raja (2):
  wifi: ath12k: Use __le32_to_cpu() conversion while parsing wmi service
    bit
  wifi: ath12k: Add support to parse max ext2 wmi service bit

 drivers/net/wireless/ath/ath12k/wmi.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)


base-commit: 65c12b104cb942d588a1a093acc4537fb3d3b129
-- 
2.34.1


