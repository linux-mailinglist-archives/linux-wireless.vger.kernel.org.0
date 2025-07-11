Return-Path: <linux-wireless+bounces-25241-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CE4B011AC
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 05:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFCF27613E5
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 03:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D072019DF5F;
	Fri, 11 Jul 2025 03:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ChSfG2hr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC12816F265
	for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 03:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752205144; cv=none; b=o1m//bU0smDkbQD/3SFQlL/YNGDnQJpBhRJflpaPOdM+Y5S+A7v0o2wFpuWRWf6ksGdbAiQVyWT9YAlw8aGyT9rVIExXEQUYGNan1lE2rEAH8f2ALkyBIwZWuFFpXmKRKBeTFVUgLcprfZhRmMqtbEt9+yNQEBMk/zQtnsQa44Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752205144; c=relaxed/simple;
	bh=whqWhItsrMNf4gE32HuFdHaiJbqKiUzKTZLlAzTOT2k=;
	h=From:To:Cc:Subject:Date:Message-Id; b=YUcUGauQuaB7EA+c0MpUxAt8tkmvyKHYfiizWNTOz0I07NxRUq04VphcTmV1bDIXmoEiftH8NFv6KLeNBPswxuVJ5nEsVVw0TYBLZalpqvOnm5MxXV3yuEDKSA3iBXUQKWEIoyy6er7MqgdFBwLYnH+DOy0zMAbT9KRympASO+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ChSfG2hr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56B1XF7i012862
	for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 03:39:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:message-id:subject:to; s=qcppdkim1; bh=tKUVgnCQ1gxr
	UmXvF7MOAVez054T0QLhXRSUhyfzbJY=; b=ChSfG2hryp8eGYWzATib+fNnqCK9
	uy2tWkmszuxl6uxfKH7djsbjVUFxTCAmZr4mYIeBwsN/UjbszVzpyECm+9Llac2j
	i0MYjqpOdwku590btFix8xkMtpFHydQJ4ZlTO3Tw4zTyLjqva6u5MncdBko1Q9Fd
	FtkjbcJOZR5mRrLkwxK04a77AgC56hZ8byoxhozetbdiS5tMjC+nCMVmVks4GwzK
	dr6GEKsFz6TUf46RRlPCuLGfxVG+EhcjsKR9K6DR/+0cXdfHRynOPdWemrMF/b4d
	rzZTZpaODsT7mTXAVr4ofQV6aTz7h0GSNUWTYYc+3RGAZpZlZwdpyNXZdA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47sm9dy4g9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 03:39:01 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b3bc9d9590cso860240a12.1
        for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 20:39:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752205140; x=1752809940;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tKUVgnCQ1gxrUmXvF7MOAVez054T0QLhXRSUhyfzbJY=;
        b=GR/gm64MzLVdC4VAHWlaMUs7VLqhEDp/xAjCWST5LDpSWREpM+NrLKEWto//mgDWvc
         ui7n4Guor6Lg3TdmsgBTyEvqQPRg1Typ40El4yiBq3vyQIC18P4Op3F/prUM6OPVzfHI
         QYZEzhxzSb3y6MEbzeNH44j5kKgXt5NkrYxAfprfHqCReF4aSQo33M2QIMDt0msMwpFr
         8rpLn15CSrX1lukxizx8vXMkZdP2SFGRhQvpGRDFW8KvYu61UdsmJLAEia99nkMz6DWl
         8SNQKbQOYzpBLDnRgI/aGoD2Coof+rgwLbaD4FxVh8R9/zdQfvFRUIsYgXHh3KeOiNBQ
         ctoA==
X-Gm-Message-State: AOJu0YwBAhR7rnKXuQCiCFESBTkIMDxTbymxiRDErEJGsIqvM6R3BN2q
	cJjN3zdSBnsXS08wE1viBk5/Xi3DUPzdrqQ6KPC76/2Y4HPnwtlWTDEXjGuYX19TqAxZScm20aR
	jMA7qzrpvmDvVumoThEe6Y6KEFPfXeqecXEM19h4LUAretdrQApcmfamA5yQuSuJ7bXEgrgW1cu
	Xi3w==
X-Gm-Gg: ASbGncvnHck9RlymSG5xWtNzksvmFYu/AmhDEoSw/roqO8oFvKmcgIiAxCmgeFi7h82
	G+D0KXMcKMETjU0jcUIGi846OuPZjj7msuR7scc09AQFrseGghh8Q88yQQhlzKSmFW+KaQgBCyQ
	shzOq52X7wkK7l1z1pxtup1r7tSUcnVIpuVh3wQe/hWhFsCHe0oZgoaDB3t9o826LnO3zRR9ofx
	ILtLG5QJCabXWpjsviyN4GPO2jvAku2IIp6sxxTWpJLboQT+GqsWmFqCYgHQC2841+4ktVPCYjO
	usEJtHVaE8uyubdhdx/Eqnbeqqf/En9AtVneFsdn2TriXe967JOSD3NEAU9NHYUe2kArbZYAsHp
	Q2FKSIuc=
X-Received: by 2002:a05:6a20:a108:b0:220:8c06:8615 with SMTP id adf61e73a8af0-231208046c1mr2807242637.36.1752205139967;
        Thu, 10 Jul 2025 20:38:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLKTeLtIGR38iYYN9uja1D9ER3qS5c0sQbbLtO4xM/gOExaNUPss3qLLfYqa6vOCa/86GG1g==
