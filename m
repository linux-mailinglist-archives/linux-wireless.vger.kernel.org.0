Return-Path: <linux-wireless+bounces-27986-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D1867BE10AF
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Oct 2025 01:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B2C064E7AB5
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Oct 2025 23:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB983191AC;
	Wed, 15 Oct 2025 23:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Geb+KiN0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9579B31691F
	for <linux-wireless@vger.kernel.org>; Wed, 15 Oct 2025 23:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760571631; cv=none; b=LQu6yw3jCS1MzNQi49tvtjkWC6wYzCDF+2MvQab2tJRpm6EUNXTFZGrgCmrtqc+FlxBNCkp3p2iYaMXjUDhwNlzsxohKdYgrr4jfCqAbRDmsUaxe4ZDHwxtqDgZAP8adFSHDETVEYz0bV///a0Eh9DoIyi2xAFAZSXqGZWL8zgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760571631; c=relaxed/simple;
	bh=5G7ZhYyW1+yTfWAQLw2XStW9Ido9fwAuEy2K+h8cipQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YKwFIbXJEUPk1uNMrlls7bZJHjTyEvnO7I0ujRUrAmhA+cJI9Tz/cCGuZmEPh51MEgdOPnLWWITct0Hmf6gHK+YUNqhD63Vm2L6F03UL9dW2rl0g+3k1OaLo7iiShCu9wR71cYFEN/5n6FQNv+jxHPrsVCyx5piAmA2zMRULLI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Geb+KiN0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FJVQDs016735
	for <linux-wireless@vger.kernel.org>; Wed, 15 Oct 2025 23:40:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DzB5aLxCajfa5GMSNAJ4Eb/AVG7nZr0Yfp5fuGdHQqY=; b=Geb+KiN0HfC4pTZe
	dijQRwAwJVpm03rYgKTG3OSCawsLWkWJQ1UVE1lI5Dx+QQLpql4ZTv0QHaXaGGE6
	UalX7FXNhbhkO5qb3DEMeWPDCQBrL4INRkZg77jeADO+DuHIpFUPPPA8uAtUc8id
	0OKGlvLK/Dp40sycl659edd5fkV/eyVb3ODi5VAQI6kCUivqCleHwlMwwPK/NPa9
	GPKPzk2dg6V3bl0xDd62DUcT10tiGfQO4gIb0QTLoXgWZOi7doYpY3jNxNpU52Z4
	wj6AaYUUGO1es//6spYPixPeoPyhPEfg1AsNaQyBLEyxlN3AORrHSjI6bXZNLz5X
	/QkBtg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49rtrtb7gs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 15 Oct 2025 23:40:28 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b63038a6350so976127a12.0
        for <linux-wireless@vger.kernel.org>; Wed, 15 Oct 2025 16:40:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760571627; x=1761176427;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DzB5aLxCajfa5GMSNAJ4Eb/AVG7nZr0Yfp5fuGdHQqY=;
        b=SHw+s5J8PI1aG8HX+WsUsNq/iLoIbE3qHnYDUdPdrSo3d4Ek6ikpxDOPuo81uQJHSD
         f6EiK2HP+Xmzvo6uUtW9G7TcMINi4cdvY2uLtRUxE15XoIW4iWGqBUdCsGOwieEgilGX
         Dt89JtHBf085xABGyduf3vRxquDEuwOu2DNFXbV/EuLAkdtF+uvw3c5P032jj1wALPQQ
         1XRKC5uiC5aYb6r0o1FXDgb+lU17KbLPekOW4G/B9UAL55daYWRkk2jph2nuSLYXxP3T
         rtyCQnpFJsQ15YwJ+8yYa2nQd2uQyOkSYir1L0XynX9mDNAW2VzJAQVwunnZAyjCvV40
         yGUA==
X-Gm-Message-State: AOJu0YzqZHHoFbrSZ3std7JW8gzwc7/rmUxgqHaM7AfOrPNidEaB3maP
	S2F4Dimb4If0Mv1lpHsG1GsI+pJIMsXTuFOFKqABdUBO8/sRLCEnzyd5UNn+JqDLnDx0BFmWABS
	VAuoGGOXPU4iAk2olH/GAIGcniRtwJD2jjDcxJR5T9duNQxoT2h5CjuroaYWPhMaVEql7Iw==
