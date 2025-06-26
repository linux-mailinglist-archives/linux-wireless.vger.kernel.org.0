Return-Path: <linux-wireless+bounces-24578-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B42AEAA4C
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 01:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9E241C26D59
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 23:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FC71DED7B;
	Thu, 26 Jun 2025 23:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pYmdYbH0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7E31FBCA1
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 23:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750979714; cv=none; b=Fn0azVH/P/+Zv9DSG63dQjUlGJVzdi/stakNaftIWgCK8UyoKrUck9BedutF++6FrKuLfpWeKySiDeMpbRw2q7LQqaRIIDOGn/x0S9PapE7rsUi0qUUcg/T7BPYeRcLvDbCNuDr16HJuhnJgkX2zBbhw9Bt2yK0cBsJ7Sjl1yfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750979714; c=relaxed/simple;
	bh=G+7wF9yd6vovIyrnA2PHzfa82ugGuBWenVpkTDcIQy0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SdJb+eRC/aqHDVMnEIZHA1A7JlbGNxAFlRoPc6MJYa8lRzfPKCH6ROdpc75ad3gDCWSIUsAbhuD6YVA8JfGwoMlTzblh6HsDJfhCjqYESTQtvSLa6V662bAIZrxDUFw5xv+lVsMP+M77mTqcaQihmQ+9pZoqlD3APRve/JEjv1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pYmdYbH0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55QIdiXJ026643
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 23:15:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	m0YwMxO+jUeFCXEvL4KpijnvGsNmfzPaS3I2nEc0Qic=; b=pYmdYbH0YFfXTLk8
	Rr9gC0YnAwbd0ABqw452uMM9fvyiE5nHtWW381MHIYdL8ZRgTlvCMr/ASLT3k5cG
	zd6dys+dPH5VB83sjh8w3hduoEqGlQP0g53GktULcVS9ohrmlX3GWxBfWmcztRCS
	i4acamPjPT3Ga9m6z6vHXuKOvOdrBo8h9fO7eO1TQZqXxLGPu8fsssOeFyKvVl0H
	GtRctpuy2+lBlPgYXpZ8rdDQ0dhCo5MlRequCmqwPTGzrKcxYkT8xRAwfv5rsHk3
	1RpgydHe8wNBlf2V+COjV3CKx9oONwzZd3SzJ/mgjvjboHj2e8iVCk5juqVLtA/V
	WYvHdg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47evc5wynx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 23:15:12 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-23689228a7fso21445785ad.1
        for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 16:15:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750979711; x=1751584511;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m0YwMxO+jUeFCXEvL4KpijnvGsNmfzPaS3I2nEc0Qic=;
        b=P7TsBgyg7sOYyzXxzLR4Vd7JPQT2xsWfpp4ASGzpXmU93rFcbmj02wVq1x22hAs7BN
         byhiXceMT2wQQI80wCt4bEjVFxDvd7+jKnHURWoHtXg+2GkfQ60JN+XZ7oy7JKmlqE0/
         2NWUbBnA7FOjbIKrUlEHNRjlvnBmZfyYADdIlCx5ZYLSuhXav3zgzHeDrjLSJbsnn1E4
         Htu3+SQJwclen6MyQngMLDSsHwuovoCMdbdMxqsSLoPorufiOKC70zvRbC84cWJ13C+C
         +bSPghyUNCV5wkG7z474XWrH9F2W7hNkmBrsjw6CZPIH++BwqgKH+JIuN+c29CRgcaN/
         H6/Q==
X-Forwarded-Encrypted: i=1; AJvYcCW7nzORvR8mjvqOSYIcKyWQ3IAHACfa5jc7LObc+3nK8CxQuSzz0tKojnszx0llWNpmR2pNn61XBzmBbl3pvQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0u6U3wWNtAJtl1qTwKIWUR3uUN3SbIsUj4kYVNXjQd5AjE6qa
	MHQ/n6vkxfwWPnUNrdZV+6WI1wda+RRA17xq3HUb/0nbG1M6hzF2zByf9ZJTVWO+kPNTATveDFI
	aOnQk8YBL0zesY5OlQUrVFG+ibZahK30Ex1uzwPFSVDvonG/jF5ZGSIhTelrR+U6VbASMNA==
