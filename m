Return-Path: <linux-wireless+bounces-27737-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D58BAC3B8
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 11:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 68F824E249C
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 09:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C0D21FF4A;
	Tue, 30 Sep 2025 09:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jw2M+syT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E1B23B62C
	for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 09:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759223785; cv=none; b=upwn6zWnr9zVvH/aUTWIjJGRIIwNCVlwDIVAHfZDAnhLqMYTNFmXzZHMs+w77MPpwEAWxVPmKAgwYio0T2hXSg18wa27WgXBPrwtxNP0dp5zWWvbbTAH5eyuaINZ4HMW0sXukDWp3yguJbSY/DH3/xZz452alGNcqlFMr7vjTbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759223785; c=relaxed/simple;
	bh=lJMEJSx4drjfG71rZhzFTS/OoPc8j7S1LaZqaan3iqs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bMSiGY2IJaU7bPCFP/x8W/ouBfZ+996Oo6u6wz9a/4uHwEMRkyblFuiUXfMTIW351EFdpjlBFensb/z7zVoDxziNvbx1WKL4n0sBEQbeDiaF7ux06VGX72CnIfOB17fw5Iw5kIzBsSd8YinnvKO/HAKxHerFVir4oB/03/mBk8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jw2M+syT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58U4Hoi7021155
	for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 09:16:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=XCJKrrgmaDL66Q7yaaKc6X7YICUIwVtqPie
	fT9SBHIg=; b=jw2M+syTYVCVPQnSi6UIBluidvi/Kd8ENqdlIx5pgBAPWjzseLW
	CFDwwowk9Fu3sBd1EO+phUritUosmv1iIgl9g4purH1vsICi3PkOn8G0sJXcUgBH
	NZsZj8jQBH2P3R5pD6lJCHOJTLIFtikCy26yYTIdS9d8PCQ+SrsS3OGYtY7uNVpi
	2KNvce7A6YiLaafupsoubf8OpqHeuhCFW5Cn8NInXya+yfhNow6i9IZskKV1hysl
	HIHxT7fQkof9whJTBV8vERq3C2Iag09bnbKUxWZpX4XaHdBhSByfuHiIUnduCtWn
	8GfHShtuOZi8V9e79flpknQb2B2IW8wrfCw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e6x5rhf4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 09:16:21 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-780f9cc532bso4941636b3a.0
        for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 02:16:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759223780; x=1759828580;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XCJKrrgmaDL66Q7yaaKc6X7YICUIwVtqPiefT9SBHIg=;
        b=RqSQBlB5l+Uo2GzkV+7iihxVbGWznzcLQXA5Io3fJsjpQo/8gyemWviywkBz0D1u7s
         euSSnTbBS13Ohjf0zzgxu8AHzc1ZMJgq6mxtXj/p0RFED2VAZ+AoTUtZqA2ITuvVJtLx
         X3p7fys1mepv2OEkrG08Nx7c+iC9tZG9cix96ZkE1IgJE/pgd6WWwW08MEWdZyAxgasn
         T+5sLw8FavzllD6DNB7mHQbJ6Iu1slz+K+/u6ydoWd9QQprBBnISf6c6bf6GVV2admHX
         a41003T5OCIa8ygN0vW+4VJWQLlyW0yjsYCrsmFzZ1DMmMMf/Bb59i3i8XUVWwhUw628
         BWqg==
X-Gm-Message-State: AOJu0YzbLtdf7bl2iD1OnErGV/rSc7KZQoblRiXtpX73vxujXv8K9aEG
	fxk9JgEzy3OZRk22XTkZRG8nEkbC6g4Tx+/ow/diQJe4lwarc3f7kU+vKl6FElL+tzW5e11Uc5h
	dFwtl1sd6vanxFB8rI5WkiwjSIr1CtPfq2sif10+ZErg3jWdpgNZIrnmn61wc+Ztpb2fB6A==
