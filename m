Return-Path: <linux-wireless+bounces-22451-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48982AA921F
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 13:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9613216F893
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 11:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62092202C31;
	Mon,  5 May 2025 11:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cXhbpPU8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866C11F948
	for <linux-wireless@vger.kernel.org>; Mon,  5 May 2025 11:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746444989; cv=none; b=uDe0vsRcYTpaUErlH9OK1tS4nFl2BxC7N7TeyAQ61RPok3G98pwvnF5g+K6w3iOVAtotJLqNzfFl0lCkLFOIUzSBsHiB7T/1igQiDwyqDQK89JCbj5+cTlbvlWn9RlZWFecZH6ufXGB163coSun9Wnc2VVD6Il+Gch1tKbJwypI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746444989; c=relaxed/simple;
	bh=ofqC0RoSF97Le0fhXTG2VW0oNvarap2Z6RX4pswfXU0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=fxwLoBTjcUgB2keb6C4qjduq8YtAkqqlsOCivn8CDTeP9yc/sWdMHes+K4S6MEPaKh/PfVIajNi1y52eVPsPHCaLT3taPJbNpPoPpB8cpizaxKUbJfv8rZUfyuh14qPsidQrtvW9hb/R8jYzHRnNtnZ9xb/fGjHY0+njN2DE7aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cXhbpPU8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 544MhJMC002441
	for <linux-wireless@vger.kernel.org>; Mon, 5 May 2025 11:36:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:message-id:subject:to; s=qcppdkim1; bh=ZYt6qh4c3aG4
	BDhCS+7MrnJ6uABYUDP6r1QWDhraVSU=; b=cXhbpPU8ucScsaU1jPaSSJbR6weA
	cOHfioltOJMTLjKq9Njo/bylhBtjZQh8SQylKcnnjLg/gNWiL5mwE1UXSxvCGyQz
	hHswbCfi0ZZsIleICzkyKE+AEyfdxVEeQwX1KQpebRK2vFuQBCW1qE/3T2e828g4
	n3VdwB0sA9ENQPPh95tl70PYAllFox+V8byM9yAEQdDQLrm0LXvk16DvVNnJhH85
	JrWOhUs6HwI4Dr92miprtjqMFiGEfZCJle87Pns9JN0/TvOcDTDtdC9bVILqBUnW
	VOdCADG2H0jbJshYQgHLhUqAvgnxlnchxCul5Pytna0KBc/c7U4KXMANDQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46e0xstegy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 05 May 2025 11:36:25 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7391d68617cso4792022b3a.0
        for <linux-wireless@vger.kernel.org>; Mon, 05 May 2025 04:36:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746444984; x=1747049784;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZYt6qh4c3aG4BDhCS+7MrnJ6uABYUDP6r1QWDhraVSU=;
        b=jK6TvwXCzQ1p6TNvm425RYU5o4DRu6h4QPgFgnr9KJQmkYQ48wksdUjfyyqtPZkbmP
         AZVMzTJV1gzcr0MbG35yP1SqKXZWPZ8mawXfZDUH55VimPToTnNJ0gry8fi5Q2JPTFp8
         fh0HX/Y41XM59hHAGpFgdgBrO0S0OczSKY9z/JWW4hkuU4QWDnZNLShh1NpQawmQKVOd
         WwpTixZ95Weu20NKJ+bI8fZrYDRkR2NhXgB0rpVWO2ye6U0WfalCd8Upk4nQskxE1b2F
         f5jPbRoz7WFlXwboEHJb0aECLwcWwRhp+pH/+o2Gz9JJLAIRZIdFsZpdrH8X1/LTUhDS
         oNpA==
X-Gm-Message-State: AOJu0Yw7clFSHg+43R6eeDqxsscaidQ35ZIbxgNjgcEBEzhc5Z5z1E6J
	nueTKH/s41HfnzawifraJowvL+IUabqvXQh24ejgGzmDUU/g1uJQgwKQKE/O+eA93SB3HrZAi3w
	Bz7gLD9+vcsWj0xsJVkJe3dnnmur0NlV54sqsAR5tPGg3lWn0DojeIoO07w7DE+fBJA==
