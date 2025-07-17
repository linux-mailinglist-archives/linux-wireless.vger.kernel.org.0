Return-Path: <linux-wireless+bounces-25618-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74128B0934B
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 19:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3A51189F5C6
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 17:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5692FD874;
	Thu, 17 Jul 2025 17:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OYJUE1rY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068A41F95C
	for <linux-wireless@vger.kernel.org>; Thu, 17 Jul 2025 17:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752773756; cv=none; b=P53pLux1+CjlCokOizqiyPBF4y8pnw73WUsbRKm+IE2p9sy8CTJmEIGaJ21Uahe3Ccj4IJ4Q0ZSCdTeZXZlaT59Wan5Hdidc1qqRoxbTHRF2Uojx9Pg5s8/ZSRojYVfZsDifcbDm9wreXf5y6wtw6wE3DGNRvZZUu63Vp2clAy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752773756; c=relaxed/simple;
	bh=5ibM1Ytq9AxsfzCxvr+5m76tJz1o9hjO5IoiVNoq3Dk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ry+K/hD4qoIrxkyTbXMOuSTpUlGi8iYf2mZCSapDsjMyd3biMWtOjmgA7YmRN1zxg72MEInYd7kRfYTlpDUpVgLpfzzgJm/nNY4aVWcgD69diU3T3iG81mX+qLgOKG28Fjqp+Tv66r8zSS7wa7P279Wg+BLGUSaSrHPTn4+y1SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OYJUE1rY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HBk1GJ022239;
	Thu, 17 Jul 2025 17:35:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=rvDDOwlAfh07/HCzM7218UDU9HsLIY6jh5N
	b5g1s6DA=; b=OYJUE1rYvAnZTgLRhcnCQoUu87EPXRLwJWrqRgxflEn7X4L5xGl
	x3HYv2+Zh/96jdVmX0z8r0hFry8VigLVKjpYPb561HMnGwVvR2bFqNPyvTbpwNqG
	UsgTu0DeXsb658/Lb81asHG0tmpYo8x85bcChyRbvn+F+lms9DGw27qHLoaCP4RW
	gQJM2HAXhxtiO1CYNahahDkQSRspd9fBGMMSFPK+tNQj5qsVsYgIgmaFbVw77Wkj
	pTZQghatholywurQk/o2uJ1hXjnusb2a99vzQZu1IvYZO9oOs7izuiNgWDliyIb0
	abSHZoHOQAAUj23LscPesV5xp/7wTZ+Fulw==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wqsy8mxj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 17:35:52 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 56HHZmoU004189;
	Thu, 17 Jul 2025 17:35:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 47xuvs3b98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 17:35:48 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56HHZlFg004184;
	Thu, 17 Jul 2025 17:35:47 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-tamizhr-blr.qualcomm.com [10.190.110.180])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 56HHZlT5004183
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 17:35:47 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 380741)
	id 29DC741566; Thu, 17 Jul 2025 23:05:47 +0530 (+0530)
From: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
Subject: [PATCH ath-next v2 0/2] wifi: ath12k: Extend support to parse wmi service bit 
Date: Thu, 17 Jul 2025 23:05:37 +0530
Message-Id: <20250717173539.2523396-1-tamizh.raja@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE1NSBTYWx0ZWRfX5IDFy361Kxpn
 FY0e6GoHMCPn6TJXsicnvtMJBkCLIahYR/+Su5Tg7v/jDn7CQ86qmyVAD+LqomC0vdZ0uT4wBwd
 l2XhXXnxXsuX10BGtzZ/kRdDtHyvAhOo6/emqVB/Sc7GYn+L4M1uREn67IsktYCRWL7Ic2gq+W3
 OE6Tg/1W1LaXBEF5nCPH78oB0qZdLqLnS+EKTpNsmWyUG6Bvlti8qy+Gmy3nCHYBYSQBZaIq7dw
 X55V7sjQ/xinUldrT3Vzo589YHNESRJIpjNrzwqpSj+mOJ1JazLaYfIdXsNU4W4nehtqEyFZLPR
 7pDuNAmDWv0Hm/DDew+MBopsIt9jorjrbaTTGc92S5N6pq8NSvQauCvX+EF8Ehttl9+aLiybUJK
 kxARn1WYz+7ieqKRQ2RHQm28Z0u1UyvWpB3kqvGtYm7HtjW4Hh3IuqRdysKuDW7H4mbyZFD/
X-Proofpoint-GUID: vG4BRdLFVwxMQbD9IbsA0oGa9rw_hioa
X-Proofpoint-ORIG-GUID: vG4BRdLFVwxMQbD9IbsA0oGa9rw_hioa
X-Authority-Analysis: v=2.4 cv=McZsu4/f c=1 sm=1 tr=0 ts=68793478 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Wb1JkmetP80A:10 a=VqKXJ2bPb1k_lhZ8nysA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 mlxscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170155

Extend support to parse wmi service bit till the last value firmware
is advertising and use endian conversion while accessing the
wmi_ext2_service_bitmap value in ath12k_wmi_tlv_services_parser().

Tamizh Chelvam Raja (2):
  wifi: ath12k: fix endianness handling while accessing wmi service bit
  wifi: ath12k: Add support to parse max ext2 wmi service bit

 v2:
   * Modified commit log as per review comments.

 drivers/net/wireless/ath/ath12k/wmi.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)


base-commit: 65c12b104cb942d588a1a093acc4537fb3d3b129
-- 
2.34.1


