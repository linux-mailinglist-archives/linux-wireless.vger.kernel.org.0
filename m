Return-Path: <linux-wireless+bounces-32647-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOLpLwb2qmlaZAEAu9opvQ
	(envelope-from <linux-wireless+bounces-32647-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 16:43:02 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDED22411E
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 16:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 27C0B308C5B4
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2026 15:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156063E9F97;
	Fri,  6 Mar 2026 15:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W3mV1Ri4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ShdBiLoF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DD53D6CC1
	for <linux-wireless@vger.kernel.org>; Fri,  6 Mar 2026 15:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772811613; cv=none; b=CibR/J/yPyYHu0fT6hn9bzIdXtIgGkqLDbCZFkFem3voP41oPzqC8bbUrhSWrVRc3fk2G/iU2Ax24TbnJUoIRiCwH2+TZsOSvozweTdgDFREh+QphVQ0e700Jr2gUhuGadnYyaQwnNP8ljokWZjBXC37GeWkTA0iWUCdmfq0df4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772811613; c=relaxed/simple;
	bh=Bt9Qa0S7HuAqxfWE+5XT2Me1HGCFa+NbCGCJteZtnfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o08SzAKu/2WAzGezCXZ6YNyxcrNzK9XxdJYUX5AFoqVHPbFlen0n4HAuEaDZ/2MwS5RV1V0rSmjr+b5rA5ITCBFZ3q/KLRQlIUV58rvEtNUjOATcbcUZR9iCW4ATyPH7sgiq+C5rezqBfaBvxAg8t7xmLDDGwNauJ9m8CJe0lMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W3mV1Ri4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ShdBiLoF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 626FTHaI3905333
	for <linux-wireless@vger.kernel.org>; Fri, 6 Mar 2026 15:40:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wpH7c7MyE5oMPFius9rdgPXUx1Fgj3bT2b7iRgr/UYQ=; b=W3mV1Ri4C0Kr+8NY
	z48jIL/Lo5XCeSg8j7D2tMGiz+BixeS5WwAv+77z6Xtmt3pR8njgOFeAZk6HFWcR
	Oe0ZKlLov/jk7pnvYIKXwyH7MfJKbX0HuZ2GueDvAeOb6k9QaQmPqWmOKdAR59pn
	xQjhDSAc5fiGNCDUU7FsPAQh5WM+mj27lJKEClXszb72kWsUAoqrv4mtMbX+Efv/
	m17Hp96OLfYiwK9tX1eSetYWiKUrZXXbobABTIeAuNZmIx4touC45LQCSaHPVUyp
	yRgXXe4KghrLLTAyBzGs+Hpwb/FHWFSoJ1U6gIwIWeqQFSbJtg7+w8atgfY78i8S
	x/xrPg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cqv9u9591-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 06 Mar 2026 15:40:10 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2bdd327d970so4373490eec.1
        for <linux-wireless@vger.kernel.org>; Fri, 06 Mar 2026 07:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772811609; x=1773416409; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wpH7c7MyE5oMPFius9rdgPXUx1Fgj3bT2b7iRgr/UYQ=;
        b=ShdBiLoFgVKC/kiBbz7d+MJ0PJCXwWOaXQk3CfwGu6Q73SBV0Tvlxj+Pj25jhwzYjl
         X4rpvQuYEcQstENZTZoVQNtOhpOaig/vPoVoLraEzid9O/xQRikKXrbi+vWKPfwRaoY8
         C0JcJA/V/dv3i+oJxpRYZn42KL0O4fdW97Ull4XOx72B1pm23uBpoBTn0GHaF/njuFsg
         HVgPNppP+pgOdT9rZF9hOodJSIGisC2oYy5HEJC4tbnN/6d4vkNZBwq599Yc5Gf1O9G9
         q2G8dwZcdkyZdI6JQuHpDoR6fYKSPxswDNMc/o+a9Oj/xfmxfHxEuac28T5Su6e5AjNS
         ZiRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772811609; x=1773416409;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wpH7c7MyE5oMPFius9rdgPXUx1Fgj3bT2b7iRgr/UYQ=;
        b=ViRdMx/uVwXhAOSclVix6iezBAUuv6rls95qP6f7NVTx3iHV8ghKooKzB1j1r4d7eg
         QECqVTiF8NvjJJY7MvJT2pBOW0gnAcjhoEf5K1EWBEAJVHZTZVrFvfu0/DydTo6fYEPl
         e7uF9+DyWY8tZH5RkztDIEOYdNfMTYuCZ+0OReBMC3ncJT8rb/lJXLfpQiOffoY7Pc+D
         zp44xG7QL2rcsxLJtcEwqAvETfzO+lU+/M7tNGy/I8WbFsjgLZReTjyY3r27Q5HQJMwA
         lh6M+fqU8mZAmStYdc+ExogXpw/phg5mP2SxrSiQd7LmA6DN4BoBcsN7q05Nq7uPetKl
         Ai2g==
X-Forwarded-Encrypted: i=1; AJvYcCWHf3wEfNB0U6XfmSLkDb4T/hPA3/yol5/riGBFXE5Pz8gDf8cCV3JbPVRU5IlAL3Ex5A/Xo8SDhu51Q9wTSw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6I7T1X1LbfnX4kabyL/5sMI8IAKx0SgwC82ihhErz+iy5HTS4
	IXCqgzw5x1198OVpXnsuoO+lSosOJURgWDKVNNDV0mvBpvmydo722TsH2bs5wZK0TfU77dEnm9T
	tUiLeVqt9XPnfQ6xP9i4WhjcTitXV5uRcwpE9p6QDqJ8yVWtwrILM4ffecB/1kQyEkgXtYg==
X-Gm-Gg: ATEYQzxplW+9uDW1TrbD3PA4MTMBvz6dmrBSZEUvTl+paqNU/V7W9o9ziTg4rW0cMJT
	WqrxsnhWznvrUxc9mtMSkxV7ZZpdkj82DvXo8Ak7kpPqKE4R9OjGaVm+PaosnCLsZNgTbOKAR2T
	lgtY/4/isSmAhYlQoQMsext0UhHpSf5/tY/HIrBzyBInY4rwAsoc8Sz4hNhXY6dCzr/G4itNLVr
	tmLlFn4UA0DjwN1b0TmoKfNQnVObiX6ZtoZ7WCzsI4h7NnSn0sMnN3NeyvSWAB5O9QmEzdIqkwo
	pQ9Rghv49mEJ76WIGOCx0sWl7N7ml0POD11RUOQCpGMjmvrpjheFf9kPWwEvMX+0fnA8d3CCPGo
	MlwOpZLeia9WFYit15XbF+mMz6sWWMgxfruxXQv6poGFKagYzIHjRMaID6rDY+efviJ0jVNKaLp
	B4WmyIRGOmaaeFGw==
X-Received: by 2002:a05:7300:ec07:b0:2a4:3593:ccba with SMTP id 5a478bee46e88-2be4e56f9f9mr928816eec.1.1772811609173;
        Fri, 06 Mar 2026 07:40:09 -0800 (PST)
X-Received: by 2002:a05:7300:ec07:b0:2a4:3593:ccba with SMTP id 5a478bee46e88-2be4e56f9f9mr928768eec.1.1772811608557;
        Fri, 06 Mar 2026 07:40:08 -0800 (PST)
Received: from [192.168.1.41] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f94833bsm1356612eec.18.2026.03.06.07.40.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 07:40:08 -0800 (PST)
Message-ID: <9741588f-e6a1-4749-970b-3ed814399a32@oss.qualcomm.com>
Date: Fri, 6 Mar 2026 07:40:04 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] firmware: qcom: Add a generic PAS service
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
        skare@qti.qualcomm.com, Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20260306105027.290375-1-sumit.garg@kernel.org>
 <20260306105027.290375-3-sumit.garg@kernel.org>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260306105027.290375-3-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDE0NiBTYWx0ZWRfX15yUqLU4vYy1
 RBGJdhpNjTYTtZ9/ZFjNGQgxebsFZ2qzN0HpY3cd4gqbuPks50L20oSP0tG914mqIX8Nm1UFMPS
 kF1jxHN2UoKmOxyfSYzRakBPU9679vHPOeViiTdiDfFeyLs2s3kOHDCT1cdkw0BbGC+lac+Opyi
 rhkqLKMxo8luDl023HcuxuHc5hIMuHkl/c+3hcjCOuX9hqF7vJI+WtFFMc4dmv9f5kVEbTb6Bkc
 ibr7umvqnOWJtLEdYfVcWM4eHO0t5GTu/IlLoVGgGOqZ60eg5t1VeWz4BMv9sltvaSahCe0hVQa
 othM8vGLtBsm6o23wmX3pGP//CZifou+sKKH4+mJ/taB9pVbrBl05BauRqx84yQY3Gor+JqtewS
 rKwrdaa43NLMDv5bgl6Dwom6fHaUtJK4bGDxTRQtl4dihS/4GyBbYIywgSTHQnPXLsPZiCYTBSA
 eWeLx4FkLax5mm3OvNA==
