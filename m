Return-Path: <linux-wireless+bounces-25410-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5976BB04ABC
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 00:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 935974A4A76
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 22:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAF6236A73;
	Mon, 14 Jul 2025 22:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cLnbG/TV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B67C230BD9
	for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 22:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752532424; cv=none; b=lril0HRWp1D6OUlMtGtMpvySPvlGAfyxZNUN1KJ/dCL/4Soo8u3czaE6BUGdkzlVLWKemNNrE7dg1ikcLB+t+oFWsnzEm8LQJPdyPa49EaZHw7t+pe0C1P6pQbOX0MFn+uzLX/YNZejrTUCrVIznTb9Gk0FXwhIjVDYis6iwBP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752532424; c=relaxed/simple;
	bh=bunis5LfXrPX5VTCd+1M7mKLIy9OUoNx+GoYz1o1G4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQEzQ2oVWLKmXHlwQ9USWbqLAWlPRwnTog8hG+HMUXg7eOrhAoN27mmOh2S1bKg6Gvgjp1yNHhknNDo9TOski7WXR2BQfXFuIBe3XfCk/iPlGKIR3HaPCnvDNk6xbStL1tMfuYWchdPzJjZVHGd+DRrRw3Ah6QR3it6OeHbbxyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cLnbG/TV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EGSO1d022401
	for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 22:33:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jin39v5RU2OC6taZwVEep++H4MP+V5H7HkCH2SULjQw=; b=cLnbG/TVb7wqSU9v
	zXIC8UP2dgJsrBQ/B49OUI5+PtwnNpBuqPs7LZhg2O42Jmd6A5PxQw/dh/SgKwIK
	EzxjQqEWQRmCdeUQFQHRPpkwOCxY4f4rXXUTe31S63/hhRRkKLWIKjFeAoW1IYUe
	VTohsGPvpiI51AuRT5/LwE4T/NbaSkfokgp8/Pgadh9/CNNOKetIbDQf7wWyq8Tu
	5phMJwzNcqPQV7F/zdmW7gUKxPcm9lXFrY0cB1IfKmQ/iOvEKpx1CnImyFgedVEU
	ONa83X4bOFlrR9FXvS9Xgr1nrLa9HgxCtFlv94cLsUbt14wEBqu0s9+Sqpdour2l
	pcPwew==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dw0u4d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 22:33:42 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7da0850c9e5so797692485a.0
        for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 15:33:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752532421; x=1753137221;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jin39v5RU2OC6taZwVEep++H4MP+V5H7HkCH2SULjQw=;
        b=hQVrfYZ3P/gZlIOWG0amBNeh/yFY8zV2MiHeug8qnCHv9K0uPi+QyvpBG9HYQnbRWW
         nj+GJ0RCi7z3iMzkniBR5a2gMjoi0t3J1nwVaEZH01pLqI91zMkAL4lteW6+6GKvT/0Y
         CSyVX0mHEjXYWXR2p9k4ouw18lWwGlCjNvD14lO7gXYfxrXxHUg9HcgGS3Kk0aiPlGz/
         nLaB9CgAEECZqmH+W/SQ/Ba1bxUlqtG3oV+QHRqNgRoSC9sEYlc1VjZZAIIk2S1LeyX5
         Z43ZphMn/qEeKdZsLKZDfHMxDnLQCxI6i+4gk7nDJTWRbChH4DTciNHMwl8iSwyNK0MH
         EhvQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0Cah5hvWB62NlVW/yfOy6gv9R23lTXb8mRfiNggruUsXoUyUdYX7SrmQxNXbe+smRn5B5Uczy4mzb0u7dQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt8zmBZqfBNRGzJWat13tVVrVz2mvJ4yCEF9Qdd2gqmlJuMt2Z
	ufij/nLBPwMeG+oCFh7puOzRCtPMoOTStbp3BiuUsESlniaIBBeQjx9IoqmUetBP2hpqIJVhGVu
	HVFPvqjLQPRMVR67iIknwbfDJ7W5fB7u6FXF9RlKSR3MYg+I+s/ja6+ZrQAUGTOSSizTj8g==
X-Gm-Gg: ASbGnctNSV9XIxE0VeR8WHQZHgPecIzvD+Ax8drT3R9HAghKejP2TDhbdxnEU/8SnPR
	LCDM9zaEIN/WOJLYoy7nAsEPrtGAuu90I8kan+0NN4exmVzt9xW/Kl1tI+69ZalXeTEfR8/KBCT
	rpTCW04quL1OzLK1t3RbH+2GvCLBFLLePrbUHwRJlZLALUqkOFDav+plpkwutXkwRk0vM4rdujb
	6sochG1u4urvoQKCP2fOTz+vICCs4/qXbnKdZloUCb1+rHQqNuD6jAMsxy5JT7wK5T9iknb8lPR
	PhHrZs65YXcSzODH4EVTIYBz3A/Tf0G0jjdMHi9l+a5Zc0uu28Ea0veyau31Ksx5sJzXQJCSIv0
	DHGH96Uh61coD7LEu/ChKorkRgBixgZR9tmUhueBQnDaselYBcpVF
