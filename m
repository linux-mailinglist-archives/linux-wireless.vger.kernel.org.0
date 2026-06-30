Return-Path: <linux-wireless+bounces-38411-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id StBrGaA0RGoZqgoAu9opvQ
	(envelope-from <linux-wireless+bounces-38411-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 23:26:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FD86E822D
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 23:26:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=bdRlwRdX;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=Dfmw7n2J;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38411-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38411-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2854E303E239
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 21:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDC731E107;
	Tue, 30 Jun 2026 21:26:36 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA67E31BCAE
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 21:26:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782854796; cv=none; b=XW6P10GTwt3nMPKB4Av7MfPqjyM3JOS8fpCtDfP167QVw24n0E1PH2dYyT0t8QJBrDQZpy7Zlt9S+owmtmJ9nSbA1xd/vu2OJ7d5iwfliGI0KjzQ25+9/1734jLKBWL3tinGdb1vLGuXLOd++arUu+fR4AdTzIcrQPSJ8RR5yoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782854796; c=relaxed/simple;
	bh=1kb7fNjSbmdpOkTVmbA/5HDKdlREqTz7EjPNAq3ADHw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=L8lFvnwRz9/f1IgkYuOZ/4d3GgfTGaQDHV9MFnDQGGMIrodhW/rWQzzMjtTmsZtpDuKnxkb1F6FCn5wNgqxBhdXEZDq8EHCfYrWwY09FiCNlby3LjH4KkrbZ7hOX5QQRivgZIzlJZZOIOfZDiduU3CHEUNQVQrOxzyIWy1angFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bdRlwRdX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Dfmw7n2J; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UJDojh2960152
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 21:26:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MAzaYVsUkGuytF349XwCOUWCbbCHXOwSdhtsx4FTc7g=; b=bdRlwRdXpAA0aLOn
	8icodGVrfBxtIfQrwVoNJ22LiGastf2KoeNdlCpRrlxcK8f9IOY8LHSi9GKaMh2/
	Nv7WwaT8d7ZZ4uyqQHFxMJJx18W9SGBwJccvcEFWAmFoLC2tJM+geY1AWUPDDq2z
	0CjMT+C3MbIN4D0jwkdL6dW7Q3t1GIQpRVbABTUD69HcShmL+INSYzLk444gTGPT
	1ZawjTdNJNlGX/Fuq6YT5gMyAnbet5Un9uVwttISHqagvNUdXmUTTE4sJl2aleE4
	NPIjgnvDmmxJw/uXH5FwGNl2auhg0rdqysVo961TTRJhHBiYhi83PV1gN+uKzq6Y
	Df68Zw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4j91100k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 21:26:30 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30eec544cc2so262047eec.1
        for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 14:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782854790; x=1783459590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAzaYVsUkGuytF349XwCOUWCbbCHXOwSdhtsx4FTc7g=;
        b=Dfmw7n2JooIUh2sKdD/eVZ7fQxkFPJEB0Il7GoRsduEFy06Xo17+2lVOb86dPx7Urw
         BaK0BGfkuk3irnGlfG221nDydiTOKslV/9qruo0KRbl9fbZQ9KoOOeX5twEbwRhxF6Ss
         kIzcADKm5varF8Po7tcK+p0sx1N7isVMDp95v2vDhJkPyLxO+WIg9+6joS+GIkZJRRwr
         pge4fZKmu1Af6aXZDcv0+Ez6RI1z/lwF5RaCFgub87CBAKrdY/Nt7pPuzy9WNTRHStAi
         rjsYSMzOHw4JJ2E6lVrRAjq+whtLRNEbA+ieT2ERtPvPU1LBdQfuAWje8ujumwip9jNu
         eIUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782854790; x=1783459590;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MAzaYVsUkGuytF349XwCOUWCbbCHXOwSdhtsx4FTc7g=;
        b=qFSWI1r9Uqcy0dLYMk0Eej6aocR3h22/uN8UUwYqeeJAXjENqqaWQNCqulDTxoTw6l
         Tqhjgi6O52kdJJ/Ox/KAkxZFuFzXtGoh/L/TL/xdOxE52dc5L+kfQ+9GIQvyjgpZriKg
         QF6xLFTjjM+Cyadsgt3lxRjTD545vpLKW5n8FSbrK8ttl7rznS/mGuC6JfKTH8z3piIy
         FEanZj+DEhThCasPTdjPi/IcuK8axS+W49MUwASB27GLGbgkfbbw6t0pKjKJs5OhUkWV
         vcfqEm1yIudJw9qkmQ6bI3w6vEbvraopMRv704gT8WOwJncX4GrBzwgqKZOX6OtUciTJ
         ruog==
X-Gm-Message-State: AOJu0YxoAYycIVwtX6AtksRidMZ1ZaYtyGOT30rWmwEqUmNOJ2ex8D8a
	QAtyydhfLkEplbEnlCTCjAOwAuMCJrHa7j/DF/vf1ilz+WaYxEZwKb1uP07bMA+rtz7Zs1aPMN1
	uiUCFbD0skWxZv2x3s/Yxn8+JbsB0niSNz7TjHrr/AkKdGZxck/d1vO3YA6pwCrrF+dfZBLfcba
	pZjA==
X-Gm-Gg: AfdE7cnXSkUtnZE7CIWHEu2k1PtbLnldQYJsRuyCOBPKJTOHe4QTKfGJwO91hzHxf9k
	RZ+O4NcDt7Xiaqmp8MJczp2tVu91ZaVN/PioTWLQ/bM9Bkk+Q9S3Et73uqk6EyCSGNDUHBpTQb+
	ffQXBmpr+aJRwLxkxghkeN+WNaOvIWFadKzm0UsaxbuNhGz9mPn2V6uv/XqVD1zZ2Q14gfwha9i
	STiilojmDmjWodeToznvNMgno2rMv0HXFF7Y93LBQt0Ci0MIof/wHoUMPVYsIkb+O4Hc7Mkch3t
	97Uee9a2xUO69CwNubKwEoOGLFN/xjnQzhu5j94dAqWfv7uSg0tOQs58H5XSn2nx32a21Rh7b31
	R4J3KYHQ2CN8b/eyow85s91VHI2ht4ZMDJf6PdX/xpzpGaKZ3E1dAasRi1dO0X7qopw==
X-Received: by 2002:a05:693c:88c7:20b0:30c:9f31:b631 with SMTP id 5a478bee46e88-30ef09b97femr1230238eec.33.1782854790144;
        Tue, 30 Jun 2026 14:26:30 -0700 (PDT)
X-Received: by 2002:a05:693c:88c7:20b0:30c:9f31:b631 with SMTP id 5a478bee46e88-30ef09b97femr1230224eec.33.1782854789562;
        Tue, 30 Jun 2026 14:26:29 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee300b286sm11604046eec.12.2026.06.30.14.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 14:26:27 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20260604031551.4178754-1-aaradhana.sahu@oss.qualcomm.com>
References: <20260604031551.4178754-1-aaradhana.sahu@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: expand UserPD ID mask to
 support up to 8 PDs
Message-Id: <178285478779.1590147.7383564492377283183.b4-ty@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 14:26:27 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: oPcG9EyuAxfrhJOSiZTNpgnueOsE1_dr
X-Authority-Analysis: v=2.4 cv=ftfsol4f c=1 sm=1 tr=0 ts=6a443486 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=GeFKMj_w3zxWA0NedEQA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: oPcG9EyuAxfrhJOSiZTNpgnueOsE1_dr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIwOCBTYWx0ZWRfX/L9XNE4tywUc
 mEyTiYMVcCDIkoQxon9sUtjl3cUnf0F1dfSZ5hZo8dA2YXUhOnbNIaXqx8vNs52N5ol8r6pElV/
 AuvCeU0CV5jBegGsRZPTwEzxATTeVnxe6ZvFSYwoBEggn+LSylvG2yZWZ4c85eX4P+0c6yNdWX2
 dcq2JlvgoFK1srIGQErl76Nd6YoL/gGKdarXxFJPpF1SErsQjNYQAZ+zhYWStcTaY3Bp5qvQGgJ
 YXM9+nr1j5JH6TPoqcGZETS1vjUqdiwN9DvIl0+YbL9tIhZRMbfiEcbeiscSdt8fYIfiN4M45OG
 t5FtLPmZMNUbRJl07RZ0//YtTbKYyRcypr3ctMENhQ9uZUwSy1Vfvh6pSfR32tF/Cli3iNg7dP0
 nS6HkdlUE9dk1jKfsjupBVDv5Ooc1zV36LKjxjrMGHeyI6fL1H0CjSJO+OLtLU4udYMkvecFpfE
 OtxPaY9uZ0udgE4yG8Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIwOCBTYWx0ZWRfX5r7Xdbu/nWXD
 ZKwEUGtnQ/HHiq6jtWVFRgXAgS+t61JbRLk62pz+ITHLM+qKLMkiokVGbjsaOPAXl62Y3G1GraJ
 oaGiAwG++PoGt3GRCN2o1K7Oxwc5wXU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300208
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38411-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:ath12k@lists.infradead.org,m:aaradhana.sahu@oss.qualcomm.com,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,qualcomm.com:dkim,qualcomm.com:email,vger.kernel.org:from_smtp];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E8FD86E822D


On Thu, 04 Jun 2026 08:45:51 +0530, Aaradhana Sahu wrote:
> Currently ATH12K_USERPD_ID_MASK uses GENMASK(9, 8), which defines a
> 2-bit field and limits supported UserPD IDs to values 0-3.
> 
> Future IPQ5332 multi-PD platform variants support more than three
> UserPDs. Expand ATH12K_USERPD_ID_MASK to GENMASK(10, 8), increasing
> the field width to 3 bits and allowing UserPD IDs from 0-7.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: expand UserPD ID mask to support up to 8 PDs
      commit: c2d60ab8e3827de2cbf951491e5de339e4bb2eb9

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


