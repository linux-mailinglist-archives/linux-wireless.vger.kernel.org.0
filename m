Return-Path: <linux-wireless+bounces-35365-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCx4NEU872mD+gAAu9opvQ
	(envelope-from <linux-wireless+bounces-35365-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 12:36:53 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9224711B3
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 12:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2837B300FFAD
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 10:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3DF30AD05;
	Mon, 27 Apr 2026 10:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jtHe3VIQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aDLBcfux"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DDC3B19A1
	for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 10:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777285898; cv=none; b=D2Rm762lVxHY2K7KpfVj4Wq4FmMvBrr5xE4mZHZojwNZwjvPKqH2lw1S/qfrc3JzR+sUT2ym5kCXSXQ+StFWRvWIIrU8PMm+yjcFAhhMAJTU4Z5alw2tQskxUr25dGv1fH4qTsn9V/8PwkDMW0p1MH3jVaBZHNs1n27pEZN37pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777285898; c=relaxed/simple;
	bh=j2dBXxKXNRSDA75d47JakhoyCUDr9tYbnS0tQvyDp0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n2Eu2JU3hpfUGX0DKugzExm3jkwDFeqKOzil4vdnz2KVzS/m7q7tWs8AIua7SPfN+b9dA2DbSelMCDs7jc1L+Aq/qzOBMs/haeW0oB7BFn8Xhqft6vsvoLUAcJMJym1UO21X/ziPyw8UNZI1bJ6I+cr+EuyiDrVdvpe4LKEo9ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jtHe3VIQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aDLBcfux; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63R8kH0l3961988
	for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 10:31:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=gv09TPI2227ZiJMzvPU4OIzd2ArvduENZba
	lsUu74Ig=; b=jtHe3VIQe7VVRx+0kNYiy6XkhRDysylQVvgs4LjhUP83GVkBisa
	unjF3O3FkjvLm2fAwFtzd0qdX5Oh+tAElrdH3t+LxJbktnZnVKdSdfKEwF3XA6qu
	Zhj8sBpQQWwCOMBetmvnuYwaF5Yk9bXK11sVXgXnLbDIibQRZXEoVsNhEANiPHco
	aANt/7K6h8/c+vLLkXLRaVU0AgmM5EjTHH2TbU+ZO+m/BpbsEoiZBv0K5mOgAg9w
	1YwCjPGeabxwJmd5m3Vh0c5XXEHpMHBq8xmD+b/4zbHJ3dfrHR0Rke39uCuybxiI
	GZsCh/9Khm9j0dZC/ZyNiqRKlSEFXwc42cw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt4k30n4f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 10:31:36 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-82f6610a6c8so5441678b3a.2
        for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 03:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777285896; x=1777890696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gv09TPI2227ZiJMzvPU4OIzd2ArvduENZbalsUu74Ig=;
        b=aDLBcfuxnQRRdnhaxAtrbkug3Snn2dMbtKrlt3LsWxl56MOgMAfivPuTeyPRMM/VXd
         f8xrz9VmWzWdrR6VAqhE6BfsnGGnbQ4plBmj8ceu3d+QewYZ//Sdu879SxoOatODXWDK
         4qh9SJ8oM+GF7D9FfZpyQWWfOj93K4u/qzaDq6BJOXzc5R2D3nL+zcaUX+38/y71iwN3
         U11BLZRzCIyZ1m3jV4caxO5oLuGqM0jwwnRlC8g5eKJaOjQTgdDxQfW12Xx8Js+djNdK
         EWzUJSl2ctPOb3bVpJCfneOaeYRnslydVoF2N5IH+osVbYkTxyAve+1GFu1JeRGhb7+4
         Xteg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777285896; x=1777890696;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gv09TPI2227ZiJMzvPU4OIzd2ArvduENZbalsUu74Ig=;
        b=DwoBhhSviK9p4CsSDojx9kT/IbXnx3jUSJqXmkF/A9rZ5zfLutBBTDj2+yBOS+Xf/D
         PmT6mKrkG3qxTGI+emPY6rkNM+hDl0koWnkgyzs4Ghqpk2xkRBiSqg0CzC0l9bKghu8b
         Pqei/XA2CJzAhOB5TXVXJlpY1x5YTiyYjtdn+X9bhiJGwvXcmEvKpfzkB28Fv/gJs1v/
         ngqA8N4irTiLfX9hpDP7oC8qPJ7gVJBD+1MJr86kIDs+CFgB4lPgm1AVS9YSqkT7imN8
         ngVTmxdvlpW/cq9qtREOstrCyGRp0FjWlDtBnpRT4vD/qa/PIqohyoil+P2zCNPRapLl
         0D5A==
X-Gm-Message-State: AOJu0YwqpkQcN7LhOV4TW7c/FaH+Qt0q5jtbdh1KXtvmTqpDFKmaVA60
	oY9XR8QRPGjrxG6KMdkDVBr1fA2KcniqcpvRGt7AJgLIQ/S6W1mQ5cP2deLaST8m1GDYWs6NeHi
	977GQts5j8DKzE7XefxlXgXbJ7lageER0dOWbx97Y/kZseZ4nNgTCU0XmQJ3YoQKWPVtvHA==
X-Gm-Gg: AeBDieudifi1QgGaN0WAqPf2lOf8o76hpw/MGKkQFsnR5h8A19X6OFG0ZTtZ+ySITQY
	M4v42LRabaY9mtTqUhwsDAHnLVUtEzV78o6prQi0+7+HBFikGpTqvYNuLNANojSmPaoG6MXO79c
	qkPpfgB+n/0mcQGG7bsulg2CStxIS2/9HuBdFoFoBaIGXW0FEXFODDpsmLtXulVHBTaFaIGeADi
	qm3j1xhYBYaugMeaPvZfHtInrhysM2TEYMgAH8imhAxB4OVEsDwRAquaamTc1LJYDGshn8BI0a6
	mmdK+bPtsAAYOqHRLEKHceyJqTUkaX7HsMdB9rzWs/xHfPN6yXLZJi8YINdFLdR+0coyziEA9Bi
	Sbel/u+9/jBpe/8RwJksCfPMO7ts4Fvhgqls6jiLDVlJ5JmJdTHXvS3TlbGDFT6+CgvkYEe8EPL
	H0zsTHfZKhkYNA+1y6NtrCG8LJHi2FHAbQKTf7uCTUrgCy1pMv/YNrjiYxHoNP
X-Received: by 2002:aa7:8faa:0:b0:82f:7ba2:e120 with SMTP id d2e1a72fcca58-82f8c8beec4mr31641281b3a.28.1777285895572;
        Mon, 27 Apr 2026 03:31:35 -0700 (PDT)
X-Received: by 2002:aa7:8faa:0:b0:82f:7ba2:e120 with SMTP id d2e1a72fcca58-82f8c8beec4mr31641259b3a.28.1777285895008;
        Mon, 27 Apr 2026 03:31:35 -0700 (PDT)
Received: from hu-ramess-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9cbb1dsm34626181b3a.14.2026.04.27.03.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 03:31:34 -0700 (PDT)
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Subject: [PATCH ath-next] wifi: ath12k: initialize RSSI dBm conversion event state
Date: Mon, 27 Apr 2026 16:00:11 +0530
Message-Id: <20260427103011.2983269-1-rameshkumar.sundaram@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDExMSBTYWx0ZWRfX5d78BMC8Q6ab
 Efk50c9XBRs/5ouhnd83KP7Cb9i1aNxL4dVpiOajDlFn89RrHLOTa/GiTapEGD0oV/lPAPfxnF8
 OFj1S8fk5C6/NtwNVeAsMuwPqqLND1+g4kxlzLhg6+fXBRtYhPe0fEKLfb6VsEzXvq46UFHkw3I
 Zo3WyulGcVAaSsF2wqde6C67TmOd1FGcT+LRHWxh1MS+ft8cgQWYTLtoAx6+c8x53AP3iGjdoaJ
 na4yURulSJD4bEHkvzw7gQuu9QU+Hk27MtZmswU2jPP0cVo3tkh8inE+48lcTKLpvVOsvLs6n9/
 LbUS738f85sDYnNs4AR6X2ALfKx/4t/k5kLzhCoIti1zKMOs9ldGGUlEOJ7i+PFJyh/VoiyIVrS
 g2ketBuDyr6YDwTXck6NUiC6QEGlwiErNNdo57mFkOQ5RcEeoVXdABlVT80YU9moXQcXv/Sqzzz
 B/bLdZApz4utuf7pSVg==
X-Authority-Analysis: v=2.4 cv=a7QAM0SF c=1 sm=1 tr=0 ts=69ef3b08 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=Gc6irwjrgtZuW1ZZY8IA:9 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: gUIZBqMKJ3bWHqLHquyW5c029lB3SI5s
X-Proofpoint-ORIG-GUID: gUIZBqMKJ3bWHqLHquyW5c029lB3SI5s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270111
X-Rspamd-Queue-Id: 4B9224711B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35365-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

Currently, the RSSI dBm conversion event handler leaves struct
ath12k_wmi_rssi_dbm_conv_info_arg uninitialized on the stack before
calling the TLV parser. If one of the optional sub-TLVs is absent, the
corresponding *_present flag retains stack garbage and later gets read
in ath12k_wmi_update_rssi_offsets(). With UBSAN enabled this triggers an
invalid-load report for _Bool:

UBSAN: invalid-load in drivers/net/wireless/ath/ath12k/wmi.c:9682:15
load of value 9 is not a valid value for type '_Bool'
Call Trace:
 ath12k_wmi_rssi_dbm_conversion_params_info_event.cold+0x72/0x85 [ath12k]
 ath12k_wmi_op_rx+0x1871/0x2ab0 [ath12k]
 ath12k_htc_rx_completion_handler+0x44b/0x810 [ath12k]
 ath12k_ce_recv_process_cb+0x554/0x9f0 [ath12k]
 ath12k_ce_per_engine_service+0xbe/0xf0 [ath12k]
 ath12k_pci_ce_workqueue+0x69/0x120 [ath12k]

Initialize the parsed event state to zero before passing it to the TLV
parser so missing sub-TLVs correctly leave the presence flags false.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Fixes: 0314ee81a91d ("wifi: ath12k: handle WMI event for real noise floor calculation")
Signed-off-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 484fdd3b1b7f..1e2e1fddd081 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -9689,7 +9689,7 @@ static void
 ath12k_wmi_rssi_dbm_conversion_params_info_event(struct ath12k_base *ab,
 						 struct sk_buff *skb)
 {
-	struct ath12k_wmi_rssi_dbm_conv_info_arg rssi_info;
+	struct ath12k_wmi_rssi_dbm_conv_info_arg rssi_info = {};
 	struct ath12k *ar;
 	s32 noise_floor;
 	u32 pdev_id;

base-commit: 7aa24d964a04648b547197c22364e2b76aec096e
-- 
2.34.1


