Return-Path: <linux-wireless+bounces-24579-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E453DAEAA4B
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 01:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 465E74E126A
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 23:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8917E1FBCA1;
	Thu, 26 Jun 2025 23:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AjRecQy6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF2D217F35
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 23:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750979716; cv=none; b=AF4BqTeNQZlzPKpRYvCHhppbs22c6ajJbt8+EaypkkSxvX1GvVdM3Q5FT75vr97FrrPdkzNyhVuwUsLqPBRrc6TU4tLv/eRsrDsDFxmYA8ZT8D42qyNYFVuYMmPxlJ7GI2ofLrejKHCsIPS3dYRiskRvjeDKP5Zxf9aGAkeIKGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750979716; c=relaxed/simple;
	bh=aSc0tl6N7FxaMkghN48RVi2dPCCABt5TI+aKtGozcqY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QUxVe5NkRkRmyditRc+rBDBLDAQcC5XwvgWrmrZGO9vE7tmoGh7AhSOvsTXtkX59FARTThAxkoS4LipC4eWCH9WzA9CdFfcFJ82Zf5artjeZQQlMjDxQMWzOSINTZQ4qIn4E2hMVy1uBir9oOV7eMNx/ou8O0pmsllG/cs9rWEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AjRecQy6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55QJ4qFr029535
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 23:15:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7qeZ7GCDwUB0wspAU08ExZecso0WhfdKZDuLxMXJ7fs=; b=AjRecQy6cI8VaFS+
	SE2vE1IhdWAg7TpT7iUi1GWw1yVwM9GDdkk2rPA+ruQegG0lvKiKCcztDh4blgj+
	HtBACWWnz+mVm+LvYOA979gt7d4F5CK8EmIvKw3fWFSnNlubaRobU59Gb4IN4eeN
	1UkbAe4AKr6K4xaOc5ac16cicpz4PG1YPBTi8E/ZfRYjKwir7WrpofuOBkv6wY1n
	FsjOIvn06JiMZ2gSe7gSCtOxX3lpdLZ2V7v0HhhRC/e2ftRXh99XnSktg4463nnw
	wfomzo6Wc8DQL94cIXHVzrYMbT5DOihlagxpqosx/l+kl3nIpq6beyRi0xmo4yk3
	Xzvliw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47esa4x3nk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 23:15:13 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3132e7266d3so1534506a91.2
        for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 16:15:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750979712; x=1751584512;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7qeZ7GCDwUB0wspAU08ExZecso0WhfdKZDuLxMXJ7fs=;
        b=U5N0KO6cXcXDgUKVjkCHG3OSDJb6aBjK/D+UXTl+Com3QHu9dwdLVP9B29BI7QYGrH
         WoImmn2QhKGTcGfbTFvQxToRGpHKRbgn6BhRc2VQRBNUOuoAdpmxKgsc62tDq1ktV5BU
         k27A/bUyzkYRdD3HE0CnN/GD/CHWKXE2kZ8qLu9lwsN/zImi3ZyM7/+XF1zB/m2RPxEQ
         LjEA4o5j+iIrbFR2so8igiGQfKfcjuiGSm1cMZ+hgtK92fi2CiN6myw+/Z/9LGSZxnGc
         hCIpNztu8W98Wy5bOmUyH7SVnoSGvxWcJjeCANeUrj2JgwZU7ZKqLnSlhitK/Zok/mrs
         Xzpg==
X-Gm-Message-State: AOJu0YzVQvqM4e7DI4MyoC1p6jcTm/vFQCnixAoA4LFnoetjf+8bubQs
	mnIunUjpbfoNTeDCdwCAAgxRBCHiL/1AJTPeB4UiAwTOI27cT2311F6dlG4y0E3XPe1Jc2g1+fc
	7THPYT9odfSXvrYKac8SXGWs8s1DLTCt5pyQi6gD1HvdHSzLuzfX9ltk9F+ngi8WsC9ouNg==
X-Gm-Gg: ASbGncs53DJ2pqxGL4bw3RecTjXO5oG6n/pk9jB6nAOnSui/rWcuwwapva8b466ydgO
	a+ir/mtR5mFZAvDk+n1bnp3gYP3W6aagHgQXeDouaxoFHbR+AdRBrgEr0X7WjpfKVaW3/V8y9ou
	Kx88mQnEG7AA05P305USICcLhRO7GH6/3NZTcuHAAaLJxHRWQZTzaAxDTgr7mBJDlk5BwynjxTC
	ruC4RgkChGNtdkE7r2nro5NeKX11NpmwXAOReW6LNeCIawwYv5FiDBhorZYZ5K2bVjmwsLEEvB/
	BQ0OM6ulKv5NbK081//4oUD2avJz80LolJjnCENKHKzdjijFt0mE2OQ0n4c=
