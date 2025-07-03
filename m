Return-Path: <linux-wireless+bounces-24802-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 660D5AF8383
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Jul 2025 00:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C97BD1C87C5B
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Jul 2025 22:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE46528A1C9;
	Thu,  3 Jul 2025 22:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CWyUayD+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BEE1A3BC0
	for <linux-wireless@vger.kernel.org>; Thu,  3 Jul 2025 22:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751582307; cv=none; b=BysISAdJ+pVJ91zB/12eePg8XUAD+qcTWW4uBdgN6eEV/xLe3Z4YwiLhKzXhkXeDhkiZLlq3MN74v+y2LXkG3Jg2m2mlPis4aq4j/uWawvILLta0HYF9NyD6Z1oDm3tbh+8uzN0Oamh4yYioPMdWzB2CxoMQ2iDp1lYelH2Sg1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751582307; c=relaxed/simple;
	bh=J8XOG8z5CAZ0QFR2Y5pf+7IGDzVvnEwa+Oq5Pi+SeRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RQ9jCSZ8PfXT8ASbIFkTgFpOoN6b6+8Fqojf13DUpiAxhzBdnQMmvh6CG3mbTpmqc0iO2kLumE1AgXeqThFUh5t4aqp8lEpaAfjiH+x3KqIwl1qIQpddkQuIgIbHotk7ZapTnudBB0S0r1qLi0/d4OHpYTuyzIBGMJrCkwrGm5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CWyUayD+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 563DfBPT007732
	for <linux-wireless@vger.kernel.org>; Thu, 3 Jul 2025 22:38:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G66uk6oLrJa+bE3tPC6EUtvc6W8R4jWMeiXs6Py51D8=; b=CWyUayD+8Bux6HrS
	CXSgMVfZdWOYL4PH1XzrD0XHMeNGifHqaXcXt3dSsVnScByMnmAkiQRTpL7Rwruf
	tkl+NV8VC8/mMl2p2UjTD6e/32uJajCEkw9ysfYert8V9Qs/l9Ij2Ztb0TW1zjn5
	Hi5Oic5NDb728rQvotIGsYRtInx+ZUoxbHQzTnOu6VLUFqldf0wY3+3zwsg3/53O
	Lo5F93pr4Ihri0ZI6Ija+X6iZ3R4XVvTn4UsbN3CVm08y+Uu9OMdOivvlHPYHQXM
	tOvQgY66FqQkZzZ4bdZCQZoEqnGrWWIdG2uJQViBPXBP5PK93LOpeYC5y4lbZmMJ
	w9OG2Q==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47napw4465-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 03 Jul 2025 22:38:25 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b2eb60594e8so201721a12.1
        for <linux-wireless@vger.kernel.org>; Thu, 03 Jul 2025 15:38:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751582304; x=1752187104;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G66uk6oLrJa+bE3tPC6EUtvc6W8R4jWMeiXs6Py51D8=;
        b=mjoHq1rYfWTnyY6EO+egVKGikcWCodX8W469mJBzsxRPaWeYkwuXM2gvEeYlY04Jfh
         vVI4lgTPSFEapH+xgzpnG/t02odmQ9lmbEfcKHYOX9O/NUv5NqippSAiC2utwL58va6y
         bWK98mTyEVmBm6u7laGNKuBxYSlqCiWExrbQjjp8vvZ3NFYfV4d5ecS99pnG3itMOY3H
         ma7OIvsSL5/ezYucOGp6ckidMNIahB6C9m+FPJt1rmUBCYIcJpesPTyCChTAytHpDrpH
         jqusq52CxQ98dXhqxcKyer5gcHhqxzaBizhQs5/lHYlmEYsAHhmWNDKzy0q/c1oC2xxi
         F6aA==
X-Gm-Message-State: AOJu0Ywl7BMCA/k9+ODqqt/PBgSL75GY/DSbgG5KOjopMv62IgMSoiS9
	xHMc834e0yEX9szCmBLuU2phJ9B6CtCxAKKtdqMLrF0mTGeHnkcmhJz6F49s6ur7Dvh5ovFDmHv
	jOakBVzOKhVAjDCs7PRHwEP2rwPOXepAtLWXSxvmZ6kgn5/mTWVO/44oqT+bxWCDaer5NIA==
