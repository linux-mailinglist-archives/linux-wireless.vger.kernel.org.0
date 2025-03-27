Return-Path: <linux-wireless+bounces-20879-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC66A72899
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Mar 2025 03:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BC633BC41B
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Mar 2025 02:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B035E54670;
	Thu, 27 Mar 2025 02:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PWWit/CL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191AB1805B
	for <linux-wireless@vger.kernel.org>; Thu, 27 Mar 2025 02:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743041163; cv=none; b=LAHF9r1+EuenPDu2tQqyj0bmMbSQd8d40Wn97oXkZBXpDOO/C16kcPaZKYK4zvgiNfYSiA4jQN0nWxmeYxmnYjgIyJoVqhPZh2LsxJ32e1vIMcMdZi7U6y0eUYo/ROVcK+s+3fJ7CV7jNRIenXuGp7XiovGcfYEgQt5ZjoEHDdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743041163; c=relaxed/simple;
	bh=vU9FXiM1HIY9sa2Z36ujpk0pycomMnjVE8SOIJsbn7I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WT/tAIkSjHdWxvJplu3Q3voLafJ4IOl+I4ZTPwyAm+maq6CniSgSUY2h8aepVca/dMcxsfZ1vDIDmMvkdja0Uqmd0mx3/tTWwG0vxE5D/k7+3ShARYUgWlLmnOgt3xPHAgghpq8dcEImHbGgLhaKj2ukjon9OAY80nJWxRle5lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PWWit/CL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52QF58Xf029068;
	Thu, 27 Mar 2025 02:05:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=UYCkZ3JrcDwamHka2y5UTp
	ai1nck8SiQulvsZVKNOXA=; b=PWWit/CLl94cc2VsPhxbfgvLroFNr43aX+An9r
	/LtOxAEwMIYZIVa0IzzVGOwZ5W+3U7AvRQ8S/9YYuT8Pzvps1l9iss5ESeYgvr/3
	l/B4fN7KlMh3d2cQQGKCO0ZkXIr/c3kKalSqLfwy1JPWYQ+f0PulaskCcgycC/78
	gXp/jldd6cgjLApadlesauyCm0UfHJBOG4QWiuA4zG6Eb1xfNje6IR/Me6Xq903c
	3kmYcqo9ZsR8fJb6RYXhvOvGz0yL+wyy6N01KPd8vTvSTW09sLyNQqAvoXxv0Eyi
	MAYH3YkEc0oRv7MVjIRI4oe1S6XOf3QaG7bh1hHQ3CfvlALQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ktends9v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 02:05:58 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52R25vMg017648
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 02:05:57 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 26 Mar 2025 19:05:56 -0700
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>, <quic_kangyang@quicinc.com>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath-next v14 0/4] wifi: ath12k: add 11d scan offload support and handle country code for WCN7850
Date: Thu, 27 Mar 2025 10:05:23 +0800
Message-ID: <20250327020527.1527-1-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1.windows.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=TuvmhCXh c=1 sm=1 tr=0 ts=67e4b286 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=IvkglCj0MCVAe19RatQA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: M9hibBDC4ltH2mIaWlGOu27GEDajpzG-
X-Proofpoint-ORIG-GUID: M9hibBDC4ltH2mIaWlGOu27GEDajpzG-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_09,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 adultscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 mlxscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503270013

This patch-set mainly does four things:
1. Add handler to send WMI_SET_CURRENT_COUNTRY_CMDID to firmware.
2. Use WMI_SET_CURRENT_COUNTRY_CMDID to set country code for WCN7850.
3. Implement 11d scan offload, and update new channel list to firmware
when 11d scan finished.
4. Store country code, and update it to firmware after device recovery.

With this patch-set, WCN7850 can do 11d offload scan and update country
code to firmware successfully.

Note: This patch-set is an old patch-set in public review written by
Wen Gong. Just resend it for him.
Link: https://patchwork.kernel.org/project/linux-wireless/cover/20230914090746.23560-1-quic_wgong@quicinc.com/

v14: add branch tag.
v13: rebase on tag: ath/main(ath-202503251458).
v12:
    1. add reviewed-by tag.
    2. add branch tag.
    3. rebase on tag: ath-202503172347.
v11:
    1. swap the order of patch #2 and #3.
    2. rebase on tag:ath/main(ath-202502181756).
v10: rebase on tag: ath/main(ath-202502111625).
v9: update copy right in patch #1, #2, #3.
v8: rebase on tag: ath/main(ath-202501172342).
v7:
    1. rebase on tag: ath/main(ath-202412191756).
    2. rewrite commit message for patch#2.
v6: rebase on tag: ath/main(ath-202410161539).
v5: rebase on tag: ath/main(ath-202410111606).
v4: rebase on tag: ath-202410072115.
v3:
    1. use wiphy::mtx lock instead of adding a new lock(patch#2).
    2. rename struct according to wmi naming convention(patch#1, #2).
    3. update copyright in reg.h
    4. modifiy patch#3, #4 due to struct name change.
v2: change per Jeff.
    1. change alpha2 length from 3 to 2.
    2. change wmi_11d_new_cc_ev to wmi_11d_new_cc_event.

Wen Gong (4):
  wifi: ath12k: add configure country code for WCN7850
  wifi: ath12k: use correct WMI command to set country code for WCN7850
  wifi: ath12k: add 11d scan offload support
  wifi: ath12k: store and send country code to firmware after recovery

 drivers/net/wireless/ath/ath12k/core.c |  34 ++++-
 drivers/net/wireless/ath/ath12k/core.h |  17 +++
 drivers/net/wireless/ath/ath12k/hw.c   |   6 +
 drivers/net/wireless/ath/ath12k/hw.h   |   1 +
 drivers/net/wireless/ath/ath12k/mac.c  | 167 ++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/mac.h  |   7 ++
 drivers/net/wireless/ath/ath12k/reg.c  |  72 ++++++++---
 drivers/net/wireless/ath/ath12k/reg.h  |   2 +-
 drivers/net/wireless/ath/ath12k/wmi.c  | 158 ++++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/wmi.h  |  38 ++++++
 10 files changed, 480 insertions(+), 22 deletions(-)


base-commit: 11cea2b6a2e3a5ddf3562314d1a378e7ea1c26eb
-- 
2.34.1


