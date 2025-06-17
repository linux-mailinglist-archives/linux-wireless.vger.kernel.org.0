Return-Path: <linux-wireless+bounces-24167-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE23ADBFEC
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 05:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E0FC3A8C7B
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 03:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A225B1EF39F;
	Tue, 17 Jun 2025 03:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FO3C1lS8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CBC1EA7CC
	for <linux-wireless@vger.kernel.org>; Tue, 17 Jun 2025 03:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750131369; cv=none; b=ZGW6eF22JDQI5+8TDEx+LKpIwk80HDzV8pPAKShGsbYyUC9yoPNQvlt+mQheapEplQQHtbO88VU5jXOxPlbr9R1PWMlHFnC+PVP6eCoYhwzc++6w0pGYtnLqUgBXwudtSn16F9iFssMcx8KoogGN9rvicE6R2xzoZp1RSo1EvWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750131369; c=relaxed/simple;
	bh=dQxkobsAclMg4B6C3oDqN3OjfKg7051DNhwLh4ZsfOE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CJ/VzHGGBEKM6KkaERijVr3p4l6QzF5NU/ivm6bp1nz+INm/mpJT9x8ZVLGc7Nje/nTo58lzhQjff98b7CfQ5pBts9Ihkk+Ly2XnSFLtAr/xW13vwgPsZ04ip8+WxUNhy8eAxGO2pshL4a98mh2x0cJFlu2C/v+0RfZvGgNJxnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FO3C1lS8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55GH8gub016060
	for <linux-wireless@vger.kernel.org>; Tue, 17 Jun 2025 03:36:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=SXaiysyC/M+/tDpGKqLEbi
	nKnxqzYegzIqQucICqSuk=; b=FO3C1lS8x/gja3snDKyAey/S7EZk3Y4I7V3Qn8
	SK7GcLHrkvVE9egepyeFKTRX7U4FIY7XVbYyDrKYMSxOYj+RPH0svVGFh+JyDOhe
	wnG3q1Sy6lUkohWROBWrEErCC9KsEON7Qk+WIzD1SKJH6fEtKPWedPqHevc1ACdK
	h16Jo/NSSQqgE4x8E83wYhbl/lSqHiQ4UqFHBEIzCPTBFfGRO6HlQFpSfwP1YuJC
	yE52MgDZNJZQxrIX5q4pdbpV30wyRX/SIglt/FCXfmgNjM8Y1XirbLFTgVwlCEz0
	X9Kj725JJgUtYKVm99tYo3/9BHIvOeQ9pO4zYZNtu52Ts/uw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4791fsxm5q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 17 Jun 2025 03:36:06 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-31218e2d5b0so8288053a91.2
        for <linux-wireless@vger.kernel.org>; Mon, 16 Jun 2025 20:36:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750131365; x=1750736165;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SXaiysyC/M+/tDpGKqLEbinKnxqzYegzIqQucICqSuk=;
        b=tHMWIc/mOxRE2BK1FwLmG2tV9+71UdRJpkQ9MyMMP6EXtraJrbj02LS4o9c5ByaluL
         eaRmiOzpFHcEvtfWakEGSZYfReVJu17Ze3LN+xuhgRWgpM8JJ36q5vxOPN4F3qWBM+xe
         me3xUkfzZ3F0Qhyo0ThlZeEeXpcmhiPazFR+kGV7tqTsq39OYkydSnSd6P9D0J3ZnSdp
         jjDsSTaf9kjv22W73P6RA6kyrmov0DolPFnY0uBuB/pOyPuZfdJCYYaGGwdVypIWeQqB
         UF5YSydfhOHOJEZQ/b04Q59uoZNoFOwZXP227e+T9Guh9FA10sUY4BaWKtHHocC5GCf8
         Fnbw==
