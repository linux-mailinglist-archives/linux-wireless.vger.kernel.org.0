Return-Path: <linux-wireless+bounces-36620-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNZHKjW6C2q3LgUAu9opvQ
	(envelope-from <linux-wireless+bounces-36620-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 03:17:41 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A42575F90
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 03:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D0226304E66F
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 01:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7732EA498;
	Tue, 19 May 2026 01:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Bbl6fZAe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JEGePnmD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425352DB79F
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 01:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779153397; cv=none; b=DhsFWlwOCdPrRkwv0aj2/HTOuhAO8OZe5XrLNEM9YnvOfwKia3OuRia8jDh7cHZE6KmA9bvZwgqOUkBpYLFri+S7W66ngAq40T6MZr1M+jN1sEXAJW7IR20qeRnKxkbcz3P6ImttRfXBG4UXTAyfeSkSkxa4g/4L8X3T/jRJFh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779153397; c=relaxed/simple;
	bh=g59r7iyseJ9ZR4HJOr0G4FwF2fDCK+MaHQ/TNE4KOK0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kJoQPom1z2M0v4AGasiLpfAjszQmWsJ86HglMcx4IUSE0txyGMACQdfI1H2qsDx4jnOvycXZWrs4/eVzbttKVAevPmms1uUeKaGu/+xpZLN6rTEQcotiG4usAhsOl6BUucuVQRldpX0eZ6NBXWv4CYUCwQScK8vhp20+J3fLbhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Bbl6fZAe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JEGePnmD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64IJHVMA1890528
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 01:16:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=nKQe3CSDWeI
	3ZAT/8ZI+HGmO/H88qV/HqEiNJoaBIHA=; b=Bbl6fZAeRvAvbnFXIQFEbyBhgVf
	38cUd16r0r6+IIxFfE9ZjQfCX1FZLLU/xHMPiuL8Eh/L4KAVWQYSySSAJs/u06qq
	LiX2aXBU9FbM++gG9btDEA031u5y4w9UafnNAufNwJ4W0WZkW/O/RuU7dP8xhw6V
	xPCQPCVmXCjpzYSc6h+pc9+vZ2uyPKd0djioqF0yL7qPKDkldCg3iKkQu5b5eoeW
	/8dWmV3zNlw+zHWmpTYSzx4s8lU8d8HCMnXHhTGczjIEuprlLCP5e1g9O95OERcz
	61Lk2oFZjUbxlIljTZfnIRedOqGZU5H80AOYUK3ma3K8nVJEyR+3ve4SYKA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e82pw2jrd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 01:16:35 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b4530a90fdso40319455ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 18 May 2026 18:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779153395; x=1779758195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nKQe3CSDWeI3ZAT/8ZI+HGmO/H88qV/HqEiNJoaBIHA=;
        b=JEGePnmD7V1EeVdOCTt+A+L79/R7BmUFCk20TdsNyR3CjS3m6iTVbAJmX+q2Rx9UKx
         qNJl+/bdA3APk8JD1EUZ0XFmQWa3OcLe//EuVOcrew/nkvpNo+jmA/Y4SrQHCPQ6vwpK
         KRkEt1XI5eK06fsOtIaqA1XAeOeFkbDUnxgDQ50YsB3W4qS20Q4FdlSIkjGb7+lk+7K7
         TD8Pnq/G0zA4V/B5zcQnlBmQBqaWoEZt3IIcEfxFLlibFIgDXO2ru+YnkAQHCWyXXO85
         QWpGY/Hm1y5coEOk00zYcwKu81ksF9NyPcVMphun2fjWGSXJ+ZCnyRQzeqOJfSQt03IF
         X10A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779153395; x=1779758195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nKQe3CSDWeI3ZAT/8ZI+HGmO/H88qV/HqEiNJoaBIHA=;
        b=PqYuYHePytmGEH/JokBq3PCHieDuNQfun7SGCgWnm+6oCcpqqhOmUkloKkz8h8SbWE
         RjoyIKsBieZMRcP8hewVLjTvC6AwULo5A7A2I4AIw/61/vu2lFVpTlqSSmd0sRn0EK9/
         vycwm61WiJS6w9159Qw25h8LyEcl6Ck4Ry0HfmuJ5lRWXS/ZVdu+LrKPatcP+WRogDcj
         Cm8P26W9aRn6e4knFIzhngoztiyrkiixby285kHgXjFA8EE1+1VeIjHNprT/kcUEumj7
         OX59+3Rr7nTF/gTvqA2UHX4K1bvSNZSW3L7nI7WuwaIbTRFVyF9KtuHf3ZUhg4ZXv9iF
         5p5w==
X-Gm-Message-State: AOJu0YyZ8XjPUE4BF5glJVB1dcsSvsA010qMeqS7MhPwWbnjPARC8enF
	usBHfPXYtP5EnXyqAs6A33mXBJBQtTPmC1bjRotVqEEEYns4+97Hgj1qzPLq7TgNCrSMCpW0cxz
	VXbV6wkfs5CfMkJJ+YFSKTlv9jIkza4kABHc0CUzv9R0J+xheeb/Dn8KotygPQxMe9n7QwA==
X-Gm-Gg: Acq92OFR0WVONiBGfabWuShoEOsHVdw8u/MYunwHYCUrH2KsRY11pzIuCj0uYE/Z69i
	fi81RaCqWhuA4ELHVvLzyI4xAlqSjeiZeXiwuPPJTrVRbH37XWU+bh+kDhwX7S4Jmy3/8FDiT2w
	SZfE3qSZz6SyCVm1WFFTcUMjBQxPGNLetKUlXDkJ4G/15AA9G/jGgMNFoqtfjipZj/ICX9CrtnR
	dwx9QohrqJeWlrxSPU7gevh0oacGgaoEVBBokbc3xKJLJ5mpCWA4+aqcBiRAJ493R6U6oBEdL/Y
	doPfiE6c9izd7d4FUtT1I+yVJOVmO20tm5fOSCQaBy+6aIwkE0Z+RJtdmngXo7v3BJzxqUFw5hd
	tickrPYJ+leFD1jzJ8lT8XFjRuIvz3BtgWIYvxi8BOhJkoIXBlOcCK0jG5qHj2HQTLkepWa/jXA
	6Df11CzQeiyg==
X-Received: by 2002:a17:902:ea01:b0:2bd:d7b5:83ed with SMTP id d9443c01a7336-2bdd7b5879cmr77645015ad.39.1779153394802;
        Mon, 18 May 2026 18:16:34 -0700 (PDT)
X-Received: by 2002:a17:902:ea01:b0:2bd:d7b5:83ed with SMTP id d9443c01a7336-2bdd7b5879cmr77644755ad.39.1779153394333;
        Mon, 18 May 2026 18:16:34 -0700 (PDT)
Received: from hangtian-z2-2004.ap.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe49a4sm151727265ad.38.2026.05.18.18.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 18:16:33 -0700 (PDT)
From: Hangtian Zhu <hangtian.zhu@oss.qualcomm.com>
To: tglx@kernel.org, jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 1/2] genirq: export irq_can_set_affinity() for module drivers
Date: Tue, 19 May 2026 09:16:26 +0800
Message-Id: <20260519011627.713068-2-hangtian.zhu@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260519011627.713068-1-hangtian.zhu@oss.qualcomm.com>
References: <20260519011627.713068-1-hangtian.zhu@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=a6AAM0SF c=1 sm=1 tr=0 ts=6a0bb9f3 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=h_boC3gFLMGeuZepMsQA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDAwOSBTYWx0ZWRfX1TYBlPVeY5PG
 10uCgzlkpBakbrEpFqYB7YDwSTNF8BrcNCgQCZFbT98K9X4dpFBiAJCrq1VgLhuczeu6aUZa9OF
 e2v8e3MuiH8rzLu8wzYGm1/r0q+bb2e6M9P9gpTNymW5rGvR3q/cx2alQyWmfEx7j58c72ycWX7
 5oE3VQwBhsWtSBF8pAhqYrzu4x93EYFvR4HJBi03XNz0xI+XSgFpB3rswW43UgZGj6kb4VrODvb
 sIzPzH4+EwSQvjeOix9z/8STm0LjxHZuXsc+UlE4zcY2ccB6thif1S3YAWxGkFR1Ih8Irm30t9y
 LOlg0SH+5sH1wDsTj0P88q6Rp7E1xPLlvY4xMO3MdOLKlK2XowzN4DpxUZTxMns/mE7Ak0ZK9o1
 PIEl/8jsn4Csq8YzovUctJMV/vQc/Vql47nojhlwGlXKtKwohqglqv8T+qCBhxXfYMSPFM4HSaB
 NYpctCCsyQv0ULSu5rw==
X-Proofpoint-GUID: ttPFm79EIti4DKA5nvHcyFYuJlorD6th
X-Proofpoint-ORIG-GUID: ttPFm79EIti4DKA5nvHcyFYuJlorD6th
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190009
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36620-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hangtian.zhu@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:email,qualcomm.com:dkim];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 26A42575F90
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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


