Return-Path: <linux-wireless+bounces-19725-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C288FA4CE27
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 23:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D98A3AD92A
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 22:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C207A23717F;
	Mon,  3 Mar 2025 22:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZFDst2oL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1B020E313
	for <linux-wireless@vger.kernel.org>; Mon,  3 Mar 2025 22:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741040352; cv=none; b=L4VnH2Jz1Zj4eLZSFLsoRa5fb1WemBwRQnAiA3UFT49wdPHweJNHp5GT7OMzvWcGz99FgVD3D6iunIWDQkYKwguJr3KfKIH3xxUIdIZ6+7L/Vw9EwLTmBIRSx1XKrjZ/Csv7QalACp1ErxH+RlGdvf2rnzJ9xKvryFZrmNsK5fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741040352; c=relaxed/simple;
	bh=yQDZkqCznXUyBfQMnFVmiVqkYf5vAhTosrfH3LfzWrs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=afBmWGuUPI7dHsrNKYgcVxBumcDtQc8vREgkDLB/llj6B1Bp/aD7CdKVZJfJuJRCPteqpeRd8sbFCA3kuOKPutN6p5bsScNE45aW9cWO+2X+AYozMxfi6E8GXZbzVIXYxMtb3+52VSVSRBudFsZn//K75mJBFmhRqT7AWQMNKfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZFDst2oL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523AGFDa029520;
	Mon, 3 Mar 2025 22:19:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=zJaw4OIUBfrnqvA+E2Qehp
	w/lV7Ut1ms1uOHsw0G2nI=; b=ZFDst2oLu5GYeepVUnBBkK/tME7axLEYVelwy0
	LvNR+PNTjc/SeP5phxRosKg8lYvIgjNfqIq7vVjueqzsXQHuUAlH2LFCahcvWAJA
	acjQfGOXOO9q5SUVDnNhvaGjhiy/7t0vCs2PizaPf8G/RcxorzBcFXb8dHCmb78m
	7jOFxAvkZizDYUGHBmNchsfYBKLQSmhMuZZY8j4UQupr+v0cvkJqTKJzjlkv0q7p
	5Icc0V2jWhEyZ6A2s1u558mjnWUz4KGllvC23GnyDtiHNLpuzGwC6MIekIeb/vP7
	uBtp4bFpP3/Ho9/rrRzv8iqTfhhoKHEL8uTnV9kfaN9tXOsw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453tm5p9cc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Mar 2025 22:19:01 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 523MJ00d022637
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 3 Mar 2025 22:19:00 GMT
Received: from hu-ramess-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 3 Mar 2025 14:18:58 -0800
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>
Subject: [PATCH wireless-next v3 0/4] wifi: cfg80211: update EML capabilities of an ML Station
Date: Tue, 4 Mar 2025 03:48:39 +0530
Message-ID: <20250303221843.1809753-1-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-ORIG-GUID: s2EhCdQVMwT7WZgh4WGGjiU2HhRJ-O6O
X-Proofpoint-GUID: s2EhCdQVMwT7WZgh4WGGjiU2HhRJ-O6O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_11,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=940 suspectscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 bulkscore=0 mlxscore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503030171

When EMLSR is enabled for an ML association, the EML capabilities
advertised by the ML Station needs to be updated to drivers in order to
trigger EMLSR operation.
Add support to fetch EML capabilities advertised by ML station and
cache it in ieee80211_sta data structure so that drivers can use them
whenever required.

*v3:
   - Restricted eml_capability change, if STA is already in
     ASSOCIATED state
   - Added new PATCH (3/4) and defined helper functions to get
     EML delay and timeout values from eml capability
   - Used the helpers defined in PATCH 3/4 to fetch values in
     PATCH 4/4
*v2:
   - Added new flag eml_cap_present to indicate if EML attribute is
     present as part of new/set station command.

Ramasamy Kaliappan (3):
  wifi: cfg80211: Add support to get EMLSR capabilities of non-AP MLD
  wifi: mac80211: update ML STA with EML capabilities
  wifi: ath12k: update EMLSR capabilities of ML Station

Rameshkumar Sundaram (1):
  wifi: mac80211: Add helpers to fetch EMLSR delay and timeout values

 drivers/net/wireless/ath/ath12k/mac.c |  1 +
 drivers/net/wireless/ath/ath12k/wmi.c | 21 +++++++-
 drivers/net/wireless/ath/ath12k/wmi.h |  1 +
 include/linux/ieee80211.h             | 71 +++++++++++++++++++++++++++
 include/net/cfg80211.h                |  5 ++
 include/net/mac80211.h                |  2 +
 net/mac80211/cfg.c                    |  3 ++
 net/wireless/nl80211.c                | 15 +++++-
 8 files changed, 117 insertions(+), 2 deletions(-)


base-commit: e5328c14590d034dc586e56aaab88e966d06efa7
-- 
2.34.1


