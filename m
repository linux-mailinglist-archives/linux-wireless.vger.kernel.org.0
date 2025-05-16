Return-Path: <linux-wireless+bounces-23099-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE79ABA434
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 21:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC5BF1C039D2
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 19:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB75128031D;
	Fri, 16 May 2025 19:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hTAzRixj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89D827FB2D
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 19:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747424434; cv=none; b=gJcvDBp8NvdW1JEhxUkNX5THJfOpMJ3nqfEfrooUFgDy5lQBzwr2WKqC1NdJXptC1qmp1ycIuh5sYqYamQYHYuGycC2QFomuVU1NY+6+Jch49eVse3fgrehNdmFP7FnZ1eOleGh0x2r3sB1sHO9mrwIh4DpCmLewcWLhIr36940=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747424434; c=relaxed/simple;
	bh=RNXCiiMy99jcdkhItnIFm/5Uhb5ZeDe/wagaoM1WcKo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IAOkmENJa9xBHpG5nPZZMz5yvWr1hoE2z5zq55z0KtQM887FqHw/ON8XJG2FRkWIUik1bPHJraTfk/CldDqiHltKg1ZIjfALBEaeZYrgIXhR2t6/ByqRUnFVo+0JDvrMoIuaHs2xNQWDYipxj8TAn2lYpbXho+HB+xlyHUFdUD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hTAzRixj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54GCj8jq014202
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 19:40:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pkhlzN+qG5vNuo4h9xeRD4O3lEA6KR/53oS6kygqww8=; b=hTAzRixjIGOgEU3z
	b+tHPrBVVE2XhghiiFIa0ColwaYpQu4TGHDFPoimEkVEWyoEePorBqbV079E36ok
	SpOF23WWwDQh6n04GMZX4R2EyUlaibXfnEHBTZLhIQscvolEfP0bD6IgqDLPA7m9
	VdfAocMeWMDopXbUW4JjwgmI22Jihf+8V4fIZKwAdDi9S4kK8VM9pizKPDEkiPdj
	+EqHEFcuUVSkNF5CBTFnwioojIPTabBUX3W/RNVrXM8mBDTwNaVyy8oduZ8sRsTL
	qX0nWU87TkjjVkpCUTAn/sWqSa8hGw/Dviv9umx3MdVXfk7WE+PLJqRndKSuXU/0
	Z43AxA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46nx9jtfq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 19:40:31 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-22e7f041997so42251845ad.3
        for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 12:40:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747424431; x=1748029231;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pkhlzN+qG5vNuo4h9xeRD4O3lEA6KR/53oS6kygqww8=;
        b=DpaVrgvbsmSqYnnanpsD+zKpSYsttNSK4y81mEWTLLMWENSg5HUPSMPJ9FwGyCPE3A
         CBkKOmtvdCOBTlFgxAnic75lF3VUmXqwr4SG8it1a7MXXX3s0L06hZNtRhgh7xRjPKHG
         LsnddPMQdW+CQbKYne/60+E0tG1Rm6URT9cIKP+QfTrWWtVzbmMljsb7fiKpfM91ent9
         xwIHODt9bob1GjS/I+zMmPnULFLrVoIUPT82JTIhvppl8jF5hJYu0S5YbehfCk3Z1dtD
         wCOpOkPXGBFgxtDPrLcKdetoPDwCfB1e0zLED0RmwZOwQtPcp21MQVQJ8buYnCB5WL7a
         PGJw==
X-Gm-Message-State: AOJu0YyLgPGAWDIEBUpDPPGXhqA6HEE4i79ur2y/RGj026B/lI2a0CPP
	habz7EIuEjmQ4cgnC89K2mEQTReYSiUW3vDisbxE6So0ER/gYKNEgBJJ1ZeUUCPOWE7Wg4FTAO5
	zv5H5ml6AZB4QqrKWn6V8ZaP2yyCvTHnxLzRA3EFfxbkHhwedG8G8mZHT1KYy6wKWzMLE/Q==
