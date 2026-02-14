Return-Path: <linux-wireless+bounces-31825-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id X0G1K3nzj2k3UgEAu9opvQ
	(envelope-from <linux-wireless+bounces-31825-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 05:00:57 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 052E813AF78
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 05:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7509303CC25
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 04:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F4DEEBA;
	Sat, 14 Feb 2026 04:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iUlZ9hy2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kpLONvKr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1B03EBF06
	for <linux-wireless@vger.kernel.org>; Sat, 14 Feb 2026 04:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771041654; cv=none; b=PymGTNdaGoj6QDgM6CnX3y8ehr6OKOEFpHOpPkw0JFs6g0kgocKCazK02moD2PBgEyMtv4DWhsTr3qJyv6bTTMyo92bk92YG4LJnzH6fjTSx8mfBlDWPML+rEKVkVJrhbrkT6AtXAeYsJRDCnWAALd++HNCpdrT6i/gbTHy+Pbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771041654; c=relaxed/simple;
	bh=lOrjF8FbIEfoP8YoloGpeylA4FJ+kFeJwd0emqoA5f0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=qqxOnFIIZiMS0CTCuY2t7ck+scq34NOTcpRma8zj6j91Wc12o4VKUfaRRDN8MHLXa5cyngBRrTd3UgcbRdk+47IgX1kHbijK66sTngnx96Oem7eHiwrl3cQC3Jf7uNRGMrSMOci4zngeC8AbTlIchNihxgL60AQj5U4U0znhBl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iUlZ9hy2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kpLONvKr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61E2poiM775276
	for <linux-wireless@vger.kernel.org>; Sat, 14 Feb 2026 04:00:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:message-id:subject:to; s=qcppdkim1; bh=8KbHFKu3heKo
	GLXYqjv8uMvTD/IdiaghTxZ08wV4Nws=; b=iUlZ9hy2e1CZ83TyTNOdxwUZyaKs
	LHqo7fhSWaIYDNm9LRWyWZMpC3N9Hem3BGbF2jIa42Mher5zQN2cuaf19bCf+zNF
	RwonQsSLUP0kGTaJYvK8J3OBKmC2zfNpUVg7VhwPJOututKS1Yr4c6ynCgG+I3Ip
	NtauCPJnmZ6ClXXXA/c1yQTmnwsPIsdMsu2Yu8Tbvo2BRY0DpSY5awu1K2lBN4mW
	pg3znFsBbPaKiQb6SKF1fx9tCL4kZdK/PKJvKZ6uUhDXi8ogAL1lwtEIM2YfEvtH
	RiyRZ/MbEQnW8iIVQItQFTF2LIAjsGK5NaGNjBvOTIdKUEYy2pfum6hCZw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cagmy03rq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 14 Feb 2026 04:00:51 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8216fece04cso3222485b3a.0
        for <linux-wireless@vger.kernel.org>; Fri, 13 Feb 2026 20:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771041651; x=1771646451; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8KbHFKu3heKoGLXYqjv8uMvTD/IdiaghTxZ08wV4Nws=;
        b=kpLONvKrC3GE3HWM7+ELABnatpa37wa0lx9QLNaqagaHzdCXtAGzJTBlHHjlQCsmPi
         67MpG+K/TH8WnOf2z+sNpGxa2Agu+mOWd6DG2KjEyv2CH7ECJqNhD/eIOFaZ2Neqi15k
         nAkZZOKUCnGoKjK4c9wdIJReyydgrelYT5TBbEZsspVPwoYXf2rZP9JNGJfIMY8V8bbG
         Jbv2raBpgN2z2kw67CQF9hyyhEPAQGe56J8fhN3bFnS4fVdfIcJ2NOtlcIv81pGhQ4gs
         lfp3crZXfLNiS/A/nG139UuBaY79va+CJ1dgJqERF1Da0Jl0nvXC3mVYzzEX5m075ZXP
         sj4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771041651; x=1771646451;
        h=message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8KbHFKu3heKoGLXYqjv8uMvTD/IdiaghTxZ08wV4Nws=;
        b=HbbVC3LV0apxRWo9186/x8MAbjC8sSUCp6+RcnkIxNjsp2fYS6B7OQgFSNfgDlt/BZ
         ugspufp0IaPTSlm8UhM2wf68dKHttFzRyYc5LPb3fUEXjs2I0/D8jeHKUfmoApfUOBZQ
         SlqT2LO0BH+mU6/mgJZRSyz94fqSnClZUbiyv8wtw2UNW/cKAP6YD4XZ4WDeITQef+Dz
         reSBU9jEDTABUnAwvNg4AdY8xJC5fOXQyj4OVHt4TPFASaijP+qwJQi24Pukp3eEgYqk
         KIHkX0Dk4EUFXRUNmxj5CDK4JrlMx/O20nhlaP367J/bR37F58JOHUxwDZ5xwvuXqcN+
         j37Q==
X-Gm-Message-State: AOJu0YxKg77XWsYq2GolpAluCMKa9ZBNGQHNwderIfeRoLn52HdWGxWD
	vPyTb6xJstgj/cz2wgTDMdWrKQ7tOnNXi3LXG/G3QtqVUUUTLJGvkqMwIDlMI8to1brFHmbGruY
	VkBw7c+4unm8ilmXkfEyFmKf+OIaN0+8uZOeCZE6Qg0flmPsUQHnbGOvt0nJnIrqot5y8og==
X-Gm-Gg: AZuq6aKFd/HkgU66NYtZGTz3ECdXZNGBh3GQRGI+OqYxk5C1H6dhgEmMu27dV0PARJd
	rzTPi9WCoy+XGYyAkuXvle09q6iVkW9mqVRQoC3RS+pynshnXueCfyQZ8FLv9kPi+lw+vABcrpa
	ekqH5cUEUbNUST9l5WcmpXvbcHL7iSIsnzqIL8s512Pii7e0+a6nmQp+PNK4Z7FVSqU07wj8fpp
	nkNo+ZvyskA6iHg4DiOlTCK5ZQfWeT1PmWleDBt+D4svvPYp9taeHeCdBeiPbIPaNUUg6FvrdZY
	68BMYdo24YGUhcT9+sgr85KfQJ2tWSX0viTc4VMgDNUTc2FjnUuorWPQyz0+Ux/PyBhEU71cw5e
	9VVe+DMspHC/27IdwbclkG4CPcvUqruDXCT4O3nEyFzCKhDD478Vhp6ajwsEw8s8V
X-Received: by 2002:a05:6a00:139f:b0:78a:f6be:74f2 with SMTP id d2e1a72fcca58-824d5c9717dmr2030305b3a.5.1771041650582;
        Fri, 13 Feb 2026 20:00:50 -0800 (PST)
X-Received: by 2002:a05:6a00:139f:b0:78a:f6be:74f2 with SMTP id d2e1a72fcca58-824d5c9717dmr2030272b3a.5.1771041649967;
        Fri, 13 Feb 2026 20:00:49 -0800 (PST)
Received: from che-ventolnx02.qualcomm.com ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6bb25e9sm4145398b3a.56.2026.02.13.20.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 20:00:49 -0800 (PST)
From: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>,
        Aishwarya R <aishwarya.r@oss.qualcomm.com>
Subject: [PATCH ath-next] wifi: ath12k: add basic hwmon temperature reporting
Date: Sat, 14 Feb 2026 09:29:47 +0530
Message-Id: <20260214035947.44671-1-maharaja.kennadyrajan@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-GUID: MDqI3cvP9X8s7GqKPc072DYT4_QJZ5fC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE0MDAyNyBTYWx0ZWRfX54ZAQHkXjhQp
 Sf7Q3jD/SRui3ig45DNAkxc6GoMnF5eEbPFcya9Y535LMfjmyRwITCthEcrAvxw4M0nPonpQ42K
 M3kH3naGSDu0ZaqrsviOJhfTu1eNSCZRRupnae+1wdODI2BzKiuyuAvfbelNgeLRmJXClFoRwFb
 7C2xLhCyFSLjlzVoc7xvb9poUyGeLLuAv2uhFWyhzVZb7OEEq3MDKGLOdVdKRkVB6rYlf7dZ/+k
 ONziuNupqKkaHaE2veCVevS24FccMh7jQ28s97fvLNCo47r7j1XCjaGjoUGzml7j2uIx+TihD11
 aqQ51VuUS67MDo63obGt+jVJ4QsjZa1LHwg2gKw7Lauv5bykn2Sz4Td2qAs9J67Kf0vkMun7w6r
 X5+SWyY7VQ1t8Xvo7JYBPDH7O98C4Rn3nTGBVIoaXH7lK7pYjLFLo79Ic4aKttbdmTVq7z3Ykqa
 WKXrxitkpfyhjwncu5g==
X-Authority-Analysis: v=2.4 cv=f5xFxeyM c=1 sm=1 tr=0 ts=698ff373 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=OZsag2OyA3-ljdnlw3cA:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: MDqI3cvP9X8s7GqKPc072DYT4_QJZ5fC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_05,2026-02-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 adultscore=0 impostorscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602140027
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31825-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maharaja.kennadyrajan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 052E813AF78
X-Rspamd-Action: no action

Add initial thermal support by wiring up a per-radio (pdev) hwmon temperature
sensor backed by the existing WMI pdev temperature command and event.
When userspace reads the sysfs file temp1_input, the driver sends
WMI_PDEV_GET_TEMPERATURE_CMDID (tag WMI_TAG_PDEV_GET_TEMPERATURE_CMD) and waits
for the corresponding WMI_PDEV_TEMPERATURE_EVENTID
(tag WMI_TAG_PDEV_TEMPERATURE_EVENT) to get the temperature and pdev_id.

Export the reported value in millidegrees Celsius as required by hwmon.
The temperature reported is per-radio (pdev). In a multi-radio wiphy under a
single phy, a separate hwmon device is created for each radio.

Sample command and output:
$ cat /sys/devices/pci0000:00/.../ieee80211/phyX/hwmonY/temp1_input
$ 50000

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

Co-developed-by: Aishwarya R <aishwarya.r@oss.qualcomm.com>
Signed-off-by: Aishwarya R <aishwarya.r@oss.qualcomm.com>
Signed-off-by: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/Makefile  |   1 +
 drivers/net/wireless/ath/ath12k/core.c    |  13 +++
 drivers/net/wireless/ath/ath12k/core.h    |   3 +
 drivers/net/wireless/ath/ath12k/mac.c     |   5 +
 drivers/net/wireless/ath/ath12k/thermal.c | 122 ++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/thermal.h |  44 ++++++++
 drivers/net/wireless/ath/ath12k/wmi.c     |  57 +++++-----
 7 files changed, 214 insertions(+), 31 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath12k/thermal.c
 create mode 100644 drivers/net/wireless/ath/ath12k/thermal.h

diff --git a/drivers/net/wireless/ath/ath12k/Makefile b/drivers/net/wireless/ath/ath12k/Makefile
index 3ba1236956cc..3b39b2c33307 100644
--- a/drivers/net/wireless/ath/ath12k/Makefile
+++ b/drivers/net/wireless/ath/ath12k/Makefile
@@ -32,6 +32,7 @@ ath12k-$(CONFIG_ATH12K_TRACING) += trace.o
 ath12k-$(CONFIG_PM) += wow.o
 ath12k-$(CONFIG_ATH12K_COREDUMP) += coredump.o
 ath12k-$(CONFIG_NL80211_TESTMODE) += testmode.o
+ath12k-$(CONFIG_THERMAL) += thermal.o
 
 # for tracing framework to find trace.h
 CFLAGS_trace.o := -I$(src)
diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 9d6c50a94e64..9dca1a0af73e 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -863,11 +863,22 @@ static int ath12k_core_pdev_create(struct ath12k_base *ab)
 		return ret;
 	}
 
