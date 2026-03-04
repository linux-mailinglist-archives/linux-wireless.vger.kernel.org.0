Return-Path: <linux-wireless+bounces-32437-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YA84HGPcp2lnkgAAu9opvQ
	(envelope-from <linux-wireless+bounces-32437-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 08:16:51 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E64121FB788
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 08:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D805E302DE4C
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Mar 2026 07:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8483101A0;
	Wed,  4 Mar 2026 07:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ht/QE8mc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NaFlcctf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A107234D398
	for <linux-wireless@vger.kernel.org>; Wed,  4 Mar 2026 07:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772608576; cv=none; b=lfed/yVBgayfnWTQL4mtv0yM0QckF3Grsk5KFluVdfGGoACZAX9/7l+dRKltlfC3uDJ7V/nCEFYJy9kBleJDwuTgOHQpRYEFTLJrRs2DOyh4khodN9pUA2KItamQajIDCXhFptzhVLp+gtqw3WxU1vUSzH7k4wAtgc1Ip/u2oAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772608576; c=relaxed/simple;
	bh=b1GblDm19067Sr4/CwERGPzydCktlyC29q6Y1AJ004o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jTcSgj/UlgjiMTDXW9CKy45eYbs808KPYlc2tujJj34A2/bfLB20zUe2noFF8l1aDGT8HbaUZdynO6hMSzljqEfhdTLPkbxfys+o4JfPbYBPh/T+uChwTk6uurxBEIYoqT4JJ69Zpc2R1aWLPLk0Uiaw6AdfgwmLH7JG0KC0pD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ht/QE8mc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NaFlcctf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6245SdIs957613
	for <linux-wireless@vger.kernel.org>; Wed, 4 Mar 2026 07:16:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=K9A+zIDsEkq
	lAjsla7AKRgzmOqqxZ5Vpm3vCcX2ep/0=; b=ht/QE8mcBNrSPqFKcdbI9z5uFTp
	fyGEFoKzACigbwGTrrBPiGvgZDjBSINbKdLHQ4IZI/egi0wkzJeuta308KgRuUSC
	evOXpcMNORcCWwrewHtZY/l6n4/1xY2ieUy1wVL6YenxJaHc4n45SPt8j+liRzDN
	U/4gSO8eixFYWU0mym8r1uwkAawXj7AS2Gz68v4PrtjsaIlx1ThTiMGcDCcJWY37
	fcrtheXTtyA/vMaHzzHDC/0DqyBmRulB6PfsXhE+Wdcm56twlGXN3fCjTU7RoRmG
	sEGD9xKX2nHYuCQzJQB03amG+hBttB8wDoue4LD/LhYokNdezT/dHyKv7ZQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cp6qg9ta3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 04 Mar 2026 07:16:14 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-354490889b6so23078798a91.3
        for <linux-wireless@vger.kernel.org>; Tue, 03 Mar 2026 23:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772608574; x=1773213374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9A+zIDsEkqlAjsla7AKRgzmOqqxZ5Vpm3vCcX2ep/0=;
        b=NaFlcctfLrmOxqGGeVuiehK6a1HuNGVzGAhl3vao6LPvfAqEfcNUO7NrJjL04DaUeX
         pgNTYecqXoiu6SzvzRkfw6bQrvidaejQIQoHzXIGqjNoz/8mlFmQf1u2PPd4PwJyrn1N
         CJGcQR8Y7Xx6zms0jmQBCyy2npB0fdKznfYunfZ0PRwilflXRP4HmpeP3/NHU0dtnwdK
         0VOF4evo5Qmry8krO9/iKaIWmtyDqH3kHXv5gG1grM37CXBqjogYoKWvTG+1nTGszK9V
         mnaHuA0FjT48Y5FDpkBuXue8nGecv9hrfqxN5SpPxqeb/WKNqnDIOszDSUboydYmE2A/
         etyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772608574; x=1773213374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K9A+zIDsEkqlAjsla7AKRgzmOqqxZ5Vpm3vCcX2ep/0=;
        b=eZjZ/Bb2Dz2NtQJBJ+Ahtm89WqbEPCnDCAYsyBvytu3nO555l9TcXp7OaoDtA7+psz
         XYCC2dvDhubwTFL8lM8qp/pll8AWT3RClOCGoSDa0iirW1VvOqzokBiCnYHRZ2OVMWHF
         yRN9JQ9TYA/RcrWCgS/otCfoK6e2yNjZxqpKBzJ/bNcHbuDoHJz0PMfJAp7/P5HKpuln
         0ptI83Netml0Myi1ZbMQfyrf/RPDJ6V+4MAUIeVeNBbDuKhJ055pRVHB6Fe31HwxbRTF
         4gdkL0TlXHtmJLKEjrQe6L5CGREEwO72TVw0owF5WYy80XLGTwZjWqi9W2ByezTLoyI9
         HcnQ==
X-Gm-Message-State: AOJu0YwzrlJbchS9GO73mjdIrvffcHdABetr2LSlGGolC7596B80hq8p
	vVmDhu12wZZ56h9U+Uzm8IC3iGG5CjflCGm2/AxDNV36krc3oRx18lRCbJr5ebEogT2XiA98dSq
	s7Ue2186+DZ3UWhgThQEZPVgwM4OQHgDZ5RqM/XtiezbP0Mr0jRs+ulUvRVlOByJLSm2U9gB0QV
	wM
X-Gm-Gg: ATEYQzxpR9hk52EjwxzJui2vi4RcpiaRxAhZFe7fe5Q7eg2SEdZeKL7yvdjn8YFVKhv
	nLHMjODgFWMaEY+4GQnWx8B4Ten2hNrYEuG9ppzXckpI1CHf+OM0RldIhj4NkP/DOMv218gqib0
	ceMXI+tBkNCcyaWmXeep36tKj1jnLRqb0q7kqdncS1RKZZF/09/cxtpNHE9WbnNKiLi/wTvpupx
	DBXpPYV6+aZjft1XcVySWA1y1z0Tlrx8Hx4h5JtLyiADX1jk1XEO4YDy3J2deNQSTWIpbdRX5wY
	1nwacqwPzggcWJnpbZsrept7owVYtT2ub0IYD8RjLxeUxRuQfHIP020YGzRQineOd6i5J5p/XVy
	00v4XodTiZ6YxHUKA/bVBynwq0GCRBdff+DVHZqdyjAzZcMER/Cmak9A=
X-Received: by 2002:a17:90b:2c86:b0:356:2872:9c5d with SMTP id 98e67ed59e1d1-359a6a6648fmr1330455a91.24.1772608573510;
        Tue, 03 Mar 2026 23:16:13 -0800 (PST)
X-Received: by 2002:a17:90b:2c86:b0:356:2872:9c5d with SMTP id 98e67ed59e1d1-359a6a6648fmr1330410a91.24.1772608573017;
        Tue, 03 Mar 2026 23:16:13 -0800 (PST)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7378125320sm994121a12.20.2026.03.03.23.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 23:16:12 -0800 (PST)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
Subject: [PATCH wireless-next v2 01/16] wifi: cfg80211: Allow RSTA role without LMR request
Date: Wed,  4 Mar 2026 12:45:23 +0530
Message-Id: <20260304071538.3833062-2-peddolla.reddy@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260304071538.3833062-1-peddolla.reddy@oss.qualcomm.com>
References: <20260304071538.3833062-1-peddolla.reddy@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDA1OCBTYWx0ZWRfX2Awi7jflMnKg
 Nhxf7f4BEVnbQSssXu0KMWYV/bjoLQmZmrY0xhBaO+LvDcLTq0f+pxsPGWxp90I7dLMiF/H26Gh
 lsjX6TWQFEsDTHEA+TuNt1OMTVmwSJIkL9x8O+qCDmCII2PYX+kUma1bweOgkcqCuGSIkpfNzpx
 Y7KndVI/o9SLV24HoF2d/sObtr9Av/kRB3fqNYYOgsSfk4NgB0pW6+H3m1ZgH3hCEoUrlnCHrho
 eb0srKo4V2hhyYx/28zqhccaS/SG86UyBK39cwUgnWQR/dfKcjrLL5n5KOrXgpP8cHasHf5PhUV
 KyFq8CIVkVdtk8oLFNtvUUikpbjhHiwgV9Ef/Aqf8jh+Tru38lRv1+Kn0bcFxwpkuHziTYAGccD
 9jQzS/SHPkltcCD+bDtQROscfe7Gka8vWVEEfPlKoMiuSYDI2PWW5vjy50c+A+NeCLz7z0SF4Yi
 MMvoVbjhVvcjUt77BIw==
X-Authority-Analysis: v=2.4 cv=UJ3Q3Sfy c=1 sm=1 tr=0 ts=69a7dc3e cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=-tftlpCPBrNBlGCn5IIA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: l-1x9_pHox5fYvNyPWloKRaX3m1p9mIx
X-Proofpoint-GUID: l-1x9_pHox5fYvNyPWloKRaX3m1p9mIx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_02,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 spamscore=0
 adultscore=0 bulkscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040058
X-Rspamd-Queue-Id: E64121FB788
X-Rspamd-Server: lfdr
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
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32437-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Currently when enabling RSTA role in PMSR FTM requests,
pmsr_parse_ftm() mandates LMR feedback to be requested. This
prevents valid use cases where devices need to operate as RSTA
without waking the host for measurement reports.

Remove the check that enforces LMR feedback for RSTA role and
update the documentation to clarify that LMR feedback is optional,
though required if measurement results are needed.

This allows devices to act as RSTA for proximity detection without
unnecessary host wakeups while maintaining the option to receive
results when needed through LMR feedback.

Fixes: 853800c746d3 ("wifi: nl80211/cfg80211: support operating as RSTA in PMSR FTM request")
Signed-off-by: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
---
 include/net/cfg80211.h       | 5 +++--
 include/uapi/linux/nl80211.h | 5 ++---
 net/wireless/pmsr.c          | 7 -------
 3 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 8cd870ece351..a54300b6899a 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4363,8 +4363,9 @@ struct cfg80211_pmsr_result {
  *		 EDCA based ranging will be used.
  * @lmr_feedback: negotiate for I2R LMR feedback. Only valid if either
  *		 @trigger_based or @non_trigger_based is set.
- * @rsta: Operate as the RSTA in the measurement. Only valid if @lmr_feedback
- *	and either @trigger_based or @non_trigger_based is set.
+ * @rsta: Operate as the RSTA in the measurement. Only valid if either
+ *	@trigger_based or @non_trigger_based is set. Set @lmr_feedback
+ *	to receive measurement results in response.
  * @bss_color: the bss color of the responder. Optional. Set to zero to
  *	indicate the driver should set the BSS color. Only valid if
  *	@non_trigger_based or @trigger_based is set.
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 0b7a06c2b9f7..8e4f9192d8b7 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -7961,9 +7961,8 @@ enum nl80211_peer_measurement_ftm_capa {
  *	channel specified in %NL80211_PMSR_PEER_ATTR_CHAN until it receives the
  *	FTM request from the peer or the timeout specified by
  *	%NL80211_ATTR_TIMEOUT has expired.
- *	Only valid if %NL80211_PMSR_FTM_REQ_ATTR_LMR_FEEDBACK is set (so the
- *	RSTA will have the measurement results to report back in the FTM
- *	response).
+ *	Set %NL80211_PMSR_FTM_REQ_ATTR_LMR_FEEDBACK to ensure RSTA will have
+ *	the measurement results to report back in the FTM response.
  *
  * @NUM_NL80211_PMSR_FTM_REQ_ATTR: internal
  * @NL80211_PMSR_FTM_REQ_ATTR_MAX: highest attribute number
diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index 556f30f5d60a..b875b61c0b48 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -195,13 +195,6 @@ static int pmsr_parse_ftm(struct cfg80211_registered_device *rdev,
 		return -EOPNOTSUPP;
 	}
 
-	if (out->ftm.rsta && !out->ftm.lmr_feedback) {
-		NL_SET_ERR_MSG_ATTR(info->extack,
-				    tb[NL80211_PMSR_FTM_REQ_ATTR_RSTA],
-				    "FTM: RSTA set without LMR feedback");
-		return -EINVAL;
-	}
-
 	return 0;
 }
 
-- 
2.34.1


