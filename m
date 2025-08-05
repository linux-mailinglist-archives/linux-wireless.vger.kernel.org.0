Return-Path: <linux-wireless+bounces-26158-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C75F9B1AD70
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Aug 2025 07:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 425D57AB6F7
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Aug 2025 05:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9521021767C;
	Tue,  5 Aug 2025 05:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="phwgjS5x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A57215F48
	for <linux-wireless@vger.kernel.org>; Tue,  5 Aug 2025 05:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754370087; cv=none; b=cH2jqJsxPhzAp0c+djxQGwIs8wZVXszPRjmoZRx93lC43BywUZ+J6vxj9XoQ/5njV+SGmn59LqMSnqy/RxZj4I7hjquFEKOKIf3XISj1iy/dhTt4iAa7r8TWRCBtXiG92AvbgUk5Vzg+KuZn45S++PRuQijsVLRsQd87PvJjl4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754370087; c=relaxed/simple;
	bh=xRL3ruAQkNgj97zvQUzJtTn9tgi4hIXR+ln1qFdIkWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n5yuQkb2s5SImcvVlskqB9lmBxxyIRCLjbzWjGQkgdsz8WvAZ3I8aPBBRdyDDPV5U2mZkauqXNYmIbc7+FRve+MTCnWx/b4VXFVAZTbN/yYb4KJWFb0D2YjsOFTRy6Ss55KxXYW6lSSA8DZxSbfdarI5u0KbiiX1jBxaf4GIplo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=phwgjS5x; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57546gJM002942
	for <linux-wireless@vger.kernel.org>; Tue, 5 Aug 2025 05:01:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=O9RIDmNzhmmHiightJnBZ7fI
	75tTgnPyBB5yU+qp9lE=; b=phwgjS5x5Wrbd34/c9mJy01NrjVqbLwhnwmEwR8g
	kmIYh0CMbdbF2yik0sk6V0uoFffk2oO6wzTBTF/zDSPH/bo9bk8pc3bLloIJblHh
	s+cOZyrn2cymDnmBApp7Hv/UfT7DRtnhn3Y6XhHlDcMU7i09iXIfh4ZRhCEKAx96
	sj4FWqJmAJsV1MF/65Ae/cI3cAbzQNjrvLOBST+uSmNE0euqXa0GzPEaLRmu4pgd
	IHMSWuSrrWJqszD6fC4AU3AlgynHgfClFVhWQGc4H2S4dkI3Th3PwVVmFE30m5+G
	9KZWFIzKYoSb0zctr+9QZgG5csaCR5xgHcmlZFVs4ubuEA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4899paf7a0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 05 Aug 2025 05:01:23 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b061ad3cc0so51946621cf.0
        for <linux-wireless@vger.kernel.org>; Mon, 04 Aug 2025 22:01:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754370083; x=1754974883;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O9RIDmNzhmmHiightJnBZ7fI75tTgnPyBB5yU+qp9lE=;
        b=OY8nD9vzo27+AKwPvv8bt3LCIlCSH0h7KUE4p1WJFeNhxbXSbP3Oqx6C51R0Xsgu+k
         EDelmirMnb7XE+PNXD9gNPxC6937+khEvsJdVQrJsWDX4D9aQKXUTCz6/Fy1Hw3U5DiA
         rqzTIEp93Xbva5mTico0bYeoPyd5vyPuYVvIjDE2AIPRzclUAomn+cTxogqqSYBXaP9p
         7Jk4AnMQESITVP1/p/W9hfok76JEuaFFEWJ1YpxCBJCkkOsWjBIkY2EJuS5BgVAgR1T6
         Fy0QFDg1u1bHBfCIp3LKrO1nSzE331y6SCOc60xH5XIvPngVwxqgqpcornW6nVkKeiA/
         OQ8w==
X-Forwarded-Encrypted: i=1; AJvYcCWSeLQ0n7KEKgoebrDcItOpx79wH0xJailYHIXivW7vahHJZVjsLEnyUfR/KgUMrmk6IbVyaDw3Deq/yybEQg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6nGzCBMcgwsAQ5qP6QR73M2PLtyDNQQFZ7WLTDN7fqfYM6dBf
	IFgI633Hk79R6WyzsBeeOhVHTF5mi06gAXzTAMonu2sQN2RR8nkawbPHp1/yHT1wHTxqyGeCixD
	CSBxQ2jgPBJUCs+q85rnUZqQgxO185b6KDadI65B4TWD08ItpGY2TTxV3bVfkZX+2S58VJw==
