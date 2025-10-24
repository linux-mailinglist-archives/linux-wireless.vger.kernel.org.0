Return-Path: <linux-wireless+bounces-28216-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 789F6C045A2
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Oct 2025 06:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0AA624E4B78
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Oct 2025 04:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF96259CB3;
	Fri, 24 Oct 2025 04:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Rs1+LVmE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B566A35B122
	for <linux-wireless@vger.kernel.org>; Fri, 24 Oct 2025 04:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761281252; cv=none; b=AYNHeoufIjOwc5AIXrVQaneEA0F0B9ZdMPF/cXZsd9B8V3UK0fiRp8emrJbDuIswFjkcY+vW0ek5NbWewdiDQ5eOe6FB/fVD/mhtPItgyThllKLeIEWqi670U1R7d40HzgysXsIszVFH2vMU6ucJg1yJDnmqR8jUJjMzGaH5kcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761281252; c=relaxed/simple;
	bh=DPfG52FIgNX1itxBevRcw8KE4Bfjnywg06TBUYwmMPs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QrY3kV4vv08WelB/jJCOEssMUKqjU7tgtTjEDxxVWRlFjx4ksmMhAS2lhDC/5CKL1Z/CpEgCR2UNizObAf5g1guR5PXyZkujBrFwMEttVFFQCaXIXHgN9Xf2kJxQmnmit4EE1oXPp7pPinmeZ6F1GOkaD2ffEutXYyyO+xMZO0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Rs1+LVmE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3FEoO000374;
	Fri, 24 Oct 2025 04:47:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TE+1Lk+ipBoDd5yTEb3kmhTs/NSJxHjGKQUc7QjIddQ=; b=Rs1+LVmE3tnntVu1
	FvUwSIHoqqY82squbwPEukcheolW5A5qTy6f/FZ7sRwA0aFAfaJD3GXbZ6ndqbl9
	Eo5JdBJcZBx48kXxtIG56XMOQiAZDzX7zcDbmqNNxkfTi7/59hVKMBHDGuznYBnI
	HecR2Qujnm+1OUOEjMSF7+c6sMJKXvEG3WgTUE9xUQnmtD0MARk1d0B9ncFW7P/z
	/mHg8YEI764qfHYxI44LwICfETrO9XmksyhOxZakOKP5au1pwWZADSy94t5HIZjz
	cwuBGxLucDfeNqAhuT8MyE/5wF1UJrtCcGkOjSzfLQahtd6cU6ejnxYzGOOGy+FD
	7ZO64A==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49ym9j2e3d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Oct 2025 04:47:25 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 59O4lPu7005208
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Oct 2025 04:47:25 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 23 Oct 2025 21:47:23 -0700
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
Subject: [PATCH wireless-next 2/2] wifi: cfg80211: Add parameters to radio-specific debugfs directories
Date: Fri, 24 Oct 2025 10:16:49 +0530
Message-ID: <20251024044649.483557-3-quic_rdevanat@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251024044649.483557-1-quic_rdevanat@quicinc.com>
References: <20251024044649.483557-1-quic_rdevanat@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=CLknnBrD c=1 sm=1 tr=0 ts=68fb04dd cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=uDsn8Rt1FR1oeiB9hA8A:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIzMDExMiBTYWx0ZWRfX5wxtPrkFQTqo
 SgQw07UrW7/pSracVHZoCEQ9u9cEdPr6u0Ing1ba2fU6T1fbqZUcxSnyN4QTEpcCJNxe980Yzur
 M38kadGS4GWNyZDwNNLb1lcJ6dfmB54hkJpXGMQP0HFsHL1VQbD5CyC395S0O3ImLhzs/a8n20j
 8+VV2z8WmrJnLUZMJHTPkZbExDWtpXHvbm3nksI/yoM2nKX50gm5YhQrjcCNiLECVw4Od9d0vqI
 Byx8OqEdQn2n8VwRZjBKoubKneA0Vjf2j2Xj91G+ALCetAjpNBuQnIn8tpwJlpQXOB0qi83AVCo
 tDFQLk9voU2/m8KdUE6dTm78tejNO+jsQtPvhY6IHmE91KOFDeQn7AiEBx0oPjTTzKf6DxMs24s
 lEDPjf65KL7hxOAv9vyQW23vziUxAA==
X-Proofpoint-GUID: k-4PO5Ex1ZMCxpUeT8jQg6E2eXjKnrcH
X-Proofpoint-ORIG-GUID: k-4PO5Ex1ZMCxpUeT8jQg6E2eXjKnrcH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510230112