+	ret = ath12k_thermal_register(ab);
+	if (ret) {
+		ath12k_err(ab, "could not register thermal device: %d\n", ret);
+		goto err_dp_pdev_free;
+	}
+
 	return 0;
+
+err_dp_pdev_free:
+	ath12k_dp_pdev_free(ab);
+	return ret;
 }
 
 static void ath12k_core_pdev_destroy(struct ath12k_base *ab)
 {
+	ath12k_thermal_unregister(ab);
 	ath12k_dp_pdev_free(ab);
 }
 
@@ -1361,6 +1372,7 @@ static int ath12k_core_reconfigure_on_crash(struct ath12k_base *ab)
 
 	mutex_lock(&ab->core_lock);
 	ath12k_link_sta_rhash_tbl_destroy(ab);
+	ath12k_thermal_unregister(ab);
 	ath12k_dp_pdev_free(ab);
 	ath12k_ce_cleanup_pipes(ab);
 	ath12k_wmi_detach(ab);
@@ -1502,6 +1514,7 @@ static void ath12k_core_pre_reconfigure_recovery(struct ath12k_base *ab)
 			complete(&ar->vdev_delete_done);
 			complete(&ar->bss_survey_done);
 			complete_all(&ar->regd_update_completed);
+			complete_all(&ar->thermal.wmi_sync);
 
 			wake_up(&ar->dp.tx_empty_waitq);
 			idr_for_each(&ar->txmgmt_idr,
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 990934ec92fc..760c76d6f0f4 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -36,6 +36,7 @@
 #include "coredump.h"
 #include "cmn_defs.h"
 #include "dp_cmn.h"
+#include "thermal.h"
 
 #define SM(_v, _f) (((_v) << _f##_LSB) & _f##_MASK)
 
@@ -757,6 +758,8 @@ struct ath12k {
 
 	s8 max_allowed_tx_power;
 	struct ath12k_pdev_rssi_offsets rssi_info;
+
+	struct ath12k_thermal thermal;
 };
 
 struct ath12k_hw {
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 68431a0e128e..d1db1285449c 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -14792,6 +14792,11 @@ static void ath12k_mac_setup(struct ath12k *ar)
 	init_completion(&ar->mlo_setup_done);
 	init_completion(&ar->completed_11d_scan);
 	init_completion(&ar->regd_update_completed);
+	init_completion(&ar->thermal.wmi_sync);
+	mutex_init(&ar->thermal.read_lock);
+
+	ar->thermal.temperature = 0;
+	ar->thermal.hwmon_dev = NULL;
 
 	INIT_DELAYED_WORK(&ar->scan.timeout, ath12k_scan_timeout_work);
 	wiphy_work_init(&ar->scan.vdev_clean_wk, ath12k_scan_vdev_clean_work);
diff --git a/drivers/net/wireless/ath/ath12k/thermal.c b/drivers/net/wireless/ath/ath12k/thermal.c
new file mode 100644
index 000000000000..33d3e70b2df9
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/thermal.c
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * Copyright (c) 2020 The Linux Foundation. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/device.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/sysfs.h>
+#include <linux/thermal.h>
+#include "core.h"
+#include "debug.h"
+
+static ssize_t ath12k_thermal_temp_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct ath12k *ar = dev_get_drvdata(dev);
+	unsigned long time_left;
+	int ret, temperature;
+
+	guard(wiphy)(ath12k_ar_to_hw(ar)->wiphy);
+	guard(mutex)(&ar->thermal.read_lock);
+
+	if (ar->ah->state != ATH12K_HW_STATE_ON)
+		return -ENETDOWN;
+
+	reinit_completion(&ar->thermal.wmi_sync);
+	ret = ath12k_wmi_send_pdev_temperature_cmd(ar);
+	if (ret) {
+		ath12k_warn(ar->ab, "failed to read temperature %d\n", ret);
+		return ret;
+	}
+
+	if (test_bit(ATH12K_FLAG_CRASH_FLUSH, &ar->ab->dev_flags))
+		return -ESHUTDOWN;
+
+	time_left = wait_for_completion_timeout(&ar->thermal.wmi_sync,
+						ATH12K_THERMAL_SYNC_TIMEOUT_HZ);
+	if (!time_left) {
+		ath12k_warn(ar->ab, "failed to synchronize thermal read\n");
+		return -ETIMEDOUT;
+	}
+
+	spin_lock_bh(&ar->data_lock);
+	temperature = ar->thermal.temperature;
+	spin_unlock_bh(&ar->data_lock);
+
+	/* display in millidegree celsius */
+	return sysfs_emit(buf, "%d\n", temperature * 1000);
+}
+
+void ath12k_thermal_event_temperature(struct ath12k *ar, int temperature)
+{
+	spin_lock_bh(&ar->data_lock);
+	ar->thermal.temperature = temperature;
+	spin_unlock_bh(&ar->data_lock);
+	complete_all(&ar->thermal.wmi_sync);
+}
+
+static SENSOR_DEVICE_ATTR_RO(temp1_input, ath12k_thermal_temp, 0);
+
+static struct attribute *ath12k_hwmon_attrs[] = {
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(ath12k_hwmon);
+
+int ath12k_thermal_register(struct ath12k_base *ab)
+{
+	struct ath12k *ar;
+	int i, j, ret;
+
+	if (!IS_REACHABLE(CONFIG_HWMON))
+		return 0;
+
+	for (i = 0; i < ab->num_radios; i++) {
+		ar = ab->pdevs[i].ar;
+		if (!ar)
+			continue;
+
+		ar->thermal.hwmon_dev =
+			hwmon_device_register_with_groups(&ar->ah->hw->wiphy->dev,
+							  "ath12k_hwmon", ar,
+							  ath12k_hwmon_groups);
+		if (IS_ERR(ar->thermal.hwmon_dev)) {
+			ret = PTR_ERR(ar->thermal.hwmon_dev);
+			ar->thermal.hwmon_dev = NULL;
+			ath12k_err(ar->ab, "failed to register hwmon device: %d\n",
+				   ret);
+			for (j = i - 1; j >= 0; j--) {
+				ar = ab->pdevs[i].ar;
+				if (!ar)
+					continue;
+
+				hwmon_device_unregister(ar->thermal.hwmon_dev);
+				ar->thermal.hwmon_dev = NULL;
+			}
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+void ath12k_thermal_unregister(struct ath12k_base *ab)
+{
+	struct ath12k *ar;
+	int i;
+
+	for (i = 0; i < ab->num_radios; i++) {
+		ar = ab->pdevs[i].ar;
+		if (!ar)
+			continue;
+
+		if (ar->thermal.hwmon_dev) {
+			hwmon_device_unregister(ar->thermal.hwmon_dev);
+			ar->thermal.hwmon_dev = NULL;
+		}
+	}
+}
diff --git a/drivers/net/wireless/ath/ath12k/thermal.h b/drivers/net/wireless/ath/ath12k/thermal.h
new file mode 100644
index 000000000000..a853af5f2441
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/thermal.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
+/*
+ * Copyright (c) 2020 The Linux Foundation. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef _ATH12K_THERMAL_
+#define _ATH12K_THERMAL_
+
+#include <linux/mutex.h>
+
+#define ATH12K_THERMAL_SYNC_TIMEOUT_HZ (5 * HZ)
+
+struct ath12k_thermal {
+	struct completion wmi_sync;
+
+	/* temperature value in Celsius degree protected by data_lock. */
+	int temperature;
+	struct device *hwmon_dev;
+	/* Serialize concurrent sysfs reads to avoid completion races */
+	struct mutex read_lock;
+};
+
+#if IS_REACHABLE(CONFIG_THERMAL)
+int ath12k_thermal_register(struct ath12k_base *ab);
+void ath12k_thermal_unregister(struct ath12k_base *ab);
+void ath12k_thermal_event_temperature(struct ath12k *ar, int temperature);
+#else
+static inline int ath12k_thermal_register(struct ath12k_base *ab)
+{
+	return 0;
+}
+
+static inline void ath12k_thermal_unregister(struct ath12k_base *ab)
+{
+}
+
+static inline void ath12k_thermal_event_temperature(struct ath12k *ar,
+						    int temperature)
+{
+}
+
+#endif
+#endif /* _ATH12K_THERMAL_ */
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 7617fc3a2479..69f2dbcfca63 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -6778,31 +6778,6 @@ static int ath12k_pull_peer_assoc_conf_ev(struct ath12k_base *ab, struct sk_buff
 	return 0;
 }
 
-static int
-ath12k_pull_pdev_temp_ev(struct ath12k_base *ab, struct sk_buff *skb,
-			 const struct wmi_pdev_temperature_event *ev)
-{
-	const void **tb;
-	int ret;
-
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
-	if (IS_ERR(tb)) {
-		ret = PTR_ERR(tb);
-		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
-		return ret;
-	}
-
-	ev = tb[WMI_TAG_PDEV_TEMPERATURE_EVENT];
-	if (!ev) {
-		ath12k_warn(ab, "failed to fetch pdev temp ev");
-		kfree(tb);
-		return -EPROTO;
-	}
-
-	kfree(tb);
-	return 0;
-}
-
 static void ath12k_wmi_op_ep_tx_credits(struct ath12k_base *ab)
 {
 	/* try to send pending beacons first. they take priority */
@@ -8811,25 +8786,45 @@ static void
 ath12k_wmi_pdev_temperature_event(struct ath12k_base *ab,
 				  struct sk_buff *skb)
 {
+	const struct wmi_pdev_temperature_event *ev;
 	struct ath12k *ar;
-	struct wmi_pdev_temperature_event ev = {};
+	const void **tb;
+	int temp;
+	u32 pdev_id;
+
+	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
+	if (IS_ERR(tb)) {
+		ath12k_warn(ab, "failed to parse tlv: %ld\n", PTR_ERR(tb));
+		return;
+	}
 
-	if (ath12k_pull_pdev_temp_ev(ab, skb, &ev) != 0) {
-		ath12k_warn(ab, "failed to extract pdev temperature event");
+	ev = tb[WMI_TAG_PDEV_TEMPERATURE_EVENT];
+	if (!ev) {
+		ath12k_warn(ab, "failed to fetch pdev temp ev\n");
+		kfree(tb);
 		return;
 	}
 
+	temp = a_sle32_to_cpu(ev->temp);
+	pdev_id = le32_to_cpu(ev->pdev_id);
+
+	kfree(tb);
+
 	ath12k_dbg(ab, ATH12K_DBG_WMI,
-		   "pdev temperature ev temp %d pdev_id %d\n", ev.temp, ev.pdev_id);
+		   "pdev temperature ev temp %d pdev_id %u\n",
+		   temp, pdev_id);
 
 	rcu_read_lock();
 
-	ar = ath12k_mac_get_ar_by_pdev_id(ab, le32_to_cpu(ev.pdev_id));
+	ar = ath12k_mac_get_ar_by_pdev_id(ab, pdev_id);
 	if (!ar) {
-		ath12k_warn(ab, "invalid pdev id in pdev temperature ev %d", ev.pdev_id);
+		ath12k_warn(ab, "invalid pdev id %u in pdev temperature ev\n",
+			    pdev_id);
 		goto exit;
 	}
 
+	ath12k_thermal_event_temperature(ar, temp);
+
 exit:
 	rcu_read_unlock();
 }

base-commit: 37a93dd5c49b5fda807fd204edf2547c3493319c
-- 
2.34.1


