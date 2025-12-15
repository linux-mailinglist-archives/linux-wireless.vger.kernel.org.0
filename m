Return-Path: <linux-wireless+bounces-29762-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 572A3CBF497
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Dec 2025 18:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5526E300EDEF
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Dec 2025 17:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFEE2EA147;
	Mon, 15 Dec 2025 17:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B3gtKez4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CNHx2Auz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E0F163
	for <linux-wireless@vger.kernel.org>; Mon, 15 Dec 2025 17:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765820824; cv=none; b=Bjc8ye6pYw8OFJJ2jmRPaIePjE9xjS2274vkVlHW39jpytPzFb7jdTmobUZUuz7eRZ3emEkqm62v1U8buHM2WVKkGKLpTL8Ko6SQxlKkwtUD76ly1FapFhRWkI5Uyc7xwLRNWSalgL1Zw86oFdUeyRyzQAhcrxzkptl4PKpRTCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765820824; c=relaxed/simple;
	bh=urh5BNGOWHg3YgDjTnD5L5O40nKliaQCPwFu77sdSEk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t3vufg9zWCsXTP9/v9XCD/RV9yUUh5v3LMYIpcxnIZdMywBLOE4yAx7MBXlNZ2tkl00HjnFhHavpUkEGuQhZ2+289swMQt9XqeWgt84yJp986heTX8BhyJMM9FCva1i+dd7rzxHFhG/ZyBoWAw9CKpQirSPAu9b6I5/DLVUXJ+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B3gtKez4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CNHx2Auz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BFGP3Qn1398907
	for <linux-wireless@vger.kernel.org>; Mon, 15 Dec 2025 17:47:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=mjywauGPl/c
	vb6dLJp353HVopnmfVfwVKvSc1nY8c68=; b=B3gtKez4yFxwRU8/72FzPvqLCXn
	EIapaDwGKRuyNpXCx4VUWHoDGKaxoXoktl/ZHy4s9X0UNA1pZMBmzlx+cN+uIg8k
	FvlpAPoRgxmVQAXEOUsFUK3PGtWSSFkkyh/ZcATEvCJnMR1R0gjOivLcjZ8RiyTz
	ZFVC1Xn8xArv6b0daYCUe+LITdFgvCRQZjBVoncXQ3nt1G6EPCzEK+ToOIPwHocC
	dMAQoJkl7E7jncMddw32M7Zw18NPQ3Iy5Olcc819pJJyDMxCcNsB8rvMGRd5YZzP
	po9uw7vZQIOLXg9qiDHj89Hs4uBrJAzXwAGjsuuTPd1zOVxTdMdyatHn/CA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b2nu1g7t4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 15 Dec 2025 17:47:01 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-29f13989cd3so110912555ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 15 Dec 2025 09:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765820821; x=1766425621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mjywauGPl/cvb6dLJp353HVopnmfVfwVKvSc1nY8c68=;
        b=CNHx2Auzg8JjW9aINhviVNz4KB//xbJhnJUrpc3GSax5L6AOCDUoGt31/ZFBY0yJSa
         RkHUHtZMboXH1wOLx/tcftt2K7dXt1FyhRqOROQQGMqndZDgF2UCOzj1WeqIBXgsjtP9
         +9RtAdZtBQZP7lEtX4n0drQTY7QHzbZMln1/Opj+twPuoURbHJ081mLEQFbg3cjH+jgF
         9tW6UkfS7iTUnzFK8v8UwrlJ+ndr32GBPi+4OcHOk9eZPqlXxmVeejiz5jqJe76qSyC4
         jgTgdrcTmgJiQtB9PLYlU9O4nLmfQIG1Hzj2Ph2QrYMsm1+cQ86cSu3dTX+ijmhwa9su
         UmPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765820821; x=1766425621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mjywauGPl/cvb6dLJp353HVopnmfVfwVKvSc1nY8c68=;
        b=c82CTqRU0srgrNRoAdo1fDBI1xcOF52Nya9jyMsUh1n/nq53d38kxhmZK4phzog3Ip
         j1G7hkp5IsUEyY/RmVUr5hQHbWPBPUWnd6HZVOXaytYpVnZRomoUrcmQopZ+7nzITiRr
         ZY3dyGkIz0JVRQEgfhwLzDZLdIC7babGsak7613U0Zhzk2JzkuUVEXhM6jSk3peCSLfM
         TgHyeuR7jMvIw/IE+if9dabFdhW/A5Ss5w+5KpVvfFAlzdVQIFUiqiv2Cgaqtlbsc76E
         AvWDceUDRYPFLgwsseVthr91f/yJHj7Vy6PCqot0IfHREOuW3RPWG7lXb6iYKTrmWD50
         7ajw==
X-Forwarded-Encrypted: i=1; AJvYcCUTp7vEGM3WW7oh3NGv/SWlyc1EFp99yngPaMNmoP4yjkM3jgS43rHbnixp4cz+/aHORincKYXQhL3tDFlk7w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwCsaEWq+3tNH8ibli9si2gyWWT5663vrSryNqUdtU8aVXFjuNj
	yrHNEPwPQ5xVEP+jTM3l/W5jpgVv3BQDkQU5jA8HFDiAEvSM5MLzVlxHTSD887DxNorz4MT/LW9
	qbmeC1sSy6WSzN+jFp4m2u1Tf3rJM/5vpvISFrCLcz1EjkjYIks2U33wSG57Tj9pU6YqtbA==
