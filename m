Return-Path: <linux-wireless+bounces-33597-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OECVH8CLvWnY+wIAu9opvQ
	(envelope-from <linux-wireless+bounces-33597-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 19:02:40 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D882DF16C
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 19:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E041A306839D
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 18:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27C630FF33;
	Fri, 20 Mar 2026 18:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZRCkMBVO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U7n+UEja"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568CE312832
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 18:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774029635; cv=none; b=hvSOZvgZVC9LkoxgRODDH12vltD5u0wVKZytpwm7oiw6kx5Qg0vBo0mcQbhxMFBvDXcwFjOS2DnXMN4NmxVejHYNOeXImGx+UwhQU2g5/myAPhL1QkHrGNYu8+2lM/i5YoM0/myPx9kDo/3AfbqlqEdLbFLlCOzDXiDUuj9JCVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774029635; c=relaxed/simple;
	bh=tl0WhL1fCHgoe+82HaI8C6qg2fItrEPS9rzLqLp4wM4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YpMij4v4rCWeKE4UOcsaV0d1UjD8JWYcQR+FOi3m5ThKFDYIDYO7HRi++MLOml/oPhWVD3UyPe9LzWYwHb3NM3GiAzzOtXuOWJBFgGzvBjXosZBIXZbl8XuaNWh88i/niAAJzat0qfOeMV4h33nAC7vmEc9iBxso7LiTUL3tyE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZRCkMBVO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=U7n+UEja; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62KBsIYJ3875472
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 18:00:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=/xBLL0+oVT0
	QjHqlpwUUCNWTBSkH/14pqegZTnvrk4s=; b=ZRCkMBVOEAaSJ7ySJc+Z+iRLZn4
	1rgFumajJNsbTMj7duMRcgXMj7UvK2C5cz8u01G1D8leYaEnHCHzxLiH+d/wMgUQ
	gYO7sSTv5QOdUpyiZ8R11iWhXKUPHyDDrJqbF19jRr6UNVBEJjC8d7ez/KvknjEE
	SQc2jsxpzgqTAImCV0qopoAIEvoEBThcHArzzCjtmczbpZP0x4zJaKNz7wyPWaRl
	OjNyQl/MxkjTufBnAVMzu6HI+7Src/lTGz0mKieDiFfxNUklJyM6RM8usTIBYg9N
	I2EeGMa3Fc0Dm3qDxFE720e8kjr4OpXzgdQ3XyuNxoq/EsphmpH0d/VcwOg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d15s08wqv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 18:00:33 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2aeb90532f6so11448665ad.0
        for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 11:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774029632; x=1774634432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/xBLL0+oVT0QjHqlpwUUCNWTBSkH/14pqegZTnvrk4s=;
        b=U7n+UEjaFiCAs83F390KutDMEuRJhyz6ZlE68OzsWysxfR4GY2O9g5nP2srAUhxOVo
         tIN1L5ycEpVkFWjWiJNViHgEZzPz5RW+P4chC5cpySJhMGmvwniuvYA6XrzOFamFhl5u
         t8xixUPQ+GydpCGA4c7IWJ90eT3tKWZaxT8lADg15lxb4FISV78/tmIc79gjpRWMGu0T
         RIyLmHp+ssFzVy1jvBZkE/Q96GQSoD3gC3wplgnU0iTkxNjtEoL5DfdktIvtVTGx8as2
         TuEu2NOcMyhR/cL5LuUYPU7QyPuzQyPrBnSNWTEM0KJ3xPo1QJISXPXqJodwbyogMazM
         ZmXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774029632; x=1774634432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/xBLL0+oVT0QjHqlpwUUCNWTBSkH/14pqegZTnvrk4s=;
        b=GgaAqlf2jaSBTrR4oaBSasKbht/SpYwTECBwvcnfUlyL7S6tLA0nEuH5rO6xEt790C
         QA0Ot9cYESgdgQ5KpHjTfEVKUD5pLpGdBbdAGl6Lbx1mQ62wx6iToDxDGdGUUff3t1jf
         FxJolnEhVl2LK652UzxLWTUsK4y7lzK0802jqoYRjmWNQLCBQo0lLiGMJEmf8ARhwEnk
         U9Z88IAAmx6UV1OYAfHRZc/tnjuZCbvQF1vUnirTJCawgBW3MXBjREbeCF/3pj+iHxOX
         z34LPcgHJ5QbxkmHWIvvUMMm/Asf/kSfmU9tCdObYmgXgECkZ/j5Pq6qpT99RgQGRxOo
         fUNQ==
X-Gm-Message-State: AOJu0YyIG70/FU7nAwYDwxy6GBFqmkX2bNOAOD2Rwl842J2YrtWX1QuG
	YBDa1hAaJVaxVcts9Js4CU7ccnMc5xbChP83nXcjMCn6BQ8bnmj9dy/VxeGsxwviayDKC7IMsRg
	HVIT8QK+wKBcBokpDteY/KjnVXJPvlQYd7bghMH6LHy4gfG+GZ8PjovMMg1qJ4mNxZceDpuPSjH
	Hp
X-Gm-Gg: ATEYQzzmgX6ghQeLjbR7iRlmse6ebqTyc/usVn77/CfGpdq/4gTBvNGXwtDTLEa2nFj
	BiDFtkqMibQm4uiI7fYd/lXI/eCj/Th3G5jEIn7mplYNocJ1X72QOYG2sNKwx7GHZf4FikCHoaC
	/D/CeWgHdWqsX2HbRckX8zwt3IdxfDyn05AaCdhjJMHoIEJ8RH2SNh2tdEOsi9V1MhLIXFj36zN
	2qxtsiOgmJPPQS47l+4bPoYBHvwoo4+g5yfSb8SiamFHyDY61xZ75sI1XMwlxMGVVRGwdewWNET
	HA9zoZxvMMStRAEt2Vxl7zJZndTD9FWF6IAFwvIQUK7RldgOgOgr6N5AMMPx06WgFnE4Dg9zrfI
	A4fIReX7JqD44fghBY61b73lmxWavBgYML4z183j06tPBjZf7/0I0oCM=
X-Received: by 2002:a17:902:cece:b0:2b0:69bf:a3df with SMTP id d9443c01a7336-2b0827a4fd6mr36540125ad.27.1774029632203;
        Fri, 20 Mar 2026 11:00:32 -0700 (PDT)
X-Received: by 2002:a17:902:cece:b0:2b0:69bf:a3df with SMTP id d9443c01a7336-2b0827a4fd6mr36539855ad.27.1774029631746;
        Fri, 20 Mar 2026 11:00:31 -0700 (PDT)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083529e8asm29926225ad.20.2026.03.20.11.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 11:00:31 -0700 (PDT)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
Subject: [PATCH wireless-next v4 01/14] wifi: cfg80211: restrict LMR feedback check to TB and non-TB ranging
Date: Fri, 20 Mar 2026 23:29:25 +0530
Message-Id: <20260320175938.2547288-2-peddolla.reddy@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260320175938.2547288-1-peddolla.reddy@oss.qualcomm.com>
References: <20260320175938.2547288-1-peddolla.reddy@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: s-zOL22AfE4J_2RuemRGnCJv493gak63
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDE0NiBTYWx0ZWRfX3dbBILzW+uh5
 tjCxmgyaca9qMMfmXGsmWJo4YJTASLFUk/laZJiHtIoM7w7Q7JuEbFqLFUvEcHh7xG9u6ZsGexf
 xC8KKuZyuLJZUh9S85zzHf2gM/LQ6WPQb/6tFMLVezEORbnh3tPpVooEOgF9aljIV1kbAfFD+pO
 1oD2aOG0Rm1IrcWAzzb6rj0cQXRkNkXyDt/kHG/EVz0sSB38/jxjthhM7uNyl2El6+S3uKTs7/+
 TNa8dUsYb/Df9Wp6PREkyFlzugw2a4mS2IXWGfU+hq6x+2hDO4Lm/VaLZEerLoTj/TqllZilALv
 DSpcqG0Ir7fe1l4Uw6jft+xs7p1/o4XXOY96gz6oCQ1297wiaBGq0zXhwWy8iE4HUWiUNY2FsBI
 nHAaFv//45NcDMZgk/02sjeFEmVhYHkW8YUKRzo8VvDnqa1o7q8P7Zr5MX3gMqIaXuliaqLnN3J
 DrFUCgDYSyVznJCTiLg==
X-Proofpoint-GUID: s-zOL22AfE4J_2RuemRGnCJv493gak63
X-Authority-Analysis: v=2.4 cv=KORXzVFo c=1 sm=1 tr=0 ts=69bd8b41 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=8X9NZW4galhvjpjBZbgA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603200146
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33597-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: F2D882DF16C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The lmr_feedback field is only applicable to TB and non-TB ranging.
Currently, pmsr_parse_ftm() enforces lmr_feedback for all RSTA
requests, incorrectly rejecting valid EDCA-based RSTA requests.

Fix this by limiting the lmr_feedback requirement to TB and non-TB
ranging only.

Fixes: 853800c746d3 ("wifi: nl80211/cfg80211: support operating as RSTA in PMSR FTM request")
Co-developed-by: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
Signed-off-by: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
Signed-off-by: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
---
 net/wireless/pmsr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index 556f30f5d60a..936c16d80cc9 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -195,7 +195,9 @@ static int pmsr_parse_ftm(struct cfg80211_registered_device *rdev,
 		return -EOPNOTSUPP;
 	}
 
-	if (out->ftm.rsta && !out->ftm.lmr_feedback) {
+	if (out->ftm.rsta &&
+	    (out->ftm.non_trigger_based || out->ftm.trigger_based) &&
+	    !out->ftm.lmr_feedback) {
 		NL_SET_ERR_MSG_ATTR(info->extack,
 				    tb[NL80211_PMSR_FTM_REQ_ATTR_RSTA],
 				    "FTM: RSTA set without LMR feedback");
-- 
2.34.1


