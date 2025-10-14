Return-Path: <linux-wireless+bounces-27972-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7202FBDB18F
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Oct 2025 21:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2747F42138F
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Oct 2025 19:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6202F2C375A;
	Tue, 14 Oct 2025 19:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SyR9iHL1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960B113C8EA
	for <linux-wireless@vger.kernel.org>; Tue, 14 Oct 2025 19:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760470961; cv=none; b=bV2T5Vc/yjNuRLLnArizV76AJYtAIMXd4oCNszn0z9lcL0CvJolTmIYJFKiQjm3AZzxZ/Z6X08KQZ4y6MW8Wkf99PZsQwo99P2+3VeGMxZDDAnm7zxbW+nrvA4TdlEm1Lo9E5jNBDkUlgNB4ZNuOeGHr8ocS+Uh6E2xUu9AfPbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760470961; c=relaxed/simple;
	bh=2w0OhVkvnqpMVxyWLgeAGvU/GU1+uEwxJVS3uCjOURM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QDahu0QcEcx20z+2E8EzL97dT+WqfsYKrgWA9p2ulafG/kbhEp5lQH315OsFREbbDkQJ3CBJdkweucQyP00gku/NzpoBHqyMkgpJ0rFYCpMdcMX517T8SIXX90+qZhuFMDNDlfuQJdWiyBEtoSOqJIpo9yxPS2/2ZlzV8KV1rBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SyR9iHL1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59EFc9Tg008894
	for <linux-wireless@vger.kernel.org>; Tue, 14 Oct 2025 19:42:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2w0OhVkvnqpMVxyWLgeAGvU/GU1+uEwxJVS3uCjOURM=; b=SyR9iHL1pvupWiM5
	+q7vsipHk80xBqckt3H1wwpuByrGKvH5B5wkWw3zJ/Z869cdcwC3PCos3tujb3IT
	nv9KUclG30dG6MkgwUlLDhHyUm1clnL3gUbPTgKpr7u3dm6I9YMgX1bT6GpAsIMa
	NyDRfdZo5Cwm2srC6OQ+UtIWeTICXCHBd6RTH96ctmgUS2bEuRqL2wqEmITG4VF9
	uDfY+woTlRxJuP7TsnYvjq2KJ91dhu4a4uHuxr6q6rGqlZLfS+zLjeeQGyu0cKIy
	QdgOU+XnoVvtviq8Yt6xOR5qiRsHIBg47PuLGK2PMdMCh5UKnpF650LKLlzL4e4R
	MFcZMw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49rtrt6n5k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 14 Oct 2025 19:42:38 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8635d475556so1406814585a.0
        for <linux-wireless@vger.kernel.org>; Tue, 14 Oct 2025 12:42:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760470957; x=1761075757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2w0OhVkvnqpMVxyWLgeAGvU/GU1+uEwxJVS3uCjOURM=;
        b=hI9Fj39RiEho2jjaF/Ji5bI3EYUTZfAxaKaqMPTPU/OquR16IJWi44JcAtGMdOo59u
         6DudPnLzbS5SHjDvIUiYX2RrrG7jL8B4OjTfFlHd1yb6RyA1p//XT29Y0QJh0YD3HIIq
         FCeVmosGW/Ii0f8VdRiB70N7aRTGx1JJ0dojAH0TTRdaRQChkdeS79WE7kNppJknEfm4
         +zn42V1orhFayyzxSXfOowhg6Yt+WRETAbsHqUGJnqwM2CWP+YRNLuRR5tdlylvk3p6P
         grY7+e/f6p9muOZD0y/+kgp2n2hbb/TipFxPoIcGjivnzAJk6FAlc/nsR6W1gaJw/o4d
         tTrQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4KB2mtt//mI6HlCAWRT+TmQY5e6iCi+hWXPfCaWuJ8HxmDQGCnfQx/eKXWxIM7fF88EsBKW9JXGOhTzEjjw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2uk/jXUQm7fVDTRR3wEz98C6kLoTq6IdPUU8FQjVOXsY0PHA/
	UbfiQUVceuXd9SqtX8Jd6kCqiTC5TNwO0I+sJhpouexq4cI2I5XVWxrqpUv9n2R13eNWE6NOy3p
	TRUqU9xRLr+aqG22kUEcmj65LXG7tcloy+/nRxIh0uaCVfi1Ra37JfOfll8/0xhFOU3Kwf3O/2/
	qWK4NEt7jlGsaH8JkKQCNBFJI6ASKvzJuRkHbm0a5xBCRf
