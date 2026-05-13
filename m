Return-Path: <linux-wireless+bounces-36350-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFCqJu6/A2or+AEAu9opvQ
	(envelope-from <linux-wireless+bounces-36350-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 02:03:58 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2AE52B777
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 02:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 094A0303670B
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 00:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF1A4086A;
	Wed, 13 May 2026 00:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QnKuHmYc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iZXXS/qM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9A24594A
	for <linux-wireless@vger.kernel.org>; Wed, 13 May 2026 00:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778630634; cv=none; b=KikV0SUZIRo/lX75h0WwpwPlEgh5w1jaxjzY26uOUoCog1xi2vexh16ta4yiggS2kallz/cMlcqeWXZFuCpyhAVGS5WD+VxAL9CMsJeq/PbThRN2bsHhgV3ZXx4CAoJghshXbLQKTJs6TY4mpCtMVEmxPu+dmbSnkqqhVANivyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778630634; c=relaxed/simple;
	bh=GMKySTkBDCMEn9cmriP73JC1ihzNspkvfuySUl79jbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SS8tBPEGICkf9tA9713PfkCqbI53DumIs3Dm8H/d4m75rQiYxfzwALgRX+YBZr+ur8Q/5Lg/MtfWLijzJidGPl1GqK5QbDuK3QFCBkKABSgD32js7Y8lduUomk84Q7aEMNxHe17la7PRRY4ujGVfWQQPepCx93I2CQsGSAd4X7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QnKuHmYc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iZXXS/qM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64CLnDGK1414297
	for <linux-wireless@vger.kernel.org>; Wed, 13 May 2026 00:03:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xRsjr2XRZOOe7w30bXakQLv+3EIBrw/fqmP4NplYARU=; b=QnKuHmYcWDLtAAK/
	dYhFRpF35KvwqrM+LmDM+7qj7VOFKPXjTjZCXndOu/8GxLi48MihMt20Eff+n5F2
	n/XGV8wGMq8+NvO0ZoL7eYS0eAW+nOstLlKH/PxgQeEEkIz/v4V3hlXfNudQHJqS
	9eMLfyMxSvAzDlajY43NeGr5FeBamP872//7Csz84bAFAX2gkoutmdSRG0Ag2CDf
	2UIxxQZpwIBblPsZFKj/rhcBshguwSZ4gzwuwJz8ScZLEbx9rn7J20sRjXbZ5Jx+
	3VJn74ZvCPCCASOCMrsC3MfVyXCIjdwM7SojfgOxNhnzPiNj3Lpc0o2RqUwyEGAG
	vGz2Kg==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e45v5a1ah-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 13 May 2026 00:03:51 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1270dcd11c1so12244803c88.0
        for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 17:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778630631; x=1779235431; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xRsjr2XRZOOe7w30bXakQLv+3EIBrw/fqmP4NplYARU=;
        b=iZXXS/qMENcMO15pu8UynqGHCoQP19mCP1XzjlpyHkrGwbOv5xguXBT6wj+nXsVpvQ
         5MGmw54fGmHy3OoOUvXqQTfqA0BUGvd+UPaSWqQikjzzVrD7VSaT7UgADi15VSgOeRoW
         TIznHLF8ysXQQ3wgzYVQ9ck0W9DvsU5YAMKte5JNRNT8t2r5uSAE/ifcA/0KG4ZXcHod
         sVMX8nq1brZ5hZmGoUe98wzx6oiMSk44zkJeRu2dSMG1jbOsHYfYSyKNwPoC4qE6aJc0
         Rb3UZ5/CXmz6UW4ILl3zx2fZvpoXxnuAUfqXnUexywQX/U27dR0oCH8Kdl24lKjD0Gxi
         SsQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778630631; x=1779235431;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xRsjr2XRZOOe7w30bXakQLv+3EIBrw/fqmP4NplYARU=;
        b=S5oT+rfZQT/jDNUmSZe2c7peFM7Xvmv1S4mTrDALXmp+KXqyEBcFfUb3RVuGjeGLYe
         5TIVTqVfGtbO1tTXTVeyNdMyiDkR0VMo1kvPPqrHvbFPVBEfxQp3jVLlHQwPhIDh7dcU
         +rqj/xZe5GCZl16+LjVW2aHJmV9qR+paRIpopMggqxO+yI7ve890mzUlb6uU3/FMkaWN
         6sJcd2LL22xMo1kuNshWhPSLm6MN1UmFGFbrnr03wb6juctm3eFK0hohcVM/oZow1jRT
         vr9vhW+cPo4rvxrnIFBicQxWvoOeiVOnVDARZYbHsIfZpaRpnmy5ZG+ydaBEnEA7cYVu
         uxpw==
X-Forwarded-Encrypted: i=1; AFNElJ+j6IZfkCBPnBjxbTDKRxwRGkoVXRlhRZmzi1ugZZX8FblV2cWmCm27Cis+Z282gz6V9u0OgEvBJJjaa6cFNg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZYPFJ/407F2hD+CI8iGcBL3o8eZxBOP+WzGim0wctGXLDBKLo
	LlcNeFFphs1GR0mmpQJT3v8QgIdKxTrCA2g7mTiGwMHfrL/4j5/O+BoFPleeeI6q1b6cukp/MX+
	W1baNe6dhza7tBGMLTr+k6ILTobQiUflTPSYGSExmz2C7AU6BIkaBA88x0lW3B+BaqYkmAA==
X-Gm-Gg: Acq92OH0Geex7maw4PWnHBkpe0Ye7QYRD3uvduxG0fvR8KsWEJASDnxZ+m8vjbYViTp
	JMAi0KufsVpM1RzLyhU5jKvXURE48x8afQAObFFWj9jsnCQk34gG8/xbl5wCf6hKQfev9nO2+kK
	bpY+WqqF7y4PqoDSC+xwiw/aqdV5kM2M83grdMdpgs92eLALjbVN9DovoE58PexBA+kTPVon+nS
	lAhvARyCwZFSnwIJEr95xhzE68TtPk9i0CV6cc4l4i1g0ebShH39ilnKb0UqxScpp4Q/HrqQ+cU
	1wC8slN8Hgjc7P8oIzz5xz9cm/3d7KisCdifpRFHizJFya0xDVK6+ZS9HUuOGYTkZLi1o68XlFx
	SWkb6Dy2HUSe+PN+GGBxf3EAloXf/PXEtdZRU9hmgT+GfmPCyYK42x7IJCKINStrWKpwfvVenLx
	D9aMK5vRHo6/iAow==
X-Received: by 2002:a05:701a:c971:b0:119:e56b:98a4 with SMTP id a92af1059eb24-1349a80b5a7mr296500c88.11.1778630630866;
        Tue, 12 May 2026 17:03:50 -0700 (PDT)
X-Received: by 2002:a05:701a:c971:b0:119:e56b:98a4 with SMTP id a92af1059eb24-1349a80b5a7mr296484c88.11.1778630630286;
        Tue, 12 May 2026 17:03:50 -0700 (PDT)
Received: from [192.168.1.59] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13278210ff2sm21412690c88.6.2026.05.12.17.03.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 17:03:49 -0700 (PDT)
Message-ID: <45f1c979-ea8d-4118-8551-eff93966b4e1@oss.qualcomm.com>
Date: Tue, 12 May 2026 17:03:48 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath11k: Add two missing Lenovo IDs to the quirk
 table
To: =?UTF-8?Q?Santiago_Ruano_Rinc=C3=B3n?= <santiagorr@riseup.net>,
        Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, linux-kernel@vger.kernel.org,
        kfarnung@outlook.com, Kyle Farnung <kfarnung@gmail.com>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>, koike@igalia.com
References: <20260506200249.317690-1-santiagorr@riseup.net>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260506200249.317690-1-santiagorr@riseup.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDI0NiBTYWx0ZWRfXxTId8IQCADsr
 zubtp4TA+tdMHO+csRpWcT1QWAjz5ZFssu3A2FOv/zAY9bkaL7Mfc+HxebCzCempbg0EZfL/Bb+
 TbPDa+FQssKMAd6KivHa0i53xqXS4+4/9SDDnqCtEkqhbnSu0OfZNkGJomwMbPaUSe0d6XLGDOr
 pPBoJOvm8YTDJa43hiOrP9kYCi+wjMMP35Ks1Dh4kgr62WUhMlEdpxu55oKXhBIYDOxOCVljLv5
 7lLpCmkj8QG78pr6Fnux7qFk6kPQHVdP1vb2s1swJq4u2otQb2/yWbAy4PPsEnFKS3PzBJz8zg8
 GNt1JHcDpu7lB433RUl9dK9hV5bIo1o9CbhSPxtdAXK3gophkG9pUTRcjVYtP9ENzCFlNEA/gYz
 S+7oJDXn06P62hoslodyPA8x3KGbKZaBNCChQR2VsVEPYS/lOwvmGRlENUmo5KU1ntkN7bEkldy
 YU+9diC4dHZ/RVkILyA==
X-Authority-Analysis: v=2.4 cv=GZ8nWwXL c=1 sm=1 tr=0 ts=6a03bfe7 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=bBqXziUQAAAA:8 a=UdeeB3KLDkuo1hJFcNUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22
 a=BjKv_IHbNJvPKzgot4uq:22
X-Proofpoint-GUID: e2PuMrBJvvR6n2xzH2bwiY5XcQ21z8GJ
X-Proofpoint-ORIG-GUID: e2PuMrBJvvR6n2xzH2bwiY5XcQ21z8GJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0
 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120246
X-Rspamd-Queue-Id: 0F2AE52B777
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-36350-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[riseup.net,kernel.org,vger.kernel.org,lists.infradead.org,outlook.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 5/6/2026 12:54 PM, Santiago Ruano Rincón wrote:
> Commit 0eb002c93c3b4 ("wifi: ath11k: Add missing platform IDs for quirk
> table") added some Lenovo platform IDs to the quirk table to address a
> wakeup from suspend issue [1].  However, at least P14s Gen 5 AMD, as
> reported by Kyle Farnung [2], and P14s Gen 3 AMD are missing in the
> table.  This commit adds the two corresponding Lenovo version IDs for
> each.
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=219196
> [2] https://bugzilla.kernel.org/show_bug.cgi?id=219196#c23
> 
> Tested-on: P14s G3 AMD running 7.0.3.
> 
> Fixes: ce8669a27016 ("wifi: ath11k: determine PM policy based on machine model")
> Co-authored-by: Kyle Farnung <kfarnung@gmail.com>

This is not a standard Linux kernel commit tag.
Co-developed-by: could be used, but I'd need a Signed-off-by: from Kyle

Kyle, if you'd like these added please reply with both a Co-developed-by and
a Signed-off-by tag

I can apply these fixes when I process the patch in my tree.

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by

> Signed-off-by: Santiago Ruano Rincón <santiagorr@riseup.net>
> ---
> Changes in v2:
> - Merged the Lenovo P14s G5 AMD #1 and #2 related changes proposed by
>   Kyle Farnung in
>   https://lore.kernel.org/all/20260330-p14s-pm-quirk-v2-1-ef18ce07996b@gmail.com/
> - Added Kyle Farnung as Co-author of the commit
> - Added the second ID of Lenovo P14s G3 AMD, and adapt the comments
>   accordingly
> - v1: https://lore.kernel.org/ath11k/20260423211458.458911-1-santiagorr@riseup.net/
> ---
>  drivers/net/wireless/ath/ath11k/core.c | 28 ++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
> index 3f6f4db5b7ee..c1ce0a11af44 100644
> --- a/drivers/net/wireless/ath/ath11k/core.c
> +++ b/drivers/net/wireless/ath/ath11k/core.c
> @@ -957,6 +957,20 @@ static const struct dmi_system_id ath11k_pm_quirk_table[] = {
>  			DMI_MATCH(DMI_PRODUCT_NAME, "21K4"),
>  		},
>  	},
> +	{
> +		.driver_data = (void *)ATH11K_PM_WOW,
> +		.matches = { /* P14s G3 AMD #1 */
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "21J5"),
> +		},
> +	},
> +	{
> +		.driver_data = (void *)ATH11K_PM_WOW,
> +		.matches = { /* P14s G3 AMD #2 */
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "21J6"),
> +		},
> +	},
>  	{
>  		.driver_data = (void *)ATH11K_PM_WOW,
>  		.matches = { /* P14s G4 AMD #1 */
> @@ -971,6 +985,20 @@ static const struct dmi_system_id ath11k_pm_quirk_table[] = {
>  			DMI_MATCH(DMI_PRODUCT_NAME, "21K6"),
>  		},
>  	},
> +	{
> +		.driver_data = (void *)ATH11K_PM_WOW,
> +		.matches = { /* P14s G5 AMD #1 */
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "21ME"),
> +		},
> +	},
> +	{
> +		.driver_data = (void *)ATH11K_PM_WOW,
> +		.matches = { /* P14s G5 AMD #2 */
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "21MF"),
> +		},
> +	},
>  	{
>  		.driver_data = (void *)ATH11K_PM_WOW,
>  		.matches = { /* T16 G2 AMD #1 */