X-Gm-Message-State: AOJu0Yy/HKwkKFQJsGYC0E0SBktRYtN4KdWt9WoKGDSQan3aDGDadbxy
	QYuGdbZMlm9mVEtG3+AfifDcJBx0/gdz7r4Jl4N6SmXbOQWwn29h6bIkR/3WADoiwLEJt9vnC95
	PfKy1myR3SV7pSk1uCCDD7M92jK/9s/5VzK595z+8T6X6kCkUUtJiDE+yRT+EoJxtqT7SbA==
X-Gm-Gg: ASbGncuOjcEyqqizYhLVQXzQW+MarSp6bKfVsvblnKV0v4qI5Se+90rIWDnsoQqUeLK
	X7pB3g2BsfzX35HmLYEWXKPqeqMQACjKpQ0OR1+HiUU7kiB8VA1vaLBavt5kBosbF4RjlOrNWeR
	F74iCplm9uOfLl+lx44Mdioqrz72h40dVT6y6qCi3DK2qkG+mtp9+GKkArEXNfMk09wOGwiI4j5
	vU9FRCDnai+NZs7gnzDyNHFyAwiwOWEioP77DPYXOvNp9AEs/HxQmGyJrAQUeXLiH1JQxDipxP2
	NglXX9XbxuJeAiKXgfCYTnzklOd7hNmKNX5qiF3oUKoiujki2EN6IQxnA/clm0txK04YLgC6bRn
	yuMNBmLGoo3oNSzLSPaVbxZrGVGWEDGSgEM7kYmP7dPJsrH0=
X-Received: by 2002:a17:90b:4e90:b0:312:f88d:260b with SMTP id 98e67ed59e1d1-313f1c07f88mr20268767a91.14.1750131364615;
        Mon, 16 Jun 2025 20:36:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8F9gocBMZScl0mlUsjSwGe6dHuZffl7cW0gp2NR649XWeFN4k80zvim3Vf1qS+FoYNQ95Ew==
X-Received: by 2002:a17:90b:4e90:b0:312:f88d:260b with SMTP id 98e67ed59e1d1-313f1c07f88mr20268699a91.14.1750131364049;
        Mon, 16 Jun 2025 20:36:04 -0700 (PDT)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365d8a1fa0sm69273695ad.86.2025.06.16.20.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 20:36:03 -0700 (PDT)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Date: Tue, 17 Jun 2025 09:05:59 +0530
Subject: [PATCH ath-next v2] wifi: ath12k: handle regulatory hints during
 mac registration
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250617-handle_user_regd_update_hints_during_insmod-v2-1-10a6a48efe81@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAJ7iUGgC/6WQwW7DIAyGX6XiPCogAZKd9h5ThWhsEqQGOkiiV
 lXefSSXHbYd1l0s2b/8f7/9IBmTx0xeDw+ScPHZx1Aa8XIg3WBDj9RD6YlgQjIpBC1DuKCZy55
 J2IOZr2AnNIMPUzYwJx9640MeI9BadJojalc1ihTHa0LnbzvtndhpoAFvEzkVZfB5ium+x1j4r
 j9FXDjltLHONiAr3bT2LeZ8/JjtpYvjeCxly7FbK/6EtdTqDMwpOCP7br1dsoh/pBcFUUNTO+Y
 k007/gqi+EIrzvyGq7UFtCxI7BNe6HxDrun4CJfPahRgCAAA=
X-Change-ID: 20250522-handle_user_regd_update_hints_during_insmod-42c71ee7f386
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDAyOSBTYWx0ZWRfX+X9pOixDZCvV
 +hUW5YOok42tWaSrk9qX3rcvrexO7LFQoc6z35aSPKShtJm2AYDcwJ3BOQj4gVc6SNQ4+2CuWKd
 /i8o+Dde6y0XSK6Jvak78YO8muDGa7+x3Si8E2ro6S2F1SfABHOqrqRTlU7siyPl9IG38rPpanr
 2GiWk+NxWQlyYkfNSlP7oXC5fjUHSlGcPKWZ/ll71f3z6Cx5NaJDeb8B9bRbEUjJ3p+hMrCQN8Z
 h/mnUcKuEPxaKnB6n/JxjZLN/dq313102kOwbPF8c4InfLspDsduS7xK3hCrwM2quq7uHBJY1Iy
 6y8/RixBJq1rm7rBRpTbzKXiKW/vE9Me6IPBZTI11t1GeSRsOIR4+KKowaRV2r9L3OB5w25h15C
 iD61zbtpXu+se7jIw13QPi29uC4fpTrYzvGSlm8S28kJeDls9URGQjkeUbzyDva1S9lLZmG/
