Return-Path: <linux-wireless+bounces-31746-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBp2ALPZjGlIuAAAu9opvQ
	(envelope-from <linux-wireless+bounces-31746-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 20:34:11 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F161272E9
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 20:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CA9183006B55
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 19:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A251B353EE8;
	Wed, 11 Feb 2026 19:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pWHF2dwL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bA8+hXnl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696AD353EC5
	for <linux-wireless@vger.kernel.org>; Wed, 11 Feb 2026 19:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770838448; cv=none; b=mHMpn/QKs7SF+0yYXGZy91vvMgOsR5ZUPODh4lN0awf5fWhxktggBaOzaKP6v/B2J8uIb6rwPn1tOO+llxwFVZHvX6VnM0wExFKd939qvgFl11CCBJlZjFELNSbTWq9kupRA/pPI9lBEyge8lNlCqM5niricJu7bnfSE9hex9MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770838448; c=relaxed/simple;
	bh=URFribkyJoF1ehj5fkRCHc2P8v/OT9DK7LGsFcMjzVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L4ByK5L/OpD7UKK2YroK9SK8tZ4sBx8OaZ0tucgmvfPSyMLz9QKYbtQVMxcdHp5T9ANRAiaqyg5kipSg0MHJDlRP6l1vQ8yF0etlm+CoKplVYl3qDg75x158H3dA0vyvQuN7Pr3JFsTjnyeFr4p7gnG8weEyQgLTld247DPReo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pWHF2dwL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bA8+hXnl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61BGVHrk1951166
	for <linux-wireless@vger.kernel.org>; Wed, 11 Feb 2026 19:34:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=O0qUu0rQFYpIca8hjxo2OnzN
	f5MP5k8P5QUnQDN+f98=; b=pWHF2dwL9T3WXw+3gHc6izwteIRab2dE96jpxSn+
	5nnDz6UTf1C1/+stnIHzeDirOmqs6WlVIO2239f11Xhm8bsiU1nomvsLAxfI0ivB
	yo0oKRg/cYD51SF70chjkNU321PD/40VowTQ/ewNQ/a5ckJ5iyj1D3S3DssAYD51
	5GClnchka1qWkvvioEkQT0D2Nqb8po+5AKwG1VgYrowtXO/WMyAMmi19oQzSTJoB
	ttm9h3CwPHVUTJ3XV0wtfEWGwsga2G54SjXCmPANiYaXDkLiDMgrlt0J3KkiKU1A
	/nvySg/QqIhReEhY66/YctKicxy8QmbYo1S1WytuGdU7VQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c8wc4rkmk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 11 Feb 2026 19:34:06 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c538971a16so632850985a.1
        for <linux-wireless@vger.kernel.org>; Wed, 11 Feb 2026 11:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770838445; x=1771443245; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O0qUu0rQFYpIca8hjxo2OnzNf5MP5k8P5QUnQDN+f98=;
        b=bA8+hXnlomFLbOJu8KxUv3eCYOd5aJxIqb9dm36o0wHcwmGHYEOruUEAJxboTKIPZH
         95A3n8PDbiRLaLSshGyh1WcnzfacF2o/lSPRzshQjgFxj0K2R2ceaHS46s/VhVvLPAms
         4KHtf5qeIjlm+WSf1iP137YFQoUl47/6S1OmW+zxk9e49DfwArEuTAoZ8mZ+3THz/ZzI
         HgdKn+tEf9Tab1F+BmENFIRWIxBaULolq276ftb+FH62iFwHrJwk7Sf1yd3voDT45OTl
         xkGcwgcM4WJrLH4guHC5ipFIPzAZCUVVVm0buHB603ndtMs1qux2Cr1zeWGw/H/YWbu2
         V7lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770838445; x=1771443245;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O0qUu0rQFYpIca8hjxo2OnzNf5MP5k8P5QUnQDN+f98=;
        b=Za9abJeVJmuuqy0wYkh1CmX8Bc3YEYBr87L7a/XJ9xvwDT9wfAFifYbcRa9fUuwew9
         SOvwlmZm2y/edXtKgv8sWOJMwnkxktzb+gpl2eAMGHw5Isc+c1UqxppbrM7gosG+/Pl6
         P/9luCKd0kcgq/zjRFnqo+a6sllVR9sy9jsyNuL0+ID6aCOODkfiM0tGpcKhTl5J4DYc
         CycKPrivKcl+w//mUzPQavxGDN2cTrvPY8O0GA2MhXnVwkKM59K4pW0eXP+b1J/YLQmC
         o3bpLf18IQpVd9kPFM5GFZlaEkyDnwlNLwPPjjx/8soPYtXTFSqZtBvJjAIIqj/B88Uo
         OAOw==
X-Forwarded-Encrypted: i=1; AJvYcCXRFB9WvwejnZ/AjyIpXQ4mYbS+yqf9OeHkQBHDxF2k1pb6skekgN0q/G8MB3Wa0sYP24gGFe2Gfns3znZcAQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxlSMOU57dhGv/xIUckKstFZrOk2/R9835X5YCkpABUXoR4D/PY
	AvauUozkCpJ9YPGm2aPxvX1/BJsBQ4H9noJeskIME/HRZnL+t9MscW44+JAEO2KCnI7Vz16BwnK
	4tRYrUqKrqQs4RMLytmVJ8smXzPW6gztQA4q7eE0PSVyKHOyeVPYuo8W6pu3356eh+v9AX982Xx
	5iew==
X-Gm-Gg: AZuq6aLsPNpBfjjthmfl6mfI6TuFXgzL8b/nPjaTKbAMxkR2Jx6SXVmWXSkhGMjkVXM
	NXpzT7aSLZlzzfmgAeDxabEtf4PcL853xchycYb+yv6RZ/EiWDmZZRmxFqkWpJCfkvpsvG9bbiq
	4a0JT5XJjMDAVWDD9jd7fqMKWmLauK1pWxp3anN/3eq7XzFVdGeFmuOlz6R5f+HMjJckjRR+AEZ
	s4Rt1gSXPPslwlLgmMsB0kVo7BsorbkJs9BGMqOnWANOgx/QJDypejEMJpJZ2AJVNyKjDS3W/JY
	4BwRt8vp6TF5SJfhztdyPsCMOhStex97kbjhOkh24bH5nAfGApQlcXhRMCRUbkmhK5H4ssog/P5
	GRpSexHLoKZOfyxcApeIlutmJ/LptrJXLyuQQaVy8wlujEA6bO4atinfI38c24jMvHGlniDSm0S
	F/BJQIbNfILACMnC6CJDpXSJj3h19RzUtwXCQ=
X-Received: by 2002:a05:620a:462a:b0:8b2:f29e:3af8 with SMTP id af79cd13be357-8cb33143bd0mr47628685a.59.1770838445293;
        Wed, 11 Feb 2026 11:34:05 -0800 (PST)
X-Received: by 2002:a05:620a:462a:b0:8b2:f29e:3af8 with SMTP id af79cd13be357-8cb33143bd0mr47624885a.59.1770838444817;
        Wed, 11 Feb 2026 11:34:04 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-387068e5850sm4021381fa.26.2026.02.11.11.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 11:34:02 -0800 (PST)
Date: Wed, 11 Feb 2026 21:34:01 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: linux-firmware@kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, jjohnson@kernel.org
Subject: Re: [PULL linux-firmware] ath10k, ath11k and ath12k firmware
 ath-20260211
Message-ID: <2ujc447cdished2n24epmrkp7pxepo6kcpgctdqk4whgjkwne7@l6r24pzjewqr>
References: <61ec2d75-38ec-4ee4-b447-3fbb723f59bc@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61ec2d75-38ec-4ee4-b447-3fbb723f59bc@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: ZMKLYlwS4KFyPHAKN5qm40BVa0Af7tYZ
X-Authority-Analysis: v=2.4 cv=NrLcssdJ c=1 sm=1 tr=0 ts=698cd9ae cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=p0WdMEafAAAA:8
 a=VwQbUJbxAAAA:8 a=0afWX6N_0y5Ye8V-RdwA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDE1MSBTYWx0ZWRfX+6y5ocHM32+c
 uMC8hzIdWYCvOPm3beDUD7oAC4j7a9/a+0FesPscwFEGR4j/7ZZLuqTydCQN2NiRg1DCsEyLXj0
 DGwIhLfzg8hM+tuIM8C0Gz/mP5F42/zoMDWknb/lS8IDntsDvdwWYQIQvilhWe9a2lUeqQBxdYe
 FAtCMebOyxE+kG0w/SYyY/qDKR3j5A7USoQ3+VXvmQOhSPBXjNpNmxFosMoayk/bZZpOoiK5Puh
 BNZvUFz00a/9Fh2VDUiuFSpeWLRFCtfhroO9EVLBUstLmAaLSAUnQK1gwdRTQp++jxR2lUd+UIB
 Q6/K4wadvzXHle2XZ+o1DZ6UTvIhopWj+j04yz/HvPSr3+iYRW0HxPY3rJ62QAbtpdCnwIlfyNa
 po2hyfCtjYvxcKoWgnUmzUcKHH1NSdGFqAzH2hQGHpg7++xGg6shGIWcUcYjoXv7uEyYUqpC1us
 W1mkizwjmhQKNyNr94g==
X-Proofpoint-GUID: ZMKLYlwS4KFyPHAKN5qm40BVa0Af7tYZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-11_02,2026-02-11_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602110151
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31746-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,gitlab.com:url,oss.qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 91F161272E9
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 09:50:15AM -0800, Jeff Johnson wrote:
> The following changes since commit d87f4693ed96d0f3f6f16b0f09be42f3b8acb9e0:
> 
>   Merge branch 'robot/pr-0-1770665774' into 'main' (2026-02-09 20:06:30 +0000)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/ath/linux-firmware.git ath-20260211
> 
> for you to fetch changes up to cbd0f9753754fd9605df129ff04b0c4b4fc82568:
> 
>   ath11k: WCN6855 hw2.0: update board-2.bin (2026-02-11 09:33:04 -0800)

Thanks, merged and pushed out:

https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/916

> 
> ----------------------------------------------------------------
> Hi,
> Here's a new pull request for ath10k, ath11k and ath12k.
> 
> No updates for ath10k or ath12k
> 
> For ath11k:
> 
> Update board file for QCA6390 hw2.0 to support:
> bus=pci,qmi-chip-id=0,qmi-board-id=255,variant=Xiaomi_Pad_5Pro_5G
> 
> Update board file for WCN6855 hw2.0/hw2.1 to support:
> bus=pci,vendor=17cb,device=1103,subsystem-vendor=17cb,subsystem-device=0108,qmi-chip-id=2,qmi-board-id=255,variant=HW_GK3
> bus=pci,vendor=17cb,device=1103,subsystem-vendor=17cb,subsystem-device=0108,qmi-chip-id=18,qmi-board-id=255,variant=NTM_TW220
> 
> Please let me know if there are any problems.
> 
> Thanks,
> /jeff
> 
> ----------------------------------------------------------------
> Jeff Johnson (2):
>       ath11k: QCA6390 hw2.0: update board-2.bin
>       ath11k: WCN6855 hw2.0: update board-2.bin
> 
>  ath11k/QCA6390/hw2.0/board-2.bin | Bin 173980 -> 231980 bytes
>  ath11k/WCN6855/hw2.0/board-2.bin | Bin 7117076 -> 7237392 bytes
>  2 files changed, 0 insertions(+), 0 deletions(-)

-- 
With best wishes
Dmitry