X-Gm-Gg: ASbGnctsQsNFIFPMYu+UM8oLJZmdMfy+J7byGXXzGqT/StWD0MjEQ02LUVEiMmuB4kN
	o5N8ooskbIvs5quH6pRE4HmhFV+iQAnQ14q2LLMIbtXJuIPtho84kW88KE1Sde/YCuGFWHTbqAE
	zVk5IgddL7ybRemGEamIqg/9JZ45ST3kJyp2+AZYidWcxUEBOdesjBcKMBG/XkzAgWjXv0k8nYi
	OqRO7oH/36obTGOo2wEZn5L2Tkf8d1MeSa6nfE0SpjSdYJOO7KPblmkXjJBVgRq/ArHzaM512/A
	ppuuye6UqV9twpc/6hW/0LRQ4W25WpA30/eHnIhy/EXMF0TxwP4AbWPa3Dq+7EaclBIn5wQrhDr
	CCG/IKTfbFjWzChv4zRTmam95uA8Cn7IgDOVCOrxHKrA6mHP+TdLw
X-Received: by 2002:a05:622a:2614:b0:4a4:2c4c:ccb3 with SMTP id d75a77b69052e-4af10a4a6f8mr183536951cf.38.1754370082947;
        Mon, 04 Aug 2025 22:01:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFrkygcTlWMwxP/dXL1HWOn4RsCOYuS94xjX9GRmLBpCLWrY5VJAZwhtLhFsjZ3j/oj45ilQ==
X-Received: by 2002:a05:622a:2614:b0:4a4:2c4c:ccb3 with SMTP id d75a77b69052e-4af10a4a6f8mr183536451cf.38.1754370082422;
        Mon, 04 Aug 2025 22:01:22 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-332624953b1sm9339861fa.80.2025.08.04.22.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 22:01:21 -0700 (PDT)
Date: Tue, 5 Aug 2025 08:01:19 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Subject: Re: [PATCH 0/3] EDITME: cover title for mdtloader-changes
Message-ID: <volasof2jfa5bv7f7epyetxgci6ymt64ampqf2hhqhjf7co4vo@afkw5oxoralp>
References: <20250804-mdtloader-changes-v1-0-5e74629a2241@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804-mdtloader-changes-v1-0-5e74629a2241@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDAzMyBTYWx0ZWRfX6uSBIc3JIyjO
 0qlo9rcCmIAfR2sQI2PuWWZeod+2dlhfcFNkkDK2qwLhyeKuzNK5AlEoSk5tCuG9ak9crsf9i4R
 AC3ly0Etm5zCw1nKcPU+D9t1dp/g2t66PEsGopGbGIzEJXpeI0PCMlvnWgAg6QGLUquCOvlOxug
 asUnMN9H0m3K7NZ7/vEpDmsSCuBDAUkXMr30rk7jMm4drcDyXTl3w8tdWVCDwLx0ccV/H5aAIRb
 ETf1R/dHYKB9Yyhxn8s3s9KmNzKuqFUlVwQ4aaVoZiFKM2iLc14n0QO1Wj1+ZSJvH/0BFJvNGnL
 RcbGcdICZ80RW8UvXIXeETreD4igoX/3y8rRIKzhu6JSzJwcbzERGtjAbVpgVCbEdh3KF99JxDf
 jBtn26/vz6MwBW2JkAWkQaSc2+UyDw3v+F1l/3SPTFYqjZY/SZq4Q22dkX8KQFYZ2XQx1srp
X-Proofpoint-GUID: Xum6GHUupveg8u16IlEdMEblSdwRCvHt
X-Authority-Analysis: v=2.4 cv=N88pF39B c=1 sm=1 tr=0 ts=68919023 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=PPOPQqKM8dVImZj3vAoA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: Xum6GHUupveg8u16IlEdMEblSdwRCvHt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_01,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 mlxlogscore=828 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508050033

On Mon, Aug 04, 2025 at 06:11:48PM +0530, Mukesh Ojha wrote:
> 
> ---
> Mukesh Ojha (3):
>       soc: qcom: mdt_loader: Remove unused parameter
>       soc: qcom: mdt_loader: Remove pas id parameter
>       soc: qcom: mdt_loader: Fix check mdt_header_valid()

For v2 please move the fix to the start of the series, so that it can be
picked up independently.

> 
>  drivers/media/platform/qcom/venus/firmware.c |  4 ++--
>  drivers/net/wireless/ath/ath12k/ahb.c        |  2 +-
>  drivers/remoteproc/qcom_q6v5_adsp.c          |  2 +-
>  drivers/remoteproc/qcom_q6v5_pas.c           |  7 +++----
>  drivers/remoteproc/qcom_q6v5_wcss.c          |  2 +-
>  drivers/soc/qcom/mdt_loader.c                | 22 ++++++++++------------
>  include/linux/soc/qcom/mdt_loader.h          |  7 +++----
>  7 files changed, 21 insertions(+), 25 deletions(-)
> ---
> base-commit: 5c5a10f0be967a8950a2309ea965bae54251b50e
> change-id: 20250804-mdtloader-changes-9aca55e8cf37
> 
> Best regards,
> -- 
> Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> 

-- 
With best wishes
Dmitry

