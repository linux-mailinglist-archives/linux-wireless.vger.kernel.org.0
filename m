Return-Path: <linux-wireless+bounces-24573-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A122AEA5F7
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 20:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 164881772F1
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 18:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CD32EF2B6;
	Thu, 26 Jun 2025 18:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X3Tes+CG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37A92EF2B9
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 18:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750964326; cv=none; b=hndu2Xk+d76hKgVabgztIzdWErxK76NqN9mYVT0k2asMNs5ss30hEXvoVLSWVzhRwovrfcq2FRbVznfmEqyO7LXAuqyPwvJ73ZVWMCJHNE+3TcRkiRhN53XF0Pw36XCsyBvY5VOoxDqjNDxfXEKuWF8GTW6tvLSdox3PQ3L3p9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750964326; c=relaxed/simple;
	bh=Qn28XiW1EPCU1dbzp4mTt8PDhQm6ZCjgoHuSPUpglKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nxKVfYaPGv8y4D1/faCtyTsqk3E6BCnCV8jpjsdeQaU5A/QnZyCQvB1NH+XBaNMAml/WRwHRxUDEsA9I/8ve4zjMrCvqlh1fHczw91+ZITrXut7WAs8Ei6sDhlEiaGojEz8hh1/212vA/rrqhbEQRqxgxYPGVhz5rRaUUQeDOxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X3Tes+CG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55QA0bjX021561
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 18:58:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7hJht9qqs/t1dfOac3Sy9XDpNOgvAdeh4EY5QG98y/A=; b=X3Tes+CGqQWmFtT7
	5hOdCxboUR1VeVdtBX6kSb8slndGCh0idFv6jn2ebzaJUziNHR+WnqaK2zc82Z+A
	s+Kb66StomnwVZ8sJIQ+J32mNAVdzprQ/fXZaMB6Tsq4Vr9M3t6SHKg4n+KOc0CS
	dtVyqrCV3l1HIsL8kxleI/blIoENoJP81DR9jBzJ5qHlghvHmrLiqGPEuVrL99Cq
	zXkKqs4/q5/pWPpP74xhMncwb0QSjtt28eFRHFFo0x8i5uhOkSO4/2PqaN74zM67
	ysZQdoQEIIi0kqNoy7mLAC+s8fF93H1y48Ixq9Qojgbzksju7ah2WVZbFBNtb49/
	tX0J6w==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47fdfx2p4p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 18:58:43 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-748764d84feso2132153b3a.2
        for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 11:58:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750964322; x=1751569122;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7hJht9qqs/t1dfOac3Sy9XDpNOgvAdeh4EY5QG98y/A=;
        b=lfMaMWfjGQkSHh4GtV4HFRtLJONOxzjlwDpWZ391lnWleYS8fPZPfP8Yzzf2epeNk9
         jEF1yu8M2fuZ2chZnIyHtqkf7dqjAUb7q0myMxp8eJjiSdI46WiQrs85MUOYwb6iS+Pj
         MTEjZ0JeEaOUKsSgIiYlPz2AB5TH3XPrmgf2Pc03w4wjqovaWXLA2UsqPqO/0x+N09Cs
         ss38cle+k7svnk7klAuVn5ba6VKDOfcoa8eIYDwSq4TkQbBXVNuILhz1ueiqpQFCich5
         liUiynSHtSRye4kPf1Jl2p+hA16nuwMeCFOOCHjIZOD2YlwEA/cEONYqiBp2GTS3YHTX
         waEg==
X-Gm-Message-State: AOJu0YzUu2l/nIVK1AxBcFHp0xMVzTmUn/Bj0Y6+AcR+x6ozpvvSF/fz
	tODCfY8O3glR/9mNbLwrthDFGt8BOCjktYo22vat5lPhpPfTZQ/xkqXgEVfY9aWhVUQLUk++ols
	qTMzQdrhWwNKEOnmSHuZ3pWb3CfwhkxOesUIGubRmKz6ggcITZWYfEqulpUC1+rXbYiW9Hg==
