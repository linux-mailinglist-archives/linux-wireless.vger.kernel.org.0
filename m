Return-Path: <linux-wireless+bounces-35915-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHPkClkC+mmBHQMAu9opvQ
	(envelope-from <linux-wireless+bounces-35915-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 16:44:41 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FB34CFA7F
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 16:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E40F6306FE63
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2026 14:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5471718DF80;
	Tue,  5 May 2026 14:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dAT7va2v";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aGRIG+iE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3368A38BF7A
	for <linux-wireless@vger.kernel.org>; Tue,  5 May 2026 14:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777991952; cv=none; b=Bu0oVyUvSGpub3vbL410hdFelZcrzA3EX+3PS3i8o6fRX2psxDz9BpWP/Sfj507yhhDbpf7dxPXRg9nfZhYpg30wPUIftFOJRh3+wUeSrLT17E+2pkg3ffdvBAC8OSXGPM6RspC5FoScIapoirHjX6jNSb0UL+VLZZal+kZP5ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777991952; c=relaxed/simple;
	bh=n5KAxwuAAIFBzWl8OWnFiZxCa0t04WOvyfMSV/OEQSU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B4MsWuaVHcOLorPLgcWjyGNUSLVUH3+Gsbrovno8mcFEGadbbsC9a5us2heugm0j9fUfHe7q0EeXCa3UQ0jCEFzXDRmaxRZ/5sqGIh2m8FboJHQRT5r7jv8XbGLukDx6XXblLxMXaCD5vhGrnDIIXEAy4oZCQHx9X759ZuthEDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dAT7va2v; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aGRIG+iE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645E8ngH1186704
	for <linux-wireless@vger.kernel.org>; Tue, 5 May 2026 14:39:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ro8ERA5P37W
	EF8I1lF4QK5tdTa9qlJ6LpJxSuVe+7WU=; b=dAT7va2v/G8haufH6Rr4FotMCOS
	aJIcfzvEWoPjLx1koCTFuTrkuJoun6vou1YcDRT8n4SBCfjpHt7eRbzgQVEw73nL
	aKU1gsNPz8jPmahiTrEE7k0J7Ksbe8EBO+ZIqzX7pDg69o7Ung9yYuP8pS7mvoHO
	QxPrB8AzgLpyHlJRzpwLVCd2p1LF85nOX3Z81o5EaKomXfTM16wPnZVCa1OA5BRc
	wRunvyaKWys/8KCCC15ERTh/XWYxXLPfMvD5BDY9SFhOFnRwQBvSFTaFl0QZE3ll
	WYHrxI1qN0W5aWfkeywknBplqBMRC+wWWZ2AgEUxc1ygLOozTBtqNl6GiVw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxvvgcugb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 05 May 2026 14:39:08 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-354c44bf176so5698246a91.0
        for <linux-wireless@vger.kernel.org>; Tue, 05 May 2026 07:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777991948; x=1778596748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ro8ERA5P37WEF8I1lF4QK5tdTa9qlJ6LpJxSuVe+7WU=;
        b=aGRIG+iEZzvLZkNPT+MQpAxL76C/75Ys/2tE1PakNHEMcwXNoH+FCIPN1S0aZw1Hys
         nmgT2Kkr4QMapdyFycvjLvOmO7JW0XJB+sy8wOq8SZx/CpRTgUTNs9x0G99U5usoq5/1
         xAsFLnGAPK3FgTTEVtI/BX3OFIv0SFf75VuIdrAlLJMmnJYH/r3iUTWYrxxfO20b48PR
         dLmWCureSMMyUNOp8d+mEJuFbCjqasbpKD3+hkmIGkdLsOpYlitUEars6S/bKOpLl4zx
         lnclcUg03CCqi9/+wj50EDYbEtoGGZ/9HOsLqGgtCSy0U/J96kj+kNvmijaoa7dZuGqg
         WWOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777991948; x=1778596748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ro8ERA5P37WEF8I1lF4QK5tdTa9qlJ6LpJxSuVe+7WU=;
        b=MINhRQVQ2nNDo8zxkid6hHK/Ev7wKAEgIU3dq1FcE1Uxk3txVFmhYIPunVo3FpTB11
         TzR4j0OS+Ad6/N8q6cS8RR0uwgta9qXG/rS+ueXkS8dhdBHqp2ouac7wR38t6Ryq4Ns+
         zDrJdTf8OGPVOM0JNKMOj7GtB2Y/m86G3PVzGTdI1hzsWsh8lBO9KH9ZyliD+vC+g/hd
         UIOpFdxwmidlf7j/fP0nrIpjWEWOoW2u0qzFw1nVrnkqflmbUN76JFsOQKsoyfNSFbYo
         bw4jnVZ1w3EZCfeO/RGiYDADdQ1wotjFT0e5MAnBoJc1cx+a/WOqUYyLaI8GmFzTFm7Y
         pUzQ==
X-Gm-Message-State: AOJu0Yxxc5OFLHfmj57O0l830+fl4DfbxbGIk9HMAxuS4WD+zxZXinME
	MAqauw6K345nKWSGN9UAdJG01Rb6PBDIV9oU5AQr+x5zH8yyT4zkjflPwI3bMuhNtsspFKIzK8B
	vCrFeTJNezxK406nb5Rvl/VSCrh00Cukw1vAaz2wDjsFK0ELB925i7rlUaWrjdFqGv1SWsMUxdn
	TnUQ==
X-Gm-Gg: AeBDievJXDlo269QnlmG2M0CmAqaKdSQ6dKS/Q9lqKaARRAlkK9JXdlMSVDFePSGP1s
	2livzc7X7TDD7oGh7X0E7k6L7hzlq8JYrOhZMtnuluVQSa+juG+xzwNHRP3lDJ5mY3z/y6eFEuJ
	AfMHk2cadhyVw13omMDslXvGt3vW+LgyzgkIcS9a7ZVi79zm9GEgGixawuNcTBjWgcFTG7KxBP8
	AvBUM/FSNgpZQK3lBQz8ez3ba5oQJrjxnMohLV7xEeqjJNYtG5UrX6S29QNR/tdKIuU1Nd/8fOe
	ODpG+Sp682uinFnbc9f37+VQOro3cjd/DXcGgqxVVcOQUcyx8SMslErAa5rOrJTsbzqHUFkyk+h
	WAY88bxho68RPpq1P+6ce1wummj3d//y1BEy8iPY0TBjol4QT6ej/4enrLAc6ZaJSTK3RggeFZb
	uW6fny4ewzB7mo7tX1H4w1vQTBXRS74Qy/f+MX9NiA2PHMnA==
X-Received: by 2002:a17:90a:c88b:b0:35f:b69d:7292 with SMTP id 98e67ed59e1d1-3657747c1f3mr3314522a91.15.1777991947425;
        Tue, 05 May 2026 07:39:07 -0700 (PDT)
X-Received: by 2002:a17:90a:c88b:b0:35f:b69d:7292 with SMTP id 98e67ed59e1d1-3657747c1f3mr3314484a91.15.1777991946783;
        Tue, 05 May 2026 07:39:06 -0700 (PDT)
Received: from hu-amitajit-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36578259e7fsm2831030a91.2.2026.05.05.07.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 07:39:05 -0700 (PDT)
From: Amith A <amith.a@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, amith.a@oss.qualcomm.com,
        Aishwarya R <aishwarya.r@oss.qualcomm.com>,
        Hari Chandrakanthan <quic_haric@quicinc.com>
Subject: [PATCH ath-next 1/2] wifi: ath12k: Add support for handling incumbent signal interference in 6 GHz
Date: Tue,  5 May 2026 20:08:52 +0530
Message-Id: <20260505143853.295368-2-amith.a@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260505143853.295368-1-amith.a@oss.qualcomm.com>
References: <20260505143853.295368-1-amith.a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: zGRMBm4dy4wdstm2FHCErsAAAlfwyOOL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDE0MCBTYWx0ZWRfXybpZBhShbgp4
 6L0l+96xhYp/23aHNxn2d4VdkFv3yVL5gcBkVH9K3+7rIk04CpnMM0pXlRMPQrSzH45JdISRpKg
 wnsnTz+DDQAw70o9TEfMNC4Dkb0iFyjCIuZQeAsQhFECazKkNTqbL/DiADAtRdnsgpPdxwwoUwn
 4tnJChLqQ3sGwiFL3xiKQp7PR0gzJkaisZlagNPa2PWjzt6V8fXeYPYIKPuXxBaVwoAQAXYdO05
 MoguKj98nRal+aUgMfi4shr3oj9PikHRhxYNRPcuAQorIjYqQ8FvkJfEwllsfuKjrKx2b9vidWW
 wh4snfvvrTSZ1A2RTbuuPFA+7X+/iyK18UVHV1AEpKe1/BU82WE958vHc5078Cl+ZQo7OG2KGjh
 bIqEAQ7TUrGastuI37PgFmPTEl1W1kHp8zaFHnSa8MhKM5q0ayMFf+gyqDOn54ivmue745CJr0w
 yprH2gdmaZfFEuq+jng==
X-Authority-Analysis: v=2.4 cv=K+AS2SWI c=1 sm=1 tr=0 ts=69fa010d cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=jAPGQAQIC87bCrM3vxMA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: zGRMBm4dy4wdstm2FHCErsAAAlfwyOOL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605050140
X-Rspamd-Queue-Id: 98FB34CFA7F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35915-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,arg.ar:url,quicinc.com:email];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amith.a@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]