X-Gm-Gg: AY/fxX4l7fT0nYgx/m/fkY1mZBM620F11viOK0i1fRJETi0N8/PZBUwcM9gXTJ/yjYF
	FKEFkakeg5aVo9QxOW+O+CxLen/YAqM1Q4eXPAjnrCI2KU1A1HefZu9kUzm5+yG0+PDu/t0+d3Q
	pOMk39hDaHloY2hdtx0OcJAbpCiAZ5iJ+nMNN5yEsXwiGSuKHtCdxkEwVDTh4VyzCOt9NMb+EQI
	Cn2XJpSeOQCvBF8nG93H0UcG3MigAna9f63zFtfEBmWUbjbEvGsHa1Cqx0621ZVq6tuzXO+iKiX
	xKIQSdgPZGSk9l+fahK6uHS/zqQ9emzJXBiyKxOtKNo7s/L3kZLY2P33APUJEkRIIMa3Acbjj3t
	R4pZw5kDGsc1irbt/MQmHRhObHZvelVhEl9SVzaOuFIp0WEf4MuX/Hh5reSZRlNIP
X-Received: by 2002:a17:903:2cd:b0:29e:e925:1abb with SMTP id d9443c01a7336-29f23b6832dmr106183435ad.27.1765820820969;
        Mon, 15 Dec 2025 09:47:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrT3B1/aPYsV5z2bRJvRs8srXT9lTqfWDUjd8ksM613EHNqRSkWTOcJscRIXRpp/3RCay14A==
X-Received: by 2002:a17:903:2cd:b0:29e:e925:1abb with SMTP id d9443c01a7336-29f23b6832dmr106183265ad.27.1765820820480;
        Mon, 15 Dec 2025 09:47:00 -0800 (PST)
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a094398eedsm78650325ad.37.2025.12.15.09.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 09:47:00 -0800 (PST)
From: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
To: johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Cc: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
Subject: [PATCH wireless 1/1] wifi: mac80211: do not use old MBSSID elements
Date: Mon, 15 Dec 2025 09:46:56 -0800
Message-Id: <20251215174656.2866319-2-aloka.dixit@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251215174656.2866319-1-aloka.dixit@oss.qualcomm.com>
References: <20251215174656.2866319-1-aloka.dixit@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: wvC_6fIo5Rfcz3CL_UG4MgRiFvXaMWu6
X-Proofpoint-GUID: wvC_6fIo5Rfcz3CL_UG4MgRiFvXaMWu6
X-Authority-Analysis: v=2.4 cv=AOuEbwt4 c=1 sm=1 tr=0 ts=69404996 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=xidHEXp7qheXSHX85acA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDE1NCBTYWx0ZWRfX5VXuWi1jpTsZ
 KaVMHihSIHkXUUMj49pNVF9QLFOPMW2kp/UaRUWkmEijlPEOMNYvtfhLyU0tffOuUvAOJhe6bcS
 TlAwItc2WAoUPlzasW8BU2CZma22QMswgBvuHVmS+m+38b4Evi4ocB3yCGKK+e9f8/BrWD42tdh
 w5e0U2mzMQbjryjg0XMBUpu7MqwOfDVvdFR62N5KpkShbZ91kBKjLcY50pFEPrpyrjnnY9mSZYp
 DpFo45sm8LXnIKRpc+JzuuHWFMAqJSlRB+50rHG3sylVsuAf23Le3o3G+Z4BYGVI4n+PCbitxFs
 fObgolUDtwZXLLzno/jpLb66c2VEMorW1qtMWzm7wyVbz8XEF2giiEQBcOTixdLgfKWvhFX0Wap
 wUD/mTnD+mSt2NpUD4JxoySEtrZfpA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-15_04,2025-12-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 bulkscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512150154

When userspace brings down and deletes a non-transmitted profile,
it is expected to send a new updated Beacon template for the
transmitted profile of that multiple BSSID (MBSSID) group which
does not include the removed profile in MBSSID element. This
update comes via NL80211_CMD_SET_BEACON.

Such updates work well as long as the group continues to have at
least one non-transmitted profile as NL80211_ATTR_MBSSID_ELEMS
is included in the new Beacon template.

But when the last non-trasmitted profile is removed, it still
gets included in Beacon templates sent to driver. This happens
because when no MBSSID elements are sent by the userspace,
ieee80211_assign_beacon() ends up using the element stored from
earlier Beacon template.

Do not copy old MBSSID elements, instead userspace should always
include these when applicable.

Fixes: 2b3171c6fe0a ("mac80211: MBSSID beacon handling in AP...")
Signed-off-by: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
---
 net/mac80211/cfg.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index b51c2c8584ae..c81091a5cc3a 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1345,7 +1345,6 @@ ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 
 	size = sizeof(*new) + new_head_len + new_tail_len;
 
-	/* new or old multiple BSSID elements? */
 	if (params->mbssid_ies) {
 		mbssid = params->mbssid_ies;
 		size += struct_size(new->mbssid_ies, elem, mbssid->cnt);
@@ -1355,15 +1354,6 @@ ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 		}
 		size += ieee80211_get_mbssid_beacon_len(mbssid, rnr,
 							mbssid->cnt);
-	} else if (old && old->mbssid_ies) {
-		mbssid = old->mbssid_ies;
-		size += struct_size(new->mbssid_ies, elem, mbssid->cnt);
-		if (old && old->rnr_ies) {
-			rnr = old->rnr_ies;
-			size += struct_size(new->rnr_ies, elem, rnr->cnt);
-		}
-		size += ieee80211_get_mbssid_beacon_len(mbssid, rnr,
-							mbssid->cnt);
 	}
 
 	new = kzalloc(size, GFP_KERNEL);
-- 
2.34.1


