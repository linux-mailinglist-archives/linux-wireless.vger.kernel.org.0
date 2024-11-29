Return-Path: <linux-wireless+bounces-15798-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE85D9DBF9C
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Nov 2024 08:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19889B210F4
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Nov 2024 07:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C03155A30;
	Fri, 29 Nov 2024 07:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="asgCMqr2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C449F1386DA
	for <linux-wireless@vger.kernel.org>; Fri, 29 Nov 2024 07:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732864067; cv=none; b=j+QYrbDeE8qgvoB7N+8oOFrSc15NY2dI3Fg0po8rbVzf0GEwNkZSDQ6rMBmDqYkd7kq5nVj3eNasxIU9MHgYiqzRXCLeYEfglxL/v/NvXie+IQR9D2mEJCpNrUbAgnqLm2NrHVaVK1Tr5WY4c14FuXxlJU6Q6ac7koS3CJX3v18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732864067; c=relaxed/simple;
	bh=gZEIBgYoqArBR1rSrPslwefRrp1WYe7iELsx5u6iTYM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oNpHuysAKSGyYxLCHRn8WqVzehDbj4KhfAAMqaY/JU0bNH6nAbMs7C7MTJ5TXIjfAJm3qKOw/t0JsU6pgcb4icbzoZJKTDTD3Ik4errpQ7MEgjdelxR2pBhS/otypr5Vnwl2gzbbg3ZWzfxTwP4ul0Bk7WzruJu2PyQ0gSZiOVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=asgCMqr2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AT0o5Ni025379;
	Fri, 29 Nov 2024 07:07:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UhuDktOsdK31qUSnUDvv8aSlwfyes9vnkdmizfcLstU=; b=asgCMqr2A4L65Upq
	CRRsxTahr4zfPWV3rFkulFK/DHFYnxe1dm799YCOuuEzizvcasBHSlmEnfaZo6q1
	iKwlvyN5etn04DJ5l+rFFA16NOOAtG3VbFdXEkO3yCLWhXAZI+f7Rf7b9j+LfOzt
	bTmjiOL7e1ts0vZVFsL7bNhVwtp4cG7H2OTAElR3r3Z/OhUG4DrzOiBvBy+9hFls
	sKb4oY6J7C+11z3YHkkf7bazSVg66LdgftTu41n8CSlwB9vnuPVru+ROm0mgfGzF
	TxCIs7uepTZiwbHYb0Sc2ocNOd+yyNEdtmyeG0dXWFHkI/9tHKh/1C44JplGEhZ0
	rjz3pA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4366xy4mnn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Nov 2024 07:07:42 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AT77fas010552
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Nov 2024 07:07:41 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 28 Nov 2024 23:07:40 -0800
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v3 1/2] wifi: ath11k: move update channel list from update reg worker to reg notifier
Date: Fri, 29 Nov 2024 15:07:13 +0800
Message-ID: <20241129070714.226-2-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1.windows.1
In-Reply-To: <20241129070714.226-1-quic_kangyang@quicinc.com>
References: <20241129070714.226-1-quic_kangyang@quicinc.com>
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
X-Proofpoint-GUID: xuoonHGzs-CehPQnM9yMdpfuC89k9K3f
X-Proofpoint-ORIG-GUID: xuoonHGzs-CehPQnM9yMdpfuC89k9K3f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 clxscore=1011 malwarescore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2411290056

From: Wen Gong <quic_wgong@quicinc.com>

Currently ath11k call regulatory_set_wiphy_regd() in ath11k_regd_update()
to notify the reg domain change to cfg80211 and update channel list by
reg_work, then ath11k immediately update channel list to firmware by
ath11k_reg_update_chan_list().

callstack:
ath11k_regd_update
->regulatory_set_wiphy_regd
           -> schedule_work(&reg_work)
-> ath11k_reg_update_chan_list

They are running in two threads, it leads the channel list data out of
sync caused by muti-threads without synchronization. At this time,
ath11k may update wrong channel list to firmware because the reg_work
still running or even hasn't started yet. In this case, if the
ath11k_reg_update_chan_list accesses an improperly updated channel list
before reg_work is completed, it may result in out of bounds write
errors, as shown in the KASAN report:

BUG: KASAN: slab-out-of-bounds in ath11k_reg_update_chan_list
Call Trace:
    ath11k_reg_update_chan_list+0xbfe/0xfe0 [ath11k]
    kfree+0x109/0x3a0
    ath11k_regd_update+0x1cf/0x350 [ath11k]
    ath11k_regd_update_work+0x14/0x20 [ath11k]
    process_one_work+0xe35/0x14c0

The correct flow is after reg_work update the channel list according to
new reg domain, ath11k call ath11k_reg_update_chan_list() and update the
new channel list to firmware.

reg_call_notifier()(finally it will call ath11k_reg_notifier()) will be
called to by reg_work to notify ath11k when it finishes the channel
list update. So at this time, call ath11k_reg_update_chan_list() in
reg_call_notifier() with initiator type NL80211_REGDOM_SET_BY_DRIVER.
Then ath11k_reg_update_chan_list() will use the correct channel list.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3

Fixes: f45cb6b29cd3 ("wifi: ath11k: avoid deadlock during regulatory update in ath11k_regd_update()")
Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/reg.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/reg.c b/drivers/net/wireless/ath/ath11k/reg.c
index b0f289784dd3..cb2cf9b63d18 100644
--- a/drivers/net/wireless/ath/ath11k/reg.c
+++ b/drivers/net/wireless/ath/ath11k/reg.c
@@ -55,6 +55,19 @@ ath11k_reg_notifier(struct wiphy *wiphy, struct regulatory_request *request)
 	ath11k_dbg(ar->ab, ATH11K_DBG_REG,
 		   "Regulatory Notification received for %s\n", wiphy_name(wiphy));
 
+	if (request->initiator == NL80211_REGDOM_SET_BY_DRIVER) {
+		ath11k_dbg(ar->ab, ATH11K_DBG_REG,
+			   "driver initiated regd update\n");
+		if (ar->state != ATH11K_STATE_ON)
+			return;
+
+		ret = ath11k_reg_update_chan_list(ar, true);
+		if (ret)
+			ath11k_warn(ar->ab, "failed to update channel list: %d\n", ret);
+
+		return;
+	}
+
 	/* Currently supporting only General User Hints. Cell base user
 	 * hints to be handled later.
 	 * Hints from other sources like Core, Beacons are not expected for
@@ -293,12 +306,6 @@ int ath11k_regd_update(struct ath11k *ar)
 	if (ret)
 		goto err;
 
-	if (ar->state == ATH11K_STATE_ON) {
-		ret = ath11k_reg_update_chan_list(ar, true);
-		if (ret)
-			goto err;
-	}
-
 	return 0;
 err:
 	ath11k_warn(ab, "failed to perform regd update : %d\n", ret);
@@ -977,6 +984,7 @@ void ath11k_regd_update_work(struct work_struct *work)
 void ath11k_reg_init(struct ath11k *ar)
 {
 	ar->hw->wiphy->regulatory_flags = REGULATORY_WIPHY_SELF_MANAGED;
+	ar->hw->wiphy->flags |= WIPHY_FLAG_NOTIFY_REGDOM_BY_DRIVER;
 	ar->hw->wiphy->reg_notifier = ath11k_reg_notifier;
 }
 
-- 
2.34.1


