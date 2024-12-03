Return-Path: <linux-wireless+bounces-15863-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7659E272C
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Dec 2024 17:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4DC028975F
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Dec 2024 16:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BE71F8AD6;
	Tue,  3 Dec 2024 16:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="w68KKUgr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3641F8AC1
	for <linux-wireless@vger.kernel.org>; Tue,  3 Dec 2024 16:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733242944; cv=none; b=ADnExwA7jJV5yNUdbEjlvab7EJ2lXMqulI1ijj8qhQaeNt3+5Ap/6FjSTUrRCsNfuI+gx6NXZZTCMyZH5fjuA9Xlg5qpEr5VhjFrovy4GMHom7DW1CIA8a8M4FcbkZckNpDHv/dbjq0wS8nyLPYK+r3oLKoCsLkZ7GkPqYnF5zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733242944; c=relaxed/simple;
	bh=MAMb3InXzNtxIVC9mpD36wC7DiH6bFIuVagB1fhWAqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H3x88KAJlmxo7oslbq3rqyy1IJubibcCZvCSjgDBRXzjTXubjraJLyOqQ3b2u7ntr+6Mcr6DyOg2H1XNm4Evu0S90anjrOvntHGU/wDVkkKYeT++iCnAaj0OSc1cyzg884I3LY4vhDqaW7sDsexBn1pdQLMhP4RfOGr4WuVPZuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=w68KKUgr; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6008a.ext.cloudfilter.net ([10.0.30.227])
	by cmsmtp with ESMTPS
	id IVYcttAHNvH7lIVdmtipHn; Tue, 03 Dec 2024 16:20:46 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id IVdltLsa9NWjnIVdltCZLY; Tue, 03 Dec 2024 16:20:45 +0000
X-Authority-Analysis: v=2.4 cv=dOagmvZb c=1 sm=1 tr=0 ts=674f2fdd
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=GtNDhlRIH4u8wNL3EA3KcA==:17
 a=IkcTkHD0fZMA:10 a=RZcAm9yDv7YA:10 a=7T7KSl7uo7wA:10 a=mDV3o1hIAAAA:8
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=YY3CVkhoXc6STAsvKmAA:9
 a=QEXdDO2ut3YA:10 a=J6ZU--GpMfYA:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=U74Ds+GFctnV/vlAbJcubbjqMwBEGmBMo13rCZz9JUQ=; b=w68KKUgrX01H8mxitVGqv0lS0F
	B2ZzyNafbaYy6VjpmAnU6+vQTyJKoP+6NadRddjvX9w3PIkMHhpzvhftrt/dYchj4yjwtWjYPPqND
	K9/QV6MPnGW8N4HZmBrpPdNF0sbatbLkJrR27cIhC0oIbUqt91oghFJBXIIRH/Vf4AI8CCDv7A5ny
	e1p9spRgJJOIfvhg+SjxQbMye8R5XUhot8+lmEQxFf7cM8lv2lodKc9908l86r69hGU25N/3YvbfT
	Je5UdHwow0NTbZXsNVFKDgaq6QW6tUuoxH6T/1tNSUhAWnW1MkNLiNUCjHLhFko71M59FJgUqcCqH
	Ii7TGyzQ==;
Received: from [177.238.21.80] (port=15554 helo=[192.168.0.21])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1tIVdk-002GvY-0s;
	Tue, 03 Dec 2024 10:20:44 -0600
Message-ID: <238df0b9-d1db-4f72-8238-828ea20ad1d9@embeddedor.com>
Date: Tue, 3 Dec 2024 10:20:41 -0600
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: wireless: sme: Initialize n_channels before
 accessing channels in cfg80211_conn_scan
To: Johannes Berg <johannes@sipsolutions.net>, Haoyu Li <lihaoyu499@gmail.com>
Cc: Kees Cook <kees@kernel.org>, "Gustavo A . R . Silva"
 <gustavoars@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, stable@vger.kernel.org
References: <20241203152049.348806-1-lihaoyu499@gmail.com>
 <fa9ef37903db0f81654451104b1407f60f85ce5d.camel@sipsolutions.net>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <fa9ef37903db0f81654451104b1407f60f85ce5d.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.21.80
