Return-Path: <linux-wireless+bounces-28550-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B06C6C320E6
	for <lists+linux-wireless@lfdr.de>; Tue, 04 Nov 2025 17:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CF7E3AA68F
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Nov 2025 16:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6F4333437;
	Tue,  4 Nov 2025 16:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W+CBeVL9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZZfLYlL6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774083328F1
	for <linux-wireless@vger.kernel.org>; Tue,  4 Nov 2025 16:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762273603; cv=none; b=RuIMHfVkEMl5EnCN37uVe9ap65nPp15yHprbIzo7X/5/qZ9LZCBPoL/ktDw3s5mn/xk1pxuzFQex0WN65w8aQ9Ml9jrzBukGrGN3ABvLufAbUI0yqSVVCqjZu/ploilrcN+O0M5b542BlCN/y3WNHyxy1sihl3hEg8Cf9pa98+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762273603; c=relaxed/simple;
	bh=O0SBU6X8ZNXAhp0bLg8v3zUNUfHYsDrMu8k/vt+hBzI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rx1Nsxk02ce0wbNdm7Y0jas9YCZ86ffrddElPUi5OhQb/IKh5B2mweWWJ9a0img6G+DODCLaFWv6EfkO1bph6fRCOYVNTMogH5Ra017SgPIv/X9koloG3dul/M2T9tm+B8YGlrFmLgeqYH1hFonmD8TmMyuWYcjdiwmRvSrrb0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W+CBeVL9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZZfLYlL6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A4EdqbD2422235
	for <linux-wireless@vger.kernel.org>; Tue, 4 Nov 2025 16:26:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LFrtG1KFdR/sQfiwZyV2ZsLgdioWBtQF2cBCrfJ2vFU=; b=W+CBeVL9IqbQuYWq
	XqWzy9O539/4gDgPHeTfR5abk+fP545qDaC9q1j7ajq77t9rKLglbII1hlpYrm74
	GfT9cV11yu9mzcgrdWJJ82LwbO4VCrF5mn0L8ZJP0cVdfBKSkY2HT7FhF6cJiCKs
	4fnuTBcfg18b9GjysVeKl6dzkl2X2v9OdlIVhVkLsNZ6rz94RxtbX7m9NmApPCeu
	NS8H4bj3rgfWVBoSfH0du+k6jBgv7vL/r4tLelEF23m0VQWKxJm7FqErHXhcGtJJ
	stWTLve4fx9ECh2AphKg9ilpYo38TyhaCWPBgMC9Qn+EivTQ0Mz4xXkc2E4e7Cno
	g1CDLw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7ketgaxy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 04 Nov 2025 16:26:40 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2956a694b47so36880075ad.1
        for <linux-wireless@vger.kernel.org>; Tue, 04 Nov 2025 08:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762273599; x=1762878399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LFrtG1KFdR/sQfiwZyV2ZsLgdioWBtQF2cBCrfJ2vFU=;
        b=ZZfLYlL6FH2v1SakmZp6Lqqh0VXKaZZmQBMcukz590YCEhSYQynYNmVaOsqudqEDfW
         BL1jwSDflVqC8/i03fTvy9aHkxczWq64PW9WeUpFvrX6vp5imF7AZ4vDdU8wvsh/00D6
         CdHSPVTQMfcnbgfznLTmoWo7nxIC0QQLnmPYMqqa1F9bVPTfkTg2kbzOtGkemaJULuJ8
         TuJMytNXoR24TnEJmZ0T+px1R1fy2TaPZ3JO2+YQNCAt6XaffomrgYmQFbGuSjBDlkUl
         2rIlEnCc5YphrG3zrwKzawo3kdGVSW+fofOZScPLNlydjyT0t7c23edWb/5BijXDcbAP
         N9+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762273599; x=1762878399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LFrtG1KFdR/sQfiwZyV2ZsLgdioWBtQF2cBCrfJ2vFU=;
        b=w0YqLlwJHIl36EiOFSXYejWr2JZiYJ2f/leXT6jy2P7kg1qmRdfKpPNbCxbdpKfX3T
         mXaHQi9yTO1p+cHWZC8yJ/ZAJulOvAMSu927lcD+XVrU4jjLGabLXlvIsUprFfRknA2a
         wdQZyslezgJAF0NN71Zoi2XFuIfmgH5lUJbJn1UcJYIsJdr+FOiqz/oDiom8WftwYhbZ
         SbZgyNf9btzvxzPiTAeBCwscZ38aDFi3h7OVjFQ7SFSr3HV7Az5gbDtF8nwJK1DyIBPP
         BOowiDV+zxGuHouFnFJlMPRta6hxQ+X41rc9VdNz2HIQP0xxx5bVY4etFiElkQ/loE+H
         CRWg==
