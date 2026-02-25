Return-Path: <linux-wireless+bounces-32165-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKt6JK08nmkrUQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32165-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Feb 2026 01:05:01 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 063F918E45D
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Feb 2026 01:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DDDC4302515A
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Feb 2026 00:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46AC2BCFC;
	Wed, 25 Feb 2026 00:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j3He+aK/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JmfTy0tu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719F93FCC
	for <linux-wireless@vger.kernel.org>; Wed, 25 Feb 2026 00:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771977897; cv=none; b=B8gMguK1B9d4WJf6M70kkQ7EdDg7h4AxqjFDTGOHVN+GLEHt5pqZ94SFLgKfo8kHLz0bwbSOB3c/4dlNUipM8zipr7QVozRNRfPEZpZYiGguWmdsCxdP0tJg+wGzkSbjlUgQp42v7dlKKcsliEBut7wPyn3SgDeuI7g3QZmBL/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771977897; c=relaxed/simple;
	bh=dW7lqqXeBT5oEXdn7ctK5Si1uatIa8OOl9uOANxDvvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gmrPIHsBrmgTQsmwPWg1QmFNvfD7nhGuin/T+jXotarTgV9OmOSzVtYG9C4sZjLIwDGpjFmeuhGplmmlFmygF3ePqTLUiyuhUnR/X+oJtNPxjP1DfHTiIjKRjmsDORdOMKxQ0jtWRvIsjVOIu46a2MfiPXFcfpQSEShIkQyYXI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j3He+aK/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JmfTy0tu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61OH2VGe3660095
	for <linux-wireless@vger.kernel.org>; Wed, 25 Feb 2026 00:04:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bPgRkd6Joc2i9hnEq7xsKy9CSR31CuQJjlbadD/0CKw=; b=j3He+aK/7leYcnvM
	m6nTDtOb2NfwpDnhUWwYdACKbE6Sn37SuCuI63Ur+XkfDpFA2klz0g+vEQXoUNAu
	6yOBCdH+bsYh8oJFPT2DG2LRibPlmJM9HjOTCIngkeUP2ODWg6HdFHFlnukolTL2
	FUiySzQ3oWTnNjZ5/2ha/xpOLavygbwFJ4tL50Hyhnr28yHuBK4SfVtq0h0dyjar
	VqRicQ8dLK4iuFln73s6f+Cy7EJ72WBAN8M7MZ8So+2c7J8diKYq8+DeA7GMmUW0
	T5HxVoLNqA2BMk560Ofd11oTOu69HJ6esN7ukuuC/PEexmW6FrqzEzzSpvsG+xaS
	wUyG/g==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4chg1s9ar9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 25 Feb 2026 00:04:55 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7d4cb5810a0so39235838a34.1
        for <linux-wireless@vger.kernel.org>; Tue, 24 Feb 2026 16:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771977894; x=1772582694; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bPgRkd6Joc2i9hnEq7xsKy9CSR31CuQJjlbadD/0CKw=;
        b=JmfTy0tuWEU6rwnR8XqMwCYeVLZEGJSfIrmMMV3cyAnoFqfWQAUuh6AqlQOJQIREy8
         6VlxRRNI/XJzuqyaKSRrDFpa2M4gDdcgr+IZ5JxtawW8oLZvoxO5jUhXFZzMrmWlYeNh
         Sp7p8SZ9CCfMcbfbdMqm2PezmGUEalUBUAPlNciv1mPembdFLWWBAOrCsSzb/UYKrpfl
         sQqGzEc7xRvPpUvFRw0maywMMERHzFrmjOIcJ9Gcfuc5u63GVlC2t8h6tKCXSCKLRLiv
         BIfs7BjgTMLeMcccDCzFhzO1yGnZrPe2bMEw6KqJ6q0fTNbtejJnyodrAIc36WeDv4NY
         UHQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771977894; x=1772582694;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bPgRkd6Joc2i9hnEq7xsKy9CSR31CuQJjlbadD/0CKw=;
        b=bnfQ/zCmPzbsloFbLpmILwwrWymAN/J9rsTOrt8HfW2Nvudwqlbf0Zj8VGtxSX6Iv1
         WJ70L9l4BzK8jqNIEWRGCJ3i1gGhPDPEoO1q1+fwzeOGrz+Ccx/cFQbU7R+quqkK69HG
         dzr+Boly/aJNJMGuntb7S74Zr65SDKN2Mr+ml4cKm/4KYxcY6zGP96yTElmqbKe8BBCB
         l4s6DX3hvIEFilmayHDxLslIrKcZ6Y4/a41Q3R1ks+NfxAQXdaG6bMwOvVOEhsib9nUc
         swH1zvCWLzfhZ+2ub+O9x7DkG+dNoLUgdvD8h+0hDeDgThauLZggVetG5O6AH0aiAyaM
         mYyw==