X-Gm-Gg: ASbGncvyDTJYNlEmY9ujwSrFq0xXq70vT/Sq80UfFKlAobHKZHUMutNtpW3bFRiGxp1
	DLUgqGOEO/xWK94Chzm7BdYyYa65IhHi50Oq7CxvzZ4T79aYDFPIX5zNKHALGn8aliznDsIFyiL
	3Olb+vVYtyCgRvZv9YE9wdzrio9seY5CMUg9ilSqwVckBYr7S6ZnHykD2ab0O4KDir2/zGUqS0M
	VqFdUA/vMxwQPIiQnnDdA9jJx8QNDNLMQWcHcBx6vMJG+8vQdyt8JHIzTn1G3pS0Vzs65b8TWtJ
	Ql0rtgf13TUxPc7RxYfkuRwgLOi6kecIvFJ6mpXKsAxh+9sRqcpjPjBY7dM=
X-Received: by 2002:a17:902:ce8d:b0:236:7079:fafd with SMTP id d9443c01a7336-23ac46527ccmr17456625ad.36.1750979711550;
        Thu, 26 Jun 2025 16:15:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtxZAT9RsuczoF4qvzPiB5OMo2NIectyuJIvyMQ1qsmF4ZT12KS1G8XG4t/QvX9V4JDG5Znw==
X-Received: by 2002:a17:902:ce8d:b0:236:7079:fafd with SMTP id d9443c01a7336-23ac46527ccmr17456035ad.36.1750979711051;
        Thu, 26 Jun 2025 16:15:11 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3adeeasm1548105ad.156.2025.06.26.16.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 16:15:10 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: jjohnson@kernel.org, johannes@sipsolutions.net, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20250522013444.1301330-1-miaoqing.pan@oss.qualcomm.com>
References: <20250522013444.1301330-1-miaoqing.pan@oss.qualcomm.com>
Subject: Re: [PATCH ath-next 0/2] wifi: ath11k: support usercase-specific
 firmware overrides
Message-Id: <175097971004.153431.2672795252438495643.b4-ty@oss.qualcomm.com>
Date: Thu, 26 Jun 2025 16:15:10 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: B6zRG9i9mge3r_SvdYuCPh5biYKM8Jxq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDE5OSBTYWx0ZWRfX+KKBiJCc1Rg2
 DEL53KQMdJXzsivHQAer2WN4FR1UkRzEqVhuie0QbmpSu3sKvKyYmlhdT2cowUQQPyLMJqb5GWf
 DWWcX88SQpbJA/8BJvcwYt/TPlC2LASd5uIpx2Mh3NP9ub2BaXNdDO94BSyhr1HUZKI+ylJUXEW
 63sp5Gank7S4sKu67BssZRtOi4xkKZtmEni6HwOSXD7lxhvbD6PbFE3yqngIUdfP+gaXlrsKrbb
 XfCr+0tpxZyRZlPtIV8qoyeQwM4SD9mDYcCvrW0x9uH8jTzQfITw13A9TDtWn1xBTYHgbakpOBo
 Pa1C+tel3bHK0ZXfo6lhwJ6Z9juXGSPf4Qpaj6Aq8Xo87NZp5EerdzlM1Ti7TN/v9lokrecgHgf
 GiVZ70mnvMJc74fI1obvSBsuDqtIr8KbyKkLDKJ1dlyc1guJxUY33LxkOI4RGi4TqbD5zhBO
X-Authority-Analysis: v=2.4 cv=caHSrmDM c=1 sm=1 tr=0 ts=685dd480 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=ZHLDmf7C8hvfDcYlofMA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: B6zRG9i9mge3r_SvdYuCPh5biYKM8Jxq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_07,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxlogscore=806 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 mlxscore=0 spamscore=0
 malwarescore=0 phishscore=0 clxscore=1015 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506260199


On Thu, 22 May 2025 09:34:42 +0800, Miaoqing Pan wrote:
> Introduce 'firmware-name' property to allow end-users and/or integrators to
> decide which usecase-specific firmware to run on the WCN6855.
> 
> Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
> 
> Miaoqing Pan (2):
>   dt-bindings: net: wireless: ath11k-pci: describe firmware-name
>     property
>   wifi: ath11k: support usercase-specific firmware overrides
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: net: wireless: ath11k-pci: describe firmware-name property
      commit: 02dcb6921b8827782e51e26593d4a2866576ab63
[2/2] wifi: ath11k: support usercase-specific firmware overrides
      commit: edbbc647c4f36e8a6375d07ecb5aad8e8b90de5e

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


