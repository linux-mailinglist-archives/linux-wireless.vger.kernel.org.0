Return-Path: <linux-wireless+bounces-33359-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +D3ILprAuWnJMQIAu9opvQ
	(envelope-from <linux-wireless+bounces-33359-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 21:59:06 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF5C2B2794
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 21:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D49F304CE82
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 20:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955C138C41D;
	Tue, 17 Mar 2026 20:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PbX4K2Bq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KOeQDQYV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B52B38A736
	for <linux-wireless@vger.kernel.org>; Tue, 17 Mar 2026 20:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773781092; cv=none; b=UzBancIt4pgfWBVMBJF6FbT8GwnoUTb1Q76e0NrQ/QGgMYsJPNAsM2Oflh58m0Z/Z6J6Eh5eUnefZDaVzMO1gdYjWsuHZy8crlpnw5gmbaDqcDRmyiH37k77/udTFwmbZTorsP9Ofar9Rd+kTQSdFftXgDN2LO8BOfE0WJFDOOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773781092; c=relaxed/simple;
	bh=N6IwVbFs6da1t+wrrtKXeYMIIYwzKR8zOYji8hfH2ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fRPMaArwLTKLzsM3ls7kMZ3BwhXHkNdonhn2nj5rGE5ClzngUmduU/hdHZPZFqm3pPfrW71BqZxBm94Z4FqH7HXYPDvKkKe/2KRXwB1Q51u37yno6vpORVdhmqIwIakcCD65mqneXSDszXImmi+zJ5VDtX6Qe51D9ljZVDWHd1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PbX4K2Bq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KOeQDQYV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HIJ7dm3281050
	for <linux-wireless@vger.kernel.org>; Tue, 17 Mar 2026 20:58:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=13JEGb7aTnX7IY7HCWv/idnN
	4TiZVfefOdq8xjCIpRA=; b=PbX4K2Bqg4rwv9YhBy6BCIkis1123gnDwv1ZUynk
	avZ4xOdADkyRER5OZ6i4XUeUqV+BvuIyEchK9dODrt50fnytLyRlmcEV6Ku22Tka
	QWu7KKQJH0hd+CnHIoMSSPRfBBQBSUNni4UK+WcU77OT+gb7vV8s30S+ZzpGuSAP
	R9IDtHPsRJwHDGT7ZvVtQgXOqDPlR9RkjVrU3KQupUBuDOKFeqbKJnR/EEZZetJ4
	jENqq3vrgpgdTCfDTsmhYoiyJd8GlJi+G5KU+YaUuDL0wkOEjdEw6hF3CcYbogq/
	+8/M2tQPoOEDoEnGclSKd5CXB+zk4SaG7Jn5wL7GnX2R7w==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cya62s5bj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 17 Mar 2026 20:58:10 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cb706313beso179058585a.3
        for <linux-wireless@vger.kernel.org>; Tue, 17 Mar 2026 13:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773781089; x=1774385889; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=13JEGb7aTnX7IY7HCWv/idnN4TiZVfefOdq8xjCIpRA=;
        b=KOeQDQYV/iYvRuZKj3O+kSxYCGpYMnum3nhZVhW2dtIVv8mRs9NYMGobM4UdjY5f1U
         nwFGmk+UpX9DEgn1aotUPWxpu+uAQ8YEy+jhy+ocCqw+qpZwgnk1pQCgVsXicNwg3Myu
         gMtQxkxzBHem37uPwylmrjxfVgTLfh1dTaCBqk6AWbRiE93Danwl/Y8WGYqWoosmlpzk
         r6gshJ3G3SjfSrbL4KR01xTFLX/j0Mlef0OqwALFq5SBn35XoM8ff5uMScMnPpVKxlk1
         Jsank7k7iV4CwhxMfzWDFsKuLAaEU/xDTIYV2OaVnL9EMivh0LIficBtNXxf1rjPAQoW
         aTtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773781089; x=1774385889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=13JEGb7aTnX7IY7HCWv/idnN4TiZVfefOdq8xjCIpRA=;
        b=dvQ0VeACjJpQ3zLSkz9Tw+yIAtm296omj6FJiZPWIHlVYcTKH01bbR3NTpT0adHmkB
         NXGABzVcXbylNkVs6Y4sII1zIHlZgjDcpqVk0oFvN0PdUFRgm+8DtFVgYUNbLepm5R/B
         Tqjx1ldnUQkDDvfLTLGAwHGNUox9NXTRmCtenJhT1lG0Z5J4nj4TQnRfqC60znpxogEz
         gvXQ0wfBXat9z4ZguU1Ykh2arCjEJ+X0cY5T31KtF1AgsbTbJI2/tEBWMJTd9nd5d/lm
         /or7lQWm6l+hN45ZJ3o+/Yo/9NrS7kghvsMsfBilzhda3k2pRVCOWgrMij+8+nKe497t
         /3sA==
X-Forwarded-Encrypted: i=1; AJvYcCVGRaE/VK9GIGQYCQKT+14CEuEnnJGHM20h6h7y9MHZUF5iC1Sef2HoYnya1ToY5rvalv8y3SBUrlxorXfQ4w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyP/TiQK63skqA+d50lYmcAZF8vjLUCAsYmdMn/T6kL6BdoGVAr
	1jfczZ2McrmJ0YCMFM0fWttQtKeg3c/0aUZS9m+yEz7mqkwQMSkriKzslgzzAJx1Mz5fLRzM8Oj
	Fu5r/poZtuKmgo2ad7AamDXQHCvGtOL1Yf3xJv+FUd8M/aE+MqlsUTo+W6utNI8oCCTD03Q==
X-Gm-Gg: ATEYQzz0p63Uar+Ty6VAl5anSvZdQjZhy5m9RwjPaaBl4MRTD0gkZTPry1qfTt4+QHE
	sN0dksXnBLJgOUIKDRA1OLs7XL97nLUOR2pfHmOcR8N1LZt5HTBw4/DEW0eqRcGtDFmjrU9/k3w
	tDXWn51qOjtUbzQsFR0DKksRcLpYPj+AbDe2RHxCPtYNT3U6+BiahEfYeWLGa7EJ9hWvrLVce64
	CF9YUepSyZXMPJh7zqfp3C8wNK+jHvJXS/dDE6sbSfjvL2d2rxEUQryVODHSDBzB9vy++yExneP
	ZjSCinfHD1FrPBVVUmBVT98ai0oIvDdDd0GNY6WsduPn2gm7/3KO5Z4HiwdjCeaEUVjL9H0O2F3
	JRPJsEsiWLnx6aKVKJcbFdOylTqQKFZvciwqcDn0mfeAyfSTf5cgKN8Txs0ziBr5XLUHopTOyk8
	GOtSSt5bRm3MLIX46tM4NNXZhBPEhNXYwO78U=
X-Received: by 2002:a05:620a:7016:b0:8c7:a53:4d17 with SMTP id af79cd13be357-8cfad24abb6mr161539185a.21.1773781089345;
        Tue, 17 Mar 2026 13:58:09 -0700 (PDT)
X-Received: by 2002:a05:620a:7016:b0:8c7:a53:4d17 with SMTP id af79cd13be357-8cfad24abb6mr161534685a.21.1773781088780;
        Tue, 17 Mar 2026 13:58:08 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a279c7c77fsm101863e87.81.2026.03.17.13.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 13:58:06 -0700 (PDT)
Date: Tue, 17 Mar 2026 22:58:04 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: linux-firmware@kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, jjohnson@kernel.org
Subject: Re: [PULL linux-firmware] ath10k, ath11k and ath12k firmware
 ath-20260317
Message-ID: <sxyottdaf2tu7swtvs46cziq4s7vraebrgclia3i625lnczf3x@bo7ssgih5mjk>
References: <3ff94227-db20-429b-9872-75faf39daec2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ff94227-db20-429b-9872-75faf39daec2@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=Ns3cssdJ c=1 sm=1 tr=0 ts=69b9c062 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=p0WdMEafAAAA:8
 a=VwQbUJbxAAAA:8 a=5Y3Z_7dTJYxM88ERm3YA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: dAbkY6ExTHWUvqsX_JOAO8SClVXt05Rz
X-Proofpoint-GUID: dAbkY6ExTHWUvqsX_JOAO8SClVXt05Rz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDE4NCBTYWx0ZWRfX+hr2rY5y2v29
 L6WBjGRNYV9XuhHvWLl1vJlD6jM7KGmKLG9cZrwphiWPlQjVT74UG0BUNrss4egRlsAl04gQXJL
 0HeA8X0uYpSKtnShgddqWU8rq87MMf08Ly16tW02b/zvWz33EsNQISXMFfkB6uUg++4Ye3PsnYX
 agrNbVcIb+ITYjMYl9P4mljtn82G3zTk7t57hfWYbZbjWZVZpB17+NDWAZWdAFUjIzYwRRWvmg4
 Ihq9xVKNiZb2PE6eiKzHehhhmW5pwGQFPMeBHhp9XugCRiE3eadJwVVQ2Skh5gItqIDxg/Oewa8
 xDWmNQPKJqi63EktaLVYpN+ahaanxUXS/Y/58SB2kLBsY5kuWrURJ3jmyNIyEBXxcrDBFnGAkHe
 J/i3WMUjH4W0mNHoKh2DNAeF7S7QgDA2olxs0i7SHMbwiZaJs7ktc5wRBaYVO2eSnRsdmeaCpIW
 7ailFEJ3viEFdrbDbnQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_04,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603170184
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33359-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gitlab.com:url,oss.qualcomm.com:dkim,qualcomm.com:dkim];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: 1CF5C2B2794
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 01:18:59PM -0700, Jeff Johnson wrote:
> The following changes since commit 81f761d1b5fd51469d87d1633a959dbff4785f58:
> 
>   Merge branch 'mt792x-bt' into 'main' (2026-03-17 17:33:37 +0000)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/ath/linux-firmware.git ath-20260317
> 
> for you to fetch changes up to 6fb33265936075ee1bb5a31786a4fe1b30fdd001:
> 
>   ath12k: WCN7850 hw2.0: update to WLAN.HMT.1.1.c7-00108-QCAHMTSWPL_V1.0_V2.0_SILICONZ_UPSTREAM-3 (2026-03-17 13:07:48 -0700)
> 
> ----------------------------------------------------------------
> Hi,
> Here's a new pull request for ath10k, ath11k and ath12k.
> 
> No updates for ath10k or ath11k
> 
> For ath12k:
> Update WCN7850 firmware a new unified firmware supporting Mobile, IoT,
> and Automotive.

Thanks, updated and pushed out.
https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/962

In future, could you please include similar information into the commit
message too?

> 
> Please let me know if there are any problems.
> 
> Thanks,
> /jeff
> 
> ----------------------------------------------------------------
> Jeff Johnson (1):
>       ath12k: WCN7850 hw2.0: update to WLAN.HMT.1.1.c7-00108-QCAHMTSWPL_V1.0_V2.0_SILICONZ_UPSTREAM-3
> 
>  WHENCE                        |   2 +-
>  ath12k/WCN7850/hw2.0/amss.bin | Bin 6082624 -> 6090816 bytes
>  ath12k/WCN7850/hw2.0/m3.bin   | Bin 299660 -> 299660 bytes
>  3 files changed, 1 insertion(+), 1 deletion(-)

-- 
With best wishes
Dmitry

