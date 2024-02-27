Return-Path: <linux-wireless+bounces-4050-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CDD868904
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 07:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 738EB1C21BF4
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 06:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712271E876;
	Tue, 27 Feb 2024 06:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JW3cHmkC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF012209D;
	Tue, 27 Feb 2024 06:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709015793; cv=none; b=UE57RMwQPSNZ2y8xgKvVs6N6ezXL6kMmydQuwTFfY9L4zz15KQnXGt5C40smWrO3n4chHDampEB6Zvab8ZgWj+huUBKKnFpIEQN2ti+QullhyiQ8b18AU9Wf8zjImLxOeaavccyw/nW5HZBDBYk/6JdSd+zlLBl46rcHb8U+CuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709015793; c=relaxed/simple;
	bh=oXvTUL6QYnDFJEAv2+7pJsc+qpOs8b+PF6a5zLkcBZk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q0MnzEYHj6yeNNijfWWfsdCJX2Ez/6kBLSkQ8GkSlMrCccKGEWKg343ms+sheWXSBCK7PmZC0gFApwgMXHE/Z+2NguOy2aGuRTVhgawWFR/zPF7zFhzzQ68fUcI94uZ6zljf5J6luyoTe+fKYNoc8N4TiS4q3AqfPvLO0XzLAYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JW3cHmkC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41R40Amo015639;
	Tue, 27 Feb 2024 06:36:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=TJcb+UK
	9z1yOYKH/0mXA5f0AcSIrA8aoAZBx4KNLlrA=; b=JW3cHmkCsXD3cTfnLli0eJr
	gB0b3d7UrHeCvRBd+ZSpWPhPe9Oni4ZS2UbRis8/2kaTXLhrNsOxx8O9KS5DgyDA
	uQQHEdbdMFGqoz2IWluLfeBAByWm0Uff+zEwyhTPnwknA1bHTazwiil8+JsrnF2u
	OvGiU/7Re6d4TezIuFs5pzpUKoW3VoJZ2IMm3mrSTh1/wzvMRhzp6Wc1yFldt4pB
	AfIU835ELaKc3wE9wOqokbRo0wn8ZLwR0qoIb8Cz1xckGIYtOOspTEIy+qUUuw8B
	ZirznHMar9QOBgh2x6A1FFucrSpPZrBRzmmrLLeR2PNgjyghrNIV+fqrgqsCdOg=
	=
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wh8aug9dv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 06:36:26 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41R6aPhK026068
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 06:36:25 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 26 Feb 2024 22:36:23 -0800
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath11k@lists.infradead.org>, <manivannan.sadhasivam@linaro.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <mhi@lists.linux.dev>
Subject: [PATCH v2 0/3] wifi: ath11k: hibernation support
Date: Tue, 27 Feb 2024 14:36:10 +0800
Message-ID: <20240227063613.4478-1-quic_bqiang@quicinc.com>
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
X-Proofpoint-ORIG-GUID: ipfusPh26n3Z0XWpQ72SyI8jgui46ULm
X-Proofpoint-GUID: ipfusPh26n3Z0XWpQ72SyI8jgui46ULm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0 malwarescore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=930 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402270051

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

v2:
 - add comment on why destroying the device is optional in
   mhi_pm_disable_transition().
 - rename mhi_power_down_no_destroy() as mhi_power_down_keep_dev().
 - refine API description of mhi_power_down() and
   mhi_power_down_keep_dev().
 - add/remove __maybe_unused to QRTR PM callbacks.
 - remove '#ifdef CONFIG_PM'.
 - refine commit log of patch 1/3 and 2/3.

Baochen Qiang (3):
  bus: mhi: host: add mhi_power_down_keep_dev()
  net: qrtr: support suspend/hibernation
  wifi: ath11k: support hibernation

 drivers/bus/mhi/host/internal.h        |   4 +-
 drivers/bus/mhi/host/pm.c              |  41 ++++++++--
 drivers/net/wireless/ath/ath11k/ahb.c  |   6 +-
 drivers/net/wireless/ath/ath11k/core.c | 105 +++++++++++++++++--------
 drivers/net/wireless/ath/ath11k/core.h |   6 +-
 drivers/net/wireless/ath/ath11k/hif.h  |  14 +++-
 drivers/net/wireless/ath/ath11k/mhi.c  |  12 ++-
 drivers/net/wireless/ath/ath11k/mhi.h  |   5 +-
 drivers/net/wireless/ath/ath11k/pci.c  |  44 +++++++++--
 drivers/net/wireless/ath/ath11k/qmi.c  |   2 +-
 include/linux/mhi.h                    |  18 ++++-
 net/qrtr/mhi.c                         |  27 +++++++
 12 files changed, 224 insertions(+), 60 deletions(-)


base-commit: c39a5cfa0448f3afbee78373f16d87815a674f11
-- 
2.25.1


