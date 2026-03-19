Return-Path: <linux-wireless+bounces-33510-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qE4LF5dFvGkJwQIAu9opvQ
	(envelope-from <linux-wireless+bounces-33510-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 19:51:03 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA6E2D1595
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 19:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3F30B3050433
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 18:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E423559DF;
	Thu, 19 Mar 2026 18:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YSopD4qg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H7Mh6joC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E11034DB7F
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 18:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773946236; cv=none; b=D8/MN6beUlOSwCemQaDBhYDPPb35m3dsC25oqo2LYvmgC7H1+zEzEUqz4afZzsch9uZ7DR4UUyO9xyzsWepsNiqc8Uc0K18oM0oaIQyNXHrZZ32xR46dxc7EdiOV1TyCLvrd5BUqta0BcxS9BCiS3YGvOWEleUHIArZlKHOiwA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773946236; c=relaxed/simple;
	bh=gr/9NeEAFUkbVQbfw4Mz4GNhFZSSp1BkHRJt9tIUqz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U0PIg8+ueH8JbXsqMW6ohHSNSH1+9Hfp/rAUAOONwNoQjjmKQd2019jsL7xHwu+PWJhvqjgXzP0PXFF13B6TO7KRYCZF2AT6+uYlz33RMq5PTolAOABZOQeALovB1j7CrLhzEzmj7coA03vfCggL2DyEai4ZyhXY+eeku4ZXCpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YSopD4qg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=H7Mh6joC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62JEcCSP1027121
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 18:50:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gr/9NeEAFUkbVQbfw4Mz4GNhFZSSp1BkHRJt9tIUqz4=; b=YSopD4qgHwbIVIpz
	oqUx2FZRfeiSp7FyrEuC83/50T28HT1CW/+rdOV51TEMTWaSNRq9bzKd1MhOCm4J
	exV3MwIj+etMLmexHrYnot72cf4c2CK5T/atE43P/CqkUbchc26SJNtKSlrAse+8
	Q/zuMIynH442jCSbWYEOeIeJyHf5RtdxYX8vLcKkfVwUYZjlrPMGDc3sveQ7367I
	zXzE4So2vvHPQAtkA4GzJ4pOfbjiXQRlgcv71fT8gzfuC/UETr66Rgh1pQP2whqO
	/eEpqAt+JrvAP/J8Mv2tpxuEZw0eIFebSnta3takZmBbelOCBQD29h3o6hWD4L+T
	0MMUzA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d0032mjqw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 18:50:34 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2bda35eab74so867975eec.0
        for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 11:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773946233; x=1774551033; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gr/9NeEAFUkbVQbfw4Mz4GNhFZSSp1BkHRJt9tIUqz4=;
        b=H7Mh6joCJ/H1sjDeT5PXpC4yDNnZVyKGegg8qigTKeCGbWVvZ5ia/pqnjRSgIiBUzX
         irqSyEYoPhVHKTWE47bAzzE1exc3inq61KKN1MxVWfd8dXEoA/m1k0T5uvvutSexY5vd
         WM5UXgcOcGbiK45ufsvW180uGxXIlzgs1281Y1Q8msGm7pCq+XSzAA9KwRplDfbd+FBW
         SuFs5Npgcj3ObHG6eV+C+1MeYMZjPPS1znE9cCm+7kjRErGsXNaHYNNZWljgWxVX+8hR
         Fd+IRsdrnUY/4C2omfyic5k6JFoiZcFWkDFVL2bMXged3mWCVeBX6sb83v63xYmNGbQA
         R/Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773946233; x=1774551033;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gr/9NeEAFUkbVQbfw4Mz4GNhFZSSp1BkHRJt9tIUqz4=;
        b=ZSTHOmetFTjwJf8EYL8NYD7h2O3qY2DJ9nW0TZ3AxBjDpl6eAhAYIK1deunRXlc6z3
         ukiUJXtN1n+82E+zOgIBdnyhh2yROU1j3xqzvmKxRfZvChb/zozdZ27ISqup3bN88Jz9
         2FD+5vMm4UeEpyWDfo2V+HKpvabQ5EKlWJ3qoH2v5vaPBfdr//FPwC90oMdjwz1+nePj
         m8kkwxltdaodcm50WW6BwrP0z+iPOvcJNgbK4FQC6vI+piP045/wxiGEyEmOYjeAwVzj
         pcX7vp4HfESvU9xVDMvMqoAesyWVfoXYai/iNMMlYC36muvHyXJlzqiWQq+iFyFeSdlL
         HHdA==
X-Gm-Message-State: AOJu0Yy4m/O9npdzesEScqwS4XFdH453BM0+54NX+K+27Cxk7qhQYc7d
	WjFNCoridQaJXiq3ZPc/b/KRMChF795WgT84lxVnKkvvBJkstuuwY3YpPZ3vxBRo54coaAJ1dng
	7BP+hiK6DVbyeyNFwrcacJGR7tMAERIGZJL/HmrjPHkdcyI/L5l7BVo1xkdhB/ZiXwk8iMg==
X-Gm-Gg: ATEYQzziU5O1TQwNYw9Z6SASCC+m9t0q34djnHziwng0JaC6UOUe2FK8KyF9jnFLsG/
	/u4nkcny/bEX530aRLltNXy67H0OoZxtw2+hXLMnveQAVusNpHaTNwlRz4Do7SnWj5hdsntPwGX
	GyQGqZ2nhpCALqxy+FmBw/+aBbDuLbsL5KdPYBN2EvO154KwoMDNsFNTEGmX3rkZ/gm7UXg2v/Z
	2fusfrCxT7jpBCRSQ4l8qYq2wWgkGKWTkJMxywEw/07exrEgx/0p6wiat+HkrMztprZvV/uqpHX
	fkCK9tlhfZFNlqb6Q9JHYKzT+Bp5P7ZqC6PEmg0rjn1P68HZuE703dGlL8U5br1jKoaLBeieYrU
	7qcmZRmBl0ViH0bRpUkejr1woqcD1omoSiVZd6GfgaQNr+/d+kfdjEjFc29xvLcww2FXI9cGmtp
	BmPqTewTbInWx0Fw==
X-Received: by 2002:a05:7300:fb8d:b0:2c0:ca48:3107 with SMTP id 5a478bee46e88-2c0f3eb5664mr1959237eec.15.1773946233167;
        Thu, 19 Mar 2026 11:50:33 -0700 (PDT)
X-Received: by 2002:a05:7300:fb8d:b0:2c0:ca48:3107 with SMTP id 5a478bee46e88-2c0f3eb5664mr1959219eec.15.1773946232576;
        Thu, 19 Mar 2026 11:50:32 -0700 (PDT)
Received: from [192.168.1.41] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c0e536894bsm10154217eec.5.2026.03.19.11.50.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2026 11:50:31 -0700 (PDT)
Message-ID: <17507b59-c688-4a3c-9eb5-a907e297a10a@oss.qualcomm.com>
Date: Thu, 19 Mar 2026 11:50:30 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/3] wifi: iwlwifi: pcie: migrate to modern
 pci_alloc_irq_vectors API
