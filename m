Return-Path: <linux-wireless+bounces-3832-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A5685CE79
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 04:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 589271C22F5B
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 03:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248812B9D6;
	Wed, 21 Feb 2024 03:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lztLj9E+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D08746BF;
	Wed, 21 Feb 2024 03:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708484451; cv=none; b=b0NFgTZEt+UbY8nBxycvh/4w6LZHya4CSoxeHoyOO6ofKqrgwc/FpGigPdhiBEEia9QKEj5lLZOetXnAo0LLTOK0xTB/h2u9kkYAFEAbQUIFP9d5HqFuPBpM5Hxb3HBGVz3iGIcuIM4D8n+6BDuVCnKpDYfCXi6syk25A8QbFJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708484451; c=relaxed/simple;
	bh=0/OGpzfd35ioFroZyJvdOOMT2FWP6cE4wEBGHPCX0j8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hn36idI4Ft8llAwRgoT5F9VoYR9d/l+/yABudXen3e+g+JbG/w2Mgyrp5r5ytXdXFK+zULoi90w/VUF+JIbC2CQNnDMVGPS6V2fmFA2/Z6CbuYLGxXQJ2YgqFzXdXjFUmkKwmzmMoLrtuiboMaWCRjvBBpDzl6HPKjTW4uydiAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lztLj9E+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41L2uFC7006944;
	Wed, 21 Feb 2024 03:00:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=xqAx+6q
	4cmST+6i8xL4b9Nl9jzjBC8YxcMrVxIe0LCk=; b=lztLj9E++KjoMzhqx0QJq6K
	01r4Sm3DORPnlu2d06Gq2AJj9tph/uqDqxnS1NSM+l0STGhnRGvpZfczrkQnb6T3
	XB/gYdpL+rTtcVRroNkyPjo9WG7AibRfjNfKBMal1t25sDCSjsg11hNOC6P3jnM2
	IEm0A2IxU3jM3RtM3fiu8SDh+m03tvEFuZD00tZ9b47NTXN5T7UQgxSSCnf7ROHi
	WtIsjcRGAjZK4PMfHZchreYnKa0V5cwCe1nMQfJVDbfS+dsUJ2YTJxSJVDGTErTo
	e2U3A8rXXT7duMAigZCSq+JDiyCgFV476kMeRGg+MlgXWo5Hu9WXSGjrdaM8jNw=
	=
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wd22u0sy9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 03:00:44 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41L30hOI022919
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 03:00:43 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 20 Feb 2024 19:00:41 -0800
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath11k@lists.infradead.org>, <mhi@lists.linux.dev>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>
Subject: [PATCH 0/3] wifi: ath11k: hibernation support
Date: Wed, 21 Feb 2024 11:00:23 +0800
Message-ID: <20240221030026.10553-1-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: odlhEWLq-eHOKnhP-TNm4Eys2KyOYTAX
X-Proofpoint-ORIG-GUID: odlhEWLq-eHOKnhP-TNm4Eys2KyOYTAX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 phishscore=0 adultscore=0 mlxscore=0
 spamscore=0 mlxlogscore=927 priorityscore=1501 clxscore=1011
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2402210020

Currently in ath11k we keep the firmware running on the WLAN device when the
network interface (wlan0) is down. The problem is that this will break
hibernation, obviously the firmware can't be running after the whole system is
powered off. To power down the ath11k firmware for suspend/hibernation some
changes both in MHI subsystem and ath11k are needed.

This patchset fixes a longstanding bug report about broken hibernation support:

https://bugzilla.kernel.org/show_bug.cgi?id=214649

There already is an RFC version which has been tested by multiple users with
positive results:

https://patchwork.kernel.org/project/linux-wireless/cover/20231127162022.518834-1-kvalo@kernel.org/

Basically the RFC version adds two APIs to MHI stack: with the first one ath11k
is able to keep MHI devices when going to suspend/hibernation, getting us rid of
the probe deferral issue when resume back. while with the second one ath11k could
manually prepare/unprepare MHI channels by itself, which is needed because QRTR
doesn't probe those channels automatically in this case.

Mani, the MHI maintainer, firstly doesn't like that version and insists that an
MHI device should be destroyed when suspend/hibernation, according to his
understanding on device driver model. See

https://lore.kernel.org/mhi/20231127162022.518834-1-kvalo@kernel.org/

After a long discussion Mani thought we might need a new PM callback with which
ath11k is able to wait until kernel unblocks device probe and thus MHI channels
get probed. So we came to the kernel PM list and there Mani realized that his
understanding is not correct so he finally agrees to keep MHI device during
suspend/hibernation. See

https://lore.kernel.org/all/21cd2098-97e1-4947-a5bb-a97582902ead@quicinc.com/

Mani also pointed out that an MHI controller driver (ath11k here) should not touch
MHI channels directly because those channels are managed by the corresponding MHI
client driver (QRTR here). To address this, we come up with this version.

Compared with that RFC version, this version adds PM callbacks in QRTR module:
suspend callback unprepares MHI channels during suspend and resume callback
prepares those channels during resume. In this way ath11k doesn't need to do
unprepare/prepare work by itself so those two APIs added in RFC version are
removed now.

The power down/up procedure requires a specific sequence in which PM callbacks
of wiphy, ath11k and QRTR are called, this is achieved by exploiting the
child-father relationship between their device struct, and also the PM framework
which separates whole suspend/resume process into several stages. Details in
patch [3/3].

Depends on:
wifi: ath11k: rearrange IRQ enable/disable in reset path
wifi: ath11k: remove MHI LOOPBACK channels
wifi: ath11k: do not dump SRNG statistics during resume
wifi: ath11k: fix warning on DMA ring capabilities event
wifi: ath11k: thermal: don't try to register multiple times

Baochen Qiang (3):
  bus: mhi: host: add mhi_power_down_no_destroy()
  net: qrtr: support suspend/hibernation
  wifi: ath11k: support hibernation

 drivers/bus/mhi/host/internal.h        |   4 +-
 drivers/bus/mhi/host/pm.c              |  36 +++++++--
 drivers/net/wireless/ath/ath11k/ahb.c  |   6 +-
 drivers/net/wireless/ath/ath11k/core.c | 105 +++++++++++++++++--------
 drivers/net/wireless/ath/ath11k/core.h |   6 +-
 drivers/net/wireless/ath/ath11k/hif.h  |  14 +++-
 drivers/net/wireless/ath/ath11k/mhi.c  |  12 ++-
 drivers/net/wireless/ath/ath11k/mhi.h  |   5 +-
 drivers/net/wireless/ath/ath11k/pci.c  |  44 +++++++++--
 drivers/net/wireless/ath/ath11k/qmi.c  |   2 +-
 include/linux/mhi.h                    |  15 +++-
 net/qrtr/mhi.c                         |  29 +++++++
 12 files changed, 218 insertions(+), 60 deletions(-)


base-commit: 707e306f3573fa321ae197d77366578e4566cff5
prerequisite-patch-id: d3f76112f9a55195c71459e0edf3a4ecf8af9181
prerequisite-patch-id: 340d15aad1d3c1c3c93d9d996e1c96226c8bad8f
prerequisite-patch-id: 98cdd37a68df4f651a065145e946d92c43be799e
prerequisite-patch-id: a19ed13af0c894b7f9b22cedc99029991f48e47c
prerequisite-patch-id: b5ad50fae6167c7c2b60cc063a8d460f7ddd4997
-- 
2.25.1


