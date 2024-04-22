Return-Path: <linux-wireless+bounces-6633-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4C98AC3C0
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 07:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EDBF1C21B4D
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 05:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA02110A19;
	Mon, 22 Apr 2024 05:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CCXrXxG6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598FD18040
	for <linux-wireless@vger.kernel.org>; Mon, 22 Apr 2024 05:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713764100; cv=none; b=Fi5ETaX0DqMuqfsKz5+rIZBRnqHaiZ2dN3c0S5k21z8kr96RTdUVZM70s/5BDqox5mM+7ZKXtAjb1JW3Li51edigKNztMHuB2irMoAGXC012fZAY67m6J1ygtooDTt7T0+PAUxDiyMrdIeZS72CLJ75l4+XTvpIWsYjW5czI7o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713764100; c=relaxed/simple;
	bh=sREqMZQqEuWzwTtDnHfjrGiWTg7PYjqoRhyRB9b+uqE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hGPFw1FmiXH/Ub6/jhQvTpaHqZbjHJHhjWiQQhfiGxErO1DO9k1MZ7oNNrLD7Cf49MEfTKjhC7zOLZcOWaMwvlZcF+NmM7CaF1AECpYEUBi3u1IZ9ZNzI5TBFtZUhSPm5EX3AheaRSI++wLNpk5q03Ih3x6ZI7BQXw15Ll9DS3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CCXrXxG6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43M5EQlf021872;
	Mon, 22 Apr 2024 05:34:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=umA2WeMevJOBdVBn0nJ47nPsTgeke+FYcqePmaAgZl0=; b=CC
	XrXxG67eaTmFcTgedpD2yW18v1KDICAyw8eC23InYBsYt59eEpsN5M7a2ArS51P5
	aMD/LubsR5KN8nCaWSGmADskyEwIkF0hnu1nwaI3K/B23UelaW4f/x2SAWvNFBmd
	YQGDrazGEXS0lxRdj8Hlw+i+Pm1wzz6oYtZG9gEUrZa2NYfSb3Oh8Q5ijl9ZsfrQ
	86mv2YtKNKxJ9apyzjNcIBiY/9EljMHK70U0vUQe7MhWVZ+YwhuKMiOvFEaMb0J4
	vOiF/cj9JPeML3UL1h9i4uaBgvFFJON3Q2kfMOUHIOXmq4en2lbyWIioa2ANfybB
	MKY40W22HOQyADVvhJ7A==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xm6fkk7g7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 05:34:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43M5YjRX029278
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 05:34:45 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 21 Apr 2024 22:34:43 -0700
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH v2 7/7] wifi: mac80211_hwsim: add support for BSS color
Date: Mon, 22 Apr 2024 11:04:12 +0530
Message-ID: <20240422053412.2024075-8-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240422053412.2024075-1-quic_adisi@quicinc.com>
References: <20240422053412.2024075-1-quic_adisi@quicinc.com>
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
X-Proofpoint-GUID: XdoK98vhTnl4eBvaDCwsvvy85iXOCXCI
X-Proofpoint-ORIG-GUID: XdoK98vhTnl4eBvaDCwsvvy85iXOCXCI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_02,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 impostorscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 phishscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404220025

Advertise support for BSS color and then once the countdown reaches 0,
call color change finish.

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index f5aed44ec80a..64eeda1c398c 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -2313,6 +2313,10 @@ static void mac80211_hwsim_beacon_tx(void *arg, u8 *mac,
 
 	if (link_conf->csa_active && ieee80211_beacon_cntdwn_is_complete(vif, link_id))
 		ieee80211_csa_finish(vif, link_id);
+
+	if (link_conf->color_change_active &&
+	    ieee80211_beacon_cntdwn_is_complete(vif, link_id))
+		ieee80211_color_change_finish(vif, link_id);
 }
 
 static enum hrtimer_restart
@@ -5323,6 +5327,8 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 
 	wiphy_ext_feature_set(hw->wiphy,
 			      NL80211_EXT_FEATURE_SCAN_MIN_PREQ_CONTENT);
+	wiphy_ext_feature_set(hw->wiphy,
+			      NL80211_EXT_FEATURE_BSS_COLOR);
 
 	hw->wiphy->interface_modes = param->iftypes;
 
-- 
2.34.1


