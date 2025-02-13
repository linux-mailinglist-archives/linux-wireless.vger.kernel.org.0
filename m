Return-Path: <linux-wireless+bounces-18948-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A37A351A0
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 23:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 512A33A56A1
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 22:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA78022D7A5;
	Thu, 13 Feb 2025 22:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZoRytg1h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527982753FF
	for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2025 22:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739487047; cv=none; b=Q+0rCLtJjIFDDbsa3PA7vbicAXYLXw4o7AQh7nof/6YwZpVQ30caCrY18Pd6p2gYmUWNBKqcvrr2Yej0H6v/aoYUAPWFOHNZC6ggAOXFDWz9ViWEF3opUiqpmi61UITyRpwhfVYQ75AZfvjw4Qp38XRIDZ3csheu/LFFrJnSnq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739487047; c=relaxed/simple;
	bh=IeLkZDdhETEUw+FPfZgo02WbCHEhKSkN4KCkAGDwsnw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nA+sIpjFhNHCOydYdbTe/gDBjODu6WmL2hRHenCN/OAn6ONxeBMxGYu3yhlGQ2VJ9U4KIAMoEjYV/oyUVZeyOK3uOmy2ZgnschxszRMsW8c2cDBgamq3iKFCd4cDRlYj9Az2uAwIWZVn5FQ6fQCplaGz6RX+z7GowDSQVTzPDAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZoRytg1h; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51DHEwn7008318
	for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2025 22:50:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=7QHH8TkTsDq
	axKjXZMczZxcJjHOjjkHmCEvXQXVJNZI=; b=ZoRytg1hKUUrjGBSOJJAWrqq8+j
	VybpfTXJ/mg2fbIoWbrs0bywqw6PDcaOdZWAoFvP6laNt1dJLsfd6asoxW8vKg07
	6p36H+tRQCXjIGsBfsJDeKxTdfIkc76Gb31L8bj7oT6S/iUD3LHzKLeu30um77VF
	al56JRVZyKI+SBN2vMIWh2DNhmA5ghHchIQJ0j+C6WIr7t1BKgqRLvyfbLQqsGYR
	b8q7V6hUw3/cJexm2YDZDliGmUbhxPZsEuRc8tK1dYbhZ6fLzJP4dSej6G0Bl6eJ
	woNuohuX0fJsWRoyybPlLt3pq2sefB4MMz4+f+LKPlDVUG+63heNnHpEikg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44qewhcaqj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2025 22:50:45 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-21f022fc6a3so29376765ad.1
        for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2025 14:50:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739487044; x=1740091844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7QHH8TkTsDqaxKjXZMczZxcJjHOjjkHmCEvXQXVJNZI=;
        b=ufktFnt31Kumyg3WD6bpJosdFIZHnLawsL38l/UllYUeHS6sx7361jc/gRW5sSbvas
         Iu4xp83+wXCbdqyYyOxMeYAxTGj/MTH4Qzj3JU3nT6WTvq4DsFt4W7MnwWXva0NiMAJW
         X/HKICN2WFacBBqhDAUBqT9fpvtS4lcYTnlDSaHw5r6d+hNyguLzwAy4QOFLMO85Y5Wg
         XfSfiI12r8POtOigR3TiPqnBt8jD1CpmsVEMbkPLnVfkPpZzYoi1tT0Lc1p5jRX/wphd
         +vhzd9w6XzGEn69c15jiAT7ugNbR4MO3m5Eb6bDzWoVcy3XbF7QBPjcJGwof/gg2pm9P
         aCvA==
X-Forwarded-Encrypted: i=1; AJvYcCVjm3hPfkzGOIzLC1f9Vz4OzruvvZa+dnENNHTnM255UiPnjyXmU9rKidBg/l9pr2cuMv9DCAkLjKVleHfwOA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzfM6cx8+2tvvKDNJsL6ArOmclKWF+IBsUpr4/b+AsKaMSrH3Zv
	RS7IyxeQ3j22ElrUB7VyC9E2qepFIMVgLDAAUJekRWZXA+JgXgOcGQDKOWeoP7htaPRid9JsZKM
	FIF3J6/QSenKjOsZJXptw277jc+In9G/EvnJIfPd43cX6c1b9FhVaErTTgIVWQswXyw==
X-Gm-Gg: ASbGnctJCuKKE6z36klMQOsphflaOxFG75OOQXlhjtzTHAEpcHaFe+QSrDn1IgKrPZy
	/UXe+zDH/s/nxp7E/aacxgKISWR2zVdYdWVkesHq8tTY3hPEIn5KdIjsyNh+jCmPY6gQUJ2y02J
	fpi00CZCeIS1ZS6GaIYm+hnBDsgePjOFAFES9ofE4DMPmRRa1xNkNlijCNKxreih+EywQlSVl2M
	Zn6a1AWPFewGFsW/OLh2gmgFALekxEXXhl0yiTzaVMUC25j0Ozb2TUorQPFcxBP6xQHXuFR7NFG
	64c1mFpSP34t/ExfYGVY7LLr/GCclGAUH8CLaIhoAO9ExDl4UbKuZOWJJoE3
X-Received: by 2002:a17:903:19cd:b0:215:a808:61cf with SMTP id d9443c01a7336-220d376b0b4mr76445575ad.25.1739487044573;
        Thu, 13 Feb 2025 14:50:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKnPyFyt17H+NQBkHBzvQy8lsquibSIE7E5VrIS8ldflXSj55yntdLeifjiTlOlYf+cwECzg==
X-Received: by 2002:a17:903:19cd:b0:215:a808:61cf with SMTP id d9443c01a7336-220d376b0b4mr76445315ad.25.1739487044232;
        Thu, 13 Feb 2025 14:50:44 -0800 (PST)
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d55916c7sm17571665ad.243.2025.02.13.14.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 14:50:43 -0800 (PST)
From: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
To: ath11k@lists.infradead.org, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        Aloka Dixit <aloka.dixit@oss.qualcomm.com>
Subject: [PATCH v3 3/3] wifi: ath12k: use link ID for CSA finish
Date: Thu, 13 Feb 2025 14:50:36 -0800
Message-Id: <20250213225036.3118133-4-aloka.dixit@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250213225036.3118133-1-aloka.dixit@oss.qualcomm.com>
References: <20250213225036.3118133-1-aloka.dixit@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: -9sAMTbN6uFMjlufUQzbqsDTI3BvflfN
X-Proofpoint-GUID: -9sAMTbN6uFMjlufUQzbqsDTI3BvflfN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_08,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 impostorscore=0 mlxlogscore=999 phishscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502130160

From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

Send link ID instead of default 0 to finish channel switch operation.

Signed-off-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>>
Signed-off-by: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 4dd6cdf84571..198e22ec6735 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -6894,7 +6894,7 @@ ath12k_wmi_process_csa_switch_count_event(struct ath12k_base *ab,
 		}
 
 		if (arvif->is_up && conf->csa_active)
-			ieee80211_csa_finish(ahvif->vif, 0);
+			ieee80211_csa_finish(ahvif->vif, arvif->link_id);
 	}
 	rcu_read_unlock();
 }
-- 
2.34.1


