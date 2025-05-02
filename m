Return-Path: <linux-wireless+bounces-22364-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F76AA7C95
	for <lists+linux-wireless@lfdr.de>; Sat,  3 May 2025 01:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D19A4C6CFD
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 23:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39FE1F4725;
	Fri,  2 May 2025 23:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lBU97RPX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD5413D2B2
	for <linux-wireless@vger.kernel.org>; Fri,  2 May 2025 23:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746227019; cv=none; b=a0NahIJsrDuN06z2vet/T1LNaCYzeUCMYqjUryxSR1scIV5ShOl0nGTuX6weUq7+ESrfj6tBBPbNe07byqVJ/1Dmr+iDqR6BqbpdF3GLl55kOhL7DhZUtnDbFjsYPe68Mqin3+gmKJjTnwltND0tYywSHT5sSEKrnU6Uy3ReUbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746227019; c=relaxed/simple;
	bh=70QrMBejAtZSSYHJ/OckrhCLMH3OKqDtNcUHds1UhiQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YPSBgI6E7g0uPXaJfjkmNmKdxtuDZSJkapDL4217kAIDxZhjvUxau7hxRFuQ96Zj/AuZBNyjzAOUsV3iN5kf86ettVU31Jg+BfM2CETbbQt1s9QXQqiOI9TmOtBIUHnKIEuRzTgEja+4AvK6VMZTme42oXWW4d26PZH+D4XSAVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lBU97RPX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 542KBckX012028
	for <linux-wireless@vger.kernel.org>; Fri, 2 May 2025 23:03:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=ITNozfI5RkhFMbtdCDhndJtiQb2Tu+23G2H
	G9tUlBoA=; b=lBU97RPXxNzfKFgTtuHPH766vtk8q78AR/sv4wYfqhZKaNVUyJ9
	bkdj08UhTX5KWQONQJQq1WSk/8MOxG0ZgTX/+yOhRyMJg37eGsocIRAz/IHtwGlO
	SBZi+z6VrtboCFFc45JvUSqXOqAHbirBV8wBCe/vQNWvlISWz2fRzpsGC/rTLQa+
	+ZHVGIsTHg5lgcl5kXNDEcL4uEv7GFmhf0p0eTgHbK3QvX/5yTLy/K+zCBPSJbVP
	HjrN2jDM0dGoqLxcqhs84MMXe1sh5XTQhP+NtMqq9RCFjxH3o/QIzWRS6axpVU0Z
	gaWKdtfmr8Zfc8yLB+I7kAGPZFVIQxGnaJA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46b6ub1gs6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 02 May 2025 23:03:36 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-739515de999so2085271b3a.1
        for <linux-wireless@vger.kernel.org>; Fri, 02 May 2025 16:03:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746227015; x=1746831815;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ITNozfI5RkhFMbtdCDhndJtiQb2Tu+23G2HG9tUlBoA=;
        b=m4ZHqIlgyLK8ru5j4fC42gM2H4CtlDikF7ZAOPfyt9+xQBfK2hs3JuwinniQevcGSK
         5cps17inuJi+aQYwbVd8CDY0zw9nOc2WK8CFIeiJuQxhsxbVPrlG8ZUCr0Ys7xXrIx6Z
         q9Mpt2ILgNYuVEb+TpxqXKQL3RaifqTkJT/U0K6HWaVzXlRY5NJlzcC8ez2Ox4a9jIff
         qoi5z+J4CfvKnndQ6YBOqEogB6c5ZCfi1bQUZRnOGA5997jEkw5/JN+Ppm3dhrMzkwQE
         JXlFh9NiUvucpMlAItNXg1lvnR0x76BwaC1atZ53m0OfvPmslZVuNiXN6VYQ6ZsM4KRi
         /Dww==
X-Gm-Message-State: AOJu0YzS+ikSzzSIrFlqeRZ2hkhabc5SDg4WORVE/jclKMcUJvhlgjrd
	foxYcZ0L95t1D4KDLFuUBdWzuvi5Nbf6MsEBCcEW3oQ0chFmbnsqzB9Abr4gWvBcdolqrYosMor
	9sPfN4ZruWkxzB1/P3iwiAL43aKtySLAsoNiFbfQDsQa3fXif34rtKYG4PBOoCcV4rw==
X-Gm-Gg: ASbGncvoGJKuJ1LXgJ/eg3cZH3yeaWekqz0+XDT8Z/+L+giCKyXeXQhu1xx3v0eyC80
	ZtKKkgLPusPXsuSJ/rogMEX0LhBT8LOZYglBSiDj9WvadB3NV+VOJBB/FxQgTNSU+HNbAM/s2wf
	zWAPPD+YdgUL/8uZfK0YhwS/D9pSHx9bEC1fO4vyy6mCDNHoaVRvEaSNHDo3J0Ca7xoNvUgpLE7
	GDtIusuQM4KeDgpd9ZLLJjB0vYccTBBBRIsChcrrjgPDInsE1kYLbCAuxE+BoCJO229fYdkN7Ov
	EDPuQYHDbNUmg8CVap0ThZycxi6Ru5B45asPsZT1ncjTiHMXyxi4XDM8cFmc415V8XOb
