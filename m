Return-Path: <linux-wireless+bounces-6960-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4FA8B5032
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 06:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D8D51F21AD7
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 04:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6920E8F6E;
	Mon, 29 Apr 2024 04:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bE4ye/EO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17819463
	for <linux-wireless@vger.kernel.org>; Mon, 29 Apr 2024 04:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714364862; cv=none; b=THuBJU7kLQp/LzaKyduzd6Sghsf876qxMlHoOKODXHC87jvqKfH3YCETWBJfi/y3uOdgVojBpPER5AhJbJO/Oz76/v/XHWNFjFopDmEX/M80PjMdW8ESlAi39tRwXAtoR0cB3Ghh7IGXgbwL2ByDcJZtafPK3ZEBVz7NFo90Ql0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714364862; c=relaxed/simple;
	bh=WZ8d4gU+qgu6zNJUgW9aRz9KQTGihzKhRpaSLiWMJaQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TmV2tG1e8Ka55XTVJchacF9Fg92qXwXm+MAZrUBwzuBYFfP24c/JJoRS4jXXAObvKPZ/hVmHlX/JAr1mhslmvbL6jGam+VAIwcfWDMUyTx97U3H5UR/Q54pBRhperxdcEDJLtTYMLzGFcv5O6IaO/EB6t87o+mbCU1vMFV82wj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bE4ye/EO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43T3QH11007150;
	Mon, 29 Apr 2024 04:27:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=qcppdkim1; bh=5q2K8xBKQ9Jl844a5Sug
	durDoUavfSeIvZB8oGF/J+o=; b=bE4ye/EO9ydx61Vdy7GpI9ikYekPtnZfh+A7
	noQ9Q+gedHUhdpe77VgWkjP3ejzikIc0pQbX5fzBouTmBZGza3ZKxb67lybnNYmE
	XjufMpQw26QB6uOVcf3MOHrhpYxXDuB70rkGz60n9mVca1+DTrs4q6muuibsL+eG
	LzeFUBeSHZLCds/dfpUlwLoPUuyubatW3SDkg9bQdFgbxQMw4hD8MkK27d6hRIu2
	Ln6ci6ByBiarmcvWKneB1SQhoNTHCKw0q++mlaxtjhOfwZJYIK2BlixchibEwlzM
	Xx1DDkCIfvhKItWmW2wcL5Cc3B4LfCU2cya25CFkdBc5/ouDFg==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xrsk7an97-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 04:27:30 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 43T4RQge001768;
	Mon, 29 Apr 2024 04:27:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3xrtekr37d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 04:27:26 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43T4RQ4w001763;
	Mon, 29 Apr 2024 04:27:26 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-hprem-blr.qualcomm.com [10.190.108.75])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 43T4RQZY001762
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 04:27:26 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 4146166)
	id 40A754114B; Mon, 29 Apr 2024 09:57:25 +0530 (+0530)
From: Harshitha Prem <quic_hprem@quicinc.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Harshitha Prem <quic_hprem@quicinc.com>
Subject: [PATCH] cfg80211: Allow pre-CAC for self-managed wiphy
Date: Mon, 29 Apr 2024 09:57:23 +0530
Message-Id: <20240429042723.2847389-1-quic_hprem@quicinc.com>
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
X-Proofpoint-GUID: Owekhh_DmlNsuFF7cS65VjSlZdOhQrnt
X-Proofpoint-ORIG-GUID: Owekhh_DmlNsuFF7cS65VjSlZdOhQrnt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_01,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 suspectscore=0 priorityscore=1501 mlxlogscore=603 bulkscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404290028

Currently, to allow pre-CAC it requires both driver's regulatory domain
in wiphy and cfg80211 local regulatory domain to be same, along with the
region to be in ETSI.

But, for self-managed driver, some countries have mismatch between these
two regulatory domains and it would not allow for a pre-CAC. For example,
in ath12k driver (self-managed), country Sri Lanka (LK) is classified as
FCC domain as per cfg80211 local regulatory database but as per ath12k
driver it falls under ETSI domain then because of this mismatch, the
driver might not be able to do a pre-CAC.

Hence, add changes to allow pre-CAC based on wiphy's regulatory setting
if it is a self-managed wiphy.

Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
---
 net/wireless/reg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 3cef0021a3db..e8cc38e37377 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -4214,7 +4214,8 @@ bool regulatory_pre_cac_allowed(struct wiphy *wiphy)
 		return pre_cac_allowed;
 	}
 
-	if (regd->dfs_region == wiphy_regd->dfs_region &&
+	if ((regd->dfs_region == wiphy_regd->dfs_region ||
+	     wiphy->regulatory_flags & REGULATORY_WIPHY_SELF_MANAGED) &&
 	    wiphy_regd->dfs_region == NL80211_DFS_ETSI)
 		pre_cac_allowed = true;
 
-- 
2.34.1


