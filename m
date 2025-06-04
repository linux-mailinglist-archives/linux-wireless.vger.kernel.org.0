Return-Path: <linux-wireless+bounces-23673-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 785A6ACD793
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 07:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DD023A7468
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 05:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6EA1CCB40;
	Wed,  4 Jun 2025 05:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QSU/0jch"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61C12581
	for <linux-wireless@vger.kernel.org>; Wed,  4 Jun 2025 05:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749016391; cv=none; b=GQfoAIlyKWHsJTxPz7WCiJ+ze8Q1SZpJEF1RrCgA7vsU5H+yIFqyJwgcjDMHSjstXts3CyPpso5IPxHh5Da6AuKEDVbhWELzGKdUd2dWovU97fTjeNoNGxg7x62Vcwc1/BtWLL8yNv1rjHire9gHX9hqE/ezL6FyietIG0lPB38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749016391; c=relaxed/simple;
	bh=tzlv4oylmNO8aJYZeRq6x4+sQ62yIGkI6pIDgXS2aLY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pq/tH6Exe8es/oKUjSgbs789ANrZPK17cNs+1Dor9oktGEiw97sX4FyJLJ03nwX+5BNOqnzB1ndMf/PixmNwNdlabazV1DUdZSfa7I/zgnoAZWWxItuGzKawHKqZ317kd+LCcHcqlmSMzhIR92AQa5JAnWLpjh8nR0/uLDcSCF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QSU/0jch; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 553KkbCH027442
	for <linux-wireless@vger.kernel.org>; Wed, 4 Jun 2025 05:53:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=6mPyPqOohXXvTddm3xF8dctlb/vnPecy4zR
	eWJway9E=; b=QSU/0jchxWJZ9JtRr65e9TuGTWO35kEehGwyHVeGAeIF8dOfyxY
	9IqDvm+3UwxgooNA/Lsc9C8qZ653XtzwynxC8v1Q2b6dLpob7rV/4qm4EAK1wlKb
	DrEqbmgErzFTCFswOZVYYczr1JeW1mGk7oPgT9pxxWXVIGUMon8jUBZpwvjbUmAQ
	2BOPwyXT9Q+0xJM1rjP0TwjLpyq+EauBvQBtwOov80klwXcn/zvGQXrAJEQPBWMn
	LeYe4FOoB+6vde8Mbd8M76+K6QMIVZnyHaIE/W6uycWdxwjx41fweDA7QrvIfm5C
	pVAV5FyA3amtP7csrcfodvyRNweJ6Kvc/fg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g8t50f6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 04 Jun 2025 05:53:08 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-74292762324so5083108b3a.0
        for <linux-wireless@vger.kernel.org>; Tue, 03 Jun 2025 22:53:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749016387; x=1749621187;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6mPyPqOohXXvTddm3xF8dctlb/vnPecy4zReWJway9E=;
        b=W6waKBBju6+GNTjsvJdJ2mvImLoatboAHkvzb26Qce5q51Mx810Jv1Bqrnmb9A3Fpw
         mbtO+jJAGDF6HRMc4qZvSeDJo4cG01MWDpYeoemHIqT3eKvcHa5JOELMx9QAsoyuaghr
         aKLeFCu5QT9DXrT0NLpkeA8DyB3TV7JtQBDtgf30vWPkS0Y3eusSqCBO67S1UNfGtbiV
         xfDqup5djahW4n4TxmnDpisQm2i/oZGiu/0CeOZMF4LCUNgTdTXLsCcz51seF4MZ+iYp
         peLHF4dgwwHFC0e69vgfVfk+qRO9WACf35Y/8RvzYOpamGUVcoxHQWvnoqE5bO/ExCDE
         ZsCg==
X-Forwarded-Encrypted: i=1; AJvYcCW87BaKV2DnT6PRiSiEDZ443j0fBt38TI+y0HJ7yd7R6MT4cJIugdDqPnJupEXsB4X0BlyawESG4EbqNPrbmQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8CXdswUqOAMsEnNVLD7uzqrKkNgjvxWEzUPZ9VmFXhUN71WPO
	huAsZHJm2paaGe6deTixlRBaHyZOS0ABq2Q0TgQ3nC5uoyb02zIj4eQuYx8jUB00RHApYykWlLb
	bR4KdNuWFGZoBye+GHcX222sSb5Whr71kd1fgvztMYNkJV+XYXcMjPCbbgy0OHtDQnCJ/MA==
X-Gm-Gg: ASbGncuHeMgHImGcN3NEh4fFH5AOu+AGITIa295BsS4rtPZEoL7zFsZ2Y/vemwF8EM9
	a/Wr2umKXjY5DbP3MXt2t5VZYsA0QTgQ9B2BkfefkPh35HwbBkeLLowZhqeCSK71dtdQ7fFzH8f
	ywfTyi+Vb6kIKekASAE/gsKSK7Bbi3EqqtH4K3gDIWz8sCiyZtRZ8DtHFH8W9sRa6wI0MobGS+R
	038yNJbPfvpbO+9yKys4l9ANya9HFgYkviayBj+pBAndcbKXcE8dqtPJLgyEIEQWGOh8S1eNl+3
	qreCo6M7C79q/9Er0lIarksLddHVRMf/6zz9oNUO7autFwMG46lMendqXpd6j4u4doU53sk=
