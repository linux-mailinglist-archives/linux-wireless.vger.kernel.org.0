Return-Path: <linux-wireless+bounces-20810-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A77BAA70C16
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Mar 2025 22:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38BEC172C18
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Mar 2025 21:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832D5165F16;
	Tue, 25 Mar 2025 21:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kc1rIHoJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EAF193086
	for <linux-wireless@vger.kernel.org>; Tue, 25 Mar 2025 21:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742938295; cv=none; b=EqxMAa3riIif9IWVrblN3WlTZTcoZ7hgwy4MSNPTvTKRe75+lAV7QBbn7/lqJFG5pCuweXIi812Yop/21CM2oY8/Fa1+vJD1D+ROexb8Ea3Uml40UOqCd7yaSrG8nkn6Y2759GThX/Aa6ss1Tb0iuIhNn0yHp28AWYiQJZoR5T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742938295; c=relaxed/simple;
	bh=9yWWLcK2SXmRhzjapjszLh8Y/Oebrz4VEp+1WoS9DXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ot48Qx6rgjv5XYsn4Ja0hg0qEVUzXHXz4kH/m4I/tRPgKt8cv7PKB0bXS3zn0TZdiZbk37o79cDizYRnnlU1FsIxSyC75v8/J6hRe1qViLuiFx47yVqB8CoWbxzo3gZHwAlI2+pkAVMndNFt/nWbMqUzNFPjUIbpahoxWXPgmv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kc1rIHoJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52PGacRL009902
	for <linux-wireless@vger.kernel.org>; Tue, 25 Mar 2025 21:31:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=AMoX4nMKjD1
	HOIDOePXNJPgdqV39EU/SVa5g3oq5Rg0=; b=kc1rIHoJQosd0tZbTrTbhH8gfnb
	sqFvRzVPbwBzQV8VcWqWb+3GAqATjP7cpiAcMiaGimHpRyQBndgS9T5Kgp2pFt7/
	Ap7fxUOdyprpZEX4UapWQSzukP684dorNCn/P4VML0Ziku4wY8C2kJ07VIN6J21S
	+tkv0otx2HW/sQL0v0Sai9T1lWjGiJuSfqthD+mUpYLnPPV5NNiFgyq4v5cN65k7
	pHxaUe6Urny7V8tO20epBvfM94HjwC+LyeT9sjMQatnM4PwApnI8hohq/fm8S00f
	scoteegrSwNYRRzNTaL4294gAmxyt3Fw9GZro/iSfH6hTurq/4V+aN2XCXA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45hm79s7bf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 25 Mar 2025 21:31:32 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-22647ff3cf5so88358865ad.0
        for <linux-wireless@vger.kernel.org>; Tue, 25 Mar 2025 14:31:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742938291; x=1743543091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AMoX4nMKjD1HOIDOePXNJPgdqV39EU/SVa5g3oq5Rg0=;
        b=EDCOF3y/o7wogaTkXfJ4EgDsGP/bGUuDwVBJK8i1WoWJ9Vo2TWEe+SqtnyRmBMy0uL
         zSM/WLFPQmJCN6pM8A5FMQw6lluc7rmx5lMFC7vfNejyolY5X+iqGnG2v7dlNzEDduwf
         eJCM6+9DuZlXI41KZH3xEzD2uanQeVIdLTs0Q5rMRPy2u/4xEMDKOF1SZf0nqYtQHeNB
         mCjyxBM0G65vCsfQJfyrFwSQRm6oknZxHvGuaWdVz9bMpujJJN6NNENUQfBMQYZIGi3Z
         M1+67zHKt03RYbu9iCxGlc6y2BeDttYJW82Y/LsZfMqdpRfLD67aCYyLgrS7nC4D8Alk
         9tHg==
X-Gm-Message-State: AOJu0YzPuKssYHiKqTxcDoP9Ry1mCPtENfgLUQpWWO9iSVwkjj2zwj/t
	wYaiA5X6WVJMaSgI3r/yCKCQBFudvZgnhkl9MgSQWXthTZVL2khpuJfKj7/LKU+Mrhf20EdkjPT
	xAY0NoWj3YoJt8whNd92cYgEWcP9NBje01UjZS/HR3JR+0riWmsfCr42zlsHOIAKf8Q==
