Return-Path: <linux-wireless+bounces-23033-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CDEAB8E5F
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 20:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 120F1503E7E
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 18:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3672258CD8;
	Thu, 15 May 2025 18:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BvHM+jI/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F0A2586C7
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 18:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747332105; cv=none; b=ZAYLBVQ07vyDbeQafHdVDzxwFRBnJ63nlZppnyaWDbIyyx/b/Meva9zFy0sUR3CHtHrupld74vaXtb5SA2aCFRwWBGA6O+qY0x87zJeBJmOW46rc1hl1Rz9+FNDLfTQr5jI/6EQMSm7e7K+8k24LWrvLE5gGxMTiAZmX8rIuKic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747332105; c=relaxed/simple;
	bh=sOy5uLlGhesCw0G4Yakd2VaCUr9lbd+bxygNUNr1M1c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Y94Vh58n5y/NUGoyCR7j80dbhL9whCJDRg+I4QizmCvfRmPsI4oympX7c/6HGQD4emiK7Y12kYf51YfFrADLczaL4Np5/I0uI9eM+HyBtgzk7tzKWqY5QBxP1lhIntOrxEdyguD8AGFqNbmu+LavE1YNMKAVbI6Fb7zStihafhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BvHM+jI/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FEFCpB014757
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 18:01:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=fsC+dmKFbzMLabhjaIcqTK
	WghcdPAOZ8jCkq1SrvNUc=; b=BvHM+jI/+I+NZcxEC6wHiOBS0Ch/2s9jDlYCx6
	uF2pM334ZPxhMX5wWoWeawL1Eoyh0Eiu6SxO0x63PehVjqtvyLFvFOgGQl1lXAHz
	y2TVL4w2iF8yXyS8c9GrcVye60sWapoZaKphp5uoVhfLLdvDQRcJCO76P4GmMJlx
	saT+eLBxxZ+TQs94EAWGOglJit85VT8V3h8URl7hTWkjyTNfXtV2YHMaBs/riWBA
	GpNQQ42SGoVKB6G3aKu0LBNUORFWI1xjSwENDlHvLd1rB78114GuhyZWjtvCpl8/
	daCINFGhnT2nJY/RXTuTZdgDa/vX2AU4DEfrUvpZahv1VIzA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcpf9uf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 18:01:42 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-23195be68cdso12589865ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 11:01:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747332096; x=1747936896;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fsC+dmKFbzMLabhjaIcqTKWghcdPAOZ8jCkq1SrvNUc=;
        b=LIuJM9p5hUnIkMUTUkHuHcY+q7WKQutSaXaFRca7fTydjD6s0zC9kZ0OvqqXqo58EA
         G4mI8qPwNjvssgFPOs3TTaLeWX8rg4KcG2Q2SUlJDGrN8J5F+20YXAXLulrLjXLspE6s
         bbAnZx7+pIyLifwfIGDaBWyMDn2Cf2ibxpERs5D3NUGZd9RCpJJVi9D74GGdOFt+aDJC
         fLobxoEDbPkR0Vo9lRcjwEQ6tWzVrDmcillTaX86jjTSm+kwfqkMQbi7s92t9nvaGenD
         lGdZfCI8lCtpbSwgjNzXptErcVsI0exYn8P/YsnhRQCk647D+3PcXDy0LwQ0/H0p1ERI
         BqlQ==
X-Gm-Message-State: AOJu0YyiC0OC4yfuMspw3ANgdiUMsOZGnYMOkoSK5QvMCp5pqXASVi6m
	OfMtjU5yq5NRFrxbdvVgU9YATJy9oBsBB/yA/ujNuB1YqMixS2B0HunIoTh238tig4/hHQoWN/o
	u1qLsVPwQ3tUNee/kFZXeVbrCwguo7jeqljm+zkW3B+Kn4nQtEpNZ8YAkPQBNFX1SwvOilSiDSY
	UNPQ==
X-Gm-Gg: ASbGncsjIDKT68SYzadAe4ihhQyOrFgt6BtTf6/uhla3qM/c2Mzdsf542DXYtb64/za
	a4byvSZRe/0vekMGwPndwquH2qDaCharOpNFP4Rwhir5/cZXm7cA36SbyuQ7Uvms11SNL0UYbff
	feYBkhm0rI+Qg+QzHLyj75sU9PlWj2f+lhdVgBrftxQk1CLLzJlAR96xHJEeAix6fZCVWY3b9uI
	9nomh+LEUQ/qjUUhGBnjKQB+2TfzA8N8qramyDg9lMGRRcZhr32fKOA/s3aN15YgLTO3yGO2DoW
	kHPIMn66YqbY+xScswF8jDx4dYwz04pnzVs3cnxBGU7t1oXflngC1voEqej8nw+Z7Kh5XfZpR2H
	YY00OdS3MeP7hRfux/tdt1K05isWqqSLCONCy