X-Received: by 2002:a05:6a00:b93:b0:73e:30af:f479 with SMTP id d2e1a72fcca58-7480b4b3643mr2310628b3a.19.1749016387484;
        Tue, 03 Jun 2025 22:53:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSnPzCsfA2iQIrtlqFTnD1joMbqRjSXjSD1ZpPYgu1ZIxTqFBm47Nxh1QE+SXu2zjtHXscYw==
X-Received: by 2002:a05:6a00:b93:b0:73e:30af:f479 with SMTP id d2e1a72fcca58-7480b4b3643mr2310609b3a.19.1749016387142;
        Tue, 03 Jun 2025 22:53:07 -0700 (PDT)
Received: from Z2-SFF-G9-MQ.ap.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afff725asm10702500b3a.172.2025.06.03.22.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 22:53:06 -0700 (PDT)
From: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
To: jjohnson@kernel.org
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Subject: [PATCH ath-next] wifi: ath12k: fix uaf in ath12k_core_init()
Date: Wed,  4 Jun 2025 13:52:50 +0800
Message-Id: <20250604055250.1228501-1-miaoqing.pan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=eJQTjGp1 c=1 sm=1 tr=0 ts=683fdf44 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=TzEngFNX8HBHNH07LrEA:9
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: KXypbJXizAaZ0G3GpYy_cpYzyDs7yHeo
X-Proofpoint-GUID: KXypbJXizAaZ0G3GpYy_cpYzyDs7yHeo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDA0NyBTYWx0ZWRfX1zZY+MedmcOc
 Aumyxh1aNUH2vhPQn+j/8KYmESZQ6MY6DzljYmL+PWvZF5BYslo4hqQXJUK9QrZybOq3mVIAyrF
 LgHnmx829iDoGZPKm6XncGdZ+3LHbihw9xtd+7gTDP2ipUR4cTAnnOuUld8ZrYCww4uSIhyMwKP
 F6vZ4xfjqEfcq8S4VuSBQai+d84T2T0Z3ikGf0ceWDNJyZGVTLWCHUgK3Aos1t0q29E5MLlnWqX
 3qX/kg0i+2LjQwvBJSwtWac01nZdMaMgJpvzsbgHRlZTRDbb0uX/0tNneylm4HzkzDyH0ELBdf4
 ClZSenqYr4Tk8LPb/BQg+oc/EtG+uhEVGtw3c5yoK0h8ytYcybOtliWBhTlCKm3oDIME9kk2PtG
 vh3ikEhQj5/DlZkNhe+N7APJwsp87fe/JaZLMuXzmexLTmKiPJANU9GuYj27A5DSWuexgNfY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_01,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 mlxlogscore=999 impostorscore=0 spamscore=0
 phishscore=0 mlxscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506040047

When the execution of ath12k_core_hw_group_assign() or
ath12k_core_hw_group_create() fails, the registered notifier chain is not
unregistered properly. Its memory is freed after rmmod, which may trigger
to a use-after-free (UAF) issue if there is a subsequent access to this
notifier chain.

Fixes the issue by calling ath12k_core_panic_notifier_unregister() in
failure cases.

Call trace:
 notifier_chain_register+0x4c/0x1f0 (P)
 atomic_notifier_chain_register+0x38/0x68
 ath12k_core_init+0x50/0x4e8 [ath12k]
 ath12k_pci_probe+0x5f8/0xc28 [ath12k]
 pci_device_probe+0xbc/0x1a8
 really_probe+0xc8/0x3a0
 __driver_probe_device+0x84/0x1b0
 driver_probe_device+0x44/0x130
 __driver_attach+0xcc/0x208
 bus_for_each_dev+0x84/0x100
 driver_attach+0x2c/0x40
 bus_add_driver+0x130/0x260
 driver_register+0x70/0x138
 __pci_register_driver+0x68/0x80
 ath12k_pci_init+0x30/0x68 [ath12k]
 ath12k_init+0x28/0x78 [ath12k]

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Fixes: 6f245ea0ec6c ("wifi: ath12k: introduce device group abstraction")
Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 31d851d8e688..ebc0560d40e3 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -2129,7 +2129,8 @@ int ath12k_core_init(struct ath12k_base *ab)
 	if (!ag) {
 		mutex_unlock(&ath12k_hw_group_mutex);
 		ath12k_warn(ab, "unable to get hw group\n");
-		return -ENODEV;
+		ret = -ENODEV;
+		goto err_unregister_notifier;
 	}
 
 	mutex_unlock(&ath12k_hw_group_mutex);
@@ -2144,7 +2145,7 @@ int ath12k_core_init(struct ath12k_base *ab)
 		if (ret) {
 			mutex_unlock(&ag->mutex);
 			ath12k_warn(ab, "unable to create hw group\n");
-			goto err;
+			goto err_destroy_hw_group;
 		}
 	}
 
@@ -2152,9 +2153,12 @@ int ath12k_core_init(struct ath12k_base *ab)
 
 	return 0;
 
-err:
+err_destroy_hw_group:
 	ath12k_core_hw_group_destroy(ab->ag);
 	ath12k_core_hw_group_unassign(ab);
+err_unregister_notifier:
+	ath12k_core_panic_notifier_unregister(ab);
+
 	return ret;
 }
 

base-commit: c3910de7bab78afbc106206aed5ec8e79458fbee
-- 
2.34.1


