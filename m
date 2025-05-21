Return-Path: <linux-wireless+bounces-23246-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C6BABFE9F
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 23:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05C333BA7B2
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 21:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59B729C345;
	Wed, 21 May 2025 21:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MxOxmSmh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F55616F288
	for <linux-wireless@vger.kernel.org>; Wed, 21 May 2025 21:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747861498; cv=none; b=dXBhUXosTE5mWa2w4lYQgTOQ5yH34oD6luKRGW1WPhXd4lfrzotHjtcDr4QMN78Ko+1sbSoC5qXAksBaIxnJ9sLbiexcWHnuXqT/nYHZf+zd9Q89zlcCvoBD2CNBSlLFm2CJQqlNDFJe2jTM63I+gTUq+/I2YdJU7MotLCYjHjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747861498; c=relaxed/simple;
	bh=chJwl55od09sVeWIrN0MmDLleb4Odia5evr1uKP0pXA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PbnCMGvZmUqcgh8O0p0WZ6qqTGgp/qcf9uRNGHQcvAlfjx9aVfLltAvERqCfQbf9w/lPUvW6wLWmACzBR32tOJM0OIQjaQBC15AK4C7t5CdIN0113eHlEEXrDP0OmK61v/5AMjwwyw8PCHe7r8n5Ja8/1dbX7i4Sb8rpgZmlRvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MxOxmSmh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LJh7Qu015209
	for <linux-wireless@vger.kernel.org>; Wed, 21 May 2025 21:04:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	n8pfrRmMMPxVsgesSad2JR7BoMNnIt88nEFw4z/RGv4=; b=MxOxmSmhhtc76zDd
	VKjuwHqbDF6Uin5xc7s6h6CGg8yQ60YMNrG1K2NzR8FRMlF4iUgesDqiSXtjMtL3
	SLgI52SSqY0+qCSVE6CkV03TWvjS2zDeAuUeUGxejWd2eZwr7ecvidDbizLx8CSW
	bioeiRTAHUpBAF2tfdZYf9hvPLSKrzbvuhc0pFH756KVCLDR1B6tonfuEYATlaND
	f+G54wYaGpxRRLjim5DdvUbMV8ahL0zglUFGunzIddfyZVEmC5+D3tsTMvse3F/o
	aRndXbL546InDhxrXekGM48/U5smAIv+gbVjOOqwzRwlnEkXyH4qBz1yJV2ZFJHf
	8oTjRg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwf9c50g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 21 May 2025 21:04:55 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7391d68617cso6229439b3a.0
        for <linux-wireless@vger.kernel.org>; Wed, 21 May 2025 14:04:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747861494; x=1748466294;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n8pfrRmMMPxVsgesSad2JR7BoMNnIt88nEFw4z/RGv4=;
        b=Mp+HYDs6P3q7A1tzySVhaXpEwmQdsHI2+NFwit1AQGgjLdsmVOepcqEwsDJwQdhkeA
         lWXOzhV7BBPqrv2hHmFvBuFABLIb4H4Kf21OCrebIVQVEIHNS52riu3dCFjeAvd2/bco
         8AAYoGelYS5HtuVmhtQ+d2r+Sl9AyyGu/O21Q286Xa4PpO3pItDnH5KhVQVV6lmn+xmH
         ZL0sBJmCW5eswHnlmG7zdjDTOMUcvS2sloahrAWc0wMSE2Xfoaxd2Lj9XnRcPAYTjfxZ
         D484IOvdXPNt1NZjHyv8DfROS0NsWK/9KRi9WGQT0YSwCVLHj5oCCiWBAw6qRLLGxmBm
         G+wQ==
X-Gm-Message-State: AOJu0YyPh1Md/uBhk7D3Ih7dIlBVaAa4Yq4WeHzYpCaSE2Fezkyf+Mol
	4MdztrvQFbAdNPW120iYXI/JkC/fNJ+Z/OUPBbNitKsOT76amx1paFHpawcDyQjuKCLI1fSH9m2
	T+rx21j2nMsJZYPVhdTqkBFc7YW336Tk/CHQCjD6kqSIxXKai/vfLjd/heR9JspiS7Nr0BQ==
