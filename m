Return-Path: <linux-wireless+bounces-26293-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C85B21F6D
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 09:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C261A62885D
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 07:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6812E1C7E;
	Tue, 12 Aug 2025 07:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UMH6I2FI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710662E1C6F
	for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 07:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754983428; cv=none; b=UDSxBdB9Hcq2LY6IBYczsaWsq5ADKUr2ji/t0nuUbM4ky9GPXYCDB7bEYvzy28Y7ZthTCJ1YCWdgp2oCihgpp5KZyry8FXvWmvJxxsvc27R5iAotfXQXOikxmKkcXx7erMCJXGQjdV4eupPFZFfolRX55chipw5h2XNo8Rb+pk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754983428; c=relaxed/simple;
	bh=DtC2OsVOKnqsrqtLTXkC7XoJUJzmg1JNdxss1XeeorU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kf6/30fRXeI0pT3CG9bILNGGOv9Pg95C2H+Zu8iTzJy0IfQppcTHkfPt/6XzEbYbckm8Psxbfb2Bk9R+QtjZfmw1EmDaD2UzFFMSTIGsUtdZtyKPfU/xY+M0XGEH7957dtsF4lPViSG/HmEvfT2GMkwNgq7i9N0bXrsl458BMUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UMH6I2FI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C5l8HN024489
	for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 07:23:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0B4qMvpNIioMsMKLoBwgy4Arte0jfm66EiAkWrIKbZY=; b=UMH6I2FIBpyFFOvy
	vneN8KqKcvVyI8iDEKY2o5cXUifVY1gLOWY/KhXUFOAliSsQs4OmyYwo+zIHCroy
	fxdSiw8Q68ZpjQDYLxVW9Uq/K117ewRnj6IfvLSCN8bONOmpIu+pH56gEmk2d2dm
	H5bZPZE0t25ow8xjzeWztwQoSYbarH+qGxdEskurXGcj3TGVp4GdCmNaxNcYOGcm
	lQN8xe0/GginY418adxI21zmhpuTnz0eWEm29/IbLGbypCYnHvvk9s76mC3V1eNg
	gajP/iazq6N36l4eo7kQCjctp2oKo4upm6vHKayF1ZJ+IwkCj0T0F7cvFSzRUlQM
	H27NvA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fem4b789-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 07:23:45 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b42bcfe9c89so7183889a12.1
        for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 00:23:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754983424; x=1755588224;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0B4qMvpNIioMsMKLoBwgy4Arte0jfm66EiAkWrIKbZY=;
        b=JPnMO7VzCaQ4Z41N9G04TscOmz/b2d8m0s4lMoi9qGGTnAAsYmzFa4jL0u/Tmudfl3
         wRJD3fAk/xsehlRJTyba0DxXYfthIb7rOJmnc/PJMk9DIxiDSKfwyozVqtxIjwvGnhii
         xSk/cV2UMhFqE7IsKte09FHL1J6sIWhReDB/2GB97Wed6F7WMCybPeHU/SlFUPQmQmPi
         QLCgM3qf1nRRfpjLjCxQ0HDkfnfAd26TWrz0S2cZOV/oMyVlIxtXbQm9YnHvnEztSlCi
         bcCwnqEBrvvS5k4MwF2WBYi1Boq8FOYxXThchTEtZctDCnIR/Y9CZ/+WHsPDD+2638X5
         Z8Mw==
X-Forwarded-Encrypted: i=1; AJvYcCXdVwQujOiqLL6P6KevfMZD7JYugAMRhCYvYa42/vN6U3H5UeM7+OkM1LKGPt7g9rDinMMSLC3/y6gRF4wYPw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzozgIEqFZHC60ZMsfZvfZI4BuWyQH/l8mt4M8sAoK/SqmvZKsm
	isMxlR49huOJakg51TN3BRWwsI+DQw6DjGj21eomtcOJ1Qwk9+vHlA42oqBRIiaoGs6//8t+MYY
	A24Oygv8tkJLxwjshgWO4Vc6NDHWKs1W+pJvRn6dfJirQrD4E4Z+z81P2veMP34k/5l07fEnE6S
	r60g==
X-Gm-Gg: ASbGnctSUhXHLL53R1Zhtm5tnZf+iKCTgBZ2/enl3mkkrAuJiduMTUMpnrtUEtBGrS1
	K83eD4ilGmouXmMh5eAufwZUgbEV5Q55wHhP1ZSHZF0fz/g03NJ8pZErLdrSSCniNoMpP/Dt08U
	RsaRa5Dt9/bK3P20inxM9wCqygWS9GWxiuwBkV6k4DE//ZVGIallBm+g33/fN3HBtnq7TkBomqa
	805SpyV98PYnoC3jObLk8pr4W+d3eiadT1kYJDLW7hRtJRiR3jaRUhqV90nkf25DgJy7aLHcWM1
	2RwB8zFc2WoL188GwG4g3bAt/dcZmbIqaYam9hc1QP0hZB4FO43uMDTa7Pw0ZjBBiVVnQ1/3qr4
	9c49ELUa7+M43U4XOkhELTcw04iBfZCQlwCUhKYZSFe5hZ7c8hzht/bxy2JoXoarg
