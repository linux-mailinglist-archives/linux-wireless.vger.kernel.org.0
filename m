Return-Path: <linux-wireless+bounces-23075-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F33AB9A3A
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 12:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAA67500395
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 10:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957362356DD;
	Fri, 16 May 2025 10:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PEUFMCAm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8DE233159
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 10:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747391548; cv=none; b=ZxENheG0e8044UXqt/cXfRTWusmJ/s5iY9yJN/Hn9pC5y/KE0ObJJ+5a04N6k1v2Y+CGgbcGiT505pAIJCkZtUR8QV97aTdo6Nlo8cD1mM5oPU/Ls5vh2+sh5vd59x3hHPvkFIV78qbgzIq0Nnxjte+vZdcegQvWiNB6aaml/aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747391548; c=relaxed/simple;
	bh=2aCYsID7h6PKzoWsDWjEbsYtZRpxTQpf8z0Sn6LvenY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MSBkqxss6mXD5Ey67f1Ew7Q9tCLuM5tQtZKmG6F5qq59xfQxmgBayivxrDFfold/FD8ImU+DfdYvmi02rpQc+CBuWBQ7jfynBLTr4jj9gJ0O1CtA53rxp37XY3Ozeyb0CHF+/yvmXIum1oWxTDJ5fPuY+espPeo6w3eI1LsjiEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PEUFMCAm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54G2v6O4032701
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 10:32:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5DlwmdNmedCKJPdbWIvXijFc/3cbsfXTmrrSp5SO3l0=; b=PEUFMCAmjEecjisW
	0OcfCooXGYT+YBGJWpaGqi3s0TCFaXdlXKx7N2Wd8aIcAHYreTZ/6ad2NkslX97R
	Vsj23Q0nUilQ7a1hujr9T7ZOqOIqiE1E/l98p50UReJYSZUZBlOnMoa8GiYHeXKs
	z4zwIWmeuCk+7FMw/AXapLAB6Zu1efLdDcp97sbfYBftn8mHXh/es8nErSn1RYmb
	CPOgrfFla5FcOFl2EdzsDqjaRu3z5Iepc+SemW26phszV1kiUhmD59MK3KJ2GCeY
	xUmhNUUdfDSDhP7StmgzE20l7w38TrWfPL/k05NBugITERY3WaaZeCIcO4/viE61
	f7unQw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcp1k03-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 10:32:25 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7370e73f690so2288062b3a.3
        for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 03:32:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747391544; x=1747996344;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5DlwmdNmedCKJPdbWIvXijFc/3cbsfXTmrrSp5SO3l0=;
        b=c+vf/5F5cfLJCKCDgM56V0KsNzrklB0xMERmmnzmfQ/OJQe5qcDTWUg/o8I6nllxOP
         dtMXvLjOwA0QK3yJwIjahX1M+KRMqX79sKWygPKU+BJ9Tbns3po8YjcodXJQPFaGFFnh
         vNdiumztK6ciCIKPR6+E39gpvs8AKhc9eUcoqcuqb5E+nk6FD/1nTgeK0x9nxipO/oI4
         anrXf/R5vxzDNXXmHNQdONYRb3sxcd0oxfoJUsLAK3VLyY7Xy8pIzCVMI0g4P+4aLaSa
         vJaAbenji5/OofWFPyZTWKa8at5/Q8FgZSixj7pKoZgN8BXr+ML830DMlrYEj7NKSgjj
         thQA==
X-Gm-Message-State: AOJu0YybJ3KQxt7XwVMn4YhoVkiE2dEGdi9d1qRgyogpr6TuG6StyWpI
	WKxKoBiOIyA4aLg99Kc26zH19O80DLtcFlUh1E2PN0OUudTaPFpBcbM7bMMIIiD8ffAtjwxovxD
	184WDPhAUOeRylJKuCd2U1Nu8kLT7xf0OwrpS2KGQ5OZa4/CzwaT///yBQYzL7FPIEY4xHnT2Rb
	5whw==
X-Gm-Gg: ASbGncs1bbv4GuaAEGcGWwwPbZ0bAbegyda0E11kmRJCMKwN6EuP6iovq7LbLC3mFxX
	D8jtvAUgJbOWrYd9xIihirtOxyfbcNlbpCrO0yCR+AgFU8l6t06+jG90WW6Tyfdl36b7EMYIF5c
	jy3RUDVg3AbR4AtDLrMH7NedtTuYaHWBcXqD7MEloLRVuQvaFlIEzy+5klzB5qwf/YcOS0jkeUk
	T/WrMk5WhI5R1I+BbZyC3l2ELcrIjOs+rnArykkTLc+Xm2Ka2coxykf/IuQdjrGcD1SgiTMcrN5
	o4aUTcf/oneemfpo2UFoysCPNHXN3QDHj1vHfHFPxg++uY5sKLbcaFkEldbN/1GHBt3bi3bhwTB
	8iT3XRSfGT1AI/Wyf+7USFyKjwWx16sbkFJZE
