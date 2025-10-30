Return-Path: <linux-wireless+bounces-28393-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7ABC1E18E
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Oct 2025 03:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55522404A47
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Oct 2025 02:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526601F2382;
	Thu, 30 Oct 2025 02:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oGg2nbrr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iFDFP1vD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454CA2E0405
	for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 02:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761790147; cv=none; b=g51Pb7seoxj4Eo2cTc+hay5iJwg9pVTJY9f5Po4VAd0ShTpq+PaYETWqoiNpA0nBP0weLeVHS/j/gh8qaIU+y0BES8LqqRN9RrNknrQcRLBXDpRWmnJfcxwl+miZ8waRBzwrwbTAZEHPAD0aJCfer9ZivbFAKA4tRDw5/Z42KEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761790147; c=relaxed/simple;
	bh=IeITerO2R5IhLVecLW3Ka6LOgQpzsxCEdk8JCyjPBoU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kTuYODbsdvZledSb6CEzvj8opqnvTab4TRDt+bKaFpcLH2WzWYGuV1QO9EkJVnheDoLMITMrE2HmoUSxA5ZXsgvhn0ABdG5cHxwsx50hK3phYitQDnrFI0CIzm55nRoliI2n3z487QXvBD55DcpeIxsegNLtRJZEmQO2wT00VSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oGg2nbrr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iFDFP1vD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59TLKqL41693371
	for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 02:09:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=txTiryi9IhAHzPUCcDKkjb
	gc4ZJqQxM5lfYU1LQT8C0=; b=oGg2nbrr49gkQTFfeAPoPwOXJNgKD9NsS9qu/e
	FRNv0T8tWdJNhpPjtzpxR0Q5i3/GI1ztYXE4NOaLgLc8HNDMPy6vq1+SsdLTzASb
	TP55mZKvoQutMOE7HuGvzPOuKLbo/DvE2ks25uGwBDWWHiH5FP0NiXWGpRuEtJIg
	A/p82MRMgIgTKYogtVPnErfsdKG9WwXM+T52Ktt3n6RiP79Ox8XGOdoKf7KWyo5o
	icGWYX9GrrHPzAYRb/dK0x+DTjFPVYxLAO/t7qYFBLPPaRdVT3eJ9nQMLYhVQKu5
	AsUNZzR3ZcJrcH4i4shsPoSAq1sudTdCDuLx6hWwQ85DUlAA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3trv0ph4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 02:09:02 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-78105c10afdso576963b3a.1
        for <linux-wireless@vger.kernel.org>; Wed, 29 Oct 2025 19:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761790141; x=1762394941; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=txTiryi9IhAHzPUCcDKkjbgc4ZJqQxM5lfYU1LQT8C0=;
        b=iFDFP1vDlC51en2haIerFRacfMWMHB7kFcU+kxgzk7zBQPTAPkloiSnnh85QGpiMce
         rAJn5w3+vaWCqsZvJr/NLyodXnDOd+5Y16BQhLguBy/lW0tYD6SJtQNd5s0wFbNO23v2
         bhhoTVjV79PIlpbAdiFTKCY9y2IhM/YvBTPKUcJkbDbX3/6fYXv/LT2sW1VeANvxA9Ok
         bwOWZNCHIAdauvoyDfjyUyg4tCIRN16UYhKsv+OlCixp6PdUOiTvo1+A7IrHUlCjTi3D
         hVSKSeYgBnH7r8Vr4TCbRavdzvMBtjxpDR9mmmGfOJaLAhtwh238nY9yxGPwUigLsfCK
         NWsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761790141; x=1762394941;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=txTiryi9IhAHzPUCcDKkjbgc4ZJqQxM5lfYU1LQT8C0=;
        b=KC0cjpjova80EQl8LrLpIaPnkJXY/tWeU+bh/qbsQ8VADLvPtxjoF1GDG12GiiUdFB
         gcrcOz9967APpgu3abI71MQQ6KlWndjMrVTRJjUh7+Gbr9J3EPDuv/s/AjQ1KYfITXNt
         jvC/MKSnKrSYoqMSm59QepqcNOfFZ9yS6G+xfd9P1b8gyp4isypx3UElFmja2CXtzkZJ
         ggb218fwVqI6vFv+9AqnmHNPxVE7+1Vy+lD48L6vQRTUD4uibNLX/NYWR+wF5wmql+Fl
         lGbhI0NRw1I71vTwfxxujOPk7ocSyCrmazU3Ef9C7dSbW7kOokcT+blsbGV+9aPVebGu
         zoyA==
