Return-Path: <linux-wireless+bounces-35616-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHK6E+cG8mkimwEAu9opvQ
	(envelope-from <linux-wireless+bounces-35616-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 15:25:59 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CB3494C3D
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 15:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABE35309C5B0
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 13:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C500B3FD126;
	Wed, 29 Apr 2026 13:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MpzMTZQN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kmoEK87O"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4291C3FCB14
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 13:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777468842; cv=none; b=ftMJHlrPs/Q+pdZ2nv8rhi7BVDhhUFzunmhWPBVB2RSLdD6lb0HIvVvSO2YZ/QZl0hOvL/zYhvLGTzIgKZKIuTbOFuxUdt32X4eG/HiKFGqDttGH9u7kwQEU/hf0O0xwp58G1OjVMo0b87P7e6UX5RcvPGs3yPYeWm9mxmQbSSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777468842; c=relaxed/simple;
	bh=K9SziZwg2cg6hFbGZntKPnTumWR+tSXth0HI677R5sU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FjQGsVuso1+bjqTEQWkeAsXQFV7Gd7FwcYkV6GPaJ6AklcBk5YlTzd9RtgvTkTFnTn//yl2hcWd6T/XeCjXlciwVfRiNgI82cmiJnRuI1qXUKUjvaM5iclIv0KeA4hS8cKMLFTBrSqY2fMnevAQQLykaL0MK+lQrI28iJnugiOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MpzMTZQN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kmoEK87O; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T8q7V01721243
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 13:20:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=helEobTcZ3+WqP3KRmH5fips
	MFY/APaVYYJ+NFxCwsc=; b=MpzMTZQNb86sTF07AiqH/nkpLUkY4jGNjNCCekiR
	2F3lTRcf4LUhSYqCaGXyJSDops2MpH3hE94J5UTL3eTvZH702UNURHxKCkYz+qo9
	f5XB+VtPssFImppRrpuY39ObjH+ykdPv0SeRkpu5grOK99gwYnfunAVeHQgSsISl
	0/i4TSW1EIpmPTHHuw/JTUig82EtiP4i4B4tTKXZQjgTjx2+hL3pxcR2mezcMvCk
	IGT1ikpLw4y8g2XKFwbLYlqoOyBt+A63FOGXPf4rWwaQ+qnto0vi9Q1HUTRGtqNS
	egmgHjdignnFQoA2WiuDIaLO7BcWCP3IKfqwfqwt6S8jDg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dua732619-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 13:20:39 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b2e8bba2e6so177344685ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 06:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777468839; x=1778073639; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=helEobTcZ3+WqP3KRmH5fipsMFY/APaVYYJ+NFxCwsc=;
        b=kmoEK87OB1aPejzY3rYWbDlgzUIABonFdnI8o3wN8+kIgQaoRwiKtLHClnvggxplc4
         TKeTnCO16HRMp61YjS5qUItxGXwbQo/74NpcbFSdmd+2rbMMpFlDuyqR6I/8Rg0ZCcnJ
         7iHLXxOXUdEjUbXthsxgezipIPGWQYG5cxnusOnTfbUd2GZJJBiYSwYy5bH03b0qkw41
         a2Ye4CXsQREoA0wCdfq2vG87EXBzw2vWEG/QNCiGdrvgDQy4HY1InX/lXsSp3bLcXM1Z
         mey7GUqc9QlKbXoMc02R8+1MnfSSTeQh/1uxiVBJ3V/Vg5GU+OehTjJuyROEXip7+4Qc
         ZOYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777468839; x=1778073639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=helEobTcZ3+WqP3KRmH5fipsMFY/APaVYYJ+NFxCwsc=;
        b=ODrw2oKKBPLXT7QeuzZBgZY/yWJ3TW0DqYCf/A3eEs7lHonedG5OY8OkOlNP2SrErl
         0mdqde3NYo/jVl1hjEl+jSpYH3qFvGaeGKQgrjtpKVT6qXaWstS9ZxjALqH/DLPGDMYL
         mzQtQq+mwaodYuWJesJ0b0m0hw1QL9MY+HQGT3TuJIglLr3fzEirkiidDrv5D/u0WU9L
         J9XcsyPydTsqc6e7dWRnxnh9e0ZPYR9uT/6/28q8bxS5JcEdUJRbeKJoyngz8cEzauI8
         EocLSB6iYwH/tdee1WjxVc60Disr18LNoOGTS36l2ECyuDSvFTBozADYp3ZYs/ANOpFr
         938g==
X-Forwarded-Encrypted: i=1; AFNElJ+rfomVtW3mOufdK2nHRIQdlQpB8Usy6SnUUGzXVwXcZYJdUGsdYSKPdDNHuCR9b2XcY4tqGMDqExzF+1XZzQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLm/CCa8orfKCurvqxcxoUtBZ0B0SIZ/hju2VGLcTZWNB6qmYe
	3m6+aEcKAfZs8wH3VlGUO1tl27OvSoEItriCsmIcmZsZpRCUXE7HXzqrs9rKcIA/xZc10n5sfhi
	et0qxPwsA5aarHSeBAmW9gYZPKnv+PPaHYKGQgsQgofJWN1GPRdO88cs1bb/cw2aPGA4hPQ==
X-Gm-Gg: AeBDiesR+Bwyl5K8KDbBfFBhn4AHrOTY5etDTSkLe25CZiG+dG0nTHbFbPT9fCSrLaH
	Z23C4ZbRIbIwnIDj8leJvT6eY8xEhIAgGDILOAnto4e9jPbb1YbM/T+FJ3irPkWhFQrVCTekWfu
	qzt6y8JSryryWlBPqPkwOX+kAaX0WVG0HmT1TLufpC7jlxZf4cpPFqKDhN4f2w8wvmr9ayvZC6r
	/bU0IHVN9BwISj6UaynOmVTSMzLokT/i4IRt13SBCxhiLocXZ2pAcy/r5k/SgORXf/6hYFh6h8t
	0I+056R49p6d/h70s9XDOLmbUwyNAK81b0GJCmfckW4TNnBnAULpqOHvyKhShlkTa0I6bPP8af2
	65UlfelfYrifIPAzeNpVqV6xUmbk8tR8FHWK/nZIKdO95TEW94E3gueykVJ4=
X-Received: by 2002:a17:902:da81:b0:2b0:62dd:3a80 with SMTP id d9443c01a7336-2b97c4396e6mr82444245ad.17.1777468838511;
        Wed, 29 Apr 2026 06:20:38 -0700 (PDT)
X-Received: by 2002:a17:902:da81:b0:2b0:62dd:3a80 with SMTP id d9443c01a7336-2b97c4396e6mr82443265ad.17.1777468837700;
        Wed, 29 Apr 2026 06:20:37 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b98879f033sm22452335ad.28.2026.04.29.06.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 06:20:36 -0700 (PDT)
Date: Wed, 29 Apr 2026 18:50:21 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>
Cc: andersson@kernel.org, konradybcio@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-media@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run,
        akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
        jesszhan0024@gmail.com, marijn.suijten@somainline.org,
        airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com,
        dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org,
        elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        jjohnson@kernel.org, mathieu.poirier@linaro.org,
        trilokkumar.soni@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com,
        jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com,
        vignesh.viswanathan@oss.qualcomm.com,
        srinivas.kandagatla@oss.qualcomm.com,
        amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
        op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
        skare@qti.qualcomm.com, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH v4 04/15] firmware: qcom: Add a PAS TEE service
