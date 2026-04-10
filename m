Return-Path: <linux-wireless+bounces-34618-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCZ8MjAA2WnDkwgAu9opvQ
	(envelope-from <linux-wireless+bounces-34618-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 15:50:40 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2311C3D856C
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 15:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1A74301CCF9
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 13:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0646D3C8738;
	Fri, 10 Apr 2026 13:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YJ3HbNt9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5449F3C73F8;
	Fri, 10 Apr 2026 13:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775828758; cv=none; b=Xed/kDn67CI1+j7JwllnwA1P75x9IJiqzK3l5IhiRd1R3UVTDP8HsvILHxsVhzy3U/k3K56MXKWZTSkAO7184dAOVGaOJbWFwNroMg0TGY8fxMfW6oedxWgZ7b7IrAd2k4Zqz9rnZZSnA/DcaVcrf4e+SE8Ef0Ibz2GrYCqQB4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775828758; c=relaxed/simple;
	bh=XhwVNk7AmxnQFYYbofWW0xn2GGcCMLifpnTZm0hI0iw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UDfpEL6erpdFyhfTsT/TSVh30p3FeXj7qe9P2GAmSB12jWnHJBbPuFylcmFcGFNV0D6lpwzb0b7YFAzECmcuPxO9NgLjBRPEgpzNvDdbzv2Hypch8ROTB8IwA4JwL6Ss5wa2kySvZlwjhxWQD7W1jfiCyHvSMBxTX6A7hMxi/u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YJ3HbNt9; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775828758; x=1807364758;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XhwVNk7AmxnQFYYbofWW0xn2GGcCMLifpnTZm0hI0iw=;
  b=YJ3HbNt9KqVB6c72n0p3I8tV+eLDZ8Pyvh5wkY5xQ80nLKZnDJVlBLVF
   /hWAQZuWIDsV0WzZ3NafaV6PbRU1gbqE03bRNkaV148sKfbtEAW/igX0F
   p3HosWplFkRdknQELLo40Q+VWWm6s0SkUOr9cB6gj0v7QrMlkl8j1EP6B
   QEPe32p1VrBic6WVONIBTy+AhKGOcgJLSEVoXNFsHqpkeFVJRhKHh4Gpb
   EprtxrG4CNlyH98+XlztwbJRkUni6GBzIuFoWPlIOvUPOQzONN1aV4owx
   gK5Jt8h5EaRkh/0/onvfP49+HmHEo3oJPFp2j6q9ni6hd9s9zFXoDX4P+
   Q==;
X-CSE-ConnectionGUID: W3a5tcAAR4SmhhFO5OGbew==
X-CSE-MsgGUID: NE2Q/sTERymqCkH53yD8ig==
X-IronPort-AV: E=McAfee;i="6800,10657,11755"; a="88229167"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="88229167"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 06:45:56 -0700
X-CSE-ConnectionGUID: 5EGNTPxSQP+GmiqHTb7hcA==
X-CSE-MsgGUID: poU0WXXBR3aVBOf3UOJDiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="225932507"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.248.249]) ([10.124.248.249])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 06:45:46 -0700
Message-ID: <9db9515b-08e8-47bd-aced-206ac183195a@linux.intel.com>
Date: Fri, 10 Apr 2026 21:45:43 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, x86@kernel.org, iommu@lists.linux.dev,
 Arnd Bergmann <arnd@arndb.de>, Michael Grzeschik
 <m.grzeschik@pengutronix.de>, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
 linux-crypto@vger.kernel.org, Vlastimil Babka <vbabka@kernel.org>,
 linux-mm@kvack.org, David Woodhouse <dwmw2@infradead.org>,
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
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org,
 Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>,
 linux-openrisc@vger.kernel.org, Helge Deller <deller@gmx.de>,
 linux-parisc@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, Paul Walmsley <pjw@kernel.org>,
 linux-riscv@lists.infradead.org, Heiko Carstens <hca@linux.ibm.com>,
 linux-s390@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 sparclinux@vger.kernel.org
Subject: Re: [patch 09/38] iommu/vt-d: Use sched_clock() instead of
 get_cycles()
To: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20260410120044.031381086@kernel.org>
 <20260410120318.187521447@kernel.org>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260410120318.187521447@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.intel.com,kernel.org,lists.linux.dev,arndb.de,pengutronix.de,vger.kernel.org,gondor.apana.org.au,kvack.org,infradead.org,plugable.com,mit.edu,linux-foundation.org,gmail.com,google.com,googlegroups.com,alumni.ethz.ch,zx2c4.com,linaro.org,armlinux.org.uk,lists.infradead.org,arm.com,linux-m68k.org,lists.linux-m68k.org,southpole.se,gmx.de,ellerman.id.au,lists.ozlabs.org,linux.ibm.com,davemloft.net];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34618-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[49];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baolu.lu@linux.intel.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 2311C3D856C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/10/2026 8:19 PM, Thomas Gleixner wrote:
> Calculating the timeout from get_cycles() is a historical leftover without
> any functional requirement.
> 
> Use ktime_get() instead.

The subject line says "Use sched_clock() ...", but the implementation
actually uses ktime_get(). Is it a typo or anything I misunderstood?

Other parts look good to me,

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

> 
> Signed-off-by: Thomas Gleixner<tglx@kernel.org>
> Cc:x86@kernel.org
> Cc: Lu Baolu<baolu.lu@linux.intel.com>
> Cc:iommu@lists.linux.dev
> ---
>   arch/x86/include/asm/iommu.h |    3 ---
>   drivers/iommu/intel/dmar.c   |    4 ++--
>   drivers/iommu/intel/iommu.h  |    8 ++++++--
>   3 files changed, 8 insertions(+), 7 deletions(-)

Thanks,
baolu

