Return-Path: <linux-wireless+bounces-28740-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 694F0C45F93
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 11:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FF8E3AB385
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 10:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C2E3081A1;
	Mon, 10 Nov 2025 10:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RnB7n+rc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E8F307ACA
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 10:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762771052; cv=none; b=Rfn1CNVyBDbvSbmy/mZWK34Xk0NEv5CWR1beLixjzVtRBZVd1+iBfhxrJg/h6spTDjhduBqT89WZNte7HCcGDNRbvXmXNHH5y19Zj79eSCRzTxERD/raq7E0WYqbspiyKhIrvtmfdIwvSQmM17vRddTpcXJRR7qfgRjU/Zeh8r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762771052; c=relaxed/simple;
	bh=iNgaqxsPzlrj7i7C+0hyk34ygcKoNgbV7oa2yBHoso0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YmqcrCXaQjnrYVH4XIRHJ66AwGh3GPvVPnde17CQxErkjv694h4aVCAaRtN8A2QaXSBt13tp/xskqqyJuOXp/mw5GTe6CW/vD5effeb/Okdss3gbSQBhBzeN8eTdF2xqyya4sE5aKG5t/aqWI91h16+99glAy+pZjEMf3Z7KYCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RnB7n+rc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AA3jn9q2546968;
	Mon, 10 Nov 2025 10:37:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=K5SdsJVWGe/AL96Y1D97+XVYfgCec1k1q/4
	IQaleXAk=; b=RnB7n+rcSLqeQAJ2aO6H7Rqpfq3f5y/kCeDfUWOLVYswsJCGiG6
	+spBuehAwqqnKL/oy+pWyUNz+F22v/7SFtUhEcUD/L1HAoXUvCLXFJuIK3l2Ct2X
	rlIeraWMErEBmLQyUWj0wm2T3G3CfNVbIyLfUuFtc45rY2lhXCRYwTLJvCXCP35O
	Fz5i/SRsTiRb3iMPd82Jx4nk9YHT7r4MYr0RCdFB+OfT44o62eN0juqlddziWtHo
	7Cvjq2wI1GH9iHfhR3/sLHxd4DdARmfYyfK9pgaYcOVPtKwbIvWHo8UVgrNGqVow
	7t2LbIhx8iXPed7ti2pyCiWpitSkC3DVITw==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ab8ea940j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 10:37:21 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAAbHnj008067;
	Mon, 10 Nov 2025 10:37:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 4a9xxkq1fb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 10:37:17 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5AAAbH8S008045;
	Mon, 10 Nov 2025 10:37:17 GMT
Received: from hu-devc-blr-u22-c.qualcomm.com (hu-aloksing-blr.qualcomm.com [10.190.111.138])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 5AAAbH6k008040
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 10:37:17 +0000
Received: by hu-devc-blr-u22-c.qualcomm.com (Postfix, from userid 2272527)
	id 79F455DC; Mon, 10 Nov 2025 16:07:16 +0530 (+0530)
From: Alok Singh <quic_aloksing@quicinc.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Alok Singh <quic_aloksing@quicinc.com>
Subject: [PATCH ath12k-ng 00/12] wifi: ath12k: Remove the Wi-Fi 7 header inclusions in common code
Date: Mon, 10 Nov 2025 16:07:01 +0530
Message-Id: <20251110103713.3484779-1-quic_aloksing@quicinc.com>
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
X-Proofpoint-GUID: 2zNQuYgSiblCeyj1Q5cMCkU0NTgKdGWV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDA5MiBTYWx0ZWRfXwOmNSpxl3eQ4
 r3fyQSyfpX9+7jPn0qdyne1NOLpIEds2zqEfAsdGKvabPqVDDxJGnOBoMNxg6t1Hrxr3Sg3bVGP
 O/vWPfi2fU+Z9pfXhMQ7nDdj9dm5q8J0/wXc4v5KU9a30gsakpRwaOtM+Puy+jmbHuHZACWnBAH
 j8lNvPPd72OW5d2ZpD8TgDp+9WEWdeyFvOWcaKmFSUgV8RIGOXHDD/+ScGGhQyBhjcytdTt7/jm
 gFDeoqIPGg6ta437tsb/AHF90PjGj37eHb5GAwrW1XwvgnQknOgg03C1WyFO1PBXlrwN3Umqj29
 uaMVX2dO6UlkTllwPPHnnua8tm++baqdQW7HuRph03XRrFObdgZ23eISR6DOhsAh6L2je4bdtOk
 Bol3htj+WnQ/Ue/hjQFaT86WYgTKqw==
