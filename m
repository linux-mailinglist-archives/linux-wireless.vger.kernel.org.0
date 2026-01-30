Return-Path: <linux-wireless+bounces-31405-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yI7SEsQUfWnXQAIAu9opvQ
	(envelope-from <linux-wireless+bounces-31405-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 21:29:56 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D069BE69B
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 21:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F6C230078F0
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 20:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC2D344056;
	Fri, 30 Jan 2026 20:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FQXCgx1u";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AopV9FAv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEDF2DE6F1
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 20:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769804993; cv=none; b=rIjW9MZIW9hmk0aTHcd845yScIRdeppHgGdtdjD3uiBRqWf7NIermYVOgdGgtG8ubjffT6PKLij0d92LbxUM7tKuKDq2i2lpHv1oziM1Kd6w7EQKUAVPmA0pJB3n5NhfhMxC/CVPR0k4h6f5WhriL6r/QhE4r9z6s55XX1WQmQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769804993; c=relaxed/simple;
	bh=wVDEQWgSB+7DIiGv8BgY2vPq2LREViOuQszWKS4kidA=;
	h=Message-ID:Date:MIME-Version:To:Cc:Subject:From:Content-Type; b=nEqjCq8znU82zK24C5UP13UhRmaMLpGk9UsDCmxS4r9KY1NCg0hAOGlHQrZD2cbgK5jZBJSlLIMvrHzzXlrVQq1O8DpsWKWlfkUHDu928FkT0dRPIepVjLfL3DOwtFp14mLIjjFj4cC7QHI68jGZ3n44EC1OGlX4fyY6HHXvMRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FQXCgx1u; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AopV9FAv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60UCSCao555440
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 20:29:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=gKtVDmhXmolTIN8Uom22wN
	d+fElMtxvh9JofuLlixjA=; b=FQXCgx1ufEA3QJD4xNPENvAhS5CWK2fL9cmRCY
	XSRN6ftPFqE4mAph+/5oGAQWBg0G4dRgBg1B+oRwSnNVEQh2yll5Ql9g2607M02l
	kHnLjgjdZajf4Lo3VmC/35oywoJ6CjvCTfQSEgjODPBzZN6ra1yWX9Gs2V9IbeRv
	TBWL0NveMPnUHbADWAK2AE2xc2PE76m9AhoW2k2dMxrr83hLUGOtPW/VfYuO0l8b
	3ke7sLgfWH60olY6omWuLb9+WI52KcnMHvuFn8fFv4pMDh8/ZVfv4wN3kBTJX6MN
	Ea8x0+SEdhgM8Yy3sTpA0T0SSwbKeFZ3u5Qc8bYX5aVXNN8g==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c0p59jry7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 20:29:50 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2b6f0b345e3so17836464eec.0
        for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 12:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769804990; x=1770409790; darn=vger.kernel.org;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gKtVDmhXmolTIN8Uom22wNd+fElMtxvh9JofuLlixjA=;
        b=AopV9FAvukpLsX0J+agTYU0KHEMDgFF4JgchCExPCavadbvF1ZNrrTGSkhrsByk/A/
         fxBJ86YqJpv8SRQtFLKHh1Zo3+fBFKfvP64gYSsX0Zex1QAFu1nx7ZeIdn8RxGWAgeNd
         hYoxsEEX9ONIZZl8VRH/7jldi4/HV8bSgAAULcknedlJph44NIX9w2vKlQJ4+8M6pgg0
         niWRIEst/AiJ3JNHUClEWT1jmwL1U3h0NO1YkEBGyfiKuayZQVhMAI2yNorRE6sU3fJL
         /sQZYvkdJbBJZKwNYr6Vf3ZhBWQ05xMlKtR7LCnPshPEZ/qKjRIQTRsCPYLLE0PmikdT
         ROzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769804990; x=1770409790;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gKtVDmhXmolTIN8Uom22wNd+fElMtxvh9JofuLlixjA=;
        b=kseAqXwWmlrTkHwikkzQs69NaYRIojovMtp1tnBR8mi++9JCn4GOrm3aqz3bPRnZio
         UY7dQUU4MqgYTCtcw1/fvinftJqoXWXyl7Nm1niuVP+8onyVwgfk5BB3BszuIDghKgJB
         dxMOrh/9ZavbBDUTWbpcAlCYloKuoKuW64HbeWjIv5RuNota5HZE1wvbQMtk/b44f4Wc
         RVop0tgAATHxfji/3LAIo33W5gDbqgb7sv7d8MO2iCl4Kadxx6ChhRE/vSuUQ3Jb6dM9
         TJLwEFFKob35CSyhH+RuxVuWkSIc1vqyIPiU0GP96u9wW0YCDFFTVZxSFYFGXplVXQ6U
         0Y7w==
X-Gm-Message-State: AOJu0Yze9G4wbaboPCfS33yv+9RGX2d6Jp/wfv6nZatbVrPiLJ5JukhW
	TP+5H9Ahgr5Ite7Pqnk5CSc/nBPt5MIN8XVD5td0Ns0cjqJblj2vajsHyUPGQuQ9/cOgUGVzsIh
	u7ApLtOIkGL8wTn4z22P30ehU3xWoEhz24KN2scDU6NfZHSUQFNcEiTg8WryZZROc2TS0ig==
X-Gm-Gg: AZuq6aJnLN3LiDRGTyFEliDroA6wImSZs+mwSZ7u2YrpAn+U9fmZdgzpU7UiBxwOVTB
	pwtHdsledBkqhse1CMwzaNFB9RvXbfOvzxk3VBBP8vrGSg+hytlOsZS08QrUSOuwU82H7n0YiVl
	ftAGjh/IbvA80kBERmJb0sYpefSOIP+u2B9CQ8YVh1UrDwn7G5ZupQLlKSR2AeNdjZOb+G8hz8r
	/vVwegdtwFUIkIrtZMFKCUiCmSdjpN9N8X7WW3A0tTxskEfXtYNGPHT+GzbRtK+eeD5aw7ETuJF
	5hVwUiYAjr0TGljrDlrCtBy21rqLV9iAvZU/S8rzS6hD1JvJKs3FEVkBPZsP4hVlmPAZrtPBY3c
	KHbWmxBHcZa+3l0TEPnlKb736qbyFsImQtFeL3aOtNvJmmw==
X-Received: by 2002:a05:7300:4306:b0:2b7:f7f:69c with SMTP id 5a478bee46e88-2b7c88ec6ddmr1953655eec.32.1769804989669;
        Fri, 30 Jan 2026 12:29:49 -0800 (PST)
X-Received: by 2002:a05:7300:4306:b0:2b7:f7f:69c with SMTP id 5a478bee46e88-2b7c88ec6ddmr1953639eec.32.1769804989195;
        Fri, 30 Jan 2026 12:29:49 -0800 (PST)
Received: from [10.81.91.45] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a16cf8d6sm12595008eec.3.2026.01.30.12.29.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jan 2026 12:29:48 -0800 (PST)
Message-ID: <ecf412bd-7bd3-42ed-bea4-d7aa837ddcae@oss.qualcomm.com>
Date: Fri, 30 Jan 2026 12:29:48 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-firmware@kernel.org
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        ath11k@lists.infradead.org, ath12k@lists.infradead.org,
        jjohnson@kernel.org
Subject: [PULL linux-firmware] ath10k, ath11k and ath12k firmware ath-20260130
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: c40KrJ-yoWlT7mnscQTBXSUNDGY2pYyr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDE2OCBTYWx0ZWRfX09ALm5avi9++
 eijgOkn8+3l3RQ/cnmDLkbKRJsdaqzJv/IFTmNOKqRjwLRtWu2FWM/Z8lnvuTBR/5JFhB/g5oV2
 FPAX+7cLN4/jll8s+HUgOVu/UKwm0SbL81HkD2pVfvtNd6GOKjLE5P4ysFqMCHqNDK+5o0XMnrk
 9Vfqt81WUEZ+hZyjW6BBauPXInW4weAvt6kNhM/fC/EqLP9JCyI9sfL2Cs5T0Qf6mQy2s9t7Fs/
 MtsPOzIxTXwLzUKNZWrJurNkrCWxtX7F8vAWSWlLEAiB09D0ELVVY4E0fmrawnntGrNTMXq45JG
 qpxw8LADjeMQuqP7K7klWstr8z9OuWp0RBwiYkRgFzPO6Yl4qJ6CHR6iSc0bh8l/nrpLsR4RZY0
 XvBUwOuVHoGgnfcutWfbutX30mO00Doo4KEeL5sMRa/HhGnJviTDER8p/1qiJcFINDfHMO2ZT7n
 bShU+RfqvMKB1uo690A==
X-Proofpoint-GUID: c40KrJ-yoWlT7mnscQTBXSUNDGY2pYyr
X-Authority-Analysis: v=2.4 cv=Re+dyltv c=1 sm=1 tr=0 ts=697d14be cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=xtntLAz0KcNX19M1530A:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_03,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601300168
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-31405-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9D069BE69B
X-Rspamd-Action: no action

Hi,
Here's a new pull request for ath10k, ath11k and ath12k.

No updates for ath10k.

For ath11k:

Update board file for QCA6698AQ/hw2.1 to support:
bus=pci,vendor=17cb,device=1103,subsystem-vendor=105b,subsystem-device=e105,qmi-chip-id=2,qmi-board-id=268
bus=pci,vendor=17cb,device=1103,subsystem-vendor=105b,subsystem-device=e105,qmi-chip-id=2,qmi-board-id=268,variant=QC_SA8775P_Ride
bus=pci,vendor=17cb,device=1103,subsystem-vendor=105b,subsystem-device=e105,qmi-chip-id=2,qmi-board-id=255,variant=QC_SA8775P_Ride
bus=pci,vendor=17cb,device=1103,subsystem-vendor=17cb,subsystem-device=0108,qmi-chip-id=2,qmi-board-id=34618
bus=pci,vendor=17cb,device=1103,subsystem-vendor=17cb,subsystem-device=0108,qmi-chip-id=2,qmi-board-id=34618,variant=QC_QCS615_Ride

Update board file for WCN6855/hw2.0 to support:
bus=pci,vendor=17cb,device=1103,subsystem-vendor=105b,subsystem-device=e105,qmi-chip-id=2,qmi-board-id=268
bus=pci,vendor=17cb,device=1103,subsystem-vendor=105b,subsystem-device=e105,qmi-chip-id=2,qmi-board-id=268,variant=QC_Hamoa_IOT_EVK
bus=pci,vendor=17cb,device=1103,subsystem-vendor=105b,subsystem-device=e105,qmi-chip-id=2,qmi-board-id=268,variant=QC_SA8775P_Ride
bus=pci,vendor=17cb,device=1103,subsystem-vendor=17cb,subsystem-device=0108,qmi-chip-id=2,qmi-board-id=34618
bus=pci,vendor=17cb,device=1103,subsystem-vendor=17cb,subsystem-device=0108,qmi-chip-id=2,qmi-board-id=34618,variant=QC_QCS615_Ride

For ath12k:

Update firmware for QCN9274/hw2.0.

Update board file for WCN7850/hw2.0 to support:
bus=pci,vendor=17cb,device=1107,subsystem-vendor=1eac,subsystem-device=8001,qmi-chip-id=2,qmi-board-id=255
bus=pci,vendor=17cb,device=1107,subsystem-vendor=1eac,subsystem-device=8004,qmi-chip-id=2,qmi-board-id=255


Please let me know if there are any problems.

Thanks,
/jeff
---

The following changes since commit 0882248d05045565bfefe1f07cbfc22276c9f058:

  Merge branch 'lenovo-ish-uspstream-clean' into 'main' (2026-01-23 19:26:31 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ath/linux-firmware.git ath-20260130

for you to fetch changes up to 09167289ec698099435e499e45c5788015d26783:

  ath12k: WCN7850 hw2.0: update board-2.bin (2026-01-30 12:17:30 -0800)

----------------------------------------------------------------
Jeff Johnson (4):
      ath11k: QCA6698AQ hw2.1: update board-2.bin
      ath11k: WCN6855 hw2.0: update board-2.bin
      ath12k: QCN9274 hw2.0: update to WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1
      ath12k: WCN7850 hw2.0: update board-2.bin

 WHENCE                              |   2 +-
 ath11k/QCA6698AQ/hw2.1/board-2.bin  | Bin 986384 -> 1046928 bytes
 ath11k/WCN6855/hw2.0/board-2.bin    | Bin 7056532 -> 7117076 bytes
 ath12k/QCN9274/hw2.0/firmware-2.bin | Bin 15183928 -> 16035896 bytes
 ath12k/WCN7850/hw2.0/board-2.bin    | Bin 2253732 -> 2253964 bytes
 5 files changed, 1 insertion(+), 1 deletion(-)