X-Source-L: No
X-Exim-ID: 1tIVdk-002GvY-0s
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.21]) [177.238.21.80]:15554
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfNkb9o14wqW4aLAwkUU6Jxc83StYMWaj+l3SE9r5Ho1KcZfBHK0OAL97TY8bvcAfW2cLS5vtLUnla2JrmdyfH2fHzbsjvSe0bk8H7biL/p4+zhL2uVAs
 2i/So6o7FVsPpTUIlxQoJzwQ44T7a0Rqp9/1v3EPmxheuKBsMmQ24LTxEGaoue1WKhfDUrfNj3Vp3Y0mai7I2UqGoY6kufOfLgffA1ubFx91ubAsGNIhVQdH



On 03/12/24 09:25, Johannes Berg wrote:
> On Tue, 2024-12-03 at 23:20 +0800, Haoyu Li wrote:
>> With the new __counted_by annocation in cfg80211_scan_request struct,
>> the "n_channels" struct member must be set before accessing the
>> "channels" array. Failing to do so will trigger a runtime warning
>> when enabling CONFIG_UBSAN_BOUNDS and CONFIG_FORTIFY_SOURCE.
>>
>> Fixes: e3eac9f32ec0 ("wifi: cfg80211: Annotate struct cfg80211_scan_request with __counted_by")
>>
>> Signed-off-by: Haoyu Li <lihaoyu499@gmail.com>
> 
> nit: there should be no newline between these
> 
> My tolerance for this is going WAY down, it seems it's all just busy-
> work, and then everyone complains and I need to handle "urgent fixes"
> because of it etc.
> 
> I'm having severe second thoughts about ever having accepted the
> __counted_by annotations, I think we should just revert it. Experiment
> failed, we found ... that the code is fine but constantly needs changes
> to make the checkers happy.

Thanks for taking these changes! - This is improving :) See below.

"Right now, any addition of a counted_by annotation must also
include an open-coded assignment of the counter variable after
the allocation:

   p = alloc(p, array, how_many);
   p->counter = how_many;

In order to avoid the tedious and error-prone work of manually adding
the open-coded counted-by intializations everywhere in the Linux
kernel, a new GCC builtin __builtin_counted_by_ref will be very useful
to be added to help the adoption of the counted-by attribute.

  -- Built-in Function: TYPE __builtin_counted_by_ref (PTR)
      The built-in function '__builtin_counted_by_ref' checks whether the
      array object pointed by the pointer PTR has another object
      associated with it that represents the number of elements in the
      array object through the 'counted_by' attribute (i.e.  the
      counted-by object).  If so, returns a pointer to the corresponding
      counted-by object.  If such counted-by object does not exist,
      returns a null pointer.

      This built-in function is only available in C for now.

      The argument PTR must be a pointer to an array.  The TYPE of the
      returned value is a pointer type pointing to the corresponding
      type of the counted-by object or a void pointer type in case of a
      null pointer being returned.

With this new builtin, the central allocator could be updated to:

   #define MAX(A, B) (A > B) ? (A) : (B)
   #define alloc(P, FAM, COUNT) ({ \
     __auto_type __p = &(P); \
     __auto_type __c = (COUNT); \
     size_t __size = MAX (sizeof (*(*__p)),\
			 __builtin_offsetof (__typeof(*(*__p)),FAM) \
			 + sizeof (*((*__p)->FAM)) * __c); \
     if ((*__p = kmalloc(__size))) { \
       __auto_type ret = __builtin_counted_by_ref((*__p)->FAM); \
       *_Generic(ret, void *: &(size_t){0}, default: ret) = __c; \
     } \
   })

And then structs can gain the counted_by attribute without needing
additional open-coded counter assignments for each struct, and
unannotated structs could still use the same allocator."[1]

These changes have been merged already, and will likely be released
in coming GCC 15.

For Clang, see [2].

For the kmalloc-family changes, see [3] (a new version of this that includes
the __builtin_counted_by_ref() update is coming soon).

-Gustavo

[1] https://gcc.gnu.org/pipermail/gcc-patches/2024-October/665165.html
[2] https://github.com/llvm/llvm-project/issues/99774
[3] https://lore.kernel.org/linux-hardening/20240822231324.make.666-kees@kernel.org/

