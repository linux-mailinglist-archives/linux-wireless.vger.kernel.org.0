Return-Path: <linux-wireless+bounces-34186-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6P0EKX1Tymn27gUAu9opvQ
	(envelope-from <linux-wireless+bounces-34186-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 12:42:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 342F5359918
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 12:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E44EB3080FA2
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 10:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C303B52FA;
	Mon, 30 Mar 2026 10:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lCYLTIFl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XAa48mK1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F663BC661
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 10:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774867029; cv=none; b=J7uS8zwWl8K+W3sD8s+T/zZ+wubbk+njhK99TOl8VqHSWT6yAQLDl0WGE9pJozmH06EoLoCgvXmYBTgzoB3XhHnLJnQqQG7Tfk4x8AZmNO8TDxrjbBlOKrF6CHf9XlIhA6kvOVknp9TZLKCnTev+cDjVpAOO06rkC1UPxX0sEuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774867029; c=relaxed/simple;
	bh=HYRVavxoNYK1FyOfMIicTrBsVtfWm4g6JbYH2uFM3sk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H7lQsZePVG2zjattYhycrp1sZSVC3lD1rkWVbKgbS1N13AXbV1FMSiTnpIU727NTalJGsk2C18lq+18rFv1Kun3XXNNUtAmvvbiqBQX1SbTDKL063wv67nhAw/EMQPMh+hCh3PRs+72+H+DTJwV/Mgv8DEIzPjbGiqBB6tAt1tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lCYLTIFl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XAa48mK1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62UAGdnS3173912
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 10:37:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rS3q4/ckZwfhIe+L/YtKzkCxLX5gEQTddXgVybWNDR0=; b=lCYLTIFl+FdK0XIG
	ziMxedSFCqONG+x4qug8Avv4zbsIyVFLaCHQ+9QAZZbXyZhpohVrLjO+3ffBzfBT
	uuiLXknUR0XrlDbFDtgQEfjhS49QmnyGDae/1x/72GSTC64pTNwHgdAWBoTCVO0V
	o0wVojDOK/JleyJph9T4o25FCE0m2BUsbQpl9PHiJTnXkHDsYBSH7gz/FUsuHACt
	L45cO85O5whi0Nyyh7yi6PFQHTnjfVUYMKdY4ijmKf73ndatCEJ1E6JaiU3Gk9yH
	QOGVPvFSwVCo/Yq4CEWE3paaZwQUqfhMND5Twg4SoKWKmwNmMXuc9Gt2zPr4YCvr
	njHKaQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7q9h0251-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 10:37:03 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2adef9d486bso83987955ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 03:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774867022; x=1775471822; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rS3q4/ckZwfhIe+L/YtKzkCxLX5gEQTddXgVybWNDR0=;
        b=XAa48mK1O2GjJR9K+C+wQY9WOA6ni7ByN7CqmjCq5eD8OaVDqhbfNJQpOSoaHuJAzq
         WG9Eqi1FEnF3fsPyFnx+7gvGQdOpYUFeKW8wYZuEV3hNgpAWSBXhdr0emKQpg4Xz8Z+f
         W7Aa3WuHKPlHk3mx62w7hPvkzboQ4umXHqwpr1WZq9bHcoFSxHhXB9U5BSaQbIEejzNI
         yEod/IKIcUx+TZuZNIZ5oAwhfyXlgRGc/3hKiqZdXdALYQTT87d91Heqk0nuhGYPWl9Q
         dJiXzKetzoXzIwbAbuHGvL3qLWkYXibgFfZ5sRWOUlRBCVGUGqfOFPKBmG8FV5Fw8Fxq
         0uxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774867022; x=1775471822;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rS3q4/ckZwfhIe+L/YtKzkCxLX5gEQTddXgVybWNDR0=;
        b=hVL3bTjSUb5tt8uaukjmDOfj18lTKpOX/RYXBD/KT/tyXdWVBq96HbqY+tfFsb2rZd
         vCIqH7hr8oXBvXbpbv2FLPmKbUxkrE05sSmQtsQbuWdoTKxUlPeuDmxURe5ssrA2qsPa
         lyLChYmmZa1pPDjhbMXQOnFO3XrSdVTP+kuVt66o03tAvFkv2TR8X1svOMRxk52DqYpK
         ZSDGSz36BSiXxHGNTvrn4Yqb27Q7vCx0UzRdmAC7xcaDA61exyoM1elVvqF9Cm1asE7F
         Q4Y4myiE0unqp85MZGw3xNLgOX3zwqDMZahZ8tiXSs1qcS9V122jPcvtP4vlySsl0e+H
         Eeug==
X-Forwarded-Encrypted: i=1; AJvYcCXAxGGMgMIFGDdDUSWmz+LcKtzH5AAuSYbedj7gvFI2HazxIyNqATRoy8mP3nyby2mabqUFtGSbyls57GtV6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPbLGFetTjOjb7HbWUtLo4/iJMkeelrx/0MlhhDrdSxNpUba/+
	/2mw5lidyJ4BFpQu2Nk1dpXwOngLQVxsLEnWG5GFBGTz3GHih5/srfzhHh7KqzT8mpsFO/12A/b
	Q/9qnqumoRPrGQA8IBXis1abe3O6u1DAaJmsh7clWWm9r93hBUGb3iSN1Jsx7zTJb/bEglw==
X-Gm-Gg: ATEYQzzZ95Hu0yjyJaPZ4ny2ZS5g8qPMB8UFAHDI5VpYvPBQkYRBLayt7q0EI20tWZe
	fF28es/gKQSHmgGgJvOjCvc9LS/5X+rZ1u6dxkY/NylnfFf6FU+wPivbWSIcHTUbsJWDeBfydcw
	+58QYMia/9GcAKsXHK0kiNw218bRRLH0UMpmfY1S2y4aSKwejvEaAoIRsO2XMh4n1TYvTfsyDY1
	krq5fxu7gPi0rFgsShdTvDoUMai6p2LV4hQGhng9sjVBW24T472YCy74XPPWsmwYspVQGhL4JdO
	6fGOKfTSED32lf/BcztkjhrE/qw0Vp+JNplgYTLjt0F1K+rsE5xq5BtlMnHwJ1cKXwpLri+BEbh
	xu4Efbu6ATJWDni5OiqZY6DjyMv4+WOyMPPFLgPF92jwvj/NeLJs=
X-Received: by 2002:a17:902:da4d:b0:2b0:70c8:ccea with SMTP id d9443c01a7336-2b0cdc28c47mr99334895ad.13.1774867022315;
        Mon, 30 Mar 2026 03:37:02 -0700 (PDT)
X-Received: by 2002:a17:902:da4d:b0:2b0:70c8:ccea with SMTP id d9443c01a7336-2b0cdc28c47mr99334605ad.13.1774867021710;
        Mon, 30 Mar 2026 03:37:01 -0700 (PDT)
Received: from [10.217.223.121] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427c5339sm78747725ad.79.2026.03.30.03.36.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 03:37:01 -0700 (PDT)
Message-ID: <000abdb5-a8b4-47c4-860b-5666e650b545@oss.qualcomm.com>
Date: Mon, 30 Mar 2026 16:06:47 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/15] firmware: qcom: Add a PAS TEE service
To: Sumit Garg <sumit.garg@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-media@vger.kernel.org,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com,
        sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org,
        abhinav.kumar@linux.dev, jesszhan0024@gmail.com,
        marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch,
        vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com,
        bod@kernel.org, mchehab@kernel.org, elder@kernel.org,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org,
        mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com,
        mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com,
        jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com,
        vignesh.viswanathan@oss.qualcomm.com,
        srinivas.kandagatla@oss.qualcomm.com,
        amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
        op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
        skare@qti.qualcomm.com, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20260327131043.627120-1-sumit.garg@kernel.org>
 <20260327131043.627120-5-sumit.garg@kernel.org>
