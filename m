Return-Path: <linux-wireless+bounces-29654-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16076CB5E7F
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Dec 2025 13:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 152D53018432
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Dec 2025 12:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2AC30FF36;
	Thu, 11 Dec 2025 12:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FBL0BpxA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NvqM+zE+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9875230FF37
	for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 12:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765456877; cv=none; b=X/DTMMl2xV4egEbOxM9CyMmKY4UgUNjcKkA4UR5SZA+sy7CKXhFxJDcxeldpXu34PlygmN0TOuiUlY3GxlzRxzXwdLyS4//CRWwu3n16hFvRZnrPvR3wEbVTI0Wl3YOClxjObrFhrEYs+molswZAp88LJErJHyqQ7TaWZsgB3XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765456877; c=relaxed/simple;
	bh=MyJQnw+6Jktuo9+TWloqvrOsjRlcvai3tQlZki4o8uM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=YNJM5DPEhJCqbEQy8ktTKOG1q95/vewqiVY3MtxbE/4xGmxCQb9adN41L+NkUHj+vl4jhsBZfYJ8zgHqgpUeQUonlmeRsOuTNqRuapWeVXv3X1hCZ3e3NO8D5Xz1wYl/T8voUosXF4e7o5uabknXsKT885TSOMBxEd7sW33etFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FBL0BpxA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NvqM+zE+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BBAXpoa932685
	for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 12:41:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=6gqFUWKAWPtd1VYfhkpI2m
	H23MplIJ3Q71u+y/1Eerg=; b=FBL0BpxAszYsm5av4vy1MckX3UpiDxgqIBjXZU
	yIIlGa/PalMiJG44Zi0G7unEFe7cm3pb0Mt7/R05XHmOjQ51KkQDsFBqPLzbJW3b
	WeTOE3oQsfW1m6EaDTpulbj59mhC4fA17d9/G5Zd2Kr9YwViC4QTPOlnMn27u4fZ
	pXKcXYrvfTme7AcpC6M/1VvV0zQlEjlQ3y2yH0wSMq3vnlwbBSYtpN55YwW2VwaV
	YJ/0NZDEwYqGA8zbVEhj2QrEwApPLbsoREf8aPl+0pgLXf39PSVsCnNhkhdL6XPJ
	kLbl9+csg6vO9cUtXspTYgS4XncKcJY1nM27nChRQiIMk66A==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aym581wy8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 12:41:14 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7b80de683efso14707b3a.3
        for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 04:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765456873; x=1766061673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6gqFUWKAWPtd1VYfhkpI2mH23MplIJ3Q71u+y/1Eerg=;
        b=NvqM+zE+yJzulhIIryafAl/KED1UeZjbLvFwt9p5ZNiCf7sEVKCG7TTDoU/yJfKEYJ
         kHshck2Vsibda1ygxOdThQ3eXK8aJDXLQiYqWH4LdmtPOfqTAVCowQ13JBz/vUoRB6uQ
         A4QE8Le0JH4efJ5OK6XODNlHGd9knACFUQwnlx+j9WOdhuElOldmewqjQee8hfhdAGCN
         M/BSql5zCFIXHeRFL4OYak+vGcjzUvSqQbXss37UUsn/hGhXD3flBogwGjqTmKF6e/61
         Yo5/cHYQhXusG0Tp/WCkbZiyCK1Ut3ANzhgIrYCj6dweLn9sBP+O9r/LRd3PD8mv+X8t
         Kztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765456873; x=1766061673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6gqFUWKAWPtd1VYfhkpI2mH23MplIJ3Q71u+y/1Eerg=;
        b=m3qvQYk/PlFxAnlISlNIV8JkHSrvanNziC/weBGog5O8rU/5CghFHkySbtDp7qks67
         QJKZPXs1d99dFYA0MS32//k8hyuH+9Kc9MCdYIN+g/6h1HaV6EQcFSDrboF0txBmkS2W
         9zZ2++qay2Q6aVU4LtLKPonhvATG46WBFlf/7YLRY7vudVo+pH8pPQMBQ3JAM3xSSG1l
         tOL7SLGMpv4ujJl/t0/BKzjgrlm9gFDlywqYaaQAL03cy/tBbR9NTe1ouTZeYtXLThf5
         1gbzdFpOt+pyGOQ7EOvrCspQwle99vpsXTN7ddPi8pkuRs4JbgamgMowJnVmVTSqKqaF
         Ux1A==
