Return-Path: <linux-wireless+bounces-24078-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F39AD78D1
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 19:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31953188A4F7
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 17:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B830E248F50;
	Thu, 12 Jun 2025 17:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nC62XfK9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6BE29C33D
	for <linux-wireless@vger.kernel.org>; Thu, 12 Jun 2025 17:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749748737; cv=none; b=uGUY96trzN74SAta74LsiWplVup7cYuxMBoy/gxXPbUiGaM1ntN64ugKTAhrf2yTL+Z/R2ITTuvfywPLxggdhE5uNgk1mkjYDDFUwGcUMqgvvt7azRgvLYRp8Wrpdu50wCmzqyLf4K2GcAAgdsMol95OFSyt4IDN35P1lkgjMJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749748737; c=relaxed/simple;
	bh=cn88p5R3Fk3fbeYuWcR19hLDcM8Ds/dn8XfTcbw4Hfg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=E4FWVFiObaoVxaoYfF6b06530+pyyNxsda3y2WRpa1DL+D879lRCYKlgVjN2HVmtJheO3jYkgIEpOGsyGZ/RnnZ8S5iFTaHuyPEWDdh/KfZ4q2ni8XsvG9xotYhxLP1Y+bwaC5pKE6hAZF7HEL2TDFAEeuBd0c0oiobGMMZQfdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nC62XfK9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55CGOlqO013543
	for <linux-wireless@vger.kernel.org>; Thu, 12 Jun 2025 17:18:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=FAfd/466aJtk26pdkcE23i
	lUVjqGoKW+Tnh2zkx2NW4=; b=nC62XfK9UZzFHDI4g+xpU2QOqAXn6b+A7Prl/w
	YXxKtazHEVz3vLsP4Xars2nfNDMAVmBlYl8mCfFr4WzH8vJ+n2Jo/QhK9ubT4cDy
	CSsTOEjMXIn4d8npkbKCXxqxhzwomRigFgdKvCevJsmUOVaKrypvBmzSEjlvmvdd
	W9Fi9OJe8MQEiP9baIGvJt5umZd3AztiO5NW6dMTpov1xTr8pDVxQ03pGdWKIG6A
	0eDP7jYdfNzLpfGeB/aaoUuy1khB3PBoZFNzCoHiVe12C1sbRih/XdNbo/na6rtH
	cvCe+iiDsV5XjtHZdgnALjA7//bwmj610dSumU89utDFw5dg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 476fmngxqe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 12 Jun 2025 17:18:54 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b2c36951518so1202202a12.2
        for <linux-wireless@vger.kernel.org>; Thu, 12 Jun 2025 10:18:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749748727; x=1750353527;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FAfd/466aJtk26pdkcE23ilUVjqGoKW+Tnh2zkx2NW4=;
        b=IkDsPG8YoZ6r8RUi2TS6oiYA2nDoX4RhVXbCAfqHyWY6VfiRKeyl+kDQOQqh4zpFw+
         88X2TADVe2vAH/8Yia7dA7A9HOevqbWX2AJT5vp/eUmOm39X5opBtQuuGl3+2tM3v+Le
         6sQDGvTKxFQIYDuOBHOH0Y7E8oEdBP03C9YaJjB51TSF/g5Xnc0GavfpInjAWJ38+4KP
         Hukgfdd+U6T4IxIIUdUI+js7O4exvwi7E4n/ZVSpTMBX/Bu5qZDFpnBiBJ3ppcbjOdMA
         9gG5q4rLv/Ul+mPMx6S0CB2zUJ451O6R7rVXs/j7xG1ycVuTRN9k35XV5CIYpWQJk02I
         8FZA==
X-Gm-Message-State: AOJu0YyW3Vwnm1JYmpgck1TJW721RGClZuUiF8ZzS46jET31DmtuAegW
	0eugp4RX3JONSIvuJzua5IeKzpdEbg3bmJ6FWX8fEtucBgE3wPLYZUW/2Q6h+Aeg+vrhp43pAr1
	eo1UFZjBoehaXAGwx3uFyDG6Gn2Y5eHGCdEe3hsAfDFXP42h+/dDB/Hf2ubZ9KiFyDvx32Yn82T
	eiEg==
X-Gm-Gg: ASbGnctNcZ9VYq3mnYnl/M9URXmYCU4lIHLN+bVmViQHjFQdu2f8u64gkMpa/Wji3IU
	94KhGYy1ytxzrbvIbryvQFAgfZNH4DIIQghQhY3sTHUDW5pNkusW4vFmkLEAyHrG3ovP1KDQ0H4
	vcRSrEhTsQdgYSTIOkzY3Is6BI3XUcFCYHKmMlY+Nsm0GG/aPfEvqXeN67P7j01Med4aBKic6pu
	POLj9fUZhEOdKNB2SpI/lRx29g0g1oDmRvhtmxnL++55V0IrRuJhhZO5syex2bZJujnm1f7Jgng
	1GNhkZYWgUuXk04QIxGCR3tYTPgzsrqpvSZLP8kHUK/AhkGYqUcS4FGYn2dY4GNijm3Kwhb4TRC
	YlLXwh2KzyXj1k+BsAh0bEQaFS2drC4qw4pzdHPWjXLIUygA=
