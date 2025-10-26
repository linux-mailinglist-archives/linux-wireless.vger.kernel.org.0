Return-Path: <linux-wireless+bounces-28280-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FCFC0B017
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Oct 2025 19:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4697218A05A9
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Oct 2025 18:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0134270542;
	Sun, 26 Oct 2025 18:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e3WtgWwG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EEF2566D3
	for <linux-wireless@vger.kernel.org>; Sun, 26 Oct 2025 18:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761503001; cv=none; b=o9bJnrbZ5j60Hsa7nh/WnRpEk3Q2lnNegqAUmmg1v3pm5EGhlUJSbX83XYgp0znrPPrXjNvZquiD95VJcORO2Rm2iZjMB2y71qzu0ol4yIxV9P3yByIkiEjTDq+J5ARusRqFGWm4yon1QJ856eRc3r6lClcUyZyC/DCAeEzYdzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761503001; c=relaxed/simple;
	bh=uj3QUmchFpkLbVloON6X34xff/LbaNs4FH6uavJoUTU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qYGJbxcxbWutMfFocnirf5ua+4996X2gLsBCl8kaotoWJzy+zq3mvNeOQJZlsbJVfSirar7lDI/qXDiDnxTTUznm2rcPqR37iy9ESQvNOGQISyCenMpluXOSwa/Iypc1D/Bu4/mcBIrSQRP5lmhPuzWsIOtsoEPP4vu8k3a1TIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e3WtgWwG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59Q8xeHh3565674
	for <linux-wireless@vger.kernel.org>; Sun, 26 Oct 2025 18:23:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=07ocjkdEJGZGwyrHZf6N4TSK9zFMgHbhsQL
	06B+flvk=; b=e3WtgWwG1uwoQhVIig+AHuWLRog7Vj3nHQSPairlQG73tmvrzzJ
	QnXbCMxoicBz0LbA28VatHJCyjMyTYjugxXUPFEM36MwChshBHa9Qw3CrKKaAWkx
	PrS56BHe9s46wcXM/cDuVhI0EJEdwEgBHCLCkPmgKsu/H/4XZXKJTrtnTsdUOC3k
	mmA1jrEG1x+7t3UjrUS5CEq+y+WayoWAJ2ASBvVMy2S809bV+IjJYvHDMwvBShvl
	kCQSCEaMjKgHPIS4UmZJjFcnVhqN/QTsrCu3s1bMUa3pV6h6oKHUjVBVtOQrt7+i
	o7Zm1qrYaneBTjoLgMN1R1FxWaIW7Z9bT4A==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a0p4g2ddw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sun, 26 Oct 2025 18:23:18 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-294baa12981so578615ad.1
        for <linux-wireless@vger.kernel.org>; Sun, 26 Oct 2025 11:23:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761502998; x=1762107798;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=07ocjkdEJGZGwyrHZf6N4TSK9zFMgHbhsQL06B+flvk=;
        b=k/1166huibH0iKXlicR4MTUjFGi/XSbUPapqQg7hb0p9yFO6K7c4kkZaws9QjupTVj
         v+jWHtRzQomRVrLAogWRg1t3NQkiSg1SQPIJqWbVyq6ij48dqF39IoUXOUfLUPMgdWvz
         e2Busf1XVtmcZugL3Br2Qx20bk2CO1k7vBB0/YhKBnIYhGKeWgjdisMioBMJywGJV79I
         bXK0800wdWy1E4IiAyRsBLhdfBJvtIbH2v3FRmTwtQ9jXHxHAeqZL85EMQO1giYPIBTC
         d2Eunu4UmeKK5Gil5VXkA8LsBUpmexK8rW7tcy9lUOoQwbukM/eRsniu8/bJC7R+JjCA
         oARw==
X-Gm-Message-State: AOJu0YzauvluvyzHan1NB8k29KT9UVX7zwteBrk2mUCuLCzMXRj2CtSG
	4bIw8Z+fPUb01uV6Gh4MFTHf4mo5g6jOiGDcsSCoB2OZX9h8Zb8+Z0eL3ScQik2Xq0uuZ2DATYo
	nlaWjHsjzq7Y9NjvvK66TQPmj1aDFyD7l1BnnO4V57a/EqF+HzDL9C/KOvz52zR5AooezzVKz1I
	VQqg==
