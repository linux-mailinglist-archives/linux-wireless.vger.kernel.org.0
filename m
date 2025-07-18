Return-Path: <linux-wireless+bounces-25634-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB385B09B21
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 08:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 253F6567E71
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 06:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9261F1517;
	Fri, 18 Jul 2025 06:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kKIQwkV3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8D817578
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 06:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752818946; cv=none; b=aFsDjKWerdK+ttEIA9NuBZDtS8sd+DWUPx7BW2eEweE1zludqoFoEUxv3Qqx2qKpnoEW0rHZ8fd5gxHvnv1WpYwrXW21okZN+elk25prBUfxA8r++ULgs7UYXrSb3WWQs57OAOWGVQSXWmLCFDVwpLb1cUu4bF2JExf554VTr58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752818946; c=relaxed/simple;
	bh=G1A315OBDTaIS4qb1YbNxM8JMY2ZXPyRI86t4aKInWc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=jsuR5HxDr7ccQpCE17nt7Ja7W131C5w8dLQ9OqeeVAilTi3xp1HL/RnlqeIA7P8Vn2HsXgr8b2eMZRRv3WMd7K/hzrz+gH6gotAEjVxNNoerW1GMsJ63ctKaoqZtwdBY6FVi7EDNciTjcfyzF6d2ft0QQqJb1KLzKILVjnnS4dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kKIQwkV3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HLuJcQ020761
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 06:09:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:in-reply-to:message-id:references:subject:to; s=
	qcppdkim1; bh=z25vRVmkjbKIdpqWUoQykUC+SKXNOSeNTfORv/WdzBM=; b=kK
	IQwkV3XyZYWT/i3jmOPP9tPzLwxpsuhPFiXDLUBpSL1HjUoOpMz5oH7ROgIqUFkO
	EFbtlq4TIw2P/jGgKRMC+h7oRb1sJyMf4DPY3qb43ot4s8QozqBi0AD5k3cRFsgM
	oF2tt5gU5Lb3Y6i5lmckiR+R/9t2ezZk/AikdN1w7NFIxzKawCJDpSBbdXP0VeGc
	V9nUWOJBKb198HuZrjFLDemSkyewU7gAcuWfuqJ72cmoLXUfLAV8thJMZs2JgiJC
	J9PA/Fyv9OrI2NbZC9mG+liAHC1CzIkVzX76u2smjkzwqKUneHINcRLrZYhK23/F
	SXGl45opeVK7ARie5kqw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dpndp3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 06:09:03 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-74b185fba41so1658446b3a.1
        for <linux-wireless@vger.kernel.org>; Thu, 17 Jul 2025 23:09:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752818943; x=1753423743;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z25vRVmkjbKIdpqWUoQykUC+SKXNOSeNTfORv/WdzBM=;
        b=CS/m9vTrPuhjH88dwcLzVJnIaWkitwq57xRd0615GYgeYnCbSdTT+AmqRp3B7oPFMB
         F64Br8y0eQu4qzfs8hiqE7MOQZknD0a6aR9dbw74N0Dg+dl5HF/JUzo79U0SxqnSFRgE
         dv+EHssNl9dMYhHdDybkuV48z4zCfRS13EdWxIXz7T2rnsYXGq27UD7evEE34Z9wg9Sw
         o4dKVa+Bgu/xtlO0AI4KbIkw/UVAOyunHF6KZlGYTueAHUOWjn0wYXz7HHW+AJTLYtD/
         KSd8UNVKJ4vak/DBGfGbAQGOg7n8UMXStcpyp3tOTeoVb/fKjxjIhPndEg18nF461uCn
         3kzA==
X-Gm-Message-State: AOJu0Yy1GZySOZ2djSHw8U2A7XNvFJPeOiSlcRrmqoak2aVONUQ09Gqa
	m85PwHwHAEZPGday91NB3SYqiZFh1zp4tqkClsRzk/Q7CQDsS+BAVgqLGecF5pmsQqhgcWL0+fD
	fFwNvu3EQYl68UNPBvyI4wfDDfpT59mTEUn8l25jEYjPqAXxOVexdOjQtkoy9ye3JSsLtlg==
X-Gm-Gg: ASbGncuy2ZXbCTsSOI7J3cjLs2c7E29EASjRig+U4pgwcj8DY5bLUAKSyTpjVrn+OEk
	CmEBJbtxuCDAR6expjZYFkLAO704x8b1MSja8u3m/R1WQTQ6JFYKIjQXge18f2/0icyge3dtV+h
	pC0hkc7weJLJa6bxJ6tIWg5AuWpSVe8Q5ippC+kOY6Un1L33/Q9Ud6BSj8w9v1a9dbLnTuugAMX
	31lG63TCnv7sjiizRz7OrvAFABUJEOa1kJR4fxiILIImQwRT9D/yGY87E82dBASsgokvKpJwdgU
	+LCQL+0MyD0I/aOSZj5uapMKiuqJ2ZxrL7ka7hpnZ+zwMkz9urvjUy9UfMvmU7V9UK/FVbzmx0e
	BfUYpK/E=
