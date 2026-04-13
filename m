Return-Path: <linux-wireless+bounces-34692-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEkbCCG23GnbVgkAu9opvQ
	(envelope-from <linux-wireless+bounces-34692-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 11:23:45 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B85D53E9CCE
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 11:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F4363049298
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 09:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890623B27C4;
	Mon, 13 Apr 2026 09:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oY+vEH1n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5664E19C546;
	Mon, 13 Apr 2026 09:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776071783; cv=none; b=DXyEAPU6HKBrYkw1IFuAYKk2/ZFxAm+FGqV+QUlnBoH71VOwgiXICiessO0I1ayP2P+61khY6MJGsQSPIb2wizLfMzfDULZ5ItD5/P4Y5d5h7/u03spEK6ZKIpUa/t+XU0AM6JAwGQ8BlaMC3BtBT9GP374TgT1P1/muHOxLnVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776071783; c=relaxed/simple;
	bh=j/tYEurlHNq5kx1yV6D47wbOZhhwgvOxlSSa1P5IOeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K5FItm4pkWqIoz/HLDoSRvqOYcfcTW90Ijz3BL3hja+DhSPq7EPSBtz5R2UMMJhPvvZ8fAM0XCljCUcztKBQw9SxMrw/5RRrlgL4OzYKNVsYWnVn5Ic6ttpen+bHYyoXj4F2CuzeaLsxiRAT887zW1VHTVG7qH99bimsdTdwtsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oY+vEH1n; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63CNQ6Rp3649347;
	Mon, 13 Apr 2026 09:15:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=3hYK9Ei+d9kVH0VV/CR68CUDnV5UVC
	rS18XI/2Q3GjY=; b=oY+vEH1nHYm21zR7dKdG+rMVbiAs+2M4pSYJYH25H3Q/WQ
	S5pbibNxKHXRtCU5RA4BZpoAC/CsLV14kYSk9HD7BI83gpVLqIVXm+N3/UD3mtFb
	VGL3bfwkoS+MFSXp/7ksAXz/d/43BdzYyNe+WU94qMB7+oTAY5jMdy/aC1rg5QU1
	UhBzNrX2r1ZHEsamBr6j/bYRaaLxasa1WWuLDHkVDfa2K6RkMY6wizvw26f4v3Pw
	kdUQa11kKa0O4lHqHX35TBGaxo9cfSk8h/UtwhMbDVaUgMt8SMltIpECwIrRGVKB
	KeirN6PqfMTEor0kXcjWPcrhlHvR883P23ApPmxw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dfdt3px1j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 09:15:17 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63D80WMC015153;
	Mon, 13 Apr 2026 09:15:16 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dg0mscku7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 09:15:16 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63D9FEC727328866
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Apr 2026 09:15:14 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 70F6620043;
	Mon, 13 Apr 2026 09:15:14 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B712A2004F;
	Mon, 13 Apr 2026 09:15:04 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.123.13.2])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 13 Apr 2026 09:15:04 +0000 (GMT)
Date: Mon, 13 Apr 2026 14:45:02 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        x86@kernel.org, Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux.dev, Michael Grzeschik <m.grzeschik@pengutronix.de>,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
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
        Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: Re: [patch 07/38] treewide: Consolidate cycles_t
Message-ID: <ady0Ft_tDrbGlu2o@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20260410120044.031381086@kernel.org>
 <20260410120318.045532623@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410120318.045532623@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: r6KN03kK1HZaoam71kVl5aHZm9BfgAQ4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDA4NSBTYWx0ZWRfX+Gwbo0yddZP/
 ED3CWrVQNFFw/TECS1M9+tSS57FYBZnMmG79KmJVnAwBWc3o5BgyeadFZ9maSHI4Tv+/+VHQiXF
 uu6/EAbMsVnRYIXugjj6TyQBBqRyeSoPbLxIVX8tqr0goumkz0lPJ9Y4Y3a3ECfM9WbzUtOSm5u
 eNbyrRMw+nuwi0Afz/QuxwA0FuazktkFPrSziYKfNEV92tR6ksCbhLbdKwZfOQ6IaUNAK3mHh04
 Z9ZuJvFG4+5R/DIJQ8v5H1fE5bYExgqIL1hC1HoekBef4/UHL3Jav5jU5Ty8ib2gAESLlopFcCb
 VttV6mxWXomhvrcFDBgGSdweqIiLio3UyKWRaxfdCdf1K3UdP0nDdx3LiWp/XKSUCxaso/02xav
 PADy/jEsrag0vsgcCLG1/jcBcJ3bFL3cNcYlDCC6JXFySGCPKTcpDMOtfvLh9vv4Vg7VR02ItSs
 a0USozVz3do3GTBrHkA==
