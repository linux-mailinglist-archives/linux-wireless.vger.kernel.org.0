Return-Path: <linux-wireless+bounces-30406-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2ECCF90B7
	for <lists+linux-wireless@lfdr.de>; Tue, 06 Jan 2026 16:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED138301BCDB
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jan 2026 15:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2CB33F39B;
	Tue,  6 Jan 2026 15:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WyWqJczv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kGV+RWZU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504CD345736
	for <linux-wireless@vger.kernel.org>; Tue,  6 Jan 2026 15:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767713129; cv=none; b=JMqDIpDnJ4B8Khdz/h9H03jv3iG1qVCQkKKgLeuKPdzEPGnUfN+rX9+ACwmC6tduiDUxx0L3irPXUzXP7xOT9oOl2Tbhiux2NeHlVjxWDgsJUrYKo6U5TjYZt8HKXhgog1FO3J2al6xdVi7bxAD7c/l8ocMu6BCY1cwfBZMJdXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767713129; c=relaxed/simple;
	bh=moSSl4uZn9UFiVxcCKZO8UECKei6vrFUpqASCb3JvCI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=adkroNfgpmEZd6yxegtp8k4cjJzA4/svqIZKs3fhKqfjoRTVu33z8ODgXMaDiH79Jl0IRMccoIR9qI/XWDZyOlg2u4Pax3gIcLStwZt8iI2XeGfWYIOoy6KdD6YZrb6tUrpk/wHPCW9yDMQOO8feK/pk4dFd4fNiJOyj23ca2sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WyWqJczv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kGV+RWZU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 606EfkwD322873
	for <linux-wireless@vger.kernel.org>; Tue, 6 Jan 2026 15:25:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lvutWKI7TKt16StpCuzmvGLizpsf+0/4btbqFsNvdR4=; b=WyWqJczveUCuVlFJ
	OL2GQ8ZH/yywZP5y9zqU65aUBiDSvLfo/ujX1ELI2L8cZtDy+FJTYWE//eju/40m
	1rINqaqsNJ4jDS2Oe9N7xc0jET0ZxARKByAQbgUP4BIz4TS/DKRBWiDODsfV+14a
	ZffNZ6KCGM2nu2UljGuY/Rxg51npYkHpZK8Yeu/5qU3mlrPLYvY9NlaGGK2/SFfn
	GQGga2+gJdM1s6p5eZQsA7P27WFTGURfdzrNduf6HgNPVDLJGuhQyJI6ySVSHmdI
	WQHg3oY6sO3lVjQbw/DQ7+9cHGaRN8aMQ7cIMHvxipiYqfFd3b8XvYNOjSMDP+1m
	TwPMFQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bh4crg4dj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 06 Jan 2026 15:25:27 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-29f2b45ecffso16347715ad.2
        for <linux-wireless@vger.kernel.org>; Tue, 06 Jan 2026 07:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767713127; x=1768317927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lvutWKI7TKt16StpCuzmvGLizpsf+0/4btbqFsNvdR4=;
        b=kGV+RWZUs34a1j5/XoDuCjC+MUlXh3t+vOh50mfx9LqWzoutJnCYvxH1JSkFC4C6qI
         2SG0iOqZzksRt4UDzijmQNEf/DRlXG+Ugm+xz+wrQua4CRBr2/DyomHgXXaR5WlIWlJx
         mTVILjFyAZlUHy3SlYTOb0wMSeg5bpd/E46ofwsDD0Zcl9FxUeNg3p2s/PE/RXxKXTHr
         GpX6vrfYEmqQ7tCFdmKt7hO87cusYbjDOeDcdEiIvK4MYN9lAWt2BxZ5hfhBO4ZfbGSC
         iK/LIq28GdIDdrNGs6ACI5iqJQJy+8BhW90OGd963H7Ih3/IgP7OtFlKLAzR5sY8nxQL
         S8VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767713127; x=1768317927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lvutWKI7TKt16StpCuzmvGLizpsf+0/4btbqFsNvdR4=;
        b=NRUIRjZrFfMoUkLqKjDc2cS9P0mExBLCND8Q10AVgWSsMJ8686L5ueFlNQSYuCOzrc
         TBWOzaYip3YsC6nu6ZtBotC/7qgqBdA0kb/DF/QxKNkW3J4FRZa313AUgP+1c3ZZN492
         PZbsquIZRBdBWcF8F44pZDEgriwl1N/xwHw6Q5lejm2Q3c/8S6Xz7phDbN0ZnPtRJHuc
         RUCeUk8OZ7YtoB2BVOqUVxo2QaESRUKKGrwa461+YGCTOXDat2OcZqWqPtwfeaDlUWVM
         a3rdpNHdEIOqXJvQ/Ybah1pqQejufivE1xDr97XC0HCK7zN781aja9Bk7BUIqVIIe2dj
         XcRg==
