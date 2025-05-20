Return-Path: <linux-wireless+bounces-23180-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E28FDABDE14
	for <lists+linux-wireless@lfdr.de>; Tue, 20 May 2025 17:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A77921BA4185
	for <lists+linux-wireless@lfdr.de>; Tue, 20 May 2025 15:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C6C2512EE;
	Tue, 20 May 2025 15:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SZK59fza"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615C72505CB
	for <linux-wireless@vger.kernel.org>; Tue, 20 May 2025 15:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747753287; cv=none; b=ZBtC3Gt2QaiMUWImaO+6/K5TcUC6Qz3zAELIo7lP3qIdmZqHNnPBDJl3o2PrvcZFG+LS1xs7PNXerrIU5IkKZsfCWaEvgAO7KpLS3WGcezRSPp3yS78xEdjbkddSQtEvCVEGfxrfh9AJwIfo6rkH/VDXwefDTT+iTGj6DpYmkYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747753287; c=relaxed/simple;
	bh=LOQqr4tM+mXSpYiJXYDV0k/BHzBTVkxWKGcxCbbNz4s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IDp59Q8qsIXJfhUbsTAv685YTyIrEfCZW9MnFQ0L67oXSPkVhqSOkGzIIebMSe1SClnMP6/45Mi0MbMDFBZlJay0zspkhtQm85qkKQCCy1A/yUlTkEn5ZNaYlT4UcEa4lFcWHnZDIuqAEK5y4m+iEhMqkoX1/fe031b1i2sS5bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SZK59fza; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54K8M3vS022840
	for <linux-wireless@vger.kernel.org>; Tue, 20 May 2025 15:01:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bHgqkd6hm8Hq1q7YxMSBDCk/zGJCjVvUs5Iq6IcFe0Y=; b=SZK59fzaoDuENpWv
	EAs4yOswZLDQe2RY8BrUOPSRKBfJ8MVzeiLdobjsijwfDFmccWEpJxeeG1ZhZTKv
	p/BKNCZIINHsnDpczRyB6Zw1vWCpifAPZdWLiUO3iHJnyS7QAIxeLlI9wP67vNEi
	tYLl5EDLcZXN+IVH8Dlp362xhrCQwMu8Uf6q5I6C0tMc2gafnXdVnKilCCDZ5Dy0
	8NPqFf5nfI7aFWKhOpK+NbkKspocwxJJ2bIkhfCNYFGCH8HU8lrYQKrytCBN5R0w
	U9lnthctjtiER4sH1YOTSuwbLsaYzjF20FoGha1epSUj5rYvh9M6NIszUoAq/OcD
	q7AZbw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46r29d49k7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 20 May 2025 15:01:25 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-742a091d290so3949492b3a.3
        for <linux-wireless@vger.kernel.org>; Tue, 20 May 2025 08:01:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747753284; x=1748358084;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bHgqkd6hm8Hq1q7YxMSBDCk/zGJCjVvUs5Iq6IcFe0Y=;
        b=JCJOGzAa3yno4L3XrK0j19cn5mOY+JD+WgFENm0E4CKKDr24T+i1+fv4SQ1GOsWBKD
         DAL3uXM5tjzi5tmhuNkN4PtGCobdB9y7EPhrmZIFkBNldQQNnQ8n85qmeiBpmZDNDsf7
         lc8cShQtuSKib+1IcyoV12yyY2UFhOpYjREJy6xvlVz1bp7iLZuo6KMJmIJyz1HBCRQt
         zAdWQhu6x/POaqNx7YztA0A5d6cx2NeFaKqFVOtAC8rmicNIVfLGcJLCwFw3zXuvwC8Y
         gHhWXhK1w7D7U5AzXJFBP39AXCVyO7NL72BL+7GKn5tQjPFz8fahj4hUYawrVEvBgJGK
         R6PQ==
X-Gm-Message-State: AOJu0YxDEAqXYOuVs44YtxRWN3xJVouholISVWfQHW+heAUn4NE436Zy
	0Fgwn1/8VuoRjNtlSEi6LFgtqAZuxBfqsyEIvDT9r4mf+hYf3OYK+Gwx/+QAsBqGB9a7vh2kmpU
	zFTRD1lbQlebFnP+LdsydT+JuOiWkvYz861vPs0jBrBJCPbg3wftos0Dt+46/khGgY0stYA==
