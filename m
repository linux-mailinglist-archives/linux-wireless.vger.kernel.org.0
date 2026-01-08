Return-Path: <linux-wireless+bounces-30515-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 452DFD00DB0
	for <lists+linux-wireless@lfdr.de>; Thu, 08 Jan 2026 04:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D6853006ABE
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jan 2026 03:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A733A0B36;
	Thu,  8 Jan 2026 03:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g/J1U6i6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RrDnG8Ik"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C076622A4F6
	for <linux-wireless@vger.kernel.org>; Thu,  8 Jan 2026 03:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767842549; cv=none; b=sNBs+Rxjb6zDVPM4Qt2eqjrahXxyVAqe3/2QpQCOiPP5JMjv+xDeswUHbYKQ7hhcRLKjYTrwQ4VZrI2roGf0fpWmnd3EQl8BMezg5J1hmje8mS9D6X8W55pZCoGTATLtqwyXMT7v1wy1Hq1PC+7Dg2gpGf6NUKw4/lNWDr5Aji4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767842549; c=relaxed/simple;
	bh=fK060d3pmC1AJnx3mPozFG2gI3bYmcZajkokVubrU9Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=k2/OsyblqJ1TI04n3PbNZbZ9dUdS66Un6S+N0SdnmuQusYkc8n3ZISZ0aMl3ex/ZqN4T/7PE3ySLYMWJ7l/dQAvQwZGy+8EblZ/C4wCbaZzFV8DvREfttbGIu1exQuMPTyR+VJ+Zusk6qeC5FWUoX1mWDsCqFr6K8IAwnDBgNMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g/J1U6i6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RrDnG8Ik; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 607Norfr305532
	for <linux-wireless@vger.kernel.org>; Thu, 8 Jan 2026 03:22:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=7PXwKV2N6Les3ztKmWoLYU
	uV1uMp/vFDg6/giSKNcK8=; b=g/J1U6i6gDNok/kzuvek3kexgPn+RkG1V6Dd55
	yym/s1VZzUfdzrVajYfYI3HhwTV82jCBHdpmc6UAOK56OwGuAUSx2RTpigeMowUs
	fnIH4cuLdSTHQ2y/zYzKEYTtgaIwrs32yjHw63ByPDrZL8z+BunTBSwsIJ7O1E6B
	Xf+ISlyhuOk8x/w37JuKLK1oDZwlhw0SJGXGQBEoDou7M5SxQDW+ZVWQqjE/mP/V
	721hzWcSfzqAwZwcJrG3Q6HnMpbohwNbuT7rw2RRqyOCfvVFGlxHh4rWhlhzpp20
	gCPb8rrZvRveEKpncpcALrerHQzf1nJQ6Mz8XpmTa17hseWQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bhum51k4w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 08 Jan 2026 03:22:26 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-be8c77ecc63so3890395a12.2
        for <linux-wireless@vger.kernel.org>; Wed, 07 Jan 2026 19:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767842545; x=1768447345; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7PXwKV2N6Les3ztKmWoLYUuV1uMp/vFDg6/giSKNcK8=;
        b=RrDnG8IkIrxUTeQtx5gW5bVMS02Af2b/g3XGK4Xiz96uuxdHD1KNESWWQNh95ltTHf
         sMX2ZsgiM9lHiDj1gxmIMjGszjcAbl4KlKemZEZlic1v79VPAqHJ+X8mZ7dDfEXwFx6k
         CxTXf9lvl7OxbqeHaaXmeawu4H61Q4gCAIzHlCF6BH0al3RRHZzaoh1OpNukRfFkKz3O
         ZAFlpeLRNJDdgfGeNuvoulXt/lw5DR0n4BBXfLN38yQYMDx8/7Rb/V/7/OP1Y3cVTF6j
         cn5tp8Fs0if4C1LVebMRQE+QWC8f1jRM6MJFcbOzO2CMJ96fHoDXMzN5KFUi6qvyaacN
         MFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767842545; x=1768447345;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7PXwKV2N6Les3ztKmWoLYUuV1uMp/vFDg6/giSKNcK8=;
        b=dbI0R2EYxUirki5eAom8EKCJlTjVfPtx6DtQrnno0ebEhGHTeR9C7waIu6N8iduTvs
         IQEjfP9xU5X/wyEHGzIvq8DdlHiEkpZXwKHzQ0OA34bQjyZFWubGAH9ss0Ln8qYGCjTJ
         JpSRsRgNB335noP2aDODEz47uh2aZP8rOKyRY0/f8YzIMZZISEHB+3/Pm3U+gZuPa1w+
         Oc/MWE20QNZdnNLpNzjGnm5q9s1sM54aTqTPYLorQ5AjThxonztYFIlkw7nZLDK1MIR+
         hNk/0NTwqfQmiKbqZBe1mb8W6OOKIlFL6mJnwmHVfXDOptJc3FbdB19dRNCfPCL8Uzwo
         YzCg==
