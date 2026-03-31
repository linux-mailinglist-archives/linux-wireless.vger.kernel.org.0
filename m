Return-Path: <linux-wireless+bounces-34216-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLEFGwjby2lHMAYAu9opvQ
	(envelope-from <linux-wireless+bounces-34216-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 16:32:40 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5225636B025
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 16:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8DC363054A08
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 14:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC7C3FCB1B;
	Tue, 31 Mar 2026 14:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DmJbY5LT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TREYdA3C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3213FB059
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 14:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774967114; cv=none; b=Ii+J6mFOWaNlBGChsB+GjfcbqRlbvugo5FOjPWH3ni2Ic4ObVHnCxdkmr/7A1WXfLXgPjjO6l9/bxlNEoAdxOTPryrIiwUaSITl24JsFI1Joen6O0mKFehQ4hkv3V8Aw5ZwE5jDkYujy53fCLqFxEq56X0n9BcyDC6MJYyBtBdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774967114; c=relaxed/simple;
	bh=661do/qFbri6NrR4lDbff5uN/tWAIiQe3soC6sZbd1A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UON0+/p9BHRlVQQysX0sHjt6TSrOstHS6NUWSwcmgOrjGSH9H/+TJo8cBwDTVPS+5LNucm89aE8xYSRkvyde39H1wbK3sFjbSmJg/Rwz/DRvE8v/sY4EjPzD4DVtL959kogfwMH7tAziUq+XpMmzMEn0t5y0251seToUokP9CCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DmJbY5LT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TREYdA3C; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62VEDYJq2761341
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 14:25:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=EXiHakN9Z7R
	Gr+m11/kq2CxIF3O6rm9l4+o6TN0VXjw=; b=DmJbY5LTMQ7fz5QiD7YPotLi6PF
	DdUCbY1V96qd066yNeCP+GAGqJ+x8YIzXpo6C9JU2audWzeFh4wvlEcN0hR8YNDX
	PP6Umy245LkVNXrIXiU8oT/zEUhOWngc1zjiAZuGseLn/l4H4qZcNk9BHnf5mVEC
	HTDJOlSKUZ6oPqC1opeoX9l2hVmOkKeINcPmwFo3YOJSMkUtDu6tOTw2VxU5mB1S
	0pmTHKfz0crJNNnO+Kg4ZbFGaJi36shIv2oAXOhLJQ/Y/UleIMe6RViMp2j5/nFS
	Rlq43sjoPcu5kRds5ZlmRiehKQqFFmreooXDvwozVGCsiQSUMs3yaF72TuQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8b931ep0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 14:25:12 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b24611696eso22549985ad.3
        for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 07:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774967112; x=1775571912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EXiHakN9Z7RGr+m11/kq2CxIF3O6rm9l4+o6TN0VXjw=;
        b=TREYdA3C8Yc9rIqVuGkpqWv+ypoEt+2rky63m3kjbwIZOfQaA01rqNzIlVoapRokA0
         XNLxHAzagzXlS4qbqY+b4JBwyYYtFiDlVhCEw7GaHBsAQLXCOgiA6090S7F84W+dvRig
         pxk3jLJhvlIXrPtDBj08Ynm1LPQTnOQQQus6nO1v3BVwUrP5KTdgslueewO3sWGrcLcd
         jjBfKwbUVuqZiLz30fjcu3k9RWDViowISCHeIZGuf3fRQjp7r5Fg4hSlEBujsPPd42fG
         YP2my99jSwROfdTT0kkBaOlZ9wrcwd/KF2F6iXpHgS0Aky7uAodhhDZI6/BpkV7AgHjz
         Zz8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774967112; x=1775571912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EXiHakN9Z7RGr+m11/kq2CxIF3O6rm9l4+o6TN0VXjw=;
        b=Q582L8DT3h2iA38N5NEa7KlDTFMPSk4d6bJlft8agqlTZbY8eabBaLEcnQ8dAPZwF+
         qmdDN4uqxs3rRUNhKHfeehY0Fv9X59RlNxyxzuTX2w09vTe1F6cmjff8ObBe66g1B1H2
         Yea04kCnDkML2cbB91c6bMkWjWrw3fNi0zw0RbP0p1Sea7jPgEMH/AhydI+hGytyAbiq
         BZ+9sTs1cUbAHaMFTy3axVzxqPh7D3k3cIpYvSzWxz68MTQN0ed+xtydJE5d89YmFRF7
         x8e7LU2IqnSHWLJXKHnZPbkFfEgTOD7lkJIlOQzTSC+EQlIkc+6CwQnIPwx2GhWjvfqF
         H20w==
X-Gm-Message-State: AOJu0YzBHbgaw7VbyY84OK2lWUD8icqHupppvtt/kDWkEc0p+nCwJixs
	XJGHV5KZTYEoofaBN1X7encov85CzrAbUtmIQya5lJ21WQxt26LJvD0Z8FeReyK2BCGsGBzA0Zj
	1ZEp9E4yGImHb5aG19a9UM+GdAlELePuhwimwZAEqJSfZvd/LAxaPNzyh7VZp/26a/lx2jQ==
X-Gm-Gg: ATEYQzzg1Q0Z5fwFU7Se1HL554hnIhGsHb7InwD6s39Ctic0pulZY6AepxUfM+CDERn
	8klI9FCwa4b8iNBhmPqmvWVf+w3eFidTeYQ5t9Az4e9uKa/gn5jc6jL2YbbefwSlRA/cvcXgkrC
	y4mTUXDKnpGRIVoOKVOm5vI4PNPp36dlAI4pNFWH3JbmaaeMY4nDIrAkjFiwmhJLkaGirB/qdFa
	sBCNkXepjXDX8YyCQM0xAccz1Ox9Hd47rkH3EYaaCPHo1kBBhd4QdvV1sAa3bObLClvAfFUlKxb
	55kySeFQzKmFykAaLud8c9EGRAOYw1tP5JG4w+qu9letbGWQtMp6D+pR0Lak/qJyI0woItEubGm
	lgg4PXsbSEYub7iTswZ5t6sCcXYao0lsTVXAq0cM3v/W9L8QwPPITjMLF0HYVaXyOwuapuHQ1Zk
	QsotNkC3c561vPNelEolCQGw/lpfuf1aqIao1voJqqe5M6HMVonDU=
X-Received: by 2002:a17:903:2405:b0:2b0:afbe:4e14 with SMTP id d9443c01a7336-2b0cdcf7f99mr161106935ad.40.1774967111864;
        Tue, 31 Mar 2026 07:25:11 -0700 (PDT)
X-Received: by 2002:a17:903:2405:b0:2b0:afbe:4e14 with SMTP id d9443c01a7336-2b0cdcf7f99mr161106495ad.40.1774967111332;
        Tue, 31 Mar 2026 07:25:11 -0700 (PDT)
Received: from hu-mkenna-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24276689asm112030225ad.38.2026.03.31.07.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 07:25:11 -0700 (PDT)
From: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Subject: [PATCH ath-next 4/5] wifi: ath12k: reorder group start/stop for safe thermal sysfs cleanup
Date: Tue, 31 Mar 2026 19:54:45 +0530
Message-Id: <20260331142446.2951809-5-maharaja.kennadyrajan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260331142446.2951809-1-maharaja.kennadyrajan@oss.qualcomm.com>
References: <20260331142446.2951809-1-maharaja.kennadyrajan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDEzOSBTYWx0ZWRfX0gDK0c9TaKst
 EWigvwRB4U4BsFXIKiEhQxtHd3YQYpdBr/jjTfith84mq+sgIVvH8PrijapGwYgsbYMSuTEIhmY
 O3XEDCF/CjM13YTJPg81FlchUtU/sKw1FPFqOPsbJ0KLqNRGmfzbyLiROcx+r0D/MdFsuIHA7UT
 uCohKb6tGblmy1WvU+YAIxvF/gdRWrdcK33k5rR3cwj4aH8YxUgOWJlBoXgX/zeFNy69/j38DZt
 iLluQDDTMgzzfDQzUMPy7YRmh6WNDSm0e1JAmyUstBqWpNHPpUE8BvpF+PCpz54NzpDYla8Y3M4
 tChsRpkV4k/j80c1yfCtv++uqBiWIrxySHN4l2rj4iYZEnGcKKDWuxd6VmSZ7N+gsV8I4ERc3o3
 kRaG12Y9IseZFd6dOIDkbQKzlm05Gd5GtEenBCX4upB/x40NpHS0BeqtkxzWDRU6d8SeEJqwkLj
 GXT7aPkoaBIvSjkexZQ==
X-Proofpoint-ORIG-GUID: U8ZK3-tgWIXtQ7cmnqfV3B8BUoRcjHxp
X-Proofpoint-GUID: U8ZK3-tgWIXtQ7cmnqfV3B8BUoRcjHxp
X-Authority-Analysis: v=2.4 cv=NLjYOk6g c=1 sm=1 tr=0 ts=69cbd948 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=2ln3ysbViG1LyOe46xYA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_03,2026-03-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603310139
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34216-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[maharaja.kennadyrajan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5225636B025
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
index c31c47fb5a73..d21db889794a 100644
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