X-Received: by 2002:a05:6a20:a108:b0:220:8c06:8615 with SMTP id adf61e73a8af0-231208046c1mr2807217637.36.1752205139554;
        Thu, 10 Jul 2025 20:38:59 -0700 (PDT)
Received: from che-ventolnx02.qualcomm.com ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe57dc09sm3756755a12.26.2025.07.10.20.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 20:38:58 -0700 (PDT)
From: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Subject: [PATCH wireless-next] wifi: mac80211: use RCU-safe iteration in ieee80211_csa_finish
Date: Fri, 11 Jul 2025 09:08:46 +0530
Message-Id: <20250711033846.40455-1-maharaja.kennadyrajan@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-GUID: a5YXb_tusfFSJQrSV8IY1H1_zRi1Kdqs
X-Authority-Analysis: v=2.4 cv=W7k4VQWk c=1 sm=1 tr=0 ts=68708755 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=M10hxwpqwCanTSsDGlEA:9
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: a5YXb_tusfFSJQrSV8IY1H1_zRi1Kdqs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDAyMyBTYWx0ZWRfXwmjMUChO+Bti
 41gAnjV0XQ3QlWPtQNOeHX0SQup7k2gAnILgUAqVs1RNsXsMzQYIf5lxbaXYWHicT3n/Kwnabpg
 /03GVrQdOnRR6wTth8dQPmtyQwF1oEPEj9AD/ZdU3MGjjn9vrl0fT7aqt3r9WvK9DLM0FCBcvzY
 iMcTU9XmFP3HOo46AIMxhUr0MrqyI1H2dA7M9QMdyaT1YEV6RIMXFJjVJ2OWcmy9Mn4GHEKjqqk
 uEYvrFtN3wiz5PCeyCF7GBQMb5qLnvY75Tt5WxevEmxXkYa+PE4wkoPLtEN1rtHZOGRgV5BQMOX
 1x/EHl0+TNHerI80Nug3r1rjO6afhdGc1V76bPhG51TPeWFplDFRTwBzwUtMpWAQyOGANiKIjnt
 H3Re0XVa8A+7CEobbmD6Tnuikr9Za6SehcVbfJdwU+WcsIgDcv9c+HYzzCmSEMcrDPRplWdj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1011 suspectscore=0 phishscore=0
 mlxlogscore=854 priorityscore=1501 impostorscore=0 malwarescore=0 mlxscore=0
 adultscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507110023
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

The ieee80211_csa_finish() function currently uses for_each_sdata_link()
to iterate over links of sdata. However, this macro internally uses
wiphy_dereference(), which expects the wiphy->mtx lock to be held.
When ieee80211_csa_finish() is invoked under an RCU read-side critical
section (e.g., under rcu_read_lock()), this leads to a warning from the
RCU debugging framework.

  WARNING: suspicious RCU usage
  net/mac80211/cfg.c:3830 suspicious rcu_dereference_protected() usage!

This warning is triggered because wiphy_dereference() is not safe to use
without holding the wiphy mutex, and it is being used in an RCU context
without the required locking.

Fix this by introducing and using a new macro, for_each_sdata_link_rcu(),
which performs RCU-safe iteration over sdata links using
list_for_each_entry_rcu() and rcu_dereference(). This ensures that the
link pointers are accessed safely under RCU and eliminates the warning.

Fixes: f600832794c9 ("wifi: mac80211: restructure tx profile retrieval for MLO MBSSID")
Signed-off-by: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
---
 net/mac80211/cfg.c         |  2 +-
 net/mac80211/ieee80211_i.h | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 56540c3701ed..263e927ec7fe 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3827,7 +3827,7 @@ void ieee80211_csa_finish(struct ieee80211_vif *vif, unsigned int link_id)
 		 */
 		struct ieee80211_link_data *iter;
 
-		for_each_sdata_link(local, iter) {
+		for_each_sdata_link_rcu(local, iter) {
 			if (iter->sdata == sdata ||
 			    rcu_access_pointer(iter->conf->tx_bss_conf) != tx_bss_conf)
 				continue;
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index ec68204fddc9..5682edc0904d 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1226,6 +1226,21 @@ struct ieee80211_sub_if_data *vif_to_sdata(struct ieee80211_vif *p)
 	if ((_link = wiphy_dereference((_local)->hw.wiphy,		\
 				       ___sdata->link[___link_id])))
 
+/*
+ * for_each_sdata_link_rcu() must be used under RCU read lock.
+ */
+#define for_each_sdata_link_rcu(_local, _link)						\
+	/* outer loop just to define the variables ... */				\
+	for (struct ieee80211_sub_if_data *___sdata = NULL;				\
+	     !___sdata;									\
+	     ___sdata = (void *)~0 /* always stop */)					\
+		list_for_each_entry_rcu(___sdata, &(_local)->interfaces, list)		\
+			if (ieee80211_sdata_running(___sdata))				\
+				for (int ___link_id = 0;				\
+				     ___link_id < ARRAY_SIZE((___sdata)->link);		\
+				     ___link_id++)					\
+					if ((_link = rcu_dereference((___sdata)->link[___link_id])))
+
 #define for_each_link_data(sdata, __link)					\
 	struct ieee80211_sub_if_data *__sdata = sdata;				\
 	for (int __link_id = 0;							\

base-commit: 6b04716cdcac37bdbacde34def08bc6fdb5fc4e2
-- 
2.17.1


