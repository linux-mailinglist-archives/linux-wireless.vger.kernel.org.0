Return-Path: <linux-wireless+bounces-36617-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPVwBRy4C2pZLgUAu9opvQ
	(envelope-from <linux-wireless+bounces-36617-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 03:08:44 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AA2575EBA
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 03:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29B493037DC6
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 01:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4210B229B12;
	Tue, 19 May 2026 01:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bAH7mkvw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QsOYSBJn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F3829AAFD
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 01:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779152889; cv=none; b=ojfHA/99jrFdh/y8h080v2dqXtV7OSTOazWj4HkQxeB1tjQuUv+HKusgZXqC1I1L4YAAkpMb/WuDmTQ9zVBpJkjeZECQ7TnHGlAUM2WvGymPjNkHhdy70cl6dF5Y3xHEwbdYYJHRxp3f497uGt/QtOkwJAyyyKMKlwvbsN5Eg2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779152889; c=relaxed/simple;
	bh=+rp6gvMlHIRoz51YZ9zaqACx88D664H1vCrpLGKZLzY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VS7SalNjeeFo7eMfgkBVKpLw9k838w8dBK9OVTF5xxtgridzWB4Oo3Pn/pGAdykwtOSz0ZcpmBfWYtjtWXmEW0yV/HmvqFVY4qzZsLQ9gUF1diZtu6iNZVcIW19r7wCwZoiJw9HynYBPL9rDxIhX6PCCp7Rkzszev9hPiVbnxq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bAH7mkvw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QsOYSBJn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64IIvTh32482391
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 01:08:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=X9HmXD8It3z
	OIVPJa6MlBya8ryspjm9ncZa5MieYLs4=; b=bAH7mkvwJJk0C3CWufg2av+kqmu
	u2ogO5AhMvgKaWGXHF1gaMnRmsizlhdCDVCuC3dpbVNv/JWZr3XoyJ10/MYcJhLF
	bPD+4lxha9YKcOO7vazKuNkyzfjzxyCZpohpFKidHGsmGfiaMNfVhY9OYpv86lCp
	Mk9ftcxw3T4NnHTMPDpVPC9FbT5ceD6DmTCZM1c5Ouha+rKJiEXYfVsGuGYJ1G3D
	HJ9Vq9JVC291W+S6I31bUZNJbfSrcxnxgwBO6dV5wP1Wz/nelwCdR6aC5XnCpNDL
	523qf9XR3NwKf4b72gmK7sdFHdJyJzjO9oWPNMpWi+11HaX1+XBlWI2YY6w==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e81rvjqxv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 01:08:06 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8354503d9acso4145690b3a.1
        for <linux-wireless@vger.kernel.org>; Mon, 18 May 2026 18:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779152886; x=1779757686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X9HmXD8It3zOIVPJa6MlBya8ryspjm9ncZa5MieYLs4=;
        b=QsOYSBJnA7xcmGU5TBOwE8xRvhtb0GdGa374ESMV7qc+Aihjaj/YyC9GJM7+b8HMVZ
         e/xCxZ7CoqCkXUZ0enSnjOYO1HYLvt4C+LSQBS6nUjCclMD4pBxuB4uSiX+r+wH1+Wic
         nzFLqO5IdTnNz6wF3PDrVDrzyveirYTKdGl6nKinBVMDLMibNhj0ixaLjbRrFuLDwGBI
         aixiOzLHl6ng1n5DQLz1JijoQlnsmvO4Z9vICRMUBdUHbDWBuAnLqfG6Gwvg3kOjo9/y
         5N8W4LIiN0R9KF9gNPEc34pQEPQ8nAdSiPXg7XmnfR+krQFoNdrgi3Rq9KcRgROoWODe
         BFsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779152886; x=1779757686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X9HmXD8It3zOIVPJa6MlBya8ryspjm9ncZa5MieYLs4=;
        b=rw3uZcywivbGoQO79ynHoUWxFPVOn1dLdnQl4qyhb8meGm+qG7brKBGGItqxjiHRrz
         YJ2+ZboYXV9CD8tO2eftwBHUDP7bmJQz2cLCeep0eS9jJagmYDlV1V61l0Ub0NtfsvIu
         TKmc2uKCX91Mmi3msxgj1vfQ//Z7O8XXKMKfQWKMLsH3RBS8qdYYXl9xmmITzTAhP7id
         UKYEuv9XQKQEPPxVRw9+9iVVThM3+Nn8cwrKsIublpE385FMJ925QypNXTQ0mw1Bekr+
         Vubd3UzJOYeLwCNKgBs3wTnzIZo3mrqFQXAmWMGUzl7QkasmQQoSpTgqNNtcDj9Lj4Ny
         Ib6g==
X-Gm-Message-State: AOJu0YzUMT0XOnH4OAy1zhmZKsGM3JcdCARPYGtnc0jPCBqGC+coAYXm
	EWvhh0bHwykOIYPWpBHapfM5EiPzoZH2xSXIjKvg3Vg3in0Jp3TMuA1vDLToH1Y6sBkyxfJIZHB
	2Ih0oxnmVXwy+iMqStqGWYLLJFUE9X13Hbyk0S6PbBD1+OEuRRaOtebV5wukFqsImFOo+sw==
X-Gm-Gg: Acq92OE8C3TcqDatJPzzkPJx07LmInoDZH/wARpg/7Vty/hA1NhRaYhMfir067UD3Ab
	EzF+6hpP9O0AtWnRdd14U0nCRZPwlNSc/rp+pFePqKypjoIrfMMkWAKytrFHYjK6VNwKuClEWPP
	L9ZylfuLwQ2BmWjQZn7PEL2hF9K463PuwxTTkmr/YZO/mUqFzFJahsve+Uoxie4I4QX2h2RGdeR
	OMAlynNCOgpEvV8zyu97DHlYUKn4e/jtmoNdY0JPUKq+wnORz5JSQ190QKUSd/LScXEwcGY+1o5
	azrPwqsdLcJTxoH6EOQt7nBO6nG9dq1DiUYhJsEW4yhnE1PhxAc01RaFIJnq0mtXTSVvh66bxYD
	qdidDEDAVuEjIQOntuVqXe9+8F4prdPih9knZzfOPrjKrfphS0HRusKd7ifbMWycsBy2LKoZPI/
	fWn86T
X-Received: by 2002:a05:6a00:4193:b0:82f:a6bf:bee7 with SMTP id d2e1a72fcca58-83f33d0d040mr17751395b3a.49.1779152885748;
        Mon, 18 May 2026 18:08:05 -0700 (PDT)
X-Received: by 2002:a05:6a00:4193:b0:82f:a6bf:bee7 with SMTP id d2e1a72fcca58-83f33d0d040mr17751368b3a.49.1779152885236;
        Mon, 18 May 2026 18:08:05 -0700 (PDT)
Received: from hangtian-z2-2004.ap.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f1942a83fsm16196793b3a.0.2026.05.18.18.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 18:08:04 -0700 (PDT)
From: Hangtian Zhu <hangtian.zhu@oss.qualcomm.com>
X-Google-Original-From: Hangtian Zhu <hangtian@qti.qualcomm.com>
To: tglx@kernel.org, jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/2] genirq: export irq_can_set_affinity() for module drivers
Date: Tue, 19 May 2026 09:07:57 +0800
Message-Id: <20260519010758.712297-2-hangtian@qti.qualcomm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260519010758.712297-1-hangtian@qti.qualcomm.com>
References: <20260519010758.712297-1-hangtian@qti.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDAwOCBTYWx0ZWRfX1CxPKF92DJUa
 eZOERPnvaVeVCNFQTaqZQMy/QIgWa+O2dj9VcLJCjxQZT23HlxPTlF9ckYYQ+jr6yhtUBFGy0rr
 rrHHHiJptoxfZytyWjJrpCA5MXXnaqObPQXqwL0c1u3i133nJq4ewFEGrwLWloI92gfKAs8HSLo
 wHbiXN75XoP22hPKcCrN5kgi+od9i6EhgUPD2MF3Gh1slxSBg82fcNGVtgmXyfQnvydCijfmjAM
 lDnymZEYM+HRXsA7yK6g1PoFLnprFdGi7ZV5l7i8LITY0Of8DePkmhJC4LuKTJmO6/MsNy27Sfo
 fbBCLrd46qX1G5jBE8UjXKCd9bBkuvZC/bcWbpS3Hee4QKnyWJ/7Gllw9RDDqdu5nB/5MtVx8Oi
 /Cjh31IgLP+2wH7cmLIHc0MBn8fWfY4kVF+C/hyYh5Yq/TS3xiCrOQBbcitE+lbGwU/1RMAzIn5
 uRmecCV/rM88t/zxBsA==