X-Forwarded-Encrypted: i=1; AJvYcCX6r1GiIhiWSdsZwu6Uao70tHo2UE4FQSrSSt+ePT8bhxotyaWRsiFGKbiqFKsbsmVFTjXVe6lfy448M9tfnw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxfV1glu89Rn0uKpFsfUVNSAdPv3OzQANLojzWpJpb5d6d8rWGe
	OEmeREG5PBSS0IgoUw8V3zyVz+g0jx2PI+viubwV+xqUAd2NsYWfsK6UfPHXBqIzZ40Xak6aAeh
	VuYdoVUxy8d5GD/w+ivYZpWG6smxIyW1fc6A9mEx+szBfcGw6lv6quYvzLJQXEVjquOb/U0Hjsd
	W7Lg==
X-Gm-Gg: AZuq6aL1J+euSzG9MwmPeU9dkNHFaWyLs/PkE463cTfQ6Iv4Cz8Bk4ACzWjOmOYA+U0
	TVe6R8CjRWNIRM/j1lKLtJ1rstxfYxl3SY/2pZgFWC2MaYtqQ7kCdnRCHYAlKMhOVdcBuRqoQpN
	rz0X5m27huKDUo1LxZIEUFO7CgNw48ikvieQgubjCt22D3ReidExAJzflHXXHKbb6HdVWwplobC
	Yg9L8+DOY+zzBW/Aji1crA06k/mULKcdCVxlzcKWUe4NqIgdW9/c6MJHT89DyT3e55FfY/0PDgC
	HpOh80qkg5t9eMycQxvswRDa+aFtZ93xO96pwZhnQXMbEOJcuIGHbLHueKBJdbCntwKbCL30bgu
	R6JpcqsH+11D2fZjkCWjMxBZaRXVInOShQevJz5rHcDGNwKvkfpJm3uDz4uLaGPatAtest0hJK1
	FoY1CeQgom4z/How==
X-Received: by 2002:a05:6830:d0e:b0:7c7:6bb4:1197 with SMTP id 46e09a7af769-7d52c2c9255mr9993057a34.24.1771977894507;
        Tue, 24 Feb 2026 16:04:54 -0800 (PST)
X-Received: by 2002:a05:6830:d0e:b0:7c7:6bb4:1197 with SMTP id 46e09a7af769-7d52c2c9255mr9993044a34.24.1771977894077;
        Tue, 24 Feb 2026 16:04:54 -0800 (PST)
Received: from [192.168.1.41] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d52d038b5bsm11076612a34.14.2026.02.24.16.04.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Feb 2026 16:04:53 -0800 (PST)
Message-ID: <2ad609dd-bfbc-4af8-88e4-9576708c156d@oss.qualcomm.com>
Date: Tue, 24 Feb 2026 16:04:51 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] wifi: ath9k: Fix typo
To: Alejandro Colomar <alx@kernel.org>, Greg KH <greg@kroah.com>
Cc: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        linux-wireless@vger.kernel.org,
        Rajkumar Manoharan <rmanohar@qti.qualcomm.com>,
        "John W. Linville" <linville@tuxdriver.com>
References: <6ab107cf786f9d05dc4d84ea4e2d1b219ce108c0.1766355822.git.alx@kernel.org>
 <871pibo5fj.fsf@toke.dk>
 <8beecde0-1280-4852-bb82-120590347fb3@oss.qualcomm.com>
 <aZ4Wq6h-nMt-G3pC@devuan>
 <5e01a680-ebbc-4855-b1f9-e0381b3a8fc8@oss.qualcomm.com>
 <aZ4r6OUVCiHE-hhZ@devuan>
 <0b9635b8-05ee-4ae4-b4eb-9b83188a0917@oss.qualcomm.com>
 <828b4d9b-268f-4f7c-ab7c-51aa49c0bde2@oss.qualcomm.com>
 <aZ4xt0TIscdxhseW@devuan>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <aZ4xt0TIscdxhseW@devuan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ZKvaWH7b c=1 sm=1 tr=0 ts=699e3ca7 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=dZbOZ2KzAAAA:8 a=NZUTPbpSSALN-5B4fF4A:9 a=QEXdDO2ut3YA:10
 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-GUID: hjeSJHndgj-JJDijIGkv69DKJGmgu3Ka