To: =?UTF-8?Q?Adri=C3=A1n_Garc=C3=ADa_Casado?=
 <adriangarciacasado42@gmail.com>,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
References: <20260319182925.19436-1-adriangarciacasado42@gmail.com>
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
In-Reply-To: <20260319182925.19436-1-adriangarciacasado42@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: yMX41W6TKvEB11vxRNJpq7jRicvmgJ40
X-Proofpoint-GUID: yMX41W6TKvEB11vxRNJpq7jRicvmgJ40
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDE1MSBTYWx0ZWRfX+tLmIA08vgPa
 BqDblbZMcKID6aueI2+38PMOV/R2rNiJx31a6kneqvXZ+iBA4VpP/jTiw2HSTjp/voNLDqGvHKy
 71hvS3CMr2HFZ++xVFPJkz+m8ApgOVDH9pLRiA1PMdnK+VPaMs1SXmNn/B6H1NJ5fu3P6Q5Y7iY
 M035R9mp7yWucCkKsZbOlsv2TVun0hCai5LiEXsYdAUxfgT0Zure6grc2SGQ27dduARD41qvP6d
 VbN3A79dYUx7AZaGIk6EaMotLQ2lQO8ph3Xw9S4Z1SLcWliBWnKZ4W7nYz84vvBRqHGrWs3Kq4l
 2f6FxkoCTQMnnLltXXlVgyatAZBlMKA+FvQBmq7e8R875afdfPj2R6JYACYPWe5t78TuVjFdMp2
 /9XhC1SHaf+8+G/Th92HtY2bJRHeDfQNvTV3mYqB7QKFRetahaKT5/VAr7sRXAYY1ubcKEM6rLk
 pJNYrSt1a9ajYQS8OcQ==
X-Authority-Analysis: v=2.4 cv=WO9yn3sR c=1 sm=1 tr=0 ts=69bc457a cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=jSEP3iq8ptvKKmpwVf0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_03,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 clxscore=1015 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603190151
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-33510-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FREEMAIL_TO(0.00)[gmail.com,intel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: DCA6E2D1595
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/19/2026 11:29 AM, Adrián García Casado wrote:
> Johannes Berg suggested using pci_alloc_irq_vectors() and delegating
> affinity management to the kernel. This patch replaces
> pci_enable_msix_range() with the modern API and leverages
> PCI_IRQ_AFFINITY. The manual affinity loop is removed as it's now
> redundant.

I see from the archive that you've been pointed to this link, but I'm going to
do so again...

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes

"Describe your problem. Whether your patch is a one-line bug fix or 5000 lines
of a new feature, there must be an underlying problem that motivated you to do
this work. Convince the reviewer that there is a problem worth fixing and that
it makes sense for them to read past the first paragraph."

"Describe your changes in imperative mood, e.g. “make xyzzy do frotz” instead
of “[This patch] makes xyzzy do frotz” or “[I] changed xyzzy to do frotz”, as
if you are giving orders to the codebase to change its behaviour."