X-Received: by 2002:a17:902:d489:b0:234:a992:96d8 with SMTP id d9443c01a7336-23641abe52fmr121980195ad.19.1749748727219;
        Thu, 12 Jun 2025 10:18:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEb3hmyzcuYh62ytDN+Gfk1knVYsAAA29UVORbZv5+sAlmWUmsH84jXYEFz2PZxZTBqay4zGA==
X-Received: by 2002:a17:902:d489:b0:234:a992:96d8 with SMTP id d9443c01a7336-23641abe52fmr121979685ad.19.1749748726701;
        Thu, 12 Jun 2025 10:18:46 -0700 (PDT)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fd629375fsm1411495a12.45.2025.06.12.10.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 10:18:46 -0700 (PDT)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Date: Thu, 12 Jun 2025 22:48:20 +0530
Subject: [PATCH ath-next] wifi: ath12k: handle regulatory hints during mac
 registration
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250612-handle_user_regd_update_hints_during_insmod-v1-1-576bd0f6dbe0@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIANsLS2gC/6XPwW7DIAwA0F+pOI8qkFBIT/uPqkIoNomlBjogU
 acq/z6Wyy7bYdvFkm3Zz36yjIkws/PhyRKulCmGmoiXAxsmF0bkBDVnspGqUVLyWoQb2qXO2YQ
 j2OUOrqCdKJRsYUkURkshzxF4JwctELVvzYnVjfeEnh67dmGuTDzgo7Br7UyUS0zv+xmr2Pt/E
 lfBBTfOOwOq1aZ3rzHn49vibkOc52MNO7fKfxCyEh2YzjdeNdrrH4j2izgJ8Tui/fyi70HhgOB
 7/w2xbdsH8kOorb0BAAA=
X-Change-ID: 20250522-handle_user_regd_update_hints_during_insmod-42c71ee7f386
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: wMHGDQqowXMNPLLayfT1fhzPgI5nI3Tq
X-Proofpoint-GUID: wMHGDQqowXMNPLLayfT1fhzPgI5nI3Tq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDEzMyBTYWx0ZWRfX8KN0zv0HiZkM
 9PU1Cuna/pH8ePhKZ6xkyeXWbDKYYlKh9uFORBXXOvWrl7NWffk9Fw+wv8PhARClRPtvnLQdtQp
 lj+p6VSET7/3noKcTqeHSyLPP/d2gW4V9EVUYFz7fmYq1ldf+crWMy88N747L/61vTkGKTvLzct
 I/9Fu/jT8MCM6T/z2PrTPuf6swC22hBZPyUgeTr8+F0RIAA6sNM561AZ7s9uHrwrT3pO3pVhCRc
 OUvnnEHmfpfG098A2W3+ZysZ/ZuzEr3TwV/XJIo2xlwVE0sOov1UQGSd4ydNYB//xzXUh78P4td
 nhvk0ZPxlMkKmoVfe6e5I6Jqc1qwlnHhqcWbG3wZL5voHuhxJdMMSP21zmZi+lFLbh2G3VNhJWQ
 Y78rqYTdq6Zq7v9ftPKV4O8tK6gkk9WCzQb6QfFNMomGp/Sq45FNxDPYsmLk1+e46L1pfk8b
X-Authority-Analysis: v=2.4 cv=K8wiHzWI c=1 sm=1 tr=0 ts=684b0bfe cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=cjyl3gcxlCMcS8tmzmQA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_10,2025-06-12_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506120133

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
 drivers/net/wireless/ath/ath12k/core.c |  4 ++++
 drivers/net/wireless/ath/ath12k/core.h |  1 +
 drivers/net/wireless/ath/ath12k/mac.c  | 15 +++++++++++++++
 drivers/net/wireless/ath/ath12k/reg.c  | 12 ++++++++++++
 drivers/net/wireless/ath/ath12k/reg.h  |  2 ++
 drivers/net/wireless/ath/ath12k/wmi.c  | 13 ++++++++++++-
 6 files changed, 46 insertions(+), 1 deletion(-)

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
index 60e2444fe08cefa39ae218d07eb9736d2a0c982b..047d7a0f0e7423759f7cf05dff4aafbd3b9697d7 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -6143,6 +6143,7 @@ static void ath12k_wmi_htc_tx_complete(struct ath12k_base *ab,
 static int ath12k_reg_chan_list_event(struct ath12k_base *ab, struct sk_buff *skb)
 {
 	struct ath12k_reg_info *reg_info;
+	struct ath12k *ar;
 	u8 pdev_idx;
 	int ret;
 
@@ -6198,7 +6199,7 @@ static int ath12k_reg_chan_list_event(struct ath12k_base *ab, struct sk_buff *sk
 	kfree(reg_info);
 
 	if (ret == ATH12K_REG_STATUS_VALID)
-		return ret;
+		goto out;
 
 fallback:
 	/* Fallback to older reg (by sending previous country setting
@@ -6212,6 +6213,16 @@ static int ath12k_reg_chan_list_event(struct ath12k_base *ab, struct sk_buff *sk
 	WARN_ON(1);
 
 out:
+	ar = ab->pdevs[pdev_idx].ar;
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
base-commit: 8270f43193a0d097659eca55e701fd6818708945
change-id: 20250522-handle_user_regd_update_hints_during_insmod-42c71ee7f386