X-Gm-Message-State: AOJu0YxdM3Lcv1UldAD+omeDbFWjCH2f4aJpjLHq9jmDViiAqTW6PErH
	ywPwodQ3pLCniiEhXHlMPvBS90wOThTX+/LiW7eJ9eTkjUmdOk5Bn3vQ3045NlZSmdPCYZ6++8Z
	HHuBGdScnEb1QEWeza2rh27ylQ2c5J3RmKXuAJe7mzrfuddIm+ynncGPKRaJVbzmay1JeXw==
X-Gm-Gg: AY/fxX54JgVMxhvUz4kr7/jO924qw9mJ37FnnovQRbeaH2KRUM49ELNc6mNhRtaH7UD
	yBRUVjVF0lYz+PWGN0voctaxs2Uo6Ljaz+b07nhvzouu1jA+1JLWDU9Aw7anOuCJ25gsSoXuUNR
	YNZeeJ1R/tUIFQ2ypkE8fg4aQski9kunoLYdYP7NJdGN3349tzsFYCDvzpHnU+dbSOkq302ncP5
	QKblpdLqSIZ9EH4h0BJid+TXr6Qk79QYUDKmtPHefU0+FmAJcb0GjmwCmBmTOfthwlVu3Ww8Xxp
	fMk946kA390W20OCENpY7wUA8OwMZ+VA1wCfOHIyxXgbwHoMXpkpBLv3CnJ8uGSqpGhN1KbXUDK
	Q177IBQQftemSVO/KNNneuUHDARjgOQAcXgVORR0IjQ==
X-Received: by 2002:a17:902:ea11:b0:2a0:9e9d:e8cf with SMTP id d9443c01a7336-2a3e2df504amr36372665ad.57.1767713126577;
        Tue, 06 Jan 2026 07:25:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGbIWFs9zlq2bAMNYYU9U3Pu+1rZ7m0M8HHLrsgGkOvqlPm0zAmfgy/DpEM68LuYWpnHDw+vA==
X-Received: by 2002:a17:902:ea11:b0:2a0:9e9d:e8cf with SMTP id d9443c01a7336-2a3e2df504amr36372395ad.57.1767713126077;
        Tue, 06 Jan 2026 07:25:26 -0800 (PST)
Received: from hu-kkavita-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cb2ea0sm26343595ad.62.2026.01.06.07.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 07:25:25 -0800 (PST)
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com,
        ainy.kumari@oss.qualcomm.com, sai.magam@oss.qualcomm.com,
        quic_drohan@quicinc.com