X-Gm-Gg: ASbGnctazyXerqwafZU+X+NXeBCrBc4H1wTCCsdnp8T4watj/c5D2zf5voiz5I6wFwR
	frvwe1JYvJ7YnTLO9hYcp0IR8AAHH+SWAdROPrOqRqFlGUwUJ18DSI2ZdLkzPsrgBvzj7GUud23
	mq2A7oNUO7OsydmbWgANcJpmPV2fjUdBbGZhF0IUlU0f3BDK/4apKQ7S0+FGt+UKFP1OQIfrtDc
	7tI2zy2W7dIIXf9A7KMhAIxpAMeTj84I7V0nu/fm+nMDdsI8UGug4qh8MlV8cGg2Zw/UZiREsOY
	bFMHlPKlh26Z3jorZsuLUzfmdEs/UHct7cDZGbneGV4w/wG6E1b/FsMJYPnVixBzFNm7nWMbr/0
	Shr3L0nOCfWpVRfU=
X-Received: by 2002:a05:6a00:1953:b0:74a:d1ac:dd48 with SMTP id d2e1a72fcca58-74af6f80730mr387234b3a.23.1750964322446;
        Thu, 26 Jun 2025 11:58:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpWGVmELkxpW1iTyTYKIQf1aGEee7mw03kIFkPSPspVzPwV+zLb41R8LUxKIjLtkEmuP+a/w==
X-Received: by 2002:a05:6a00:1953:b0:74a:d1ac:dd48 with SMTP id d2e1a72fcca58-74af6f80730mr387212b3a.23.1750964322049;
        Thu, 26 Jun 2025 11:58:42 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af5574604sm359024b3a.86.2025.06.26.11.58.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 11:58:41 -0700 (PDT)
Message-ID: <a8d8b59e-70b1-48e1-8c63-b641a8c9ca86@oss.qualcomm.com>
Date: Thu, 26 Jun 2025 11:58:40 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 2/2] wifi: ath12k: Add support to RTT stats
To: Roopni Devanathan <quic_rdevanat@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Maharaja Kennadyrajan <quic_mkenna@quicinc.com>
References: <20250617051136.264193-1-quic_rdevanat@quicinc.com>
 <20250617051136.264193-3-quic_rdevanat@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250617051136.264193-3-quic_rdevanat@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ycn6Ra5Oa0IayMYQCgOmgxce7uriAH5D
X-Proofpoint-ORIG-GUID: ycn6Ra5Oa0IayMYQCgOmgxce7uriAH5D
X-Authority-Analysis: v=2.4 cv=MtZS63ae c=1 sm=1 tr=0 ts=685d9863 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EHGo9OVjQ_Ov5pHEzq0A:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDE2MSBTYWx0ZWRfX9HybTwtJp8tk
 qGLqJO86K81I250cHqiG9bqWCTq/CvcFg95maH6uciBZuEzw7p7euSv3A/GA53vK9Vy4GYDCOap
 Dc0rOSa8sa3RKXdNk3VzqmMtMEP0fwbmC2+ajvLgGVT8l3ij6AduUTCMEM0m4w8dEkztUMRHJg5
 hZ6b8+TIq1nvJWx7hc9mlo+HtRks5ZCiiDMYbSDsAsRCfTnh34ApW611fXssViM1jnql1xqbwOu
 WnmzXQKpvSyMoWEznGfXGtj3c2v8MeIsrxbLgIc03bNhZs5CSfx7h2Vlp8zmETCSSCGabLcz3u7
 FUQjnQz/8a9SapbJ1cWjzpAD9P+BLfSUvR5eIeMUaRrG8Kx9e33nH6ufR98gFehkbYolffpZ+rA
 MmtiJ11qIdpW9x7a1has+gAgAJacYoVn6mBpnKCaweK35iuaBaeJqt0WC6Pt/vmqOne9EbG6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_06,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0 phishscore=0
 mlxlogscore=788 spamscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 mlxscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506260161

On 6/16/2025 10:11 PM, Roopni Devanathan wrote:
...
> +enum ath12k_htt_stats_txsend_ftype_t {

I'm going to drop the trailing _t since that is normally used to designate a
typedef

> +	ATH12K_HTT_FTYPE_TF_POLL,
> +	ATH12K_HTT_FTYPE_TF_SOUND,
> +	ATH12K_HTT_FTYPE_TBR_NDPA,
> +	ATH12K_HTT_FTYPE_TBR_NDP,
> +	ATH12K_HTT_FTYPE_TBR_LMR,
> +	ATH12K_HTT_FTYPE_TF_RPRT,
> +	ATH12K_HTT_FTYPE_MAX
> +};


