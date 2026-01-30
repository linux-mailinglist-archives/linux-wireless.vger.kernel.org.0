Return-Path: <linux-wireless+bounces-31401-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEPpMszwfGndPQIAu9opvQ
	(envelope-from <linux-wireless+bounces-31401-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 18:56:28 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C136BD87E
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 18:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8F5030053DD
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 17:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAF4344056;
	Fri, 30 Jan 2026 17:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dMfuUBz+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g9oq+hif"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35EF335090
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 17:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769795785; cv=none; b=dEstBsIYuvYOPskeSbohU59iMffVBql1+Kon6AmeW8leAp3gPrh8yacQYBo6PLUNYztRFjS08/sZiViyFDcz/x95ft/lPjrzhZRUROMqC71EtbSPTIdoV+yR9Yiq9L8K+G+J4JJDvmNkGIpoL5r2KuVADEaW3XGpRgrETxxH10I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769795785; c=relaxed/simple;
	bh=BXrMmhislSQtuiZImoMTpMd776ycchvH9IY6W5ldcy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ITWWo3jqcxmcxmjtLsYjBlepkJS1AMKLPib5pCHat+EsgigKw4bDpU5BJWs6utTjbJNUuZvVpGjHavb1FS4X6M/4TKH6bALRz+Rrpds6Ga3Uw+/fCAeuJycMM3X/4JBUIkW8e7gsw/KMjgJTJiDJTb0A705hvvPSypb+QR1LEQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dMfuUBz+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=g9oq+hif; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60UB0jUD891901
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 17:56:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BzuLzdW32575u3ngxywQ+2PkcHLv9quudlxmBtCY18Q=; b=dMfuUBz+F+eWPmnI
	mtm11l4AOO/W9uHvoic1dwYg5og8/PGVCc1NIAqQBMdLm8BuKh2HdD6CUGlCLi2b
	6m5C6S3PPWeCsvXarD0mTRBqO9MuVqLaNIeAcnT8mVg/vZzRDLFUyzt9/PjBPns3
	jmMIvBHM/6Jc1ifUbqckSObw91QMKmrrB1NgqijVZ2fTHLG2UJpmJrRy/O8VuGxz
	P6bb38vOiAPNEfmlrRkLx36MR6SPC7ZlvA/mypVjuSYlD5cWclXSWZ4fZhM8Q8H1
	av+pAM+h1/z9lFIfjZPwFN2jyCBGnAjG7ZLy2AWCNC4pK/rzcDkEYSvUHsFcgJ78
	EVkSfg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c0gs7u5uh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 17:56:23 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2b708fa4093so13394014eec.0
        for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 09:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769795783; x=1770400583; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BzuLzdW32575u3ngxywQ+2PkcHLv9quudlxmBtCY18Q=;
        b=g9oq+hifWnW9ttu1068cCAhf2IAgMUqWPPVh0QWWQKcrHaZEYmuloW7JOiZ3C13tka
         7xatFtEgZUmlbbNfv+Zxuth/iVG2KRzFFC+kXQZ/6YXkGotOTs3RPVM2owzLP+PiFpif
         5vCjCNuG34UYbPIB2XoDw6WvroSUNAk28GvrYaVF6LHOmA/uO/XIROqpcunQ0DNLCw8q
         Np7uG9jDDM4KaRKHP16IYNAYT+SpUF5D20RLs956UR/z6z9dJcsnE330/uOmwLUvBc9T
         ZYcKulxyGgwgfcGo7b6uLfvkw/N0e0WDWmRuYJDRsaPeLCVCYPAMghXP/0VQmmqbjnK9
         GZIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769795783; x=1770400583;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BzuLzdW32575u3ngxywQ+2PkcHLv9quudlxmBtCY18Q=;
        b=R4vg1pmqQip2mEJWPKg6SREYFvywy7ofT/XqRZgiTjK6532jAUumEyYfKX0x6wQm6N
         M4ruqHY/LDdx+fsfxMcxAczvS7xarqgsrWHgkoao5ZsbkkhjtAkbWqxURN+Zc27ZVOxb
         zMDOhiYpgx4ftOTtzc1lkLRNnA0WHA8763SvbbU0FMJAmP39NiFcs/6HqNgzy9mccdKu
         PQvZ9zHnY0tF0jqSyGb7aieOgyODHx5vhEnCjM/QOfEskhRhh58rrJ4QAtOxJMTqNaxP
         Bdc9uOWLMbA1zrv/iuXpqfqnjKVJRHmPaQhqG3A5rIgNEp7WYIY12pR4exMbgBg5XOIe
         LF+g==
X-Gm-Message-State: AOJu0Yz1wcMSDjZXbp1NjJFtC60Nnz9VxPGsEoBwQpOLdGiUKRB9AnK6
	U+7W2fAjHzMXBd9t3ZCJkluGHhhRFxfpQDe0U3+h2TOJkFRwyRvoeKCIRfXkkg9xRFmQr/RbiEd
	/vsfyjXoZeOqxZYzE2/+17qd9+nvqxjAjEJlMPJ0Mr9j9a4XyM20ILv0aHTWWgbg6bT3QSQ==
X-Gm-Gg: AZuq6aK6R4AObztoPijA/cHyICvf86+LTiCeF83CUfufChO0vMwGdrohFI21c5z0rXe
	C7jLjbd4BvKsAwErZrcRn9xqKJ1QHRk4QHKCu9Xn9t0Eu4tr5L2O5MqqE0fhNHbP+WD742n6Yqd
	AiHxSqAR7DPriK2BuiDwaytkG3TOsp7bc+qY7uXM1ooObntyFHsW+4PWDbIYWB3mlYqcHFDkF13
	rinQCTHxNpgnqCbO4FAnAAi0nIug6Sh9ECZcbCAJ4Scv3mEPWirqdCa3uqCGk0e2cqtYoSkvtLk
	fREibVNybwlm8NY06yqy83bN9iMcfxmIaAFRDi1hjGpaHVEwGlyp/IotcX/KYRjCOxBMJSi7NBJ
	iKwQ4QuctvKBm4jdHqQMw0fZzKw90sGDbGeliH3YXMvR4tR6oSEeqxz5YHFBCL6u+nwXo0gICfJ
	s3
X-Received: by 2002:a05:7301:9bc2:b0:2b7:2e9a:3193 with SMTP id 5a478bee46e88-2b7c863c399mr1961063eec.3.1769795783144;
        Fri, 30 Jan 2026 09:56:23 -0800 (PST)
X-Received: by 2002:a05:7301:9bc2:b0:2b7:2e9a:3193 with SMTP id 5a478bee46e88-2b7c863c399mr1961040eec.3.1769795782651;
        Fri, 30 Jan 2026 09:56:22 -0800 (PST)
Received: from [192.168.1.3] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a16ee7d3sm11887156eec.11.2026.01.30.09.56.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jan 2026 09:56:22 -0800 (PST)
Message-ID: <8bb02c38-7476-43bf-b0e6-d8e29b0c777a@oss.qualcomm.com>
Date: Fri, 30 Jan 2026 09:56:21 -0800
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
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Saikiran B <bjsaikiran@gmail.com>
References: <20260129-ath12k-fw-stats-fixes-v1-0-55d66064f4d5@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260129-ath12k-fw-stats-fixes-v1-0-55d66064f4d5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDE0NyBTYWx0ZWRfX/E0xyo8OpVvb
 D0Yakqv5R6atjdpYskDiNcGwhbXpvPcsAGgNRwgeEHvvh+P666IlUKpqciWkfjQiorqFFnL+MDc
 GZFxwH8uh4lrvMkMYqojyBHmL2Oa5EedYAg+ZESqOcicE5tHmP0h910uBiIXpdpUH5eiS4IPqjR
 jkw2wDTWS7dyhMXtyyi/p6U1sTNIufh973JtvLNMB/xSZvsrawvF2ATz8RzN1NPaoBjkGyVaoMh
 u9JOpywKmYgC/XPpxjVUVYsXlpL3FzU3523U3HaH5YMb8GZA3L3bl7rcaHweX2hoarXDO1XlkC2
 L3QRU7NOuT3ZkDq7IyHcEG1I9X3m/ijs9oH4LqLRbhudHfeeDHer/goTw5uVbqEwirkLI9g4hJU
 JtQ3Et4cOhlwisNueQ+r6EcicAvf6zXo5gQ7SdRw3skBRNrXsiLZVxIozplv81q//UUWPYH9bT2
 XYk93LcXBXvUatfEuBQ==
X-Proofpoint-ORIG-GUID: DYZQ8SUWJTDC5Z5ygQX0x7c8tXgx33Ta
X-Proofpoint-GUID: DYZQ8SUWJTDC5Z5ygQX0x7c8tXgx33Ta
X-Authority-Analysis: v=2.4 cv=UPLQ3Sfy c=1 sm=1 tr=0 ts=697cf0c7 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bC-a23v3AAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=6wuBYe4-bsxGNRZuf9QA:9 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_02,2026-01-30_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 spamscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601300147
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-31401-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2C136BD87E
X-Rspamd-Action: no action

On 1/28/2026 6:24 PM, Baochen Qiang wrote:
> ath12k hits timeout and memory leak when requesting firmware statistics,
> fix them.
> 
> Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
> ---
> Baochen Qiang (2):
>       wifi: ath12k: use correct pdev id when requesting firmware stats
>       wifi: ath12k: fix station lookup failure when disconnecting from AP
> 
>  drivers/net/wireless/ath/ath12k/mac.c |  6 +++---
>  drivers/net/wireless/ath/ath12k/wmi.c | 36 +++++++++++++----------------------
>  2 files changed, 16 insertions(+), 26 deletions(-)
> ---
> base-commit: 8c6bd5e9db28152563c984d8c48322610cac8609
> change-id: 20251121-ath12k-fw-stats-fixes-6e008a4054fd
> 
> Best regards,

As confirmed in https://msgid.link/CAAFDt1vck6=sp4N+yEi6J8WwOmW-ZLfHaFXOaB+R9tMGophMDQ@mail.gmail.com

Tested-by: Saikiran B <bjsaikiran@gmail.com>

