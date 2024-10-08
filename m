Return-Path: <linux-wireless+bounces-13702-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B9F9940FB
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 10:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25E2AB24E40
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 08:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DECD1CDA17;
	Tue,  8 Oct 2024 07:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="emEr3G9Y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA741BAEE7
	for <linux-wireless@vger.kernel.org>; Tue,  8 Oct 2024 07:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728372969; cv=none; b=uoHMeyaVchaK2/l8xsGDm+MAgWtyXqtlq3mCxwcj7zCTy4i7HR2mqdbi3Ewy+ug8vYhTOrGIJrZ9ksBEdHvE3e6QfH6o/8qHSTgMsgy/oOoTO8jDu/tJuruCsIt4OhNbVjhKzgAr0mhGQ69gJkjeKQiQq5LKTPvmHesUvGLLci4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728372969; c=relaxed/simple;
	bh=YO6CW6I/1Som0HVJRh7EjhgUK5Um/qo8Ub+BKcVO+HM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Uvac90P018Lab8PiFjqxcG8y/ZVNVbmmEVwmpPFXAW78oHB+jQbIHuEKlT5DG4WrfW0mV+BwfBVhlzNyUUzt1eY3qLktV/RPAkQ1qHv0M2N5k8aKdv4/5rRbYeQXwVO7BGByN00ZfVs7ct/dRUL8AszWkD1Sx3f0kYgitXblFlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=emEr3G9Y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4984TVXP010058;
	Tue, 8 Oct 2024 07:35:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=fuJ+Zn+obt41Q+kLXwFOYL
	UBRKF3HgyO1+7HHSXkRG0=; b=emEr3G9Y0qNuwFD0v3FvQgcB9I5UKf4wBqdNU1
	6qTgOAS6JlCj7KWXaRvCfnk2noUp92JaTG69UFdor2LVNr+c0rV0aTzuDWjvH7yQ
	rNxNHMODt+vsMt0GoguGr6K/I+6lNErlogsTN0kBw4zbrzhr6tvLX8V4ouKxrzDS
	QHjhe42O7rFjBBgZjRyteC8FcGpeEyD10JMxRK3oKFGM29hTC1DBZqF9tu0lavwK
	YD0OUa/AoSUL0RXmiGEdYFAsmEqhCSBOUKbdF4g3QJhLtFUmn1b/mAi9wguXwL+/
	pEUhU02JbE6DGKy+aM42sl3RanKRORTgGZ8dJ9oThhs9udfg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 424wrc0cfq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 07:35:59 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4987ZxOt030366
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 8 Oct 2024 07:35:59 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 8 Oct 2024 00:35:57 -0700
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v2 00/11] wifi: ath12k: some fixes and clean up for monitor mode
Date: Tue, 8 Oct 2024 15:35:23 +0800
Message-ID: <20241008073534.1195-1-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1.windows.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: WgcvZE1SxpGaTWR3wgBQJIk__AlE4O0C
X-Proofpoint-ORIG-GUID: WgcvZE1SxpGaTWR3wgBQJIk__AlE4O0C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 clxscore=1015 spamscore=0
 adultscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 mlxlogscore=871 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410080048

This patch set does some fixes and clean up for monitor mode.

v2: rebase on tag: ath-202410072115.

Kang Yang (11):
  wifi: ath12k: remove unused variable monitor_present
  wifi: ath12k: optimize storage size for struct ath12k
  wifi: ath12k: fix struct hal_rx_ppdu_end_user_stats
  wifi: ath12k: fix struct hal_rx_ppdu_start
  wifi: ath12k: fix struct hal_rx_phyrx_rssi_legacy_info
  wifi: ath12k: fix struct hal_rx_mpdu_start
  wifi: ath12k: properly handling the state variables of monitor mode
  wifi: ath12k: delete NSS and TX power setting for monitor vdev
  wifi: ath12k: use tail MSDU to get MSDU information
  wifi: ath12k: fix A-MSDU indication in monitor mode
  wifi: ath12k: delete mon reap timer

 drivers/net/wireless/ath/ath12k/core.c   |   5 ++
 drivers/net/wireless/ath/ath12k/core.h   |  23 +++--
 drivers/net/wireless/ath/ath12k/dp.c     |  25 ------
 drivers/net/wireless/ath/ath12k/dp_mon.c | 108 ++++++++++++-----------
 drivers/net/wireless/ath/ath12k/hal_rx.h |  53 ++++++-----
 drivers/net/wireless/ath/ath12k/mac.c    |  24 +++--
 6 files changed, 114 insertions(+), 124 deletions(-)


base-commit: b9545f4570fcfebe982439de7c9106e55b4bf756
-- 
2.34.1