X-Forwarded-Encrypted: i=1; AJvYcCXHJA/U3xoDdVgC/leHw8ghW3o19AtXWSZLMJq3Uyq+BduxoJWJkHk3pm7WV7/mfeIeLVNYFyF7cEojdDG80w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxGheKEZiUThtCbbpAUyhUkSsbXhGQEYF2Z7H90or5/pPW9dlPv
	4/9n2HtJIJA4N1PyAEWqiDxW+S1fe3VMXq8Hdf+IYxHhpZr5LKE8X/qBmip5Y/lPzWy8VCwBX7y
	9hO5GOeXeL6ICGFRB/wbNzUV/9Wi4IJnhYvgfkg9bowFcwO/IywnIvwyyoBk7nOym1iCb6w==
X-Gm-Gg: ASbGncuzIMWErb0o5FuP7CDGnIDtoqmkXQLqIL/bReC6PjiUU1hfZzhweti7aukNVIU
	NASdPMuRzFaw6QH/xQMHB4KvR0JvWfyrdrwTAbysyf0ZEmY3cHflN0XdyJ19XZ66BCoXgISH7cb
	JEZSBHGhXmsUD4TqoErprb29uXQ3WfiCoSNKXywWNsNTrMSNGnSwV6uBIjCvF7BqnstDfL+diuH
	jijrYltLMUzDxBx2jfj071QutMAOhv2aFCezGChloYZgiX/Wnw8no/IQoyrCzLVYn6d1upWbhvQ
	3pSkffJWUdAfP56tBOgW29Kw8rZJXt08ZCiDWJPHzbUx1EYg0p08NhfVFaaHPCX+ewaMNwcyBms
	2TDux89/oaXvBfR4Zmtgqyi0LQKZ3BJDhW279ZIU3aPkh
X-Received: by 2002:a17:903:2f81:b0:28d:18fb:bb93 with SMTP id d9443c01a7336-2962adb409amr2300485ad.7.1762273598729;
        Tue, 04 Nov 2025 08:26:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkpY6qFCLWV8sp54qIOAW7lPlFtTaPOBdgjs5le3oz92PclTleyWaIa7yqI7/ktCot3RePSQ==
X-Received: by 2002:a17:903:2f81:b0:28d:18fb:bb93 with SMTP id d9443c01a7336-2962adb409amr2300035ad.7.1762273598152;
        Tue, 04 Nov 2025 08:26:38 -0800 (PST)
Received: from hu-yuzha-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601a7a8a9sm31508435ad.107.2025.11.04.08.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 08:26:37 -0800 (PST)
From: "Yu Zhang(Yuriy)" <yu.zhang@oss.qualcomm.com>
To: jjohnson@kernel.org
Cc: baochen.qiang@oss.qualcomm.com, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        Yu Zhang <yu.zhang@oss.qualcomm.com>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Subject: [PATCH ath-next v2 3/6] wifi: ath11k: Add support unassociated client CFR
Date: Tue,  4 Nov 2025 08:26:30 -0800
Message-Id: <20251104162633.3007874-4-yu.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104162633.3007874-1-yu.zhang@oss.qualcomm.com>
References: <20251104162633.3007874-1-yu.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDEzNyBTYWx0ZWRfX55xvuktMRWIJ
 a6EYN9sQrB5khMYjUzzzMAt/9UWcU83XOcmHdf6z1dRlB9C7YPJQ051+l+ZQof5f1aBnAXPsxjK
 MD3D1G/Z/hC5KkJFtnrigN7ojywL+tSw/owT5gURO69RkDfUCvuE6kpYpeykOo4Dt9K9BRyLXEM
 tcAj89pQO8GNOKmSVn0yNqCX9xW7GaZT/meTYgcXc7lHTZqB/O94Wr3URP2wBwnkmvs76XS14p6
 JjqY2TxcFy6atwN+RNtUHQeQmMYDRE5ZQ/TWYWLcs3bBSXb55o2jTgAud//8nD5hHyvq3aFr5GO
 kjW/xLVVDgDB9Npcm4o+IobKCqEU0AmzKuG2uUBmqOmYEBh1/B3y0u/gtSSiY6mLQ5ZFqS3UVkq
 SG5dlHXgM3Vu7Xd9/WkLC07uVqwuMQ==
