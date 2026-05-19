Return-Path: <linux-wireless+bounces-36616-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yfhyIfq3C2pZLgUAu9opvQ
	(envelope-from <linux-wireless+bounces-36616-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 03:08:10 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3D8575EA4
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 03:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A39F3302529F
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 01:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9095229B12;
	Tue, 19 May 2026 01:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mze0kJSR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FVt2QIJw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB991DA0E1
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 01:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779152886; cv=none; b=mCZwyQYSisM/ZhUVGh7idF4KqcVbtBnNp5+4HvO3HPdFxlke2sLQG6gAAzCIExlf/w5s2tH9fkXwf/Y6HvHbdep4JivjnGJAyE5O/+JhGSoVJXb/8bZmyBH8v3SjdnXSSBQG7ZfRB3EnsncHsb6Bqj7GszrEIRLgxBQyNSFPyQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779152886; c=relaxed/simple;
	bh=eCfqeubpBbRu6UrM584CPr6ai3O7UZL6fDMIov+IxhE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gx9tSsB6auRm3Gyj1hbYJY4Rt3f1ZblOcVEc4IEY0LR6AEAZAnC6mKwEwWuHIyrv650ukmizG31fAtpOqmnEMNj8Qc9VhXQjc381wc6l667xkbpWXgxsimZdkU82d/GZx5oi7ZlI6ripb31/vJLwoCBSJmgXyCDTnXsf3MF2AA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mze0kJSR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FVt2QIJw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64IIhBuP2482761
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 01:08:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=opKCdYGQQeXEl44WzwqwkN/2YDFGtLqnDNe
	ag6cAjQk=; b=mze0kJSRRk95yz+FiA1wMKRg8GeHFqaySr7XiaVdzfbVscIhsdF
	Io/5ltl16dTPdm73xq6oyXMNRPowVB6STSmDfzNJ+3cnsXc+bChgtZYTr6s1qxnr
	akoOk+BZBD5H71dWHkkOz9UM/D/XdIdKkI271r/QWC6bbI0LLb7+80dk56E7dG5E
	QjnCRc0WPXsvaiiMsGKAzYEELbv+FfItQ6z58zZO1VVDKJFgou77/3A5ub90Gyl4
	vcgD5cjgHfz07jad/iLbtMcd40diFpUFtzcZopQTrIFNSnZvPYkdkz1WE4Jp08DX
	/GLQ08BNd3ng/3/ezNhdtnHc71fclibjuIw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e81rvjqxs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 01:08:04 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c827bda2e60so1509228a12.3
        for <linux-wireless@vger.kernel.org>; Mon, 18 May 2026 18:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779152883; x=1779757683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=opKCdYGQQeXEl44WzwqwkN/2YDFGtLqnDNeag6cAjQk=;
        b=FVt2QIJwpVDy5EoMoVxuHtTIemIOhyFNNCoX8+nTlfEll8o5JkdxF/4tO1+Yocnva/
         2PKtj2mtNJtrVmV06AkdE1v/WJ457lFPrIfnGfMSNgZt/w0ck2czRq1SkQmelMZBlsQw
         YhY+imGQcg3RDANpLCAHMIcd0qjVq7PRSNpXy5KBKrMiFCep6oyZS0PjBt/uxpEvQBcw
         bfkOIbOten/3v27694zCXQI142wXSCytes8rukCBaRc4JkzFHIyM0e70805lZ5DcKXHE
         /f1o4gC/o0p8BobWVNHEo5eIs0UWBRoMQ+CFSDMDo9MqcUq+hQd5xGxtjCTbyjtfe7EC
         nemg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779152883; x=1779757683;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=opKCdYGQQeXEl44WzwqwkN/2YDFGtLqnDNeag6cAjQk=;
        b=DeXED/lnpwS1RjCGCiNbLiLhm4e4hOBF26mByOZkFA2wigZlebYwqmIdydfqq1G0Eh
         E4PXjTJAXfFU0UpC9DfgU5sv2Hbmm9oMjiThZcIOJAJRVAWDT3Vc+Q2vAhtc3Mg5Bthe
         I9jhcIBZBGfVzVn1Aj1WMlARbqEC205UKggLJQnp4kxC89Tl9TTq4FiRvEoPprkrMzUF
         aVLyRqf+VxV5pWB39klaZJ5Oud6sknNGfmr4Cd/NnObF+2D8K30KcgtArsWihsjpH9YG
         Hh8XQVEHfmCjn4/3a2TLxj+2VJvLHOcnp63TFnZ9OIAm0SrG/AfVW0vlIKVeHCWflrop
         qUkw==
X-Gm-Message-State: AOJu0Yxm1ttxnrAAD8iBUCVcWwpUVXyZKvdXjODohlaRvhV6fpi3LRlh
	ssfIJtPrAzi8dPMOU4Azuo+Wchs3ATgRbKAO0V3Alu2RB+XpEscBcb20efZ5VEgdvxNa7oSm8Wg
	WFtAK4C8UpCf18oFQczPZVLVHCgE/EUtKRN/MNxf3zVsrBgaxTnmPJcuUpiMfgUoYr/nV7/LjrH
	f/lg==
X-Gm-Gg: Acq92OGpw80sLaqYxVeT/rRfk1hnMKZdZBKE+eomt//tMLVDF62kY1/MYPseud0MAXb
	yxUhHewr9EaT3LEgCmrWN7zAeHwWWgOh209hb52mjaZEAj7LmFaP6DFz2aKGwIDzbUnyY44koIr
	TnKnQ+T7+qcKHvRorYvqznGmQRod3peyLCserOlnLGZB5VUmI1pcnEDaj5rYgtkTSXzWm7U0Ehv
	6TFWmyajTwtlE3CwS6of6KmjeTI1Q2Ic/XeGvlVG9Y99ILPP0jf9ztMN/NVzTG8rISW43J4fYho
	P0nbMQ+kGWixeGWmg/681T2eIji41Olix6DvghajubA/A4I9pHaLbOLuuuJRBAFqX3sIF0m0x3r
	twTBtRXXq39ekgzOhxcFUQxr+yXkxtC6gy1FpdxrvyNJEw1hLCKPR1czfJf/RpwO30watJbkUtR
	fWvwbZ
X-Received: by 2002:a05:6a00:bc93:b0:82a:7893:e14b with SMTP id d2e1a72fcca58-83f33d98510mr17008258b3a.38.1779152883322;
        Mon, 18 May 2026 18:08:03 -0700 (PDT)
X-Received: by 2002:a05:6a00:bc93:b0:82a:7893:e14b with SMTP id d2e1a72fcca58-83f33d98510mr17008227b3a.38.1779152882831;
        Mon, 18 May 2026 18:08:02 -0700 (PDT)
Received: from hangtian-z2-2004.ap.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f1942a83fsm16196793b3a.0.2026.05.18.18.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 18:08:02 -0700 (PDT)
From: Hangtian Zhu <hangtian.zhu@oss.qualcomm.com>
X-Google-Original-From: Hangtian Zhu <hangtian@qti.qualcomm.com>
To: tglx@kernel.org, jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/2] genirq/ath12k: fallback to threaded NAPI when IRQ affinity is unavailable
Date: Tue, 19 May 2026 09:07:56 +0800
Message-Id: <20260519010758.712297-1-hangtian@qti.qualcomm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDAwOCBTYWx0ZWRfX89FwPHNJ8EKC
 dEoKQcx/Pp4R10psu9DW9PWb7CrsY7fAcK6x+pdoMc9Mh9Izsf2AIOPzxLjq1adjv5PKzpqfSW4
 ITuCqgpy0Pz92D11OQzZ2VKGFWVth7m4+V60bNTgfzhrpVkyshoq2n/AJB6GVOrdS3OvVKSA/I3
 tGtCRLLKBADPf3pvqEn3NLInMSfn57pDoWE9r+H5Ld7hRGrDoripGriJ8UYxe11mHe2NV5thbAp
 5ktPLb6Y1o9Tf/bLA8rJ5Ai5DESxRT67+tVyGWAf5VoZaNEoopLCC7XCKNFHQCSWHqo9m0p6xAp
 v5JQxDjZk6xMBCFSqUnMpBZ3nI+bqIbK6JHAYbiz8s5RAkcrVS4pg36h8QUm7B0KR5B+N+1fDVn
 vwonor5Y4utZl4b9yUpFYOfihdhSOYsDTu4KjeeBfxi2c7zR32FAtwQFzAmq/aZpll9EXShF4Jf
 gfO//WHWoPeRU/r+p1w==