X-Gm-Gg: ASbGnctcApMtX/S4/gixUt820LYcRy/9VODw5/ZtUaF51Bs5dwZ+WB2L5Nb0AyeDhq4
	EdXqyqLt5HWgUPMw/eQO439Y4Ov0+yKWoK4FG/Q8VFZyP6nJ0XEp38UamyRLjg4RKkG1mz2rNJZ
	NSVkWNKbgAtSV8lSO+h9Mi3O8RtefP1S0YJvoJhsR9MGMcpKrxVPS7mUy/D1QawAmPE4/Hx7pf7
	k9Sd3HywIPDrD+cXWO9Z8bbwmDiO05vGtS+kpWwlOAX7TEHssCCz26xDSYbrvVKWl13XA9eLTn1
	jdpoippV+xa/AsuWoVlPiVlqnXaVhldeRY6jjpxUstrQnA78VenzFWzNGudcSIkAdxyJMDRI
X-Received: by 2002:a17:902:ebc9:b0:220:c63b:d93c with SMTP id d9443c01a7336-22780e234c5mr277072875ad.44.1742938290896;
        Tue, 25 Mar 2025 14:31:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLNgf9cZotSBYbjtzrnbdOzFlQzTW3IMRbOaCvb+MZStVUreiuQX3GkPL1YxbTqNrBPsW0mg==
X-Received: by 2002:a17:902:ebc9:b0:220:c63b:d93c with SMTP id d9443c01a7336-22780e234c5mr277072455ad.44.1742938290382;
        Tue, 25 Mar 2025 14:31:30 -0700 (PDT)
Received: from msinada-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f3a2b5sm95599395ad.50.2025.03.25.14.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 14:31:30 -0700 (PDT)
From: Muna Sinada <muna.sinada@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, Muna Sinada <muna.sinada@oss.qualcomm.com>
Subject: [PATCH wireless-next v4 1/3] wifi: mac80211: Add link iteration macro for link data
Date: Tue, 25 Mar 2025 14:31:23 -0700
Message-Id: <20250325213125.1509362-2-muna.sinada@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250325213125.1509362-1-muna.sinada@oss.qualcomm.com>
References: <20250325213125.1509362-1-muna.sinada@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: dAdmBvUvDiH7IzQB24litw-iogUi3ugA
X-Proofpoint-ORIG-GUID: dAdmBvUvDiH7IzQB24litw-iogUi3ugA
X-Authority-Analysis: v=2.4 cv=IKYCChvG c=1 sm=1 tr=0 ts=67e320b4 cx=c_pps a=IZJwPbhc+fLeJZngyXXI0A==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=o5T2I9SElLahcmg8vGoA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_09,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 mlxlogscore=814 mlxscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503250143

Currently before iterating through valid links we are utilizing
open-coding when checking if vif valid_links is a non-zero value.

Add new macro, for_each_link_data(), which iterates through link_id
and checks if it is set on vif valid_links. If it is a valid link then
access link data for that link id.

Signed-off-by: Muna Sinada <muna.sinada@oss.qualcomm.com>
---
v4: new patch

---
 net/mac80211/ieee80211_i.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index fb05f3cd37ec..c956072e0d77 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1226,6 +1226,15 @@ struct ieee80211_sub_if_data *vif_to_sdata(struct ieee80211_vif *p)
 	if ((_link = wiphy_dereference((_local)->hw.wiphy,		\
 				       ___sdata->link[___link_id])))
 
+#define for_each_link_data(sdata, __link)					\
+	struct ieee80211_sub_if_data *__sdata = sdata;				\
+	for (int __link_id = 0;							\
+	     __link_id < ARRAY_SIZE((__sdata)->link); __link_id++)		\
+		if ((!(__sdata)->vif.valid_links ||				\
+		     (__sdata)->vif.valid_links & BIT(__link_id)) &&		\
+		    ((__link) = sdata_dereference((__sdata)->link[__link_id],	\
+						  (__sdata))))
+
 static inline int
 ieee80211_get_mbssid_beacon_len(struct cfg80211_mbssid_elems *elems,
 				struct cfg80211_rnr_elems *rnr_elems,
-- 
2.34.1