X-Proofpoint-GUID: Uosg0V1YZ6L9q6e9oR0-kVNo3rjwaHqQ
X-Authority-Analysis: v=2.4 cv=IdSKmGqa c=1 sm=1 tr=0 ts=690a2940 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=J6nKnfFvHuu1lZMax6MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: Uosg0V1YZ6L9q6e9oR0-kVNo3rjwaHqQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_02,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511040137

From: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>

Provide debugfs interfaces support to config unassociated client CFR
from the user space.

To enable CFR capture for unassociated clients,

echo “<mac address> <val> <periodicity>”
 > /sys/kernel/debug/ieee80211/phyX/ath11k/cfr_unassoc

Mac address: mac address of the client.
Val: 0 - start CFR capture
     1 – stop CFR capture
Periodicity: Periodicity at which hardware is expected to collect CFR
dump.
     0 - single shot capture.
     non zero - for Periodic captures (value must be multiple of 10 ms)

Tested-on: IPQ8074 hw2.0 PCI IPQ8074 WLAN.HK.2.5.0.1-00991-QCAHKSWPL_SILICONZ-1
Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-04685-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1

Signed-off-by: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
Co-developed-by: Yu Zhang (Yuriy) <yu.zhang@oss.qualcomm.com>
Signed-off-by: Yu Zhang (Yuriy) <yu.zhang@oss.qualcomm.com>
Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath11k/cfr.c | 228 ++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/cfr.h |  33 ++++
 drivers/net/wireless/ath/ath11k/mac.c |  15 +-
 drivers/net/wireless/ath/ath11k/wmi.c |  16 +-
 drivers/net/wireless/ath/ath11k/wmi.h |   2 +-
 5 files changed, 290 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/cfr.c b/drivers/net/wireless/ath/ath11k/cfr.c
index 5d634d1ef5f5..0fa81c939860 100644
--- a/drivers/net/wireless/ath/ath11k/cfr.c
+++ b/drivers/net/wireless/ath/ath11k/cfr.c
@@ -14,6 +14,60 @@ static int ath11k_cfr_process_data(struct ath11k *ar,
 	return 0;
 }
 
