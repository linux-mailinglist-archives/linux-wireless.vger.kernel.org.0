Return-Path: <linux-wireless+bounces-29460-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DACC9CD6F
	for <lists+linux-wireless@lfdr.de>; Tue, 02 Dec 2025 20:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 840263AD721
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Dec 2025 19:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFCA2C237F;
	Tue,  2 Dec 2025 19:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GAAOUGu1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Lq4Jt0IL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB2B2C21C1
	for <linux-wireless@vger.kernel.org>; Tue,  2 Dec 2025 19:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764704413; cv=none; b=F6c1Y7lPXn0Cv3qNRv+nPrQTd2Sq/Qk3XORvmG/lbtqqGOLj8NJ+1bea2uZo3KsclsIGk80sAPXWeLlOv7zM9RZvuwrCciJvlDLdEIyetVkkKRNIfex8A8lIGW1sEY9wSwuXhRwuiOGnP6oasd/a0HDCc7kjisIUcOkM2gSrCXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764704413; c=relaxed/simple;
	bh=3Uq/+bE3n3/YUqbFBRCUGbu0fEwxK+LKMZ4gWysWWgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jqP7XVLwYVnI54FytO+fhjwf5e4f+pv7FxGzcEAKNYuiI0WcDNS8dlKh8v5JyGDU9yVSstqu/Wgy7HEeyeaPb1UfWGAwIomv+qpoxxWAArtG48gdXmslSQT6k/PTVfvheeZTmkknlNxaXShEbrFjV7NTExmdfZS0tFByB9JulXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GAAOUGu1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Lq4Jt0IL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B2AVQRN3660413
	for <linux-wireless@vger.kernel.org>; Tue, 2 Dec 2025 19:40:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ymqUFuKgkW+1ZVITaHJuQJuC
	RC41Z8npiwRYSjupMVQ=; b=GAAOUGu1pnU7oMhHYLNJ8fln9vIgFPletMAjmeHX
	QbhEfK3hCHGC8rM8nd1noR6GdRmnjM+Lvg4Mbtw8UOHbCMid4PhWIKaiaAord7Xe
	Nx0e/3SGxVgyrld0Us8Fk6MHaoJJ+HRbosFLlbx9kiXPVwuAxiK2R3YKiNcoXcbg
	LhGShHpD7CKJEMu4ERU7Yw+lSo1DkdXtCyu7FKHm6zJv8DFo+L98V8Di8LWTmGEP
	6nCy5AL/ZlBCrpgqaM5tB4hg3Ub+2FY+bMFCVignQJ+lgEFda5zmOE3WSVvKgPDh
	GhWzeyWT/TcdIm71ABLZd7MbwyoxxFHcYwU2YrBUmF76Bg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4asxeehrgx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 02 Dec 2025 19:40:10 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b17194d321so628596485a.0
        for <linux-wireless@vger.kernel.org>; Tue, 02 Dec 2025 11:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764704410; x=1765309210; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ymqUFuKgkW+1ZVITaHJuQJuCRC41Z8npiwRYSjupMVQ=;
        b=Lq4Jt0ILabsZoWeELmtMb5qedfvWq4WkT9GafCX4PrPQJ5pgpmxL/eDfk0OxDXI7By
         TJ2BhkgzmfViDnq10MLyUxa0ov1C/Vewfvsy2YdCgUHVDLghcK680abqYabLBVo+dO2t
         dJdNhVC1pvbzcToGu7oLXkxjq+TL0Cs8v1bJN4BAqg5SSxzMd0eCd1enOipYdDo2gjyX
         gd7AqGnwyz8lScUaFv4qzaecyZArwW0R03/0kvRDJjQYFhubPoNVB4nGSw53zg2FUC8L
         itMC0Mp6Kz9rdcuOvdsLkKjel21VZoA5geoc4KUUbFdjj+JrpiDnpX8UdKS+l7TYQ7l1
         JA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764704410; x=1765309210;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ymqUFuKgkW+1ZVITaHJuQJuCRC41Z8npiwRYSjupMVQ=;
        b=t14yxTkoL5hmCpjvMXLVLZUknlTQjEPyebhnkEwBSUoLetrbpfhO2vI+kiO93lPm69
         kxlX/Xb1WNTAZpvysvfATH293In7Q3wVikMoE54sKrLu+U7Xvzp4ld9VJCQ+sIF/NtXV
         aioSM1wqtoyM4ztXGMF2amXSm5J6BVpl9Sc938wGo5topem9kz/5uZbNUDJt/iIqQL1x
         J0u/4Y4/KnPVNpIownrJ5ZC4z4iU++SuYfb99e26F54uNoZs1bruWkXtsOZ7CzWOFZ1Z
         JVAD4/F4+w4qOdOyStTPH9/fzC6KBNO5tAdwukyvel90nu4SogKrAGX3b5nWUTZOw/07
         nqtA==
X-Forwarded-Encrypted: i=1; AJvYcCXfM5ZQCMkCqxPpqv5mBY6bMLh47tN1EWpCTBOE3L7cfv/6ovPffpYEFrdH/tfsFKGeJhI9OG+KFnf0S4/Dkg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl17qiPVwD7lisSNbzYx+79F2lwd+dbloEB5DlSwNDZ8lMoGt7
	vg1wsLMJsKZscx/GLaC3xLoatj1ESjc9JcRofIMD9fiwuucKyVbMLI9MSCaSH7MqlA9vrgNRNVe
	SUygypWzU54xIq005DZ2XrTojVQlBSrOlGCA+lOz7Ex/TVDuoThhfaRNecMruRsomtwwzTA==