X-Gm-Gg: ASbGncsh/xxt4SDIx2aoxvd1dR9+6YYuBFkUqpu7pGK6BsnLoHGmTnXP0qrlK/jRFgV
	ZiGl0uvPOBxBDt+g7TOBgC/mEuUcowvapsEGI1iFrDITz/ZeqMb4SEsKc0e/uzF5hroloL/Ilvn
	sAoCNYllCVj0v6bJR4bZFZOYPKq6B352vgCf2Tvrd1cHLo+GefqwjxgGyFPy99UKX0KtXgVNbaH
	smx0zhKO0G9MDjxkU8ub1n5YknztdAT93FdwIBZijXu1rX9ZBE5aNlNcHeyQfvYbxTjoGA3nEGm
	vSWqsVHxZx7UrnYP3ej8sEHPG/8d2FJaNKKMn5LbwCwNVGj4HwkCPApHJhZuk/9jPdUrZl3SzjV
	O4FCkb7tKQTU9zl4NSvRD65YWMVryho6rTlo=
X-Received: by 2002:a17:902:f54b:b0:24b:1585:6350 with SMTP id d9443c01a7336-29091ae4cd0mr21934245ad.11.1760571626721;
        Wed, 15 Oct 2025 16:40:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGagydBD16UpR7uTmLN/2+yvKL0NUF0tG5fUuFZf+nep1BW3UPO/UuVky60XXWexQq6YEDFCA==
X-Received: by 2002:a17:902:f54b:b0:24b:1585:6350 with SMTP id d9443c01a7336-29091ae4cd0mr21934045ad.11.1760571626263;
        Wed, 15 Oct 2025 16:40:26 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099a7c255sm8055635ad.70.2025.10.15.16.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 16:40:25 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20251010-ath11k-nuke-wmi_bcn_send_from_host_cmd-v1-1-bfb5118d9018@oss.qualcomm.com>
References: <20251010-ath11k-nuke-wmi_bcn_send_from_host_cmd-v1-1-bfb5118d9018@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath11k: Remove struct
 wmi_bcn_send_from_host_cmd
Message-Id: <176057162556.260563.9941291705002350620.b4-ty@oss.qualcomm.com>
Date: Wed, 15 Oct 2025 16:40:25 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: l1q5Jqf6ko642v2HLS94co-5pTGQc6n5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDAyMiBTYWx0ZWRfXxmCrjKmuoAwL
 xS/tN0+40M+aBWCfBI4fh2yG4b1tdoF4nq1/loLAW8D4nkcLgsVt12CDsHCA+GHUzBMuIRI39wr
 NJ4jZQqni2c7dPFk4bnwbGml887ipz68QrIxF1gb6VHJOo9u3IR30h/032OW1+j2ajvgfaZV9KB
 t5GlIxXkpx5qLpzvybW15brt7IDfR6MawmFQ6a4NuBHd/4cAjiayYScz5qhsJxeGF10arxsOION
 5gNE/or3ClGyaknLruomLPqIFBpLNddnwKm/QVkG2+TnWuSPwausOW3I6m+QITHErm6HO/L32cN
 KA7nizQ9rC6wOcFCwzvYG5CaQk3mc8r18An1aR5w8sQrRz1l0gDRAn0MW8EMzyaVyUn2dY98uR1
 Yscfw1Rt0cjWF3lgtlnF4jXxTKpOjQ==
X-Authority-Analysis: v=2.4 cv=SfD6t/Ru c=1 sm=1 tr=0 ts=68f030ec cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=skVgQ6i2UJWBhP5xJtIA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: l1q5Jqf6ko642v2HLS94co-5pTGQc6n5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130022


On Fri, 10 Oct 2025 09:46:27 -0700, Jeff Johnson wrote:
> struct wmi_bcn_send_from_host_cmd is unused, so remove it.
> 
> Compile tested only.
> 
> 

Applied, thanks!

[1/1] wifi: ath11k: Remove struct wmi_bcn_send_from_host_cmd
      commit: 960fc268a9fc269190014773c81507e695bec3d4

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


