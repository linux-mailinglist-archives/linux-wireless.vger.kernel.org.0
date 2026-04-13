Return-Path: <linux-wireless+bounces-34711-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CpuBbQO3WkOZQkAu9opvQ
	(envelope-from <linux-wireless+bounces-34711-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 17:41:40 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 868F63EE1A5
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 17:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 079A1301E7CA
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 15:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7D23CE4A5;
	Mon, 13 Apr 2026 15:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PH1kTrza";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PqRbGVLB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B3F3E1CF4
	for <linux-wireless@vger.kernel.org>; Mon, 13 Apr 2026 15:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776094790; cv=none; b=GaLMniarGukN14chtZS+ccl8w1pA+Ve+NVZK5rtoRsB4hr+QREwrTrVJMcLQdO/orpHy5qc8IicIHOlAOVXj2m2j129c4cN8JQnPqLemRu54uKfcRvIESNQ83pbrVnW3LLkVxKgnBH3P/MTwzE0A4u+NdEJNLABOnm6C/EpypYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776094790; c=relaxed/simple;
	bh=xqvAnNHV16Mq3WDqAi9RzskNz+yjuu9aGGAdyOBtffw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DAgWcUcIAa5/bhtNnu1jnnO4SMBKFZpLvCC4Xd0ixkBD54THRzn1XGLONP/EIS+ifHDTXw4hh1KAQUdNMfcQSxA7WJzuF3zBCPcsg2qJuUGRPdf2xj/5j8eRrbaJsebLYkmpXFZka3ZlGR2qbAagc/S0unDmuTDnre2bgwkNRSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PH1kTrza; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PqRbGVLB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63DE7YNU117582
	for <linux-wireless@vger.kernel.org>; Mon, 13 Apr 2026 15:39:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=K1BnQnX86bc
	OruLMnu2cKRSxiljoYASvR8mTo9FcWZs=; b=PH1kTrzauPJ+uJkxbK7uKRy0X1H
	SvtSTtbSwc4t4L8DgTxVeJJ0a3h7FNu+Vz0xyFm5u/tz255L413zfRVTIMVFQhUn
	KnIFG5hX3eyVbj+utfQOorIkVwheHMFck9f3nqKCYFGt78FYjr+3DfUry77n44i0
	mn7G1SBX3F/yGyyPkrX4tNtINJA4msM1A5KJgW+C4HuVCq1F9BzhFoF3M+UHP03W
	EdcYKt6xHQh/GJHLW2FOX0NUnPlNULXxFyavCugf1abipLGQnJn72pTuZB9OhSBl
	D+mQydTGvcgl4sICJ+Dn3NzWzBXOGH/CVTwdgEhxkwI3wFhK1LIEtz9mCTg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfewkx43n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Apr 2026 15:39:47 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35fb3bebb30so2245395a91.3
        for <linux-wireless@vger.kernel.org>; Mon, 13 Apr 2026 08:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776094787; x=1776699587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K1BnQnX86bcOruLMnu2cKRSxiljoYASvR8mTo9FcWZs=;
        b=PqRbGVLBH8W50NpM2I4Vg9jnQG2OJ5IRDAm9xYXVud3nZsKywbLPzy6jRniPYRccE8
         KEp4XKH5e45PA6jLSXJsrI5+qSdB2NwXnlAntoFeQByJvNXHAWanOtY42AVD3a8kDmC6
         3xB1aq9n3x31lBOZ83IZEditewD93QRO3nAOnjib4hALV6uI4wC2D/ZelgVnTm9GaolM
         XINXK8qUIYkUlpkcljlY17dhtysWEqL4Z/5xN1uEP2AJ0z+56rhBGTZyTzOiYys2J7X3
         kthAOmgx7jWt3G7S0QK4nqXOEiqndfvIgsDCD/NAPNX+J0K6UiuRraeF5FJswR50S7/q
         Vnxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776094787; x=1776699587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K1BnQnX86bcOruLMnu2cKRSxiljoYASvR8mTo9FcWZs=;
        b=RaRxPek4ZWxMvGNmGGJr5xWOicW7fv9FMXq0SkzqvTnLlLh1M2Oab7VPVCyjWf2Fcq
         t352C7BZQ4K97tXQtmaio+rW9uYo9r7H59NUpVvTvzyLiHPs87POVzu8fPSKVJxi2Xlo
         /eAoh5riUyFbuFhq5n6k3xA1sdeBqxP61hDMiRQmPAVVd3ZFWStLpFtYCfVcwVksXHyE
         lePFNcnijPqj0Gt/ePEyJXPHGWe7YdDjnXqnPFso2U1yUO8730azVGTR/wyx8Vfs7Rqq
         oVr9ySM0FCSK2nChDRFFSOJRncCpQWI1g8UeRjhFRWFG6iPB+q0z8d7G/FbDGkNfC0ZK
         yvUA==
X-Gm-Message-State: AOJu0Yyr6CU7PdF3HXuHjS4bpxXaduNWbGppCuWi11n6Gr0lFWOUWd+I
	YyuYh2qGki1dh27e+lXantiEGqwhrTYES+8YLlRKv5jw8yWxUT9W1kRoUoJBmufBJRowjl0LV0d
	q4MXO276cXa2dMdIFgYJRCIgaLHAcRQaRAK12M6TGnQ5jTic1QxcFZBhGEUgd4T+DkXjOocSiLG
	WJ6Q==
X-Gm-Gg: AeBDievPtO3sc3cS8s2jaB9i2oBQXtEQKrAEjtVtU4fG7FvctQ2BjkbekCFwNRXkImF
	ZyC1ZT48dw4n4WkSSC4e8AzScLCAuAodRNhDwBypPbTZxrW5GiCNh7Anz0y0ACqGnZ254bkdlBv
	rzUDyUDUKFX8of/WWH3ibpKBGutiuIuUVxwLNc0IBY057q3wQDcQc78WS8l9kAvZqhqzt/9ay40
	zi5z34ESMg0mhJ5zHiCe01bo0GCcq/wFB/4hPTm1W5F9PJlJzEwOx1ux8JO18dZSXOnmnn4E5cu
	n7TD/pSasFZ2yKTDeTJzLI7e/d6d/9QmBLMzf7l0U2p4D2dGdMlXFL1hh9q41xqv2jhnN8OngmC
	0mEZxtnUJN66I9+jmxccJvMJGkJOemUVXc+0iuIVIpCOHwxjclMyxiUhG7WbdN5P5nhmcLxZtw+
	y/AQZMH0el92uw1fPnQVrLk6AfbKBiWCvna/pXsHPyttz1IokKoik=
X-Received: by 2002:a17:90b:2892:b0:35f:bae8:3531 with SMTP id 98e67ed59e1d1-35fbae84a3amr3132584a91.25.1776094786498;
        Mon, 13 Apr 2026 08:39:46 -0700 (PDT)
X-Received: by 2002:a17:90b:2892:b0:35f:bae8:3531 with SMTP id 98e67ed59e1d1-35fbae84a3amr3132566a91.25.1776094785974;
        Mon, 13 Apr 2026 08:39:45 -0700 (PDT)
Received: from hu-mkenna-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e411ff4e1sm13000123a91.3.2026.04.13.08.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 08:39:45 -0700 (PDT)
From: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Subject: [PATCH ath-next v2 4/5] wifi: ath12k: reorder group start/stop for safe thermal sysfs cleanup
Date: Mon, 13 Apr 2026 21:08:39 +0530
Message-Id: <20260413153840.1969931-5-maharaja.kennadyrajan@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=bcFbluPB c=1 sm=1 tr=0 ts=69dd0e43 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=2ln3ysbViG1LyOe46xYA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDE1MyBTYWx0ZWRfX1kCGK3ho0S6y
 HHfulsYgLh5ACTrf8aQQOjvJOIN3wZB/xQr4NZ/bcZiZS3UWFwP5yxa9sSqgT/81IszDG0uigu8
 8vT0ghikdy6beKA3FYatELmkLXsdzwTi3NMnje1wFiRACcl4WRcL550O43CsKaVFF8HowRMMb/G
 jiaLagQ7WY4i9ta2yMDBK8JKU883m3xFCgmswFk6cwTLsGVZebLLHQkZsXHBfHac4M+H2i8iQTk
 2IjPIomYcsz3CIQhWyqZbwtrtNZfCDo6nvNi37+8P5BLBDtTpri/N+W5YBrNfTkVN+rFH2jfjaQ
 cm227HEEYw7eZSwdqyHZWWvGH0tRQ/n8/9WwOwnEPe3qILraOvRwORjuGG2VROWBUJex9zlQHwY
 a3kO/6FWVJNxCFyh7e3pbV53fi5sU0gGE3dwGHFns61OiGa65j7w6EcLueQtSfbTQS2UQIINYJa
 Xx1+VUzEtUprgUjAxgQ==
X-Proofpoint-ORIG-GUID: HSskJbaHDO_rKdbGsFQvWWA_X5VHWRAr
X-Proofpoint-GUID: HSskJbaHDO_rKdbGsFQvWWA_X5VHWRAr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604130153
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
	TAGGED_FROM(0.00)[bounces-34711-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 868F63EE1A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A later change adds thermal cooling device sysfs under the wiphy device kobject.
With the current teardown order, MAC/wiphy are unregistered before per-device
cleanup, so any subsequent thermal sysfs removal would run after the wiphy kobject
is gone. That ordering is asymmetric with setup and would risk kernfs issues during
removal.

This change also adjusts the position of ath12k_mac_mlo_teardown(). Previously
it ran before per-device cleanup/MAC unregister. MLO teardown issues WMI to teardown
multi-link state and is part of the MAC teardown sequence. Placing it alongside
MAC unregister (after per-device cleanup) preserves setup/teardown symmetry and
avoids racing with remaining netdev/wiphy state.

Reorder hw_group_stop() so per-device cleanup (including thermal/hwmon sysfs
removal) runs while the wiphy still exists. After per-device cleanup completes,
unregister the MAC (dropping wiphys), run ath12k_mac_mlo_teardown(), and finally
destroy the MAC. This mirrors the setup sequence and keeps sysfs cleanup safe
when introduced in a later patch.

To keep start/stop symmetry, add ath12k_core_device_setup() to encapsulate the
per-device bring-up steps (pdev create, IRQ enable, rfkill config) that were
previously open-coded in hw_group_start(). Use this helper in hw_group_start()
to match the existing per-device cleanup helper used by hw_group_stop().

Note that set_bit(ATH12K_FLAG_REGISTERED, &ab->dev_flags) is now executed outside
the ab->core_lock critical section. The core_lock has not provided protection for
the REGISTERED flag, readers do not rely on core_lock for this bit, and the flag
is only toggled in the serialized group start/stop path using atomic bitops.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1

Signed-off-by: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 50 +++++++++++++++-----------
 1 file changed, 29 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index e8137144fd1f..1a9866061f82 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1006,6 +1006,27 @@ static void ath12k_core_device_cleanup(struct ath12k_base *ab)
 	mutex_unlock(&ab->core_lock);
 }
 
+static int ath12k_core_device_setup(struct ath12k_base *ab)
+{
+	int ret;
+
+	guard(mutex)(&ab->core_lock);
+
+	ret = ath12k_core_pdev_create(ab);
+	if (ret) {
+		ath12k_err(ab, "failed to create pdev core %d\n", ret);
+		return ret;
+	}
+
+	ath12k_hif_irq_enable(ab);
+
+	ret = ath12k_core_rfkill_config(ab);
+	if (ret && ret != -EOPNOTSUPP)
+		return ret;
+
+	return 0;
+}
+
 static void ath12k_core_hw_group_stop(struct ath12k_hw_group *ag)
 {
 	struct ath12k_base *ab;
@@ -1015,10 +1036,6 @@ static void ath12k_core_hw_group_stop(struct ath12k_hw_group *ag)
 
 	clear_bit(ATH12K_GROUP_FLAG_REGISTERED, &ag->flags);
 
-	ath12k_mac_unregister(ag);
-
-	ath12k_mac_mlo_teardown(ag);
-
 	for (i = ag->num_devices - 1; i >= 0; i--) {
 		ab = ag->ab[i];
 		if (!ab)
@@ -1029,6 +1046,12 @@ static void ath12k_core_hw_group_stop(struct ath12k_hw_group *ag)
 		ath12k_core_device_cleanup(ab);
 	}
 
+	/* Unregister MAC (drops wiphys) only after per-device cleanup */
+	ath12k_mac_unregister(ag);
+
+	/* Teardown MLO state after MAC unregister for symmetry */
+	ath12k_mac_mlo_teardown(ag);
+
 	ath12k_mac_destroy(ag);
 }
 
@@ -1165,26 +1188,11 @@ static int ath12k_core_hw_group_start(struct ath12k_hw_group *ag)
 		if (!ab)
 			continue;
 
-		mutex_lock(&ab->core_lock);
-
 		set_bit(ATH12K_FLAG_REGISTERED, &ab->dev_flags);
 
-		ret = ath12k_core_pdev_create(ab);
-		if (ret) {
-			ath12k_err(ab, "failed to create pdev core %d\n", ret);
-			mutex_unlock(&ab->core_lock);
-			goto err;
-		}
-
-		ath12k_hif_irq_enable(ab);
-
-		ret = ath12k_core_rfkill_config(ab);
-		if (ret && ret != -EOPNOTSUPP) {
-			mutex_unlock(&ab->core_lock);
+		ret = ath12k_core_device_setup(ab);
+		if (ret)
 			goto err;
-		}
-
-		mutex_unlock(&ab->core_lock);
 	}
 
 	return 0;
-- 
2.34.1


