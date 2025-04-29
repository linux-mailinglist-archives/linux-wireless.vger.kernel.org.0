Return-Path: <linux-wireless+bounces-22203-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CD0AA13CE
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 19:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04B7A189CE73
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 17:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B0A7E110;
	Tue, 29 Apr 2025 17:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZECioE4p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E5F211A0B
	for <linux-wireless@vger.kernel.org>; Tue, 29 Apr 2025 17:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745946345; cv=none; b=ZKcfR3/1WY6rcSyD2zu28oAFqPPUYTvTvOuscVJAdWvebaRE6RLxnPXMj8NzxbtdnaKZdDDGVINyx42EAZajUykiiojYqw7QuZWduE7ZCjK1Lp6nRSxsR+YaAXkf4pzVUh7RwOuWS6pdPtNekjphYYmQlnQisaab5H/bc/dLVdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745946345; c=relaxed/simple;
	bh=aw6WfxALxNmAsksGcltpK2jMtMQIauKRueN8TXiZSzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C5hx7jzVaiRpKakWa6zzzRGAKiw8adXIGuDJEkN9hv8YPC1EHJzPn7XCE19cG5C9aXLkG4kxP10T7S9WrJVZei8CyPJosU8k9BY9l4T13Iuj9Iu+amK5Ffxd8w4GmwlJdlXfq1TBlRTQnLJFKgMTZ3AqXz/pKtL9gIE8NFpfcbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZECioE4p; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53T9l2mN011871
	for <linux-wireless@vger.kernel.org>; Tue, 29 Apr 2025 17:05:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+BeRUPh5CwyEHNhQxM8dLF8a/Be260QZjKornLWq5+w=; b=ZECioE4poFwTvAHH
	o+ImugQNlVLFd2N7tWw+i9FwKtPEUBDbHBbmNrhFOoAIU52FbVPeRih06dnjTqDu
	PVmESnMlD8UjkSOgLgQ12yK2aEOTPELIrshJMYJStSxSYEcjJqoaVudwqkgxrpPt
	m7ROOoDH08k45bAEmSIM7mRc0sNrtNDMXCqLLI6ZhSxD4Kgtb4tTEbssH2DoSNeS
	lc3MAWEyxb4/adZhqayAwvS7vS9AEs1qHJ9bkf98Fosnqj/FLKhIfykJh2QbXNts
	3igKP6Tv4svPd2DawmtqZmgUQtSlmE3obYvJ3xbgzi404f/vRv0OlpygF9sqNzn/
	29gn7Q==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 468pg9daf3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 29 Apr 2025 17:05:42 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-6c8f99fef10so6541644a12.3
        for <linux-wireless@vger.kernel.org>; Tue, 29 Apr 2025 10:05:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745946341; x=1746551141;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+BeRUPh5CwyEHNhQxM8dLF8a/Be260QZjKornLWq5+w=;
        b=aTKYGAtPdX1tBUlTXzbEjjyVDOq/KJWPZiW07fIaA60sxNb0S5t6O3K+0BaaXGG3PI
         AgAZtYHoV+OhJioBoVTuDV2aEVTM+fI/W6s6UsISp10iXbm3b2XgvRWYNTnSQDWQK/t8
         psRcTJY9H2rdzan+uo/VVkFMXp0ZYQIGHfu/ZgdFbCn/7DV597fU8ls7iChS3uzYMCJs
         6g0vdnUu9/OrDgRqLdMpjOJEwiknMja8XArLbBC1li0Desr0Jb486bT18OCwnN8j1I6A
         JkM9pK00fVgk9vW61z7QN2o+eaQs5dus6ht1cjPVm6/A2rMIujohhBwZM5B5XekmDrU+
         LM6w==
X-Gm-Message-State: AOJu0YwwxOEddZqQhPyl/8ycGB3bkU+MvT9rjAkNuIaJtmSXnK7ABjmg
	c1sTeRunBYMr61H6qDxhbC7d9NgTsmmA8WcsQPG4ZBFgCVhfmwidye41MVAssfUgQzTuOu8S4wp
	dxy2o9TgOOGc5GLpGtDM+4vGniT1LfB1bNidcOVKMa2gkmbts+5FeKBNhBTpMEPZhuA==
