Return-Path: <linux-wireless+bounces-36062-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eL6xMEtz/GlBQQAAu9opvQ
	(envelope-from <linux-wireless+bounces-36062-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 07 May 2026 13:11:07 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 208CD4E7440
	for <lists+linux-wireless@lfdr.de>; Thu, 07 May 2026 13:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37A0E30078F8
	for <lists+linux-wireless@lfdr.de>; Thu,  7 May 2026 11:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BCA3128B6;
	Thu,  7 May 2026 11:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kE0j+Jqt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480933101D4
	for <linux-wireless@vger.kernel.org>; Thu,  7 May 2026 11:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778151916; cv=none; b=XTAW3AWuCNSfq5u5ogXKYWX3A3+CboXEcADmsIT4tAuTszEomHVfr7+THzuvTKOQIoFsH6G0p853YoBlKwzmFjWW+IaEca7G9I1MvvgNIy4q4rw171ICNbO8/bbhncFpNEq8ayjLF4Pc2z6ssW9UQ6ikyw9CLR8FPNUyUkuDm7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778151916; c=relaxed/simple;
	bh=gcoVnuPbLQBwdWdcxYRh2eENj0ujltQbPI9VkwzTwgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qa1Dv4npUf4eZ67Su7p79e8y1pdEvXNTCBI6qhR78Af5ZJSbGQw++ORW28t+pQ0yIMQAPQRFDdMntGC15AKemfIGX7JhH5usqCy2+MYuxHE2nrDPpW9ccPolN3RmiJMZE+6hD/WVSUwcvhAp3MqecmMspS+Zj2I1iSDTAVLT81A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kE0j+Jqt; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c80203b9d7bso240170a12.0
        for <linux-wireless@vger.kernel.org>; Thu, 07 May 2026 04:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778151914; x=1778756714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lzzmv3l5JprSivqCZvNRZy1Z5+t5yN2JlhJPRVH/nQg=;
        b=kE0j+Jqtf9rvJGzGMQKuQhrtxqbsfYrH/Hnj4Z3UZDcFVInkILnqkjA6VJ979NSgKT
         WkgN4pV+BdagA90RJeK4pHbWF4gWcQYjx4UdFNzeIHtfvzNfWlqqgneHrslP+V7i1xNp
         aAplLQgnFtLrjuyKzyEXAMBdRk2jdfWIcDNMWhe/4xOMvdPfVZ3RVbr2UDKb6qm0asnd
         8YEx5ajtyTfaxmJef4XZmhuziZxb86oZndHnraSTkFD8WSEsrs+caJNyc08gUJmE5Mwa
         EDHblElcAgArBjujX67bR34jg+aF58mt3ONE8ZZfDIIVIgeUGFA1lzvU34XXFCRQtLPI
         4m6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778151914; x=1778756714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lzzmv3l5JprSivqCZvNRZy1Z5+t5yN2JlhJPRVH/nQg=;
        b=dAdbFUT6EK68XX0WTmM3M4qMJzGxgD2dWI4cpM5sU7Uxf7dJeTuJSO1QnuimX8+xAe
         mn8/i9wqMAkGnOUc+RpJ3uX50AXLqbBfgYv6+6rRuVT25xlN+4TUnIGdk1Dbkijf1Cnw
         R7rKQSDLygeW+stEQkwoipWP/s+lLhTUVxFIZaAwtR3m/FcJk8JCeLckktfOUDfZZqJA
         0v9uQ2nGWsLxGqmL59vhfvrlLBjK/pDSnW4gonnFmx4APDRxDbQ4bHMQBtzQY4Eg3YVz
         O84Dx+CRZcwgQMPrIvUUAbFIVD7W29C/2MqwGyswvzp/vTeUiT4NtpChpOPAZSiXseFW
         XpaA==
X-Forwarded-Encrypted: i=1; AFNElJ+s9ZbPTF5LMI4zcjHw6+tcm7R0BkO2PB9QbAobAuJ2154JlCk80h+jc/wTlmZGElzo5y2TEK8NLxvoaSJF+A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVLOoe4aFz4L2eiWaqYJdPq0kVHmTjySbLU9MzeWLAWUk+jBDU
	TqLim0UN8b2gudgDElMaHuDVlz/6ATNt7DukvHPwi3OuOoyCYEsh7lhM
X-Gm-Gg: AeBDieuCFj33P7pwRpkiwYukQMi6DZ9xr1xImDQDhOq31DTmtV9E4cFtksXjUAK5txJ
	YKM+Cz8Sen12XiGEfnCP0Ks+/IONqDvGAkmBs+EUjL1YaMi6pxHvpPGCPJPOx8fn6JDthCKMjLi
	qCuKCIedwsbcatbWxyAcnpCMnGFStcKzvshBLDJ9Yt+MTZdMFhy4olO/rqCoyVVeqmFeeUf6Ufg
	JZD/mqYM+g5M1KtTECGPQdroAwsDAkduFVSCTAZAQ30Fvd0i3h1d3E/Uo7OOB2midXan+K1f9+q
	MedvFpzX+2y1nrNwcdeZ4uxnNmTawkgyQetKqgrNCHb83I+06kF5ApkrX0cYZ3feiondMLz+8pE
	r3s+9WjsC4s4YTvanTmT0G0uIpMxggLvbZXP6Hklp8qbh77HW+RR66/btm6Gt7vT/DUruMxjDWo
	pTTIEYH2E/1iVSMpKNW6Nnej0HD5OBSpiXmw+Xm4vK
X-Received: by 2002:a17:902:cec8:b0:2b9:8e63:71c8 with SMTP id d9443c01a7336-2ba793c04b2mr83245075ad.29.1778151914606;
        Thu, 07 May 2026 04:05:14 -0700 (PDT)
Received: from localhost ([103.74.250.37])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2babaad7e4dsm22697315ad.20.2026.05.07.04.05.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 May 2026 04:05:14 -0700 (PDT)
From: Jiazi Li <jqqlijiazi@gmail.com>
To: Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>
Cc: Jiazi Li <jqqlijiazi@gmail.com>,
	linux-hardening@vger.kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH v3 3/3] coccinelle: Add rules to find str_alloc_free() replacements
