Return-Path: <linux-wireless+bounces-37570-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id v0UlAY7ZJ2pS3QIAu9opvQ
	(envelope-from <linux-wireless+bounces-37570-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 11:14:54 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CBD65E2E3
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 11:14:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=dOblSGYF;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=grXCHO2L;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37570-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37570-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B820230AA420
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2026 09:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2BC3101BC;
	Tue,  9 Jun 2026 09:06:17 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02622EE262
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jun 2026 09:06:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780995977; cv=none; b=F1fTqJjwwh3dDQMVHSqFNc4yZE7M+kTiOXrXELa6lbxfOV6cXVUVrRJTr2K5FwhuRAcNrrIUbDmeA6qqleQ07wSdzZO2XXYfxf+Q99gmHTf1nTQq/sqrvgj88TyoqjiWFM0ENMWVu2H7K/WopwdPkTE+tqIK4nptYwfV/xuj5Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780995977; c=relaxed/simple;
	bh=l74VdIa2ixxhypdj420z26edkeE4wYqCIkRDwg8STfA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rzTgAGMItM3ZbouJcbETTIbttEG2Vu4HSD7j/lWtEB3gSquLC7TN8t2zb6iL8nkLddOoxS3g5VkhlkK6qIK9BeyQd1zNKK9KzvelPt12KAfOnYupoCZg23wweW/Q2Xfg7HNo5QHYH9NGX32uTaLv/0Y+IcxL33hxZukJWlcUbaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dOblSGYF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=grXCHO2L; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6597rv201587715
	for <linux-wireless@vger.kernel.org>; Tue, 9 Jun 2026 09:06:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=lMR7DNyFrCJR1oBUZx5aCLEhe3qVrp/ulGb
	YrnrVCog=; b=dOblSGYFmtztB+LRnDpxLu1Y2AU1mOCBt/d49dQZCCg/f8b5/qw
	0g49d62XJS9lVsE1Nd4TJmWWeT/+gR6hh3CbhOru9T0+hQZEl6NAX5Yail/nJES7
	d2gvOmGlKcvLWNdPtoBGIvRH0NbXSiYknFdtebwOS3SiY1LwVWrBYl5hymGgrqyW
	YZWUOg3o20SJxbI9cEi0vbP/A7A46Dn71io9s7b2OKH9szq8ts2+Pwk5JNnL6Fv3
	iotxrqJzil+Su7lF+EoUHAIY5Z6cilvknVcLH6RO94skQVDQbxTil3CzrCY0MLXL
	JmqnaoyLGIwpMJD7VAV6PwAKUmWgtq0FTMw==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enw5m50tt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 09 Jun 2026 09:06:15 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1383414cf84so147020c88.1
        for <linux-wireless@vger.kernel.org>; Tue, 09 Jun 2026 02:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780995974; x=1781600774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lMR7DNyFrCJR1oBUZx5aCLEhe3qVrp/ulGbYrnrVCog=;
        b=grXCHO2LUisqoXFjzLCZ1Bpt4kJ99MNeFHJcagXrdrjHTYMIEQ1GFyyqp81r/nZB+g
         TmEdA6CMhi0Pcr4ldgwJxztW1IXH8eQU+nZ8UwowUn88PTeokWYRL7aKG0TCPf7k/s0j
         4J1MFRUfyVLe0VH9Wt2Ria/E6M4wyD5usrrE4+m9CB+MLTN8jWjLZSSeMAHrjfssPwS6
         oF3XdrCxHO1xT8TI4d6uYpxAmUcJM7IjV8j+dIaHyBLJjdVzDvrhFFwjqx1FKbG3ilNb
         PowPGVJywOR8oQit8joFDi8wKBmDw88hhA0ax5dxvtY0CJhhnlLWDfHGtadZt/KSZtsz
         EcPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780995974; x=1781600774;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lMR7DNyFrCJR1oBUZx5aCLEhe3qVrp/ulGbYrnrVCog=;
        b=dLArtuT/K3lQ7AQ0lXscD43N95E7MVzXVwkC7GCsnbY6oW1AYnzVOGv2MShSzCXUKr
         w9Hoq6bOtd9IkGdFYAyyTJqr3Y7NvS+Gutn/R9k6YOmWiTh3z01Lp5cFldMEQwjOffn7
         9wa9GvBpze3cD5pmH6eoWkiZy/V2Yd9eMCjRBZf5ZKpwyiopJfFJnPTCxLZRApjDj5K3
         kAazTFNsxzO6z1E9DrdvanTrnwhoSiW5wMd0fMfQ27aAdwvogHgyYlDeuDJgnBd0L5p/
         8tt2utpFsvD0M+Oq8syloJxydgV8hIseOJb7S4BvssyZCN7WRyHMokrhR/tidUl96vI8
         OqeQ==
X-Forwarded-Encrypted: i=1; AFNElJ+yYQI2vJm2+8kjWAd5lgsd3MzWZhcwszLx07gbGUlUmBcyUJF0FDkTLoV4mKEiVeH2cazAmudaWwPlmixolQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyca8T9P/28CCfkdMOBM0o5k1mYflY3s35REdIVviCl6maxa6cZ
	fyTgCKK3w1WYVRMoA5BuR6rZy8owBuVmJzdy1NhYHHl9u0cJzfxy/T8flivYk+pGjwZI80PA+jY
	X4ZTCzIo02L8bpI1OAEq2gg60F978FNyzgojt+b4345vxldUsrSBTJz8N9Z8FW1fcD2JY0Q==
X-Gm-Gg: Acq92OG+jeee1wN9NHspi5g6amj0Z+N3YA8/hLEMv931BvhMC0M5orVTZlZ5rGYfc3G
	Uk/DcliUIV1B7cwmcnqDQQgtkSAzlcrHEllbD58JQkFA2fvAq+MWEbt0hUDjvFZMBFt2sB/IF72
	3PACrwUA/Ecc41UptskVgpHp3AoQPUb+rAN7V0zNbrx2Av+1wKs3qY2bj6F6NzLTWEpwlLATFeB
	KiZmg6d393h49WHipzZ2kA+bDANEAtzF4H3wnH7QX9akmzo5saS7Qf5FlIPOrcCYgQO/x6V+35b
	YTUsR0q5f7urKW2Cr67YgRDCAn4rVQsJdP+6FlbIP/hMDNOzN2JOIP072q8cMb7TRuvKDUdvl01
	8c1it/+iz5WydWDusnRnKTQDI1TjMs+J/wWtxl5Yl9I0PovDshxvZnIzoYaz+s17zuo7jpaq7mn
	uCqNJmZO/16/2/WQ==
X-Received: by 2002:a05:7022:ec4:b0:12d:de3f:f3e5 with SMTP id a92af1059eb24-138067571bbmr8812602c88.37.1780995974265;
        Tue, 09 Jun 2026 02:06:14 -0700 (PDT)
X-Received: by 2002:a05:7022:ec4:b0:12d:de3f:f3e5 with SMTP id a92af1059eb24-138067571bbmr8812570c88.37.1780995973648;
        Tue, 09 Jun 2026 02:06:13 -0700 (PDT)
Received: from sdciot-sh03-lnx.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074db528dcsm24532741eec.3.2026.06.09.02.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 02:06:13 -0700 (PDT)
From: Gaole Zhang <gaole.zhang@oss.qualcomm.com>
To: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Cc: gaole.zhang@oss.qualcomm.com, miaoqing.pan@oss.qualcomm.com,
        hangtian.zhu@oss.qualcomm.com
Subject: [ath-current] wifi: ath11k: fix NULL pointer dereference in ath11k_hal_srng_access_begin
Date: Tue,  9 Jun 2026 17:06:09 +0800
Message-Id: <20260609090609.4041009-1-gaole.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA4NCBTYWx0ZWRfX5pqJoRjkD1c9
 m8xvVkDhTn/nisIDmihXk+hR/RR37yoWXe3KO3WNx63gKByX9ePfJANZ3gVPTTtcRzKPo5AHCMB
 ZLPplW/SenoCM7NWsQMOBJAsGqajMBjnn+RyA1+7WMe+vG+AErJLvC27FE5yMV3YP1jQBwwVA9G
 Y8FO+ses089y7TDpCs0abB8xM3mUqjQfiOTkU+1YbHLnPjSTNkRj0z94SHiQOxEUVxFiLMINiTL
 8KTPe7R5ahqhRdh1Wp2euwvADHpQuEZ8qMfWcCO1Kmo3XAWkjeTVhmw8AQow9AgFC8JB+FQcqeh
 9YuqBZ1eH7fDAwakNIGXB+NkjozHUO6g78dxVrbIHYNYuMHi4SxnBUKOnN9y8t/xG8Dr/B9e5qb
 edPMwh4OSYHu0sWPyHRtD6w/RJB4rTsoMxQw/ArOqJbKIHcBkSnO8BIZpOPzCiggAgLbYGg+4zu
 qLmtOwrbAiRGHsZZk+Q==
X-Proofpoint-ORIG-GUID: ea_elMAZM4bf22avl4B6II0-wkGbPnmq
X-Authority-Analysis: v=2.4 cv=UptT8ewB c=1 sm=1 tr=0 ts=6a27d787 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=3g4jOkLtDLcfbKciuAwA:9 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-GUID: ea_elMAZM4bf22avl4B6II0-wkGbPnmq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 clxscore=1011 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090084
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-37570-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ath11k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:gaole.zhang@oss.qualcomm.com,m:miaoqing.pan@oss.qualcomm.com,m:hangtian.zhu@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gaole.zhang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gaole.zhang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 49CBD65E2E3

In ATH11K_QMI_EVENT_FW_READY, ATH11K_FLAG_REGISTERED is set
unconditionally even when ath11k_core_qmi_firmware_ready() fails.
This leaves the driver in an inconsistent state where
initialization is considered complete although the firmware ready
handling did not finish successfully. During the subsequent SSR,
the driver enters the restart path based on this incorrect state
and dereferences uninitialized srng members, resulting in a NULL
pointer dereference.

Call trace:
  ath11k_hal_srng_access_begin+0xc/0x60 [ath11k] (P)
  ath11k_ce_cleanup_pipes+0x17c/0x180 [ath11k]
  ath11k_core_restart+0x40/0x168 [ath11k]

Fix this by:
- skipping firmware_ready if ATH11K_FLAG_REGISTERED is already set
- setting ATH11K_FLAG_REGISTERED only when firmware_ready succeeds
- setting ATH11K_FLAG_QMI_FAIL and aborting the FW_READY handling
on error

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.2.0.c2-00204-QCAMSLSWPLZ-1

Fixes: 6fe62a8cec51c ("wifi: ath11k: Add cold boot calibration support on WCN6750")
Signed-off-by: Gaole Zhang <gaole.zhang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath11k/qmi.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index feebbc30f3df..a304feca7042 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -3295,9 +3295,14 @@ static void ath11k_qmi_driver_event_work(struct work_struct *work)
 			clear_bit(ATH11K_FLAG_CRASH_FLUSH,
 				  &ab->dev_flags);
 			clear_bit(ATH11K_FLAG_RECOVERY, &ab->dev_flags);
-			ath11k_core_qmi_firmware_ready(ab);
-			set_bit(ATH11K_FLAG_REGISTERED, &ab->dev_flags);
-
+			if (!test_bit(ATH11K_FLAG_REGISTERED, &ab->dev_flags)) {
+				ret = ath11k_core_qmi_firmware_ready(ab);
+				if (ret) {
+					set_bit(ATH11K_FLAG_QMI_FAIL, &ab->dev_flags);
+					break;
+				}
+				set_bit(ATH11K_FLAG_REGISTERED, &ab->dev_flags);
+			}
 			break;
 		case ATH11K_QMI_EVENT_COLD_BOOT_CAL_DONE:
 			break;

base-commit: dc14686f27df6454b13b16ad1c9203ab3e9b0375
-- 
2.34.1