Content-Language: en-US
From: Harshal Dev <harshal.dev@oss.qualcomm.com>
In-Reply-To: <20260327131043.627120-5-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA4MyBTYWx0ZWRfXyGDflUvwIXiK
 i6hGOsxH1tqMVmrnsTUDcz8z8SVdHq/9HQpDMKEdd7//WHrBR+R0RYFbdYOHMOciUJpane4WM7e
 hf+aj9ZnVqLxVkJJHUeI7gHiKlg4T6Fjl2wijC33yCQU03aerF1NMpNdrbpuR6C90mdI00n0Gvz
 cxbUthEuCEBKKPR2Z0OqHjKi94APXigrpnrrKjmvP/aPyWYGoK2xeK4Ehkoyj/00i4l9REILuWq
 8RD4V1XZOqC8hAto+mNMf0APOO/XHkRh2XF2VP5JwPje8o6j11A9NV7QuhWtoKAWajA02Ng0MOk
 gvz/mg8mEHyof9cuCB9Dl2IBL9KCjK4oH0GA5o7n57m/t66tEHKjLFrN33x0drKLZCj0Cx2BQO3
 rpRG59x2RVoK77udwlw4ZutFkgh2rHtFyhFpGjC+JyfkWl0NpiuNxfJGIJvgkhV2DnxkjHzWmtr
 e7/mP5vhEj3NAfaLLng==