X-Gm-Gg: ASbGncuBS2mnrCyJ2XOdIvfrZVC6w/HuyF9oyNyRWVRHIXxsm1kavxBGIaEaBHoxeVw
	cSuHvHzaeg/cylTwhCaz4gpdyTEuozwy23lObzUw2s3EMbmFdTTY3sd1rdk3vEoBEEPZEQu3naG
	X9WjRjzity99/auYkimSDvMKkanfpV7RXxZNMk010HXM7GbjXFR70/A91bpI3N9x4VYlbp+6Xp9
	/gRTA+NjIe7i7o/zvoVod+4XbhpQV0ar28P7n1UlA/rGj4HHxlvYC3946sb0cEhY1bACqCT3TFA
	7yXIbqmZtA/1csbH4w5Kp9y60fuFhOrsj1ejn3CsC6rDYvCf
X-Received: by 2002:a05:6a00:2387:b0:742:a82b:abeb with SMTP id d2e1a72fcca58-742a9787178mr25526315b3a.2.1747753284507;
        Tue, 20 May 2025 08:01:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9RZleP0KFHI4c54jIB6ezn6V6sype+be4dY8lOauCm798mvRiBrtqj7XJhbQ3yCpUKokmow==
X-Received: by 2002:a05:6a00:2387:b0:742:a82b:abeb with SMTP id d2e1a72fcca58-742a9787178mr25526262b3a.2.1747753284023;
        Tue, 20 May 2025 08:01:24 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a96e2106sm8264258b3a.17.2025.05.20.08.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 08:01:23 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Rajat Soni <quic_rajson@quicinc.com>
Cc: linux-wireless@vger.kernel.org, Aishwarya R <quic_aisr@quicinc.com>
In-Reply-To: <20250505034351.1365914-1-quic_rajson@quicinc.com>
References: <20250505034351.1365914-1-quic_rajson@quicinc.com>
Subject: Re: [PATCH ath-pending v2] wifi: ath12k: remove redundant
 regulatory rules intersection logic in host
Message-Id: <174775328310.1942021.3509552130230492528.b4-ty@oss.qualcomm.com>
Date: Tue, 20 May 2025 08:01:23 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDEyMSBTYWx0ZWRfX4bpXj73PHr6f
 ViHrKiA2UfVYT/NKEbBkSHtLIANMVHi8w6syCJTnxWZClMGMEyQZh1hqmEf0sPchA3DLi57qJQh
 mCux+5VRTH5FjvxjZCLpSqAUAw19IXtIqOl0IyeKULhfbLQo9DlzDBFQxSB0m0HyIfsU1PrrKAd
 bTPSFFBtEs/0m1jSYbjRErHWp3V4a7eDdV2rHA+YQFhsYB7hk7rzMiutnhcwCKBth7yyNGPBwiC
 fWyjyvALmYqlkCMjAFkokulie9Xp02zq0jYWpL3NQHEg8uNMB+F/SC7XjoHosifAWq+XBdxNWXq
 cH+RXJs+NRF/IphhrdPrKriA5iQce+kIM4SP/QlhpvjjyElGdF1EPa/BxRorNbMeidVfDlYv2/U
 o5qwh4qtAfix8eZhiJ6jjEL3gWJXj8MXORJhGm6/a2kxnIawCO8xsAoN7m+oK0y1LnFbj5+u
X-Proofpoint-GUID: TfeGXXp_K0wZYueua0T8_5lf8fjSL-ng
X-Authority-Analysis: v=2.4 cv=KLdaDEFo c=1 sm=1 tr=0 ts=682c9945 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=lSjuBxavmJQmSIbZAZEA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: TfeGXXp_K0wZYueua0T8_5lf8fjSL-ng
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_06,2025-05-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505200121


On Mon, 05 May 2025 09:13:51 +0530, Rajat Soni wrote:
> Whenever there is a change in the country code settings from the
> user, driver does an intersection of the regulatory rules for this
> new country with the original regulatory rules which were reported
> during initialization time.
> 
> There is also similar logic running in firmware with a difference
> that the intersection in firmware is only done when the country code
> is configuration during boot up time (BDF/OTP). Firmware logic does
> not kick in when no country code is configured during device bring
> up time as the device is always expected to have the country code
> configured properly in the deployment.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: remove redundant regulatory rules intersection logic in host
      commit: 1cbc77e0bc32304f574d06c57467914c6168d413

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


