Return-Path: <linux-wireless+bounces-23356-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B64AC2243
	for <lists+linux-wireless@lfdr.de>; Fri, 23 May 2025 13:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C8F55002A7
	for <lists+linux-wireless@lfdr.de>; Fri, 23 May 2025 11:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDF82288D3;
	Fri, 23 May 2025 11:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bGLwNQP7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC75B5D8F0
	for <linux-wireless@vger.kernel.org>; Fri, 23 May 2025 11:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748001535; cv=none; b=f/nkJzNXzTzQKy4TJch+pFumMgaJg0RNUJbN3oD+1BlAcnAOaF/8LAf9IMf5AZWNID2iKbqRbuzvKZlIoXUl5P2MiJwJCVV0PFK9iVKT6cIyKwlHLsMvTwnO5Sz8TSD9bK+k/FYnj9jmY61J58AoWkegVG8DwUqI43ldSfUJDOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748001535; c=relaxed/simple;
	bh=PIK8h5fB9HNCjBGJroQ7es0PuVw5l6LmKA9EJkwGWz4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=pDn0bpfjoqP35j7PO6enwM1nChnKbxU8a2pof4wf5OFpooY274G/HiHJZjNXVW01R6Qh4GS9jwA9YXOOkBc/xMHguFhZJb4K7qcZ0pWk7AtsrrXoFvLEZHScn8vxQtaDqiUmPS1Ks+UApa0fbdnVO15xT1indLuJJ68sWZUNKoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bGLwNQP7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54NBZo7e016599
	for <linux-wireless@vger.kernel.org>; Fri, 23 May 2025 11:58:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:message-id:subject:to; s=qcppdkim1; bh=zdZRyypIFbKr
	kbP+Xiy12Ar4ln4NLwIS9unPSCtxGMM=; b=bGLwNQP7CdHJ72IFFf/YkpUo1+rm
	Q4/AStcRH2q9bytLiF+2x+//jXj3QU+btlp84bm3Fdu/mlQqs/7pob3L+Zo9ksAW
	0r6F4nWYok3AXUr3TQ6NTbZsSx9iVRUXTUfXO1iFvYFA0+5pTKPgo77rZ8pABVxe
	BPxkWRuyWtXD740hw037SWiJCSk6oyp74KMBjXxE56FbLPVuQEnjhqOGVaKq7IFN
	lOgZwPRZxaimqHqljz6LG09XfpsDgSXyUv028OxZ8JW7qNAvCX/z4+lo4bIce0SO
	eNf9rWueK0tHBoEM+TJgeFeZd0quKfrs/m/hQoB7+nZkaHSGdfBHzdGB+g==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwfa1yh8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 23 May 2025 11:58:52 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-231e6e1d988so101227425ad.1
        for <linux-wireless@vger.kernel.org>; Fri, 23 May 2025 04:58:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748001531; x=1748606331;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zdZRyypIFbKrkbP+Xiy12Ar4ln4NLwIS9unPSCtxGMM=;
        b=j5hg4uA0D4PMe1+CkN1HgzatG6efeoqln7zWluzVAD23LGrd2mPunMTrLxIBS/cq2h
         n9dc3FtGHIPMxZQYb5cWM0rhKmAY8gwIgqKvdOagQHYaPByqPlxgk/h9C/htvo+0oNkd
         VTbzwyJZnXlUNIFCG61oHos1ZTbL906YnBk4se2AHWcqJNWkUHomJDFcXzLRJnACrySj
         o+j2kuQpfwFa5OVeJV2747ZsjqY2fuCW2yXWZ/RpAGJ4UnOyJ+ennBI6VUkPEseCpPTH
         gPtwIRPE4TWGXwc6KW/jNx4ocRkmLQipAaQKtbd+GdVC0UuYTeBJBi1D+6yWztPki2a+
         3uxw==
X-Gm-Message-State: AOJu0YzC1vm84l3rbrx6ax7uIwhpAesPs18Q/AaLs+F1Uvx3/HLj+Mev
	3KHX9mJwbI3oOm+1J4TE8x4KDLARToVQoI8QVyi2sduUvW0P6JzhB2LHDJi9AX7CtiY9dHod6Kn
	H7VcWxGcBw+iGHeIlm1QsEr18DCswqHs2WQtisGQSLTISiHLNb6XwJrpK1jw/wlK8/ywhqQ==
