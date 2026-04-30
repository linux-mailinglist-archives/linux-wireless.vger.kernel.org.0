Return-Path: <linux-wireless+bounces-35735-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oD7uGYjP82nq7AEAu9opvQ
	(envelope-from <linux-wireless+bounces-35735-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 23:54:16 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 072654A866C
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 23:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2CA7D30055A7
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 21:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A78377EC6;
	Thu, 30 Apr 2026 21:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IdEFwmdN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cDKqWGp2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3D72ED843
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 21:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777586054; cv=none; b=ZGT8zoZzj3JFf2TT2KPUH6h1D8m0W3emd/eMJMSxKK07LDJiwuJFkQPVf4sE6XUfmsMCPjYO/CLjJbFbYCKT98r7DVS3/chrgQ0yX1g/ZUF9rroT0j+rKFnbfb9CHkgcM0zvcLV6HlYcqXSrdYiqVbjdw1eE2OMvxtosophp57U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777586054; c=relaxed/simple;
	bh=19pnxUof1ycnmITgNaNjk9W74SaTYBGPWwHro6KH8V4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ns2S3hdYX4XbetZLCGc+lCntsIww+EdeWlx/BGwhky6wT5MInvTiFDFJYA6u6LPyi8IgodEn1xFY7NPC7i4oicZx4UIo3whR3mGdmqgryzadJltkhAZ/cNd+XKeAdzngRRQegSjOWSDwSzAQyFUi04Q1EDJl0ByDIE/eCRUXyQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IdEFwmdN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cDKqWGp2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63UFSqRW2099721
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 21:54:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oD/hwFjD2LNpSn907GkM770fKxCvjrV9J6VUXwvJVyk=; b=IdEFwmdNbwRqQAUT
	vAqHPqSgxaw7LsSVuvKhZPLpEAHKjn1Ki6Jnqqrk1QvKXji/phDgmnlL8tHKULUE
	O9hdHa+4lDOjdkmCs/YnSTmcA5Ud76ozHgkaBSLyxTLv+ZF9utMuLofw/3rqmz3C
	JX82xY+bbxh1IWwrbxNuM2viPwOVg31LCfUZa+tbBoI4kJGsNbJrktB9WZqKVQYR
	6wxQz+caN++kiHQz7+IUhRRvmYd35ZJunzBZztaP3dn+tdldDq8kppgEAqnlHpM4
	exMqdREdWtVeUfQ0Pw8YUzzUBdfMJvlB9SE10AIID8JB3aykpOG6NpIBU9U9c74Z
	0ebbdg==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4duyr44fr7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 21:54:11 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-12c8de02a4dso8047052c88.1
        for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 14:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777586051; x=1778190851; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oD/hwFjD2LNpSn907GkM770fKxCvjrV9J6VUXwvJVyk=;
        b=cDKqWGp2qo4HMADaYLdUVN8xwx85JD1CSpeVwfTqbxE5VH4C2ag6oIpG0X8U17PFdP
         3DiMGmKu/yoKMpeGEBhXwRwwJujuxn5OEfSq2Xe5FTLIJ3MNvoNFb1zyUKTrViwC+qRx
         5qrLGb0aTSxujkxY10MWCnlfhnCU3h3Ic5uFOS3HR3ZxQU3XgDhJwQAgjgBWsi2lBM9i
         2XouLC1GaiXCaEQ/CXQ+pLJ9t6E0vqXuv3UmSb5dczxk0CEYXCCKbvmD3VomyRghPsXM
         0Sg94ByKXzvGadLJARTD6d0VzmcCRyoamFe3cLMwtKDEc+FBDdkFx/P7Shww5VXgQ41L
         7jVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777586051; x=1778190851;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oD/hwFjD2LNpSn907GkM770fKxCvjrV9J6VUXwvJVyk=;
        b=Ok9aqRPpuDvCLbAFk/EEb1qG1tgqauE2nP1ant+jsyLAYqkgcx+PqP9g2IS5Vm2sTP
         YAufzu2HEi2LX5SK1i/Y4nbbIJ7b/PhcIP0hTKa/YSUqU0MJfO68ULMGaqxmFDyQYCwm
         F7M3VEkDsB5PKehlmu9zUJhwcg4hE+oVDwr2LMhAc0Wm+Gxs2PCA+pf5Tl9m9dvmuf2E
         nQaaJqVHNZnWJPVXTqM4atyE1dI7Zi5hH05nQWEudWWC3yYF+zpr8fPOfDoyD7JOdoFf
         GDc6EPlea7b/YhJfx6JkPoOHOntP7rqG4cWFB462GUhdXvraUeopfWtARlEH4qND/rnb
         Rtxw==
X-Gm-Message-State: AOJu0YyMLGe0+uuPWURgjbkAuKHhnmBNFhTNa4OlgnZWM69d87Y1C96E
	0MFskz+MgqeoKosbaPW/PFvOkT+Z9An8AB5Nil3GQPB0SMu8ESALZKhRi2LrZ0kY5eeX0sFLrRC
	3t3ClbGPseu1ANc4XzTlTceMmrOf2tFks/9gHmHkkGj4rfqxsXTSmNi/QgqePoOUg0/4maA==
X-Gm-Gg: AeBDietezTOh81SeWeG1vx/UgIrrTHRSme1hxMSixTa/LOFCThc+z5FpOi16fiEkhlK
	6NSL8JvGQiov34kI4CP0XQE64Thca1PmG/siRb9cnlZK2mnuTQAR2rxLTOtP22nEztjYOKOVisv
	4MtgYuSZsPEs/yCRs4iQbPtyFt7PSz17KLHXtjPPlWuxrB9oAmxlGZOm/UkstRh2bWTBuR2WB89
	Nh207NZ9Vi6KW11N4FfT38nmFsOqCSsBgFAMABOpMZ+VM1tISBOyd0QWp2kRW9zEQ99tojoe/wk
	acUuO+ZrjmYVgonjEdNj568lWfWPbpL1t4m7m/geATsnDtXNST8/4sSKb65ghNH837EZREaqqCV
	VrWF3u+doWMm3uaIJIHqUxlsYeQVwvHDPu4HqoLqQldYd+UffRTMPCoknambFpr72Oaccn9/n34
	3tUXIdDcBGKfZf5UmUTbZBz/vk
X-Received: by 2002:a05:7022:258f:b0:12c:8f92:c6ba with SMTP id a92af1059eb24-12dead0b926mr2583415c88.34.1777586050794;
        Thu, 30 Apr 2026 14:54:10 -0700 (PDT)
X-Received: by 2002:a05:7022:258f:b0:12c:8f92:c6ba with SMTP id a92af1059eb24-12dead0b926mr2583395c88.34.1777586050260;
        Thu, 30 Apr 2026 14:54:10 -0700 (PDT)
Received: from [192.168.1.59] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df8287711sm416994c88.4.2026.04.30.14.54.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2026 14:54:09 -0700 (PDT)
Message-ID: <67aba8de-9a4e-46bd-936a-688abdb5d01e@oss.qualcomm.com>
Date: Thu, 30 Apr 2026 14:54:08 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath 0/2] fix leaks in some WMI error path
To: Nicolas Escande <nico.escande@gmail.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260424144813.1708214-1-nico.escande@gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260424144813.1708214-1-nico.escande@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=bJcm5v+Z c=1 sm=1 tr=0 ts=69f3cf83 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=FqyUr2HIOI8AG8dd71AA:9 a=QEXdDO2ut3YA:10
 a=zgiPjhLxNE0A:10 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDIyNiBTYWx0ZWRfX7ZaQq44VFj2B
 EF8Z6bkHn+2jQYNLbcItJQ1x+evo6Ci1nfey5/S6PSmslo9ywHC1wx7mr0gw8th7WkdbaBybdwu
 cTEBwqx2LZLq6n1IX1ApPh/yoCDjPeKCYyFOHFW5BiPm26posnNvmG+vOS/ecEcbj/cvW9fewyH
 qHqu8zuQlBiQgxFuuQFCjnZb/BZDCOBgTTrF8kyGdubRlyrLT4m0Y2RpLPt5gOyTKqFRcZpaGpG
 WU5nrGqMryD88Pxijx5xso2cjPaptrEHAG1LHJarnib8t4RIFGH3kyTmSHYsOI5tjmd1iN5gT/6
 4MpWKNtbT+BuN/+Brq6mn7+V+5Uh1Hw7rvWLMb6uXnTxEHVhJPE/w9lMXctRIJPNm3PUdtb7Phh
 pb0bjOiXipN0jEdq4/YvCnpDHveyc66Shi/3RiiyU/ukOs6vAoJ7xgDHIfbjgvsGzLauAwpkSrp
 p69nfTy3XTATFaEf/sw==
X-Proofpoint-GUID: dcyho3toWS8sUZWjCXMxjk-EsjwZMugA
X-Proofpoint-ORIG-GUID: dcyho3toWS8sUZWjCXMxjk-EsjwZMugA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_06,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604300226
X-Rspamd-Queue-Id: 072654A866C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35735-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.infradead.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

On 4/24/2026 7:48 AM, Nicolas Escande wrote:
> So this is similar work to what has been posted here [0] for ath12k.
> 
> When we use the pattern 'return ath11k_wmi_cmd_send(...)' without
> explicitly checking the return value we fail to free the allocated skb.
> 
> This has been split into 2 patches per Jeff's guidance to hopefully
> ease the backporting process.
> 
> [0] https://lore.kernel.org/linux-wireless/20260422163258.3013872-1-nico.escande@gmail.com/
> 
> Nicolas Escande (2):
>   wifi: ath11k: fix leak in error path of some WOW related WMI commands
>   wifi: ath11k: fix error path leaks in some WMI calls
> 
>  drivers/net/wireless/ath/ath11k/wmi.c | 131 ++++++++++++++++++++++----
>  1 file changed, 112 insertions(+), 19 deletions(-)
> 

Please repost and include the ath11k list

