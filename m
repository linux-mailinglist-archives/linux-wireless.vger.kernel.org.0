Return-Path: <linux-wireless+bounces-2360-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 657FE8385DA
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 03:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1530A28A002
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 02:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B526E1FBE;
	Tue, 23 Jan 2024 02:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JZypEor2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B531FAD
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jan 2024 02:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705978646; cv=none; b=W/G4GZHEM6jIE2AqCLKO/az8dZULWXP9dlPQq1ULtDqqfvzzywsrmNIVpes26LvltrjQgoNDOgP4jOv/1/CU05zSoatFiRxAf3BjyUTYofJd7ASd6RYgzfpBhLvsejdcKlNnd8SmEuPEUMw4t9slBhC5xsuh/BhuiKEQhZXQVNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705978646; c=relaxed/simple;
	bh=oz17DnRoBAzfqJ1tRkxFSFnwnfKwmGolrqQ746enqfY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B4+U3AlOEByTP8YtqOA4GOQjM9vEPbsnPwfGoAyPkkTTeeYE03bX1ibG9qjx8VgTXicPGdDFzKbEYXkPpE8RphHx+a0+JQdymQDk0L+IkFWfycbqC5tkLYWUM3EHEYj6SLhiOcgnJJUMNwhK6Drck8GBKrjAyhRYcbc5/CWVPF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JZypEor2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40N1pnux032489;
	Tue, 23 Jan 2024 02:57:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=2rULums
	sjPVe3Ecz4XwiMCfYVtvvuc+ITFJdrM0Ckbo=; b=JZypEor2A9YAfnEcaHt2w3i
	r/6cQfYVTp9BnKlKqi+hyOJUeSJ+UAN5nuoTLiI4GFjtw+NwTnhFTITLqisF918Y
	cQpZpXaN/79btD/CU4HJry/gq2slFjXGlZ70dZzkS8keY8eLU+hYNuD+pbvqKYx8
	h4sgkmJSjQ6EvXQPRAYcadKysNlvU7SecKKyYpVHvriTkfaamwrhNLLVTzHwkqN9
	aNs5aEKKPb3yxTAq+xOGxG0A0NSSexw9XjiInBgBmTCRwpJ5FYeTXN7v4BkMjajg
	nsoRaCchIwWr084geuXfaL/SPQUZkK1Zf8s2sWf/S5GeskAtIYRp47qAUn9cMlw=
	=
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vt3ku85xd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 02:57:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40N2vAKX016227
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 02:57:10 GMT
Received: from bqiang-Celadon-RN.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 22 Jan 2024 18:57:09 -0800
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH 0/4] wifi: ath11k: fix connection failure due to unexpected peer delete
Date: Tue, 23 Jan 2024 10:56:56 +0800
Message-ID: <20240123025700.2929-1-quic_bqiang@quicinc.com>
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
X-Proofpoint-ORIG-GUID: bL0mO0VpTQhg7ab17WvsppsFT4_Gu19E
X-Proofpoint-GUID: bL0mO0VpTQhg7ab17WvsppsFT4_Gu19E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_12,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=926
 suspectscore=0 priorityscore=1501 phishscore=0 clxscore=1015 adultscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401230018

Currently ath11k_mac_op_unassign_vif_chanctx() deletes peer but
ath11k_mac_op_assign_vif_chanctx() doesn't create it. This results in
connection failure if MAC80211 calls drv_unassign_vif_chanctx() and
drv_assign_vif_chanctx() during AUTH and ASSOC, see below log:

[  102.372431] wlan0: authenticated
[  102.372585] ath11k_pci 0000:01:00.0: wlan0: disabling HT/VHT/HE as WMM/QoS is not supported by the AP
[  102.372593] ath11k_pci 0000:01:00.0: mac chanctx unassign ptr ffff895084638598 vdev_id 0
[  102.372808] ath11k_pci 0000:01:00.0: WMI vdev stop id 0x0
[  102.383114] ath11k_pci 0000:01:00.0: vdev stopped for vdev id 0
[  102.384689] ath11k_pci 0000:01:00.0: WMI peer delete vdev_id 0 peer_addr 20:e5:2a:21:c4:51
[  102.396676] ath11k_pci 0000:01:00.0: htt peer unmap vdev 0 peer 20:e5:2a:21:c4:51 id 3
[  102.396711] ath11k_pci 0000:01:00.0: peer delete resp for vdev id 0 addr 20:e5:2a:21:c4:51
[  102.396722] ath11k_pci 0000:01:00.0: mac removed peer 20:e5:2a:21:c4:51  vdev 0 after vdev stop
[  102.396780] ath11k_pci 0000:01:00.0: mac chanctx assign ptr ffff895084639c18 vdev_id 0
[  102.400628] wlan0: associate with 20:e5:2a:21:c4:51 (try 1/3)
[  102.508864] wlan0: associate with 20:e5:2a:21:c4:51 (try 2/3)
[  102.612815] wlan0: associate with 20:e5:2a:21:c4:51 (try 3/3)
[  102.720846] wlan0: association with 20:e5:2a:21:c4:51 timed out

The peer delete logic in ath11k_mac_op_unassign_vif_chanctx() is
introduced by commit b4a0f54156ac ("ath11k: move peer delete after
vdev stop of station for QCA6390 and WCN6855") to fix firmware
crash issue caused by unexpected vdev stop/peer delete sequence.

Actually for a STA interface peer should be deleted in
ath11k_mac_op_sta_state() when STA's state changes from
IEEE80211_STA_NONE to IEEE80211_STA_NOTEXIST, which also coincides
with current peer creation design that peer is created during
IEEE80211_STA_NOTEXIST -> IEEE80211_STA_NONE transition. So move
peer delete back to ath11k_mac_op_sta_state(), also stop vdev before
deleting peer to fix the firmware crash issue mentioned there. In
this way the connection failure mentioned here is also fixed.

Also do some cleanups in patch "wifi: ath11k: remove invalid peer
create logic", and refactor in patches "wifi: ath11k: rename
ath11k_start_vdev_delay()" and "wifi: ath11k: avoid forward declaration
of ath11k_mac_start_vdev_delay()".

Tested this patch set using QCA6390 and WCN6855 on both STA and SAP
interfaces. Basic connection and ping work well.

Baochen Qiang (4):
  wifi: ath11k: remove invalid peer create logic
  wifi: ath11k: rename ath11k_start_vdev_delay()
  wifi: ath11k: avoid forward declaration of
    ath11k_mac_start_vdev_delay()
  wifi: ath11k: fix connection failure due to unexpected peer delete

 drivers/net/wireless/ath/ath11k/mac.c | 564 +++++++++++++-------------
 1 file changed, 288 insertions(+), 276 deletions(-)


base-commit: 8ff464a183f92836d7fd99edceef50a89d8ea797
-- 
2.25.1