X-Authority-Analysis: v=2.4 cv=AZS83nXG c=1 sm=1 tr=0 ts=69ca524f cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=RWzqk8q2zN-G-DdlaHkA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: E6D73CbicmHFiGIglZEswyK92Y1RJ6I5
X-Proofpoint-ORIG-GUID: E6D73CbicmHFiGIglZEswyK92Y1RJ6I5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603300083
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org,vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-34186-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harshal.dev@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_GT_50(0.00)[50];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt,netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 342F5359918
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/27/2026 6:40 PM, Sumit Garg wrote:
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
>  drivers/firmware/qcom/qcom_pas_tee.c | 478 +++++++++++++++++++++++++++
>  3 files changed, 489 insertions(+)
>  create mode 100644 drivers/firmware/qcom/qcom_pas_tee.c
>
[...]

> diff --git a/drivers/firmware/qcom/qcom_pas_tee.c b/drivers/firmware/qcom/qcom_pas_tee.c
> new file mode 100644
> index 000000000000..d63122c34f04
> --- /dev/null
> +++ b/drivers/firmware/qcom/qcom_pas_tee.c
> @@ -0,0 +1,478 @@
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

Nit: Column alignment of comment descriptions.

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
> +		dev_err(dev, "PAS not supported, pas_id: %d, err: %x\n",
> +			pas_id, inv_arg.ret);

I can see that similar error handling pattern for tee_client_invoke_func() is
being done by other clients. But it seems that this error log doesn't really convey
whether we failed before or after entering OPTEE (or some other TEE) for invoking
the service.

Could be better if we print 'ret' when ret < 0. And print 'inv_arg.ret' when
inv_arg.ret != 0. So for example, if the param marshalling fails, or some other
issue is encountered when processing the params in a different back-end TEE
driver, we could know from the logs.

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
> +	if (!ctx)
> +		return -EINVAL;
> +
> +	mdata_shm = tee_shm_alloc_kernel_buf(data->ctx, size);

Why not move the DEFINE_FREE() above this function so we can use scoped free
here as well for mdata_shm?

