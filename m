Return-Path: <linux-wireless+bounces-29668-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04778CB5EA9
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Dec 2025 13:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDFC23053B1E
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Dec 2025 12:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D18C3101B0;
	Thu, 11 Dec 2025 12:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N/YkfCAX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dHW50ZfQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A4330FF3B
	for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 12:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765456912; cv=none; b=b1z+iS8/nCtubJPd+LQ2rTsNwpD3xoswK6Cd07G1QZZ+kkW8M1+wv8KOGOa3XcVPwxM7KyrNa1R5frBCpSmPExnV7ZOf3wh8TjOGHS3/PsAkM/23IOyzLnJX8fSc8p1XclOJ69iTpp1sFL/Lbz4BCh7W9ew36+BrLvGa+FuPz4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765456912; c=relaxed/simple;
	bh=M4+LKpLTFqeO4oAEnLiLXl155xTaKtgIbPFhF55NWkA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nj/s4G2yzVGNCAdU1IR6nwmbbjJNMxbZH2pcdXEe7qYETZg8Uj5lUqSDW+N0h1l0qWWtHsy7k3UJT0ZJkee4nM+9OYa8vP5Nx39tDKo61sKEz9fbsiOGYtIKFUKTU7NlE972uE1A6x2GcnOzuJCojVU5UbfDY1/p5tAjGGILQ7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N/YkfCAX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dHW50ZfQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BBAY0sE470650
	for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 12:41:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=92J5xs8yKnM
	pUAnA1tkoch/nQP5MYa/YHtsxIS9ArJQ=; b=N/YkfCAX9s5FigLVCV6uRdNpLgU
	HosXywMHmOcFSlLp9TT05Q6CYGMcasqUd4CMnYruxSj2k/UP5LWw662NIDYLwGdm
	E+vUof5m0de6oUKkU/p9dMKMoMoshjmMfcvbXepuQL1dsGR9FtCOThXHTp+fnwfx
	rKiiwHC5Fl0h4ItkV1D3bSUx/eDD+MRLHUiDG6RoPYE2M3aGJUss0T6/v4IgZ/zY
	FSwv9N+zx+NDJJhgrnGfLxgtaZRdWSpVLGr4tIEtkQ2GvHn4eEiSDGZHArMhE1It
	gM3MoC4k+ybx34wNuVZmii7KEM+KbJjGyk3BCoBlfZGFqaXqfYhejvDzPmQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aynpvspdf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 12:41:49 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-343daf0f38aso1149971a91.3
        for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 04:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765456909; x=1766061709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=92J5xs8yKnMpUAnA1tkoch/nQP5MYa/YHtsxIS9ArJQ=;
        b=dHW50ZfQwL7J2Fv4OBuYeqjqFekh7JvpD+nZBtmC5kqeZ5NotyLz5ScfgDyJQJsk5a
         XsGABTwMtB0yxjrN4tJAy/q4z/padU8X42rlmAnVAunS6asdvNdX5kldo02tEeYq4fRg
         hQd5nmc9vn/A0Duhqw+Kj7RhDJXh68euu/9W08W9Cqb3efRBaRjuRZSVRvPdnwnGA235
         7IMOAZh12tdVxSE/dKPW+ufVQTtkAppqRrYWhRZTf1xD+7O0p8Jq+yettsu6r93IEBka
         6Taz9JppJFsDOORkTZY0TMdSVrqooXJqUI3BcnSyE9b62bqY3cfdz4pJaiqfIScrPcd8
         722g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765456909; x=1766061709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=92J5xs8yKnMpUAnA1tkoch/nQP5MYa/YHtsxIS9ArJQ=;
        b=lT831cnUaiRotsRXGIwOVgj1BE2WLZALXegGfYfs8bV36jguAVcCoiiihbp6Wd0/+e
         SR/edVfiCm9l6/kXhJRL50iDRbRfZhVplX77p1X1msTYrGGV/uIBictqowlSNzl/qNwb
         w/x4icypwh9CvzXA8fwmKplM513xqPlcPdLi3HfTsS+JJ/bHdyswc7546ZboVWdoH1GZ
         4QfbRtSBS+SiXxIKDmgAl3SqCDrnC21DD43HOAdaZ6LxPUQK4UkpZyIkGCGSyb5Mfkgo
         4cqABYbVVu80Dvx85oHMlPbzVWXzuJwVzi6vGsYl/z7AlA+AirijT+FMfkNUdPoPjVuW
         sqEw==
X-Gm-Message-State: AOJu0YxAT/PLOaOH7XX+MlYttWo4bYFI5Lgferc88JkG4qmj2AZ5dsZh
	HzMsq/TpVtkXuTiB1Mo4/nNV5yZ1WMtf4vHgvOyuQ1KUC42noipiKJy4ABhf9ZXCq4MKWa/Mefd
	8E4k4Hb2BJkSvLfGBJD9o9W7ffDJCdyufRFSLproG+Rip8S45hy5chJYX+6JYMqKDTtttlAec6D
	TMeg==