+/* Helper function to check whether the given peer mac address
+ * is in unassociated peer pool or not.
+ */
+bool ath11k_cfr_peer_is_in_cfr_unassoc_pool(struct ath11k *ar, const u8 *peer_mac)
+{
+	struct ath11k_cfr *cfr = &ar->cfr;
+	struct cfr_unassoc_pool_entry *entry;
+	int i;
+
+	if (!ar->cfr_enabled)
+		return false;
+
+	spin_lock_bh(&cfr->lock);
+	for (i = 0; i < ATH11K_MAX_CFR_ENABLED_CLIENTS; i++) {
+		entry = &cfr->unassoc_pool[i];
+		if (!entry->is_valid)
+			continue;
+
+		if (ether_addr_equal(peer_mac, entry->peer_mac)) {
+			spin_unlock_bh(&cfr->lock);
+			return true;
+		}
+	}
+
+	spin_unlock_bh(&cfr->lock);
+
+	return false;
+}
+
+void ath11k_cfr_update_unassoc_pool_entry(struct ath11k *ar,
+					  const u8 *peer_mac)
+{
+	struct ath11k_cfr *cfr = &ar->cfr;
+	struct cfr_unassoc_pool_entry *entry;
+	int i;
+
+	spin_lock_bh(&cfr->lock);
+	for (i = 0; i < ATH11K_MAX_CFR_ENABLED_CLIENTS; i++) {
+		entry = &cfr->unassoc_pool[i];
+		if (!entry->is_valid)
+			continue;
+
+		if (ether_addr_equal(peer_mac, entry->peer_mac) &&
+		    entry->period == 0) {
+			memset(entry->peer_mac, 0, ETH_ALEN);
+			entry->is_valid = false;
+			cfr->cfr_enabled_peer_cnt--;
+			break;
+		}
+	}
+
+	spin_unlock_bh(&cfr->lock);
+}
+
 void ath11k_cfr_decrement_peer_count(struct ath11k *ar,
 				     struct ath11k_sta *arsta)
 {
@@ -130,6 +184,59 @@ int ath11k_cfr_send_peer_cfr_capture_cmd(struct ath11k *ar,
 	return ret;
 }
 
+void ath11k_cfr_update_unassoc_pool(struct ath11k *ar,
+				    struct ath11k_per_peer_cfr_capture *params,
+				    u8 *peer_mac)
+{
+	struct ath11k_cfr *cfr = &ar->cfr;
+	struct cfr_unassoc_pool_entry *entry;
+	int available_idx = -1;
+	int i;
+
+	guard(spinlock_bh)(&cfr->lock);
+
+	if (!params->cfr_enable) {
+		for (i = 0; i < ATH11K_MAX_CFR_ENABLED_CLIENTS; i++) {
+			entry = &cfr->unassoc_pool[i];
+			if (ether_addr_equal(peer_mac, entry->peer_mac)) {
+				memset(entry->peer_mac, 0, ETH_ALEN);
+				entry->is_valid = false;
+				cfr->cfr_enabled_peer_cnt--;
+				break;
+			}
+		}
+		return;
+	}
+
+	if (cfr->cfr_enabled_peer_cnt >= ATH11K_MAX_CFR_ENABLED_CLIENTS) {
+		ath11k_info(ar->ab, "Max cfr peer threshold reached\n");
+		return;
+	}
+
+	for (i = 0; i < ATH11K_MAX_CFR_ENABLED_CLIENTS; i++) {
+		entry = &cfr->unassoc_pool[i];
+
+		if (ether_addr_equal(peer_mac, entry->peer_mac)) {
+			ath11k_info(ar->ab,
+				    "peer entry already present updating params\n");
+			entry->period = params->cfr_period;
+			available_idx = -1;
+			break;
+		}
+
+		if (available_idx < 0 && !entry->is_valid)
+			available_idx = i;
+	}
+
+	if (available_idx >= 0) {
+		entry = &cfr->unassoc_pool[available_idx];
+		ether_addr_copy(entry->peer_mac, peer_mac);
+		entry->period = params->cfr_period;
+		entry->is_valid = true;
+		cfr->cfr_enabled_peer_cnt++;
+	}
+}
+
 static ssize_t ath11k_read_file_enable_cfr(struct file *file,
 					   char __user *user_buf,
 					   size_t count, loff_t *ppos)
@@ -188,10 +295,127 @@ static const struct file_operations fops_enable_cfr = {
 	.llseek = default_llseek,
 };
 
+static ssize_t ath11k_write_file_cfr_unassoc(struct file *file,
+					     const char __user *ubuf,
+					     size_t count, loff_t *ppos)
+{
+	struct ath11k *ar = file->private_data;
+	struct ath11k_cfr *cfr = &ar->cfr;
+	struct cfr_unassoc_pool_entry *entry;
+	char buf[64] = {};
+	u8 peer_mac[6];
+	u32 cfr_capture_enable;
+	u32 cfr_capture_period;
+	int available_idx = -1;
+	int ret, i;
+
+	simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, ubuf, count);
+
+	guard(mutex)(&ar->conf_mutex);
+	guard(spinlock_bh)(&cfr->lock);
+
+	if (ar->state != ATH11K_STATE_ON)
+		return -ENETDOWN;
+
+	if (!ar->cfr_enabled) {
+		ath11k_err(ar->ab, "CFR is not enabled on this pdev %d\n",
+			   ar->pdev_idx);
+		return -EINVAL;
+	}
+
+	ret = sscanf(buf, "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx %u %u",
+		     &peer_mac[0], &peer_mac[1], &peer_mac[2], &peer_mac[3],
+		     &peer_mac[4], &peer_mac[5], &cfr_capture_enable,
+		     &cfr_capture_period);
+
+	if (ret < 1)
+		return -EINVAL;
+
+	if (cfr_capture_enable && ret != 8)
+		return -EINVAL;
+
+	if (!cfr_capture_enable) {
+		for (i = 0; i < ATH11K_MAX_CFR_ENABLED_CLIENTS; i++) {
+			entry = &cfr->unassoc_pool[i];
+			if (ether_addr_equal(peer_mac, entry->peer_mac)) {
+				memset(entry->peer_mac, 0, ETH_ALEN);
+				entry->is_valid = false;
+				cfr->cfr_enabled_peer_cnt--;
+			}
+		}
+
+		return count;
+	}
+
+	if (cfr->cfr_enabled_peer_cnt >= ATH11K_MAX_CFR_ENABLED_CLIENTS) {
+		ath11k_info(ar->ab, "Max cfr peer threshold reached\n");
+		return count;
+	}
+
+	for (i = 0; i < ATH11K_MAX_CFR_ENABLED_CLIENTS; i++) {
+		entry = &cfr->unassoc_pool[i];
+
+		if (available_idx < 0 && !entry->is_valid)
+			available_idx = i;
+
+		if (ether_addr_equal(peer_mac, entry->peer_mac)) {
+			ath11k_info(ar->ab,
+				    "peer entry already present updating params\n");
+			entry->period = cfr_capture_period;
+			return count;
+		}
+	}
+
+	if (available_idx >= 0) {
+		entry = &cfr->unassoc_pool[available_idx];
+		ether_addr_copy(entry->peer_mac, peer_mac);
+		entry->period = cfr_capture_period;
+		entry->is_valid = true;
+		cfr->cfr_enabled_peer_cnt++;
+	}
+
+	return count;
+}
+
+static ssize_t ath11k_read_file_cfr_unassoc(struct file *file,
+					    char __user *ubuf,
+					    size_t count, loff_t *ppos)
+{
+	struct ath11k *ar = file->private_data;
+	struct ath11k_cfr *cfr = &ar->cfr;
+	struct cfr_unassoc_pool_entry *entry;
+	char buf[512] = {};
+	int len = 0, i;
+
+	spin_lock_bh(&cfr->lock);
+
+	for (i = 0; i < ATH11K_MAX_CFR_ENABLED_CLIENTS; i++) {
+		entry = &cfr->unassoc_pool[i];
+		if (entry->is_valid)
+			len += scnprintf(buf + len, sizeof(buf) - len,
+					 "peer: %pM period: %u\n",
+					 entry->peer_mac, entry->period);
+	}
+
+	spin_unlock_bh(&cfr->lock);
+
+	return simple_read_from_buffer(ubuf, count, ppos, buf, len);
+}
+
+static const struct file_operations fops_configure_cfr_unassoc = {
+	.write = ath11k_write_file_cfr_unassoc,
+	.read = ath11k_read_file_cfr_unassoc,
+	.open = simple_open,
+	.owner = THIS_MODULE,
+	.llseek = default_llseek,
+};
+
 static void ath11k_cfr_debug_unregister(struct ath11k *ar)
 {
 	debugfs_remove(ar->cfr.enable_cfr);
 	ar->cfr.enable_cfr = NULL;
+	debugfs_remove(ar->cfr.cfr_unassoc);
+	ar->cfr.cfr_unassoc = NULL;
 }
 
 static void ath11k_cfr_debug_register(struct ath11k *ar)