Subject: [PATCH wireless-next v3 5/9] wifi: mac80211: allow key installation before association
Date: Tue,  6 Jan 2026 20:54:59 +0530
Message-Id: <20260106152503.223216-6-kavita.kavita@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260106152503.223216-1-kavita.kavita@oss.qualcomm.com>
References: <20260106152503.223216-1-kavita.kavita@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=V9FwEOni c=1 sm=1 tr=0 ts=695d2967 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=NJNI8byFtPwFAtEfovoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: limB_nngGqSqJCq3wR2Y6gZEjzXav11D
X-Proofpoint-GUID: limB_nngGqSqJCq3wR2Y6gZEjzXav11D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDEzNCBTYWx0ZWRfX2YZqN8QAQuem
 j5KtzHJa7cSKyedgq0olfo1hFigd3IxzebrJYYxtxhMSCGANZsdb6wZ8YABca9Fchy4cD9o3Xja
 bVYRiWaftAkKEa2J0njp05xd0IV7qzHtSAR48vPE+IADLRx0i2eL1BcdzAvbnrLIBGJ9Xe2+m6K
 qx2nNYt/vFnEEutjydktPC3UrNZZOylkjoybhxYADgIlBJbzY/hi6kK92iVdx3g/4OvgxrJ2vE8
 nVqBOedGMkxPlVnOcWgdQoBfzHzWmY1me/CYywi55myqKyJ39w9tCaR2jC91Hrfsly2cdQ6gXwH
 qk1/VI8nugCDiHEy7zTU+jMxYqSBF54qi/OS5iL6e0zNKa1VvXr4I5whq+CNR2yMGiPlj3AWLHG
 sWIV9IdfDR26ZUGF6iSgePsCZxEnpqU2xk7xTxwazEb/WKK0dPSZLJfBl4hCv/H+whJiMqwNt4u
 SShSp4xserKSOdcUY+A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0
 adultscore=0 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601060134

Currently, mac80211 allows key installation only after association
completes. However, Enhanced Privacy Protection Key Exchange (EPPKE)
requires key installation before association to enable encryption and
decryption of (Re)Association Request and Response frames.

Add support to install keys prior to association when the peer is an
Enhanced Privacy Protection (EPP) peer that requires encryption and
decryption of (Re)Association Request and Response frames.

For non-AP STA mode, the existing "epp_peer" parameter is set when the
authentication algorithm is WLAN_AUTH_EPPKE during station profile
initialization. For AP mode, it is set during NL80211_CMD_NEW_STA and
NL80211_CMD_ADD_LINK_STA. When "epp_peer" parameter is set, mac80211
now accepts keys before association and enables encryption of the
(Re)Association Request/Response frames.

Co-developed-by: Sai Pratyusha Magam <sai.magam@oss.qualcomm.com>
Signed-off-by: Sai Pratyusha Magam <sai.magam@oss.qualcomm.com>
Signed-off-by: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
---
 net/mac80211/cfg.c  | 12 ++++++++++--
 net/mac80211/mlme.c |  4 ++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index afc636a31f57..ba7b1110c2f3 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -680,10 +680,18 @@ static int ieee80211_add_key(struct wiphy *wiphy, struct net_device *dev,
 		 * association has completed, this rejects that attempt
 		 * so it will set the key again after association.
 		 *
+		 * With (re)association frame encryption enabled, cfg80211
+		 * may deliver keys to mac80211 before the station has
+		 * associated. In that case, accept the key if the station
+		 * is an Enhanced Privacy Protection (EPP) peer.
+		 * If (re)association frame encryption support is not present,
+		 * cfg80211 will not allow key installation in non‑AP STA mode.
+		 *
 		 * TODO: accept the key if we have a station entry and
-		 *       add it to the device after the station.
+		 *	 add it to the device after the station associates.
 		 */
-		if (!sta || !test_sta_flag(sta, WLAN_STA_ASSOC)) {
+		if (!sta || (!sta->sta.epp_peer &&
+			     !test_sta_flag(sta, WLAN_STA_ASSOC))) {
 			ieee80211_key_free_unused(key);
 			return -ENOENT;
 		}
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index ad53dedd929c..cfb87ae81bb8 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -8964,6 +8964,10 @@ static int ieee80211_prep_connection(struct ieee80211_sub_if_data *sdata,
 			goto out_err;
 		}
 
+		if (ifmgd->auth_data &&
+		    ifmgd->auth_data->algorithm == WLAN_AUTH_EPPKE)
+			new_sta->sta.epp_peer = true;
+
 		new_sta->sta.mlo = mlo;
 	}
 
-- 
2.34.1