X-Gm-Gg: AY/fxX5dtYdAIwFeE6T2+h0mLnkx1//AyJpHE60bYtWp2jO6NS5vx4JtUB94/ZYp5gZ
	441QF019+k7Ar5JDOjFEN4l01+niWNnzq4dJAjDJdWJmqnjcSO2eRxQ3zQyQP+sYBcBkVoeKbQa
	6rs6orwI7um9f2EoR13hGVO2vg7QJITwYlR2d4ZZsVtwy0aMbH671L/D7hRrCiUyVR9rE88yM0l
	EK+vM0twTBNo/AEcSgBb4yryMR52Y5fuxkgnN9/9cNNVl9ysvf5/YimtqrVsjhMOwBPEGctbPRQ
	I1IJjy9Ge9dy56Weub4lCCkFxvJbG8QCUJzryJQTA7o1IxV/wIigfUmqC5CVwnOpe1NyLvvyFM9
	fbNXM11VEypnY2zxBEuLocS8ckvdc9kfbr+gpu00ebw==
X-Received: by 2002:a05:6a20:5491:b0:361:2d0c:fd70 with SMTP id adf61e73a8af0-366e07d44ccmr6357801637.17.1765456908996;
        Thu, 11 Dec 2025 04:41:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7Tt+P0vb3DEq8d8qIgH9dc8iCAgoK4J1jdgTqz/h3A9+DNvU+P4OQmxg6hSWPZhjcmpKpSQ==
X-Received: by 2002:a05:6a20:5491:b0:361:2d0c:fd70 with SMTP id adf61e73a8af0-366e07d44ccmr6357777637.17.1765456908495;
        Thu, 11 Dec 2025 04:41:48 -0800 (PST)
Received: from hu-kkavita-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c0c2ae4e163sm2272297a12.20.2025.12.11.04.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 04:41:48 -0800 (PST)
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com,
        ainy.kumari@oss.qualcomm.com, sai.magam@oss.qualcomm.com,
        quic_drohan@quicinc.com
Subject: [PATCH wireless-next 14/14] wifi: mac80211_hwsim: Declare support for EPPKE authentication protocol
Date: Thu, 11 Dec 2025 18:10:51 +0530
Message-Id: <20251211124051.3094878-15-kavita.kavita@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251211124051.3094878-1-kavita.kavita@oss.qualcomm.com>
References: <20251211124051.3094878-1-kavita.kavita@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjExMDA5OSBTYWx0ZWRfX9dLwnb2YiV03
 v5B+Xw/m2a0+Eoc3T6I9RGlbFDQRVur2f5CiNumDYPreNhlPpdDSAhHupoHHx7/D4y/uvjC3Kb9
 TXz6VsMgtE6FkaFdlwc9iACQIIB5NcI4p6mH2+xk/n9avqZanx2e4WbisxLAM/Ge9JVIMam5Gjy
 vbW1+albrbSt9weMr1RxMANTPtkrZ3jIa8Dr2fKO3EUbiSFZi6PeelyQfCQ3ku1+mBjW4VJKXDY
 nKShOI9tyeaKigVpCBFDucZnHiHurm6TwkliUbRzO54A7icZRXPXqhMSEAYVLjDCnO+VS2pHq6K
 zw1cJVCwe75tnmAFfESEnZxGpXCdQuEtYckJgH6srMHe/e5X1XbPsDgKQOnU7aEK/rX0izs2657
 ldnH5D8zb4IAtkzf7XyZMlbrbpAy/A==
X-Proofpoint-GUID: c1_KUqH5JHN4K_RPxTGhtnmSKG4JzZo4
X-Authority-Analysis: v=2.4 cv=C6nkCAP+ c=1 sm=1 tr=0 ts=693abc0d cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=a1T-8RYyaUdGYqk8DgAA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: c1_KUqH5JHN4K_RPxTGhtnmSKG4JzZo4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-11_01,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512110099

Advertise support for Enhanced Privacy Protection Key Exchange (EPPKE)
authentication protocol for testing scenarios.

Signed-off-by: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 551f5eb4e747..5c36eb959514 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -5640,6 +5640,10 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 	wiphy_ext_feature_set(hw->wiphy,
 			      NL80211_EXT_FEATURE_BSS_COLOR);
 
+	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_EPPKE);
+	wiphy_ext_feature_set(hw->wiphy,
+			      NL80211_EXT_FEATURE_ASSOC_FRAME_ENCRYPTION);
+
 	hw->wiphy->interface_modes = param->iftypes;
 
 	/* ask mac80211 to reserve space for magic */
-- 
2.34.1


