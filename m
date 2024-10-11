Return-Path: <linux-wireless+bounces-13893-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C485799A68F
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 16:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62309B252C5
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 14:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C430319755A;
	Fri, 11 Oct 2024 14:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IvqfDn7F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DBE194094
	for <linux-wireless@vger.kernel.org>; Fri, 11 Oct 2024 14:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728657580; cv=none; b=KWZtNdkHvqKsy9B8SMCzT+Wkv9xeI4+iKXKvYPLmSykeJ6QmthCkXXa/5bcyKmBaokgb8WqJcGaVEbjy5Dvq3lQ0ln4MOWhcKNiCJ2GYxuYyoYM3v7u3dkhK0hFo/RXTkILG0ujRnR8X5OwN+ej3SaXmAcCs/umWZLkdWzghYeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728657580; c=relaxed/simple;
	bh=ObFMZtBAAacC/P83aZm9WRPrbE0ZqpADQws0/SSHTm4=;
	h=From:To:CC:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=hCeMfRh9tR58FOMURUFyi966bqbl4+DzWpK+JFVpeXFVhAVAFyIovFOPG9Va/DUHlKKPZh58FEO+j/xSzVEBgMXhXV6Afa5oNBxTLjjrfPQWiDSY3JZn9lIUmDuM6gS4L4j8isoJkpBUNZ6jLgPM9kmWBcED29Z27kyM7a9NFLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IvqfDn7F; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49BAjWOs005432;
	Fri, 11 Oct 2024 14:39:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	L2C9ZVjGeGuo1wcMeYk37kBBOFT3TAusl1UrGYBdQz0=; b=IvqfDn7F1TvDjqac
	UMU9Zfu813+safIgFm7JWDRZTZZ2ScXJ0SxUnjZzHHR/3MuqG/+Ze2nxaNPM5sp5
	2caYAR+P1i0tATItCmIeJZ55cf8SHNop89KuEkpmUD9GtTmqh2/EE8+hz3Yk+49e
	B42inOHc1mN6X1lgkJ9AEC3YYejwER40wECObv2E54b66vqySUj3PiBKp8O2t+UU
	ps54acpTuJbdNJD23py416Kbaw86JHPizb+AOWoNoV5PN1HAmvQ0Bw6APymeT5jU
	uDWzpOy+AVNaRNBHRh5n9crfSFQGT+r2DMdkqgpORJv+buRZ9GanfsrEA4/1tX+j
	B6HKIA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 426t7st244-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Oct 2024 14:39:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49BEdY82016049
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Oct 2024 14:39:34 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 11 Oct
 2024 07:39:34 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: <ath12k@lists.infradead.org>, Kalle Valo <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
In-Reply-To: <20241007165932.78081-1-kvalo@kernel.org>
References: <20241007165932.78081-1-kvalo@kernel.org>
Subject: Re: [PATCH v4 0/6] wifi: ath12k: switch to using wiphy_lock()
Message-ID: <172865757395.243911.9922704649615659085.b4-ty@quicinc.com>
Date: Fri, 11 Oct 2024 07:39:33 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2ENUQEBAIK0YNnf2L3THv0Jb-KR4iswN
X-Proofpoint-ORIG-GUID: 2ENUQEBAIK0YNnf2L3THv0Jb-KR4iswN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=643 malwarescore=0 phishscore=0 mlxscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 clxscore=1015 adultscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410110101


On Mon, 07 Oct 2024 19:59:26 +0300, Kalle Valo wrote:
> From: Kalle Valo <quic_kvalo@quicinc.com>
> 
> Convert all uses of struct ath12k::conf_mutex to use struct wiphy::mtx, which
> is already used by mac80211, and remove conf_mutex from ath12k. This way we
> have one mutex less in ath12k and simpler locking design.
> 
> v4:
> 
> [...]

Applied, thanks!

[1/6] wifi: ath12k: fix atomic calls in ath12k_mac_op_set_bitrate_mask()
      commit: 8fac3266c68a8e647240b8ac8d0b82f1821edf85
[2/6] wifi: ath12k: convert struct ath12k_sta::update_wk to use struct wiphy_work
      commit: 58550cdda961dedad8ed08c5abf8367d5c020fb6
[3/6] wifi: ath12k: switch to using wiphy_lock() and remove ar->conf_mutex
      commit: b8c67509b91ec23fcacbb99d40c960ab479e1299
[4/6] wifi: ath12k: cleanup unneeded labels
      commit: 31489439e6481cd0c21c8c7096d2ec44dc56b6a6
[5/6] wifi: ath12k: ath12k_mac_set_key(): remove exit label
      commit: 37d06d71e69c16d24ccc276cb86489fd2fcd00c4
[6/6] wifi: ath12k: ath12k_mac_op_sta_state(): clean up update_wk cancellation
      commit: e805272f8c2dee280e2fa1c1a454517df17f1261

Best regards,
-- 
Jeff Johnson <quic_jjohnson@quicinc.com>