X-Proofpoint-ORIG-GUID: 7qm7sAKc97oUIOpDbQBm80mVZWGsAp_M
X-Proofpoint-GUID: 7qm7sAKc97oUIOpDbQBm80mVZWGsAp_M
X-Authority-Analysis: v=2.4 cv=eJoeTXp1 c=1 sm=1 tr=0 ts=69aaf55a cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=40pWYZonmZhD7659SdoA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_04,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060146
X-Rspamd-Queue-Id: 3DDED22411E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	TAGGED_FROM(0.00)[bounces-32647-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	TAGGED_RCPT(0.00)[linux-wireless,dt,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 3/6/2026 2:50 AM, Sumit Garg wrote:
>  drivers/firmware/qcom/Kconfig          |   8 +
>  drivers/firmware/qcom/Makefile         |   1 +
>  drivers/firmware/qcom/qcom_pas.c       | 295 +++++++++++++++++++++++++

kernel-doc is throwing some warnings in this file which I've listed below.
kernel-doc is also throwing warnings in some of the other files touched by
this series, but since those are presumably preexisting I didn't bother to
mention them. Just want to avoid adding new warnings.

>  drivers/firmware/qcom/qcom_pas.h       |  53 +++++
>  include/linux/firmware/qcom/qcom_pas.h |  41 ++++
>  5 files changed, 398 insertions(+)
>  create mode 100644 drivers/firmware/qcom/qcom_pas.c
>  create mode 100644 drivers/firmware/qcom/qcom_pas.h
>  create mode 100644 include/linux/firmware/qcom/qcom_pas.h
...
> +/**
> + * qcom_pas_mem_setup() - Prepare the memory related to a given peripheral
> + *			  for firmware loading
> + * @pas_id:	peripheral authentication service id
> + * @addr:	start address of memory area to prepare
> + * @size:	size of the memory area to prepare
> + *
> + * Returns 0 on success.

kernel-doc complains:
Warning: drivers/firmware/qcom/qcom_pas.c:103 No description found for return
value of 'qcom_pas_mem_setup'

should use the kernel-doc Return: tag

 * Return: 0 on success

(Returns: is also accepted although not documented)

> + */
...
> +/**
> + * qcom_scm_pas_auth_and_reset() - Authenticate the given peripheral firmware
> + *				   and reset the remote processor
> + * @pas_id:	peripheral authentication service id
> + *
> + * Return 0 on success.

hmmm, kernel-doc didn't complain about this one so the script must accept
'Return' without the ":" (but not 'Returns' without the ":").

Suggest changing to Return: to be conformant with the actual documentation:
<https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html#function-documentation>

> + */
> +int qcom_pas_auth_and_reset(u32 pas_id)
> +{
> +	if (ops_ptr)
> +		return ops_ptr->auth_and_reset(ops_ptr->dev, pas_id);
> +
> +	return -ENODEV;
> +}
> +EXPORT_SYMBOL_GPL(qcom_pas_auth_and_reset);
...
> +/**
> + * qcom_pas_set_remote_state() - Set the remote processor state
> + * @state:	peripheral state
> + * @pas_id:	peripheral authentication service id
> + *
> + * Returns 0 on success.

Warning: drivers/firmware/qcom/qcom_pas.c:217 No description found for return
value of 'qcom_pas_set_remote_state'

> + */
...
> +/**
> + * qcom_pas_shutdown() - Shut down the remote processor
> + * @pas_id:	peripheral authentication service id
> + *
> + * Returns 0 on success.

Warning: drivers/firmware/qcom/qcom_pas.c:232 No description found for return
value of 'qcom_pas_shutdown'

> + */
...
> +/**
> + * qcom_pas_supported() - Check if the peripheral authentication service is
> + *			  available for the given peripheral
> + * @pas_id:	peripheral authentication service id
> + *
> + * Returns true if PAS is supported for this peripheral, otherwise false.

Warning: drivers/firmware/qcom/qcom_pas.c:248 No description found for return
value of 'qcom_pas_supported'

> + */
...
> +/**
> + * qcom_pas_is_available() - Check for PAS service
> + *
> + * Returns true on success.

Warning: drivers/firmware/qcom/qcom_pas.c:262 No description found for return
value of 'qcom_pas_is_available'

> + */