X-Gm-Gg: ASbGncukql9bAH/9qQSsQ177lpoPfS2wUGTp5neufIIeMsDuU3ZfCJUfcoclP166pUk
	RbsBRTBLt3nHyYgLXWxRqpuWdkKx0Wsa4yHB2JZzExfDyuk7P/v05Oq/5Jhxe1ZbOoBlOMmzU1O
	B+UXAoh8YRcCLi60rgY8l20rV5AuZGT8wUe/Tp1EPmush3xvEdskSfUTSJo9cT/bUZTKB/ZCwCY
	5Rpz+xhghH61ukPij/zTThXOqQpOMq92ITxzPbCJwQO09l3XTDnL0bZmq3G1xVvmMLORxLEw9dr
	8CEBFbGEbYZmgeNCE9KukFerMe8GP3yjTstoHfsjQd5crmj/ZXhtXB02E5PgZTmAV7XrMYflTxt
	nGo6+pfp3V645htDpKCzruNnkCmSnHr80XQsX4xqNVurNcQ==
X-Received: by 2002:a17:902:d543:b0:22f:af3f:bf22 with SMTP id d9443c01a7336-231de3ba64fmr384259765ad.42.1748001531327;
        Fri, 23 May 2025 04:58:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGjBU4Rgu9PAfbwRi0Tesfp5YChDH/UqLil9fD/H1e5Ia6aErSdPzMcKss1TwCZX4RaOwxJA==
X-Received: by 2002:a17:902:d543:b0:22f:af3f:bf22 with SMTP id d9443c01a7336-231de3ba64fmr384259555ad.42.1748001530921;
        Fri, 23 May 2025 04:58:50 -0700 (PDT)
Received: from che-siroccolnx03.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-233f9e17e3csm7210725ad.177.2025.05.23.04.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 04:58:50 -0700 (PDT)
From: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Subject: [PATCH wireless-next v3 0/2] wifi: mac80211: Fix Rx packet handling in multi-radio devices
Date: Fri, 23 May 2025 17:28:36 +0530
Message-Id: <20250523115838.481402-1-maharaja.kennadyrajan@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
X-Authority-Analysis: v=2.4 cv=V9990fni c=1 sm=1 tr=0 ts=683062fc cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=FYtan9AznsI-kIebVFUA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: ezZy_V1hhlTpj-oK84G2_ej5iMomC2K4
X-Proofpoint-GUID: ezZy_V1hhlTpj-oK84G2_ej5iMomC2K4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDEwNSBTYWx0ZWRfX7mxdf5WDuURd
 Ujp8+WmLKNnJRVHMKzgqu4Ua+AfR86FvpyDegcpXA1hJojgzpwBuw5VOYlfw4Q1t2rB3IlaCwLZ
 DtbMmE08OGTdgEJVNT0hpUVog8CPvVlW16EcDaq87UiMlhIZZv+rPgzXm+LFIWrmJoiPYuOkx2b
 yVcBAOvUbUups6ZllQddmyx4ybUXCy26x5UAeyMHaGtk4Ev636A/4Abork3xBLFwconoN1UBBJS
 wuxQApzLqIqynvrBywvmQllR1zrMmagfok5VAYRRfMiTi4DDLjzUY2kz0mNjiP2UnVQ7RU8ekhG
 xmmjZV5Cx+r2B4nE+KZ6vtpuhSWlIfanZWwyA4ylKsVqXKY8xRODHhGoEp9ErNIUxqkirGUTjI7
 aO4p7jNLVl8wOFmicNMcqxv2E9eZQXBBLXYt05A2txiuUgE4blSrPs6TSbL1RgvS6ojU0HuD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_03,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 spamscore=0 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505230105
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

This patch series addresses issues related to the handling of Rx group
addressed data and management frames in multi-radio devices with ath12k
driver. These frames don't have the destination station information, unlike
unicast Rx frames, and are forwarded to all the active sdata of the device.

This happens because currently there is no check to ensure if the sdata is
running on the same band as the frames are received on before start
processing those frames.

The patches ensure that packets are correctly processed and forwarded only
to the appropriate interfaces by mandating the ieee80211_rx_status::freq
for group addressed data frames and check the operating frequency against
the rx_status->freq and forward to the appropriate interface when the
frequency matches.

v3: Changed from RFC to PATCH.

v2: Addressed Johannes's comments.
    * Changed to for_each_link_data() from for_each_set_bit()
    * Removed boolean variable and return with bool value.
    * Combined the if condition.

Maharaja Kennadyrajan (2):
  wifi: mac80211: update ieee80211_rx_status::freq documentation for
    multi-radio
  wifi: mac80211: process group addressed Rx data and mgmt packets on
    intended interface

 include/net/mac80211.h |  6 ++++--
 net/mac80211/rx.c      | 48 +++++++++++++++++++++++++++++++++++-------
 2 files changed, 44 insertions(+), 10 deletions(-)


base-commit: 0b0ff976af94fc2437b62e3798f11aacc3798613
-- 
2.17.1