struct tee_shm *mdata_shm __free(shm_free) = ...

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
> +		dev_err(dev, "PAS init image failed, pas_id: %d, err: %x\n",

Nit: We can prefix %x with 0x. "err: 0x%x\n."

> +			pas_id, inv_arg.ret);
> +		tee_shm_free(mdata_shm);
> +		return -EINVAL;
> +	}
> +	ctx->ptr = (void *)mdata_shm;
> +
> +	return 0;
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
> +		dev_err(dev, "PAS mem setup failed, pas_id: %d, err: %x\n",
> +			pas_id, inv_arg.ret);
> +		return -EINVAL;

I can see that originally in-case of error, qcom_scm_pas_mem_setup() bubbles
up the return value from qcom_scm_call(). Perhaps we should do the same as well,
return ret here instead of hard-coded '-EINVAL' which overrides any useful
return values returned from the back-end TEE driver.
 
> +	}
> +
> +	return 0;
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
> +		dev_err(dev, "PAS get RT failed, pas_id: %d, err: %x\n",
> +			ctx->pas_id, inv_arg.ret);
> +		return ERR_PTR(-EINVAL);

Same comment here, we could return ERR_PTR(ret) instead of overriding to
'-EINVAL'.

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
> +		if (IS_ERR_OR_NULL(rt_shm_va)) {
> +			dev_err(dev, "rt_shm get VA failed\n");
> +			return ERR_PTR(-EINVAL);

Why not just return rt_shm_va? It already encodes the error in the pointer.

> +		}
> +		memcpy(rt_shm_va, input_rt, input_rt_size);
> +
> +		param[1].u.memref.shm = rt_shm;
> +		ret = tee_client_invoke_func(data->ctx, &inv_arg, param);
> +		if (ret < 0 || inv_arg.ret != 0) {
> +			dev_err(dev, "PAS get RT failed, pas_id: %d, err: %x\n",
> +				ctx->pas_id, inv_arg.ret);
> +			return ERR_PTR(-EINVAL);

Same comment.

> +		}
> +
> +		if (param[1].u.memref.size) {

Is it possible for param[1].u.memref.size to be 0 after a successful tee_client_invoke_func()?

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

Can you explain this comment a bit more? Plan is to allow passing a MEM_REF here
which could be lent/shared to TEE via FFA ABI?

> +		[2] = {
> +			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT,
> +		}
> +	};
> +	int ret;
> +
> +	ret = tee_client_invoke_func(data->ctx, &inv_arg, param);
> +	if (ret < 0 || inv_arg.ret != 0) {
> +		dev_err(dev, "PAS auth reset failed, pas_id: %d, err: %x\n",
> +			pas_id, inv_arg.ret);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int qcom_pas_tee_auth_and_reset(struct device *dev, u32 pas_id)

I'm guessing once all clients have migrated to PAS, plan is to drop this wrapper?

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

Nit: Why not ret = 0 initialize and always use ret?

> +
> +	ret = tee_client_invoke_func(data->ctx, &inv_arg, param);
> +	if (ret < 0 || inv_arg.ret != 0) {
> +		dev_err(dev, "PAS shutdown failed, pas_id: %d, err: %x\n",
> +			pas_id, inv_arg.ret);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
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
> +	int ret = 0;
> +
> +	ret = tee_client_invoke_func(data->ctx, &inv_arg, param);
> +	if (ret < 0 || inv_arg.ret != 0) {
> +		dev_err(dev, "PAS shutdown failed, pas_id: %d, err: %x\n",
> +			pas_id, inv_arg.ret);
> +		return -EINVAL;
> +	}
> +
> +	return 0;

You could just return 'ret' here. :)

> +}
> +
> +static void qcom_pas_tee_metadata_release(struct device *dev,
> +					  struct qcom_pas_context *ctx)
> +{
> +	struct tee_shm *mdata_shm = ctx->ptr;
> +

Nit: Unnecessary extra line.

> +	tee_shm_free(mdata_shm);
> +}
> +

[...]

> +
> +module_tee_client_driver(optee_pas_tee_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("TEE bus based Qualcomm PAS driver");

Since this is a tee_client driver, isn't it self-explanatary that it's TEE bus based?



