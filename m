Return-Path: <linux-wireless+bounces-20912-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4A3A74369
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Mar 2025 06:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C15D33A686D
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Mar 2025 05:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA267211A20;
	Fri, 28 Mar 2025 05:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PiHrDBGY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811DB1C6FEF;
	Fri, 28 Mar 2025 05:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743139983; cv=none; b=qyawe0zkV7aYSHCt68fqGI03rvWIUuCp0zvL8MCX4opowmMjMjPSL5RJzDsgQHKT9ZuWpH2u1LIhvx9tXTHmm+W1bq2DSkqFF7dUw2E2ViRxON4vyg+gKvyqEjZROncrQN5UBgueeYfhKfVd+uYNq6/GjVUUfaWbEAvRpU3d2Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743139983; c=relaxed/simple;
	bh=rN6DyagHDwCs+EMnrIJyU6XNYW9xyTkNo7nBpeALx/U=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=oc2GxF37YYjYI57VkRwAj0FD7EIc2mkvfenN6qbn0RP4U9e0F+i4QRYgSWK6KAesGUpAzT/Pr8DF17QQHxAZTfz4daeCgah4t2i44BbxgYTRdywcyDJDjdkeL1U45evDBOqnnoQI17YddAeNQIk0Tr3pCaa9Nw3gSVJy0wmyd+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PiHrDBGY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52S5GjJZ021827;
	Fri, 28 Mar 2025 05:32:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=DPzqsLzc01etiPqCN2r1R8
	t0f9qXE5ghw0sQf/1D3D4=; b=PiHrDBGYWKkfIWVSifRwRn8mHDi2etXwPs4YXa
	T23qg1DEgEUyXE47r046dVP4lwswcZyba8bzj2EvEjym37+RonbhiMVEz3/GPi5S
	x3kQvQej5tOvBYcoGOi7kLY0hqYG/cjm9ghsW0Blq8uZu1d0/TH5yjO7B5CfK9MU
	523rYq7pxPk/4Rqr1dquoW+4BwFzcI0aUmkdS6sNtbmCGp/a22oQyYBv5Tn+Ikje
	dM0tUrjfbZy4FimDriWPgniR2m2IOmmThR0ongFirByAAPH6L+AqV/k6Opl6PbZj
	C0hIE5PpM+FA5SViD/CLyX9xnWz7ICWOGAUxt7QVHGMNv3pw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45kyr9rktu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Mar 2025 05:32:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52S5WU43028555
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Mar 2025 05:32:30 GMT
Received: from [127.0.1.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 27 Mar
 2025 22:32:28 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
Subject: [PATCH ath-next v3 0/6] wifi: ath11k: bring hibernation support
 back
Date: Fri, 28 Mar 2025 13:32:23 +0800
Message-ID: <20250328-ath11k-bring-hibernation-back-v3-0-23405ae23431@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGg05mcC/4XNQQ6CMBQE0KuQrv2GFgrElfcwLkr7Cz/Eom1tM
 IS72xAXunI5mcyblQX0hIGdipV5TBRodjlUh4LpUbkBgUzOTJRClpWoQcWR8wl6T26AkXr0TsU
 8gl7pCZBzZTrshDKWZePu0dKy+xeWp+Bwieyam5FCnP1rP05y7z8f8s9HklBCjS3ntbJK9nh+P
 EmT00c933Y7iW+v+eeJ7HWtNVqYphad/fW2bXsDQlcP3yYBAAA=
X-Change-ID: 20250324-ath11k-bring-hibernation-back-e11ad8e82adf
To: Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson
	<jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath11k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Takashi Iwai
	<tiwai@suse.de>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fLAS_WEdKn-NvDC9IFw5lwQjxsqAKWpn
X-Authority-Analysis: v=2.4 cv=UblRSLSN c=1 sm=1 tr=0 ts=67e6346f cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=AIL0eFhmMaeWv0y-ez0A:9
 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: fLAS_WEdKn-NvDC9IFw5lwQjxsqAKWpn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-28_02,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 mlxscore=0 impostorscore=0
 adultscore=0 clxscore=1011 mlxlogscore=851 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503280036

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
Changes in v3:
- [4/6] remove cosmetic blank line change to make it easy to be backport
- [5/6] s/ath11l/ath11k/ in subject
- pick Tested-by tag from Takashi Iwai
- Link to v2: https://lore.kernel.org/r/20250326-ath11k-bring-hibernation-back-v2-0-87fdc2d6428f@quicinc.com

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
      wifi: ath11k: choose default PM policy for hibernation
      Reapply "wifi: ath11k: restore country code during resume"

 drivers/net/wireless/ath/ath11k/ahb.c  |   4 +-
 drivers/net/wireless/ath/ath11k/core.c | 294 ++++++++++++++++++++++++++++++---
 drivers/net/wireless/ath/ath11k/core.h |  16 ++
 drivers/net/wireless/ath/ath11k/hif.h  |  14 +-
 drivers/net/wireless/ath/ath11k/mhi.c  |  14 +-
 drivers/net/wireless/ath/ath11k/mhi.h  |   4 +-
 drivers/net/wireless/ath/ath11k/pci.c  |  45 ++++-
 drivers/net/wireless/ath/ath11k/qmi.c  |   4 +-
 8 files changed, 350 insertions(+), 45 deletions(-)
---
base-commit: b6f473c96421b8b451a8df8ccb620bcd71d4b3f4
change-id: 20250324-ath11k-bring-hibernation-back-e11ad8e82adf

Best regards,
-- 
Baochen Qiang <quic_bqiang@quicinc.com>