X-Proofpoint-ORIG-GUID: -2agoE7T17ioDZLcCJJ8noQPigcJZpr3
X-Authority-Analysis: v=2.4 cv=OLIn3TaB c=1 sm=1 tr=0 ts=6850e2a6 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=cjyl3gcxlCMcS8tmzmQA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: -2agoE7T17ioDZLcCJJ8noQPigcJZpr3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_01,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 mlxscore=0 bulkscore=0 adultscore=0
 suspectscore=0 phishscore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506170029

If a regulatory notification is there in the system while the hardware is
being registered, it attempts to set the new regulatory country. However,
ath12k currently boots with a default country derived from the BDF. If this
default country differs from the one provided in the notification, a race
condition can occur while updating the regulatory information back to
userspace. This potentially leads to driver having the incorrect regulatory
applied.

For example, suppose the regulatory domain for France (FR) is already
applied, and then the driver is loaded with a BDF that has the United
States (US) country programmed. When the driver finishes loading, the
regulatory domain shown in phyX still reflects the US regulatory settings.
This is incorrect, as the driver had already received a notification for
FR during hardware registration, but failed to process it properly due to
the race condition.

The race condition exists during driver initialization and hardware
registration:
- On driver load, the firmware sends BDF-based country regulatory rules,
  which are stored in default_regd via ath12k_reg_handle_chan_list().

- During hardware registration, a regulatory notification is triggered
  through:
    ath12k_mac_hw_register()
      -> ieee80211_register_hw()
        -> wiphy_register()
          -> wiphy_regulatory_register()
            -> reg_call_notifier()

  This sends a country code to the firmware, which responds with updated
  regulatory rules.

- After registration, ath12k_mac_hw_register() calls ath12k_regd_update(),
  which copies default_regd and passes it to the upper layers.

The race occurs between the firmware's response and the execution of
ath12k_regd_update(). If the firmware's new rules are processed before the
update call, the correct values are used. Otherwise, outdated boot-time
country settings are exposed to userspace.

To resolve this issue, introduce a completion mechanism within the hardware
group (ah). Trigger this completion whenever a regulatory change is
requested from the firmware. Then, in ath12k_regd_update(), wait for the
firmware to complete its regulatory processing before proceeding with the
update.

This ensures that during driver load, the default country is processed
first. However, before ath12k_regd_update() is called, the new regulatory
notification will have already been received by the driver. As a result, it
will wait for the firmware's regulatory processing to complete, and only
the final, correct regulatory domain will be updated to userspace.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
---
Changes in v2:
- Fixed uninitialed variable usage warnings (detected by clang)
---
 drivers/net/wireless/ath/ath12k/core.c |  4 ++++
 drivers/net/wireless/ath/ath12k/core.h |  1 +
 drivers/net/wireless/ath/ath12k/mac.c  | 15 +++++++++++++++
 drivers/net/wireless/ath/ath12k/reg.c  | 12 ++++++++++++
 drivers/net/wireless/ath/ath12k/reg.h  |  2 ++
 drivers/net/wireless/ath/ath12k/wmi.c  | 17 +++++++++++++++--
 6 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index ebc0560d40e3419130e4caf01c9b91bd9affb3bd..9c18a706dc3ae3b8c5b95d8575e778c8a9c898ba 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1470,6 +1470,7 @@ static void ath12k_core_pre_reconfigure_recovery(struct ath12k_base *ab)
 			complete(&ar->vdev_setup_done);
 			complete(&ar->vdev_delete_done);
 			complete(&ar->bss_survey_done);