From: Aishwarya R <aishwarya.r@oss.qualcomm.com>

When incumbent signal interference is detected by an AP/mesh interface
operating in the 6 GHz band, as mandated by the FCC, it is expected to
vacate the affected channels. The firmware indicates the interference to
the host using the WMI_DCS_INTERFERENCE_EVENT.

To handle the new WMI event, first parse it to retrieve the interference
information. Next, validate the interference-detected channel and
the interference bitmap. The interference bitmap received from the
firmware uses a mapping where bit 0 corresponds to the primary
20 MHz segment, regardless of its position within the operating
bandwidth. Bit 1 represents the next adjacent 20 MHz segment, bit 2
the lower 20 MHz segment of the adjacent 40 MHz segment, and so
on, progressing sequentially across the bandwidth. However, for userspace
consumption via mac80211, this bitmap must be transformed into a
standardized format such that each bit position directly maps to the
corresponding sub-channel index within the operating bandwidth.
Finally, indicate the transformed interference bitmap to mac80211, which
then notifies userspace of the interference. Once the incumbent signal
interference is detected, firmware suspends TX internally on the affected
operating channel while userspace decides the mitigation action. Userspace
is expected to trigger a channel switch or bandwidth reduction to mitigate
the interference. Also, add a flag handling_in_progress to indicate that
handling of interference is in progress. Set it to true after
indicating to mac80211 about the interference. Reset the flag to false
after the operating channel is switched by userspace. This prevents
processing any further interference events when there is already a
previous event being handled. Hence, further events are processed only
after a channel switch request is received from userspace for the
previous event.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.5-01651-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aishwarya R <aishwarya.r@oss.qualcomm.com>
Co-developed-by: Hari Chandrakanthan <quic_haric@quicinc.com>
Signed-off-by: Hari Chandrakanthan <quic_haric@quicinc.com>
Signed-off-by: Amith A <amith.a@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/core.h |   8 +
 drivers/net/wireless/ath/ath12k/mac.c  |  46 +++
 drivers/net/wireless/ath/ath12k/wmi.c  | 382 +++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h  |  58 +++-
 4 files changed, 493 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 8be435535a4e..3aa25db9264e 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -763,6 +763,14 @@ struct ath12k {
 	struct ath12k_pdev_rssi_offsets rssi_info;
 
 	struct ath12k_thermal thermal;
+
+	/* Protected by ar->data_lock */
+	struct ath12k_incumbent_signal_interference {
+		u32 center_freq;
+		enum nl80211_chan_width width;
+		u32 chan_bw_interference_bitmap;
+		bool handling_in_progress;
+	} incumbent_signal_interference;
 };
 
 struct ath12k_hw {
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 9ce759626f18..75881fccd175 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -9637,6 +9637,10 @@ static int ath12k_mac_start(struct ath12k *ar)
 	ar->allocated_vdev_map = 0;
 	ar->chan_tx_pwr = ATH12K_PDEV_TX_POWER_INVALID;
 
+	spin_lock_bh(&ar->data_lock);
+	ar->incumbent_signal_interference.handling_in_progress = false;
+	spin_unlock_bh(&ar->data_lock);
+
 	/* Configure monitor status ring with default rx_filter to get rx status
 	 * such as rssi, rx_duration.
 	 */
@@ -9850,6 +9854,10 @@ static void ath12k_mac_stop(struct ath12k *ar)
 	synchronize_rcu();
 
 	atomic_set(&ar->num_pending_mgmt_tx, 0);
+
+	spin_lock_bh(&ar->data_lock);
+	ar->incumbent_signal_interference.handling_in_progress = false;
+	spin_unlock_bh(&ar->data_lock);
 }
 
 void ath12k_mac_op_stop(struct ieee80211_hw *hw, bool suspend)