X-Gm-Gg: ASbGncspfmiunHM2kJyqEydiztMfy36JMGXoMnabXlNu2XZ3HjRsPafM0KIM+OI6ad3
	ohcB4rso9RyB/TqIBGYFxezQBrbGdCT+vSCO3KPVRCDQW5pAj6lEWwVN+985bWcLN17kDwynwmF
	FyDCTUSmGtbWm7MnDgC+Mlv8Lo17LJglPHnjWoNG3WZFHKtx+1hop5y/JTpUmrxb89o7C/dYua4
	0Ripe0NCn4xAGB/JquzGXItzw572BIUZbKRdr/JuZRGFTdwpZkqjrCpLGKudsk0LmLonR0VsP6W
	KMpdwE9R2Exl0tAEYXVqtGITbNwdihzU2PH0NJuBGSs4Y8hUB0ym2MqweodQuzdLTzbyZsHOtD5
	wYgO/Kfm1NWwjPPMCIT+rgOH5UpCpwqDPtgEtwPalZp2ShJxAUpBlzR/iJ3La/u3xzjYmPz0ViW
	8jwNxgwbL5U7AE8SKuB5vQ7rwpgpc=
X-Received: by 2002:a17:903:4b04:b0:271:9b0e:54ca with SMTP id d9443c01a7336-29489db2210mr112152555ad.13.1761502997756;
        Sun, 26 Oct 2025 11:23:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhUW87NKvc/BI4PtFg7arwb1oOCYao85sOx7mz7awGO7NbfJuOxAMvDWdGtVV/3Jzseu4CdQ==
X-Received: by 2002:a17:903:4b04:b0:271:9b0e:54ca with SMTP id d9443c01a7336-29489db2210mr112152385ad.13.1761502997312;
        Sun, 26 Oct 2025 11:23:17 -0700 (PDT)
Received: from hu-ramess-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e429d9sm55208655ad.100.2025.10.26.11.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 11:23:16 -0700 (PDT)
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Subject: [PATCH ath-next 0/2] wifi: ath12k: handle vdev create errors and ensure limit checks
Date: Sun, 26 Oct 2025 23:52:52 +0530
Message-Id: <20251026182254.1399650-1-rameshkumar.sundaram@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ExJOkeqoPDy5eHGcolfAX4BYK0gXdXGA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI2MDE3NiBTYWx0ZWRfX/phJX4TOeJtA
 motjI3m7WHgnG0pCNwQe0wNadbQZiTpmEB8BbpTMS7Ok3cLT40e3rguracQZO8f5lFtZey1SgNw
 +Knb5oIr6lZZFlr/Y9i33p8K+MjYiS3DehN5iy2zGyI7uGiUqDfwzNg+aI11WRaIWyU/LhzYCMf
 8Dq/BUPLjIqgPW3utihSrCgAOcimnDa53Yy51axAwIr/9xf1zYoNRyH1+loSZ6Q7GgZjTX3lQyP
 9X6uSAkEMmEuSqt+TAURYEbRTBLzn8/Z6dSAhSlfn43cH9n9ph/FjWfmbpYyQc3iu4AdBeKn6oX
 rj5Ad7uaHz5TkImGi9PEqduATt+xs8IKVWo22omzR7+qnkN3Iq95ySCxNP2Bz9XC/4vQPbFsvHl
 hCPdaBUsOx7eHxsNtOmlrSkxtQNTbg==
X-Authority-Analysis: v=2.4 cv=L9YQguT8 c=1 sm=1 tr=0 ts=68fe6716 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=ORCT1FrbHtTs6jEYeXUA:9
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: ExJOkeqoPDy5eHGcolfAX4BYK0gXdXGA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-26_07,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 spamscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510260176

Centralize the vdev limit check in ath12k_mac_vdev_create() to prevent
exceeding firmware constraints and triggering asserts. Ensure stale arvif
is unassigned when scan vdev creation fails during scan and
remain-on-channel operations. Return accurate error codes to
improve error handling and cleanup.

Rameshkumar Sundaram (2):
  wifi: ath12k: enforce vdev limit in ath12k_mac_vdev_create()
  wifi: ath12k: unassign arvif on scan vdev create failure

 drivers/net/wireless/ath/ath12k/mac.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)


base-commit: d5d9da878287cb30199defc6941b695f33f9236b
-- 
2.34.1