X-Gm-Gg: ASbGncvyrMt50Pl4RevKTZ8+gAmFVOGOOFB0jg8Bo9yzO0fBRsNZTmukx1Cgnl+Zo81
	eNA1IMPpY1PqOlsqYhgmXaRAOak4Se5ctgaQRx7P2hJ0nyTu80jqcDiorLiMJIxgFxxL2Jw8WGD
	RDFf6es2QtzdQzS8BqFkNgOVD9wYFYZNiJTSutT/SLaKRygurwzQtgmdyB1rpTI3kCN/Hf8+zzF
	V177iToC3+OsvVs99S99eVkgHRJocYR+NKC4upNQxKjnhNHOSYowIfsd6P3ZEV41KD7qYnbeSpE
	TmJ5w11FomnBYM14lwMUshyfl4zBtgqDYtBEitHSoIzu0lfjqZKTVCKI000l4j0mFJNkoL7vZfd
	QC7Q7R3zuL04h2xM=
X-Received: by 2002:a05:6a21:9989:b0:215:f6ab:cf77 with SMTP id adf61e73a8af0-225b9a84143mr678861637.23.1751582304166;
        Thu, 03 Jul 2025 15:38:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpT4Lpx7Qr7u2DGYV2UWbI8VMttTXhwYx8YoVd9mUgEjIMP8UGVB0SwmR2RW7RvDWCQB5IHA==
X-Received: by 2002:a05:6a21:9989:b0:215:f6ab:cf77 with SMTP id adf61e73a8af0-225b9a84143mr678833637.23.1751582303769;
        Thu, 03 Jul 2025 15:38:23 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee4a40c2sm559085a12.33.2025.07.03.15.38.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jul 2025 15:38:23 -0700 (PDT)
Message-ID: <339f0d83-a28a-41f2-99ce-3fde0b5ef95e@oss.qualcomm.com>
Date: Thu, 3 Jul 2025 15:38:21 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wireless: Use of_reserved_mem_region_to_resource() for
 "memory-region"
To: "Rob Herring (Arm)" <robh@kernel.org>, Jeff Johnson
 <jjohnson@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org, ath11k@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20250703183502.2074538-1-robh@kernel.org>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250703183502.2074538-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dIKmmPZb c=1 sm=1 tr=0 ts=68670661 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=iqVkCsNWeGCx9g_Yh1UA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAzMDE4NiBTYWx0ZWRfX7lngbaVgsR8n
 gPG8LLoJpbL/E7oscAU7K9kBoWy5PQCMIhnetGu0JDkJ6c30eJx4MIadendGWB3RA0/dDhs8WGE
 rISOlv7houL26yGomtm9froYrgL9zgrm5RfqPAMYBwVed55KAE9wOGf7AKelnh2mFyBmcWacgm3
 5oMWALR/Xc6ne5mhbVqL+SdnroYDum3bRGDs7SE3OPTW40JJVjNWicHuZAjGFcqXdjyOWFyOODC
 GU74xE7C0Jq82aHr2w8Jg7Go05LH4e2jFJbIb1eTtzyXoZ5MkrgTfatj1qaDsSpZ4w1dg6diKaK
 0LEnIXRmx/Y3DlsMWnGUwhRPdeovLs7m6R2wNBE/LkGLBnh6K8PptTTLTa8rsvbMDMSxS8pCfSp
 weLWYJd+AmEm4X5N+bCQIMXX5NYQLzcXtZ4D1mDJe2fLQshcCYsf1CiMi9BCF5ASsdPo+x2M
X-Proofpoint-GUID: _idBK5SHdPe27sGCx9mfxQDArrLOzg7d
X-Proofpoint-ORIG-GUID: _idBK5SHdPe27sGCx9mfxQDArrLOzg7d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-03_06,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 adultscore=0 mlxlogscore=641 phishscore=0
 suspectscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507030186

On 7/3/2025 11:35 AM, Rob Herring (Arm) wrote:
> Use the newly added of_reserved_mem_region_to_resource() function to
> handle "memory-region" properties.
> 
> The error handling is a bit different for ath10k. "memory-region" is
> optional, so failed lookup is not an error. But then an error in
> of_address_to_resource() is treated as an error. However, that
> distinction is not really important. Either the region is available
> and usable or it is not. So now, it is just
> of_reserved_mem_region_to_resource() which is checked for an error.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  drivers/net/wireless/ath/ath10k/snoc.c        | 14 +++----------
>  drivers/net/wireless/ath/ath11k/ahb.c         | 17 +++------------
>  drivers/net/wireless/ath/ath11k/qmi.c         | 17 ++++-----------
>  .../net/wireless/mediatek/mt76/mt7915/soc.c   | 21 +++++++------------
>  4 files changed, 18 insertions(+), 51 deletions(-)

Can you split the patch into 'ath' and 'mediatek' since those drivers go
through different trees.

/jeff