@@ -11436,8 +11444,10 @@ ath12k_mac_update_vif_chan(struct ath12k *ar,
 			   struct ieee80211_vif_chanctx_switch *vifs,
 			   int n_vifs)
 {
+	struct ath12k_incumbent_signal_interference *incumbent;
 	struct ath12k_wmi_vdev_up_params params = {};
 	struct ieee80211_bss_conf *link_conf;
+	struct cfg80211_chan_def *chandef;
 	struct ath12k_base *ab = ar->ab;
 	struct ath12k_link_vif *arvif;
 	struct ieee80211_vif *vif;
@@ -11549,6 +11559,42 @@ ath12k_mac_update_vif_chan(struct ath12k *ar,
 		if (!ath12k_mac_monitor_stop(ar))
 			ath12k_mac_monitor_start(ar);
 	}
+
+	incumbent = &ar->incumbent_signal_interference;
+	spin_lock_bh(&ar->data_lock);
+	if (incumbent->handling_in_progress) {
+		chandef = &vifs[0].new_ctx->def;
+		if (incumbent->chan_bw_interference_bitmap &
+		    ATH12K_WMI_DCS_SEG_PRI20) {
+			if (incumbent->center_freq !=
+			    chandef->chan->center_freq) {
+				incumbent->chan_bw_interference_bitmap = 0;
+				incumbent->handling_in_progress = false;
+				ath12k_dbg(ab, ATH12K_DBG_MAC,
+					   "incumbent signal interference chan switch completed\n");
+			} else {
+				ath12k_warn(ab,
+					    "incumbent signal interference chan switch not done, freq %u\n",
+					    incumbent->center_freq);
+			}
+		} else {
+			if (incumbent->center_freq !=
+			    chandef->chan->center_freq ||
+			    incumbent->width != chandef->width) {
+				incumbent->chan_bw_interference_bitmap = 0;
+				incumbent->handling_in_progress = false;
+				ath12k_dbg(ab, ATH12K_DBG_MAC,
+					   "Bandwidth/channel change due to incumbent signal interference completed\n");
+			} else {
+				ath12k_warn(ab, "Bandwidth/channel change due to incumbent sig intf not done intf_freq %u chan_freq %u intf_width %u chan_width %u\n",
+					    incumbent->center_freq,
+					    chandef->chan->center_freq,
+					    incumbent->width,
+					    chandef->width);
+			}
+		}
+	}
+	spin_unlock_bh(&ar->data_lock);
 }
 
 static void
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index c7559938564c..b9e107cfd869 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -234,6 +234,68 @@ static const int ath12k_hw_mode_pri_map[] = {
 	PRIMAP(WMI_HOST_HW_MODE_MAX),
 };
 