X-Gm-Message-State: AOJu0YzqEKpe8Tm0KgX/aXN3cT/FXfo4LYej3J7ocANZc4pPTAxX7xCx
	xui20Mt7Zuu6GNExBNgmIRU6QVVIsQvjK0aJlY2jSDdDzQkFnnCaN9PPMJ7rCUqkqgvFf6bkZlj
	3j+jMPkd+MyVV6zh1gqMEbUsktsiYhSPOnXyZicxD2zqk/f6hXPeI35dUhcfXcuTUIgRTnPu8h/
	6W8s0A
X-Gm-Gg: AY/fxX4UfgsWs5MKFp4cDTG8bmgZXJBvPLNurLYSHqGrYaFto5soCym8ZP+XeMoZqDQ
	16VkEKrE4SUrb0VCQXXswFEynAph+PKGDt85NPu8Rd2+C5iW5gknzf4HQcinP0zV4PcHjRivKrv
	rlGZQdOD1QDMJj1WDdh9jWgeO5xTMjrvSQLopMOOg0x7tVHXr6DAWinp3Qe2hn8bw1Wu75kB5IP
	fhMCx6pI9xali11BXSJAV1bEVp/VzO/5MBZVxdpzKBJMLbANBXPfIZVThmi0gfrNFBTRgxLV0z0
	MpbnXG5ZmmFZW0OZzxkMzQojAYXzoBTpyBIHAV0gf+2nabr396Smkert8u1rTh5uN3BB/BCOhtB
	DTWAMs+zAoxM1rLmCTHf28rYQJ+Z7TchdHFhrDwB91tSLlt7Lo8VwWxYe/g08biM=
X-Received: by 2002:a05:6a20:3947:b0:35d:2172:6010 with SMTP id adf61e73a8af0-3898f9904b1mr4702847637.51.1767842545110;
        Wed, 07 Jan 2026 19:22:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGFVfouRyUmplzoXgfdGWuahXRjDDZ+DaSIRm+rneipYN8hW0cVcTS9EsNE1J7rHs/lITOURQ==
X-Received: by 2002:a05:6a20:3947:b0:35d:2172:6010 with SMTP id adf61e73a8af0-3898f9904b1mr4702822637.51.1767842544518;
        Wed, 07 Jan 2026 19:22:24 -0800 (PST)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cc9e7e824sm6339625a12.30.2026.01.07.19.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 19:22:24 -0800 (PST)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Thu, 08 Jan 2026 11:21:46 +0800
Subject: [PATCH ath-next] wifi: ath12k: don't force radio frequency check
 in freq_to_idx()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-ath12k-fix-freq-to-idx-v1-1-b2458cf7aa0d@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAMoiX2kC/3WNzQ6CMBCEX4Xs2SW2lR89+R6GQ4GtNEorbSUYw
 ru7IV69TDKZmW9WiBQsRbhkKwSabbTesRGHDLpBuzuh7dmDPMpCSFGjToOQDzR2QRNowuS5saB
 Wnakqo6SREnj8CsSVHXwD3qCjJUHDyWBj8uGzP85iz3/w8z/4LFBg2/aqLNWp7ovy6mPMp7d+d
 n4ccxZotm37AhFpElHNAAAA