X-Received: by 2002:a05:6a00:2d04:b0:73c:a55c:6cdf with SMTP id d2e1a72fcca58-742a978ebbbmr3468649b3a.1.1747391544249;
        Fri, 16 May 2025 03:32:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFteE3Mw4pPWiE7vfRquHKpv93rwCXiS52hSupKTl7Ckq9iVLreYnHqgng08z9QmeE+vjgsaA==
X-Received: by 2002:a05:6a00:2d04:b0:73c:a55c:6cdf with SMTP id d2e1a72fcca58-742a978ebbbmr3468606b3a.1.1747391543642;
        Fri, 16 May 2025 03:32:23 -0700 (PDT)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a986d8d7sm1247585b3a.130.2025.05.16.03.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 03:32:23 -0700 (PDT)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Date: Fri, 16 May 2025 16:02:08 +0530
Subject: [PATCH wireless-next v2 2/2] wifi: mac80211: accept probe response
 on link address as well
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250516-bug_fix_mlo_scan-v2-2-12e59d9110ac@oss.qualcomm.com>
References: <20250516-bug_fix_mlo_scan-v2-0-12e59d9110ac@oss.qualcomm.com>
In-Reply-To: <20250516-bug_fix_mlo_scan-v2-0-12e59d9110ac@oss.qualcomm.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: FmymP377KZxb7XqXeaEbB4WNnRi_HI_h
X-Proofpoint-ORIG-GUID: FmymP377KZxb7XqXeaEbB4WNnRi_HI_h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDEwMCBTYWx0ZWRfX+DW5Gjr6LIfU
 GoXadGgYCxx4ercTIybvpXfc5Dt4ivMFqTFYrABAE41PieZqA8F2m36AJEnr1/AdBR6RpQzA+qc
 IUSekIwcdn1UTWenxQ86JvYpDmtyRqUo90jsa2kEiQOuDb+zExFW6tQtgoRntnFhEGHRMUnivsn
 PqkluluTwds9wiuyqpevxm7UKyOPTuIjSTjUqHvhuK1mZS7GmkbnBfRBzjGEMgXKnkj+lGagoht
 2pVEoyZ4oUfkxUFBpxnE6aiOXhNB5Yw8cfDLtGXLUIE/JS6Z+0A5ry9GEvKMjUw7T9jmgPPB/EB
 1oN5tqDAP6O/E3xSqFJOtRds7ujCevsF+cQY9l4fYZtMaEIngqwXlNSw8wjdqLoPK0Oqa/IMIbW
 63sr8/WcZNtt21pHc7YvXPuflO6HWNYk9CoX0CEhbBSACeomZKyry7dx8AHKQFQ0uoV2t2iI
X-Authority-Analysis: v=2.4 cv=Gp9C+l1C c=1 sm=1 tr=0 ts=68271439 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=kffUEhMhicqf5g7Do04A:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_04,2025-05-16_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 adultscore=0 suspectscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505160100

If a random MAC address is not requested during scan request, unicast probe
response frames are only accepted if the destination address matches the
interface address. This works fine for non-ML interfaces. However, with
MLO, the same interface can have multiple links, and a scan on a link would
be requested with the link address. In such cases, the probe response frame
gets dropped which is incorrect.

Therefore, add logic to check if any of the link addresses match the
destination address if the interface address does not match.

Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
---
 net/mac80211/scan.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index cb707907188585d6874bf290874bdb0ca33bb399..7b8da40a912d020f229a74c67bd5a57fb513a72d 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -240,6 +240,9 @@ static bool ieee80211_scan_accept_presp(struct ieee80211_sub_if_data *sdata,
 					struct ieee80211_channel *channel,
 					u32 scan_flags, const u8 *da)
 {
+	struct ieee80211_link_data *link_sdata;
+	u8 link_id;
+
 	if (!sdata)
 		return false;
 
@@ -251,7 +254,20 @@ static bool ieee80211_scan_accept_presp(struct ieee80211_sub_if_data *sdata,
 
 	if (scan_flags & NL80211_SCAN_FLAG_RANDOM_ADDR)
 		return true;
-	return ether_addr_equal(da, sdata->vif.addr);
+
+	if (ether_addr_equal(da, sdata->vif.addr))
+		return true;
+
+	for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++) {
+		link_sdata = rcu_dereference(sdata->link[link_id]);
+		if (!link_sdata)
+			continue;
+
+		if (ether_addr_equal(da, link_sdata->conf->addr))
+			return true;
+	}
+
+	return false;
 }
 
 void ieee80211_scan_rx(struct ieee80211_local *local, struct sk_buff *skb)

-- 
2.34.1