X-Received: by 2002:a17:903:1a4d:b0:237:ed7c:cd0c with SMTP id d9443c01a7336-23ac2d8b52dmr14889065ad.11.1750979712429;
        Thu, 26 Jun 2025 16:15:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2tnvUr5R4y05/ayA00IpnhQO2OSLo2b43usy4w8q5lhNvhwx+xftIt+XJU4+l2F8VfIaP4g==
X-Received: by 2002:a17:903:1a4d:b0:237:ed7c:cd0c with SMTP id d9443c01a7336-23ac2d8b52dmr14888735ad.11.1750979712045;
        Thu, 26 Jun 2025 16:15:12 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3adeeasm1548105ad.156.2025.06.26.16.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 16:15:11 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Baochen Qiang <quic_bqiang@quicinc.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20250612084551.702803-1-senozhatsky@chromium.org>
References: <20250612084551.702803-1-senozhatsky@chromium.org>
Subject: Re: [PATCHv3] wifi: ath11k: clear initialized flag for deinit-ed
 srng lists
Message-Id: <175097971130.153431.12728903041387632447.b4-ty@oss.qualcomm.com>
Date: Thu, 26 Jun 2025 16:15:11 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=eLYTjGp1 c=1 sm=1 tr=0 ts=685dd481 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=pd9zJXUkC5-qadN-W_4A:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: -4hxxNJatnvV_uaRjx8IXDbkhL40sLQT
X-Proofpoint-ORIG-GUID: -4hxxNJatnvV_uaRjx8IXDbkhL40sLQT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDE5OSBTYWx0ZWRfX5PwH52G6V7Yk
 YpAWjsV6ABb6a5aV2Yp9zY6ruYYTL2z+rlD7h8WVRaSGfnqp3gjUZDAp/ygQZlGMYKVKHOmaTfW
 xoTT9U+m3JmqqxlNQvrwVMSTQHNdizmMevA3RDnPhOOj6p6sio/tbaIEIkpyc3mcQbAfk7IFZHi
 Kf1SlsJU5XyP5TRl8etVioLYOKTNbXE7ASqJVLrZUv5itmE847isphbFIAFomK29yiaXoAkkwJp
 crNFr95uX9RAuYmRhD80aZXu1Jzp+Z/SE41mKVlDr+pK5OhLjOt5Utk9N5oagGE/C6fLX+kp+Il
 PDHng5VVly7vZrFkTfX1uvIpt0vJPHtF+lMH33HSV4k+n2/PueWbOpofJwPatVbr2cek5kqW5te
 hyC+be+7YpM1f1Y3nqJGR1hyPt8GKJRTa2Bkc0IOnQSlj8hjCVgkoOD6RVQ0Utps1oGSkp3G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_07,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 mlxscore=0 clxscore=1015 mlxlogscore=979
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506260199


On Thu, 12 Jun 2025 17:45:06 +0900, Sergey Senozhatsky wrote:
> In a number of cases we see kernel panics on resume due
> to ath11k kernel page fault, which happens under the
> following circumstances:
> 
> 1) First ath11k_hal_dump_srng_stats() call
> 
>  Last interrupt received for each group:
>  ath11k_pci 0000:01:00.0: group_id 0 22511ms before
>  ath11k_pci 0000:01:00.0: group_id 1 14440788ms before
>  [..]
>  ath11k_pci 0000:01:00.0: failed to receive control response completion, polling..
>  ath11k_pci 0000:01:00.0: Service connect timeout
>  ath11k_pci 0000:01:00.0: failed to connect to HTT: -110
>  ath11k_pci 0000:01:00.0: failed to start core: -110
>  ath11k_pci 0000:01:00.0: firmware crashed: MHI_CB_EE_RDDM
>  ath11k_pci 0000:01:00.0: already resetting count 2
>  ath11k_pci 0000:01:00.0: failed to wait wlan mode request (mode 4): -110
>  ath11k_pci 0000:01:00.0: qmi failed to send wlan mode off: -110
>  ath11k_pci 0000:01:00.0: failed to reconfigure driver on crash recovery
>  [..]
> 
> [...]

Applied, thanks!

[1/1] wifi: ath11k: clear initialized flag for deinit-ed srng lists
      commit: a5b46aa7cf5f05c213316a018e49a8e086efd98e

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