X-Gm-Message-State: AOJu0YymSFNQRf0nCMYFYSouCzm+vpamMio4JPfZMzPd2SabMiOYMThy
	/5sKdfvZYAp5ZI41goicFMTJ+Bwwk/LLw3x0SuJnIyKhiDQACnWEW0w/qjPsuUEz/0jVr9QnWoA
	XyRR/c0BwiQT5yi3g1w2fjt92fof1M2tVEjubHmTbvlDC/Ur3JkRCo/hSwbdEofysBDXPsesInb
	BjFQ==
X-Gm-Gg: ASbGncuFRr402rJkJKfxUAzV7lq1P7+3KD5hV/8fFcThskozTyNsCr8GWA2L08C6Ur+
	WXXGXSUqZwcU5Fxj7iCTp+E8flRBMqKKZiHajHhbil18DgTWIZ4VunRv2WVx95ApEWxibRVb5bf
	ss2rn3ZswDQrW4w0/p5Ep+/9uKEXJeS3DpF7AL5LgZrBhILrA32pulhmBLeKv/zTCvEpr+cGvM8
	jODGrUeKplNRBuWrhNCZZ3Df2saj91b/kWkyGPmFqtijSbtf/MSKGz6KAiL4+VbCERMtCCqnZc7
	5GwDbaf7fuiXGb827LSGncAmyWpQQY6JDG0F48aJxBx3pdG0ZTHdSj6BPmqp8GdldZU+34MO3hm
	alAdoasa+CGfdMjcM263sAsFfV3bKoffKUCg37Df5fAX+0MOuCNeD
X-Received: by 2002:a05:6a00:84a:b0:7a2:50c5:64e8 with SMTP id d2e1a72fcca58-7a4e4e12aebmr4820886b3a.23.1761790141318;
        Wed, 29 Oct 2025 19:09:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHmgeapjx0QflJejJC5uG1l2QuXj3wQa6orQ0sWPzjfQno7ofwPjEYQ1924atN+a/PbBmlHw==
X-Received: by 2002:a05:6a00:84a:b0:7a2:50c5:64e8 with SMTP id d2e1a72fcca58-7a4e4e12aebmr4820862b3a.23.1761790140710;
        Wed, 29 Oct 2025 19:09:00 -0700 (PDT)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414066d0esm17003502b3a.43.2025.10.29.19.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 19:09:00 -0700 (PDT)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Thu, 30 Oct 2025 10:08:43 +0800
Subject: [PATCH ath-next] wifi: ath12k: fix error handling in creating
 hardware group
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-fix-hw-group-create-err-handling-v1-1-0659e4d15fb9@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAKrIAmkC/42NUQqDMBBEryL73ZVEa0371XsUP0LcmIAmNonWI
 t69wROUhYFhZvbtEClYivAodgi02mi9y4ZfClBGuoHQ9tlDxaqG3VmF2m5oPjgEv8yoAslESCF
 gLvejdQM2QmvGlbj2rYD8Zg6UNyfiBTIZdLQl6HJibEw+fE/2ys/8f8zKMV8ttajvN1Gr9uljL
 N+LHJWfpjILdMdx/ADTUvJ24QAAAA==
X-Change-ID: 20250902-fix-hw-group-create-err-handling-58ff01c84d78
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        a-development <a-development@posteo.de>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: R79fq-F5ANjTWYW30tRbIsesMnJ1P8F0
X-Authority-Analysis: v=2.4 cv=D+ZK6/Rj c=1 sm=1 tr=0 ts=6902c8be cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=uChsZFC9AAAA:8 a=EUspDBNiAAAA:8
 a=Z_vG5fj8drChUe-V2goA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
 a=ULtXvzFHYWHLyBAuiDia:22