Message-ID: <20260429132021.xk2xtll545o256oz@hu-mojha-hyd.qualcomm.com>
References: <20260427095603.1157963-1-sumit.garg@kernel.org>
 <20260427095603.1157963-5-sumit.garg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427095603.1157963-5-sumit.garg@kernel.org>
X-Authority-Analysis: v=2.4 cv=XtvK/1F9 c=1 sm=1 tr=0 ts=69f205a7 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=uCB-_qCOk_dth8sO8NgA:9 a=CjuIK1q_8ugA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDEzNiBTYWx0ZWRfX9JvuwevhIs9c
 CjMZf4W9ChuiYYR13sikYOnNsd3lPCvvxfWpX4KI/x520U2woJn+AStD4iJOUjrnUk44FNnZ1Wz
 GMXpsSQFMahOwpMpnwGDHZXVjYKkYQtIZGb9GJdFlcVkK579HP4T3Tby6lImfOc8KU1NYLaEgHo
 B7crgHRW1m0mae6bHruDAu+WmhJzJNq/HyuWLwJiDNRZ18pVkUYXhY7FeAIWuom9sJLD8BRD6b2
 K9qdiT1usHXpdt76WGtJTOtbQSYA0yf46Jckt+OXCFnzup7Mlq1w9rE8OuUEuIsPE+7hpt+MOAo
 pSAkqk1FxZT5A2bhx0jxgkZlkZDVV/yJYhXV8TDaNcI59zs7bFQ97iVe9lFvNM6IInSsN73r+Lv
 PBo07gm2fFFIkZx8mwR3KEsakPYLmmgWg9H94f/hM5OKTexm3OTRpQp9kStA8G51UEEjokMbqEb
 YrZzZyg7xPo0JTsR5uw==