X-Gm-Gg: ASbGncsOXCYzJX+KMaKaNb/3uzLGTjwweAtEsd3+ZL7A7J2hs7AmiuL/CFUHFDAMb0F
	6pw3C0v9/Dlj+5s+0Pj3h+838ntbrWs0ZpUxqbAh/PmH40Z5ueTY0UM4gX4fZKb2s4Us9A7vDIY
	ky35ekKJXt/nOknUoqsZYlL1IdYrTYM+H2druOfeV6LJm2pkIH7Mi59wEGCWSvi/Us5fuGPSIS1
	n6omsp65YiMwtJJknF+dw/atZfP6ntwZBcJ+AcdOwOlnGqhp4eYzbR9xvlirmMuwepLTuAZXgCj
	7KoKOpKiIAH/gllvnqe/N66PZpwvgbgR3XH62Z8qBuR8HZaJ
X-Received: by 2002:a05:6a20:6f96:b0:1f3:26ae:7792 with SMTP id adf61e73a8af0-2165f87234fmr31590426637.18.1747861494488;
        Wed, 21 May 2025 14:04:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwyz7dPN3iVMEKuZm00Xxt7WNxKbvIPZRXOMsuu9ovK+uJlYmywLQxhYU5YAUcR5aa5ssk/g==
X-Received: by 2002:a05:6a20:6f96:b0:1f3:26ae:7792 with SMTP id adf61e73a8af0-2165f87234fmr31590380637.18.1747861494053;
        Wed, 21 May 2025 14:04:54 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a982b7f3sm10057303b3a.87.2025.05.21.14.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 14:04:53 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>, Kang Yang <quic_kangyang@quicinc.com>,
        Wen Gong <quic_wgong@quicinc.com>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
        Baochen Qiang <quic_bqiang@quicinc.com>,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20250521-ath12k-fix-ah-regd_updated-v1-0-9737de5bf98e@oss.qualcomm.com>
References: <20250521-ath12k-fix-ah-regd_updated-v1-0-9737de5bf98e@oss.qualcomm.com>
Subject: Re: [PATCH ath-next 0/3] wifi: ath12k: fix several regdomain
 update issues
Message-Id: <174786149316.3123854.11064222745292053302.b4-ty@oss.qualcomm.com>
Date: Wed, 21 May 2025 14:04:53 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-ORIG-GUID: 7-nKUivInHN4E9NchPXBzPhakcpF1kXJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDIwOSBTYWx0ZWRfX47Wqm8J15eIv
 xyX5LVocZUgyc41Wb90aTjM9c5Vxv17/n5Uu9Nl/CAyWdQrGVTZ8G7wvmKz2GrHc3DYiSJAtqoL
 XimwzGpL6YY+nJnAB8bUs9gTiwzBniYNQPYGRNgq52kNjgUGNUC274zTgUMV7pVYbyql7gsMVHm
 15gnBXu2fT2lE/64ZIwDN5VBnyC4YdFUgc8nwkJBdyuBf+n02xWiYdi/HzUPs4TKt7jrne1YSJ0
 ywaiZteQB38IjW346R+DNRokFi54XZq+oR/s4WOU6qMoxPASitdb6HeOCJizuyL1lg2iyp7uSXq
 EmNl+DNQhtJVLKcZpg/tYyuyaR3SpnG2OkYTMzeRPMefDtEeXMa1VBTRCkL1BLa1YjXT/flUk9T
 Z2KC++wn/8U1a2Q3e3QX7pf9ZIVRK47CFq60LYTZnmi6Zmq81+yRFVhFTWdXY0X3CEUPCnsx
X-Authority-Analysis: v=2.4 cv=GawXnRXL c=1 sm=1 tr=0 ts=682e3ff7 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=qE4HOfYLDg8APkTHxjoA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: 7-nKUivInHN4E9NchPXBzPhakcpF1kXJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_07,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0
 spamscore=0 suspectscore=0 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505210209


On Wed, 21 May 2025 22:29:28 +0530, Aditya Kumar Singh wrote:
> Following commit 4c546023d71a ("wifi: ath12k: update regulatory rules when
> interface added"), the WCN7850 fails to connect to a 6 GHz AP due to
> ah->regd_updated not being reset. This issue is addressed in patch 1.
> 
> For the same reason, regulatory domain updates also fail during interface
> addition and connection establishment. These issues are resolved in
> patches 2 and 3, respectively.
> 
> [...]

Applied, thanks!

[1/3] wifi: ath12k: fix regdomain update failure after 11D scan completes
      commit: d662c14a51910ba0ad66afd248b601ba30b9f7f1
[2/3] wifi: ath12k: fix regdomain update failure when adding interface
      commit: 37e775a0a9d79a031d28d9e21480f99f448e9215
[3/3] wifi: ath12k: fix regdomain update failure when connection establishes
      commit: 886bb3624e4c9914a943b63fcfdf30b8d2f2b66e

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