X-Received: by 2002:a17:902:da86:b0:231:d0ef:e8fc with SMTP id d9443c01a7336-231d459b1fcmr4613115ad.33.1747332095565;
        Thu, 15 May 2025 11:01:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYXXgxnWdQmJyD0XWr6g147ptwEDwXQ4FgNhLnaaUV+QyO50AQyshEdbhLPpZCG923rRRs4Q==
X-Received: by 2002:a17:902:da86:b0:231:d0ef:e8fc with SMTP id d9443c01a7336-231d459b1fcmr4612495ad.33.1747332094987;
        Thu, 15 May 2025 11:01:34 -0700 (PDT)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4afe887sm777435ad.88.2025.05.15.11.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 11:01:34 -0700 (PDT)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Date: Thu, 15 May 2025 23:31:21 +0530
Subject: [PATCH wireless-next] wifi: mac80211: handle non-MLO mode as well
 in ieee80211_num_beaconing_links()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250515-fix_num_beaconing_links-v1-1-4a39e2704314@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAPArJmgC/4WNUQqDMBBEryL73YixCqZfvUcRicmqSzVps2ot4
 t0bvEB/BoZ5M7MDYyBkuCU7BFyJybto5CUBM2jXoyAbPeRZXmalvIqOtsYtU9OiNt6R65uR3JO
 FKQqrba66ttQQ26+AET2XH/ChgCMyC4fbDHWMB+LZh+/5u8oT+nuxSiGFVraVqqpUq/TdM6fvR
 Y/GT1MaBerjOH4op/TT1AAAAA==
X-Change-ID: 20250513-fix_num_beaconing_links-c44dad29fb5a
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: rSs7ZFNMmpuYFNJH8qyTQ6h8WOZp_OJf
X-Proofpoint-ORIG-GUID: rSs7ZFNMmpuYFNJH8qyTQ6h8WOZp_OJf
X-Authority-Analysis: v=2.4 cv=cO7gskeN c=1 sm=1 tr=0 ts=68262c06 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=stkexhm8AAAA:8
 a=EUspDBNiAAAA:8 a=24pOLicwr4PYXPShmKMA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=pIW3pCRaVxJDc-hWtpF8:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE3OCBTYWx0ZWRfX2PmCzaH/EMyQ
 sJS1ECIeHWC6N3f+ypxtmJkKy+UKibtiDYYRuP4xf0EF49n1bm2vf1b4JSdLDIrb+OHMktJvcOh
 TBvGxQhSZpbA5kkFTG1+UtJ+hrs0L6otk3qPaCiY2InLBNwRK8vKA0HYHMWph8CctwCDMY6JQ6z
 5GkclndTpOkRzuTUivkvjkuNq7lldFqJaPsdo7OVC5P3RnNfAF4sGqy7oNin9a3SpQgH04MJkTK
 adr62wP4QKvIUPRm/si3+u5bc++Fqrzh4XsNL2UP7cn8Nc9Ner5MCqO7Ez1FpzSprv2pnNXgSxJ
 hBBi26tZk22Qlgrzz6gd17zuwtYl9oBiWhl3naKEjKE1BAVRtlPOiDqaCm8yjNeEbCY0PoSdFq1
 6JI/fBgNUoYdLr/cN5XinlQQ2nsZgWB2D7fRCS6ZtXlRAdogHnztLv4JT4G/1lSaa92rwjUq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_08,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=798 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150178

Currently, ieee80211_num_beaconing_links() returns 0 when the interface
operates in non-ML mode. However, non-MLO mode is equivalent to having a
single link. Therefore, the function can handle the non-MLO case as well.
This adjustment will also eliminate the need for deflink usage in certain
scenarios.

Hence, implement changes to handle the non-MLO case as well. There is
no change in functionality, and no existing user-visible bug is getting
fixed. This update simply makes the function generic to handle all cases.

Suggested-by: Johannes Berg <johannes@sipsolutions.net>
Link: https://lore.kernel.org/linux-wireless/16499ad8e4b060ee04c8a8b3615fe8952aa7b07b.camel@sipsolutions.net/
Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
---
 net/mac80211/cfg.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 2cd8731d8275b2f67c1b1305ec0bafc368a4498a..05b7296b152cfbe1e81f8981eee52d72f711706c 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1290,9 +1290,9 @@ static u8 ieee80211_num_beaconing_links(struct ieee80211_sub_if_data *sdata)
 	    sdata->vif.type != NL80211_IFTYPE_P2P_GO)
 		return num;
 
-	if (!sdata->vif.valid_links)
-		return num;
-
+	/* non-MLO mode of operation also uses link_id 0 in sdata so it is
+	 * safe to directly proceed with the below loop
+	 */
 	for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++) {
 		link = sdata_dereference(sdata->link[link_id], sdata);
 		if (!link)

---
base-commit: 06c4b2036818585542a16f286d88ad8e7b7a8252
change-id: 20250513-fix_num_beaconing_links-c44dad29fb5a