X-Gm-Message-State: AOJu0YzoKaHFc7jvt7hxeEvFz+n5m3nycJrQZdC/+N75egtjJ4iNRxHm
	MgdSZlQ0TJ3nAzldMtY8CuF++jPtJ/ZMWc1EvKZidwtmBWfqFEw1FIgMYFMnwBTD0NrrhpCtclI
	5ZqtTJFPPInkBr8LTFiIoYbWmHp8fr9bN72/ZpSesPuj2ES5kCWlw7Mioc7atVScfxoLHxA==
X-Gm-Gg: AY/fxX5UgeFWd6axRGF5gZ3CDNehbMgQQ/N1U9ODXcYTzIOnH/8C8OxhYrQhbKnF7e2
	F6opMqM7poCeeWd0vfE/nfqQaZJt6YEbDLqcmDZoXY0LeQ0QStG08Xg8LWGvfx2G2HnfQ6WfwCW
	i+EXaZOtcsyh3WAMiQ7YLkvRv+5bpU9re8JYg80hKazhxbE1gc614fPubFiQqgBZgXCSbQazbSG
	+Kxkimg4k1/rfE23XSFopbBerlnVdVQvoS0EWPHSKfiKDCyrP+pS3AtmH5PBigOtDgHWUAXj9jM
	VAd1EJ/6y87aN5GuKq59AYWbLl7hKIo30lcqvozWwt/v3BbpK7OTqyGOfddeajkT4cxB2SB1l9y
	9V2ZCO6JAiunYTBCGJ5FJM8Ytgx+CuQxzsxh45jU9QQ==
X-Received: by 2002:a05:6a20:7f8e:b0:334:a784:3046 with SMTP id adf61e73a8af0-366e299c856mr5285229637.38.1765456873195;
        Thu, 11 Dec 2025 04:41:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjpXcDENcEpIWD7IcNsQQ4G92I+bcjDr5QATd4/T6yshJxOF3pd1VCkt1olFhGWO83dgTvOA==
X-Received: by 2002:a05:6a20:7f8e:b0:334:a784:3046 with SMTP id adf61e73a8af0-366e299c856mr5285210637.38.1765456872719;
        Thu, 11 Dec 2025 04:41:12 -0800 (PST)
Received: from hu-kkavita-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c0c2ae4e163sm2272297a12.20.2025.12.11.04.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 04:41:12 -0800 (PST)
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com,
        ainy.kumari@oss.qualcomm.com, sai.magam@oss.qualcomm.com,
        quic_drohan@quicinc.com
Subject: [PATCH wireless-next 00/14] wifi: cfg80211/mac80211: Add Support for EPPKE Authentication
Date: Thu, 11 Dec 2025 18:10:37 +0530
Message-Id: <20251211124051.3094878-1-kavita.kavita@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: hKX0nuG3PzPMja1-Dghniz7aRNGAN9cE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjExMDA5OSBTYWx0ZWRfXxR48wZiKxcNv
 E09VV8Iqesptd4//aPhOWtjj+ztnwkD3SffhdTQ4wzKyRmE9w2rRz4e9wtr+LZ2D+c0BpSuka9W
 Cz8VVGaT+MgOi8j1bDJ79AkxGa/HSYkQ87dxovAfKuhN28HPYOVp0xYRSe75H+RV/dDAZEvv+cE
 CRoFtLWpNhkb24UqC4XmiQYyhl89vQp1FtscR67GMT5G/2MMpIGNg2QrKeOCOJNsJtMMpNznyGp
 a19HWmMJrUZKZdBykfw+yAyFDRd0xni07T4M3s/pjewXRqdIPVGGdx3uTag7dayQKMs+xyY2xkE
 fXBnrw8xnuiaKi/G81c12oXP0A1+IJkJPPJ3TJvOJKs8TRC3aqQ/7qBjFQR8D9tBoT94U+ugCDG
 cK+5doezUvk+IY9kXOgH5QYLHCZnAQ==
