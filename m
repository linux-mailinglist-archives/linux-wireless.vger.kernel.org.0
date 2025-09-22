Return-Path: <linux-wireless+bounces-27554-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC73B8F03A
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 07:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7284A17A6F5
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 05:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AEAC1531C8;
	Mon, 22 Sep 2025 05:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XpHDYtGK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA303AC39
	for <linux-wireless@vger.kernel.org>; Mon, 22 Sep 2025 05:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758518686; cv=none; b=dojtiCmRYYUsHtfuXzRvqe3l+jtWCKvcXote0ZxQy+g3drmjF3lT04bMxlJlNCLiudKti0EHpqOxo7y0oi604zCzjPds6uhua6VdnKjzikRzCec527QYBNdhwW3329NCsbK1ZzVWbU970Vk8gUsMxYPSU0pvDR9VAlTEks6tlPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758518686; c=relaxed/simple;
	bh=FvlESC/mg0BypHa/Op/vXPzTWjgK5riMInn4Sm8u6u4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ldmaYsHWgmcusi62Iv1tITMqMG71PKy2E38mCwGDAw/KtllCYnvTXcK2AKffYBALZ1pgSVxgyBiu/07x6cUTT1Mjj/4EPFFEICQeqezpOulhRN/aaQ/yQosTBdT5aKRb/AHJiXOFBh0r+bndNSvKt6AObOjRwy8hMk6P8fAeRVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XpHDYtGK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58LMurlc031985
	for <linux-wireless@vger.kernel.org>; Mon, 22 Sep 2025 05:24:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=A3d4gbSFY2D/xKjYBpEnXz
	vpR5UF+3q/i3hnwHakflw=; b=XpHDYtGKvZCgpO8A976NsIzVF8lgTlnTVfEKiR
	og0wSeVp5mejApm5LeY1m7OcG4h+XloTIn29TGe3p1BG+Rz6EXpEeY99gCBkqLQ/
	36YS6O4pWqhBwW+NZaEXcJQHZ/u121z/tWWTszksd3Ag1hvx0t4AbWA9Gy0r3+g8
	y10TAG3VRhmMVaHyhWNSmpji1Nj6e2KoZDCY6tOkzH6ac5cbEb1jeWuOr2OdLEnV
	WzbmrHXdpw4AHEduS9qzu5ihzVG9Jn21Bi+ivjEi+2rHvnDW1EHO1gmfyFby8aMG
	g8TUhK4TJq0VrlFWxY7Ukm2SA3rpt44F7Us8IaX9MCl568dQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499kv0uetu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 22 Sep 2025 05:24:43 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b4c72281674so2725182a12.3
        for <linux-wireless@vger.kernel.org>; Sun, 21 Sep 2025 22:24:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758518682; x=1759123482;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A3d4gbSFY2D/xKjYBpEnXzvpR5UF+3q/i3hnwHakflw=;
        b=X7he703XquvupwBonmdhhv7GSh22yVYa1gSU7iY6sMtlTkxP54MKDqp8nWT4oC/otd
         UIJrdIiKQr2d/M8s40jyziwd/0Qn15NbDuKjL+eszz9cf7ec9VNC+V4AYXOBQDgoVvtT
         pjUCPKZ1R3l/uRT/Ud469bEJI712Npiqjm+0slGISG748GyYLIno0MP8MSdgCMb/1hbY
         XljnUlFJSyI2LG4v1oAE9qhlgEm/gtKI2f5hlW8yLTxHKvJvg91UZfkmkoFgIliVEUMm
         ruSuuaAjiknhgUqBDMnc1tyPHSvOSVwS5lZ+natr5GaV0W+envjp8nC9G44UhAk+2ZTX
         3qLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVySyJLyVD7d6CUb6DKpVGbgC0ijti1SVeBzCaJkfXZeuSF0PWgbFuuNTo+keTPZSPVq8ouupuOKOIO0bk9XQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyI3Esd4i/N3r96smbk/lqvU+RrVwmODK5mAp8VVoF6F99MWAZP
	J71XasVt6YY3dtkp//mvxOzLVP8xDne3GxPVxzo56Qn9vXrM8UyPtrH5qUwaJ+AUsaNPNgcSrdT
	mqx/j4hmsGxjK0kRn41SF5c9NDnSJaBzMGN2Yvq+r2ulpZuu3RvPDvJPmo/joFTdR8nIjjw==
X-Gm-Gg: ASbGncvCnNL+bzEL5WVWLKduIXIFNuz16gyFE7OpFpNUATBVHVDyH7mqqbBSgvKyyDg
	dqBxcIJmKCfuHX2AoiHUoTEfcq5STBhlk/ixfw25c2zlWi7yVgBxbnrNdXMrRILF76HJ8OzzRuC
	ETogWQBXlut7aJH+dx73AP0WCNauWmFmgNwmvupYtxdwV4O7jyIFR2vTEzMj5HCRaP/g/rGnzCh
	H87ENqAtxXUIEc+1S1HYuMMl0b17e6TDtEcOCxRLuVyUXb+ETT2fDt+5HEkiJX8pKcfzbfwlmRH
	uFRe6GjwGe+rUroEE8PzCk3r7pAsCe7bUG+xjA8rAENnOHMAiA6HeFvSkwk4XNts0QWY9W6Yo02
	rp+1MGIJlHeT9rGQifO+aN+VyC6XbhKklLgKSNLl9YPihPUCNDzhf6k6oSC0wcnWO1cYqob7N
