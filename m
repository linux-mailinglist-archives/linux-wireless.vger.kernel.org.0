Return-Path: <linux-wireless+bounces-4042-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6867A86877E
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 04:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5961B1C21790
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 03:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547851CAAE;
	Tue, 27 Feb 2024 03:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AZQNH4It"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51281C693
	for <linux-wireless@vger.kernel.org>; Tue, 27 Feb 2024 03:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709003098; cv=none; b=eXXhMuaw0XoFvnWZ2npFOB6bXz3/gz2xorfe0yS/2sgmBRkP29kuM+v5ObWaqByMCtNjVIKpl/fcag8NAWlW3t+qUtZbz0/s5GeqSZMeAdn4hdz9UFz69o6yZk8hqe0pzWad2tus0wWkNDct3Iiw5sA7q8c48T/svMVjoYCDBM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709003098; c=relaxed/simple;
	bh=JHWuPrN9MsSYswPMnzKnSYIlppXJ4A4t6iTjec7C46s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NWU3uIELd5g3QP3QIYWKtHOKa5jonSq72X41i+5Jizm1q4zV0ymJmqlYnlFGwTO57OU9FGADXj1o9mgXBUI2GFW7GWO6vytUCte5aq+Pi7/gMKFPO+ILYuxXuhahoQ7DjdtAMGub9Ww2vqrhjzQgI5T4vFOogWYASgIzFpzVRSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AZQNH4It; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41R0RcP5014785;
	Tue, 27 Feb 2024 03:04:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=MOU4LRK
	QNVZKxJNVJynHDDPtNlgI+m5yAl1GBPgOR1E=; b=AZQNH4Itw8H7Ub79E8ikUzH
	tfz1u/25p3U8G2zKrZT92yfSkz+MtTx8PpoSKtOHDBlfkGeckJjpbQ1FALs/lHtI
	xYcbPpyEXfFWH+x88uFj5SIfDNEo8zE7tXm+qnqSQmIW5Q6yrz+dDsVrPgCCgiR/
	PpLmv6Jg0RBhtb7dk52QpyOgbTI6AcLmOzsfh814de2bLCq/emD9sUwikamvNMJX
	Mm+X4YhnQlgX2hP+0j7oNJVLGMCtkZGRu1iurAhFazW9kkYv++hOj9+62qX/bCEr
	3Blk1zX3javk69cf+6D0UAsnHQC22NzGG8IcAN5TM6a1tXkvCLxugx+FG4L2iVA=
	=
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wh152rs98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 03:04:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41R34RDr011920
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 03:04:27 GMT
Received: from bqiang-Celadon-RN.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 26 Feb 2024 19:04:26 -0800
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath10k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH v2] wifi: ath10k: poll service ready message before failing
Date: Tue, 27 Feb 2024 11:04:09 +0800
Message-ID: <20240227030409.89702-1-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
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
X-Proofpoint-ORIG-GUID: xMcGkeDnHumPrVh1hY68rax0EFejvTdr
X-Proofpoint-GUID: xMcGkeDnHumPrVh1hY68rax0EFejvTdr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1011
 spamscore=0 priorityscore=1501 mlxscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 mlxlogscore=785
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402270023

Currently host relies on CE interrupts to get notified that
the service ready message is ready. This results in timeout
issue if the interrupt is not fired, due to some unknown
reasons. See below logs:

[76321.937866] ath10k_pci 0000:02:00.0: wmi service ready event not received
...
[76322.016738] ath10k_pci 0000:02:00.0: Could not init core: -110

And finally it causes WLAN interface bring up failure.

Change to give it one more chance here by polling CE rings,
before failing directly.

Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00157-QCARMSWPZ-1

Fixes: 5e3dd157d7e7 ("ath10k: mac80211 driver for Qualcomm Atheros 802.11ac CQA98xx devices")
Reported-by: James Prestwood <prestwoj@gmail.com>
Link: https://lore.kernel.org/linux-wireless/304ce305-fbe6-420e-ac2a-d61ae5e6ca1a@gmail.com/
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
v2:
 - print the end result of polling.

 drivers/net/wireless/ath/ath10k/wmi.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
index 2e9661f4bea8..80d255aaff1b 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -1763,12 +1763,32 @@ void ath10k_wmi_put_wmi_channel(struct ath10k *ar, struct wmi_channel *ch,
 
 int ath10k_wmi_wait_for_service_ready(struct ath10k *ar)
 {
-	unsigned long time_left;
+	unsigned long time_left, i;
 
 	time_left = wait_for_completion_timeout(&ar->wmi.service_ready,
 						WMI_SERVICE_READY_TIMEOUT_HZ);
-	if (!time_left)
-		return -ETIMEDOUT;
+	if (!time_left) {
+		/* Sometimes the PCI HIF doesn't receive interrupt
+		 * for the service ready message even if the buffer
+		 * was completed. PCIe sniffer shows that it's
+		 * because the corresponding CE ring doesn't fires
+		 * it. Workaround here by polling CE rings once.
+		 */
+		ath10k_warn(ar, "failed to receive service ready completion, polling..\n");
+
+		for (i = 0; i < CE_COUNT; i++)
+			ath10k_hif_send_complete_check(ar, i, 1);
+
+		time_left = wait_for_completion_timeout(&ar->wmi.service_ready,
+							WMI_SERVICE_READY_TIMEOUT_HZ);
+		if (!time_left) {
+			ath10k_warn(ar, "polling timed out\n");
+			return -ETIMEDOUT;
+		}
+
+		ath10k_warn(ar, "service ready completion received, continuing normally\n");
+	}
+
 	return 0;
 }
 

base-commit: c39a5cfa0448f3afbee78373f16d87815a674f11
-- 
2.25.1