X-Received: by 2002:a05:6a00:391d:b0:74c:3547:7f0c with SMTP id d2e1a72fcca58-756e819e070mr16196003b3a.3.1752818942870;
        Thu, 17 Jul 2025 23:09:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5Tq4pr1bRZ/Ss2+f8DglJO8cX9m2IEj/qrUkwsu3ydn8aINdy3vj1KXFifCSxtGRzXk2oNw==
X-Received: by 2002:a05:6a00:391d:b0:74c:3547:7f0c with SMTP id d2e1a72fcca58-756e819e070mr16195961b3a.3.1752818942369;
        Thu, 17 Jul 2025 23:09:02 -0700 (PDT)
Received: from che-ventolnx02.qualcomm.com ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759c84e26d0sm531236b3a.8.2025.07.17.23.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 23:09:02 -0700 (PDT)
From: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Subject: [PATCH wireless-next v3 2/4] wifi: mac80211: Add link iteration macro for link data with rcu_dereference
Date: Fri, 18 Jul 2025 11:38:35 +0530
Message-Id: <20250718060837.59371-3-maharaja.kennadyrajan@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250718060837.59371-1-maharaja.kennadyrajan@oss.qualcomm.com>
References: <20250718060837.59371-1-maharaja.kennadyrajan@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDA0NiBTYWx0ZWRfXyrOz/aro2wC9
 nRtkMFBuxMxe0w6LpRDvuiLKKDJRluF/WB5S243TqY9VdKhot2UgXsoz+sTErABWjhiPrDlBO8C
 83CYa6ARwq5OnHA1ZszAm5foXymfDH2gs5gyei91/vPu8vNYq3pzlH2qt+MPtiDTEng3nCA8d1U
 XTS3d28pe/BQ1laqQAkp5PNMM/EKH0yjeodniSUhbHEhiMqBuO4BQ89L8RtZmlsKxkbtwtqDoeU
 cxc3PQny3pCdkQIsJ7vrKLCPGcNRXqSx0knFNd8IQXp8sqb1EvJbWCzZ/mIoQpwHY+pdfk1rX+y
 6yW83/E/ZbGQvrY5j6YUBMl3OdAy7mlcrU4+2i8r58zqUy4sraKZeV8qwgOpXooqOfn7sXg9unk
 NNOOmrpaHILM3PjxMQPlYY1lzOUe+uQsKvFltcZLRqbMkP9RrT7GB8ri/z7VmlTVk6xy0tGj
X-Proofpoint-GUID: n2uwquNipkcyNKX8tJvzE-U2DGpVa_N0
X-Proofpoint-ORIG-GUID: n2uwquNipkcyNKX8tJvzE-U2DGpVa_N0
X-Authority-Analysis: v=2.4 cv=Y+r4sgeN c=1 sm=1 tr=0 ts=6879e4ff cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=28aoLwbwrKESd3e5DxsA:9
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=717 phishscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180046
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

Currently, the existing macro for_each_link_data() uses sdata_dereference()
which requires the wiphy lock. This lock cannot be used in atomic or RCU
read-side contexts, such as in the RX path.

Introduce a new macro, for_each_link_data_rcu(), that iterates over link of
sdata using rcu_dereference(), making it safe to use in RCU contexts. This
allows callers to access link data without requiring the wiphy lock.

The macro takes into account the vif.valid_links bitmap and ensures only
valid links are accessed safely. Callers are responsible for ensuring that
rcu_read_lock() is held when using this macro.

Signed-off-by: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
---
 net/mac80211/ieee80211_i.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 7c18c51966d0..9c0603eb580f 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1252,6 +1252,19 @@ struct ieee80211_sub_if_data *vif_to_sdata(struct ieee80211_vif *p)
 		    ((__link) = sdata_dereference((__sdata)->link[__link_id],	\
 						  (__sdata))))
 
+/*
+ * for_each_link_data_rcu should be used under RCU read lock.
+ */
+#define for_each_link_data_rcu(sdata, __link)					\
+	/* outer loop just to define the variable ... */			\
+	for (struct ieee80211_sub_if_data *__sdata = (sdata); __sdata;		\
+		__sdata = NULL /* always stop */)				\
+	for (int __link_id = 0;							\
+	     __link_id < ARRAY_SIZE((__sdata)->link); __link_id++)		\
+		if ((!(__sdata)->vif.valid_links ||				\
+		     (__sdata)->vif.valid_links & BIT(__link_id)) &&		\
+		    ((__link) = rcu_dereference((__sdata)->link[__link_id])))	\
+
 static inline int
 ieee80211_get_mbssid_beacon_len(struct cfg80211_mbssid_elems *elems,
 				struct cfg80211_rnr_elems *rnr_elems,
-- 
2.17.1