+			complete(&ar->regd_update_completed);
 
 			wake_up(&ar->dp.tx_empty_waitq);
 			idr_for_each(&ar->txmgmt_idr,
@@ -1509,6 +1510,9 @@ static void ath12k_update_11d(struct work_struct *work)
 		ar = pdev->ar;
 
 		memcpy(&ar->alpha2, &arg.alpha2, 2);
+
+		reinit_completion(&ar->regd_update_completed);
+
 		ret = ath12k_wmi_send_set_current_country_cmd(ar, &arg);
 		if (ret)
 			ath12k_warn(ar->ab,
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 941db6e49d6eaeb03783f7714d433259d887820b..329f3e490a713b179413f73a4024448aedc363fd 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -804,6 +804,7 @@ struct ath12k {
 	enum ath12k_11d_state state_11d;
 	u8 alpha2[REG_ALPHA2_LEN];
 	bool regdom_set_by_user;
+	struct completion regd_update_completed;
 
 	struct completion fw_stats_complete;
 
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 88b59f3ff87af8b48cb3fafcd364fd9ced4ff197..ef2e8398cbe8723c020aff03da5db7fa7fb2245e 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -10900,6 +10900,7 @@ ath12k_mac_op_reconfig_complete(struct ieee80211_hw *hw,
 			struct wmi_set_current_country_arg arg = {};
 
 			memcpy(&arg.alpha2, ar->alpha2, 2);
+			reinit_completion(&ar->regd_update_completed);
 			ath12k_wmi_send_set_current_country_cmd(ar, &arg);
 		}
 
@@ -12116,6 +12117,16 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
 		goto err_cleanup_if_combs;
 	}
 
+	/* Boot-time regulatory updates have already been processed.
+	 * Mark them as complete now, because after registration,
+	 * cfg80211 will notify us again if there are any pending hints.
+	 * We need to wait for those hints to be processed, so it's
+	 * important to mark the boot-time updates as complete before
+	 * proceeding with registration.
+	 */
+	for_each_ar(ah, ar, i)
+		complete(&ar->regd_update_completed);
+
 	ret = ieee80211_register_hw(hw);
 	if (ret) {
 		ath12k_err(ab, "ieee80211 registration failed: %d\n", ret);
@@ -12143,6 +12154,9 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
 
 			memcpy(&current_cc.alpha2, ab->new_alpha2, 2);
 			memcpy(&ar->alpha2, ab->new_alpha2, 2);
+
+			reinit_completion(&ar->regd_update_completed);
+
 			ret = ath12k_wmi_send_set_current_country_cmd(ar, &current_cc);
 			if (ret)
 				ath12k_warn(ar->ab,
@@ -12215,6 +12229,7 @@ static void ath12k_mac_setup(struct ath12k *ar)
 	init_completion(&ar->scan.on_channel);
 	init_completion(&ar->mlo_setup_done);
 	init_completion(&ar->completed_11d_scan);
+	init_completion(&ar->regd_update_completed);
 
 	INIT_DELAYED_WORK(&ar->scan.timeout, ath12k_scan_timeout_work);
 	wiphy_work_init(&ar->scan.vdev_clean_wk, ath12k_scan_vdev_clean_work);
diff --git a/drivers/net/wireless/ath/ath12k/reg.c b/drivers/net/wireless/ath/ath12k/reg.c
index 2598b39d5d7ee9b24ad8ed5d6de1bc5bbc6554e0..079dcb6d83df4eb487fb0dbf4088fb8cacca8f6e 100644
--- a/drivers/net/wireless/ath/ath12k/reg.c
+++ b/drivers/net/wireless/ath/ath12k/reg.c
@@ -102,6 +102,8 @@ ath12k_reg_notifier(struct wiphy *wiphy, struct regulatory_request *request)
 
 	/* Send the reg change request to all the radios */
 	for_each_ar(ah, ar, i) {
+		reinit_completion(&ar->regd_update_completed);
+
 		if (ar->ab->hw_params->current_cc_support) {
 			memcpy(&current_arg.alpha2, request->alpha2, 2);
 			memcpy(&ar->alpha2, &current_arg.alpha2, 2);
@@ -272,9 +274,19 @@ int ath12k_regd_update(struct ath12k *ar, bool init)
 	struct ieee80211_regdomain *regd, *regd_copy = NULL;
 	int ret, regd_len, pdev_id;
 	struct ath12k_base *ab;
+	long time_left;
 
 	ab = ar->ab;
 
+	time_left = wait_for_completion_timeout(&ar->regd_update_completed,
+						ATH12K_REG_UPDATE_TIMEOUT_HZ);
+	if (time_left == 0) {
+		ath12k_warn(ab, "Timeout while waiting for regulatory update");
+		/* Even though timeout has occurred, still continue since at least boot
+		 * time data would be there to process
+		 */
+	}
+
 	supported_bands = ar->pdev->cap.supported_bands;
 	reg_cap = &ab->hal_reg_cap[ar->pdev_idx];
 
diff --git a/drivers/net/wireless/ath/ath12k/reg.h b/drivers/net/wireless/ath/ath12k/reg.h
index 8af8e9ba462e90db3eb137885d0acd4b1cb2286e..fb508302c7f0f1fea2588ad4cf9d813da574d06b 100644
--- a/drivers/net/wireless/ath/ath12k/reg.h
+++ b/drivers/net/wireless/ath/ath12k/reg.h
@@ -13,6 +13,8 @@
 struct ath12k_base;
 struct ath12k;
 
+#define ATH12K_REG_UPDATE_TIMEOUT_HZ	(3 * HZ)
+
 #define ATH12K_2GHZ_MAX_FREQUENCY	2495
 #define ATH12K_5GHZ_MAX_FREQUENCY	5920
 
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 60e2444fe08cefa39ae218d07eb9736d2a0c982b..db839fc835816c9a2d03d194547af506760f6c81 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -6143,7 +6143,8 @@ static void ath12k_wmi_htc_tx_complete(struct ath12k_base *ab,
 static int ath12k_reg_chan_list_event(struct ath12k_base *ab, struct sk_buff *skb)
 {
 	struct ath12k_reg_info *reg_info;
-	u8 pdev_idx;
+	struct ath12k *ar = NULL;
+	u8 pdev_idx = 255;
 	int ret;
 
 	reg_info = kzalloc(sizeof(*reg_info), GFP_ATOMIC);
@@ -6198,7 +6199,7 @@ static int ath12k_reg_chan_list_event(struct ath12k_base *ab, struct sk_buff *sk
 	kfree(reg_info);
 
 	if (ret == ATH12K_REG_STATUS_VALID)
-		return ret;
+		goto out;
 
 fallback:
 	/* Fallback to older reg (by sending previous country setting
@@ -6212,6 +6213,18 @@ static int ath12k_reg_chan_list_event(struct ath12k_base *ab, struct sk_buff *sk
 	WARN_ON(1);
 
 out:
+	/* In some error cases, even a valid pdev_idx might not be available */
+	if (pdev_idx != 255)
+		ar = ab->pdevs[pdev_idx].ar;
+
+	/* During the boot-time update, 'ar' might not be allocated,
+	 * so the completion cannot be marked at that point.
+	 * This boot-time update is handled in ath12k_mac_hw_register()
+	 * before registering the hardware.
+	 */
+	if (ar)
+		complete(&ar->regd_update_completed);
+
 	return ret;
 }
 

---
base-commit: 7fb79ce2693c94f8f74bf62ad25a97e4b61721b8
change-id: 20250522-handle_user_regd_update_hints_during_insmod-42c71ee7f386


