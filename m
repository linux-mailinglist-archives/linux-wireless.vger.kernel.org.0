Return-Path: <linux-wireless+bounces-16130-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EDC9EA7CB
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 06:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B436C284489
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 05:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C013226172;
	Tue, 10 Dec 2024 05:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kX+DkHSn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE6422616A;
	Tue, 10 Dec 2024 05:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733808431; cv=none; b=jhYIQhe7Q6VQplwsQ8d3hC0QxsGPmazUI92CT9ZNzYCdJe7w8S1eKNzU9gbFQcsyuhVZvhpCy5QPLrMgUharH0YnDDswcDGhK50faRAkYmJ9YSPtfF5/GobxKja7XlDJgpx9ufACnMtHdbwwcoi/ntACOTdYp27NF8Y9Cg/sl0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733808431; c=relaxed/simple;
	bh=c99OcWHLd9glOzgh5/aLRHmE3tJAPbZAmvzLEO/XT7Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=N5hPMluxwGyO1XrDwQsKGw9NdPMnezZqAzpjxhYFka/Aoskk1fXgzcqgdn/4h43fOYtVjXip5K2rj0dUEtXe+DPfjyZ+XqE9JqzNaOFcxdAHelCJKQIYvU4hRRKbBkcMM9xIGkVcHd0+j5kQVarvJ4YNTlR7QNvfg+BX7nEBX54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kX+DkHSn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9HLRpp032550;
	Tue, 10 Dec 2024 05:27:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=LPzWFx5Zfx4cXehpMKgB5C
	ml8AHa1x0prdlTRmHHhKk=; b=kX+DkHSnq7ek71gouMfKpdy7R/YnIzEWvDkUqq
	sYuEDZx+M1OXDkuyiMPcJD7j5nt8wSe9oHDphEFgSHln839UqVLRel1m4tbAfZV0
	snbkWTj0K3sw7ucwOzyBS+ZNSOSuwEkeVu8fF+co8pxr7yWthNeISP/y6GpCK4i6
	SJAWYOq7dYhEFFW+4HKbOkv14kLk+O9+cio94iS8FYIOsmtQRrlKARVHTuXIApYh
	tt71nLoe1IuS/aiH9p3DWRP9qb6CnZYA15x8PgedJgzNWnZvboA4838cRYCftuCo
	bllT8fw6EaqSD8iH7Kuc4yNOHTEjQeu8JdNncqNwevAxdnkA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43cdxxf64p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 05:27:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BA5R0p5011493
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 05:27:00 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 9 Dec 2024 21:26:58 -0800
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
Date: Tue, 10 Dec 2024 10:56:33 +0530
Subject: [PATCH] wifi: ath12k: fix read pointer after free in
 ath12k_mac_assign_vif_to_vdev()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241210-read_after_free-v1-1-969f69c7d66c@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAAnRV2cC/x3MQQqAIBBG4avErBN0aBFdJUJMf2s2FWNEEN09a
 fkt3nuoQAWFhuYhxSVF9q3CtQ3FNWwLjKRqYsudY2eNIiQf8gn1WQHTgTnOKTqknmp1KLLc/3G
 c3vcDbyOEnmEAAAA=
X-Change-ID: 20241210-read_after_free-4e22cbdc1ed8
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        Sriram R
	<quic_srirrama@quicinc.com>
CC: Kalle Valo <quic_kvalo@quicinc.com>,
        Jeff Johnson
	<quic_jjohnson@quicinc.com>,
        <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Aditya Kumar
 Singh" <quic_adisi@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: pUu9L7tdE2Ix9IdZlBJmlwnU0Sbc3jcv
X-Proofpoint-GUID: pUu9L7tdE2Ix9IdZlBJmlwnU0Sbc3jcv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 phishscore=0 mlxlogscore=669 priorityscore=1501 clxscore=1011
 malwarescore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412100038

In ath12k_mac_assign_vif_to_vdev(), if arvif is created on a different
radio, it gets deleted from that radio through a call to
ath12k_mac_unassign_link_vif(). This action frees the arvif pointer.
Subsequently, there is a check involving arvif, which will result in a
read-after-free scenario.

Fix this by moving this check after arvif is again assigned via call to
ath12k_mac_assign_link_vif().

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Closes: https://scan5.scan.coverity.com/#/project-view/63541/10063?selectedIssue=1636423
Fixes: b5068bc9180d ("wifi: ath12k: Cache vdev configs before vdev create")
Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index c4eab4c1c10e0a05248fb58858dac9a00ef2e799..47a80d28d1d7f83ae7f61ecb89c6cd7d1d779494 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -8064,9 +8064,6 @@ static struct ath12k *ath12k_mac_assign_vif_to_vdev(struct ieee80211_hw *hw,
 
 	ab = ar->ab;
 
-	if (arvif->is_created)
-		goto flush;
-
 	/* Assign arvif again here since previous radio switch block
 	 * would've unassigned and cleared it.
 	 */
@@ -8077,6 +8074,9 @@ static struct ath12k *ath12k_mac_assign_vif_to_vdev(struct ieee80211_hw *hw,
 		goto unlock;
 	}
 
+	if (arvif->is_created)
+		goto flush;
+
 	if (ar->num_created_vdevs > (TARGET_NUM_VDEVS - 1)) {
 		ath12k_warn(ab, "failed to create vdev, reached max vdev limit %d\n",
 			    TARGET_NUM_VDEVS);

---
base-commit: 27909c77d085d32db141cbb32b2cc9fbef874197
change-id: 20241210-read_after_free-4e22cbdc1ed8