X-Proofpoint-ORIG-GUID: hjeSJHndgj-JJDijIGkv69DKJGmgu3Ka
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDIxMyBTYWx0ZWRfXwfiLfj3nyYug
 4qr665s9/RLAl1RZhMP/5vtLiB1zgnyZO8mPyC4kCb47GiP4B+WpysO3ww+CLh6BPKZFglNddMX
 0IJrGClaN3A7Ks/q3nZWFcD6aj32MDcPW7V8PmvhnLJbRYlcHzbcBa28Sx3Z3gWCpz9Mgq44v+0
 8eoZpF/nGkpPg/OpGwp42UB/pSjxg5731LtmjKpOrBG4pH+OB/vzpgIAK+z6NJ0rkmr45bMy86L
 ea+T0ZYaFFgskjN3bQncOgufyoyUumNji9pbEIQxYNGdmPeUq8djmGxQKngVxcz4TUfwuAwoJvV
 MgdV7eilrLqOYBTyG8zEm5pCYLR8vLbmRb90I9+BkiqvAVQ41uXxS1jxon2qcI5fXUebE+UdwaR
 jIIE/dbZgBx04s+PgdYlZxuaNue+0B2CVjwqSAsfuHlDo9KqKI2H1uBESoBkuTC6i8rcFfJwQCv
 KI3+CTcDqvzS2oUoTfA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_03,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602240213
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-32165-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 063F918E45D
X-Rspamd-Action: no action

On 2/24/2026 3:23 PM, Alejandro Colomar wrote:
> Hi Jeff, Greg,
> 
> On 2026-02-24T15:09:05-0800, Jeff Johnson wrote:
>>>> I don't know where I keep the patch, so I'd have to apply it from the
>>>> email to resend.  Could you amend it yourself?
>>>
>>> sure, I'll amend the patch in my pending branch
> 
> Thanks!
> 
>> I've also updated the Fixes tag to meet the expected format...
>> Fixes: c4dc0d040e35 ("ath9k: Fetch appropriate operating channel context")
> 
> Greg, I CCed you in the man-pages thread where I discussed adding the
> commit date to the Fixes tags.  I was interested in your opinion, and
> also think this could be useful in the kernel.
> 
> <https://lore.kernel.org/linux-man/3a656e90329f26d743d0904f56ae847951c852c7.1770150003.git.alx@kernel.org/>
> 
> Do you have any opinion about this?  Should I send a mail to some kernel
> mailing list to propose its use in the kernel?
> 
> The format I used is documented in the Linux man-pages here:
> <https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/tree/CONTRIBUTING.d/patches/trailer#n16>
> 
>     Fixes
> 	Add 'Fixes:' tags as necessary.  'Fixes:' trailer fields should
> 	have the following format.
> 
> 		Fixes: 12-char-hash ([author-date,] commit-date; "subject")
> 
> 	where the author date is optional, and only included if it's
> 	somehow important.  The commit date is often more important, as
> 	it's sorted, and thus can be used to find (with a binary search)
> 	a commit whose hash and subject may have collisions.  For
> 	example:
> 
> 		Fixes: bb509e6fcbae (2020-10-16; "kernel_lockdown.7: New page documenting the Kernel Lockdown feature")
> 
> 	See <CONTRIBUTING.d/git> for how to configure the alias.ref and
> 	alias.ref2 git aliases.  The commit references can be produced
> 	with them.
> 
> 		$ git ref bb509e6fc
> 		bb509e6fcbae (2020-10-16; "kernel_lockdown.7: New page documenting the Kernel Lockdown feature")
> 
> and here:
> <https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/tree/CONTRIBUTING.d/git#n46>
> 
>     alias.ref, alias.ref2
> 	To produce git commit references, the following git aliases are
> 	useful.
> 
> 		$ git config --global alias.ref \
> 			"show -s --format=tformat:'%C(auto)%h (%cs%x3B \"%s\")%C(reset)'"
> 		$ git config --global alias.ref2 \
> 			"show -s --format=tformat:'%C(auto)%h (%as, %cs%x3B \"%s\")%C(reset)'"
> 
>     core.abbrev
> 	Use 12 characters in abbreviated hashes.
> 
> 		$ git config --global core.abbrev 12
> 
> The Fixes tag I used in this particular patch was
> 
> Fixes: c4dc0d040e35 (2014-06-19; "ath9k: Fetch appropriate operating channel context")

This format doesn't conform to the format described in:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html

And it fails scripts/checkpatch.pl

Review the comments from when a similar change was proposed (including a
response from Greg):
https://lore.kernel.org/all/tencent_F8CFC8ED723F6E8103B4AF3D98D63D7F1F08@qq.com/

And referencing a project which you authored as an example of how to do things
doesn't give much credibility. Please follow Linux kernel style.

/jeff

