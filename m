Return-Path: <linux-wireless+bounces-30540-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D4427D04A98
	for <lists+linux-wireless@lfdr.de>; Thu, 08 Jan 2026 18:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C272309BC2E
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jan 2026 15:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93294C0421;
	Thu,  8 Jan 2026 10:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Mxk/qZbK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aNy+vwqX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB774C0413
	for <linux-wireless@vger.kernel.org>; Thu,  8 Jan 2026 10:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767869097; cv=none; b=pK9jFOXPt9VE3mo/62E2EdEh0a1uBYxawy+CiavULOBd+BoNNUGcnNDo/qnPyxxc2mwx+ZAJiXJFtfuu1ynQJjJP07/Fr+zbmjSlS7TKoNsM3JJTkC7VHxUK4qgai2/ZhBr3eiSmwgqElNHIM5PPBR+IN9GorArO7GXPKlywFrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767869097; c=relaxed/simple;
	bh=EwMf8/8XcOKtjzN7bNffRXI5pnRCOFeRMZyrOgmLvms=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qEbWfMGcb0nj5iWm4tflwAes1gnQJkXIyRv2gSOWjqQBFKKBjZydAgWr2EzTABC5btn8H8nQcCdKOTuQz10gWYDdlU54C0dtSzBkf6A1Na80uAV3nR/ZWOpZ73INkXzs70V0SdhGwfG2qo0aw7I4VKTOkT0LKeGB+gkIyCEjzic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Mxk/qZbK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aNy+vwqX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6087QYHZ1259090
	for <linux-wireless@vger.kernel.org>; Thu, 8 Jan 2026 10:44:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=UCWf1GYG01oCNT5JUBK9ci
	QvOCCDtItp2wmBxL7jzC0=; b=Mxk/qZbKHvx7D01uSV2gX77Q8Yxwik9NgMLpPO
	JfnbL8MaYFcSY7oW2XdO3/KTOFHznoP0/E1I1oet6tifAG89lsQSUPK+dRFPhTC+
	vtl35PnPRYH/aABf32FJHOTVkLuUCD9fwbi+cl0YKa28RZr2O3sLuXe8E8dYdqt/
	AjGsFDE8qX6nOwCgymX1Cht9ihhHvQ7cBVOHxgiqYVCb1JWKas9TDacwLVr5YKPj
	Dc/tF5jQWS7UB3ZL+enG+G2pyOBi98VgVtqJXABTLnLTdTLpwOmKTFoFin3H/o2f
	Eb5mzpUf+Vn/kpHgRFq3eLV6uxpzaZMcWd2kfz4SlzLWuPEA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bj86grkqh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 08 Jan 2026 10:44:48 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a0f47c0e60so67423325ad.3
        for <linux-wireless@vger.kernel.org>; Thu, 08 Jan 2026 02:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767869088; x=1768473888; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UCWf1GYG01oCNT5JUBK9ciQvOCCDtItp2wmBxL7jzC0=;
        b=aNy+vwqXMDbCotp2cjLcbJ4KHt9Cs7uE+J5vzeqapFNz5fEsDlUNmtrEAUu/e3XbKN
         IuJ7Vhx67w5ymcaL8ZVV9W0PSAU7Agdar0bkUDSK8wW2TpUrKPQvXzalE1bMIWuzBxPP
         v10kR8Tqq1dt/Hpa7EVl7Lzp1eARfJtyj4ALplntBPct3R5NJSTGJm5EtZv+dra9erOy
         GZZ50IzqhiyWlhHsar6qfUNt5dV4KHpGIof7sJdHg3nt9RPSEExGFMGK5PooFsXAuEhg
         +DiM3W+PhuqJeT2JyCScLlcWrFeo2o9dR1Ub7on4QN/Lij+iHGIPBtNZhRlNOL8bsPNt
         sVxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767869088; x=1768473888;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UCWf1GYG01oCNT5JUBK9ciQvOCCDtItp2wmBxL7jzC0=;
        b=jyo3T1VeZk40r9oWM+CwqmL0BP1a/QecQX+5q6V06urMORuepXUlANhMPbUznegFCB
         ZZie/+Vkfz8IzIwtLmk/CRP4kfHck16QdlkcMPKExWivGkf0L3KOHPbb/+7gR7GMs/7J
         Ob68+50Ks159mO/8q02XGVia4cMiAWK6yvu8ZSHF2WX2x2diCaVQs3gjdsIebcbXE9YV
         8A5xbgRxptOwCkvvH5BBRZg/pR1bybD3XRs8nMukNncpXz6nM3pGWJGg//mtCiCsV5kw
         zKBrBL/YaxC/SrGud2pRztrEweIwED5tl9uTJhVGGs6u9rYExZplEuW/JIda5zK3cg15
         87jA==
X-Gm-Message-State: AOJu0YysvIA1B9UcG5TKr0grLDzYoI7x5I//S8XSmXBbcnmKaHtSjYBA
	jYgWBKloWc0WfGmlVl7WJKzypkWbIMKfTIK5vkEEAz1nZUCaRfNDCtNbDEr/iCH6IOhNf6Jd0mn
	NF3FiS1xj6xqlgniYR62n/IkAuVUwDZ8+nlrNhQLDzTV25JmORxmOCMgq7TNKykruis5ysDSerV
	HZDUcY