X-Gm-Gg: ASbGncudDsSmPR+jOan184DkdPzOxif6U/mHjO+20QGN5tHEqIvrnWyYalhgbmp9gHU
	6PqStOcXQlLLAW/Fhap40FrI0lCnKjXpMKtnb3sZ3YmYFhvNYszgKSK79wtCF+PSNkhR19Ek7K1
	mBh/ibEp/bKSetMaZtVURI5ykr8ywFGT6o2ERt0uffVFMMBtinR01SoKJeIVsXqF6CwVwDM90R1
	N8orlBlmdbjnAxyV1D6p3YPJBykvRv+1Pbfylk/zLJ+asnbV9EeC7mB9pooe8Zk9dekA4Ey8g2t
	/QgiaEUJKm63iPF8S60eoGmfSdxaoceWsjWGeNkiRaZNFSFVLDczx2ySeAof2aQSKPedZiBrdRe
	tJ546
X-Received: by 2002:a17:903:910:b0:223:6180:1bf7 with SMTP id d9443c01a7336-22df35761f2mr1957115ad.42.1745946340986;
        Tue, 29 Apr 2025 10:05:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeKvxlItGhJsW/F3o2/QxuNoWE7hUAA2vJZ6boPbJqtL5VKAj5jHnUGoJ9xfQtFHQK5H/Wuw==
X-Received: by 2002:a17:903:910:b0:223:6180:1bf7 with SMTP id d9443c01a7336-22df35761f2mr1956735ad.42.1745946340640;
        Tue, 29 Apr 2025 10:05:40 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4dc7b7asm105963485ad.102.2025.04.29.10.05.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 10:05:40 -0700 (PDT)
Message-ID: <97bea1c0-116c-4856-920c-08521d15f624@oss.qualcomm.com>
Date: Tue, 29 Apr 2025 10:05:39 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 1/2] wifi: ath12k: Reorder and relocate the
 release of resources in ath12k_core_deinit()
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>,
        Yingying Tang <quic_yintang@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250423055650.16230-1-quic_yintang@quicinc.com>
 <20250423055650.16230-2-quic_yintang@quicinc.com>
 <28403304-bb8c-432b-9130-40af69bf8c66@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <28403304-bb8c-432b-9130-40af69bf8c66@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ZpvtK87G c=1 sm=1 tr=0 ts=681106e6 cx=c_pps a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=e70TP3dOR9hTogukJ0528Q==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=j-zp8VNVwZ3Kxvef4D0A:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: aOWGMGDpVnBFw7ZUoKOQgTp0RepgKrXG
X-Proofpoint-GUID: aOWGMGDpVnBFw7ZUoKOQgTp0RepgKrXG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDEyNiBTYWx0ZWRfXxPRSHWPtHxn7 js1R1ByeGY8FdUR5IjSqha+nz1aPDZ4r+KBjcr/oFJdBMQM391aVYACAXiXZg7S7CAHlz/vlvRT yT6dwpdsPoljymZyhvhMmIFWFtaWW/P31I79f2cjCo0Drp3q8nK8iTF4SxntnOef/f8FlEriEGZ
 Z4Fj3L7z3MW9V/LBA3BQtKSUk7wU5Hw114a7BYYqNexq/4Gf0Jw7XjUJCF+xtnBUY2xsiEexEfp owxqqN6tTgLTXRy1SO5AIxUZ65sUOwgzwPbJh8iyz6OnFgJfwt//LNtHIZOKoQ3W6WlNotjXe5H qzEsiXI7zD8i1kXgJ/4b0UPZg3hQqCci1hDtVavIORHBbjDucRTeYDE7yvudTKum39koeqcHVLC
 uG5h77WNs4zT7cDf4J7XJ1+0Gup1s4Qb8avnSjccp388LQKyhu9h0HewK1R20e00X1wbY21i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=763 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504290126

On 4/29/2025 5:41 AM, Raj Kumar Bhagat wrote:
> On 4/23/2025 11:26 AM, Yingying Tang wrote:
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0-02903-QCAHKSWPL_SILICONZ-1
>> Tested-on: QCN8750 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> I guess this Tested-on tag should be
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Not sure if this can be taken care while merging in pending branch? or re-spin is
> required?

I'll fix this in the 'pending' branch