X-Gm-Gg: ASbGncvt42iHaBzFTvTG/SqM4dTS5NwPi+vGW8tQ7M1FOy84hlXtsYeir3yAuYcZsXw
	uC2GzsL0bp/q48H1tZKqebzV6tweQuY10GX5Wq2AU8cYjngJEM9I3bdDSuVf0YVCt9LHAd08DKr
	tTv023O1fs0AHD46ThEEnhkA4eXFhI6URER4ZPLvoVZF9xhW4FH4oAMJuV1o1G+bYWfe/IM915L
	XPB7cFSDFgSfCEGJj1zJ6wDK/MvdE3jrRiR/Of9/lvQqh5QEtXUv1m+P5oI1lPFBXQMquVw5F5E
	D8mQZPYmNqBKXOThNGKuDoG+wg8TxF0Qzlo7vgW3mvZ8p6+gHqoJck/J8gHX5UIsZgDV6DzdlMM
	wI8wBI+FqOVgmETjcsu1Y0tiw88zuMpq2vpHcP8V0dLyzqHtTk67npKlJtRAnewNLxLY=
X-Received: by 2002:a05:6a00:180e:b0:77e:d2f7:f307 with SMTP id d2e1a72fcca58-787c858295amr4518534b3a.9.1759223780161;
        Tue, 30 Sep 2025 02:16:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEm7frcA2ooc4Zvu11tR6lQz0vE5C6XAaFdpafzAfJK1ikmPVz61Q+9J92XNHvj2SVqacz4ew==
X-Received: by 2002:a05:6a00:180e:b0:77e:d2f7:f307 with SMTP id d2e1a72fcca58-787c858295amr4518500b3a.9.1759223779703;
        Tue, 30 Sep 2025 02:16:19 -0700 (PDT)
Received: from hu-sarishar-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102b26644sm13431963b3a.67.2025.09.30.02.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 02:16:19 -0700 (PDT)
From: Sarika Sharma <sarika.sharma@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Sarika Sharma <sarika.sharma@oss.qualcomm.com>
Subject: [PATCH ath-next 0/2] wifi: ath12k: Improve RX Error Handling and Debug Visibility
Date: Tue, 30 Sep 2025 14:45:49 +0530
Message-Id: <20250930091551.3305312-1-sarika.sharma@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: PqxBFdyoaTVgIRsBetyaqhEmMQE56OSB
X-Proofpoint-ORIG-GUID: PqxBFdyoaTVgIRsBetyaqhEmMQE56OSB
X-Authority-Analysis: v=2.4 cv=ZtPg6t7G c=1 sm=1 tr=0 ts=68db9fe5 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=yJojWOMRYYMA:10 a=DWEtr7Mots4MbkrcYGMA:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxOCBTYWx0ZWRfXzaLy1NiFB1wQ
 SFaqc4KUn4H+I9p91wegaP2nVC9yeQ5OfRrlmdz7L+/1gZOaMb1U9myZVkuHuSUPOZfGtcn4OTr
 tII93rB0MNQljrw07+8o3fYLHKyw3u9NN0y+te38iqpIU8omfVZ9mP+o3nuukMPvPAJC23sWXEU
 drGBBPmH+50P+O46a0M8VhlHrinCL/8qaRN4i6G+O6S7d6GXnUrCSnS1fmW1xMIf9Kpepk/Q8we
 5kRlUcsbukSWiF+1qtWx8T1LHZ9b1gmxfjCaXtQqzX+dUmYxi0GSwyNEVJ0QWZV7hu6AYnqzRuk
 c0wf0CAvNzd2+BGpsN3PDmOCe7gaOhHWL00457qnjhnCoVlOqvTVtJ04Eg7id9kefL7Zjtv8LGb
 mv8+IVNRCIDfnTFg7UBcBFdOiwYjQg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1011 lowpriorityscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270018

Fix buffer leak and potential crash in RX error path. Drop MSDU
buffer-type packets received on the REO exception ring from
unassociated peers, as they are not parsed but their buffers are not
freed. Add debug counter reo_excep_msdu_buf_type in
ath12k_debugfs_dump_device_dp_stats() to track dropped packets
and aid debugging.

Sarika Sharma (2):
  wifi: ath12k: Fix MSDU buffer types handling in RX error path
  wifi: ath12k: track dropped MSDU buffer type packets in REO exception
    ring

 drivers/net/wireless/ath/ath12k/core.h    |  1 +
 drivers/net/wireless/ath/ath12k/debugfs.c |  5 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c   | 72 +++++++++++++++++++++--
 drivers/net/wireless/ath/ath12k/hal_rx.c  | 10 +---
 4 files changed, 73 insertions(+), 15 deletions(-)


base-commit: 58a0a7a45feaf4538841afe8e251737bf7c56607
-- 
2.34.1


