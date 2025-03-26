Return-Path: <linux-wireless+bounces-20817-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4345BA70E76
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Mar 2025 02:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C541E165D27
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Mar 2025 01:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9975E2E403;
	Wed, 26 Mar 2025 01:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hp57fcwD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DA0DF5C;
	Wed, 26 Mar 2025 01:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742952822; cv=none; b=Liau36PFO/hhIHmtpK1de/6WPg6fJ1y3fsNnmhIkQJZSgsNdtEFTH8JVEbvZfu0St03VQZyf6/WdxT6iJ0Ck/kIYdx+ONKh20NnFPVY4pv9HpgzDhD82sWTzr7BLQyLWenjBq+6jD+AY5DLNExEjnarJNfl7mprSeDoWe6ZQAhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742952822; c=relaxed/simple;
	bh=LswOaRk3hDdXdGBVP0ozvzch8N+1CKJilD5A4meq7Hw=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=uoq+BQlRRVbtn2QY5Qcs2oL34qZylslf/I67/OCfOlx0cshTWFXd1fAAxn0iFZW6mcDNTYad5enBw2y+e7LnYY90w65I1emlMdF2BQqZsmck7leuqOvI1O26ujdbDeQYjPyHM6XNbCp5DZZgYUBA8yVLrfYDeVXUUzC/dcBdIBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hp57fcwD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52PGaVDX014426;
	Wed, 26 Mar 2025 01:33:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=H3vC/46atoHAAwf5AI9wOB
	WhE3yr3O6wfFeYItlbDnk=; b=hp57fcwDZGsolCyLnNXZSmHYZr1hrxRf6XzPvS
	EIlBh9qKP1RlDszRahBomLUacpTymqy8X0KnDSpqXG97oObgxefow7C3wDo/R7p2
	gyxc0X/bdg72iEpyvJPG4li10P7XGsXAii4wWkat+2woz+zyH3AWA73cfd1SnpA0
	RfT9BL0QmZHGUQGzPT5mlGuBEbLziaE4TVlBfXBYUjifx6y/JYWfKZR+jomDShzK
	PdBKBBAdHPWUGfPBj+ialTFt35ELrfaTAQ5iYO1Xa0tcWQpHMhlKsev9Ys+HbyF+
	LYjmKjxNKUSGHohpknmxW3OCzbFO0TfYcFJAv/c0Gnskwjng==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45k7qjd9fe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 01:33:30 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52Q1XTad007527
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 01:33:29 GMT
Received: from [127.0.1.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 25 Mar
 2025 18:33:27 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
Subject: [PATCH ath-next v2 0/6] wifi: ath11k: bring hibernation support
 back
Date: Wed, 26 Mar 2025 09:33:04 +0800
Message-ID: <20250326-ath11k-bring-hibernation-back-v2-0-87fdc2d6428f@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFBZ42cC/4WNQQ6CMBBFr2Jm7RhaaSSuvIdhMS0DnRCLtpVgC
 He3Ie5dvvy8/1ZIHIUTXA8rRJ4lyRQK6OMBnKcwMEpXGHSlTXXWNVL2So1oo4QBvViOgXKR0JI
 bkZWiruFGU9dD+XhG7mXZ/+9QVAy8ZGjL4iXlKX728Gz2/dcwfxqzwQprvihVU0/G8u31FifBn
 dz0gHbbti/GakSG1gAAAA==
X-Change-ID: 20250324-ath11k-bring-hibernation-back-e11ad8e82adf
To: Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson
	<jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath11k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: F_9GYMJWaM2OzAN6ya3MSuYS6sOEN_nu
X-Proofpoint-GUID: F_9GYMJWaM2OzAN6ya3MSuYS6sOEN_nu
X-Authority-Analysis: v=2.4 cv=feOty1QF c=1 sm=1 tr=0 ts=67e3596a cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=AIL0eFhmMaeWv0y-ez0A:9
 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_10,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 clxscore=1011 phishscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 mlxlogscore=781 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503260008

To handle the Lenovo unexpected wakeup issue [1], previously we revert
commit 166a490f59ac ("wifi: ath11k: support hibernation"). However we
need to bring it back, of course with additional changes such that Lenovo
machines would not break.

For suspend (S3), as those machines work well in WoWLAN mode, the thought
here is that we put WLAN target into WoWLAN mode on those machines while
into non-WoWLAN mode (which is done in the reverted commit) on other
machines. This requires us to identify Lenovo machines from others. For
that purpose, read machine info from DMI interface, match it against all
known affected machines. If there is a match, choose WoWLAN suspend mode,
else choose non-WoWLAN mode. This is done in patches [1 - 4/6]

For hibernation (S4), non-WoWLAN mode is chosen for all machines. The
unexpected wakeup issue should not happen in this mode, since WLAN target
power is cut off. To know if the system is going to suspend or to
hibernate, register a notifier such that kernel can notify us of such
infomation. This is done in patch [5/6]

The last patch bring the reverted "wifi: ath11k: restore country code
during resume" commit back.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=219196

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
Changes in v2:
- fix compile warnings
- support hibernation on Lenovo machines listed in quirk table
- Link to v1: https://lore.kernel.org/linux-wireless/20250320023003.65028-1-quic_bqiang@quicinc.com/

---
Baochen Qiang (6):
      wifi: ath11k: determine PM policy based on machine model
      wifi: ath11k: introduce ath11k_core_continue_suspend_resume()
      wifi: ath11k: refactor ath11k_core_suspend/_resume()
      wifi: ath11k: support non-WoWLAN mode suspend as well
      wifi: ath11l: choose default PM policy for hibernation
      Reapply "wifi: ath11k: restore country code during resume"

 drivers/net/wireless/ath/ath11k/ahb.c  |   4 +-
 drivers/net/wireless/ath/ath11k/core.c | 294 ++++++++++++++++++++++++++++++---
 drivers/net/wireless/ath/ath11k/core.h |  16 ++
 drivers/net/wireless/ath/ath11k/hif.h  |  14 +-
 drivers/net/wireless/ath/ath11k/mhi.c  |  14 +-
 drivers/net/wireless/ath/ath11k/mhi.h  |   5 +-
 drivers/net/wireless/ath/ath11k/pci.c  |  45 ++++-
 drivers/net/wireless/ath/ath11k/qmi.c  |   4 +-
 8 files changed, 350 insertions(+), 46 deletions(-)
---
base-commit: b6f473c96421b8b451a8df8ccb620bcd71d4b3f4
change-id: 20250324-ath11k-bring-hibernation-back-e11ad8e82adf

Best regards,
-- 
Baochen Qiang <quic_bqiang@quicinc.com>