X-Proofpoint-ORIG-GUID: R79fq-F5ANjTWYW30tRbIsesMnJ1P8F0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDAxNSBTYWx0ZWRfXzq0jIp4m9lPk
 DeXy+1aPlSg/mI5bckg5h1PDd6ywrraw3ysHN63oYMrVQG73eWSMmkWjCYxmKwTNlgpq+ktbOOW
 +SeIkrSMz4un535qcBRvNdrzt3Lt4gyhgjymB3mSiBRfhGvjQ9EHeqsGr9Ylgtld8t3uOIu37Pc
 XxuPMEOb6Nz0pYkoj3tg36pDQOyGxtN3SD3EbYo2OFip+gHIYeTbee+tga6lFmOsaGTM0DAtZkX
 6CyWUmHLex3M17L3MQf7c8Aj6rrT8DbkkfToRfW248y6XIDELpyrs9uwJxvbF4/kWYFHOlvcJrZ
 mZ4Ob4mS5pEaQsMkxFJK+9kDHcROJwx/H9LY4m8EBL1RtBR8pchPqFMRGi8wwhubc24qmsJm/sL
 6F36qQdWxDABmktoy9g+SuPh6DNf5w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510300015

In ath12k_core_init() when ath12k_core_hw_group_create() fails,
ath12k_core_hw_group_destroy() is called where for each device below
path would get executed

	ath12k_core_soc_destroy()
		ath12k_qmi_deinit_service()
			qmi_handle_release()

This results in kernel crash in case one of the device fails at
qmi_handle_init() when creating hardware group:

ath12k_pci 0000:10:00.0: failed to initialize qmi handle
ath12k_pci 0000:10:00.0: failed to initialize qmi :-517
ath12k_pci 0000:10:00.0: failed to create soc core: -517
ath12k_pci 0000:10:00.0: unable to create hw group
BUG: unable to handle page fault for address: ffffffffffffffb7
RIP: 0010:qmi_handle_release
Call Trace:
 <TASK>
 ath12k_qmi_deinit_service
 ath12k_core_hw_group_destroy
 ath12k_core_init
 ath12k_pci_probe

The detailed reason is, when qmi_handle_init() fails for a device
ab->qmi.handle is not correctly initialized. Then
ath12k_core_hw_group_create() returns failure, since error handing
is done for all device, eventually qmi_handle_release() is called for the
issue device and finally kernel crashes due to the uninitialized
ab->qmi.handle.

Fix this by moving error handling to ath12k_core_hw_group_create(), this
way the issue device can be skipped.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00284.1-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Fixes: 6f245ea0ec6c ("wifi: ath12k: introduce device group abstraction")
Link: https://lore.kernel.org/ath12k/fabc97122016d1a66a53ddedd965d134@posteo.net
Reported-by: a-development <a-development@posteo.de>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220518
Tested-by: a-development <a-development@posteo.de>
Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 5d494c5cdc0da3189640751b8d191fa939ac3ff5..a2137b363c2fea4deef724b682c1e41788777c06 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -2106,14 +2106,27 @@ static int ath12k_core_hw_group_create(struct ath12k_hw_group *ag)
 		ret = ath12k_core_soc_create(ab);
 		if (ret) {
 			mutex_unlock(&ab->core_lock);
-			ath12k_err(ab, "failed to create soc core: %d\n", ret);
-			return ret;
+			ath12k_err(ab, "failed to create soc %d core: %d\n", i, ret);
+			goto destroy;
 		}
 
 		mutex_unlock(&ab->core_lock);
 	}
 
 	return 0;
+
+destroy:
+	for (i--; i >= 0; i--) {
+		ab = ag->ab[i];
+		if (!ab)
+			continue;
+
+		mutex_lock(&ab->core_lock);
+		ath12k_core_soc_destroy(ab);
+		mutex_unlock(&ab->core_lock);
+	}
+
+	return ret;
 }
 
 void ath12k_core_hw_group_set_mlo_capable(struct ath12k_hw_group *ag)
@@ -2188,7 +2201,7 @@ int ath12k_core_init(struct ath12k_base *ab)
 		if (ret) {
 			mutex_unlock(&ag->mutex);
 			ath12k_warn(ab, "unable to create hw group\n");
-			goto err_destroy_hw_group;
+			goto err_unassign_hw_group;
 		}
 	}
 
@@ -2196,8 +2209,7 @@ int ath12k_core_init(struct ath12k_base *ab)
 
 	return 0;
 
-err_destroy_hw_group:
-	ath12k_core_hw_group_destroy(ab->ag);
+err_unassign_hw_group:
 	ath12k_core_hw_group_unassign(ab);
 err_unregister_notifier:
 	ath12k_core_panic_notifier_unregister(ab);

---
base-commit: 43d31f3f26f766f357e95513ba75c5126ce17d4b
change-id: 20250902-fix-hw-group-create-err-handling-58ff01c84d78

Best regards,
-- 
Baochen Qiang <baochen.qiang@oss.qualcomm.com>