X-Change-ID: 20251218-ath12k-fix-freq-to-idx-a3cf77f32f22
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: V9r_TU8Ns35rvNI3BVd1dqYUt-gWbf5c
X-Proofpoint-ORIG-GUID: V9r_TU8Ns35rvNI3BVd1dqYUt-gWbf5c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDAyMiBTYWx0ZWRfX3TitCW95de/R
 ixcYFhFqTgiULKYnEdm78YdUMxOLouJ55DWXPzxQcsiPysMizEjljFHsuqpX+/vKOGqYaMGU4J3
 qxs37pW17C93rTrxA/+dFnys2bl6cMFkAYjlXVPkDtdfl844QvWamogv16LY7qzeH3uy23fT97Y
 9L3WR8ug7UAAaVUVGhYeGtgrjxFLlqPORJZitl8zWppgRuYRxwkDkH0QqC++Ml0vgreAXPU7D5q
 AgbiBaO0LPwp4UrC/gLq/CdO8zyn+H/0WveJa37pi7rfhhvKRsGaqWBgvqVhvIlhcxIVsX9bCN5
 5NZLd3WZjKmJFD3zmPgeEKSAVgWX7kuXO1kBSmlqRGPNGWI8tSHau5D6IFPwt6Q9cj61b+N+sN7
 ICdV47u8+V8gKkAu9F/BBVt45GbnMQNktUob/4XX1VsKBDdVOzVxHyzEB6/8QSuIpcTro5HVgsS
 wB00elja0qTmLF+XnyQ==
X-Authority-Analysis: v=2.4 cv=KNZXzVFo c=1 sm=1 tr=0 ts=695f22f2 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=VOO-gYkIs3c7SNGsfqsA:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_05,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601080022

freq_to_idx() is used to map a channel to a survey index. Commit
acc152f9be20 ("wifi: ath12k: combine channel list for split-phy devices in
single-wiphy") adds radio specific frequency range check in this helper to
make sure an invalid index is returned if the channel falls outside that
range. However, this check introduces a race, resulting in below warnings
as reported in [1].

	ath12k_pci 0000:08:00.0: chan info: invalid frequency 6455 (idx 101 out of bounds)
	ath12k_pci 0000:08:00.0: chan info: invalid frequency 6535 (idx 101 out of bounds)
	ath12k_pci 0000:08:00.0: chan info: invalid frequency 6615 (idx 101 out of bounds)
	ath12k_pci 0000:08:00.0: chan info: invalid frequency 6695 (idx 101 out of bounds)
	ath12k_pci 0000:08:00.0: chan info: invalid frequency 6775 (idx 101 out of bounds)
	ath12k_pci 0000:08:00.0: chan info: invalid frequency 6855 (idx 101 out of bounds)
	ath12k_pci 0000:08:00.0: chan info: invalid frequency 6935 (idx 101 out of bounds)
	ath12k_pci 0000:08:00.0: chan info: invalid frequency 7015 (idx 101 out of bounds)
	ath12k_pci 0000:08:00.0: chan info: invalid frequency 7095 (idx 101 out of bounds)
	ath12k_pci 0000:08:00.0: chan info: invalid frequency 6435 (idx 101 out of bounds)

Race scenario:

 1) A regdomain covering below frequency range is uploaded to host via
    WMI_REG_CHAN_LIST_CC_EXT_EVENTID event:

	Country 00, CFG Regdomain UNSET FW Regdomain 0, num_reg_rules 6
 	1. (2402 - 2472 @ 40) (0, 20) (0 ms) (FLAGS 360448) (0, 0)
 	2. (2457 - 2477 @ 20) (0, 20) (0 ms) (FLAGS 360576) (0, 0)
 	3. (5170 - 5330 @ 160) (0, 20) (0 ms) (FLAGS 264320) (0, 0)
 	4. (5490 - 5730 @ 160) (0, 20) (0 ms) (FLAGS 264320) (0, 0)
 	5. (5735 - 5895 @ 160) (0, 20) (0 ms) (FLAGS 264320) (0, 0)
 	6. (5925 - 7125 @ 320) (0, 24) (0 ms) (FLAGS 2056) (0, 255)

    As a result, radio frequency range is updated as [2402, 7125]

	ath12k_pci 0000:08:00.0: mac pdev 0 freq limit updated. New range 2402->7125 MHz

    If no scan in progress or after scan finished, command
    WMI_SCAN_CHAN_LIST_CMDID is sent to firmware notifying that firmware
    is allowed to do scan on all channels within that range.

    The running path is:

	   /* redomain uploaded */
	1. WMI_REG_CHAN_LIST_CC_EXT_EVENTID
	2.   ath12k_reg_chan_list_event()
	3.     ath12k_reg_handle_chan_list()
	4.       queue_work(..., &ar->regd_update_work)
	5.         ath12k_regd_update_work()
	6.           ath12k_regd_update()
	               /* update radio frequency range */
	7.             ath12k_mac_update_freq_range()
	8.               regulatory_set_wiphy_regd()
	9.                 ath12k_reg_notifier()
	10.                  ath12k_reg_update_chan_list()
	11.                    queue_work(..., &ar->regd_channel_update_work)
	12.                       ath12k_regd_update_chan_list_work()
	                            /* wait scan finishes */
	13.                         wait_for_completion_timeout(&ar->scan.completed, ...)
	                            /* command notifying list of valid channels */
	14.                         ath12k_wmi_send_scan_chan_list_cmd()

 2) Hardware scan is triggered on all allowed channels.
 3) Before scan completed, 11D mechanism detects a new country code

	ath12k_pci 0000:08:00.0: wmi 11d new cc GB

    With this code sent to firmware, firmware uploads a new regdomain

	Country GB, CFG Regdomain ETSI FW Regdomain 2, num_reg_rules 9
 	1. (2402 - 2482 @ 40) (0, 20) (0 ms) (FLAGS 360448) (0, 0)
 	2. (5170 - 5250 @ 80) (0, 23) (0 ms) (FLAGS 264192) (0, 0)
 	3. (5250 - 5330 @ 80) (0, 23) (0 ms) (FLAGS 264216) (0, 0)
 	4. (5490 - 5590 @ 80) (0, 30) (0 ms) (FLAGS 264208)
 	5. (5590 - 5650 @ 40) (0, 30) (600000 ms) (FLAGS 264208)
 	6. (5650 - 5730 @ 80) (0, 30) (0 ms) (FLAGS 264208)
 	7. (5735 - 5875 @ 80) (0, 14) (0 ms) (FLAGS 264192) (0, 0)
 	8. (5855 - 5875 @ 20) (0, 14) (0 ms) (FLAGS 264192) (0, 0)
 	9. (5945 - 6425 @ 320) (0, 24) (0 ms) (FLAGS 2056) (0, 11)

    Then radio frequency range is updated as [2402, 6425]

	ath12k_pci 0000:08:00.0: mac pdev 0 freq limit updated. New range 2402->6425 MHz

    Please note this is a smaller range than the previous one. Later host
    runs the same path for the purpose of notifying the new channel list.
    However since scan not completed, host just waits there. Meanwhile,
    firmware is possibly scanning channels outside the new range. As a
    result, WMI_CHAN_INFO_EVENTID events for those channels fail
    freq_to_idx() check and triggers warnings above.