X-Received: by 2002:a05:620a:472c:b0:7d7:891:83f with SMTP id af79cd13be357-7e338d264c6mr102022585a.50.1752532420660;
        Mon, 14 Jul 2025 15:33:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCqBgY+159Vec1cfE9dZ+u3XhxSpLqUZeIaerPTNko5JEPCLrdG5Wtqgg6IXPtXcsQrNQU6A==
X-Received: by 2002:a05:620a:472c:b0:7d7:891:83f with SMTP id af79cd13be357-7e338d264c6mr102017785a.50.1752532420066;
        Mon, 14 Jul 2025 15:33:40 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32fa2930e70sm17078441fa.33.2025.07.14.15.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 15:33:39 -0700 (PDT)
Date: Tue, 15 Jul 2025 01:33:37 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Dale Whinham <daleyo@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        =?utf-8?B?SsOpcsO0bWU=?= de Bretagne <jerome.debretagne@gmail.com>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        ath12k@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/9 RFC] dt-bindings: wireless: ath12k: Add
 disable-rfkill property
Message-ID: <prrra3lon2p4pugkgeytf5ow5wls62lfdnwcdykztw3qzwity2@d26aqh6wdyln>
References: <20250714173554.14223-1-daleyo@gmail.com>
 <20250714173554.14223-8-daleyo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250714173554.14223-8-daleyo@gmail.com>
X-Proofpoint-GUID: giimcG9IqVlBWHZm_zELmqCyldym-5C7
X-Proofpoint-ORIG-GUID: giimcG9IqVlBWHZm_zELmqCyldym-5C7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDE1NyBTYWx0ZWRfXzgB88mYfjyt3
 0+Loft0j6Cz0MsdKE9+WSf1ChCLZ3g2Flu1PDJbdXdBA845JFT8ALynjciCl2mBApfuCgmFCzC5
 /hoBPQrP3yNWsUnJr4aqvMOy2X+YUjs4ureoo/rz3JDFtVPxMZZZCCnYOBh7u34dkxNQIYxxy8d
 to9BcCwo0AkzBQWAW4+oR/RbmpuebVw6xQG3QsaRSNgHPCw2aNzyY6SGUUMCKfFR7+nmb7dE5UX
 gafDGiCR4AwCmF/G+VNh7yOKzqhljcb/s6KOLDAQC+WDdTdSxLvFygW1sfCu/z6hvyPDkvSM/1m
 gLmX0jVQ7Py/LtSTsjPUPxTMvScsgqtECrncfsncqhxiA5xqdE8np6KbdRW2WvOO1qs2rL4362R
 06jK23hyazeYG3Zn8oF3TWf9clvuAf4nWmTjjGCBUOW0IyuqA9gC2jyGahijmJzdMYBpj93S
X-Authority-Analysis: v=2.4 cv=CJQqXQrD c=1 sm=1 tr=0 ts=687585c6 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Wb1JkmetP80A:10 a=pGLkceISAAAA:8 a=g818jjc2pSN6WLbPb0IA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_02,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxlogscore=999 suspectscore=0 impostorscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 bulkscore=0
 clxscore=1011 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140157

On Mon, Jul 14, 2025 at 06:35:43PM +0100, Dale Whinham wrote:
> From: Jérôme de Bretagne <jerome.debretagne@gmail.com>
> 
> Document the disable-rfkill property.

Why? What does it mean? Why are you describing Linux driver firmware in
the DT?

> 
> Signed-off-by: Jérôme de Bretagne <jerome.debretagne@gmail.com>
> Signed-off-by: Dale Whinham <daleyo@gmail.com>
> ---
>  .../devicetree/bindings/net/wireless/qcom,ath12k.yaml          | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml
> index 9e557cb838c7..f15b630fb034 100644
> --- a/Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml
> +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml
> @@ -48,6 +48,9 @@ properties:
>    vddpcie1p8-supply:
>      description: VDD_PCIE_1P8 supply regulator handle
>  
> +  disable-rfkill:
> +    type: boolean
> +
>  required:
>    - compatible
>    - reg
> -- 
> 2.50.1
> 

-- 
With best wishes
Dmitry

