Return-Path: <linux-wireless+bounces-37270-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNKxNMS2HWrKdAkAu9opvQ
	(envelope-from <linux-wireless+bounces-37270-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 18:43:48 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D686622C1B
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 18:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2DEF13014AB2
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jun 2026 16:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E480E310779;
	Mon,  1 Jun 2026 16:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P/vNU1Od";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PtaSyuwP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A812F5337
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jun 2026 16:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780332225; cv=none; b=AXYr5txCDtbevLIYa9JZFi/cBNNao8sdjCffp3IjAHgp3shtFw27kH0gx7IWFn+E2XQRhvYQoXax7gs9CvX3mTdMIxNq/e5w/JxHBek6LlcL45sxOnbafi3FXLNa5nRHsyO7qgi6rK8oiQ3hC6i9gimR1VuXsOtlFEaPqESwFyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780332225; c=relaxed/simple;
	bh=UlXEm+i+k44CyKC5aSYUVFRZQA/jHSrahJnL46L456E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=clqxq1pgWEW8KThlueK1tm2nwysMpFjFW6JpHv/91lwC+JuDtYkJ3xfI7f34cCMNNmc2p8fNHzJcPGjNHpeLJZwWc7qelxgVWgIOX9u4KVTP0mzPRe0mbzs5kf32D9dqNufvuXB5Y3ZKmguUoJv2Ethw6GZssudfFHSaHyAqmDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P/vNU1Od; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PtaSyuwP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 651GLeOZ3372624
	for <linux-wireless@vger.kernel.org>; Mon, 1 Jun 2026 16:43:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WtiwZwpjkTnh2Sai/6GSgEosRHj71tYSabTEvDWIVr8=; b=P/vNU1OdypBYaTYN
	7HRGLgW9SNKj/sxjM2AScepTvqf1G9sMBJFqA9DcylgozKTIpn6COWMZdYl/by+L
	FsiVaQjYCKbg+0LgRKrxX+oN8cvzDegcvZAXDGdszPJDZH12LDWabgh36s+T2Mqs
	I5IiIIzT7c5E3JhILSMyYFfCgjDz69vdzttYiLpTtKcaKZI22WB9fzAnlDKjRZkB
	KZsh1wZHMlMR8BinRz9Xe9KsB/culnKLSyP5PQtoJK+MIKeETzbB+tVCZl4p/K63
	YrjeqgkVMuCEFTQgVYAkpGfxKXGc1RW3iV9L7IBj7gpJ2VQD8ki7JRt4QXHHGA8P
	B2Ukxg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh7jh9tav-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 16:43:44 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-304dd917645so3748227eec.1
        for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 09:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780332223; x=1780937023; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WtiwZwpjkTnh2Sai/6GSgEosRHj71tYSabTEvDWIVr8=;
        b=PtaSyuwPZ3XGpE0z+4TBthpSjd5FKN7hsctfL+eGP1kQHpsPUDESzfH9NFwBFFdMNH
         rWwOdbTkJxPATo0adD0vHAizWdHaZzJBljCbLkz/CRCWxWwklDTSjRTP/RrZAH3FW0ge
         0kZu9ai4pSbKnINyN1Z/cWLqGZ1U6e3dNl7wM8r6EBNK40oNlh9YnhPqsPyBYVVVR2U/
         yCEp1za7O7fKK5wHNSNB6Z1n2tTI9LZVTclQXP6PNH4FjfQo+t6PIAP7g232ReB0Q1AK
         I7WXmQI+bNFBTlubQv5MbC4hmNkXQb86sWPsP9RDBbzvwBHa7O0Q3/VoudjuJ1qAssGK
         Mh2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780332223; x=1780937023;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WtiwZwpjkTnh2Sai/6GSgEosRHj71tYSabTEvDWIVr8=;
        b=e2n3j7evafL/Tb+nS7HPXqfou2vrZGgENAajB5CWmM2gl5mI3mX2FpPJm1zeKYWCI9
         MiCi+N0wlifS9zGghjIN6n4p1xISL1RuXBy40ZhOamXSr1CRK/PBhQe1BKhmLBIZL2kJ
         3i/vuHro1NLiSV6lcyyMOtPSuiJKZmKKbrFbh/vqpDnsaHKkBfe3kgbSAugSEYah4z48
         qJWwYe7Nq2KtYjSGuMLBl1eDinHJKiVfmJqtTeBgLG47cHu2B34dqnsTUUm1F27NTb2V
         5wChRA4UCB3gxCrgJ2f7f9oJ39JJ/AX9Itc5ZsZBAGKFkJS27Ygk/GoJC/jOhSD8TDte
         9bpw==
X-Forwarded-Encrypted: i=1; AFNElJ84zx88XLHWcLgV3tr4GcM7QdbUEfBPE2/mBoq3VXIMLBf3Ha2/WuyVxhDJpenX0pwNi7XpnYYy8QLbjPWTLQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxNXZV41iTn0GE4Tbj29T0UDK/Wncf8q/jzKpp1DqVvRynwQ7r1
	+S1ZNKHZbk1y0ogqQWbXnfk21ewmVK3DpA+7TBSH7NT3vzBXb5EST0Qx1Z5tDfNi3bP/DkD2loV
	v4P6+YWaKMdJDZ7jLdlbgcygzz/2FqFSNuQBUnCNwDzKejoScqzebc5eKlOupAUVDpgh0vg==
X-Gm-Gg: Acq92OFWzhuHx3LOaLq/SPwH9yZtKjqFGRQ9rf/FKn5o2tveA4JVoC/E3rfhHzV742m
	N1GFXWOy3W1+KQPhxK6r+VKJKk0jO/2AbbN6YUOc+4eC5LsbW6qQRMRe+1KMi/qvk7r7miYlhbO
	VnhydI70YIYwXfmHZwjgfwdnu7BPU9O5QV8xM+YeuDsepdQWQtXpD6z2cTQcwGneIHkCsCznMx6
	Ffl5HRwCnrILGjHsR7k5whPpsvZfBS0iqa/eUNjXC9yLcYpLoGhRp8Q/Tm/BSeEX8bB2CrLDzkh
	nGsaUd97z3xaptEY3qBQhzxfe3y2r1guxFhR78ROBM0gUhdhfF66QyvmiIoMD9jedUFrytH/zM0
	9mNeBdgRZ0p9CaTy+Kyqn12zYowzkDdMPbh6QkAFiNOSpHY/Jl2InbNuselnNrayvqFLaJED7kc
	rKDrSbyaniFyUkjxEd
X-Received: by 2002:a05:7300:e58b:b0:2f2:5c68:5074 with SMTP id 5a478bee46e88-304fa5163f7mr5520140eec.13.1780332223355;
        Mon, 01 Jun 2026 09:43:43 -0700 (PDT)
X-Received: by 2002:a05:7300:e58b:b0:2f2:5c68:5074 with SMTP id 5a478bee46e88-304fa5163f7mr5520118eec.13.1780332222761;
        Mon, 01 Jun 2026 09:43:42 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed2bdda4sm8487913eec.2.2026.06.01.09.43.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 09:43:42 -0700 (PDT)
Message-ID: <a28df759-d0e9-41c0-97c7-5f89a18d54e2@oss.qualcomm.com>
Date: Mon, 1 Jun 2026 09:43:41 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: net-next 32-bit clang build error in net/netfilter/nf_synproxy_core.o
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org
References: <20260528123911.284536-26-johannes@sipsolutions.net>
 <178001352190.1565998.2039430206651171575.git-patchwork-notify@kernel.org>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <178001352190.1565998.2039430206651171575.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: pTFlQpabwprMny5d4VbRIdqB1bNm0Et_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDE2NiBTYWx0ZWRfX6kOwwFhCseil
 G9mQpl00ZeGifhrIE+GzedTjB9tzeIQ1Ln3hhVPkVloVP8DuCL1HY9/jodngBxUHXRNCxKO2NHu
 3Nmt29hdlytLXgBGy7KCnXqz4RJ8zzj6gG+IsrXZLjnNnb0/vP1LilHeAp2AeVUz9PNDKUCRjOh
 mYfRCYxYRyvfShE2bk52nIkvqbok1TcJ/T+lRrnh+8rw4XHxdzl4voQRbB5E1f6nbn6Px59vvKw
 hWS3ijEEhNWlqs+DVoOXjmOqrCN26wVq22Xe2Lfar/tBTQ0Hj1nJqUKVv3Ud+YQb8Ao6atf6BHy
 GYdR9Xl9G2/C4g4IWT+ya/YGU8UiTz8/9WT/t5IK2hdCzvYEGFBcrJ3oA/2fqLwOn3CmGpmRASJ
 NTMe+SWSwEaM7XwJgnuiv1Izf9+VlhDx5cK9+nw1DYb/HG/JtUM9n5hP6niHGBgGd90mU+WDWp1
 nyfzU605NMEI7q11O9g==
X-Authority-Analysis: v=2.4 cv=YuY/gYYX c=1 sm=1 tr=0 ts=6a1db6c0 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=KXNP7wE5b9nUYBElON4A:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: pTFlQpabwprMny5d4VbRIdqB1bNm0Et_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 phishscore=0 clxscore=1015 impostorscore=0 spamscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606010166
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37270-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6D686622C1B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/28/2026 5:12 PM, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
> 
> This pull request was applied to netdev/net-next.git (main)
> by Jakub Kicinski <kuba@kernel.org>:
> 
> On Thu, 28 May 2026 14:37:26 +0200 you wrote:
>> Hi,
>>
>> Here's a new set of changes, mostly ath and iwlwifi
>> drivers this time.
>>
>> I have a few more things pending, and I expect a few
>> more drivers will have pull requests later too.
>>
>> [...]
> 
> Here is the summary with links:
>   - [GIT,PULL] wireless-next-2026-05-28
>     https://git.kernel.org/netdev/net-next/c/e7d6bd24e883
> 
> You are awesome, thank you!

wireless-next/main has fast-forwarded to e7d6bd24e883 and I'm in the process
of also fast-forwarding ath/ath-next, but I'm seeing a build failure:

In file included from ../net/netfilter/nf_synproxy_core.c:7:
In file included from ../include/linux/skbuff.h:26:
In file included from ../include/net/checksum.h:21:
In file included from ../arch/x86/include/asm/checksum.h:9:
../arch/x86/include/asm/checksum_32.h:149:6: error: inline assembly requires more registers than available
  149 |         asm("addl 0(%1), %0     ;\n"
      |             ^
1 error generated.
make[5]: *** [../scripts/Makefile.build:289: net/netfilter/nf_synproxy_core.o] Error 1

This is with "ARCH=i386 LLVM=llvm-19.1.7-x86_64/bin/"

I use a config made via: make $allmodconfig

A lore search doesn't show any recent instances of this issue.

Rebuilding from scratch shows the same issue.

Any thoughts?