X-Proofpoint-GUID: Ut5VE4et1ssjD9eRBM3_gvHVpCW7MhuX
X-Proofpoint-ORIG-GUID: Ut5VE4et1ssjD9eRBM3_gvHVpCW7MhuX
X-Authority-Analysis: v=2.4 cv=Lf0MLDfi c=1 sm=1 tr=0 ts=6a0bb7f6 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=ncsClcd2Rt7TSDcZb1cA:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 adultscore=0 clxscore=1011 impostorscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190008
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36617-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_NEQ_ENVFROM(0.00)[hangtian.zhu@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 82AA2575EBA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Hangtian Zhu <hangtian.zhu@oss.qualcomm.com>

Export irq_can_set_affinity() for loadable drivers that need a runtime
check for IRQ affinity capability.

In hierarchical IRQ setups where the effective irqchip path lacks
.irq_set_affinity(), drivers may need to switch to a fallback policy.
Without this export, module drivers cannot use the core helper and have
to open-code equivalent checks.

Signed-off-by: Hangtian Zhu <hangtian.zhu@oss.qualcomm.com>
---
 kernel/irq/manage.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 2e8072437826..c3aa33ef4be9 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -171,6 +171,7 @@ int irq_can_set_affinity(unsigned int irq)
 {
 	return __irq_can_set_affinity(irq_to_desc(irq));
 }
+EXPORT_SYMBOL_GPL(irq_can_set_affinity);
 
 /**
  * irq_can_set_affinity_usr - Check if affinity of a irq can be set from user space
-- 
2.25.1


