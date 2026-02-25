Return-Path: <linux-wireless+bounces-32180-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDVuJwYrn2kkZQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32180-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Feb 2026 18:01:58 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E1F19B220
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Feb 2026 18:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6F260300A24F
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Feb 2026 17:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B982222A9;
	Wed, 25 Feb 2026 17:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YOBpKJUs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Umtw0HZI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141363BFE22
	for <linux-wireless@vger.kernel.org>; Wed, 25 Feb 2026 17:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772038902; cv=none; b=CMNt/eRjwICUo4+vd+2mpIqIcrbuWE89laY5PBW1aM/gHkHerj1WFXsos70ESR/BNVC21qZv3sxNLhIrUNTIHoxW6lOM4EMUL5sWW2+VhhdGRsgM3m1PNi0JKXXkTxbLVpaw79PK4rW2xIFDlS1J9KF61gGgRqATeraVBtqt+RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772038902; c=relaxed/simple;
	bh=JeQfolJASgAqOgFUPxF+1nMdIMUCUXASOtm2UrQHgEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gkh+EMFxlHPqMFLaCcZuoJkaX3jkv5qdM0DVaKPzIXoVVEDihd7cxJ0AxeIc4q5yv537BMHs6ysodKfw7HA3C7EtRgVaMfQOcamPyjjAMqAq3/OjykkH30nao2JNneg3DzYTToZxSWfONpO6c7dga77vL+YGjVaDsm71jKT/KSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YOBpKJUs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Umtw0HZI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61P9SsnM2127719
	for <linux-wireless@vger.kernel.org>; Wed, 25 Feb 2026 17:01:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QZTkBXKmJdrutsXYLhcPuot9yfewPJZ4rwWBczMZYPk=; b=YOBpKJUsWqllm0XU
	gfWjNVOfKyTCzY8TGIHsYdypuv1EFYJzhiFk8ukOCo4eLo1KkLPaT/a5ohPV1Jvi
	F0GlJa1OfcsgFIsj29SaDE822AdC2+6xfbjRHaVqs8j3xcAJ1vgzxRjtEfzi8wbS
	d6tW+1LewKnaFx/QWWmIYXN30hMsfQcuic8NwhI2C5QdDz99UshTm6R1FPRXkhr5
	6C3nG0yXChXn6W40wDnNfPbTHd5iVr4PeSpPdS/baH6O8aji/GSNgaTK+QgtUqy3
	HlTePwyhHqjcZlf5gwXjBDVtx36LrkpJetSw+qHuCzDe3W314aJAyUnvn2rBMQLI
	F7G6zw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4chexemab2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 25 Feb 2026 17:01:39 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35449510446so6861731a91.0
        for <linux-wireless@vger.kernel.org>; Wed, 25 Feb 2026 09:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772038899; x=1772643699; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QZTkBXKmJdrutsXYLhcPuot9yfewPJZ4rwWBczMZYPk=;
        b=Umtw0HZIH5WzWrow0OyL+xjYoVW6SJIyYcyWko50QirOxa9IGb0MYCbkyAphLqnDx7
         s4MDZHpk3PYyx+dqLGBR34jMjtSf3hDVJl9xyK+gEG9vbB3gJyfdO7vogEDaS6Lo8vJI
         9+ATy95YXlm0nOLwAxTkZW/Jz8QB54ODTyQQY679Q45z4VxZ7K29/Tj+EIOG8ZqUyyI1
         6O9RhuhG2SlMxNgR8K/CUvhBBhO75jXC1ymuMOS7IC8y41NivS+02QAZ8nOJ04BDIAnP
         ByjyRPLEh5FoxJ7PvfttFE9pOWMFzV2fH9N50yhuEUXI/MKTnbbEz0h9gPDjkzdWupLY
         JiCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772038899; x=1772643699;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QZTkBXKmJdrutsXYLhcPuot9yfewPJZ4rwWBczMZYPk=;
        b=ax83GIaXBRu/5RPNTQ32JhQX+j5/j1QOSDphqhdfE8H5S6kHSeIOKZL9m8rNZrq1o4
         22HNrQD4BQ1m36yc5t+/OhDnSgL9D1jqBNZwGeTLZJz50nTl+GSRO3sTFSXPvzw3M9WL
         tPWu4eu0HjgBR7XkZjmNyLEx8dGIFecP6gJV1QuvxIMqzpjTNPtoDYTJ+v9NkijKc1C1
         7BcNhpvIXRnDeaCd+uc1RjzBO6eJbsA8vQK36EqI5fFhyln+4k1FCLdwbok5GV97e81e
         crtqaS+wUUKs/ntoa/adBnjhj5iYAXUdcJXYSbzi9XJMJoC5QmHft9sy3sFA3RbwF7yk
         SIgw==
X-Gm-Message-State: AOJu0YzBdx+03To0AEfv5v48/JMR/N7SGYHCpb2b84t1BsrDlfRqeDS2
	F+kZp8siBhDI6a9aiOGinNagCXOITMh7GTbe1BhoANw04U+ZXiGrbxpY3yIRdNYxwwlUKlaAPGl
	b9AgEjq/lZMH68Rpp7e8051FdCLa98L35aRgE1dF14UGBvwLV1I28i59RQ4V+aA2adDCLZg==