X-Received: by 2002:a05:6a21:33a1:b0:2c4:c85a:7da5 with SMTP id adf61e73a8af0-2c4c8884a30mr967797637.6.1758518681922;
        Sun, 21 Sep 2025 22:24:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEzHmbyTmeaOwGK6g6Vg96fZfwCnWB+FtOA90BhnEQj92pfjzbUxgwbFA4cmAKICgJRc2w6g==
X-Received: by 2002:a05:6a21:33a1:b0:2c4:c85a:7da5 with SMTP id adf61e73a8af0-2c4c8884a30mr967759637.6.1758518681426;
        Sun, 21 Sep 2025 22:24:41 -0700 (PDT)
Received: from hu-mdharane-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f1815af13sm5938567b3a.0.2025.09.21.22.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 22:24:40 -0700 (PDT)
From: Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>
Subject: [PATCH wireless-next 0/2] wifi: cfg80211/mac80211: extend link
 support for stop iface handler
Date: Mon, 22 Sep 2025 10:54:23 +0530
Message-Id: <20250922-stop_iface-split-v1-0-087403cea9f7@qti.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIfd0GgC/3WNwQ6CMBBEf4Xs2SUFwYIn/8MQU3CRTYBCtyKG8
 O823L1MMpmZNxsIOSaBa7SBo4WF7RhMcoqg6cz4IuRn8JCqNFelKlC8nR7cmoZQpp491nQps7Q
 0SicFhNnkqOX1QN7hw456EsGRVg9ViDsOBPc9Dhd9lP6zF40K81obZc6ZznR7mz3H89v0jR2GO
 AhU+77/AJaEnzLGAAAA
X-Change-ID: 20250908-stop_iface-split-be69429a0718
To: johannes@sipsolutions.net
Cc: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
        Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>,
        linux-wireless@vger.kernel.org
X-Mailer: b4 0.15-dev-1b0d6
X-Proofpoint-GUID: m2E9jcBW6-7q1bogo0VNyOAkY4lLluJe
X-Authority-Analysis: v=2.4 cv=RO2zH5i+ c=1 sm=1 tr=0 ts=68d0dd9b cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=n2Nl_DE46FBFl3_Z1OwA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyNSBTYWx0ZWRfX8U/r6uEOiaxJ
 isUxUGrKZ5DhM8K0Xs8CSkl7ITQGooMo0vTUwMWQnMKXDRdG1uGRo0V6EuJ5FDFk5Pu6QCmq99u
 ctQfsK5fH/kNG5/VU5PB6dmwUdCOysgBCr7i6lrIGg5FiMQVVriAbtt2joAIkjgXDUFOg9D40fP
 etrSOTKnCHR62ityOMZbF8YOvHGBKNjlEaqka07IPTOVgwqHcoI56nEbeK6PvXBsLcm2N6Xaocx
 nog7hSYaA2yoJPHs2xiC4PPK7bLO7Kmw4pGBCIJ0rMhspxdAjf+FN8rerLN8OGYVPh4lP0Aq/7W
 pANT0pbKH/Yo5w6mCwOGYxuvrBHqZC/Dzdgcoec96YpFMuZV9DQUKqUA/9W4V+SbkH6GFjxNPdT
 X0JshP0I
X-Proofpoint-ORIG-GUID: m2E9jcBW6-7q1bogo0VNyOAkY4lLluJe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-21_10,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1011 suspectscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200025

Currently whenever stop iface is called, the complete iface is getting
stopped. However, there could be a need for AP/P2P_GO type, where one
would like to stop a link alone instead of the whole interface.

Hence, extend stop iface infra to handle the event on the passed link id
and stop that link alone instead of the whole iface. This would be useful
during cases such as failed to finalize CSA. In that case, a link alone
could be stopped instead of stopping the whole interface.

Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Signed-off-by: Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>
---
Aditya Kumar Singh (2):
      wifi: cfg80211: extend link support for stop iface handler
      wifi: mac80211: Update csa_finalize to use link_id

 drivers/net/wireless/microchip/wilc1000/cfg80211.c |  2 +-
 include/net/cfg80211.h                             |  6 +++++-
 net/mac80211/cfg.c                                 |  8 +++++++-
 net/mac80211/chan.c                                |  2 +-
 net/mac80211/iface.c                               |  5 +++--
 net/wireless/core.c                                | 22 ++++++++++++++++------
 net/wireless/core.h                                |  3 ++-
 net/wireless/reg.c                                 |  2 +-
 net/wireless/sysfs.c                               |  2 +-
 net/wireless/trace.h                               | 11 +++++++----
 net/wireless/util.c                                |  3 ++-
 11 files changed, 46 insertions(+), 20 deletions(-)
---
base-commit: ee6960bdbb74499516261b84eadb19acc01cb361
change-id: 20250908-stop_iface-split-be69429a0718