X-Proofpoint-GUID: IUicd36eqCxlTX0kGG4X6TdKnDYwl0h5
X-Proofpoint-ORIG-GUID: IUicd36eqCxlTX0kGG4X6TdKnDYwl0h5
X-Authority-Analysis: v=2.4 cv=Lf0MLDfi c=1 sm=1 tr=0 ts=6a0bb7f4 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=wq-1lD5fFhYcRPXe29MA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 adultscore=0 clxscore=1011 impostorscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190008
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36616-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_NEQ_ENVFROM(0.00)[hangtian.zhu@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:dkim];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: CA3D8575EA4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Hangtian Zhu <hangtian.zhu@oss.qualcomm.com>

This series improves ath12k datapath behavior on platforms where the
effective IRQ path for WLAN MSI interrupts does not support affinity
setting.

In such setups, DP processing cannot be distributed as intended and can
become CPU-constrained. The ath12k change switches to threaded NAPI when
runtime IRQ capability indicates affinity is unavailable.

Patch 1 exports irq_can_set_affinity() for module drivers so they can
reuse the IRQ core helper instead of open-coding equivalent checks.

Patch 2 uses irq_can_set_affinity() in ath12k PCI to enable threaded NAPI
for DP interrupt groups only when affinity cannot be set.

On RB3Gen2 with QCC2072, EHT160 UDP downlink throughput improved from
802 Mbps to 2.58 Gbps after enabling threaded NAPI.

Tested-on: QCC2072 hw1.0 PCI WLAN.COL.1.0.c2-00074-QCACOLSWPL_V1_TO_SILICONZ-1

Thanks,
Hangtian Zhu
---
v2: sanity check irq >=0 before irq_can_set_affinity in patch 2
v1: initial post

Hangtian Zhu (2):
  genirq: export irq_can_set_affinity() for module drivers
  wifi: ath12k: enable threaded NAPI when DP IRQ affinity is unavailable

 drivers/net/wireless/ath/ath12k/pci.c | 11 ++++++++++-
 kernel/irq/manage.c                   |  1 +
 2 files changed, 11 insertions(+), 1 deletion(-)


base-commit: e12d2d3983acb150fd987d19ec6a2a530da110df
-- 
2.25.1