Date: Thu,  7 May 2026 19:04:11 +0800
Message-ID: <ecd2beefca98bceead680c4bd3c5df684472b69b.1778051552.git.jqqlijiazi@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1778051552.git.jqqlijiazi@gmail.com>
References: <cover.1778051552.git.jqqlijiazi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 208CD4E7440
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36062-lists,linux-wireless=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jqqlijiazi@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[transsion.com:email,mingzhu.wang:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Add rules for finding places where str_alloc_free()/str_free_alloc
can be used.

Tested-by mingzhu.wang <mingzhu.wang@transsion.com>
Signed-off-by: Jiazi Li <jqqlijiazi@gmail.com>
---
 scripts/coccinelle/api/string_choices.cocci | 38 +++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/scripts/coccinelle/api/string_choices.cocci b/scripts/coccinelle/api/string_choices.cocci
index 7b2b76a42acc..516b30828380 100644
--- a/scripts/coccinelle/api/string_choices.cocci
+++ b/scripts/coccinelle/api/string_choices.cocci
@@ -7,6 +7,44 @@ virtual patch
 virtual context
 virtual report
 
+@str_alloc_free depends on patch disable neg_if_exp@
+expression E;
+@@
+-      ((E) ? "alloc" : "free")
++      str_alloc_free(E)
+
+@str_alloc_free_r depends on !patch disable neg_if_exp@
+expression E;
+position P;
+@@
+*      E@P ? "alloc" : "free"
+
+@script:python depends on report@
+p << str_alloc_free_r.P;
+e << str_alloc_free_r.E;
+@@
+
+coccilib.report.print_report(p[0], "opportunity for str_alloc_free(%s)" % e)
+
+@str_free_alloc depends on patch disable neg_if_exp@
+expression E;
+@@
+-      ((E) ? "free" : "alloc")
++      str_free_alloc(E)
+
+@str_free_alloc_r depends on !patch disable neg_if_exp@
+expression E;
+position P;
+@@
+*      E@P ? "free" : "alloc"
+
+@script:python depends on report@
+p << str_free_alloc_r.P;
+e << str_free_alloc_r.E;
+@@
+
+coccilib.report.print_report(p[0], "opportunity for str_free_alloc(%s)" % e)
+
 @str_enable_disable depends on patch@
 expression E;
 @@
-- 
2.49.0