X-Proofpoint-GUID: iwEVNX-0n_YmGG6iAARt9TRRoEhRuwqE
X-Authority-Analysis: v=2.4 cv=WpEb99fv c=1 sm=1 tr=0 ts=69dcb426 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=9Pz4rRoAHiK5H5RfW9YA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_02,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 clxscore=1011 lowpriorityscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604130085
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,arndb.de,kernel.org,linux.intel.com,lists.linux.dev,pengutronix.de,gondor.apana.org.au,kvack.org,infradead.org,plugable.com,mit.edu,linux-foundation.org,gmail.com,google.com,googlegroups.com,alumni.ethz.ch,zx2c4.com,linaro.org,armlinux.org.uk,lists.infradead.org,arm.com,linux-m68k.org,lists.linux-m68k.org,southpole.se,gmx.de,ellerman.id.au,lists.ozlabs.org,linux.ibm.com,davemloft.net];
	TAGGED_FROM(0.00)[bounces-34692-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ibm.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ojaswin@linux.ibm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: B85D53E9CCE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 02:19:03PM +0200, Thomas Gleixner wrote:
> Most architectures define cycles_t as unsigned long execpt:
> 
>  - x86 requires it to be 64-bit independent of the 32-bit/64-bit build.
> 
>  - parisc and mips define it as unsigned int
> 
>    parisc has no real reason to do so as there are only a few usage sites
>    which either expand it to a 64-bit value or utilize only the lower
>    32bits.
> 
>    mips has no real requirement either.
> 
> Move the typedef to types.h and provide a config switch to enforce the
> 64-bit type for x86.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> ---
>  arch/Kconfig                       |    4 ++++
>  arch/alpha/include/asm/timex.h     |    3 ---
>  arch/arm/include/asm/timex.h       |    1 -
>  arch/loongarch/include/asm/timex.h |    2 --
>  arch/m68k/include/asm/timex.h      |    2 --
>  arch/mips/include/asm/timex.h      |    2 --
>  arch/nios2/include/asm/timex.h     |    2 --
>  arch/parisc/include/asm/timex.h    |    2 --
>  arch/powerpc/include/asm/timex.h   |    4 +---
>  arch/riscv/include/asm/timex.h     |    2 --
>  arch/s390/include/asm/timex.h      |    2 --
>  arch/sparc/include/asm/timex_64.h  |    1 -
>  arch/x86/Kconfig                   |    1 +
>  arch/x86/include/asm/tsc.h         |    2 --
>  include/asm-generic/timex.h        |    1 -
>  include/linux/types.h              |    6 ++++++
>  16 files changed, 12 insertions(+), 25 deletions(-)
> 
<...>

> --- a/arch/powerpc/include/asm/timex.h
> +++ b/arch/powerpc/include/asm/timex.h
> @@ -11,9 +11,7 @@
>  #include <asm/cputable.h>
>  #include <asm/vdso/timebase.h>
>  
> -typedef unsigned long cycles_t;
> -
> -static inline cycles_t get_cycles(void)
> +ostatic inline cycles_t get_cycles(void)

Hi Thomas, I'm in middle of testing this series on powerpc. In the meantime I
noticed that there's probably a small typo here (althrough this is fixed
later)

Regards,
ojaswin
>  {
>  	return mftb();
>  }