X-Gm-Gg: ATEYQzzF9fE8fTkj/Vq50ZFWWsiKdyAF8nmlsE9R5gKYisl6jAN+HnVPawdQZFgE+8F
	9Tmn/twLBPEYoqVPMmqsfAHhPGeb64sQiHDttdLawkVSx7CrBds4slgxafxXaMgwIitlQgJsylY
	msD96pVWbeh7IQ62ugiIHWlNSYXDZrIHmfelsUJNbfFmIY50q9r9G4vsxmMQP63/yhZkXAzv2Fq
	3yFYQBD6EXcDsBcc5HMtfbjZtJpJFywPtUUEOjwOJ8Yu/XpC26MgG6JmJ0dQDxW4ZBwIbdiO0MV
	zCaHEaWpXcLOqirwPkRhN3zgkEOUsjA/CKA4rDopLu1ejwIK5ztfi8k8a3SEuXQJu4tfsZaH0Up
	+zuwAGxYHKoxVBmDdMnd7VMuMM2gk/BpMdQ3ZmsOTkf1MHREwFPJb6h8oQVUCtlo6kzCHRGtzGg
	==
X-Received: by 2002:a17:90b:4d10:b0:356:2fc5:30e4 with SMTP id 98e67ed59e1d1-358ae7c6cc3mr14333961a91.2.1772038898589;
        Wed, 25 Feb 2026 09:01:38 -0800 (PST)
X-Received: by 2002:a17:90b:4d10:b0:356:2fc5:30e4 with SMTP id 98e67ed59e1d1-358ae7c6cc3mr14333936a91.2.1772038897956;
        Wed, 25 Feb 2026 09:01:37 -0800 (PST)
Received: from [192.168.225.142] ([157.49.193.171])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3590158f6e0sm4426973a91.1.2026.02.25.09.01.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Feb 2026 09:01:37 -0800 (PST)
Message-ID: <5a9d3966-26ff-4d15-96a5-189618407742@oss.qualcomm.com>
Date: Wed, 25 Feb 2026 22:31:33 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 0/2] wifi: ath12k: fixes to station statistics
 request
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org
References: <20260129-ath12k-fw-stats-fixes-v1-0-55d66064f4d5@oss.qualcomm.com>
Content-Language: en-US
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20260129-ath12k-fw-stats-fixes-v1-0-55d66064f4d5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDE2MyBTYWx0ZWRfXy14p92Vkqe8C
 nmm7NfxPsDPbMvkBKQCMXZkreqf4BNWV098wc/b7U1+cVRV0730Vi9hdyZesLHeCB4wovaDxjbU
 7GPQyYF3DjWwlrrDIwo0Fvbtu1r/96P5nXxi7U8FfszSbN9EC41Qcnf6jTUUK5ZAKLITQUGopr7
 S5wyIsvmgPk9LabgoqVfVVtaKxmkylIVx8v19ftYD0whp5dQk7NxJhCXbGKEEbyRev8Jr771Mnj
 P+kKIipf9A5bh1zfztOwsNIRSBt85c73QxTNB2qGM6djfUdr4T1Tz+vpXzahiFJ80RJy/2AFBbs
 mRlKcFcZN+2bM9ScWPo6Wt3Q38kHiZ4m3ZSXx3ud0yL9hORpyXp+ZsMcqd4GuyCuKfVrLTVrZyN
 aNivROiXj0wSRsKPJ8sgfKX/dBk6dBIEYDQ64ZCkwM56Jc574RFEbj6RgggwbuRFhkaenJJMLCZ
 Dtqlp9iHBlaDXueV7UQ==
X-Authority-Analysis: v=2.4 cv=V85wEOni c=1 sm=1 tr=0 ts=699f2af3 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=hSb1S3R1191yeZY/11SCyA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=6wuBYe4-bsxGNRZuf9QA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: FpLECT8UW6y-iD1MfRmDJ00IG7bZraYa
X-Proofpoint-ORIG-GUID: FpLECT8UW6y-iD1MfRmDJ00IG7bZraYa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_02,2026-02-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602250163
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.5.7.0.0.1.0.0.e.5.1.c.3.0.0.6.2.asn6.rspamd.com:query timed out];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32180-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vasanthakumar.thiagarajan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[vasanthakumar.thiagarajan.oss.qualcomm.com:query timed out];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim]
X-Rspamd-Queue-Id: 77E1F19B220
X-Rspamd-Action: no action



On 1/29/2026 7:54 AM, Baochen Qiang wrote:
> ath12k hits timeout and memory leak when requesting firmware statistics,
> fix them.
> 
> Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
> ---
> Baochen Qiang (2):
>        wifi: ath12k: use correct pdev id when requesting firmware stats
>        wifi: ath12k: fix station lookup failure when disconnecting from AP
> 
>   drivers/net/wireless/ath/ath12k/mac.c |  6 +++---
>   drivers/net/wireless/ath/ath12k/wmi.c | 36 +++++++++++++----------------------
>   2 files changed, 16 insertions(+), 26 deletions(-)

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