X-Authority-Analysis: v=2.4 cv=FYU6BZ+6 c=1 sm=1 tr=0 ts=693abbea cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=V2s46UuLLyq37hX4-LcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: hKX0nuG3PzPMja1-Dghniz7aRNGAN9cE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-11_01,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512110099

This patch series introduces support for the Enhanced Privacy
Protection Key Exchange (EPPKE) authentication protocol, as defined in
"IEEE P802.11bi/D3.0, 12.16.9". The implementation covers both AP and
non-AP STA modes, with clear separation in the commit descriptions.

The changes have been validated end-to-end using the hwsim tool.

During development and testing of EPPKE feature, we encountered an
issue in mac80211 related to incorrect AAD/Nonce computation for
management frames when MLO address translation is involved.
Depends-on: [PATCH wireless-next] wifi: mac80211: Fix AAD/Nonce
computation for management frames with MLO

Without the patch, EPPKE functionality will fail for MLO connection.

Note for Testing:
EPPKE relies on SHA384 and SHA512 cryptographic support. By default,
the kernel does not compile these algorithms unless they are explicitly
enabled. To ensure successful testing, please enable SHA384 and SHA512
support in your kernel configuration.

Set the following kernel configuration options in .config:
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_HMAC=y

Ainy Kumari (2):
  wifi: cfg80211: add support for EPPKE Authentication Protocol
  wifi: cfg80211: add feature flag for (re)association frame encryption

Kavita Kavita (9):
  wifi: ieee80211: Add missing AKM suite selector definitions
  wifi: cfg80211: add support for key configuration before association
  wifi: mac80211: allow key installation before association in non‑AP
    STA mode
  wifi: mac80211: add support for EPPKE authentication protocol in
    non‑AP STA mode
  wifi: nl80211: add a new netlink key attribute for Key Confirmation
    Key (KCK)
  wifi: nl80211: add a new netlink attribute for hash algorithm
  wifi: mac80211: add MIC generation support for EPPKE authentication in
    non-AP STA mode
  wifi: mac80211: add support for encryption/decryption of
    (Re)Association frames in non-AP STA mode
  wifi: mac80211_hwsim: Declare support for EPPKE authentication
    protocol

Sai Pratyusha Magam (3):
  wifi: nl80211: Add new NL attributes to support (Re)Association frame
    encryption
  wifi: mac80211: Allow key installation before association for EPP Peer
    in AP mode
  wifi: mac80211: Support for encryption/decryption of (Re)Association
    frames for AP mode

 drivers/net/wireless/virtual/mac80211_hwsim.c |   4 +
 include/linux/ieee80211.h                     |   7 +
 include/net/cfg80211.h                        |  67 +++++
 include/net/mac80211.h                        |   5 +
 include/uapi/linux/nl80211.h                  |  93 ++++++
 net/mac80211/cfg.c                            |  40 ++-
 net/mac80211/ieee80211_i.h                    |  26 +-
 net/mac80211/mlme.c                           |  52 +++-
 net/mac80211/rx.c                             |  11 +
 net/mac80211/sta_info.h                       |   9 +
 net/mac80211/tx.c                             |  10 +-
 net/mac80211/util.c                           | 278 ++++++++++++++++++
 net/mac80211/wpa.c                            |  12 +-
 net/wireless/core.h                           |   2 +
 net/wireless/nl80211.c                        | 118 +++++++-
 net/wireless/util.c                           | 126 ++++++++
 16 files changed, 835 insertions(+), 25 deletions(-)


base-commit: 8f7aa3d3c7323f4ca2768a9e74ebbe359c4f8f88
-- 
2.34.1