X-Received: by 2002:a05:6300:668b:b0:1f5:5a0b:4768 with SMTP id adf61e73a8af0-20cded43531mr6975785637.21.1746227015157;
        Fri, 02 May 2025 16:03:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkmy8VQIBA/Z3wJ2zrXg44xjFIk9NFsJDt5RRn7dQchBKgcfsiNd1Qz0qvyfME1r21G6Z/Hg==
X-Received: by 2002:a05:6300:668b:b0:1f5:5a0b:4768 with SMTP id adf61e73a8af0-20cded43531mr6975744637.21.1746227014731;
        Fri, 02 May 2025 16:03:34 -0700 (PDT)
Received: from msinada-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74059020e2asm2160527b3a.111.2025.05.02.16.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 16:03:34 -0700 (PDT)
From: Muna Sinada <muna.sinada@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Karthik M <quic_karm@quicinc.com>,
        Muna Sinada <muna.sinada@oss.qualcomm.com>
Subject: [PATCH ath-next] wifi: ath12k: disable pdev for non supported country
Date: Fri,  2 May 2025 16:02:40 -0700
Message-Id: <20250502230240.3692678-1-muna.sinada@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: PSArcg70P14O-sVriffEa1VGXe_3D73e
X-Authority-Analysis: v=2.4 cv=KtlN2XWN c=1 sm=1 tr=0 ts=68154f48 cx=c_pps a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=GS2Ra1cEi1otGwMkaT0A:9 a=2VI0MkxyNR6bbpdq8BZq:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: PSArcg70P14O-sVriffEa1VGXe_3D73e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDE4OSBTYWx0ZWRfX2N15WfB2Lah4 uv5WrkZFLRdnkfevIDtgc8Nt5EytKqWThb/EjkrW8WOF1PhXfprO1UOArrO/XVebBTaLzHxySPC gRZh4WukrlmIb3VSBVsjWEH13cktgsiF0tRHdk/zbW/CLk8JK5VSdQ/8q66vM0JszrI+r/LPALn
 mAS3UBkDkHiAOjHKVUMmIFjrjdbPaaEZOF1KRUh90mdpGTa0dCUjxIo0kS6tx/IiCQrn/eHyVMe zo0WDQjXeugGjWJDpsLy7vZ8j77NIMlMyEfLWGJaAkikywNX5OydK23jr9Xk3bD8Ddi9awly4j4 4O2C14V7H7h+D81ai5GccNiSzgKQ1DXw890HQ/XkOxHmgtTQgYkVXRYJ4OSokJkkHCc2ZxwPY5V
 BvyyaF+7q+b26Z1rFSxC1uG7P6BZSsnSzhY6agZoNy0c2nn01E6tbM5fQMRZIXxdtvb/KKAA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-02_05,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 mlxscore=0 bulkscore=0 mlxlogscore=702 spamscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505020189

From: Karthik M <quic_karm@quicinc.com>

In MLO configuration, ath12k_mac_radio_start() iterates through all
the radios and makes the ar state 'ON'. Even though some bands are
not supported in certain countries, ath12k_reg_update_chan_list()
tries to update the channel list for all the active pdevs and ends
up in the warn_on for non-supported band.

To prevent this, disable the pdev when the num of channels in a band
for a particular country is zero.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthik M <quic_karm@quicinc.com>
Signed-off-by: Muna Sinada <muna.sinada@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 12 +++++++++++-
 drivers/net/wireless/ath/ath12k/reg.c |  7 +++++--
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 4dae941c9615..f731a5759ac3 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -7726,7 +7726,17 @@ static int ath12k_mac_start(struct ath12k *ar)
 
 	/* TODO: Do we need to enable ANI? */
 
-	ath12k_reg_update_chan_list(ar, false);
+	ret = ath12k_reg_update_chan_list(ar, false);
+
+	/* The ar state alone can be turned off for non supported country
+	 * without returning the error value. As we need to update the channel
+	 * for the next ar.
+	 */
+	if (ret) {
+		if (ret == -EINVAL)
+			ret = 0;
+		goto err;
+	}
 
 	ar->num_started_vdevs = 0;
 	ar->num_created_vdevs = 0;
diff --git a/drivers/net/wireless/ath/ath12k/reg.c b/drivers/net/wireless/ath/ath12k/reg.c
index 7048834e0d14..a6c9c670e91d 100644
--- a/drivers/net/wireless/ath/ath12k/reg.c
+++ b/drivers/net/wireless/ath/ath12k/reg.c
@@ -65,7 +65,7 @@ ath12k_reg_notifier(struct wiphy *wiphy, struct regulatory_request *request)
 
 		for_each_ar(ah, ar, i) {
 			ret = ath12k_reg_update_chan_list(ar, true);
-			if (ret) {
+			if (ret && ret != -EINVAL) {
 				ath12k_warn(ar->ab,
 					    "failed to update chan list for pdev %u, ret %d\n",
 					    i, ret);
@@ -181,8 +181,11 @@ int ath12k_reg_update_chan_list(struct ath12k *ar, bool wait)
 		}
 	}
 
-	if (WARN_ON(!num_channels))
+	if (!num_channels) {
+		ath12k_dbg(ar->ab, ATH12K_DBG_REG,
+			   "pdev is not supported for this country\n");
 		return -EINVAL;
+	}
 
 	arg = kzalloc(struct_size(arg, channel, num_channels), GFP_KERNEL);
 

base-commit: 885e5cbaa0ee3738fcd99167439459ede2cc102c
-- 
2.34.1


