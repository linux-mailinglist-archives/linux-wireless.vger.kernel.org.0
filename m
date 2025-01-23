Return-Path: <linux-wireless+bounces-17849-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A78A19C1D
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jan 2025 02:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9F5F16BCF4
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jan 2025 01:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A47AD27;
	Thu, 23 Jan 2025 01:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YQGkbtpV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34BC1E535
	for <linux-wireless@vger.kernel.org>; Thu, 23 Jan 2025 01:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737594691; cv=none; b=MCp+8OAyDJHK3YMyI4JOMl89Heh2T5LWBC6yW6JvsGx13+KT8C3+x74D7yN8PQnX5pQfEXV6vsZX7A8Y3zq+D9LYEv3zLIQJ29bQhsleb0dmP02tDvWDCgHzE5uatGhm2NiZLzGtJ2f9OmpfBdc82fYNHDGBIafb72S5RymWbyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737594691; c=relaxed/simple;
	bh=mT8PQlQUdcvHu4btQpn4obZzlW07BPi8wNZxd6Afeg0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iNtVjuAna4xmXES0jDnYYPefANJEmku2R3ddisO2dp23Pi0ZNzDDjNp+ST4EMv4HF2dm4FSqTFZ4emoNCe/H4ejQO4LwNDJI9x840Pi1VAbh4R8jIBSa/eXxbCSqVMPKWhedfLgHPE75+v2LOhm8d5Xh5smhmlOnONY/BgI3COM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YQGkbtpV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50MHxhhD031260;
	Thu, 23 Jan 2025 01:11:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=sruLST3Zuy7XlllwvjQWUAZ+
	cVPcUHz37Rnt0EVwK+Y=; b=YQGkbtpVUUgYGctpJ2Ne2A7a0ztPrtqJgh5s3YDw
	/8dwFiCmS1HZM2LKeoBwcJ5zeDEjxRzlpQ5ro9NgopHy5pyhR+7ExEOom5E8xyGu
	7WitRSX1Y3RM/VMI9RdvIJ92+JUCKjqToNSWhj3RB4ERODAJqG7wy0U+emGXt6Qo
	UZK5GBdisFU3WG0j0WCG8qI+RB8FU26SDQwSgsiq8VkwbbsREgh3WbJZRDp025Ih
	MYyV2ZxZs522aTc+07rWL17sXts1N7xD0U+Rp4LzwjxJwckwdvPxqlKmz6bbjvly
	CjhfsvJvuU78G2elxDPvJjYhBOCgIEIU73qHNeI2nyEm3g==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44b5jjrr83-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 01:11:25 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50N1BAxD024163
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 01:11:10 GMT
Received: from hu-nithp-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 22 Jan 2025 17:11:08 -0800
From: Nithyanantham Paramasivam <quic_nithp@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Nithyanantham Paramasivam
	<quic_nithp@quicinc.com>
Subject: [PATCH 1/2] wifi: cfg80211: Allow monitor creation in NO_VIRTUAL_MONITOR mode with active AP
Date: Thu, 23 Jan 2025 06:39:49 +0530
Message-ID: <20250123010950.1958211-2-quic_nithp@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250123010950.1958211-1-quic_nithp@quicinc.com>
References: <20250123010950.1958211-1-quic_nithp@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: oqCkGFsSlF7MahTOO_jFsFoI3UsLLbCo
X-Proofpoint-GUID: oqCkGFsSlF7MahTOO_jFsFoI3UsLLbCo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_11,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxlogscore=877 adultscore=0 mlxscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501230007

Currently, in NO_VIRTUAL_MONITOR mode, when creating an
AP/STA + monitor, there is a restriction: if the AP/STA is running,
setting the channel for the monitor is not allowed. For example,
in a scenario with three supported radios where the AP uses only the
2 GHz and 5 GHz bands, the 6 GHz band remains available. However,
due to the restriction that rdev->num_running_ifaces must equal
rdev->num_running_monitor_ifaces in cfg80211_has_monitors_only(),
we are unable to create the monitor interface.

cfg80211_set_monitor_channel -> cfg80211_has_monitors_only()

static inline bool cfg80211_has_monitors_only() {
...
   return rdev->num_running_ifaces == rdev->num_running_monitor_ifaces
        && rdev->num_running_ifaces > 0;
}

To address this, add the new wiphy flag
WIPHY_FLAG_SUPPORTS_NO_VIRTUAL_MONITOR to advertise no virtual monitor
support to cfg80211. This flag will allow the creation of a monitor
interface by bypassing the cfg80211_has_monitors_only() function.
There is no need for special handling after this, as
cfg80211_set_monitor_channel() will manage all interface combinations
and allowed radio conditions.

Signed-off-by: Nithyanantham Paramasivam <quic_nithp@quicinc.com>
---
 include/net/cfg80211.h | 3 +++
 net/wireless/chan.c    | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 363d7dd2255a..c5d4d1d9df58 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5035,6 +5035,8 @@ struct cfg80211_ops {
  * @WIPHY_FLAG_SUPPORTS_NSTR_NONPRIMARY: support connection to non-primary link
  *	of an NSTR mobile AP MLD.
  * @WIPHY_FLAG_DISABLE_WEXT: disable wireless extensions for this device
+ * @WIPHY_FLAG_SUPPORTS_NO_VIRTUAL_MONITOR: Flag to advertise no virtual monitor
+ *	support to cfg80211
  */
 enum wiphy_flags {
 	WIPHY_FLAG_SUPPORTS_EXT_KEK_KCK		= BIT(0),
@@ -5063,6 +5065,7 @@ enum wiphy_flags {
 	WIPHY_FLAG_HAS_CHANNEL_SWITCH		= BIT(23),
 	WIPHY_FLAG_NOTIFY_REGDOM_BY_DRIVER	= BIT(24),
 	WIPHY_FLAG_CHANNEL_CHANGE_ON_BEACON     = BIT(25),
+	WIPHY_FLAG_SUPPORTS_NO_VIRTUAL_MONITOR  = BIT(26),
 };
 
 /**
diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index 9f918b77b40e..3f80657bc273 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -1509,7 +1509,8 @@ int cfg80211_set_monitor_channel(struct cfg80211_registered_device *rdev,
 {
 	if (!rdev->ops->set_monitor_channel)
 		return -EOPNOTSUPP;
-	if (!cfg80211_has_monitors_only(rdev))
+	if (!(rdev->wiphy.flags & WIPHY_FLAG_SUPPORTS_NO_VIRTUAL_MONITOR) &&
+	    !cfg80211_has_monitors_only(rdev))
 		return -EBUSY;
 
 	return rdev_set_monitor_channel(rdev, dev, chandef);
-- 
2.17.1


