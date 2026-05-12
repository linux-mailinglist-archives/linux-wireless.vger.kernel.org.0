Return-Path: <linux-wireless+bounces-36281-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNdCI3WPAmryuQEAu9opvQ
	(envelope-from <linux-wireless+bounces-36281-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 04:24:53 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A2B518ECF
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 04:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAF343044225
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 02:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843B5364032;
	Tue, 12 May 2026 02:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ar/aVTTL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CwC13A9U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DEA35F5E1
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 02:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778552645; cv=none; b=izk53Jto+SDwk8IgfJ2IRH+yRt8msO6rQThXasNM7SlALNNmGiUDF0eW5tutQ8+GSlPDOGbf5a2Bc/4HzunH3AHQ5Rnk9KhI+m4WthqcPEl3EGRPSDgYbLXfPTb8f2P61pf8vxAcLgnL05hd19VkICBSQC768ko69qMpd8S1Dmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778552645; c=relaxed/simple;
	bh=ShPdVghUhjVpekgUmJLaLvAYO0epA2adRUBRf/f4EyA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eM2Xhas43+9PLPgn4mVT0euPkj4CiirZFSO1Det4rMfmLPRSFU7CWJk2kpJMK9L9/QJmx3CUl2JH6euzlhJoea3Br9TrTQTH0riX11phuBkfOSnW0PWq5gHNwpffjNzFmgI1oyMSSYvTtl+0vkUTnpRV/+Mtlx0Wxa3KGxXSuD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ar/aVTTL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CwC13A9U; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64BK6aqB2518218
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 02:24:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=036Lv6cF0PV
	z0F6Xudk21JbDMRzEenikh7GX3NZQ5lo=; b=Ar/aVTTLNkaXYOShCjKifxRPeaf
	5ePAtsIXGA6Z24CRsxRHW926YDFHDPRyH0b435DXDPaJc+TjmJ6qGEFCvI4D4Jqu
	usqCNkcqhLEkF74JZR4cXVd/7Ng+FaEOSwkuVmpKsJSq1X3TqNTIOLsYdsLWHayY
	3qjbaovyhAdWISRSj0wbnyn/llAN/FycRGCG2LtOTXYVEUNaCW2wHsZYTjXvJryf
	xjItF9JkqPYWoFB8UhCYgXH7JD/3qXud3SY8IIXr3dbTKIk5LcGmPyFMXwZRhdpe
	vbWRRAwy4cIe3uozpT2BDA6M8GrtpUWt8+c7f4z2hHuCEQMf7ehkWXd4vVA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nv1h2vj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 02:24:03 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82f7bec24fdso2909844b3a.2
        for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 19:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778552642; x=1779157442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=036Lv6cF0PVz0F6Xudk21JbDMRzEenikh7GX3NZQ5lo=;
        b=CwC13A9Ur5xNaicr4VvHuYjedM8J/gK6CBc2qhaF5NfdWYJKFED/UBJ1SnGoDtLe+j
         KdU3agNH/NwH26My4xnuBwr/NAyFimB3NGmYbR4xZyOdcKhGR+fmojpinwpNYJaJEeML
         7iAXSUx+1BHhRYWwsRDynFImnAbS3/OgfmpFQtc+mSpCUrz9E3cRhtWJ2f0KJZJ/8jGR
         7Zn8OCBThn/LwV49OiWXjjCFG8WzOe3FcwlJr8Ht2cv08T+q50/ssIS7DV7sK124n56m
         STUVm15TJKjpA0VnOOnQcVgnqipuM7gkbs8DtC0wan397vQEVYyG83deoYkljm/pFQxn
         /1VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778552642; x=1779157442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=036Lv6cF0PVz0F6Xudk21JbDMRzEenikh7GX3NZQ5lo=;
        b=L9Y9s3EDLnhtK29B+FdWyTGtyLlx7M/ilHrnrXfx24cDoV0NhXYSWKmlTF60strqY9
         Fj1oYQr38vrUDCoaY0p9ACQE3MhWvqbkhEz8Ewu0g82c9Pq/L9mOuNs8VYe997NM3qfC
         1xHFsJhjiu0IiXP2tJwrZ1whBXV0/Gz15HeWjFbf1NYbHZazdoGzgcKwnIL0Dg8Swt7l
         LVKcmugm7VQVlexTQOYIsv7VNIA1/VZOR53d6q6SIJM6X+S7AidP4R+V8zNM4PRFjhcQ
         UKXpmx3vyUXg3MuWp9FK18dWLLRGMYlsX29zdnC4n2X32+2Cip/nq1y1v+jRmlU7BSKn
         5phQ==
X-Forwarded-Encrypted: i=1; AFNElJ/wFWFi0zPBOb88amyoRr7O8wLt0VX2ku1XRUVfw+/hr0Z+LpxNxI2cRrTlpeFtRB+Te50umQVwyJu8kbGRCQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzuocIUvFZZlVqyxtiBhRNbhm++lTgv+CnLAnx87tfKeFzbW/7g
	gq8YkYByGWi3EwNhfzHf92Uelyf1zyNoQo2QLeqJQXXz/h9fbOM3cMNpgdgg0K8mUN8Cxz6d/IL
	LvKdE608SJ5UnI1zgz2jWJpG9EXhktfg8c/pyd9xDTadLAT8lQ8eLnQvZg4xuoQ4rk1Xh5A==
X-Gm-Gg: Acq92OGwmJSo/4l22IZ9dhtE/2f4NoMAITITlcD7jHZhFchKFA/l/pbyaCy4VdKL0y5
	CDYtAE7vpbj5H3NSjx4IGL0VuCO+83ucq74BTXN8J9V29nuJGZtGzQ23gqP3+P0YoJF+72xecTG
	3037ZU/DsZWu+0Ag1qQJrGkDMgP7DCVKsemQvPps+z/iSO7GRdakpFBTeXr9CKsx2mOief9HhsP
	Cdjp3QKOKKMScSwX6EPoOQN1c6/4WeSDrBJT9I4W2AprAlSm/0LbeSgdOLL4T+S5OLIDT8j5yWP
	i7IEvKrgERwdT04ZSw2ljCdKnSR8y1qdwsVTauVm3neGkRiRAjXYm0kG3cRIYbc71rb/h5jo3Tf
	RrCzn7OKB7ONcHdORbZL6iZsfQdzuepbKpefeFh3myjPzDuBGacCk2JaO8phkzeRM5Q57pI1afA
	rmUxlO
X-Received: by 2002:a05:6a00:1bc9:b0:82c:d7c4:4c5c with SMTP id d2e1a72fcca58-83a5bae02b6mr24671155b3a.20.1778552642083;
        Mon, 11 May 2026 19:24:02 -0700 (PDT)
X-Received: by 2002:a05:6a00:1bc9:b0:82c:d7c4:4c5c with SMTP id d2e1a72fcca58-83a5bae02b6mr24671129b3a.20.1778552641599;
        Mon, 11 May 2026 19:24:01 -0700 (PDT)
Received: from Z2-SFF-G9-MQ.ap.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83967dbcf16sm25199256b3a.40.2026.05.11.19.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 19:24:01 -0700 (PDT)
From: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
To: jjohnson@kernel.org
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Subject: [PATCH ath-next 2/2] wifi: ath11k: add MSDU length validation for TKIP MIC error
Date: Tue, 12 May 2026 10:23:51 +0800
Message-Id: <20260512022351.2033155-3-miaoqing.pan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260512022351.2033155-1-miaoqing.pan@oss.qualcomm.com>
References: <20260512022351.2033155-1-miaoqing.pan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: qQqw6cHGTwi-OGiHYdlZbVNoPV4ZqX42
X-Proofpoint-ORIG-GUID: qQqw6cHGTwi-OGiHYdlZbVNoPV4ZqX42
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDAyMCBTYWx0ZWRfX7HRYGzZDnhhB
 Uf/AAOplFKZ6QYM1cVuW2XPQt7G/JmGLK3tiwuJ6xOirL7HVQKOY8g6yS8H4r5PiNNIL5QsAl9y
 eNHBxo0dxYXdlMZ23lckXKEbfsuqEj4u0HCGJDwxRB9lkw4z17yPc16xHPxwTC9wxjlkUArmPfF
 R4CCiy9b8h8A5uWg0azsOOSeKG1tXZiW/4J6hW5tPik4giBFonJEsB56eOiUisyDr3NdXdfTUW5
 noeWZoE7+U5WPCxgfjeIU3opAnQLqP5AGbUrjVMw3xum7xPUn1emKEikJJ2zLkfTa6yxZrWQKfL
 Y+txep8If/RSOjCQUdaljvLvcrhLvVCvJeYT5LUeikdpojapmo7vAUbn/gjZo4//c5kesvTJHfX
 I+SjgLSZaPKfSj+UhRXOwDEhQsSPYgWHnydZJjdSinCX7Xohyhdi0FmRb7ufuH2t00LNJUqn/bv
 yFBwYyLVmyIiL5yho1Q==
X-Authority-Analysis: v=2.4 cv=c6ebhx9l c=1 sm=1 tr=0 ts=6a028f43 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=7QbXSr-hkXkeXhD5LnUA:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120020
X-Rspamd-Queue-Id: E0A2B518ECF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36281-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miaoqing.pan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

In the WBM error path, while processing TKIP MIC errors, MSDU length
is fetched from the hal_rx_desc's msdu_end. This MSDU length is
directly passed to skb_put() without validation. In stress test
scenarios, the WBM error ring may receive invalid descriptors, which
could lead to an invalid MSDU length.

To fix this, add a check to drop the skb when the calculated MSDU
length is greater than the skb size.

This is adapted from the discussion/patch of the ath12k driver [1].

Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-04685-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1

Link: https://lore.kernel.org/linux-wireless/20250416021903.3178962-1-nithyanantham.paramasivam@oss.qualcomm.com/ # [1]
Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index fbe2061a544d..9c31bb7efcc8 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -4050,6 +4050,15 @@ static bool ath11k_dp_rx_h_tkip_mic_err(struct ath11k *ar, struct sk_buff *msdu,
 
 	l3pad_bytes = ath11k_dp_rx_h_msdu_end_l3pad(ar->ab, desc);
 	msdu_len = ath11k_dp_rx_h_msdu_start_msdu_len(ar->ab, desc);
+
+	if (unlikely(hal_rx_desc_sz + l3pad_bytes + msdu_len > DP_RX_BUFFER_SIZE)) {
+		ath11k_dbg(ab, ATH11K_DBG_DATA,
+			   "invalid msdu len in tkip mic err %u\n", msdu_len);
+		ath11k_dbg_dump(ab, ATH11K_DBG_DATA, NULL, "", desc,
+				sizeof(*desc));
+		return true;
+	}
+
 	skb_put(msdu, hal_rx_desc_sz + l3pad_bytes + msdu_len);
 	skb_pull(msdu, hal_rx_desc_sz + l3pad_bytes);
 
-- 
2.34.1


