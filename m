Return-Path: <linux-wireless+bounces-32559-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJfVMxusqWmtCAEAu9opvQ
	(envelope-from <linux-wireless+bounces-32559-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 17:15:23 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1503521541D
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 17:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 650B73021455
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2026 16:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F1F3CE4B5;
	Thu,  5 Mar 2026 16:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Bt4GZW7L";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ee86Sj0b"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F023D3CE4BB
	for <linux-wireless@vger.kernel.org>; Thu,  5 Mar 2026 16:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772726893; cv=none; b=CVtq4jartFgO/e8S2VmUPAOSeA7FHCFZDy9Z5+Eh2j6Y3wEtkXPHUSDPOK4Rt7bdJGjNCIOzuFsCbtEmcu1DCtytF+LnHmvT0K0/7v7zRdmwngUDrLf2AU2dCslA52sWarbK54q+e1KJIq2azP7Q02ebuxTi7ge6KNN+Rh7fp+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772726893; c=relaxed/simple;
	bh=Y69j0dJGomIZl+NX/szhXLyowFX+2ihohTfRDbRKvDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W7JlwlApfWmhGPiwqIWlpwovmI/sUjZdRsg8wNyba9w1HrVe07J9qR/VyEBmWwiRGyyWSfOab+lipR26rFqmXZj/NH5RsIb5PpltbIBn78Nz4M/ajK/J+enN8yTuQgBLmvyrXjnAEtiZRrkGU+L7hq8Kr8aE4kpoznbAv09emp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Bt4GZW7L; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ee86Sj0b; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 625AG4hE936997
	for <linux-wireless@vger.kernel.org>; Thu, 5 Mar 2026 16:08:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=GIM1eCoZ/Wo
	onlthLz1wRIhLEJCBsAPu7Es5P4SBH7g=; b=Bt4GZW7L7bmY1NrWBPQZGarvz4P
	LafnD4t3Ue6nfd5QiyBY/jYB4rem1OW/ou4ilRfGv5tSCswNFa7sw0VwtrvwRUu5
	THn8gO4DByOg2tqCHgX/e/mplrG/lcLvF3rrq6v/pNK7RNwc0qbwQpbJRb2RUbh0
	8yV7uJeMeOuOQFTfK2nDI1SKsniXQHaIBKlPaGderKwUnxQztqpDjsodEh8sOGVS
	r0ZQgmN06Tk8Shnv2gBDmTnvL4bXUYkxKPwcjIvX91cMYkA4eY2ufa6Z1yyZ8V4u
	4gETzcb8QrOUwu7stqwZPvjXy0rtaSrY7hY5KUpTBt9rilFf0RmN5pf/+tw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cq04u2s3h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 05 Mar 2026 16:08:10 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2adc527eaf5so45744485ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 05 Mar 2026 08:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772726889; x=1773331689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GIM1eCoZ/WoonlthLz1wRIhLEJCBsAPu7Es5P4SBH7g=;
        b=Ee86Sj0b1lxW2ugMONv7+jsCCj6lnhiYcMG0evzY1afO15t+IfP5ByvZs4kjk61ZB5
         6IfW0+ZiEy8/CfiZSZFHknF2ceQ/wtd3Sfn/R9ujZ1Xtysml3LH5DVxZLqs+KPfJiZHB
         sWGos9HRRsk7RlMwhVDglLo1qlAR29F6WkoYWQ5zEA16KRzHvZkm8yYtKdyMb7SQlohk
         Hi1x7aX3B2GLmtPhNJYcYoCur+PgMHNUONqYHuJHfOs0X8WH3XIpv/ZqyhOFfe0KiyK+
         4P+VE4+SLyRDtntaeAYIOtDMWYg2Dxmb2dKteEsqwMMTrr1KKbjc0ZpZHrrid4VwzXu/
         enLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772726889; x=1773331689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GIM1eCoZ/WoonlthLz1wRIhLEJCBsAPu7Es5P4SBH7g=;
        b=eMT0Gn5F+PJKS2egD922PC8RbD/N8lEDEJ1ElcR+ExV4F8zAGF+1XiIzaPomt19DLj
         nixBgyDR6D3Watg+aF2seQcvWfMzZwzQKMrpy/P9rBLCAr9RVSN7GyYLIpi4dAI1Zj5F
         okyKbaVBJfCxLSr2n9oaadFy4WrsdQG6kooxILewgYl7rjHdfvWGByuiKkaWA4WRacBl
         PSw7EuCwP1gnKXlHuqpam4yR0TvXz61WiiJ2rFLhEWPIyQnyhn8uRwc9YgM0NIk7+trG
         /V7SW6xj/pJRTIEU1LXiPmgnE5CH4FYH31/qICsjRzDag7JxvmS9RMlnMTNaAdkNMgEL
         288A==
X-Gm-Message-State: AOJu0YwZcuuj747tjQvl+IJ9RTsETpITL9sZ9kLL7UiHd7LfC1N2obZ1
	3agEh/SpJ5+6YZtsoovGhJLbabMyM2iSJW1FYBP6xgSUpwK2angRBPRF6G+92WiKCD84NFNW0mb
	XdowIZarP8nETmtAK28eBVYa14u4/3i5zf/YDcgVXXAZOOcrtNzNpuDshzIlEyff2QQ17
X-Gm-Gg: ATEYQzwDGbQusveUr5FJEOSunSCCLswJNqzWyrbqG+JFlU0eevfLaYZcVnlCa1xZn+3
	P8RBNungGQGP+S3Z+TpYHNKnNQPLrwOYUiO91YBR4Bl7M+7DxrC06Zw3igYVvPAw4cNALEePf/A
	9BWqDTx5y8Afmw1jYW/5BcMYXwuYnNVAXIy2kne5AwVWT9IAxY/o0BOEsKV1Cv15OsSnuk+hj24
	rh6nUJ4xiuQOKu3lWpk3LczIqPbBXg0B8gWzRyDxFiZpQ21ETTkcUwzPAdgsst2VM1JtdkprCgD
	SfYP0c6YiC1UrtW1SLtdMNoJRjrVQ9OXafhArj5ydUf/9oAtIM7QJ5hPlUhyR3X3uzgWxeNv5Ta
	LrTfO6304yJFZ8hF/CgARSh8Hm0eHZ7a1seFuWI9niHhR6Pf368HT5jQ=
X-Received: by 2002:a17:902:ebd1:b0:2ae:7f3a:b213 with SMTP id d9443c01a7336-2ae8025aa14mr1624365ad.47.1772726889286;
        Thu, 05 Mar 2026 08:08:09 -0800 (PST)
X-Received: by 2002:a17:902:ebd1:b0:2ae:7f3a:b213 with SMTP id d9443c01a7336-2ae8025aa14mr1624105ad.47.1772726888720;
        Thu, 05 Mar 2026 08:08:08 -0800 (PST)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae489c3626sm133773575ad.8.2026.03.05.08.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 08:08:08 -0800 (PST)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
Subject: [PATCH wireless-next v3 10/15] wifi: cfg80211: add ingress/egress distance thresholds for FTM
Date: Thu,  5 Mar 2026 21:37:07 +0530
Message-Id: <20260305160712.1263829-11-peddolla.reddy@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260305160712.1263829-1-peddolla.reddy@oss.qualcomm.com>
References: <20260305160712.1263829-1-peddolla.reddy@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Ff3Mswe5w7IS8JQj6Xa5uN0oxd_9QVtl
X-Authority-Analysis: v=2.4 cv=eqTSD4pX c=1 sm=1 tr=0 ts=69a9aa6a cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=34tgYfNVuceZXYEjieIA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: Ff3Mswe5w7IS8JQj6Xa5uN0oxd_9QVtl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDEzMCBTYWx0ZWRfXx8bBgxfVqFUS
 QkkdFN46K7HQyFIsEWgBqYtvC9q0euQxNTQjoylSERLQeeqt//BwWMrgLnIWdmcF2V4zqIO1UU9
 Pmjl18s0+LFrteWzOyKwIqQ5dSOxn3lYyXOl0dfCKIeF8m5SFWGH8bTKGwk1lmzQSHHdmyHy7Zc
 vJY5Z7pyETtWuuSHnOEEm7oZpYR13PxzWBL62dRZfj+vIM8KcQwdciCf4APmpUz3oG1NBbgOWG8
 yG2AJofM7ULGJFBo5wEi5SZv+C94Y7BnXE9tiaOpw1imcecDsF9p9e8LmzqwsyL8pRpOmXMq7c3
 jrMO3S2sJT/77b93sZaUaL1cZ+caEO57m5psZabQwWkKBWDpRxF8X899Qz2Jzr8mCb5AtvklrWS
 zCYJGFrpzfbsp94Ro3oldHCYjUhkMcX93dW7ZN9zt804WqaAdzFGUb2HYAItwPqpS1QihyemnUP
 f8xBjJ5LklfY02eNXWA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_04,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050130
X-Rspamd-Queue-Id: 1503521541D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32559-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Proximity detection applications need to receive measurement results
only when devices cross specific distance boundaries to avoid
unnecessary host wakeups and reduce power consumption. Currently,
there is no mechanism for applications to specify these distance
thresholds.

Introduce configurable distance-based reporting thresholds that
drivers can use to implement selective result reporting. Add
ingress and egress distance parameters allowing applications to
specify when results should be reported as peers cross these
boundaries, enabling drivers to reduce unnecessary data transfer
and host wakeups.

Signed-off-by: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
---
 include/net/cfg80211.h       | 9 +++++++++
 include/uapi/linux/nl80211.h | 9 +++++++++
 net/wireless/nl80211.c       | 2 ++
 net/wireless/pmsr.c          | 8 ++++++++
 4 files changed, 28 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 8bbca2a98ac1..1b663627a0e6 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4439,6 +4439,13 @@ struct cfg80211_pmsr_result {
  *	in units of milli seconds. Only valid if @non_trigger_based is set.
  * @measurements_per_aw: number of measurement attempts per availability window
  *	with a maximum value of 4. Only valid if @non_trigger_based is set.
+ * @ingress_distancemm: the measurement result of the peer needs
+ *	to be indicated in case the device moves into this range.(units mm, u64)
+ *	measurement results need to be sent on a burst index basis in this case.
+ * @egress_distancemm: the measurement result of the peer needs
+ *	to be indicated in case the device moves out of this range.
+ *	(units mm, u64). measurement results need to be sent on a burst index
+ *	basis in this case.
  *
  * See also nl80211 for the respective attribute documentation.
  */
@@ -4463,6 +4470,8 @@ struct cfg80211_pmsr_ftm_request_peer {
 	u32 availability_window;
 	u32 nominal_time;
 	u32 measurements_per_aw;
+	u64 ingress_distancemm;
+	u64 egress_distancemm;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 83d2a822c770..174592017486 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -8049,6 +8049,12 @@ enum nl80211_peer_measurement_ftm_capa {
  * @NL80211_PMSR_FTM_REQ_ATTR_MEAS_PER_AW: meas per AW field shall indicate the
  *	number of measurements attempts per AW with a maximum value of 4 (u32).
  *	Only valid if %NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED is set.
+ * @NL80211_PMSR_FTM_REQ_ATTR_PAD: ignore, for u64/s64 padding only
+ * @NL80211_PMSR_FTM_REQ_ATTR_INGRESS: the measurement result of the peer needs
+ *	to be indicated in case the device moves into this range.(units mm, u64)
+ * @NL80211_PMSR_FTM_REQ_ATTR_EGRESS: the measurement result of the peer needs
+ *	to be indicated in case the device moves out of this range.
+ *	(units mm, u64)
  *
  * @NUM_NL80211_PMSR_FTM_REQ_ATTR: internal
  * @NL80211_PMSR_FTM_REQ_ATTR_MAX: highest attribute number
@@ -8075,6 +8081,9 @@ enum nl80211_peer_measurement_ftm_req {
 	NL80211_PMSR_FTM_REQ_ATTR_NOMINAL_TIME,
 	NL80211_PMSR_FTM_REQ_ATTR_AW_DURATION,
 	NL80211_PMSR_FTM_REQ_ATTR_MEAS_PER_AW,
+	NL80211_PMSR_FTM_REQ_ATTR_PAD,
+	NL80211_PMSR_FTM_REQ_ATTR_INGRESS,
+	NL80211_PMSR_FTM_REQ_ATTR_EGRESS,
 
 	/* keep last */
 	NUM_NL80211_PMSR_FTM_REQ_ATTR,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 0642b7a31a32..adbc53808135 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -381,6 +381,8 @@ nl80211_pmsr_ftm_req_attr_policy[NL80211_PMSR_FTM_REQ_ATTR_MAX + 1] = {
 	[NL80211_PMSR_FTM_REQ_ATTR_NOMINAL_TIME] = { .type = NLA_U32 },
 	[NL80211_PMSR_FTM_REQ_ATTR_AW_DURATION] = NLA_POLICY_MAX(NLA_U32, 255),
 	[NL80211_PMSR_FTM_REQ_ATTR_MEAS_PER_AW] = NLA_POLICY_MAX(NLA_U32, 4),
+	[NL80211_PMSR_FTM_REQ_ATTR_INGRESS] = { .type = NLA_U64 },
+	[NL80211_PMSR_FTM_REQ_ATTR_EGRESS] = { .type = NLA_U64 },
 };
 
 static const struct nla_policy
diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index ab25fe07c946..b7e3f3a33460 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -234,6 +234,14 @@ static int pmsr_parse_ftm(struct cfg80211_registered_device *rdev,
 		return -EINVAL;
 	}
 
+	if (tb[NL80211_PMSR_FTM_REQ_ATTR_INGRESS])
+		out->ftm.ingress_distancemm =
+			nla_get_u64(tb[NL80211_PMSR_FTM_REQ_ATTR_INGRESS]);
+
+	if (tb[NL80211_PMSR_FTM_REQ_ATTR_EGRESS])
+		out->ftm.egress_distancemm =
+			nla_get_u64(tb[NL80211_PMSR_FTM_REQ_ATTR_EGRESS]);
+
 	return 0;
 }
 
-- 
2.34.1


