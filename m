Return-Path: <linux-wireless+bounces-30039-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A003FCD48F7
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Dec 2025 03:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DA3F30053CD
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Dec 2025 02:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA101DED49;
	Mon, 22 Dec 2025 02:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eS9j69Sg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Lrj9CUuU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DB11A9FAF
	for <linux-wireless@vger.kernel.org>; Mon, 22 Dec 2025 02:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766370580; cv=none; b=i5Sintmzge19WOKpv33mIWLMDkqQKzTAFo4DMKQP3wtIH9EVHR8gyfhMX1M2bVJHCs279J5p/bUIogICWBRDoE3kgW8vvz04ITXmM6A6YZalZmTPN2KjE0bN/0bynlmqbCc8p32Kzeq5HybgYnOfvqAslW3/6sZiGoF0c1ULOqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766370580; c=relaxed/simple;
	bh=f6us87eKyfiTn5Vg7d0oc4S6irJqVVoCDxBoOgdUXE8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XNBE+PsSPa1/RnPQ6AuhGZN476QsD3+o07pZyJffcBR7+RnTKmstXLDcJjTG9uZ9XxaCCm8zt8+RVPXmeoglLe9S2mYKG8HCygW7GWJYkOWPawPEVtgDIX6O9j2UWhjTX8OHs0VKLgtdAzeeg9ykFQbmjT3l21ISZAN9ujTGoC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eS9j69Sg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Lrj9CUuU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BLMu9Bh3385341
	for <linux-wireless@vger.kernel.org>; Mon, 22 Dec 2025 02:29:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=D7kWMc/lBuUsh4S3XwEIjq
	vMER2Oq0xC0fSy6OoblLQ=; b=eS9j69SgAKKENLOSiE3jimKOoyJRRXuB0Uja06
	dcWKfxHr8b2Zp+bdr7+N7sQI1svX9KihytZWcWxP33HO7S3Sv4QOqO8kCUwsgVpX
	pmBWK7DGu/HyKMToqFa27Ch+8HW1DmizDzqVanaCnaKD8polDC1XAxs8lgu6FOUR
	Y0rbAjTciCjIul3UkoDMZ/gttv5qL3q8w+QGYG6azP3f7c6eyyKPDms3LSL02SGN
	nu3+W5L6qgo0LAsjV/EbY3TioHLh7PdQuuLSDM9mOZwIBYPJojgCwR7ctDfnaNsR
	vQDQ4a+zz82ZvTqxpg9GDWU/MYjYmBVXo/VeGasDilPu6yKw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b5mtqk9x7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 22 Dec 2025 02:29:37 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34ac814f308so8037916a91.3
        for <linux-wireless@vger.kernel.org>; Sun, 21 Dec 2025 18:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766370576; x=1766975376; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D7kWMc/lBuUsh4S3XwEIjqvMER2Oq0xC0fSy6OoblLQ=;
        b=Lrj9CUuUjoPD3bdQ9JFOOZKJaq8G4qkmAw2/r0zJI64VAKr/vlF3532VymMjfh6bkj
         4nTAxw8b9A0uUle9StqgoGBlAqe7owQGEylD58XQtpYnuBdruIzScODpdk4n3ApktRGz
         TeNJ7AUxBSRtLSaMqXmr9JeDi1RwxGbJHHAca20hbog1xIYuznFOwTZhpphbGEAFuCwa
         6jTIp5b5YOzQM0BiK0cr5vJrOP+x5EVugAbtNgzyQFvXCkh/zT8+qmeWz3f+JpoRO+4l
         LxFJrVXNIJ8vj2gbbjYT4IJGPkI/fbMmpbMCKm/esi2CdtHFDIptDyDWz/skyVEfZSB0
         zl7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766370576; x=1766975376;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D7kWMc/lBuUsh4S3XwEIjqvMER2Oq0xC0fSy6OoblLQ=;
        b=seWesx0DWu6Uorp4Ds19S3g6AJfLinP0PUIubOL/qITURn54vKcLKQcvHwb3OayWCu
         QQS554e782Wugi4Q80KQXlZi7gkCMT6QC9Ia4DlTaM23Y71QkXa0DnFto3DYAnkOJ6rp
         40XevNveEMeMDvhLhFqai+lJ4jwZoqxq5GbIZmRsqBod2kyMzxgx3K26PDK5z6JIs1Ju
         Q4bqkHUllNk6AiF+oBsP8Qqd00rqpNTl9QXqPaAqPpsC3BV9JfAAHocJVYNO8Uyfjbgd
         UsdEs/G9RobVLWnjTUD/76ns62+/rglFJy0m933hKU4V30Y0YgDT1vVyqpHpmgbc0n7O
         T7bQ==
X-Gm-Message-State: AOJu0Yykx88z1s8FItPJK9rXdgH3jKEdu/fcJdB2JhTbpsT9Vnzx+6Xr
	UOAizhP8A+qirpG+gUKxo617a7l7jm6A+8FzAkOOCZxHsRxmFSJF1eQ5vHIkUtz9P9y/Mtku29H
	2ML3QvRZpMmDcawmtr5bGpb9T6XBpkQr8HJYMyervbZ5W3Yrfu75lVX9KLVfq+nO/rk35GG1YqE
	gvqY0O
