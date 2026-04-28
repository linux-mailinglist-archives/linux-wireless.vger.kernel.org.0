Return-Path: <linux-wireless+bounces-35433-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLXkMJwe8GlYOgEAu9opvQ
	(envelope-from <linux-wireless+bounces-35433-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 04:42:36 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1437447CD78
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 04:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CFBF30142AA
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 02:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68B2218ADD;
	Tue, 28 Apr 2026 02:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LbNnZihd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gyOIdf8R"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BB8175A74
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 02:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777344153; cv=none; b=TYLU+qCQZPTujS2RQ90uuzXoNx7tkD4uGY9EUt2teqYduypaWfEG19HUXb6qvU4vAOrEUNX0lqjZGtgTIKeFzJHMajygUS1+YoXaxfqE8WB4OfyROXMr0dbBAu03wB9DCqpBlg6QNr1RVADWrPsIanfyF0ujQUEwdo4D5TnXUgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777344153; c=relaxed/simple;
	bh=602ipge7Zb+y0rdLSoAx1Br9gG8guUGm5bV2SSTF2Kw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ob84YAB6UJS5VA2ci/flKNaPX//HPIUQ7Tk9o/zF9aj/mEpOYJNUa9KWMA4ID420nxtAlaQ9Vdwa5g0wv3Jv7nu3dsnf05cFYZMuSGPbbDmt3fn/Q8MVITVsybpkZVfu/cMX3ea09K9t/au9ITksY4HwD3K8Jtaib9TipWUg2tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LbNnZihd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gyOIdf8R; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63RIjvwC2006203
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 02:42:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BDvh2V5ebRZJ2XFlCMmuSuMYlpOsf9xu6saUuAb2a3w=; b=LbNnZihdOrXJJ8Ki
	viJl75+jw7bD41rpQ9B+4HkKwNClAH/5A5piefJG/TNvsIgPQmwBi4HSNVZKdAGX
	XmNJak7VgQICIF7tCtYumsSQFFvxIKQxdFfk0qxyPPp4LBjZhCbOtknCNuilhQDZ
	seUiHwA6/x7myVvQaADPPBy8a2npqfj2wyRa9MaX/vOnJThufUuXcZGTCxZrx1mt
	WwdLv0TUjYt6LO0TpmV6dRt+oYpwKvao68kOMCIOkCdB6MoGdXIkElEzLEX5VJ6w
	UKlcXQZQSHdck76UhUr9uKukx+qmE2DNKQAheXuri7Xrwj6zptWVwROXwHDsmtk4
	Ufh79Q==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt7gkjy24-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 02:42:31 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b454cac322so103507845ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 19:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777344150; x=1777948950; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BDvh2V5ebRZJ2XFlCMmuSuMYlpOsf9xu6saUuAb2a3w=;
        b=gyOIdf8RtCA1Nsz+u8YdOKJeA78ZOMhVu+VNzTWuJaKSqfSJI0eOl4hdV2FJdGMFXb
         zGr8ruoS7MGIGmne1owpMcDId/gUE41pF/86bqPZmIZqRtIhwULMEe1p4waI4X6jJfpU
         +ATFv2hBqSBOQ/hw5Dm1xphdVWW5DsouLVvQVvN8n8fTl1OS0Tt92nXsuL3UUpU0LOrl
         w6HF5b5wdrKkM3zGCGp6/cNBPqYPtYRwRw7GxyIj7ew+r5hIi49FRUIKmSsAeVq6U1hn
         wyXAMJFG6yZ3ek/Xurrdkk2qWpj2mvkaqHon9GstV4LLS5T8ls/Q5qsnRPH5G1fcjIxN
         V3RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777344150; x=1777948950;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BDvh2V5ebRZJ2XFlCMmuSuMYlpOsf9xu6saUuAb2a3w=;
        b=GpiQHcxXQeF2i8yJBGrJv+N/uoQMAkxY+unjtcMj+smOSF4lSNc2J97R/8RZ0H7qI5
         VAOJ1QcPPoZENgB+9ITmMo70FJNw2s1r+5b8csc2XCz4h+bnE8/5EQsSLHqxCm0PkP+z
         F5ObscjvsCD1nJhir8o+BOmduXYOj/Ktf6gU0D8iHyoioTLck79LyUclRqIEJLKO+1PL
         5MTIPB6piGpboIOwSutlKPY4sgd8/kbl4/L9v/yM+Z248g+4XdTWRs/cy2i2o2cRLayc
         Jh9Ck+sueTgUEn9cbtQebJ3IbJPJkLkreLtVVQQDkq/y87oH+O3JsfVRoLUl8UV68rtc
         mHog==
X-Gm-Message-State: AOJu0YxJeofJrudAj/xFlagX8ap14yADz5TXIriYGjZuA/pvhxLg0ROd
	ZaYdjoPoi/B6D5VkU014tvL5ZjYpppSaEsgaxajZUZMdPnkUwtaDoetlWF56cQGnEEmZ/6j/de6
	5tmXlm1mfTgf41jZb/AhLRA/Vs4TQwCYJRQgY8j6nk6V5ubREXdfsX434OGOWDr7C1y8iDEAdX0
	E5o48H
X-Gm-Gg: AeBDiesBlmnDdOeq4DgHIQ0BFKYqFUVx2UMxbIkI697GofxcY1yx805DPK/Wb5vm3cI
	nWp7iwi5Ln3BArUon7MgTSK3iYXcwwLR980KuUQAUMlV9OQLbrl2rFiOVDqUuzBxyT6t1rTpEyH
	gNjqfi1s/AT1/yg9KaeQ9k3CwcL/GQ6d0HL5N/2Udy0gnN3so+zCx+QhYJhSzluNmdM1SiYt0rK
	fVvItm/SCY3gYDrIAh5LUCueja6FvpVicuYnVznapbSB1AehbHuI1ia+yrTCHE9JFnQclFE4IV4
	00f4JdUl9XPqXyBt59FvyU8CLoGUMY7ATkE9XVDeHuwe4wUOLU8+sKlYuv3360NtdqUVYNQvMKt
	gyyk85rHXq+i1lN+WkiYu49wjr2JcWBqGutoVTDcpz+feNVkwYs/UmrHfCLmTGuq75vvbiy+pZp
	qlhF1dG3eXGBMUMj4agc2PevalUxc26g==
X-Received: by 2002:a17:903:1107:b0:2b2:6df1:111d with SMTP id d9443c01a7336-2b97c461dcemr10475365ad.21.1777344149799;
        Mon, 27 Apr 2026 19:42:29 -0700 (PDT)
X-Received: by 2002:a17:903:1107:b0:2b2:6df1:111d with SMTP id d9443c01a7336-2b97c461dcemr10475095ad.21.1777344149276;
        Mon, 27 Apr 2026 19:42:29 -0700 (PDT)
Received: from [10.133.33.153] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b97acad206sm8469265ad.83.2026.04.27.19.42.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 19:42:28 -0700 (PDT)
Message-ID: <7867ada0-5156-4b0b-8668-174ff0629424@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 10:42:26 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: unify error handling in some
 ath12k_wmi_xxx() functions
To: Nicolas Escande <nico.escande@gmail.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260422163208.3013496-1-nico.escande@gmail.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260422163208.3013496-1-nico.escande@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: c_3C5e6QEDjx8TiRoD97QQw57IJ2-1jR
X-Proofpoint-ORIG-GUID: c_3C5e6QEDjx8TiRoD97QQw57IJ2-1jR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDAyNCBTYWx0ZWRfX5RW2+AN1/+Ay
 EtoalpOovv32w4d5auexC3IRtSB67hyKWcZJUeFmv406FNgYcS7Hh30ESfWXlgUpGzLiPDvUBcc
 rfAjLtM9hI/cCLIO8lKVXACut/cs8Co2SN0DzuqpS771FaPo2j+i2jR9cJs9h/+kE4n7Isr7G/m
 Fq/y8mJ4lq9VQTo2WNdcwFX9mEhv1BGJRSSMECss/N3VS/+U282j2tZ1kiT0UTmktQS89+QYJVx
 tCqYsW1eIPBsDNatCbPgVi9M4HlpBgkjThMBsQHp+Uc+2yqcmubmF15pxEuZq1BpCWFE8VGIBYm
 sPIl+hDWPemCme67Hc9S1irU2D61qE+ZSZyVsJT0vgkK7iXxwE3zZwSqat3IW3qQwFwRZtCRreB
 eKJRzX9QN/gyulrWpgLPXuYwo5/YYE5f9zGnCJyPmUhOilJGX2Gn9r39JFvAJwa6ld4jVvUEmLm
 jS8dyDQTKjjIIwbGufg==
X-Authority-Analysis: v=2.4 cv=bJsm5v+Z c=1 sm=1 tr=0 ts=69f01e97 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=KE8VTcUQ_TpmJMKzUYYA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 suspectscore=0 malwarescore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280024
X-Rspamd-Queue-Id: 1437447CD78
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35433-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.infradead.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]



On 4/23/2026 12:32 AM, Nicolas Escande wrote:
> This is purely cosmetic changes that simplifies & standardizes error
> handling for functions that ends with a ath12k_wmi_cmd_send() followed
> by trivial error handling. Saves a few lines of code too.
> 
> Compile tested only.
> 
> Signed-off-by: Nicolas Escande <nico.escande@gmail.com>

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


