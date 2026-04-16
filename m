Return-Path: <linux-wireless+bounces-34893-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNJII57n4GnhnAAAu9opvQ
	(envelope-from <linux-wireless+bounces-34893-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 15:43:58 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AE740F06F
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 15:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 86393301A423
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 13:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2153C5DC5;
	Thu, 16 Apr 2026 13:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oxq0L3dy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155233B9604;
	Thu, 16 Apr 2026 13:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776347032; cv=none; b=PcHaUbA5u+B5panF8cJ4UKspzn9lwthbdsGPbhfenTH5cIB2Mv3SsU1JdAoGLGpCQAp4RUD0+pZVk17UWEty0LqiPw7VLs67G3dU0lL+pTYYScmI0/e4DHJMs9rDvPhWcDunWcfs3FOsZjyCGg43uuojv6oUWN8kIzCV/BtJvmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776347032; c=relaxed/simple;
	bh=qfia6f7p2mrxliu/5Lfsw6GThkGbZSkpMOlHgUNain4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IIQak6107BgehRD3qJ7hx87fn+1NZuQQAkkz+SZ4Jcnhz3CIIsQuuV0vL+5LWCL/7M6wuGjCn60eBCe179ny4HkwMPOIsZKyNQYJLTOQ2+tGiVm9hGdTDjyYUkkV8L4+l2y5jADH/3U62tCE1VoIwFdC9Hf/xdp+RXMN6MEYv7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oxq0L3dy; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63G7sGgI1833152;
	Thu, 16 Apr 2026 13:42:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=f/UjitU2IRDQkjyHmpVEhuknZxwT4y
	OWmcb/zMeZnjE=; b=oxq0L3dyylrzBDUlyV4jJBA8jSxvo6zyTFu2eZGBSWIf1F
	0ksXNAaZF1WFKO90vuj3ti8LrXkR4WMFD+veRWCanALiSvqIPx5mj6AiZqVUTeh6
	tnOUDFD8eG7uVm2ujOQXyKpmzLTf5Owa4nae6JyebU1il+cvOG4GPAishf31nirE
	QHj8T3NZ/YPFd6hNRv9PVtfbIxtnQmC5vDBXeXZfk1L1NOqO7IX91VEsi/on5hTf
	swPZjWAsNymtPrfj22h1nP6023klHtGdpOwHkZzHB+qFWDGTjvfilGSiiCmKXonp
	ZKuwp6xlgpdmgU9LP0G+HpY0nEqSmz/YWYI5xffQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89rnpks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 13:42:45 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63GCrstO003393;
	Thu, 16 Apr 2026 13:42:44 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4djbh94p47-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 13:42:44 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63GDggEf46530868
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Apr 2026 13:42:42 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D9BD20040;
	Thu, 16 Apr 2026 13:42:42 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E411920043;
	Thu, 16 Apr 2026 13:42:41 +0000 (GMT)
Received: from osiris (unknown [9.52.214.206])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 16 Apr 2026 13:42:41 +0000 (GMT)
Date: Thu, 16 Apr 2026 15:42:38 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
        Michael Grzeschik <m.grzeschik@pengutronix.de>, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>, linux-crypto@vger.kernel.org,
        Vlastimil Babka <vbabka@kernel.org>, linux-mm@kvack.org,
        David Woodhouse <dwmw2@infradead.org>,
        Bernie Thompson <bernie@plugable.com>, linux-fbdev@vger.kernel.org,
        Theodore Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>, Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Thomas Sailer <t.sailer@alumni.ethz.ch>, linux-hams@vger.kernel.org,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        linux-alpha@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, Dinh Nguyen <dinguyen@kernel.org>,
        Jonas Bonn <jonas@southpole.se>, linux-openrisc@vger.kernel.org,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
        Paul Walmsley <pjw@kernel.org>, linux-riscv@lists.infradead.org,
        "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: Re: [patch 35/38] s390: Select ARCH_HAS_RANDOM_ENTROPY
Message-ID: <20260416134238.9230Ba6-hca@linux.ibm.com>
References: <20260410120044.031381086@kernel.org>
 <20260410120319.924028412@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410120319.924028412@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDEyNyBTYWx0ZWRfX8JpaMjFpMFNj
 wT/gcAkcZviN6PAKMrtow2zaUGLfcmRJE1Hmlajk6nmzRCOPN3b0RjfUSbBfZ4kcpBQKzFkFpH2
 rBdoNFGP+ENma7o4H4KbJVfdl551lLtrUhXHjq9OwNJzXZ+me9M1v1uiIYgnebcgn173Z5tfoDR
 wlQdz0La24p7XZm2254oSjajXGSASA40rSmgRE/jrWjf8LX+uVSsnpdh3XNIiRv8V/PTkKj6EBp
 iBYTVRyCnznRY5uSBKmAQ36JyfUCJkrEoSNgw47/6thxuZYcD3Vho/t2EjbWxo9/yoIVwBhLMiA
 KDHNz3gXJ52J3z8Lw3ApjdhxznJ9LyQJp5nCQBfITC+W8sZcyql8UU+3NCgtkDEKALiOvDUmzX8
 cTJk9dj+/qvxdwTfyZTWoW7vy+HckV57wQs+QYABEOJZttft9F9OCKr+PfGIpmBZixsJntlLk+Y
 lz3L+7/h8eZbcTrAKmg==
X-Proofpoint-ORIG-GUID: rje87_dJEfU9HQ1lSMRsbGj9D9EjeiT6
X-Proofpoint-GUID: mvWCwZrNw9W7TL82vJ98uT3DrwWfuFPP
X-Authority-Analysis: v=2.4 cv=fYidDUQF c=1 sm=1 tr=0 ts=69e0e756 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=1gfdoSPoDaBUdwTi8XQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1011 malwarescore=0 phishscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160127
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[48];
	FREEMAIL_CC(0.00)[vger.kernel.org,arndb.de,kernel.org,linux.intel.com,lists.linux.dev,pengutronix.de,gondor.apana.org.au,kvack.org,infradead.org,plugable.com,mit.edu,linux-foundation.org,gmail.com,google.com,googlegroups.com,alumni.ethz.ch,zx2c4.com,linaro.org,armlinux.org.uk,lists.infradead.org,arm.com,linux-m68k.org,lists.linux-m68k.org,southpole.se,gmx.de,ellerman.id.au,lists.ozlabs.org,davemloft.net];
	TAGGED_FROM(0.00)[bounces-34893-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hca@linux.ibm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 02AE740F06F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 02:21:19PM +0200, Thomas Gleixner wrote:
> The only remaining non-architecture usage of get_cycles() is to provide
> random_get_entropy().
> 
> Switch s390 over to the new scheme of selecting ARCH_HAS_RANDOM_ENTROPY and
> providing random_get_entropy() in asm/random.h.
> 
> Add 'asm/timex.h' includes to the relevant files, so the global include can
> be removed once all architectures are converted over.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: linux-s390@vger.kernel.org
> ---
>  arch/s390/Kconfig              |    1 +
>  arch/s390/include/asm/random.h |   12 ++++++++++++
>  arch/s390/include/asm/timex.h  |    6 ------
>  arch/s390/kernel/time.c        |    1 +
>  arch/s390/kernel/vtime.c       |    1 +
>  5 files changed, 15 insertions(+), 6 deletions(-)

Acked-by: Heiko Carstens <hca@linux.ibm.com>

Thomas, would you mind adding the below as minor improvement to this
series?

From 7072e5d66b99a7fa666d17c6ad8cb254f2d8f473 Mon Sep 17 00:00:00 2001
From: Heiko Carstens <hca@linux.ibm.com>
Date: Thu, 16 Apr 2026 15:08:15 +0200
Subject: [PATCH] s390: Use get_tod_clock_fast() for random_get_entropy()

Use get_tod_clock_fast() instead of get_tod_clock_monotonic() to implement
random_get_entropy().

There is no need for random_get_entropy() to provide monotonic increasing
values, nor is there any need to provide (close to) nanosecond granularity
timestamps by shifting the result.

This slightly reduces the execution time of random_get_entropy() and adds
two bits of randomness.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/random.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/random.h b/arch/s390/include/asm/random.h
index 7daf42dbed32..f6d9312efdbf 100644
--- a/arch/s390/include/asm/random.h
+++ b/arch/s390/include/asm/random.h
@@ -6,7 +6,7 @@
 
 static inline unsigned long random_get_entropy(void)
 {
-	return (unsigned long)get_tod_clock_monotonic() >> 2;
+	return get_tod_clock_fast();
 }
 
 #endif
-- 
2.51.0