Fix this issue by removing radio frequency check in freq_to_idx(). This is
valid because channels being scanned do not synchronize with frequency
range update. Besides, this won't cause any problem, since freq_to_idx()
is only used for survey data. Even out-of-range channels filled in the
survey, they won't get delivered to userspace due to the range check
already there in ath12k_mac_op_get_survey().

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

Fixes: acc152f9be20 ("wifi: ath12k: combine channel list for split-phy devices in single-wiphy")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220871 # 1
Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 150b04d0a21c..17ffc4822741 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -6479,16 +6479,9 @@ static int freq_to_idx(struct ath12k *ar, int freq)
 		if (!sband)
 			continue;
 
-		for (ch = 0; ch < sband->n_channels; ch++, idx++) {
-			if (sband->channels[ch].center_freq <
-			    KHZ_TO_MHZ(ar->freq_range.start_freq) ||
-			    sband->channels[ch].center_freq >
-			    KHZ_TO_MHZ(ar->freq_range.end_freq))
-				continue;
-
+		for (ch = 0; ch < sband->n_channels; ch++, idx++)
 			if (sband->channels[ch].center_freq == freq)
 				goto exit;
-		}
 	}
 
 exit:

---
base-commit: e33fc1c6d54ee1569a57255e11c2978ba9a42ffc
change-id: 20251218-ath12k-fix-freq-to-idx-a3cf77f32f22

Best regards,
-- 
Baochen Qiang <baochen.qiang@oss.qualcomm.com>