@@ -199,6 +423,10 @@ static void ath11k_cfr_debug_register(struct ath11k *ar)
 	ar->cfr.enable_cfr = debugfs_create_file("enable_cfr", 0600,
 						 ar->debug.debugfs_pdev, ar,
 						 &fops_enable_cfr);
+
+	ar->cfr.cfr_unassoc = debugfs_create_file("cfr_unassoc", 0600,
+						  ar->debug.debugfs_pdev, ar,
+						  &fops_configure_cfr_unassoc);
 }
 
 void ath11k_cfr_lut_update_paddr(struct ath11k *ar, dma_addr_t paddr,
diff --git a/drivers/net/wireless/ath/ath11k/cfr.h b/drivers/net/wireless/ath/ath11k/cfr.h
index 054962f6cfb3..fa9d98cc72b7 100644
--- a/drivers/net/wireless/ath/ath11k/cfr.h
+++ b/drivers/net/wireless/ath/ath11k/cfr.h
@@ -45,6 +45,12 @@ struct ath11k_look_up_table {
 	struct ath11k_dbring_element *buff;
 };
 
+struct cfr_unassoc_pool_entry {
+	u8 peer_mac[ETH_ALEN];
+	u32 period;
+	bool is_valid;
+};
+
 struct ath11k_cfr {
 	struct ath11k_dbring rx_ring;
 	/* Protects cfr data */
@@ -53,6 +59,7 @@ struct ath11k_cfr {
 	spinlock_t lut_lock;
 	struct ath11k_look_up_table *lut;
 	struct dentry *enable_cfr;
+	struct dentry *cfr_unassoc;
 	u8 cfr_enabled_peer_cnt;
 	u32 lut_num;
 	u64 tx_evt_cnt;
@@ -65,6 +72,7 @@ struct ath11k_cfr {
 	u64 flush_dbr_cnt;
 	u64 clear_txrx_event;
 	u64 cfr_dma_aborts;
+	struct cfr_unassoc_pool_entry unassoc_pool[ATH11K_MAX_CFR_ENABLED_CLIENTS];
 };
 
 enum ath11k_cfr_capture_method {
@@ -88,6 +96,13 @@ void ath11k_cfr_lut_update_paddr(struct ath11k *ar, dma_addr_t paddr,
 				 u32 buf_id);
 void ath11k_cfr_decrement_peer_count(struct ath11k *ar,
 				     struct ath11k_sta *arsta);
+void ath11k_cfr_update_unassoc_pool_entry(struct ath11k *ar,
+					  const u8 *peer_mac);
+bool ath11k_cfr_peer_is_in_cfr_unassoc_pool(struct ath11k *ar,
+					    const u8 *peer_mac);
+void ath11k_cfr_update_unassoc_pool(struct ath11k *ar,
+				    struct ath11k_per_peer_cfr_capture *params,
+				    u8 *peer_mac);
 int ath11k_cfr_send_peer_cfr_capture_cmd(struct ath11k *ar,
 					 struct ath11k_sta *arsta,
 					 struct ath11k_per_peer_cfr_capture *params,
@@ -113,6 +128,24 @@ static inline void ath11k_cfr_decrement_peer_count(struct ath11k *ar,
 {
 }
 
+static inline void ath11k_cfr_update_unassoc_pool_entry(struct ath11k *ar,
+							const u8 *peer_mac)
+{
+}
+
+static inline bool
+ath11k_cfr_peer_is_in_cfr_unassoc_pool(struct ath11k *ar, const u8 *peer_mac)
+{
+	return false;
+}
+
+static inline void
+ath11k_cfr_update_unassoc_pool(struct ath11k *ar,
+			       struct ath11k_per_peer_cfr_capture *params,
+			       u8 *peer_mac)
+{
+}
+
 static inline int
 ath11k_cfr_send_peer_cfr_capture_cmd(struct ath11k *ar,
 				     struct ath11k_sta *arsta,
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 965c377cd8dc..2fbd64d78338 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -6186,6 +6186,8 @@ static int ath11k_mac_mgmt_tx_wmi(struct ath11k *ar, struct ath11k_vif *arvif,
 	dma_addr_t paddr;
 	int buf_id;
 	int ret;
+	bool tx_params_valid = false;
+	bool peer_in_unassoc_pool;
 
 	ATH11K_SKB_CB(skb)->ar = ar;
 
@@ -6224,7 +6226,18 @@ static int ath11k_mac_mgmt_tx_wmi(struct ath11k *ar, struct ath11k_vif *arvif,
 
 	ATH11K_SKB_CB(skb)->paddr = paddr;
 
-	ret = ath11k_wmi_mgmt_send(ar, arvif->vdev_id, buf_id, skb);
+	peer_in_unassoc_pool = ath11k_cfr_peer_is_in_cfr_unassoc_pool(ar, hdr->addr1);
+
+	if (ar->cfr_enabled &&
+	    ieee80211_is_probe_resp(hdr->frame_control) &&
+	    peer_in_unassoc_pool)
+		tx_params_valid = true;
+
+	if (peer_in_unassoc_pool)
+		ath11k_cfr_update_unassoc_pool_entry(ar, hdr->addr1);
+
+	ret = ath11k_wmi_mgmt_send(ar, arvif->vdev_id, buf_id, skb,
+				   tx_params_valid);
 	if (ret) {
 		ath11k_warn(ar->ab, "failed to send mgmt frame: %d\n", ret);
 		goto err_unmap_buf;
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 846c9946a084..0b4cc943c290 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -651,11 +651,12 @@ static u32 ath11k_wmi_mgmt_get_freq(struct ath11k *ar,
 }
 
 int ath11k_wmi_mgmt_send(struct ath11k *ar, u32 vdev_id, u32 buf_id,
-			 struct sk_buff *frame)
+			 struct sk_buff *frame, bool tx_params_valid)
 {
 	struct ath11k_pdev_wmi *wmi = ar->wmi;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(frame);
 	struct wmi_mgmt_send_cmd *cmd;
+	struct wmi_mgmt_send_params *params;
 	struct wmi_tlv *frame_tlv;
 	struct sk_buff *skb;
 	u32 buf_len;
@@ -665,6 +666,8 @@ int ath11k_wmi_mgmt_send(struct ath11k *ar, u32 vdev_id, u32 buf_id,
 		  frame->len : WMI_MGMT_SEND_DOWNLD_LEN;
 
 	len = sizeof(*cmd) + sizeof(*frame_tlv) + roundup(buf_len, 4);
+	if (tx_params_valid)
+		len += sizeof(*params);
 
 	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, len);
 	if (!skb)
@@ -680,7 +683,7 @@ int ath11k_wmi_mgmt_send(struct ath11k *ar, u32 vdev_id, u32 buf_id,
 	cmd->paddr_hi = upper_32_bits(ATH11K_SKB_CB(frame)->paddr);
 	cmd->frame_len = frame->len;
 	cmd->buf_len = buf_len;
-	cmd->tx_params_valid = 0;
+	cmd->tx_params_valid = !!tx_params_valid;
 
 	frame_tlv = (struct wmi_tlv *)(skb->data + sizeof(*cmd));
 	frame_tlv->header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_ARRAY_BYTE) |
@@ -690,6 +693,15 @@ int ath11k_wmi_mgmt_send(struct ath11k *ar, u32 vdev_id, u32 buf_id,
 
 	ath11k_ce_byte_swap(frame_tlv->value, buf_len);
 
+	if (tx_params_valid) {
+		params =
+		(struct wmi_mgmt_send_params *)(skb->data + (len - sizeof(*params)));
+		params->tlv_header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_TX_SEND_PARAMS) |
+				     FIELD_PREP(WMI_TLV_LEN,
+						sizeof(*params) - TLV_HDR_SIZE);
+		params->tx_params_dword1 |= WMI_TX_PARAMS_DWORD1_CFR_CAPTURE;
+	}
+
 	ret = ath11k_wmi_cmd_send(wmi, skb, WMI_MGMT_TX_SEND_CMDID);
 	if (ret) {
 		ath11k_warn(ar->ab,
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 1562d169ba9a..afc78fa4389b 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -6391,7 +6391,7 @@ int ath11k_wmi_cmd_send(struct ath11k_pdev_wmi *wmi, struct sk_buff *skb,
 			u32 cmd_id);
 struct sk_buff *ath11k_wmi_alloc_skb(struct ath11k_wmi_base *wmi_sc, u32 len);
 int ath11k_wmi_mgmt_send(struct ath11k *ar, u32 vdev_id, u32 buf_id,
-			 struct sk_buff *frame);
+			 struct sk_buff *frame, bool tx_params_valid);
 int ath11k_wmi_p2p_go_bcn_ie(struct ath11k *ar, u32 vdev_id,
 			     const u8 *p2p_ie);
 int ath11k_wmi_bcn_tmpl(struct ath11k *ar, u32 vdev_id,
-- 
2.34.1