X-Received: by 2002:a05:6a20:548d:b0:240:2421:b912 with SMTP id adf61e73a8af0-240551f3000mr22882659637.37.1754983423716;
        Tue, 12 Aug 2025 00:23:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGccrCLKxIJC3TIBr35+6WgaVzfukq44h2Rsk86RhNLOA5ZjFQm0bJpPgTKOY3SrfRO7bcjkg==
X-Received: by 2002:a05:6a20:548d:b0:240:2421:b912 with SMTP id adf61e73a8af0-240551f3000mr22882632637.37.1754983423271;
        Tue, 12 Aug 2025 00:23:43 -0700 (PDT)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422bafcce2sm24547338a12.52.2025.08.12.00.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 00:23:42 -0700 (PDT)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Date: Tue, 12 Aug 2025 12:53:28 +0530
Subject: [PATCH wireless-next v4 1/3] wifi: cfg80211: fix return value in
 cfg80211_get_radio_idx_by_chan()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250812-fix_scan_ap_flag_requirement_during_mlo-v4-1-383ffb6da213@oss.qualcomm.com>
References: <20250812-fix_scan_ap_flag_requirement_during_mlo-v4-0-383ffb6da213@oss.qualcomm.com>
In-Reply-To: <20250812-fix_scan_ap_flag_requirement_during_mlo-v4-0-383ffb6da213@oss.qualcomm.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Cc: Johannes Berg <johannes.berg@intel.com>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: cow2IWSGGdfsMlFdSdUQ_EFbAZ394ou7
X-Proofpoint-ORIG-GUID: cow2IWSGGdfsMlFdSdUQ_EFbAZ394ou7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA2OCBTYWx0ZWRfX0YPq+g+Oc6fk
 MOjVaVQXcKfiJUbixIsO5jQei+RG+H1p9TJQ43dMaPkzeJzgxisZ7jk4zrTXqjKxP2k4ZkIzy3p
 igCqHrHyyolpgCpGJ2fw4f+uZzCkqHgsYlRCqMZ328FV0Kt6WRtKjDLNltKP3mSVZptvpli6Um+
 nk3UFO+jCs/CrI8LA9TWzhOx2z+8tAZvLrR4vQTGkYcxxdWPWa4m/HKuJFiSgQof1X3Cfj+1wTP
 aXFViCxRsaldp58axDBZDMSDkgYbqGn/LWbyg0Q6ebfe2bSNH+ugyzP4X8LYuxxhoJnb59EbrBm
 vugfJFWygBRshC8Ugv616/khQVg5fNDNpF3gwAOAfV8QmpsQaYrf/ngvPODtN4lzZT1eKHJcYaK
 g0apsg+d
X-Authority-Analysis: v=2.4 cv=YMafyQGx c=1 sm=1 tr=0 ts=689aec01 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=KvhtT1cOtCMy9zCwnqwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0
 adultscore=0 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110068

If a valid radio index is not found, the function returns -ENOENT. If the
channel argument itself is invalid, it returns -EINVAL. However, since the
caller only checks for < 0, the distinction between these error codes is
not utilized much. Also, handling these two distinct error codes throughout
the codebase adds complexity, as both cases must be addressed separately. A
subsequent change aims to simplify this by using a single error code for
all invalid cases, making error handling more consistent and streamlined.

To support this change, update the return value to -EINVAL when a valid
radio index is not found. This is still appropriate because, even if the
channel argument is structurally valid, the absence of a corresponding
radio index implies that the argument is effectively invalid—otherwise, a
valid index would have been found.

Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
---
 include/net/cfg80211.h | 2 +-
 net/wireless/util.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 406626ff6cc89df4df30e6e623403b4d9ceb6cbd..cb1c36be27493bc0b356497cdbc68f1be7b4a94d 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -9548,7 +9548,7 @@ int cfg80211_iter_combinations(struct wiphy *wiphy,
  * @wiphy: the wiphy
  * @chan: channel for which the supported radio index is required
  *
- * Return: radio index on success or a negative error code
+ * Return: radio index on success or -EINVAL otherwise
  */
 int cfg80211_get_radio_idx_by_chan(struct wiphy *wiphy,
 				   const struct ieee80211_channel *chan);
diff --git a/net/wireless/util.c b/net/wireless/util.c
index 240c68baa3d1f71a80a36af854acf4aa7ce75d05..d12d49134c88159f19c2226517d129f74f3ce764 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -2584,7 +2584,7 @@ int cfg80211_get_radio_idx_by_chan(struct wiphy *wiphy,
 		}
 	}
 
-	return -ENOENT;
+	return -EINVAL;
 }
 EXPORT_SYMBOL(cfg80211_get_radio_idx_by_chan);
 

-- 
2.34.1