In multi-radio wiphy architecture, where a single wiphy can have
multiple radios tied to it, radio specific configuration parameters
and global wiphy parameters are maintained for the entire physical
device and common to all radios. But, each radio in a wiphy can
have different values for each radio configuration parameter like
RTS threshold. With the current debugfs directory structure, the
values of global wiphy configuration parameters can be viewed, but,
values of individual radio configuration parameters cannot be viewed.

To address this requirement, maintain separate entries of each radio
configuration parameter i.e., RTS threshold in corresponding radio-
specific debugfs directory. This way, radio-specific configuration
parameters can be maintained along with global wiphy configuration
parameters. Whenever the values are changed for one radio, the values
for rest of the radios in the wiphy and the global wiphy parameter
value will remain intact.

Sample output:
/# iw phy#0 set rts 100 radio 1
/# iw phy#0 set rts 468 radio 0
/# cat /sys/kernel/debug/ieee80211/phy0/rts_threshold
-1
/# cat /sys/kernel/debug/ieee80211/phy0/radio0/radio_rts_threshold
468
/# cat /sys/kernel/debug/ieee80211/phy0/radio1/radio_rts_threshold
100

/# iw phy#0 set rts 500
/# cat /sys/kernel/debug/ieee80211/phy0/rts_threshold
500
/# cat /sys/kernel/debug/ieee80211/phy0/radio0/radio_rts_threshold
500
/# cat /sys/kernel/debug/ieee80211/phy0/radio1/radio_rts_threshold
500

Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
---
 net/wireless/debugfs.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/net/wireless/debugfs.c b/net/wireless/debugfs.c
index 40e49074e2ee..f9e7fff1ef25 100644
--- a/net/wireless/debugfs.c
+++ b/net/wireless/debugfs.c
@@ -29,6 +29,24 @@ static const struct file_operations name## _ops = {			\
 	.llseek = generic_file_llseek,					\
 }
 
+#define DEBUGFS_RADIO_READONLY_FILE(name, buflen, fmt, value...)	\
+static ssize_t name## _read(struct file *file, char __user *userbuf,	\
+			    size_t count, loff_t *ppos)			\
+{									\
+	struct wiphy_radio_cfg *radio_cfg = file->private_data;		\
+	char buf[buflen];						\
+	int res;							\
+									\
+	res = scnprintf(buf, buflen, fmt "\n", ##value);		\
+	return simple_read_from_buffer(userbuf, count, ppos, buf, res);	\
+}									\
+									\
+static const struct file_operations name## _ops = {			\
+	.read = name## _read,						\
+	.open = simple_open,						\
+	.llseek = generic_file_llseek,					\
+}
+
 DEBUGFS_READONLY_FILE(rts_threshold, 20, "%d",
 		      wiphy->rts_threshold);
 DEBUGFS_READONLY_FILE(fragmentation_threshold, 20, "%d",
@@ -38,6 +56,9 @@ DEBUGFS_READONLY_FILE(short_retry_limit, 20, "%d",
 DEBUGFS_READONLY_FILE(long_retry_limit, 20, "%d",
 		      wiphy->retry_long);
 
+DEBUGFS_RADIO_READONLY_FILE(radio_rts_threshold, 20, "%d",
+			    radio_cfg->rts_threshold);
+
 static int ht_print_chan(struct ieee80211_channel *chan,
 			 char *buf, int buf_size, int offset)
 {
@@ -100,15 +121,27 @@ static const struct file_operations ht40allow_map_ops = {
 #define DEBUGFS_ADD(name)						\
 	debugfs_create_file(#name, 0444, phyd, &rdev->wiphy, &name## _ops)
 
+#define DEBUGFS_RADIO_ADD(name, radio_idx)				\
+	debugfs_create_file(#name, 0444, radiod,			\
+			    &rdev->wiphy.radio_cfg[radio_idx],		\
+			    &name## _ops)
+
 void cfg80211_debugfs_rdev_add(struct cfg80211_registered_device *rdev)
 {
 	struct dentry *phyd = rdev->wiphy.debugfsdir;
+	struct dentry *radiod;
+	u8 i;
 
 	DEBUGFS_ADD(rts_threshold);
 	DEBUGFS_ADD(fragmentation_threshold);
 	DEBUGFS_ADD(short_retry_limit);
 	DEBUGFS_ADD(long_retry_limit);
 	DEBUGFS_ADD(ht40allow_map);
+
+	for (i = 0; i < rdev->wiphy.n_radio; i++) {
+		radiod = rdev->wiphy.radio_cfg[i].radio_debugfsdir;
+		DEBUGFS_RADIO_ADD(radio_rts_threshold, i);
+	}
 }
 
 struct debugfs_read_work {
-- 
2.25.1