X-Gm-Gg: AY/fxX7YkARRuVsUleCKl30g72eyT4ex7eNe6IibGDoPAVD3stInC4yhYg9p0py4KkD
	qAB9rUrjS7p6ei46QhWplFL5rhyHJilKFPpsO08Y7o0kEY4DE2MSXcetkRtYg1GAXEqZjMhht9r
	rk2EVzVfy3q+Mgy9yLzY8atBrmiyMyfyWfQ6u/+tpcT2du+nszH+8bmAgz7tbso/Hm8sgwPV6ud
	i1+L9wjgBN0hZYhahTESpdqFbz8Vd01yK7j6KPEfavyRfuZmHFY7Vzm6IsTmnB/2YQ1fmQe0+xT
	62gbAPiQ7EtBfN2nFlo7rSDoHTfE7kh9+HLN0Qc3SdPnS4agYGpgTA2/KRCIS2ttrfoJjKoSh8c
	3R4WB3/a/cKSPP/+Hb8XxZntNCb2OBHr8vBMIM5TR7sKTsbI0fpQ7bZs5YMw0CyA=
X-Received: by 2002:a17:90a:d406:b0:32d:a0f7:fa19 with SMTP id 98e67ed59e1d1-34e921b05d9mr10177854a91.17.1766370576157;
        Sun, 21 Dec 2025 18:29:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGVO+OYpoj4kpbfZl71hER4AMjMoYypYIq7WAsOY5L9E2hjVMML6w0OWQ6jW+aKO99EAEU6Mg==
X-Received: by 2002:a17:90a:d406:b0:32d:a0f7:fa19 with SMTP id 98e67ed59e1d1-34e921b05d9mr10177833a91.17.1766370575617;
        Sun, 21 Dec 2025 18:29:35 -0800 (PST)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e772f08e8sm4330631a91.13.2025.12.21.18.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 18:29:35 -0800 (PST)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Mon, 22 Dec 2025 10:29:07 +0800
Subject: [PATCH wireless-next] wifi: mac80211: collect station statistics
 earlier when disconnect
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-mac80211-move-station-stats-collection-earlier-v1-1-12cd4e42c633@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAPOsSGkC/52OPQ7CMAyFr4Iykyo/pGqZuAdiSFOXRkobiEMoq
 np3okwMLLDYfrafP68EIVhActytJECyaP2cBd/viBn1fAVq+6yJYEJxwTidtGmY4LnwCShGHbO
 jZKTGOwemNEAHZyHQoZGiB6Vb3UiSj94CDHYpwDN52gAOEOkMSySXPB4tRh9e5Z0kytK/5CQop
 wdjgLd8aBWYk0es7g/tjJ+mKodCTPKDwtufKTJTmo4p1kkFdc2+ULZtewM1Oze7aAEAAA==
X-Change-ID: 20251201-mac80211-move-station-stats-collection-earlier-f832de5a9a83
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: fcySJRTUKr89cNfok8BVbVf-L6Rh7kIM
X-Authority-Analysis: v=2.4 cv=dPWrWeZb c=1 sm=1 tr=0 ts=6948ad11 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=6JlTSxvTPZeJ10pFLygA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: fcySJRTUKr89cNfok8BVbVf-L6Rh7kIM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDAyMCBTYWx0ZWRfX50x+FdRAFn4p
 RvoS01mLHCkN/S3OUo5acNB5b3XU6gZcQXlLg9elEGo+hrlfD7VHBNah8PteE8cIAkDGGru0Z9S
 w2Nq8Hwbi4UXUwCydp8YwBN7aYZJhuF64528LT1/gaExoh1XvElEq/iCrpDqEF5CbH3BFVO51Uz
 NyABCPL/6A6dag9xuj13dhCkCJIGIL0Rtfh52pUKARoCK/qHpIIZ0zx1SEG34y9+8vRzwd0sPKh
 M469mDc+o+vSbQLj+KAj2o3pn10ts3jHl8XbsbJ4XQj52hJ4EsdNG9vkbWjFWyAR+DCLnIunxiL
 Fmhcfc+HUt7xp+C2nI0YIyigJ/XJVNkMLiJg35VUUpfN6BC6MHa7jReUiodHdFatQ2H1PLnrYMA
 wCY2VCARtHO7wepvYgG4IcgY4VpiQTYRq1dz8jyRXXMKowoYbJ6vkC95zx5sza6PekTh2is9YHO
 dWwJxPQTAjc/ZuPwvug==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_05,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512220020

In __sta_info_destroy_part2(), station statistics are requested after the
IEEE80211_STA_NONE -> IEEE80211_STA_NOTEXIST transition. This is
problematic because the driver may be unable to handle the request due to
the STA being in the NOTEXIST state (i.e. if the driver destroys the
underlying data when transitioning to NOTEXIST).

Move the statistics collection to before the state transition to avoid
this issue.

Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 net/mac80211/sta_info.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index f4d3b67fda06..1a995bc301b1 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -1533,6 +1533,10 @@ static void __sta_info_destroy_part2(struct sta_info *sta, bool recalc)
 		}
 	}
 
+	sinfo = kzalloc(sizeof(*sinfo), GFP_KERNEL);
+	if (sinfo)
+		sta_set_sinfo(sta, sinfo, true);
+
 	if (sta->uploaded) {
 		ret = drv_sta_state(local, sdata, sta, IEEE80211_STA_NONE,
 				    IEEE80211_STA_NOTEXIST);
@@ -1541,9 +1545,6 @@ static void __sta_info_destroy_part2(struct sta_info *sta, bool recalc)
 
 	sta_dbg(sdata, "Removed STA %pM\n", sta->sta.addr);
 
-	sinfo = kzalloc(sizeof(*sinfo), GFP_KERNEL);
-	if (sinfo)
-		sta_set_sinfo(sta, sinfo, true);
 	cfg80211_del_sta_sinfo(sdata->dev, sta->sta.addr, sinfo, GFP_KERNEL);
 	kfree(sinfo);
 

---
base-commit: be83ff7549057d184b693a85cafc10fbd520f3d7
change-id: 20251201-mac80211-move-station-stats-collection-earlier-f832de5a9a83

Best regards,
-- 
Baochen Qiang <baochen.qiang@oss.qualcomm.com>