X-Proofpoint-GUID: 74CKNb0nfCtcE-0MoniSke-2G2RN-fTl
X-Proofpoint-ORIG-GUID: 74CKNb0nfCtcE-0MoniSke-2G2RN-fTl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0
 adultscore=0 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290136
X-Rspamd-Queue-Id: C0CB3494C3D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35616-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.freedesktop.org,lists.infradead.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mukesh.ojha@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]

On Mon, Apr 27, 2026 at 03:25:52PM +0530, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Add support for Peripheral Authentication Service (PAS) driver based
> on TEE bus with OP-TEE providing the backend PAS service implementation.
> 
> The TEE PAS service ABI is designed to be extensible with additional API
> as PTA_QCOM_PAS_CAPABILITIES. This allows to accommodate any future
> extensions of the PAS service needed while still maintaining backwards
> compatibility.
> 
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>  drivers/firmware/qcom/Kconfig        |  10 +
>  drivers/firmware/qcom/Makefile       |   1 +
>  drivers/firmware/qcom/qcom_pas_tee.c | 479 +++++++++++++++++++++++++++
>  3 files changed, 490 insertions(+)
>  create mode 100644 drivers/firmware/qcom/qcom_pas_tee.c
> 
> diff --git a/drivers/firmware/qcom/Kconfig b/drivers/firmware/qcom/Kconfig
> index 9a12ae2b639d..300b3a1bd178 100644
> --- a/drivers/firmware/qcom/Kconfig
> +++ b/drivers/firmware/qcom/Kconfig
> @@ -14,6 +14,16 @@ config QCOM_PAS
>  	  backends plugged in whether it's an SCM implementation or a proper
>  	  TEE bus based PAS service implementation.
>  
> +config QCOM_PAS_TEE
> +	tristate
> +	select QCOM_PAS
> +	depends on TEE
> +	depends on !CPU_BIG_ENDIAN
> +	default m if ARCH_QCOM
> +	help
> +	  Enable the generic Peripheral Authentication Service (PAS) provided
> +	  by the firmware TEE implementation as the backend.
> +
>  config QCOM_SCM
>  	select QCOM_PAS
>  	select QCOM_TZMEM
> diff --git a/drivers/firmware/qcom/Makefile b/drivers/firmware/qcom/Makefile
> index dc5ab45f906a..48801d18f37b 100644
> --- a/drivers/firmware/qcom/Makefile
> +++ b/drivers/firmware/qcom/Makefile
> @@ -9,3 +9,4 @@ obj-$(CONFIG_QCOM_TZMEM)	+= qcom_tzmem.o
>  obj-$(CONFIG_QCOM_QSEECOM)	+= qcom_qseecom.o
>  obj-$(CONFIG_QCOM_QSEECOM_UEFISECAPP) += qcom_qseecom_uefisecapp.o
>  obj-$(CONFIG_QCOM_PAS)		+= qcom_pas.o
> +obj-$(CONFIG_QCOM_PAS_TEE)	+= qcom_pas_tee.o
> diff --git a/drivers/firmware/qcom/qcom_pas_tee.c b/drivers/firmware/qcom/qcom_pas_tee.c
> new file mode 100644
> index 000000000000..af73d0a68525
> --- /dev/null
> +++ b/drivers/firmware/qcom/qcom_pas_tee.c
> @@ -0,0 +1,479 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/of.h>
> +#include <linux/firmware/qcom/qcom_pas.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/tee_drv.h>
> +#include <linux/uuid.h>
> +
> +#include "qcom_pas.h"
> +
> +/*
> + * Peripheral Authentication Service (PAS) supported.
> + *
> + * [in]  params[0].value.a:	Unique 32bit remote processor identifier
> + */
> +#define TA_QCOM_PAS_IS_SUPPORTED		1
> +
> +/*
> + * PAS capabilities.
> + *
> + * [in]  params[0].value.a:	Unique 32bit remote processor identifier
> + * [out] params[1].value.a:	PAS capability flags
> + */
> +#define TA_QCOM_PAS_CAPABILITIES		2
> +
> +/*
> + * PAS image initialization.
> + *
> + * [in]  params[0].value.a:	Unique 32bit remote processor identifier
> + * [in]  params[1].memref:	Loadable firmware metadata
> + */
> +#define TA_QCOM_PAS_INIT_IMAGE			3
> +
> +/*
> + * PAS memory setup.
> + *
> + * [in]  params[0].value.a:	Unique 32bit remote processor identifier
> + * [in]  params[0].value.b:	Relocatable firmware size
> + * [in]  params[1].value.a:	32bit LSB relocatable firmware memory address
> + * [in]  params[1].value.b:	32bit MSB relocatable firmware memory address
> + */
> +#define TA_QCOM_PAS_MEM_SETUP			4
> +
> +/*
> + * PAS get resource table.
> + *
> + * [in]     params[0].value.a:	Unique 32bit remote processor identifier
> + * [inout]  params[1].memref:	Resource table config
> + */
> +#define TA_QCOM_PAS_GET_RESOURCE_TABLE		5
> +
> +/*
> + * PAS image authentication and co-processor reset.
> + *
> + * [in]  params[0].value.a:	Unique 32bit remote processor identifier
> + * [in]  params[0].value.b:	Firmware size
> + * [in]  params[1].value.a:	32bit LSB firmware memory address
> + * [in]  params[1].value.b:	32bit MSB firmware memory address
> + * [in]  params[2].memref:	Optional fw memory space shared/lent
> + */
> +#define TA_QCOM_PAS_AUTH_AND_RESET		6
> +
> +/*
> + * PAS co-processor set suspend/resume state.
> + *
> + * [in]  params[0].value.a:	Unique 32bit remote processor identifier
> + * [in]  params[0].value.b:	Co-processor state identifier
> + */
> +#define TA_QCOM_PAS_SET_REMOTE_STATE		7
> +
> +/*
> + * PAS co-processor shutdown.
> + *
> + * [in]  params[0].value.a:	Unique 32bit remote processor identifier
> + */
> +#define TA_QCOM_PAS_SHUTDOWN			8
> +
> +#define TEE_NUM_PARAMS				4
> +
> +/**
> + * struct qcom_pas_tee_private - PAS service private data
> + * @dev:		PAS service device.
> + * @ctx:		TEE context handler.
> + * @session_id:		PAS TA session identifier.
> + */
> +struct qcom_pas_tee_private {
> +	struct device *dev;
> +	struct tee_context *ctx;
> +	u32 session_id;
> +};
> +
> +static bool qcom_pas_tee_supported(struct device *dev, u32 pas_id)
> +{
> +	struct qcom_pas_tee_private *data = dev_get_drvdata(dev);
> +	struct tee_ioctl_invoke_arg inv_arg = {
> +		.func = TA_QCOM_PAS_IS_SUPPORTED,
> +		.session = data->session_id,
> +		.num_params = TEE_NUM_PARAMS
> +	};
> +	struct tee_param param[4] = {
> +		[0] = {
> +			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> +			.u.value.a = pas_id
> +		}
> +	};
> +	int ret;
> +
> +	ret = tee_client_invoke_func(data->ctx, &inv_arg, param);
> +	if (ret < 0 || inv_arg.ret != 0) {
> +		dev_err(dev, "PAS not supported, pas_id: %d, ret: %d, err: 0x%x\n",
> +			pas_id, ret, inv_arg.ret);
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +static int qcom_pas_tee_init_image(struct device *dev, u32 pas_id,
> +				   const void *metadata, size_t size,
> +				   struct qcom_pas_context *ctx)
> +{
> +	struct qcom_pas_tee_private *data = dev_get_drvdata(dev);
> +	struct tee_ioctl_invoke_arg inv_arg = {
> +		.func = TA_QCOM_PAS_INIT_IMAGE,
> +		.session = data->session_id,
> +		.num_params = TEE_NUM_PARAMS
> +	};
> +	struct tee_param param[4] = {
> +		[0] = {
> +			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> +			.u.value.a = pas_id
> +		},
> +		[1] = {
> +			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT,
> +		}
> +	};
> +	struct tee_shm *mdata_shm;
> +	u8 *mdata_buf = NULL;
> +	int ret;
> +
> +	mdata_shm = tee_shm_alloc_kernel_buf(data->ctx, size);
> +	if (IS_ERR(mdata_shm)) {
> +		dev_err(dev, "mdata_shm allocation failed\n");
> +		return PTR_ERR(mdata_shm);
> +	}
> +
> +	mdata_buf = tee_shm_get_va(mdata_shm, 0);
> +	if (IS_ERR(mdata_buf)) {
> +		dev_err(dev, "mdata_buf get VA failed\n");
> +		tee_shm_free(mdata_shm);
> +		return PTR_ERR(mdata_buf);
> +	}
> +	memcpy(mdata_buf, metadata, size);
> +
> +	param[1].u.memref.shm = mdata_shm;
> +	param[1].u.memref.size = size;
> +
> +	ret = tee_client_invoke_func(data->ctx, &inv_arg, param);
> +	if (ret < 0 || inv_arg.ret != 0) {
> +		dev_err(dev, "PAS init image failed, pas_id: %d, ret: %d, err: 0x%x\n",
> +			pas_id, ret, inv_arg.ret);
> +		tee_shm_free(mdata_shm);
> +		return ret ?: -EINVAL;
> +	}
> +
> +	if (ctx)
> +		ctx->ptr = (void *)mdata_shm;
> +	else
> +		tee_shm_free(mdata_shm);
> +
> +	return ret;
> +}
> +
> +static int qcom_pas_tee_mem_setup(struct device *dev, u32 pas_id,
> +				  phys_addr_t addr, phys_addr_t size)
> +{
> +	struct qcom_pas_tee_private *data = dev_get_drvdata(dev);
> +	struct tee_ioctl_invoke_arg inv_arg = {
> +		.func = TA_QCOM_PAS_MEM_SETUP,
> +		.session = data->session_id,
> +		.num_params = TEE_NUM_PARAMS
> +	};
> +	struct tee_param param[4] = {
> +		[0] = {
> +			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> +			.u.value.a = pas_id,
> +			.u.value.b = size,
> +		},
> +		[1] = {
> +			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> +			.u.value.a = lower_32_bits(addr),
> +			.u.value.b = upper_32_bits(addr),
> +		}
> +	};
> +	int ret;
> +
> +	ret = tee_client_invoke_func(data->ctx, &inv_arg, param);
> +	if (ret < 0 || inv_arg.ret != 0) {
> +		dev_err(dev, "PAS mem setup failed, pas_id: %d, ret: %d, err: 0x%x\n",
> +			pas_id, ret, inv_arg.ret);
> +		return ret ?: -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +DEFINE_FREE(shm_free, struct tee_shm *, tee_shm_free(_T))
> +
> +static void *qcom_pas_tee_get_rsc_table(struct device *dev,
> +					struct qcom_pas_context *ctx,
> +					void *input_rt, size_t input_rt_size,
> +					size_t *output_rt_size)
> +{
> +	struct qcom_pas_tee_private *data = dev_get_drvdata(dev);
> +	struct tee_ioctl_invoke_arg inv_arg = {
> +		.func = TA_QCOM_PAS_GET_RESOURCE_TABLE,
> +		.session = data->session_id,
> +		.num_params = TEE_NUM_PARAMS
> +	};
> +	struct tee_param param[4] = {
> +		[0] = {
> +			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> +			.u.value.a = ctx->pas_id,
> +		},
> +		[1] = {
> +			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT,
> +			.u.memref.size = input_rt_size,
> +		}
> +	};
> +	void *rt_buf = NULL;
> +	int ret;
> +
> +	ret = tee_client_invoke_func(data->ctx, &inv_arg, param);
> +	if (ret < 0 || inv_arg.ret != 0) {
> +		dev_err(dev, "PAS get RT failed, pas_id: %d, ret: %d, err: 0x%x\n",
> +			ctx->pas_id, ret, inv_arg.ret);
> +		return ret ? ERR_PTR(ret) : ERR_PTR(-EINVAL);
> +	}
> +
> +	if (param[1].u.memref.size) {
> +		struct tee_shm *rt_shm __free(shm_free) =
> +			tee_shm_alloc_kernel_buf(data->ctx,
> +						 param[1].u.memref.size);
> +		void *rt_shm_va;
> +
> +		if (IS_ERR(rt_shm)) {
> +			dev_err(dev, "rt_shm allocation failed\n");
> +			return rt_shm;
> +		}
> +
> +		rt_shm_va = tee_shm_get_va(rt_shm, 0);
> +		if (IS_ERR(rt_shm_va)) {
> +			dev_err(dev, "rt_shm get VA failed\n");
> +			return ERR_CAST(rt_shm_va);
> +		}
> +		memcpy(rt_shm_va, input_rt, input_rt_size);

It is very obvious that every existing user will pass NULL as input_rt
and 0 as input_rt_size.

Are you not getting NULL pointer on this input_rt ? Ok, you may be not
getting because, input_rt_size == 0.

I hope, your backend implementation checks for this num == 0 and then
ignore input rt.

> +
> +		param[1].u.memref.shm = rt_shm;
> +		ret = tee_client_invoke_func(data->ctx, &inv_arg, param);
> +		if (ret < 0 || inv_arg.ret != 0) {
> +			dev_err(dev, "PAS get RT failed, pas_id: %d, ret: %d, err: 0x%x\n",
> +				ctx->pas_id, ret, inv_arg.ret);
> +			return ret ? ERR_PTR(ret) : ERR_PTR(-EINVAL);
> +		}
> +
> +		if (param[1].u.memref.size) {
> +			*output_rt_size = param[1].u.memref.size;
> +			rt_buf = kmemdup(rt_shm_va, *output_rt_size, GFP_KERNEL);
> +			if (!rt_buf)
> +				return ERR_PTR(-ENOMEM);
> +		}
> +	}
> +
> +	return rt_buf;
> +}
> +
> +static int __qcom_pas_tee_auth_and_reset(struct device *dev, u32 pas_id,
> +					 phys_addr_t mem_phys, size_t mem_size)
> +{
> +	struct qcom_pas_tee_private *data = dev_get_drvdata(dev);
> +	struct tee_ioctl_invoke_arg inv_arg = {
> +		.func = TA_QCOM_PAS_AUTH_AND_RESET,
> +		.session = data->session_id,
> +		.num_params = TEE_NUM_PARAMS
> +	};
> +	struct tee_param param[4] = {
> +		[0] = {
> +			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> +			.u.value.a = pas_id,
> +			.u.value.b = mem_size,
> +		},
> +		[1] = {
> +			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> +			.u.value.a = lower_32_bits(mem_phys),
> +			.u.value.b = upper_32_bits(mem_phys),
> +		},
> +		/* Reserved for fw memory space to be shared or lent */
> +		[2] = {
> +			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT,
> +		}
> +	};
> +	int ret;
> +
> +	ret = tee_client_invoke_func(data->ctx, &inv_arg, param);
> +	if (ret < 0 || inv_arg.ret != 0) {
> +		dev_err(dev, "PAS auth reset failed, pas_id: %d, ret: %d, err: 0x%x\n",
> +			pas_id, ret, inv_arg.ret);
> +		return ret ?: -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static int qcom_pas_tee_auth_and_reset(struct device *dev, u32 pas_id)
> +{
> +	return __qcom_pas_tee_auth_and_reset(dev, pas_id, 0, 0);
> +}
> +
> +static int qcom_pas_tee_prepare_and_auth_reset(struct device *dev,
> +					       struct qcom_pas_context *ctx)
> +{
> +	return __qcom_pas_tee_auth_and_reset(dev, ctx->pas_id, ctx->mem_phys,
> +					     ctx->mem_size);
> +}
> +
> +static int qcom_pas_tee_set_remote_state(struct device *dev, u32 state,
> +					 u32 pas_id)
> +{
> +	struct qcom_pas_tee_private *data = dev_get_drvdata(dev);
> +	struct tee_ioctl_invoke_arg inv_arg = {
> +		.func = TA_QCOM_PAS_SET_REMOTE_STATE,
> +		.session = data->session_id,
> +		.num_params = TEE_NUM_PARAMS
> +	};
> +	struct tee_param param[4] = {
> +		[0] = {
> +			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> +			.u.value.a = pas_id,
> +			.u.value.b = state,
> +		}
> +	};
> +	int ret;
> +
> +	ret = tee_client_invoke_func(data->ctx, &inv_arg, param);
> +	if (ret < 0 || inv_arg.ret != 0) {
> +		dev_err(dev, "PAS shutdown failed, pas_id: %d, ret: %d, err: 0x%x\n",
> +			pas_id, ret, inv_arg.ret);

should be "PAS set remote state failed .."

> +		return ret ?: -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static int qcom_pas_tee_shutdown(struct device *dev, u32 pas_id)
> +{
> +	struct qcom_pas_tee_private *data = dev_get_drvdata(dev);
> +	struct tee_ioctl_invoke_arg inv_arg = {
> +		.func = TA_QCOM_PAS_SHUTDOWN,
> +		.session = data->session_id,
> +		.num_params = TEE_NUM_PARAMS
> +	};
> +	struct tee_param param[4] = {
> +		[0] = {
> +			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> +			.u.value.a = pas_id
> +		}
> +	};
> +	int ret;
> +
> +	ret = tee_client_invoke_func(data->ctx, &inv_arg, param);
> +	if (ret < 0 || inv_arg.ret != 0) {
> +		dev_err(dev, "PAS shutdown failed, pas_id: %d, ret: %d, err: 0x%x\n",
> +			pas_id, ret, inv_arg.ret);
> +		return ret ?: -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static void qcom_pas_tee_metadata_release(struct device *dev,
> +					  struct qcom_pas_context *ctx)
> +{
> +	struct tee_shm *mdata_shm = ctx->ptr;
> +
> +	tee_shm_free(mdata_shm);
> +}
> +
> +static struct qcom_pas_ops qcom_pas_ops_tee = {
> +	.drv_name		= "qcom-pas-tee",
> +	.supported		= qcom_pas_tee_supported,
> +	.init_image		= qcom_pas_tee_init_image,
> +	.mem_setup		= qcom_pas_tee_mem_setup,
> +	.get_rsc_table		= qcom_pas_tee_get_rsc_table,
> +	.auth_and_reset		= qcom_pas_tee_auth_and_reset,
> +	.prepare_and_auth_reset	= qcom_pas_tee_prepare_and_auth_reset,
> +	.set_remote_state	= qcom_pas_tee_set_remote_state,
> +	.shutdown		= qcom_pas_tee_shutdown,
> +	.metadata_release	= qcom_pas_tee_metadata_release,
> +};
> +
> +static int optee_ctx_match(struct tee_ioctl_version_data *ver, const void *data)
> +{
> +	return ver->impl_id == TEE_IMPL_ID_OPTEE;
> +}
> +
> +static int qcom_pas_tee_probe(struct tee_client_device *pas_dev)
> +{
> +	struct device *dev = &pas_dev->dev;
> +	struct qcom_pas_tee_private *data;
> +	struct tee_ioctl_open_session_arg sess_arg = {
> +		.clnt_login = TEE_IOCTL_LOGIN_REE_KERNEL
> +	};
> +	int ret, err = -ENODEV;

Most people prefer one line per variable..


> +
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->ctx = tee_client_open_context(NULL, optee_ctx_match, NULL, NULL);
> +	if (IS_ERR(data->ctx))
> +		return -ENODEV;
> +
> +	export_uuid(sess_arg.uuid, &pas_dev->id.uuid);
> +	ret = tee_client_open_session(data->ctx, &sess_arg, NULL);
> +	if (ret < 0 || sess_arg.ret != 0) {
> +		dev_err(dev, "tee_client_open_session failed, ret: %d, err: 0x%x\n",
> +			ret, sess_arg.ret);
> +		err = ret ?: -EINVAL;

Only user of goto,  we can close the context and return from here and
'err' not used.

		tee_client_close_context(data->ctx);
		return ret ?: -EINVAL;

> +		goto out_ctx;


> +	}
> +
> +	data->session_id = sess_arg.session;
> +	dev_set_drvdata(dev, data);
> +	qcom_pas_ops_tee.dev = dev;
> +	qcom_pas_ops_register(&qcom_pas_ops_tee);
> +
> +	return ret;
> +out_ctx:
> +	tee_client_close_context(data->ctx);

Return after two line does not look nice.

> +
> +	return err;
> +}
> +
> +static void qcom_pas_tee_remove(struct tee_client_device *pas_dev)
> +{
> +	struct device *dev = &pas_dev->dev;
> +	struct qcom_pas_tee_private *data = dev_get_drvdata(dev);
> +
> +	qcom_pas_ops_unregister();
> +	tee_client_close_session(data->ctx, data->session_id);
> +	tee_client_close_context(data->ctx);
> +}
> +
> +static const struct tee_client_device_id qcom_pas_tee_id_table[] = {
> +	{UUID_INIT(0xcff7d191, 0x7ca0, 0x4784,
> +		   0xaf, 0x13, 0x48, 0x22, 0x3b, 0x9a, 0x4f, 0xbe)},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(tee, qcom_pas_tee_id_table);
> +
> +static struct tee_client_driver optee_pas_tee_driver = {
> +	.probe		= qcom_pas_tee_probe,
> +	.remove		= qcom_pas_tee_remove,
> +	.id_table	= qcom_pas_tee_id_table,
> +	.driver		= {
> +		.name		= "qcom-pas-tee",
> +	},
> +};
> +
> +module_tee_client_driver(optee_pas_tee_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Qualcomm PAS TEE driver");
> -- 
> 2.51.0
>


With above change,

Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

-- 
-Mukesh Ojha

