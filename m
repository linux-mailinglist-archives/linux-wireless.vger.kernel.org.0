Return-Path: <linux-wireless+bounces-32449-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMlyOavcp2lnkgAAu9opvQ
	(envelope-from <linux-wireless+bounces-32449-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 08:18:03 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F9D1FB7F2
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 08:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F133A3005140
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Mar 2026 07:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E907C34D937;
	Wed,  4 Mar 2026 07:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BrxdaTNE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aB696bP8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA1536BCF4
	for <linux-wireless@vger.kernel.org>; Wed,  4 Mar 2026 07:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772608602; cv=none; b=cBVg8shKKBtr0+GWtCXbyakQFRlLfITncvUQd/B45tW++/ByYUMZVIeuFXD1lnjmST7hW6UVeKp8d75PWQcQ7yGe6OKaBe3zabuwEEbC5Of4e/5PkpTj2m2zDclLnaSRmTQ9freX6E87pSJLTxDX+WM3YIFgpkzsdSqQkqbn1xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772608602; c=relaxed/simple;
	bh=bkMVimYwRwkG0L1t3EUBSLVLW7l6/kYFxDwC+iHguzs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uJPqnMlChA8DJMKvp47GS+bHCam42CTQIPG21mG/FGYnVIl7oUJeQMnhxTdQf3OcltpjXL3MDXZgdUvdORWQl3y407Ngz30S+jgQNjIAUzvd3Sz/CT/CP8eLd+qH9FcRavbNxgDeDOOHOrYR4cqY0PqZsWkG1hr5eG3wV+MMgrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BrxdaTNE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aB696bP8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6245SU2P1677945
	for <linux-wireless@vger.kernel.org>; Wed, 4 Mar 2026 07:16:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=v0kbXWy5iqj
	kDmmAiRcg26mi+iX5FbWl9/qw2zMK/ZQ=; b=BrxdaTNE8jZ0iauPmn+U9/j35C1
	EZynp0ys3jzFObuZjJPYrBbSfy45HUlLBfQvXbnIBAH+goBZrChC1x7x2OC5m5EA
	02sKzl7sgbFiWs1U4z56q8A4bW4vFSBufH1bs6j7o8djnGrh8ikuPFxKmPSj4gOK
	rKUlo0ht6Z9wWUZRL1orP2tMhtacV2FWqwaCmTNfJs/otHpRu2S3m6j41O1LF+dR
	XvjA86Gh1g8Zg+m364D+2Nvd1lAFuS4Dtq/9v/LslIgn0MirHV61syXhsD4vYv1F
	yC1vwDPiV+meqU8V7WORNCy7e/WefwSix1Jiaw2CGqcV33ymJAcRG5gBCMQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cp73h9rug-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 04 Mar 2026 07:16:40 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ae48a21d12so23625035ad.1
        for <linux-wireless@vger.kernel.org>; Tue, 03 Mar 2026 23:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772608599; x=1773213399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v0kbXWy5iqjkDmmAiRcg26mi+iX5FbWl9/qw2zMK/ZQ=;
        b=aB696bP8GOrvSaGFcWCdAQPsR82VDRwYj5ew8wKRog11A6AoFDn2C68Rd4D8NaYWUH
         hs66dyKOmZBmhvZpcXkrhTWD45DZb9jDLIjGJz2B2iAoKLC/FHFWCjNsjH7pH2GVFsU+
         D16y1oOutvM5AHo/qehENqG/+vFrFHZ3mEgN0hUukq3Z1K6zhqYQlSjdY6/nruXBeVy/
         EfKZEs02y4f76g8JLnAh46vT7mPZBZZDtMzslEGVJ+BlTYESohbtaXg0ANjpWql2/NCL
         bBrhCeJqwIbJyt/+0CyCmclAQGsY/BH3DgrGcdbkxbaUvtpq0IcV9HtLiZ5P5o9ZivjX
         NK/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772608599; x=1773213399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v0kbXWy5iqjkDmmAiRcg26mi+iX5FbWl9/qw2zMK/ZQ=;
        b=PpQKyTFV/Xsr0jVLmuhQIKf42Q86i/Ar/TPmfG8tGEIXAn7pxP4ySUdOffHd8zGOqK
         fQzxGBSyg2crtUP6X1Rc5O3FtcsX4muh2mZXl448Xxaw/7N+6eee02A9N1SZcXkISlF/
         Yx03eRst1zHTDDlJgHRDX8kMd6woGEgW+wppm52ZcglySkeGKc67oAzWOpaNHSH1e87U
         U1YVizeZJ/aCIF2DZOZXboMT5sHIsxEh39RsBnyOxIja3l1h/k+NH1HOh/WGa1echEFK
         OOEWBOxpC5my2Yi37Y/ATBGgDhNs+0XlyIi6MxVVt/fZtMw1vNot/fb4oW1R8vrlIMdl
         +k+g==
X-Gm-Message-State: AOJu0Yx4+ZIGUStigkMfExdvj+UbiatYQLxnbSRSQDAqrPo6G03/16Rz
	+sE1Ut0GVQhh8Vjnwgg3IqD76fAwWVv70CPLBX1xsgTgUc1vdJY900iwdbaDtEaTDrO9DL58nSa
	4MuQ6a4HjDRV7HISrhUHywdREPsHPrSgLOZ8uzAZ5ayc8CzULTQKSlBgBE5Hg0DioKlBr
X-Gm-Gg: ATEYQzwuJPA5VbG7VA2LGKaDSzeRA38uRMqakjk7KU2JNSIGIKSnbQGALmapxc/rqrZ
	QsLeyMTWqbso1Qp+fEzyCopupdNnwRH+lY83ogIgsQ7OesrQ5IOHjd+ji0xWb9LXBx4cWQISYEX
	A9d2E2T7BSeHmDCIIrXyIShvrwjgOMVP7ZMziF0/a3B92cxM7QGTiZROQ1YU5hqmM3p7OE/7l+M
	8WJf5Wt3llky1dsNrbk9n6KsBT+A9czUHnOexQB36b/NXf1e609WT1u475fx2HxCIqLrbC/xuzA
	xv36xil99NySZYfoGpDRWwb0NFhMq8xc9CUiwMEYk5UVFaquOdh+AMHpvA9gl0kT6GP+sBNsws/
	FR0TiAO9Qmo8Czaf4cWS1SeTq5AZnQnbw5ieyo1mnL67aHVuI1iyL65Q=
X-Received: by 2002:a17:903:8c5:b0:2aa:daf7:84f6 with SMTP id d9443c01a7336-2ae6abdd127mr11909285ad.55.1772608599356;
        Tue, 03 Mar 2026 23:16:39 -0800 (PST)
X-Received: by 2002:a17:903:8c5:b0:2aa:daf7:84f6 with SMTP id d9443c01a7336-2ae6abdd127mr11909075ad.55.1772608598888;
        Tue, 03 Mar 2026 23:16:38 -0800 (PST)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7378125320sm994121a12.20.2026.03.03.23.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 23:16:38 -0800 (PST)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
Subject: [PATCH wireless-next v2 13/16] wifi: cfg80211: add result reporting control for PD requests
Date: Wed,  4 Mar 2026 12:45:35 +0530
Message-Id: <20260304071538.3833062-14-peddolla.reddy@oss.qualcomm.com>
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
X-Proofpoint-GUID: N8aPXxKa1J4aA-p6W2_WLl476IYRNiJ8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDA1OCBTYWx0ZWRfX6DVnMPVDvBoQ
 YwO9ft97CByyy/p/lsxsI0tah4ztyhr8J/kPMQytriBfXxJ64Qfv9tnhKVbLCe1CwFqHcctNkOm
 JFj1+8aX3b4FAup9NnF7JbTqQicxBb7Abf21NzcITTPSyDXVRNh0xhqkFaFmh386tAeSjhVqKbj
 10b/YYqnP9UgpoN9I0wa4cwcI/3E7FmXWpnC6a6XMK1F/TrLlOqnWoYGGqEQp3lbBaYNHWPPTtU
 xM2ShGuqa6rWLy4KJ9CWLdyBtNPTsqxwZaeejyiZT4IS21n6I4ragmZcIltdFp3QecLTYR9frSe
 yMgxjl13iYQWEUZ5CklImS5H2pRGmaU91YL3BfsseMfZ+jFjVegZ3D1dwi0BQbn5a8mj0kB0cwZ
 C+qFGRZiPoObAVEHux7Hz892kQ0ew4oJWgOEV12b8QxQ+gaqGWbCXBEJ3tWhUlUFrdhCzUQAVPo
 t0isC2LLDnyBZ+89xdw==
X-Proofpoint-ORIG-GUID: N8aPXxKa1J4aA-p6W2_WLl476IYRNiJ8
X-Authority-Analysis: v=2.4 cv=BpWQAIX5 c=1 sm=1 tr=0 ts=69a7dc58 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=RfmHTrBQH4soxj86TAEA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_02,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603040058
X-Rspamd-Queue-Id: 86F9D1FB7F2
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
	TAGGED_FROM(0.00)[bounces-32449-lists,linux-wireless=lfdr.de];
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

Proximity detection applications may not need detailed ranging
measurements for every request, yet currently receive all results
causing unnecessary data transfer, host wakeups, and processing
overhead. Currently, there is no mechanism for applications to
suppress result reporting when only proximity detection is needed.

Introduce optional result suppression control that drivers can use
to implement selective result reporting. Add a flag allowing
applications to disable ranging reports when only proximity detection
is needed, enabling drivers to reduce unnecessary data transfer and
host wakeups. This flag cannot be combined with range report or LMR
feedback requests in RSTA mode as these require result reporting.

Signed-off-by: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
---
 include/net/cfg80211.h       |  8 +++++++-
 include/uapi/linux/nl80211.h |  7 +++++++
 net/wireless/nl80211.c       |  1 +
 net/wireless/pmsr.c          | 18 ++++++++++++++++++
 4 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index e398a594082a..8dc2ccafb88b 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4448,6 +4448,11 @@ struct cfg80211_pmsr_result {
  *	basis in this case.
  * @range_report: negotiate for FTM range report. Only valid for
  *	EDCA based ranging.
+ * @pd_suppress_range_results: flag to suppress ranging results for PD
+ *	requests. When set, ranging measurements are performed but results
+ *	are not reported to userspace, regardless of ranging role or type.
+ *	Only valid when @pd_request is set. Cannot be used with @range_report
+ *	or @lmr_feedback as these require result reporting.
  *
  * See also nl80211 for the respective attribute documentation.
  */
@@ -4474,7 +4479,8 @@ struct cfg80211_pmsr_ftm_request_peer {
 	u32 measurements_per_aw;
 	u64 ingress_distancemm;
 	u64 egress_distancemm;
-	u8 range_report:1;
+	u8 range_report:1,
+	   pd_suppress_range_results:1;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index a70dcb2aa111..cafa73280758 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -8082,6 +8082,12 @@ enum nl80211_peer_measurement_ftm_capa {
  *	(units mm, u64)
  * @NL80211_PMSR_FTM_REQ_ATTR_RANGE_REPORT: Negotiate Range report in case of
  *	EDCA based ranging (flag).
+ * @NL80211_PMSR_FTM_REQ_ATTR_PD_SUPPRESS_RESULTS: Flag to suppress ranging
+ *	results for PD requests. When set, ranging measurements are performed
+ *	but results are not reported to userspace, regardless of ranging role
+ *	or type. Only valid when %NL80211_PMSR_PEER_ATTR_PD_REQUEST is set.
+ *	Cannot be used with %NL80211_PMSR_FTM_REQ_ATTR_RANGE_REPORT or
+ *	%NL80211_PMSR_FTM_REQ_ATTR_LMR_FEEDBACK as these require result reporting.
  *
  * @NUM_NL80211_PMSR_FTM_REQ_ATTR: internal
  * @NL80211_PMSR_FTM_REQ_ATTR_MAX: highest attribute number
@@ -8112,6 +8118,7 @@ enum nl80211_peer_measurement_ftm_req {
 	NL80211_PMSR_FTM_REQ_ATTR_INGRESS,
 	NL80211_PMSR_FTM_REQ_ATTR_EGRESS,
 	NL80211_PMSR_FTM_REQ_ATTR_RANGE_REPORT,
+	NL80211_PMSR_FTM_REQ_ATTR_PD_SUPPRESS_RESULTS,
 
 	/* keep last */
 	NUM_NL80211_PMSR_FTM_REQ_ATTR,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index ea46c5e215ba..02e7c9f9b12f 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -384,6 +384,7 @@ nl80211_pmsr_ftm_req_attr_policy[NL80211_PMSR_FTM_REQ_ATTR_MAX + 1] = {
 	[NL80211_PMSR_FTM_REQ_ATTR_INGRESS] = { .type = NLA_U64 },
 	[NL80211_PMSR_FTM_REQ_ATTR_EGRESS] = { .type = NLA_U64 },
 	[NL80211_PMSR_FTM_REQ_ATTR_RANGE_REPORT] = { .type = NLA_FLAG },
+	[NL80211_PMSR_FTM_REQ_ATTR_PD_SUPPRESS_RESULTS] = { .type = NLA_FLAG },
 };
 
 static const struct nla_policy
diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index 2b3d7d260e35..2897876e45b2 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -268,6 +268,24 @@ static int pmsr_parse_ftm(struct cfg80211_registered_device *rdev,
 		return -EINVAL;
 	}
 
+	out->ftm.pd_suppress_range_results =
+		nla_get_flag(tb[NL80211_PMSR_FTM_REQ_ATTR_PD_SUPPRESS_RESULTS]);
+
+	if (!out->pd_request && out->ftm.pd_suppress_range_results) {
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    tb[NL80211_PMSR_FTM_REQ_ATTR_PD_SUPPRESS_RESULTS],
+				    "FTM: suppress range result flag only valid for PD requests");
+		return -EINVAL;
+	}
+
+	if (out->ftm.pd_suppress_range_results && out->ftm.rsta &&
+	    (out->ftm.range_report || out->ftm.lmr_feedback)) {
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    tb[NL80211_PMSR_FTM_REQ_ATTR_PD_SUPPRESS_RESULTS],
+				    "FTM: cannot report with suppressed results");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
-- 
2.34.1