X-Gm-Gg: ASbGnctkbmPtRVnZlrZBE6q03l1J5vD6JTJSz+BmzMnMhRbJXjB7XgezBkO17VEtApN
	2erqItCKZ9+blZxr5zitwrGgszmMX+pll4RWUBAo9BqqVr+MJzWkdZ/62bJZnY0RrfF1RB414oz
	FnvdBs839/N/EFkwvMrr7mxmN5Gxtwpkj5AYpzZEnWRkWLTNmzNoekTA==
X-Received: by 2002:a05:620a:2a0b:b0:827:b6d0:3896 with SMTP id af79cd13be357-8835069a1damr3630596285a.0.1760470957554;
        Tue, 14 Oct 2025 12:42:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHy3sTRoJsTak90pgrQQ8wD0f2bthSMA/ymChE+mOsrkVzDaV2i1I2/Kh6A+2MXfghhSWBFEQg/Rjz1F8Lf84Q=
X-Received: by 2002:a05:620a:2a0b:b0:827:b6d0:3896 with SMTP id
 af79cd13be357-8835069a1damr3630593685a.0.1760470957071; Tue, 14 Oct 2025
 12:42:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251011001038.352393-1-linux@treblig.org>
In-Reply-To: <20251011001038.352393-1-linux@treblig.org>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 14 Oct 2025 21:42:26 +0200
X-Gm-Features: AS18NWCzGHahCTCoi4NKzxpX1pOXRnYv-7AhbWeCyZ6P7MJDMKYseIP7279m4TM
Message-ID: <CAFEp6-030D5f1NMasJ8=PPqgRpY9aNZqxXjrXLHa8gfaYcKj5g@mail.gmail.com>
Subject: Re: [PATCH v2] wifi: wcn36xx: Remove unused wcn36xx_smd_update_scan_params
To: linux@treblig.org
Cc: jeff.johnson@oss.qualcomm.com, linux-kernel@vger.kernel.org,
        wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: QanM7G-Ob0hX0WiyICWdASYk0QWZMd0r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDAyMiBTYWx0ZWRfXze5TpbsxsIwL
 WCn0Fyki2zlXeoPFzZVm3rnqSQD+0j77tu5BgPghTmtpeFSKdiMMg9hYdR68/FJ5HyWCJNP0aMG
 zI6hWIj8vGU1Riqt9/LRukWdD6jC6uxjnMB59FECYJOJiClmFxjfASwsdxiHifm9Iv9NC00HoML
 b5cOAtgquggSNHJwxNOJWWd7E35ttqFwxfeG+7Y50ZixRGkxfLY7Fb1/UBwKYeYH33leekJp5Sd
 b7b/76RS5BTlkvKNUhx0CWM40CDYXJFH5zyr2c01WGcINeireKnKwaSpF2TivCrFKMIoHP67VPM
 1UxywRW3SUeCZYfMxb4Lc1yYIpMqrJC9loZc4eaMjdPaVCqI54lyH0uHH/7thHEA+MnFWbLC1gN
 wZnMhVbLFyKLXyxjQ7ZG/HxYFTIgCw==
X-Authority-Analysis: v=2.4 cv=SfD6t/Ru c=1 sm=1 tr=0 ts=68eea7ae cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=3WJfbomfAAAA:8 a=EUspDBNiAAAA:8
 a=dNIyxH4hxPn-D1A5x2sA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=1cNuO-ABBywtgFSQhe9S:22
X-Proofpoint-GUID: QanM7G-Ob0hX0WiyICWdASYk0QWZMd0r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130022

On Sat, Oct 11, 2025 at 2:10=E2=80=AFAM <linux@treblig.org> wrote:
>
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> wcn36xx_smd_update_scan_params() last use was removed in 2020 by
> commit 5973a2947430 ("wcn36xx: Fix software-driven scan")
>
> Remove it.
>
> This leaves the wcn36xx_hal_update_scan_params_req_ex and
> wcn36xx_hal_update_scan_params_resp structs unused.
>
> Remove them, together with the unused
> wcn36xx_hal_update_scan_params_req.
>
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Acked-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