X-Proofpoint-ORIG-GUID: 2zNQuYgSiblCeyj1Q5cMCkU0NTgKdGWV
X-Authority-Analysis: v=2.4 cv=QLxlhwLL c=1 sm=1 tr=0 ts=6911c061 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Qrwb4ka9RibZ2vX1gocA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 bulkscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511100092

Idea here is to Remove the Wi-Fi 7 header inclusions in common code
As a precursor to the movement of Wi-Fi 7 specific .c files to
ath12k_wifi7.ko module, Remove all Wi-Fi 7 header inclusions (`wifi7/*.h`)
from the common `drivers/net/wireless/ath/ath12k/dp_mon.c`.
The common monitor functions now compile solely against the core
ath12k headers and remain part of the `ath12k.ko` module.
Move Wi-Fi 7 specific monitor implementations to a new
`drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c`.
This file is built into the `ath12k_wifi7.ko` module.

This patch series refactors the ath12k monitor functionalities
into common and Wi-Fi 7 specific code.

The series includes the following changes:

- Patches 1-11 move various monitor mode processing functions from the
  common ath12k driver to the Wi-Fi 7.

- Patch 12 removes the Wi-Fi 7 header dependencies from the main driver,
  completing the separation of concerns.

Alok Singh (12):
  wifi: ath12k: Move monitor ring processing to Wi-Fi 7 module
  wifi: ath12k: Move monitor status processing to Wi-Fi 7 module
  wifi: ath12k: Move MPDU pop functionality to Wi-Fi 7 module
  wifi: ath12k: Move RX status TLV parsing to Wi-Fi 7 module
  wifi: ath12k: Move TX monitor functionality to Wi-Fi 7 module
  wifi: ath12k: Move HT/VHT SIG processing to Wi-Fi 7 module
  wifi: ath12k: Move HE SIG processing to Wi-Fi 7 module
  wifi: ath12k: Move EHT SIG processing to Wi-Fi 7 module
  wifi: ath12k: Move remaining SIG TLV parsing to Wi-Fi 7 module
  wifi: ath12k: Move MU user processing to Wi-Fi 7 module
  wifi: ath12k: Move MSDU END TLV processing to Wi-Fi 7 module
  wifi: ath12k: Remove Wi-Fi 7 header dependencies from common ath12k
    module

 drivers/net/wireless/ath/ath12k/dp_mon.c      | 3474 +----------------
 drivers/net/wireless/ath/ath12k/dp_mon.h      |   62 +-
 drivers/net/wireless/ath/ath12k/dp_rx.h       |    9 +
 drivers/net/wireless/ath/ath12k/hal.c         |    2 +
 drivers/net/wireless/ath/ath12k/hal.h         |   33 +
 .../net/wireless/ath/ath12k/wifi7/Makefile    |    1 +
 drivers/net/wireless/ath/ath12k/wifi7/dp.c    |   16 +-
 drivers/net/wireless/ath/ath12k/wifi7/dp.h    |    1 +
 .../net/wireless/ath/ath12k/wifi7/dp_mon.c    | 3354 ++++++++++++++++
 .../net/wireless/ath/ath12k/wifi7/dp_mon.h    |   23 +
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c |   19 +-
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h |   11 +-
 .../net/wireless/ath/ath12k/wifi7/hal_desc.h  |   19 -
 .../net/wireless/ath/ath12k/wifi7/hal_rx.h    |   15 -
 14 files changed, 3570 insertions(+), 3469 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/dp_mon.h


base-commit: f87034a7576f918f2e60a14f17185b492e91580d
-- 
2.34.1