X-Gm-Gg: AY/fxX6gHv5vTl9FODoxwITJxb4embCmMVPKMLIHd+UAOUjlqaKy7IS+AGLPS6lSpmc
	4QnJSts5R9dj4A70cEnKMhOd6HFAUF68o1h7aqCm7hj0Ie/0O3jVlVecsHjtenPR7QFMnviN1Sw
	5bFZGNuRGSpIxnZn1DzpTduuJkBK1LvuhLra1R3zGS+1wKx8ag4zMQ/1Sa4H+duB+9jJ5aY5MHC
	XhJ+UqIC8lYWpXm9igZNd1Qc7yT8j1dlJzXlHclGEQmdWBk0GQBmMavTrgobK3xnDqH/irMATnK
	4nEF6zFzG2sVrY5pcFMu5rPUKe/AHZZhkd0dqTuiOwaM/CUTSFqIahGqoSAOL7m3EGYtrDALyow
	Q63OTedVJ6v6eBR3DZpsYQ91RDJd2K5TDAA8m5D5/dNZKkL8U1pcTgTLhRXKWit8=
X-Received: by 2002:a17:903:3bad:b0:2a1:3ade:c351 with SMTP id d9443c01a7336-2a3ee41511cmr54527825ad.2.1767869087543;
        Thu, 08 Jan 2026 02:44:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpc/g1BOPk1bzcN24yJby/XQYHXCB9siaPmfawbd8NIOUuShpU+Y5E6VKaVqh0gWgtqd6Zyw==
X-Received: by 2002:a17:903:3bad:b0:2a1:3ade:c351 with SMTP id d9443c01a7336-2a3ee41511cmr54527605ad.2.1767869087042;
        Thu, 08 Jan 2026 02:44:47 -0800 (PST)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c3ae21sm74364825ad.7.2026.01.08.02.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 02:44:46 -0800 (PST)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Thu, 08 Jan 2026 18:44:34 +0800
Subject: [PATCH ath-current v2] wifi: ath12k: don't force radio frequency
 check in freq_to_idx()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-ath12k-fix-freq-to-idx-v2-1-33c0cca9d93f@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAJKKX2kC/32OzQ6CMBCEX4X07BK6/OrJ9zAcSmmlUai0hWAI7
 +5KvBm9bDLZmW9mZV45ozw7RStzajbe2IEEHiImOzFcFZiWNMMEc468AhE6jjfQZgHt1AjBkmM
 BkUpdljpFjcgo/HCKLDv4wigDcnJODYHV9OyMD9Y999KZ75YP//iLP3Pg0DRtWhRpVrV5cbbex
 +Mk7tL2fUzn3UqUIuFJ9Z+CWV7RWiGS9ptSb9v2AhgC6nYWAQAA
X-Change-ID: 20251218-ath12k-fix-freq-to-idx-a3cf77f32f22
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=ZNjaWH7b c=1 sm=1 tr=0 ts=695f8aa0 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=AXMgxrcyLYDzoHglUI4A:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: CDCMZN2FFok_Tu3Rsw6-y0O8H-XmnxE6
X-Proofpoint-GUID: CDCMZN2FFok_Tu3Rsw6-y0O8H-XmnxE6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDA3MiBTYWx0ZWRfX1fKP9al05ED+
 95OPgqBYdohLR18VHRtfQWFqP3Svy+faNsaly78LR6k8gACt+C/5nnH8KujHoKZHhtrKvuPSO1E
 5SSNk6HQl7tNw8LuHj+Q9/Kuyj/f/pkOXJmXIr+ymr3tVYmnAfjhSeZ68gNUV6K7ArarjxBEmV9
 Sm4eUqR2C28OObv3+si1vT/vm3UKQC8HFbEztysoMlQc272UUzotKb78mSmtNygQaNp1FLJwDPb
 +gxGCc9Qxl5nfbWU7y4PP2kenY9B/ksXI9skhTwkU/DPSffCXfKvBXP0H+QsF9mJkWQnbv2htd2
 PFmby2EHIthgc1RLyfJJyAANbVMdijFiPP4n2solZTYmIF2al6TINvCulIxaFvCAiaLLFePhebD
 zX/u1DYTlFX0tbiu88SkqvKHOwuASf/FbZ44zVmm8mXLWGxO44oSBTu3xM9t8TTlXkWDXdSsyqc
 yPW3Y0/vTu1ZXDITprw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_02,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 adultscore=0 clxscore=1015 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601080072

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
Changes in v2:
- change target branch to ath-current from ath-next
- Link to v1: https://lore.kernel.org/r/20260108-ath12k-fix-freq-to-idx-v1-1-b2458cf7aa0d@oss.qualcomm.com
---
 drivers/net/wireless/ath/ath12k/wmi.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index be8b2943094f..3ce5fcb0e460 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -6575,16 +6575,9 @@ static int freq_to_idx(struct ath12k *ar, int freq)
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
base-commit: dbf8fe85a16a33d6b6bd01f2bc606fc017771465
change-id: 20251218-ath12k-fix-freq-to-idx-a3cf77f32f22

Best regards,
-- 
Baochen Qiang <baochen.qiang@oss.qualcomm.com>