X-Gm-Gg: ASbGncupv3iTC/lXAt5x3xEQnXca6Cd5GeaeSXpa1RXnGdgdoGYYtB2wO/PNQ1TFrYE
	ETr5Bvu5Hw0CeZIUpJCPOIY/64qPJB29FcjRv9bWHK4OCvyvj8VX/sYQdB0HN/ePerYhfB6L5sd
	69FBtqXU+H6eVkZHQtSLhrfYD+ZGh/LiuSlDHcubz1zKEYrzpaxqRsshQXKAqektP54PVNCNL3x
	tKXYB9Yz3TV6EvpT1LDbTlTA0vCrf621aqZ0706bPGogxpX67tFcF5gNWboPJ6oDMAAIRsdzMXn
	u7NtFUJFM3QONe+9GRBzNJcRR0csdM46OyD0ikg3FKaoKZ6djeYmBVZcRrQLHqnWwYDQtOK3TVe
	Mh+Wq4l/sJ2nE71ymM7eeUt/OBDX5PvUc34rVn1Qo7sN45w==
X-Received: by 2002:a05:6a20:6f96:b0:1fe:61a4:7210 with SMTP id adf61e73a8af0-20bd6e49617mr21787574637.2.1746444984551;
        Mon, 05 May 2025 04:36:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRjg9Mf44TQ0IFpIyDEdbEp7UOJfSHHIb36CPunkp0o8qiGwdoasGtd9EnaeU15RY3+CGmgw==
X-Received: by 2002:a05:6a20:6f96:b0:1fe:61a4:7210 with SMTP id adf61e73a8af0-20bd6e49617mr21787540637.2.1746444984159;
        Mon, 05 May 2025 04:36:24 -0700 (PDT)
Received: from che-siroccolnx03.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74058db9200sm6497067b3a.42.2025.05.05.04.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 04:36:23 -0700 (PDT)
From: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Subject: [PATCH wireless-next RFC v2 0/2] wifi: mac80211: Fix Rx packet handling in multi-radio devices
Date: Mon,  5 May 2025 17:06:17 +0530
Message-Id: <20250505113619.3654343-1-maharaja.kennadyrajan@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-GUID: RER9CjkibZkZWpvFHDLOnaY1LzniiLSN
X-Proofpoint-ORIG-GUID: RER9CjkibZkZWpvFHDLOnaY1LzniiLSN
X-Authority-Analysis: v=2.4 cv=bdprUPPB c=1 sm=1 tr=0 ts=6818a2b9 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=d07TIHH5PQL_qa27likA:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA1MDExMCBTYWx0ZWRfXybx+dBLnjfTN
 AQ6/cj9TqdRtx3oHUSeSEVMR6OlfECvrRP9IU6BGUbElyeqkG8UaAu1KKn4FreM/qZivBbp7zDm
 AGL7GqL68olo2Wv7Xe7efWCusfbA1G6560ON/esPyh8Rxz8R2UwhXJ2lGxq3bfg9OyCaURIbNEl
 1+ngvwrwqYFQbia2bRDEXEFPcdZ5vZNT6hTlHbfp/2Wz8e3JzHm5/L6OQm9p0DYKzfL7L/9TIZe
 31ccouhhfLEVV4+x3YXvfR6ijetTLJMrU4xJ9m5oAJp25b8z5gPjOvJkGaG3KlHJJzwMgQxH2Ov
 27q3vfrujAn3+aVjly7hwdFKDP4CK5Ex5PUzBhrSHe6K0wZwlE0nGlPgxnuTNQrGwze6tEbJNZl
 aPzxIVLGLUAD5PPACKtVPdC25/tUipfdCwWdSIM9S/2wBgfrXJQwweJknt8WJKGPr9fpOcj4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-05_05,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 impostorscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505050110
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

Marking this patch as RFC to seek feedback for the functional change which
mandates the ieee80211_rx_status::freq for group addressed data frames to
fix the above Rx packet processing issue in multi-radio devices and
following the current behavior (Rx packets are received on one band are
processed on an interface running on a different band in multi-radio
device) when the ieee80211_rx_status::freq is not reported by the driver
for the packets received.

This issue is also likely be applicable for Mediatek driver (mt76),
the other driver that registers multi-radio device (also seems to report
freq in rx_status).

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


base-commit: 885e5cbaa0ee3738fcd99167439459ede2cc102c
-- 
2.17.1