X-Gm-Gg: ASbGncv+NCr39LoCdBuv7jhzjH1XXTuHJ2fsqVI6R/lOPMqE2J4XwA4NmY2Ai2EZtc2
	NzEoIzTfROGOR4XsT+PTFD2uk+CiMy/RFC/qQMUKACunUav44mdbI9ECxyuA/n87MZIURzmgA+M
	lbOVJJ1xtxsjtynFw2RdOoYL4d63tcneIEhTxQ/VEg1jQrrKi2cxexQi2zTexJPQ3dpDyQMMvfv
	myTn5uKuONNWeU4M5ZtCUrjRGV77Ih7OELr5RUnpkPyaKQzoWhdjsdCKPoXcfJ4XC1xloiVwD5F
	CaiGStddSPInluZ7TDnSrvrEe2D3z+GrwyT7FyCtSIJ7Lx5hmL99YVEk/I1XwpaNxHAT3OviTjl
	VY602WFdDiiekxud9tcj9f1RyBTTC9tFsgtMcDxq+p3I/a9gt3IeSIJsoh5yByvSzJxwNPHnFnS
	f0c0xsIHZwZW+/fndR3TpwLrE=
X-Received: by 2002:a05:620a:4085:b0:85d:aabb:47d4 with SMTP id af79cd13be357-8b4ebc438d4mr4219787685a.6.1764704410194;
        Tue, 02 Dec 2025 11:40:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFeduTZfiwuLmEI3ux3Yzeal23XZK+cH0bfIgKG8RjjcKOtbLOA0MsLVdr+HitBOBcoOQR5QA==
X-Received: by 2002:a05:620a:4085:b0:85d:aabb:47d4 with SMTP id af79cd13be357-8b4ebc438d4mr4219781785a.6.1764704409657;
        Tue, 02 Dec 2025 11:40:09 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-596bf8a7d0asm4967858e87.11.2025.12.02.11.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 11:40:08 -0800 (PST)
Date: Tue, 2 Dec 2025 21:40:07 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: linux-firmware@kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, jjohnson@kernel.org
Subject: Re: [PULL linux-firmware] ath10k, ath11k and ath12k firmware
 ath-20251202
Message-ID: <xznwi36wauarz32zf6fzxug5fxpu2dd2de4mgnwoxbwkyanjfr@f4fwq6jtxuyr>
References: <5d522aab-9ea7-46fc-8d46-00bd60bda496@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d522aab-9ea7-46fc-8d46-00bd60bda496@oss.qualcomm.com>
X-Proofpoint-GUID: -txe1-JN2F6pjNtIyveh1eilbAgG_ji3
X-Authority-Analysis: v=2.4 cv=TMRIilla c=1 sm=1 tr=0 ts=692f409a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=9XiVC44GTZ18DIIRa0kA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: -txe1-JN2F6pjNtIyveh1eilbAgG_ji3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAyMDE1NCBTYWx0ZWRfX+xV3YNOqZj0H
 xJwaR6g0jHgAKyULJyzgC9OTNrIlFdO33RiKMPxj4Vbs5w//HOX2MSraWmhpMNigkbCLMX4lZFn
 CC1GJxQJwBwOin3DkG9Vd9N0mxIkaEewDa8QQhkNElgxKPbJmrh868Bw5Q7BOj9Qv0zb0CpkReW
 cX3oVfspzZp5E+WX8dLmR1WVyQvmUyUVt4droRIsnLjQzJ0Epb4sZG4F6kYmU9G8ca5oU9Qbrb0
 YRQQEc+nX3tjBMPv9qkOi6lCxZuU9L8vaCpFsg1YpKNG3Nvv5UA5pDA5hsZFPgV18u3EPMc/EmW
 RbMg0KVDxSfY5s44YJ87OPwTZj28nlh1hc62CcGDlpVm0ih9FR8ztqZzlFesuzOnzop7RS24YK9
 NX2ccjAvIfBJjCB228TjakW0svtoDQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512020154

On Tue, Dec 02, 2025 at 10:05:38AM -0800, Jeff Johnson wrote:
> Hi,
> Here's a new pull request for ath10k, ath11k and ath12k.
> 
> Only ath11k is included this cycle.
> 
> Update the board file for two QCA2066 platforms, and update the firmware for
> QCA6698AQ to enable CSI/CFR reporting functionality for IOT products.
> 
> Please let me know if there are any problems.

Thanks, merged and pushed out: https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/814

> 
> Thanks,
> /jeff
> 
> 
> The following changes since commit 38c82f07a964e27c3e71224c1f038a4083ff58b0:
> 
>   Merge branch 'robot/pr-0-1764573234' into 'main' (2025-12-02 00:54:05 +0000)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/ath/linux-firmware.git ath-20251202
> 
> for you to fetch changes up to 15f8543684412387ebfc97a4b99ecd18afdc5e0c:
> 
>   ath11k: QCA6698AQ hw2.1: update to WLAN.HSP.1.1-04866-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1 (2025-12-02 09:53:54 -0800)
> 
> ----------------------------------------------------------------
> Jeff Johnson (2):
>       ath11k: QCA2066 hw2.1: update board-2.bin
>       ath11k: QCA6698AQ hw2.1: update to WLAN.HSP.1.1-04866-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1
> 
>  WHENCE                           |   2 +-
>  ath11k/QCA2066/hw2.1/board-2.bin | Bin 745408 -> 745440 bytes
>  ath11k/QCA6698AQ/hw2.1/amss.bin  | Bin 5005312 -> 5083136 bytes
>  ath11k/QCA6698AQ/hw2.1/m3.bin    | Bin 266684 -> 266684 bytes
>  4 files changed, 1 insertion(+), 1 deletion(-)

-- 
With best wishes
Dmitry