X-Gm-Gg: ASbGnctWql2v5fHbAE06h+q6D73Z+21+vK5/fNumKlHqXZJQ+y2lq7Iyi/T1bNKAK1w
	HctjqUgUsknr4g6dNoDLcOvMK77LYEQXDte1Je1EMvu9dQW330dSJ9yVn4h+235UdsSFkHkeO/1
	YKVhYBJyTXv3pQbLASyCcoGq22IqivLTu+L6ja1SnqifDy4g7PRAbO5m+XKUpkoZDCTO0nlH2MQ
	V7fDTwxfo0IPlYhxV8ry4yqyvM5RV6g1WWx6FYev5tmIy//4lDt8LVs2UNrZsJDmjluXH4kJM0G
	sFSnqSa4AH3rdEyF0H+qOlbg8tKcHLjKGbEM0l9nGgM1X/qp
X-Received: by 2002:a17:902:e78c:b0:21f:dbb:20a6 with SMTP id d9443c01a7336-231d459682fmr62471455ad.33.1747424430971;
        Fri, 16 May 2025 12:40:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7nj1shVFq4kgoN4NQot852pjWMIgCcaeeUronWy/jIPbwjtPa/8IeuqSdRXIhrs+RgKfTdQ==
X-Received: by 2002:a17:902:e78c:b0:21f:dbb:20a6 with SMTP id d9443c01a7336-231d459682fmr62471105ad.33.1747424430578;
        Fri, 16 May 2025 12:40:30 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4e97798sm17955255ad.147.2025.05.16.12.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 12:40:30 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Lingbo Kong <quic_lingbok@quicinc.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250418064008.7172-1-quic_lingbok@quicinc.com>
References: <20250418064008.7172-1-quic_lingbok@quicinc.com>
Subject: Re: [PATCH ath-next v3] wifi: ath12k: Abort scan before removing
 link interface to prevent duplicate deletion
Message-Id: <174742443000.3316767.12690800887511642294.b4-ty@oss.qualcomm.com>
Date: Fri, 16 May 2025 12:40:30 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-ORIG-GUID: VVZzwmDHeHadGtJVYBC4txhXqQMEZRe7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDE5MyBTYWx0ZWRfX6gtOfum+YAr8
 YDPSmS1njfxCv1xN22S1ZMnScQahc0si1+O5SA4AgzLyW0bKS2HtUpCt1Y/HPJIEoRvid8BJlkR
 /w1MGu0ZsOK0Zg4PrKuxNULmzZ/EcN50r+pqep2+9KruETv+PyolWxVp5AsK99pVPC27owUL95y
 9sEiJ70rqYx3EbceIoufRAS+1d0e/9zCUaYsdKnhGr6vdC3NjhZxJJ/Ho3BJjV2+lE4PrfBWkBa
 C6qH1qKFaZdy5ZwLigG8eJQ2OD/9+OVnVDewbV7uvH5qZLcOChjSIuQjLy4D7d/+y5bL9O8U83H
 kSfsGF7U04/roiGs6pfmm1MgazeD7WN3mdBQf5cZZSCYF8U3KR4qISzr0TipPwBdjmeNjwOZiuu
 gxoSeAMPJh+8gMYmatyueJ0V/UJFk3Jb02fj2NvdPR5RnqA6WjMzV4WV1lbnbfmkfL8bHPi9
X-Authority-Analysis: v=2.4 cv=CIIqXQrD c=1 sm=1 tr=0 ts=682794af cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=qMuIj1eshgUqyd9P3KAA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: VVZzwmDHeHadGtJVYBC4txhXqQMEZRe7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_06,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=825 spamscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505160193


On Fri, 18 Apr 2025 14:40:08 +0800, Lingbo Kong wrote:
> Currently, when ath12k performs the remove link interface operation, if
> there is an ongoing scan operation on the arvif, ath12k may execute the
> remove link interface operation multiple times on the same arvif. This
> occurs because, during the remove link operation, if a scan operation is
> present on the arvif, ath12k may receive a WMI_SCAN_EVENT_COMPLETED event
> from the firmware. Upon receiving this event, ath12k will continue to
> execute the ath12k_scan_vdev_clean_work() function, performing the remove
> link interface operation on the same arvif again.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Abort scan before removing link interface to prevent duplicate deletion
      commit: 1ab2e9046b4f3b298274ad4cc08ff456d3e4274e

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


