Return-Path: <linux-wireless+bounces-34710-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOFSAqkO3WkOZQkAu9opvQ
	(envelope-from <linux-wireless+bounces-34710-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 17:41:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B1D3EE19E
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 17:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C8E2530387C7
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 15:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769443E1D00;
	Mon, 13 Apr 2026 15:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PrNtyvOF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FXjz3YjB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F12C3E2750
	for <linux-wireless@vger.kernel.org>; Mon, 13 Apr 2026 15:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776094787; cv=none; b=ptHQhiw4tdc/6OEdoYXo1Yqe7GOkDh4QUJskCeTabRUqW+cg1PGDNYFKT4u51k+qNzrS9Y2DuOpWU/IuRcLDcJsHrCe2A+3B+Hzjr873Nfuv85GTPM50/uPus4X7x4Qepxgld4OyT7d7RCDLmqIlXVEQEsBfyZxQR+HnvKxH5CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776094787; c=relaxed/simple;
	bh=4KB09CwohQmzBpT1WaYWLQmdAAZXLCabcQCRHHjUWCA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t40tXlr1Cn+DEuuHQTh2jQCznHyZe4w3Jkgqo7x+hGxUxuQeC3Idm+f28zYQ143hyRz5p65D72J/HlF55O67TcLFjdiOnPOHXgx0e/im9+2FcSEJ2vz9f/UgkgHAUIyxyJTFBa5uuV9IzKGPrMXrFsHBQ7OHnXtqvGF2BB31R/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PrNtyvOF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FXjz3YjB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63DDxnT3479862
	for <linux-wireless@vger.kernel.org>; Mon, 13 Apr 2026 15:39:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=7x7Sag3p1W6
	KTCAxlSilDkanjEO722npmlRKN1tRFNk=; b=PrNtyvOFXbomcgRYqtxDSzmPRG6
	h/cW+qbX5cS0whZ1/fjMcE81C3P9yO7FjAPSjZu7FxFBoi/Ss34Pr3Gv1Qj0IDs2
	+EdD0RMtaMMBZ79b4mzJ3mXPSGsG9yXcgvcOPQwKqzEts/Pl1DZiocitT1/kRBlv
	PfiJ3UYNr4hj91pHTECtqX7DVGIbuOXzwyGWSNxLh0DprAeQPgT9bUkz8j/Zy3t5
	yZKFuIn25p2djdBi0fkObKGxdsdAESNALykBa6qqRR4auT8OVE26PMpKAydRXFmf
	j4aAmc1roP0aD6GJfqYdypnhiaFmSWEh4V8S+BYvchHt6B+/Zf9BOZyiO+A==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dguuj9tdn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Apr 2026 15:39:45 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b24cd2e2b3so44829095ad.0
        for <linux-wireless@vger.kernel.org>; Mon, 13 Apr 2026 08:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776094784; x=1776699584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7x7Sag3p1W6KTCAxlSilDkanjEO722npmlRKN1tRFNk=;
        b=FXjz3YjBL9aaacb7aMeUnYqK81/q6SplDkLPPfwRngDrtwc7KGi+XiFA9DarxY5SuG
         AqYi79IVbARt32y59NZXfU9rMgdspcBbHpdajZxjAHdOZ3rLvXF5/8pNedlZ+PtDAH7H
         5VJl6UsnQN8ngEE2WL5fokaaA47crDKI9OjlfBqn8CtoaYmMrRezKeqkVAwN1L1Uldwh
         clrVgETxgXWQP2IpBctC/gZINVh5puPIcIK5XzATyxbeDj9v3mx1a7onf6tTV3X14mgy
         VPKZVZtDAPuhYG8vRep2q/4VqN0GGC3TJoCGiIMo+yz3A9QHQ4JzKZsLs/7afo76CEOO
         QXfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776094784; x=1776699584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7x7Sag3p1W6KTCAxlSilDkanjEO722npmlRKN1tRFNk=;
        b=jUr2aK8qaRElgGtupzLkraDLfOIxqesXNGDgdydpu4EWWVxqD8aA0vnTfHcfbm/pgU
         FqvQGIm3qEg6FgOv1tQNo4MWnjZOkAT4uJbztLjoJHrfqFP1fYQBqxFlyu0OcRuuor1l
         P0GLHsJ398NSYjkwsxEgOrjGbmcizgfHM3CS1bPLSVGKOjWbXI/nZUPeaXCi5dVhYeKW
         ntfzKBGiP7u9IggXmUou2tSU8wAsGP+YULvuIGMAyiwYl/hIAjn6IKk6TH9aAArTle6V
         OdBlQhIa/X+A7EeG46U2Pd/dR6Yuk9MpCK1UFhjYcJPAqIWl+jaqYg1b5CTsZp8zWPjb
         esuA==
X-Gm-Message-State: AOJu0YwNyYVyAEhDiOol8Q2ESfTgBITbZTLEC97Wvwpv597TCjPxpHHL
	0rTKeUwWgz7bKwrswo4mfUiuiaDqEUtcPKaLa9aUWJpnfjaD6Qn9hVz4MCEkA0TfF1LAyGZTd9q
	TpYQ8y8x2TGHlkP3cYadUz7/2HUkE4XAFvpE4Dq5dlxtxraIsyuLLODi5xRrdbnisn39PEuvSAk
	eS3A==
X-Gm-Gg: AeBDieuo4cw/+VHmaGWuraPUZWmI1PJxJ3MM00hquMZ7vrQw4A+z2rwkyNAJv5JPJ1q
	G9XFu3dcLeWhkLwrMdXQClOGaNudsFD1xJEZTMKD15Www+Jvqw4EO6VeZJCOm/seUED35oQEy+z
	UQij+z5hWmZbV6RUcjB/DnM5dgTB9Zz5exa26vldxeKUCMJ3qTPnPi9DzR5fjI0mIS8Ik5rGygh
	cK97mQt1Cx2QsfTvCnkk8uznqOm5zqyx/mfUPd4zkHI5aaeJqhhKwZblXChhIJU4YRfcSw+WNyE
	qSqiu0Jgc/eZdbpuNeJuNmuAbE6PHjYQStld+W2B6EM5bSrxiXCryTxsfdDZdUsdgFFDMeP3BQq
	W82afren1PiXceqUshVNSjjd20FLuePCmsNHdx8FQ6qPL98fpamasLB5wUBI1arkEk4bRH9iFYN
	xt7F7XXrdgY/JcyTc+8hKmUQmNV7eGXBh2ZA3kd1w48Hesow1Myhw=
X-Received: by 2002:a17:90b:3950:b0:35b:e4f8:7cc5 with SMTP id 98e67ed59e1d1-35e4284c7e0mr13321527a91.25.1776094784328;
        Mon, 13 Apr 2026 08:39:44 -0700 (PDT)
X-Received: by 2002:a17:90b:3950:b0:35b:e4f8:7cc5 with SMTP id 98e67ed59e1d1-35e4284c7e0mr13321510a91.25.1776094783816;
        Mon, 13 Apr 2026 08:39:43 -0700 (PDT)
Received: from hu-mkenna-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e411ff4e1sm13000123a91.3.2026.04.13.08.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 08:39:43 -0700 (PDT)
From: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Subject: [PATCH ath-next v2 3/5] wifi: ath12k: refactor per-radio thermal hwmon setup and cleanup
Date: Mon, 13 Apr 2026 21:08:38 +0530
Message-Id: <20260413153840.1969931-4-maharaja.kennadyrajan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260413153840.1969931-1-maharaja.kennadyrajan@oss.qualcomm.com>
References: <20260413153840.1969931-1-maharaja.kennadyrajan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDE1MyBTYWx0ZWRfXxIw7q6DkRL7v
 MlDrARUz+rqRDbYJnCY7mnnLWS8Qo2mUAip336TjdLReQXvtHATHg2sKEt58rpI8/Dc/yAAqXRf
 igtDByOztH0g0USVh/3jxgOuUGEIGd6wfJMtny1pZu37Dii2naMPN9UaPGjOEeHIlJUvkbBuZ2x
 ymfsbmxfITxzTSaWyrpAA9uAAk6CyBtHphfu1Im2S0g5SajWbhdZ/ezST8Wg8BbVY2Asj85ZlMO
 WzNPFeUttVwR5+oEG+2MtjodSh5AlNx+0fDqetKTxZXhliqvroblXqwZuLGYqz/sQMzPcKLVmnd
 mSEsVhKPFN9IBZ2JiGgTGnKNBK9zWC+2aWsEeth0265yjlo0fkMEbM1HC3Drj7Z2Wh0eDuqW+hV
 zjO2y7P+bwDroDrEpWVasL1mcBxGfLmbCIQmFOmEJCwvkfWU0oFMVRegO6rv6a+eNmc9G/3aqoS
 yD4qnSZdWHZHYLE1K1A==
X-Authority-Analysis: v=2.4 cv=c/ibhx9l c=1 sm=1 tr=0 ts=69dd0e41 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=9zPADYYpdTKIp-S0na4A:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: 308jBMxDgdQJbtgs4ZkkEoGMtjlI9Xgp
X-Proofpoint-ORIG-GUID: 308jBMxDgdQJbtgs4ZkkEoGMtjlI9Xgp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604130153
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
	TAGGED_FROM(0.00)[bounces-34710-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[maharaja.kennadyrajan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 78B1D3EE19E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Both the error path in thermal registration and the normal thermal unregister
path performed the same hwmon device unregistration and pointer cleanup.
Consolidate this logic into a single helper to reduce code duplication and ensure
consistent cleanup across all paths. Add a helper to set up the hwmon registration
during thermal registration to keep symmetry with thermal cleanup.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

Signed-off-by: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/thermal.c | 83 +++++++++++++----------
 1 file changed, 47 insertions(+), 36 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/thermal.c b/drivers/net/wireless/ath/ath12k/thermal.c
index 4f76622e8117..6f70c11c1098 100644
--- a/drivers/net/wireless/ath/ath12k/thermal.c
+++ b/drivers/net/wireless/ath/ath12k/thermal.c
@@ -130,59 +130,70 @@ static struct attribute *ath12k_hwmon_attrs[] = {
 };
 ATTRIBUTE_GROUPS(ath12k_hwmon);
 
-int ath12k_thermal_register(struct ath12k_base *ab)
+static int ath12k_thermal_setup_radio(struct ath12k_base *ab, int i)
+{
+	struct ath12k *ar;
+	int ret;
+
+	ar = ab->pdevs[i].ar;
+	if (!ar)
+		return 0;
+
+	ar->thermal.hwmon_dev =
+		hwmon_device_register_with_groups(&ar->ah->hw->wiphy->dev,
+						  "ath12k_hwmon", ar,
+						  ath12k_hwmon_groups);
+	if (IS_ERR(ar->thermal.hwmon_dev)) {
+		ret = PTR_ERR(ar->thermal.hwmon_dev);
+		ar->thermal.hwmon_dev = NULL;
+		ath12k_err(ar->ab, "failed to register hwmon device: %d\n",
+			   ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void ath12k_thermal_cleanup_radio(struct ath12k_base *ab, int i)
 {
 	struct ath12k *ar;
-	int i, j, ret;
+
+	ar = ab->pdevs[i].ar;
+	if (!ar)
+		return;
+
+	hwmon_device_unregister(ar->thermal.hwmon_dev);
+	ar->thermal.hwmon_dev = NULL;
+}
+
+int ath12k_thermal_register(struct ath12k_base *ab)
+{
+	int i, ret;
 
 	if (!IS_REACHABLE(CONFIG_HWMON))
 		return 0;
 
 	for (i = 0; i < ab->num_radios; i++) {
-		ar = ab->pdevs[i].ar;
-		if (!ar)
-			continue;
-
-		ar->thermal.hwmon_dev =
-			hwmon_device_register_with_groups(&ar->ah->hw->wiphy->dev,
-							  "ath12k_hwmon", ar,
-							  ath12k_hwmon_groups);
-		if (IS_ERR(ar->thermal.hwmon_dev)) {
-			ret = PTR_ERR(ar->thermal.hwmon_dev);
-			ar->thermal.hwmon_dev = NULL;
-			ath12k_err(ar->ab, "failed to register hwmon device: %d\n",
-				   ret);
-			for (j = i - 1; j >= 0; j--) {
-				ar = ab->pdevs[j].ar;
-				if (!ar)
-					continue;
-
-				hwmon_device_unregister(ar->thermal.hwmon_dev);
-				ar->thermal.hwmon_dev = NULL;
-			}
-			return ret;
-		}
+		ret = ath12k_thermal_setup_radio(ab, i);
+		if (ret)
+			goto out;
 	}
 
 	return 0;
+out:
+	for (i--; i >= 0; i--)
+		ath12k_thermal_cleanup_radio(ab, i);
+
+	return ret;
 }
 
 void ath12k_thermal_unregister(struct ath12k_base *ab)
 {
-	struct ath12k *ar;
 	int i;
 
 	if (!IS_REACHABLE(CONFIG_HWMON))
 		return;
 
-	for (i = 0; i < ab->num_radios; i++) {
-		ar = ab->pdevs[i].ar;
-		if (!ar)
-			continue;
-
-		if (ar->thermal.hwmon_dev) {
-			hwmon_device_unregister(ar->thermal.hwmon_dev);
-			ar->thermal.hwmon_dev = NULL;
-		}
-	}
+	for (i = 0; i < ab->num_radios; i++)
+		ath12k_thermal_cleanup_radio(ab, i);
 }
-- 
2.34.1