+/*
+ * Interference bitmap transform maps used by
+ * ath12k_wmi_transform_interference_bitmap().
+ *
+ * Firmware reports bitmap bits in a primary-based order where:
+ * - bit 0 is always the primary 20 MHz segment,
+ * - bit 1 is the adjacent 20 MHz in the same 40 MHz block,
+ * - bit 2 is the lower 20 MHz segment of the adjacent 40 MHz segment
+ * - bit 3 is the higher 20 MHz segment of the adjacent 40 MHz segment
+ * - remaining bits continue outward in 80/160/320 MHz groups.
+ *
+ * cfg80211 userspace notification expects absolute frequency order where:
+ * - bit 0 is the lowest-frequency 20 MHz segment in the current chandef,
+ * - bit N increases monotonically toward higher frequency.
+ *
+ * For each bandwidth-specific map:
+ * - row index    = primary 20 MHz index in absolute (low->high) order,
+ * - column index = source bit position from firmware bitmap,
+ * - value        = destination bit position in absolute order bitmap.
+ *
+ * Example for 80 MHz: if primary index is 2 (third 20 MHz chunk from low
+ * frequency), row intf_map_80[2] = { 2, 3, 0, 1 } means firmware bits {0,1,2,3}
+ * are remapped to destination bits {2,3,0,1} before notifying cfg80211.
+ */
+
+static const int intf_map_80[4][4] = {
+	{ 0, 1, 2, 3 },
+	{ 1, 0, 2, 3 },
+	{ 2, 3, 0, 1 },
+	{ 3, 2, 0, 1 }
+};
+
+static const int intf_map_160[8][8] = {
+	{ 0, 1, 2, 3, 4, 5, 6, 7 },
+	{ 1, 0, 2, 3, 4, 5, 6, 7 },
+	{ 2, 3, 0, 1, 4, 5, 6, 7 },
+	{ 3, 2, 0, 1, 4, 5, 6, 7 },
+	{ 4, 5, 6, 7, 0, 1, 2, 3 },
+	{ 5, 4, 6, 7, 0, 1, 2, 3 },
+	{ 6, 7, 4, 5, 0, 1, 2, 3 },
+	{ 7, 6, 4, 5, 0, 1, 2, 3 }
+};
+
+static const int intf_map_320[16][16] = {
+	{ 0,  1,  2,  3,  4,  5,  6,  7,  8,  9,  10,  11,  12,  13,  14,  15 },
+	{ 1,  0,  2,  3,  4,  5,  6,  7,  8,  9,  10,  11,  12,  13,  14,  15 },
+	{ 2,  3,  0,  1,  4,  5,  6,  7,  8,  9,  10,  11,  12,  13,  14,  15 },
+	{ 3,  2,  0,  1,  4,  5,  6,  7,  8,  9,  10,  11,  12,  13,  14,  15 },
+	{ 4,  5,  6,  7,  0,  1,  2,  3,  8,  9,  10,  11,  12,  13,  14,  15 },
+	{ 5,  4,  6,  7,  0,  1,  2,  3,  8,  9,  10,  11,  12,  13,  14,  15 },
+	{ 6,  7,  4,  5,  0,  1,  2,  3,  8,  9,  10,  11,  12,  13,  14,  15 },
+	{ 7,  6,  4,  5,  0,  1,  2,  3,  8,  9,  10,  11,  12,  13,  14,  15 },
+	{ 8,  9,  10, 11, 12, 13, 14, 15, 0,  1,  2,   3,   4,   5,   6,   7  },
+	{ 9,  8,  10, 11, 12, 13, 14, 15, 0,  1,  2,   3,   4,   5,   6,   7  },
+	{ 10, 11, 8,  9,  12, 13, 14, 15, 0,  1,  2,   3,   4,   5,   6,   7  },
+	{ 11, 10, 8,  9,  12, 13, 14, 15, 0,  1,  2,   3,   4,   5,   6,   7  },
+	{ 12, 13, 14, 15, 8,  9,  10, 11, 0,  1,  2,   3,   4,   5,   6,   7  },
+	{ 13, 12, 14, 15, 8,  9,  10, 11, 0,  1,  2,   3,   4,   5,   6,   7  },
+	{ 14, 15, 12, 13, 8,  9,  10, 11, 0,  1,  2,   3,   4,   5,   6,   7  },
+	{ 15, 14, 12, 13, 8,  9,  10, 11, 0,  1,  2,   3,   4,   5,   6,   7  }
+};
+
 static int
 ath12k_wmi_tlv_iter(struct ath12k_base *ab, const void *ptr, size_t len,
 		    int (*iter)(struct ath12k_base *ab, u16 tag, u16 len,
@@ -8597,6 +8659,323 @@ static void ath12k_pdev_ctl_failsafe_check_event(struct ath12k_base *ab,
 			    ev->ctl_failsafe_status);
 }
 
+static int
+ath12k_wmi_incumbent_signal_interference_subtlv_parser(struct ath12k_base *ab,
+						       u16 tag, u16 len,
+						       const void *ptr,
+						       void *data)
+{
+	const struct ath12k_wmi_incumbent_signal_interference_params *info;
+	struct ath12k_wmi_incumbent_signal_interference_arg *arg = data;
+
+	switch (tag) {
+	case WMI_TAG_DCS_INCUMBENT_SIGNAL_INTERFERENCE_TYPE:
+		info = ptr;
+
+		arg->chan_width = le32_to_cpu(info->chan_width);
+		arg->chan_freq = le32_to_cpu(info->chan_freq);
+		arg->center_freq0 = le32_to_cpu(info->center_freq0);
+		arg->center_freq1 = le32_to_cpu(info->center_freq1);
+		arg->chan_bw_interference_bitmap =
+			le32_to_cpu(info->chan_bw_interference_bitmap);
+
+		ath12k_dbg(ab, ATH12K_DBG_WMI,
+			   "incumbent signal interference chan width %u freq %u center_freq0 %u center_freq1 %u bitmap 0x%x\n",
+			   arg->chan_width, arg->chan_freq,
+			   arg->center_freq0, arg->center_freq1,
+			   arg->chan_bw_interference_bitmap);
+		break;
+	default:
+		ath12k_warn(ab, "Received invalid tag 0x%x for WMI DCS interference in subtlvs\n",
+			    tag);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int ath12k_wmi_dcs_interference_event_parser(struct ath12k_base *ab,
+						    u16 tag, u16 len,
+						    const void *ptr, void *data)
+{
+	int ret = 0;
+
+	switch (tag) {
+	case WMI_TAG_DCS_INTERFERENCE_EVENT:
+		/* Fixed param should already be processed */
+		break;
+	case WMI_TAG_ARRAY_STRUCT:
+		ret = ath12k_wmi_tlv_iter(ab, ptr, len,
+					  ath12k_wmi_incumbent_signal_interference_subtlv_parser,
+					  data);
+		break;
+	default:
+		ath12k_warn(ab, "Received invalid tag 0x%x for WMI DCS interference event\n",
+			    tag);
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static bool
+ath12k_wmi_validate_interference_info(struct ath12k *ar,
+				      struct ath12k_wmi_incumbent_signal_interference_arg *info)
+{
+	switch (info->chan_width) {
+	case WMI_CHAN_WIDTH_20:
+		if (info->chan_bw_interference_bitmap > ATH12K_WMI_DCS_SEG_PRI20) {
+			ath12k_dbg(ar->ab, ATH12K_DBG_WMI,
+				   "DCS interference event received with wrong chan width bmap 0x%x for 20 MHz",
+				   info->chan_bw_interference_bitmap);
+			return false;
+		}
+		break;
+	case WMI_CHAN_WIDTH_40:
+		if (info->chan_bw_interference_bitmap > (ATH12K_WMI_DCS_SEG_PRI20 |
+							 ATH12K_WMI_DCS_SEG_SEC20)) {
+			ath12k_dbg(ar->ab, ATH12K_DBG_WMI,
+				   "DCS interference event received with wrong chan width bmap 0x%x for 40 MHz",
+				   info->chan_bw_interference_bitmap);
+			return false;
+		}
+		break;
+	case WMI_CHAN_WIDTH_80:
+		if (info->chan_bw_interference_bitmap > (ATH12K_WMI_DCS_SEG_PRI20 |
+							 ATH12K_WMI_DCS_SEG_SEC20 |
+							 ATH12K_WMI_DCS_SEG_SEC40)) {
+			ath12k_dbg(ar->ab, ATH12K_DBG_WMI,
+				   "DCS interference event received with wrong chan width bmap 0x%x for 80 MHz",
+				   info->chan_bw_interference_bitmap);
+			return false;
+		}
+		break;
+	case WMI_CHAN_WIDTH_160:
+		if (info->chan_bw_interference_bitmap > (ATH12K_WMI_DCS_SEG_PRI20 |
+							 ATH12K_WMI_DCS_SEG_SEC20 |
+							 ATH12K_WMI_DCS_SEG_SEC40 |
+							 ATH12K_WMI_DCS_SEG_SEC80)) {
+			ath12k_dbg(ar->ab, ATH12K_DBG_WMI,
+				   "DCS interference event received with wrong chan width bmap 0x%x for 160 MHz",
+				   info->chan_bw_interference_bitmap);
+			return false;
+		}
+		break;
+	case WMI_CHAN_WIDTH_320:
+		if (info->chan_bw_interference_bitmap > (ATH12K_WMI_DCS_SEG_PRI20 |
+							 ATH12K_WMI_DCS_SEG_SEC20 |
+							 ATH12K_WMI_DCS_SEG_SEC40 |
+							 ATH12K_WMI_DCS_SEG_SEC80 |
+							 ATH12K_WMI_DCS_SEG_SEC160)) {
+			ath12k_dbg(ar->ab, ATH12K_DBG_WMI,
+				   "DCS interference event received with wrong chan width bmap 0x%x for 320 MHz",
+				   info->chan_bw_interference_bitmap);
+			return false;
+		}
+		break;
+	default:
+		ath12k_dbg(ar->ab, ATH12K_DBG_WMI,
+			   "DCS interference event received with unknown channel width %u",
+			   info->chan_width);
+		return false;
+	}
+	return true;
+}
+
+static u32
+ath12k_wmi_transform_interference_bitmap(int input_bitmap,
+					 struct cfg80211_chan_def *chandef)
+{
+	u16 output_bits[ATH12K_MAX_20MHZ_SEGMENTS] = {};
+	u16 input_bits[ATH12K_MAX_20MHZ_SEGMENTS] = {};
+	u32 start_freq, segment_freq;
+	int primary_index = -1;
+	u32 output_bitmap = 0;
+	u16 num_sub_chans;
+	int bandwidth;
+
+	bandwidth = nl80211_chan_width_to_mhz(chandef->width);
+	if (bandwidth < 0)
+		return 0;
+
+	/*
+	 * Firmware reports bit 0 as primary 20 MHz irrespective of absolute
+	 * frequency position. Convert to standardized lowest-to-highest 20 MHz
+	 * ordering expected by cfg80211/mac80211 userspace consumers.
+	 */
+	num_sub_chans = bandwidth / 20;
+	start_freq = (chandef->center_freq1 - bandwidth / 2) + 10;
+
+	for (int i = 0; i < ATH12K_MAX_20MHZ_SEGMENTS; i++) {
+		segment_freq = start_freq + (i * 20);
+		if (segment_freq == chandef->chan->center_freq) {
+			primary_index = i;
+			break;
+		}
+	}
+	if (primary_index == -1)
+		return 0;
+
+	for (int i = 0; i < ATH12K_MAX_20MHZ_SEGMENTS; ++i)
+		input_bits[i] = BIT(i) & input_bitmap;
+
+	for (int i = 0; i < num_sub_chans; ++i) {
+		int src = i, dst = i;
+
+		switch (bandwidth) {
+		case 40:
+			if (primary_index == 1)
+				dst = 1 - i;
+			break;
+		case 80:
+			dst = intf_map_80[primary_index][i];
+			break;
+		case 160:
+			dst = intf_map_160[primary_index][i];
+			break;
+		case 320:
+			dst = intf_map_320[primary_index][i];
+			break;
+		}
+		output_bits[dst] = input_bits[src];
+	}
+
+	for (int i = 0; i < ATH12K_MAX_20MHZ_SEGMENTS; ++i)
+		output_bitmap |= output_bits[i] ? BIT(i) : 0;
+
+	return output_bitmap;
+}
+
+static void
+ath12k_wmi_process_incumbent_signal_interference_evt(struct ath12k_base *ab,
+						     struct sk_buff *skb,
+						     const struct ath12k_wmi_intf_arg *intf_arg)
+{
+	struct ath12k_wmi_incumbent_signal_interference_arg info = {};
+	struct ath12k_incumbent_signal_interference *incumbent;
+	struct ath12k_mac_get_any_chanctx_conf_arg arg;
+	u32 transformed_intf_bitmap;
+	struct ieee80211_hw *hw;
+	struct ath12k *ar;
+	int ret;
+
+	guard(rcu)();
+
+	ar = ath12k_mac_get_ar_by_pdev_id(ab, intf_arg->pdev_id);
+	if (!ar) {
+		ath12k_warn(ab, "incumbent signal interference detected on invalid pdev %d\n",
+			    intf_arg->pdev_id);
+		return;
+	}
+	if (!ar->supports_6ghz) {
+		ath12k_warn(ab, "pdev does not support 6 GHz, dropping DCS interference event\n");
+		return;
+	}
+
+	incumbent = &ar->incumbent_signal_interference;
+	spin_lock_bh(&ar->data_lock);
+	if (incumbent->handling_in_progress) {
+		spin_unlock_bh(&ar->data_lock);
+		ath12k_dbg(ar->ab, ATH12K_DBG_WMI,
+			   "incumbent signal interference handling ongoing, dropping DCS interference event");
+		return;
+	}
+	spin_unlock_bh(&ar->data_lock);
+
+	ret = ath12k_wmi_tlv_iter(ab, skb->data, skb->len,
+				  ath12k_wmi_dcs_interference_event_parser,
+				  &info);
+	if (ret) {
+		ath12k_warn(ab,
+			    "failed to parse incumbent signal interference TLV. Error %d\n",
+			    ret);
+		return;
+	}
+
+	if (!ath12k_wmi_validate_interference_info(ar, &info)) {
+		ath12k_warn(ab, "invalid DCS incumbent signal interference TLV - Skipping event");
+		return;
+	}
+
+	arg.ar = ar;
+	arg.chanctx_conf = NULL;
+	hw = ath12k_ar_to_hw(ar);
+	ieee80211_iter_chan_contexts_atomic(hw,
+					    ath12k_mac_get_any_chanctx_conf_iter,
+					    &arg);
+	if (!arg.chanctx_conf) {
+		ath12k_warn(ab, "failed to find valid chanctx_conf in incumbent signal intf detected event\n");
+		return;
+	}
+
+	if (info.chan_freq != arg.chanctx_conf->def.chan->center_freq) {
+		ath12k_dbg(ab, ATH12K_DBG_WMI,
+			   "dcs interference event received with wrong channel %d (ctx freq %d)",
+			   info.chan_freq, arg.chanctx_conf->def.chan->center_freq);
+		return;
+	}
+
+	spin_lock_bh(&ar->data_lock);
+	incumbent->center_freq = arg.chanctx_conf->def.chan->center_freq;
+	incumbent->width = arg.chanctx_conf->def.width;
+	incumbent->chan_bw_interference_bitmap = info.chan_bw_interference_bitmap;
+	incumbent->handling_in_progress = true;
+	spin_unlock_bh(&ar->data_lock);
+	transformed_intf_bitmap =
+		ath12k_wmi_transform_interference_bitmap(info.chan_bw_interference_bitmap,
+							 &arg.chanctx_conf->def);
+	ath12k_dbg(ab, ATH12K_DBG_WMI,
+		   "incumbent signal interference bitmap 0x%x (transformed 0x%x)\n",
+		   info.chan_bw_interference_bitmap, transformed_intf_bitmap);
+	cfg80211_incumbent_signal_notify(hw->wiphy,
+					 &arg.chanctx_conf->def,
+					 transformed_intf_bitmap,
+					 GFP_ATOMIC);
+}
+
+static void
+ath12k_wmi_dcs_interference_event(struct ath12k_base *ab,
+				  struct sk_buff *skb)
+{
+	const struct ath12k_wmi_dcs_interference_ev_fixed_params *dcs_intf_ev;
+	struct ath12k_wmi_intf_arg dcs_intf_arg;
+	const struct wmi_tlv *tlv;
+	u16 tlv_tag;
+	u8 *ptr;
+
+	if (skb->len < (sizeof(*dcs_intf_ev) + TLV_HDR_SIZE)) {
+		ath12k_warn(ab, "DCS interference event is of incorrect length\n");
+		return;
+	}
+
+	ptr = skb->data;
+	tlv = (struct wmi_tlv *)ptr;
+	tlv_tag = le32_get_bits(tlv->header, WMI_TLV_TAG);
+	ptr += sizeof(*tlv);
+
+	if (tlv_tag != WMI_TAG_DCS_INTERFERENCE_EVENT) {
+		ath12k_warn(ab, "DCS interference event received with wrong tag\n");
+		return;
+	}
+
+	dcs_intf_ev = (struct ath12k_wmi_dcs_interference_ev_fixed_params *)ptr;
+
+	dcs_intf_arg.interference_type =
+		le32_to_cpu(dcs_intf_ev->interference_type);
+	dcs_intf_arg.pdev_id = le32_to_cpu(dcs_intf_ev->pdev_id);
+
+	if (dcs_intf_arg.interference_type ==
+	    ATH12K_WMI_DCS_INCUMBENT_SIGNAL_INTERFERENCE) {
+		ath12k_dbg(ab, ATH12K_DBG_WMI,
+			   "incumbent signal interference (Type %u) detected on pdev %u.",
+			   dcs_intf_arg.interference_type,
+			   dcs_intf_arg.pdev_id);
+		ath12k_wmi_process_incumbent_signal_interference_evt(ab, skb,
+								     &dcs_intf_arg);
+	}
+}
+
 static void
 ath12k_wmi_process_csa_switch_count_event(struct ath12k_base *ab,
 					  const struct ath12k_wmi_pdev_csa_event *ev,
@@ -9961,6 +10340,9 @@ static void ath12k_wmi_op_rx(struct ath12k_base *ab, struct sk_buff *skb)
 	case WMI_OBSS_COLOR_COLLISION_DETECTION_EVENTID:
 		ath12k_wmi_obss_color_collision_event(ab, skb);
 		break;
+	case WMI_DCS_INTERFERENCE_EVENTID:
+		ath12k_wmi_dcs_interference_event(ab, skb);
+		break;
 	/* add Unsupported events (rare) here */
 	case WMI_TBTTOFFSET_EXT_UPDATE_EVENTID:
 	case WMI_PEER_OPER_MODE_CHANGE_EVENTID:
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index c644604c1426..d74f7fca7678 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -2015,7 +2015,7 @@ enum wmi_tlv_tag {
 	WMI_TAG_VDEV_CH_POWER_INFO,
 	WMI_TAG_MLO_LINK_SET_ACTIVE_CMD = 0x3BE,
 	WMI_TAG_EHT_RATE_SET = 0x3C4,
-	WMI_TAG_DCS_AWGN_INT_TYPE = 0x3C5,
+	WMI_TAG_DCS_INCUMBENT_SIGNAL_INTERFERENCE_TYPE = 0x3C5,
 	WMI_TAG_MLO_TX_SEND_PARAMS,
 	WMI_TAG_MLO_PARTNER_LINK_PARAMS,
 	WMI_TAG_MLO_PARTNER_LINK_PARAMS_PEER_ASSOC,
@@ -4535,6 +4535,62 @@ struct ath12k_wmi_pdev_radar_event {
 	a_sle32 sidx;
 } __packed;
 
+#define ATH12K_WMI_DCS_INCUMBENT_SIGNAL_INTERFERENCE	0x04
+
+struct ath12k_wmi_dcs_interference_ev_fixed_params {
+	__le32 interference_type;
+	__le32 pdev_id;
+} __packed;
+
+struct ath12k_wmi_incumbent_signal_interference_params {
+	__le32 chan_width;
+	__le32 chan_freq;
+	__le32 center_freq0;
+	__le32 center_freq1;
+	__le32 chan_bw_interference_bitmap;
+} __packed;
+
+struct ath12k_wmi_incumbent_signal_interference_arg {
+	u32 chan_width;
+	u32 chan_freq;
+	u32 center_freq0;
+	u32 center_freq1;
+	u32 chan_bw_interference_bitmap;
+};
+
+struct ath12k_wmi_intf_arg {
+	u32 interference_type;
+	u32 pdev_id;
+};
+
+enum ath12k_wmi_dcs_interference_chan_segment {
+	/*
+	 * Firmware reports interference bitmap in primary-based order.
+	 * Bit 0 is the primary 20 MHz, bit 1 is the adjacent 20 MHz within
+	 * the primary 40 MHz. Bits 2-3 cover the secondary 40 MHz, bits 4-7
+	 * cover the secondary 80 MHz, and bits 8-15 cover the secondary 160 MHz.
+	 */
+	ATH12K_WMI_DCS_SEG_PRI20                 = 0x1,
+	ATH12K_WMI_DCS_SEG_SEC20                 = 0x2,
+	ATH12K_WMI_DCS_SEG_SEC40_LOW             = 0x4,
+	ATH12K_WMI_DCS_SEG_SEC40_UP              = 0x8,
+	ATH12K_WMI_DCS_SEG_SEC40                 = 0xC,
+	ATH12K_WMI_DCS_SEG_SEC80_LOW             = 0x10,
+	ATH12K_WMI_DCS_SEG_SEC80_LOW_UP          = 0x20,
+	ATH12K_WMI_DCS_SEG_SEC80_UP_LOW          = 0x40,
+	ATH12K_WMI_DCS_SEG_SEC80_UP              = 0x80,
+	ATH12K_WMI_DCS_SEG_SEC80                 = 0xF0,
+	ATH12K_WMI_DCS_SEG_SEC160_LOW            = 0x0100,
+	ATH12K_WMI_DCS_SEG_SEC160_LOW_UP         = 0x0200,
+	ATH12K_WMI_DCS_SEG_SEC160_LOW_UP_UP      = 0x0400,
+	ATH12K_WMI_DCS_SEG_SEC160_LOW_UP_UP_UP   = 0x0800,
+	ATH12K_WMI_DCS_SEG_SEC160_UP_LOW_LOW_LOW = 0x1000,
+	ATH12K_WMI_DCS_SEG_SEC160_UP_LOW_LOW     = 0x2000,
+	ATH12K_WMI_DCS_SEG_SEC160_UP_LOW         = 0x4000,
+	ATH12K_WMI_DCS_SEG_SEC160_UP             = 0x8000,
+	ATH12K_WMI_DCS_SEG_SEC160                = 0xFF00,
+};
+
 struct wmi_pdev_temperature_event {
 	/* temperature value in Celsius degree */
 	a_sle32 temp;
-- 
2.34.1


