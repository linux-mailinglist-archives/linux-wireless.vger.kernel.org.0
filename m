Return-Path: <linux-wireless+bounces-23541-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8181CACC046
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 08:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEB5B172E13
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 06:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E548C1F4607;
	Tue,  3 Jun 2025 06:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HPqqPh7r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C6D267F70
	for <linux-wireless@vger.kernel.org>; Tue,  3 Jun 2025 06:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748932548; cv=none; b=b28PlwlpeKqv62kyJEzDv1rC7hx9RaDNZejWRicx8Y7hpHBvoE1TGDKxbwH3Zp4wOzHpQ1FAJesqki8rjb2npLuvEmTEcu8t9zvrb26nPqM6BnbjrliZiIkVqtqI5qxZgRmBQOp1j1fZwDZfqVjEgNzRsNZghXghhRNod+qlSFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748932548; c=relaxed/simple;
	bh=Malo1ndPzjfgVxC0L4uaYeLfd6QCm4Q3sckIoXL1Zr0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mBdwncBie+1DET3/Md68kotvozJrkQyJBFkym9hQEf/R8H89iz5SjwPSzwPa8Tjie80ss88+FygiA62bwtbdQHY3oQQCb+TgU3Z03D2B3VnaLjf0xkVL3Bc1Yt1u1ZnPoXIzTB54lQ/YvUPec1bLDSP88TWbEUNiFhbRioqfNHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HPqqPh7r; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 552HK2TU007769;
	Tue, 3 Jun 2025 06:35:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=lrXGLpxbMpg9M848+0eqf0
	Z7DtxFtlAewM8dywzs/gQ=; b=HPqqPh7rrowbJTxkQBPR9k0FQ1fwoS+L9g/vrr
	YjzbK+rcr7yDY7319R80/8hreq2GTINEmR+0aZWsbqbVF7mqY/lOIN2rBwCi4N5p
	bueiH3MOHZws+LugSCcXJtIA8390Lk/fuTCuPf8o//NhOmlDG1i4Nqd4FvnOXY2G
	wU0C0F8z3StHR5+xdcQG0jjQbfLgIo3wkvKwSgdngUQ4qtW1h4rW43W7FB1lhgkC
	LYvLST0t9MrvDCMBirzfjehPDrqLiwNaIyZpxPAbn5bo4nb1RUOI1xdoHsVnAMo+
	0e4dFFo3ckQfQE6mGDCrBAnrePHml3OuEQSvWJbPae6/+szg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g8yhjj3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Jun 2025 06:35:39 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5536Zcb3030859
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 3 Jun 2025 06:35:38 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 2 Jun 2025 23:35:36 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH ath-next] wifi: ath12k: Add memset and update default rate value in wmi tx completion
Date: Tue, 3 Jun 2025 12:05:12 +0530
Message-ID: <20250603063512.1887652-1-quic_sarishar@quicinc.com>
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
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDA1NSBTYWx0ZWRfX3q6HNCJ/qgJN
 6KcvVdwFkcxd2lxPQzvkOdjrdAELCm004r++5i/KAXfTJBjDZoujGzrykXRwiS8Cvu97K1OJejW
 7gIlWfeNvfuIUf3EhoKlzSP0obD5fPE0yti6dXvUEzuYjNDjkSmjRmQb9Bf3CXUJPjU4RErcWc4
 jo9RDfOYtuhIKntr2m+GD4OPZrgmUKOHBrjXrB6YznsloOpkq3A9bA60lKWeXQBHGpBteW3SJPL
 e2SeTQ6RoAefdNJz1/dzknWsxyjZ9Y79euRaOc185/N0zc/HxZN5aA5jVp45o+MqKfdivrDqTBV
 tqqSBnh+ntvMFtpeX7OQoHfyxP22P82dXF9GJvFYJp54bTu/0xjkYLh4B4SZ2WF6OYBAoXquXzV
 4tjq3V0t1WcIkdRCvYQr2sU9Ysy7tuGprFwQFKvJTUbh5CXrIoNTexZ0tdG5H8cRtHOB/y31
X-Proofpoint-ORIG-GUID: 1GrK_f2ZYYLJjKZBdEl9w-dkSvOVjCrz
X-Proofpoint-GUID: 1GrK_f2ZYYLJjKZBdEl9w-dkSvOVjCrz
X-Authority-Analysis: v=2.4 cv=T/uMT+KQ c=1 sm=1 tr=0 ts=683e97bb cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8 a=J6ZGN57qR9n7gPSFk8cA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_01,2025-06-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 suspectscore=0 impostorscore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 malwarescore=0 phishscore=0
 adultscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506030055

When both AP/STA and monitor interfaces are enabled, ieee80211_tx_status()
is invoked from two paths: the TX completion handler for data frames
and the WMI TX completion handler for management frames.
In the data path, the skb->cb is properly zeroed using memset, but in
the WMI path, this step is missing.

As a result, mac80211 encountered uninitialized (junk) values in
skb->cb when generating the radiotap header for monitor mode, leading
to invalid radiotap lengths.

Hence, explicitly zero the status field in the skb->cb using memset
in WMI TX completion path to ensure consistent and correct behavior
during WMI tx completion path.

Additionally, set info->status.rates[0].idx = -1 to indicate that
no valid rate information is available, avoiding misinterpretation of
garbage values.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 60e2444fe08c..3688a75b0a60 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -5606,6 +5606,11 @@ static int wmi_process_mgmt_tx_comp(struct ath12k *ar, u32 desc_id,
 	dma_unmap_single(ar->ab->dev, skb_cb->paddr, msdu->len, DMA_TO_DEVICE);
 
 	info = IEEE80211_SKB_CB(msdu);
+	memset(&info->status, 0, sizeof(info->status));
+
+	/* skip tx rate update from ieee80211_status*/
+	info->status.rates[0].idx = -1;
+
 	if ((!(info->flags & IEEE80211_TX_CTL_NO_ACK)) && !status)
 		info->flags |= IEEE80211_TX_STAT_ACK;
 

base-commit: f8bead2c1ef18efc47e495bc800aa7af740eda80
-- 
2.34.1


