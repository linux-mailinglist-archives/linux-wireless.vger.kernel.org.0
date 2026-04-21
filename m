Return-Path: <linux-wireless+bounces-35178-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLyfKGSa52kV+QEAu9opvQ
	(envelope-from <linux-wireless+bounces-35178-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 17:40:20 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1634943CDAB
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 17:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD04B30293E9
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 15:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F27727A10F;
	Tue, 21 Apr 2026 15:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RXkr/ERU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P6/c7KKb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0637129D26E
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 15:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776785601; cv=none; b=W8azb/gmU6c31Scthpy0HgG5lV44newHZR17nORrb78/C9k1Clg9xgAtX+2kODqvVCpg6chacm3KmbLdU5IFvhgnS6NX213bAVGRGlBcfBrnOfenuzjjdWD+rViA07V+N6TCPT5o587q/Pt5eRGKgagG1WRLkA4z3FlEO9c79K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776785601; c=relaxed/simple;
	bh=luE3GnWRdUk1a3Ka3cyzVxTk+FhzZA9AqCcnvW7LuS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pqcJsnakGAf0VIldoRF7L0rK0F7Qz061KMWrG+7ZGWeZaBwiy874j+xLf8hmpKTACEsHbvggExo5wUhoIE1b+2LaV4w7mauvn2zayxrzhAQuN+3MhBBp7G1el/fyl/6xE1+gqpffjvRgvoqTxKjkeZ8dUeddQxHKvOTxmz19Xao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RXkr/ERU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P6/c7KKb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63LA3eFt1085867
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 15:33:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=yIxlUghUBKiCc8deiyZT8qQw
	fk7BrJmVDIuLaHQJzPU=; b=RXkr/ERU2gTXlqPP0N71+8Xh9h/qx33T85Pw88jm
	lLesSNNFIySLhS74zBasK9ALQN/0eXlBAdrlZ1AJ7H9XChtCVxteuw/tj22laSlH
	lOi4iD/SIt8LG/E7a0c9HvhuJ5i+33+hoMVgRZz0PFS6IxIC0uvL8u9AQm08JC3S
	Zvck8K34cvfSJ0q3mpBA9Q/DRv30EH7WPd7KRpsj6Wl7To2BUuQ6pfjX8u/1yE0K
	Y1SDAXw7rlFkPhpmtF5g2o7uTE4+J51JD4VgLyE6TAlx7/+AefqTR/IkIoFzKmBA
	Mky6cPxvbgW0VavzE84noEXdAN1x/M5b+U6InjAldgovCg==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dp75a934t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 15:33:17 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7dbb97a2b6eso8508587a34.3
        for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 08:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776785597; x=1777390397; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yIxlUghUBKiCc8deiyZT8qQwfk7BrJmVDIuLaHQJzPU=;
        b=P6/c7KKbZKaXyGEyKMiQQW0SDTLIZuHu8zEn9DoqWAofi2IY6i3FP2U4BOsdfhETTT
         9+mk0X6aD078DsPjrFYI5EJvkol93bC2sJ8XHZRF40PoFmyip9AR02v7+DnCdJYD2wtq
         qmnbsgeWKTki1CTbF7TFjUw8mJNqfxTY5lSMN0iwHnipeOW1utfBX79ZsRMzk7+cNBN5
         ZAaEeB3px2a5SWQozGm0wtfROCXRmlZXfgszjvOw+BDGU+jlNBvNQnk4FiFssc6hCEYO
         IYw2zynDV5vIyNyWi28QUmtK9LfB85x3zB6earCvAE3Kcz0/3JKR9lFUd13bsNyV86af
         Jgaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776785597; x=1777390397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yIxlUghUBKiCc8deiyZT8qQwfk7BrJmVDIuLaHQJzPU=;
        b=qWKYL4fgNjfl7eqqGuCBsG2hEWzMzxY+ucqp279PKFKyTkBJyMCkXv8H7H8euEMPXs
         BybsUHemU8wzdCyfDTX+iG33ZPZMQtdMHoPvg/EXzfjX0GpL4SOeKcA+ehJ/xUpXtgKZ
         rpOYeKm/2ftZ3Kth3LKvyFh8oPdqiErO9c34/wNbYe4kbtEByOAwiS+SWnSTu1hv6o4n
         2wzHNPqc5k2ZVZ3qmF9NG7jHnigRYzjFt4fp3vCzPHTHICiWNYk/fjAsttPUa/yZaF0P
         O0QcxPUYcHVNBp1k6L3ZsWsSQAYdsoJRVsFB7ZrkqQQGxOjieMLSJLa/bpLfmc5vWO37
         JNpQ==
X-Forwarded-Encrypted: i=1; AFNElJ+vxbxTKVKs+gA1CEt8xndKHb+gMFFq7cwF1PXLr78iXwU2VlwbQ1p6uOzVG35qwkjs+ULS2qvJMrI+4/ikew==@vger.kernel.org
X-Gm-Message-State: AOJu0YzEYuLDmnum0NxeyNqW2eVuZp+BM2hqN7R+6X4SIiAxQlYaMeP+
	YYWgP6bszvpXQIdeJRya4rtZIP95XOzI+jCm7hCjDodEDhmqyBjrVCXGirDZmV4DhgzzXpzEK4T
	3LRYfStFpHORUSmlvIHHYPlKRdFTJ01dao9+7my3/E5GrwsPFFGEe6R58dqdmsnOFvmWA/Q==
X-Gm-Gg: AeBDieswso7O+qdbx58pko3nUfVlOQdOcM7Qx49NkxzhFR0pasdfLQMUD9dU5I2Jx7X
	6wFCHXvY6SQ5arIKYgf/+EQ26mZclenW0fWJWjLNKsDSG94iWb+/ncD0uU7A3+1/KBjE5XZsk0F
	eZiu5VIKUslwIM25bwlyQSvgOYU3mj31QrAGWr1N97G8ZawAolx3JfV1/LoDeyLLqI+/8JBM+8K
	TPUE/X8fB4n1lGlSfNhnL50QMZBkmp/rmvvUBIBnQyg5SLOZA7216ZnaRFshRHRvsmkuB+d3GAa
	Wj9M+3khQYJpkik8soUb3iWQwqSS5vX54wsqQB58FFImTPBMrLy4jlPX629g/a2jmzbwu6Gm6or
	pLgcO3MODmBDojXyNCVcvmcDaPSFA3tsPUTe/ugws/KdM9UsMp7uds7wPlQhGXxgiSsMD9jdpXr
	snog8r9kJTG4fahjzI5GS4LPLpTxNm5iFe4Sa42iJp8RRqEw==
X-Received: by 2002:a05:6820:55d7:20b0:67d:f88f:d853 with SMTP id 006d021491bc7-69462e2109cmr6917210eaf.6.1776785597077;
        Tue, 21 Apr 2026 08:33:17 -0700 (PDT)
X-Received: by 2002:a05:6820:55d7:20b0:67d:f88f:d853 with SMTP id 006d021491bc7-69462e2109cmr6917190eaf.6.1776785596615;
        Tue, 21 Apr 2026 08:33:16 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a4187ec0c2sm3757178e87.82.2026.04.21.08.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 08:33:15 -0700 (PDT)
Date: Tue, 21 Apr 2026 18:33:13 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: linux-firmware@kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, jjohnson@kernel.org
Subject: Re: [PULL linux-firmware] ath10k, ath11k and ath12k firmware
 ath-20260421
Message-ID: <wxnc2oczwg3hakkjxms53qbeckmy4oncp42mnqq5t7xs7lsvdc@4mmbo74zs3e2>
References: <b581cc04-f5cd-4e99-9251-523e50623b03@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b581cc04-f5cd-4e99-9251-523e50623b03@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: lpGaUBaOhbWUmOmaSiUdVCo8Qyj-YqVN
X-Authority-Analysis: v=2.4 cv=Fo81OWrq c=1 sm=1 tr=0 ts=69e798bd cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=p0WdMEafAAAA:8
 a=W2b0fEEQJ4TDHmAVsWEA:9 a=CjuIK1q_8ugA:10 a=EXS-LbY8YePsIyqnH6vw:22
X-Proofpoint-GUID: lpGaUBaOhbWUmOmaSiUdVCo8Qyj-YqVN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDE1NCBTYWx0ZWRfX6ZR2vqlRpqu8
 kNlPRkYkmbAZedvntI1ToHsnnMhZuRp6UjWvO3twlXdqqurAzmngTzT+Gw5qzZclgwUDt0nNfCL
 H7+ASdDa7xxkLpxKN3Bqb3Nm9Zk4BVu0xn1xLJGweTpZj6aEw3KxY/A7ckqxdqK/538d/dUhoGX
 y6zxN63Es0q6AwgaEPEzACVr1g2/b4yv+O47ClAZY+M5lsl8UqZT4cC51YYCT8nLdr1K6gNnJWd
 szDicgjEGUmBvh2uJqq2T4j6EeGCqkWn2hWev9qNSfzoJ2JgXd4szqa8ietf/Am90ZMv0VeqapG
 527fg5Rhi+NGA1LzJt4BnXmu2WlAJ3MaE3s6fQ2jbKC7hv8FsaK6444MxX5/76EF5S/h7WwQwQy
 HDmgiD8gL4LZeIn+U5SVbPx408U5fi64hquOlVjReMMwc+/9Bj8My8i5SxG1U07m8kC/N3VG2P/
 Xqvoq9A7AIfWB1SFD4w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604210154
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
	TAGGED_FROM(0.00)[bounces-35178-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,oss.qualcomm.com:dkim];
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
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1634943CDAB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 07:36:08AM -0700, Jeff Johnson wrote:
> Hi,
> Here's a new pull request for ath10k, ath11k and ath12k firmware.
> 
> There are no changes for ath10k or ath11k.
> For ath12k, add the initial firmware and board files for IPQ5424 and QCC2072.

Merged and pushed out, thanks!

https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/1010

> 
> Please let me know if there are any problems.
> 
> Thanks,
> /jeff
> ---

-- 
With best wishes
Dmitry

