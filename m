Return-Path: <linux-wireless+bounces-31548-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCV4GKqGg2niowMAu9opvQ
	(envelope-from <linux-wireless+bounces-31548-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 18:49:30 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3B5EB2BF
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 18:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A66E3302E793
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Feb 2026 17:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AC1348457;
	Wed,  4 Feb 2026 17:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iAP3aTjp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RlMZuB0S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C90433E37C
	for <linux-wireless@vger.kernel.org>; Wed,  4 Feb 2026 17:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770227084; cv=none; b=rsSq3ZNUkEbss0TDLf9edK32Y5FB/te+k6quxCDKAG4ND9RAoxCGVueHZTmYl3yGNJ4ybZSN+cVRddzwiCXVQNnm2VraUx0XvAodBnCiJSmy6k0FqsZJA11ql0qCeomq3prZbMMCAudafk/phPXAkTUFBAKQNYlVYvDfx6KVUY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770227084; c=relaxed/simple;
	bh=RDbOHl8ynvKyCDQlCPBqFSGyfKIjBq2BH9tuiBVf7kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sHwF4ZMbHPQo/PMzk2I1mWOgZy6RIW6C3w8MlBzQ79PhNlDihE4u4ALFfuHm6CblzzEajkVvWvYRs4qai9dYc1yGQb2FRfh055FdxNxCPzoGNOPbUj9ZewVQkDYS7ilZuSJ9hLtjH3GxT34gwwRPNcsbIcMJhbzMm/7EhK7SrqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iAP3aTjp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RlMZuB0S; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 614CIPva1880654
	for <linux-wireless@vger.kernel.org>; Wed, 4 Feb 2026 17:44:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=aHsrfprZktYuuOp72nS9bgf3
	dwUX3nERmaLiQO3UzGU=; b=iAP3aTjpKyJyVN9ovXSP+zd1s4LSAcOI0bJXnCAJ
	J7mgXhjkuRPJ8gxgYS0NmijXtwu6aNgqSpqmPFsYgJCp+iJQaiL+rxHSP9sR4FQB
	HeJYGBOXR2VTJ7bDrOUPgibrYM5p4e37bMTVS28MMwtz4sc43Fl+sanXPuxZqID/
	xsq5Y5I0HnNOi3W4GDT6doIHjhHmHfKNIX6Nij331p0KyHcPRSsyb+IkJkP9A1cH
	pOUqtmmYDLHc7IgHXaJIfi7FOoaJup+DBCvVjsjVMCGB4zndmqyqg6NJdOmLODeZ
	cLEZ35X46RVhwVGbwtcerG/VYsBBd9CjRGah+g7vo+CfSA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c43n9sfrd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 04 Feb 2026 17:44:43 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c6a289856eso344305985a.0
        for <linux-wireless@vger.kernel.org>; Wed, 04 Feb 2026 09:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770227082; x=1770831882; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aHsrfprZktYuuOp72nS9bgf3dwUX3nERmaLiQO3UzGU=;
        b=RlMZuB0SYIoSFIC1fbnFFGlQR9GGBxJ5Kc7dSRvmzRBzHKF3EkunCZs7ekFSP3Wi5Y
         QphA4CenGa2cQLqNObOcxU3Pq766K3H2AA+n9xVSQDAsUVs60GV6g9ICli0n2ltt44w/
         01xl+8mscnRWhP6hqkaGk94YphDb8Cz8ujBmLm0u+v4kMh2FEJmXO/Nbp/M3mXznfRlg
         dgm1MAxeRVlbk6iPH9PdaQkVOub6zGbQJbmrv6vx1dSgi3rlaXSh8tZPCZ+WW8iIpLEB
         IvcEfW6RSyDIQUOE+sOm4iSdGOjdDXhOIZgmWxEH65JEUbggnCORPc0SjKx0Sw41Vz0s
         fgEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770227082; x=1770831882;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aHsrfprZktYuuOp72nS9bgf3dwUX3nERmaLiQO3UzGU=;
        b=mC9Gg4yNk2aS9cWqpNscQxTkATNkQqV/qAqdBJZgo3hZ0koDG0VZvP0Ca1M0EPoxuA
         vA91NZ4bnvffkeETRA2sNzlM9vlZHrH/jsbcfyzkm3nGYjXP5rF/pwoim30RINR2CsyV
         FMIQTGtrO8XSwsN+zImP8evwrJg6k8HqJP5XoCxLXfbASd/Kf5/3/1u8CpdT+wBm03HA
         BdWL3RGwgoWzj42dA0TgY1zlqILBRBqozreNxPDkgtDKUB0oh3PvZ5imDhk2KC9wgKQY
         aU3GQy6M08mcTWRiDUQek98KSLfwQH4Qbm2vaWESWuR6VipM4sb3YAUwWVG2A+F+fmKi
         nRdg==
X-Forwarded-Encrypted: i=1; AJvYcCXrvzcQNmDPIVW/ezkgeBvcbOMQbzFaaCAqS/4FTo8Udqzz2y/X1BjZk2W5YOodAVhFIUlXVoELL7GMoMhBnA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLcU4sOj3o8vfU9fNKO/5qhkM8yKAABFhNyogxsBEqZmDoZ/If
	2Fs4qAVmRx5tUQzYZBL1Eypw9vLR2BiFBJFu65kmmb4hDYg1D7bJEIqcfut1B2J4lkxPa25/Wd3
	pYBHSGNCzm2p0QweBzWlkLhljkyAPNKWxK+pbs4vyeTLPI9WsmrzTQ/0RuQWCnD7b5qeRgQ==
X-Gm-Gg: AZuq6aLgG5T0xd/IrDOFWHFMcCtTSx3QezY1o75UnLFz8Sl4hqghL4BP6OSByWKUoM3
	jMefVVipFRnkeiAGgbme7nx3LT9bsGOFAi7vLcoGPNZ3hdWmri5Wkn0LiaokRzIZ5qTMKcL4smj
	5YawioVEpmruzR3+rObFA+ChzJ3gTY2EYqne16KwOtmE4gpQZE0g5rRrcEUOomM7Tr2PdlaIZ7j
	Qc2FdBhsmMwjOS1IC4zF+2w8nW6/7/9FW0c8ARcE3NrWeZXxUrJg1J5LNxnkyPOdpq7lcGyJ034
	dh0/c+ViXinzKucKwQi6BPn5oUC0nVYK4OhOpSFHOb0XkR7yCxZHpjOwdBeJ5R815O79vRPdO+k
	MJeTwpqGYJnc5kPviocMmThwzZ7JLMD+ZoU9VRea2fJZ/20Maa8Bc/jQcC5xrD/Eeh5CeJeQuyM
	yZW5myqVaubScvJ3LBHp///p0=
X-Received: by 2002:a05:620a:d8c:b0:8b2:e0db:e639 with SMTP id af79cd13be357-8ca40c40774mr18077885a.32.1770227082486;
        Wed, 04 Feb 2026 09:44:42 -0800 (PST)
X-Received: by 2002:a05:620a:d8c:b0:8b2:e0db:e639 with SMTP id af79cd13be357-8ca40c40774mr18073985a.32.1770227081991;
        Wed, 04 Feb 2026 09:44:41 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e3912f079sm671349e87.44.2026.02.04.09.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 09:44:40 -0800 (PST)
Date: Wed, 4 Feb 2026 19:44:38 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: linux-firmware@kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, jjohnson@kernel.org
Subject: Re: [PULL linux-firmware] ath10k, ath11k and ath12k firmware
 ath-20260204
Message-ID: <f4smcbpxikew7b3q7jnhuvojlhtvgql5po46xtcz2hfgsgbllr@a47zk2likq3f>
References: <18adf454-8e66-4b3c-a6a9-81faa2c57602@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18adf454-8e66-4b3c-a6a9-81faa2c57602@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDEzNSBTYWx0ZWRfXzuMa9jaiqsJ8
 z3j5RzmCXn5br2jcfx9RsbVHtHvEVI13z7NRPEPrOYVn/rLq1B+ZqWpFG+L+2YmXj4aEmrqYBjV
 nWd5q3kd9hJX7IpIK5KbuFL86C4qNSi7GhK9l+KBnu4xH3oGex2uE6XmfOK/HDBWZReEvAtzvng
 BSV2nMLZfFqvUjVrtadDqTpUsePWZsnRUAVaRAUUUhhJjw+q23WFVmrP3sTxuxPW+oSF+WaDYCg
 DGDxJb2eSILbNRpfM8/Q5YH1Zp+UcCpxhefFjn3t0ZDYKV8yFL4bUQMK6a9l3rHIRCPOaJSDu3M
 m8PYP16QEcrc49U+gkks5gdL/Guzuc5WIpAW6TKHB0aokNmQq18OfJWWohbSi4F34RKYJn+zvNC
 h89K/SKAiwBjpnioE+Vm46KFCZcvXD35uCQzF3tZzSrCZhmsQZeQBtahEBmFnbZgN7j9j1tatNa
 ehjZRi5djxtOOi3dqZQ==
X-Proofpoint-GUID: Yen5kIBFQKuY-8DU2nso9Kwfi7coDPt8
X-Proofpoint-ORIG-GUID: Yen5kIBFQKuY-8DU2nso9Kwfi7coDPt8
X-Authority-Analysis: v=2.4 cv=b42/I9Gx c=1 sm=1 tr=0 ts=6983858b cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=OQxrAGhQEmtJb-q9RkkA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_06,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 spamscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602040135
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31548-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gitlab.com:url];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BE3B5EB2BF
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 09:18:03AM -0800, Jeff Johnson wrote:
> The following changes since commit aeea3bf80600892be582a61de1551cf431341d9e:
> 
>   Merge branch 'robot/pr-0-1770184708' into 'main' (2026-02-04 09:13:00 +0000)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/ath/linux-firmware.git ath-20260204
> 
> for you to fetch changes up to 81a99dba039a21fd83d37a67a7de0fb80152e065:
> 
>   ath10k: WCN3990 hw1.0: update board-2.bin (2026-02-04 09:09:43 -0800)
> 
> ----------------------------------------------------------------
> 
> Hi,
> Here's a new pull request for ath10k, ath11k and ath12k.

That was really quick, thanks!

Merged and pushed out: https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/906

> 
> For ath10k update board file for WCN3990/hw1.0 to support:
> bus=snoc,qmi-board-id=41,qmi-chip-id=30214,variant=Qualcomm_sdm845hdk
> bus=snoc,qmi-board-id=55,qmi-chip-id=30224,variant=Qualcomm_sm8150hdk
> bus=snoc,qmi-board-id=67,qmi-chip-id=320,variant=ECS_QC710
> bus=snoc,qmi-board-id=ff,qmi-chip-id=30214,variant=Google_blueline
> bus=snoc,qmi-board-id=ff,qmi-chip-id=30214,variant=Google_crosshatch
> 
> No updates for ath11k and ath12k.
> 
> Please let me know if there are any problems.
> 
> Thanks,
> /jeff
> 
> ----------------------------------------------------------------
> Jeff Johnson (1):
>       ath10k: WCN3990 hw1.0: update board-2.bin
> 
>  ath10k/WCN3990/hw1.0/board-2.bin | Bin 742192 -> 867116 bytes
>  1 file changed, 0 insertions(+), 0 deletions(-)

-- 
With best wishes
Dmitry

