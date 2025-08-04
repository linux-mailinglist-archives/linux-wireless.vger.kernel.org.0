Return-Path: <linux-wireless+bounces-26123-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03886B1A2F5
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Aug 2025 15:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B16ED3A336B
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Aug 2025 13:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6148242D6C;
	Mon,  4 Aug 2025 13:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dSBcPGe3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31C525EFB6
	for <linux-wireless@vger.kernel.org>; Mon,  4 Aug 2025 13:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754313265; cv=none; b=HxfecM598goIpolmHrUi2oQpyplCF9fdCAh3AbUrVuKyfDT15u8ktnj4pH8cqYk6hIy8rHHTlbNKWf705mnfbRMiDXwe6JHbtISM+ajkGbj597aHBTta2qLiurlj+aHaxfgyOxmtd3b5Iga8ZcMXFJVlqnzp6q2Jx7nqp/NcSHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754313265; c=relaxed/simple;
	bh=nitCmAavgS3eup+SMOcSyyiqncdlMa5i+nammlA7TIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dM2D9SLDxhyKwPgeDmi4O92KYAZoyGwP93hzqzW4s4zd0coctacQQiiyMnpTE4bizrgIyQVTpEaT292ufmbWYYIYUNjjkTKeRhzgY7VDKjXicvZw6sotJ/PiCICVavdYKMwxUHwsHHZekoaXX8zrzC8EtWaxIhXv0e27wtSgKDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dSBcPGe3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 574CRh8k009970
	for <linux-wireless@vger.kernel.org>; Mon, 4 Aug 2025 13:14:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iuqkYJEHU46HSu5bF/1m8NgiJsyaKNVDD5t0GtyZPKU=; b=dSBcPGe34hwe5cmj
	mNB3LlId72lzaYJtZSgzsodfASxhHgARWwRu90eZ1psCB2Cxis7dqc4ti5c19Bwh
	fS5Ol7nj6L/cPPs+hAdS0M3wuTukXxrxLvwdKWUhaKLuSfgzj/9XQ0ZXkaQ7CE+y
	TxJAZGADC6zvrzGWl+9zyEvsArtjZgCVl9c1z7tUMCfR/KC4VbZaNny4SVONspCj
	GO3WIoaOu0tLyRvMmtdxBoK0Fl1HxZkP8D7KTxc3htCsBBT2kevwoVjKQswWu9pO
	2Xjn7p/TxO3v+qi6ZnXmUO8ed/yL0nckSKO0rKjMumMPR60y7lltL86OcGSro+2d
	1BbibA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48avvu847p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 04 Aug 2025 13:14:22 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e7f74bb018so16632585a.0
        for <linux-wireless@vger.kernel.org>; Mon, 04 Aug 2025 06:14:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754313262; x=1754918062;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iuqkYJEHU46HSu5bF/1m8NgiJsyaKNVDD5t0GtyZPKU=;
        b=ohP58NkwJeU6Vff6nd6Ra1ix7Jk4ocCCPV5Cj53Sy0Cmp+devLo7mVN6NuQKPQfYuv
         fewBQ0qxnPaUhIfW/8Y9UEm8X4R8CL3FU9jH35hfc7fO5HuChFnqhxRHsw2uvOTQPnry
         fgfLH03NzQrTPfmWUNtCyCRJrx0yd203GFyaKkLo+xRloGkg7jGBe7Q6+UXNbEO+88xt
         WNcTbBB5Owc5yaRe253rYbgWCXqkDGqryRDC5+g2/6umxamebUbjKtv6KPJU4s4GO+7U
         gzrsZKLJ+5341WWQ33jr6Oxg/ArcTgs7cWeRkr28tK/FBxcNIFWrrdQeXukeieY+gMHr
         aRUw==
X-Forwarded-Encrypted: i=1; AJvYcCXBZx2Hnbv7PbUEcGvILtHj+2fdBmd3/efXegBm8FNsxXz3Lk9dB0Y7EPJ6S6EIctZGeEODUa6U5KwHmzxqPA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0Eq3DWI+GKC9dg30Q/fxgjLadqmHGIFlLy6pO94aiq8tRrHV1
	fU3xSNJM965uPpd4dUfXUOX8hmcilGw1ozMtGn4h0CGS0wTrBhpZeBMxfm5ohE2nmLNvQB5aej7
	j7XvWrmsRpmGWEMW7zHGhfIs2gbHVo5v6uAlOcp5B7tOJx71gSxb/umHweTbIjkKIL+vK0A==
X-Gm-Gg: ASbGnctMPi1BODmLuQVzcNkJuQAwAlHw/tT39KKSLYjy14UUzCzwQNgpXiPpcvyyOQa
	eytd89V7B2qgeST2rvi6QkYZeDFg6j1ySzL2oMVa44hxX4Y4mqFModd/hmmvR5Hh67tjX/nHoTm
	FvIFIVP8ZcF536T2PaHEEoGAKbzjP76vYMMZAMT0hIS++NcXDDNM0nD9aJay7U9J5ZDjj3FLHhX
	S1FsDcX48S7zeFbYDXpt9oT6Stem1W/vUetyG8e5KNysQi9ePdPthU0jW/RZcdl1PCrZWt/b31U
	ehu1aAJkwlZqhgFql8IzmejwV72yiD7bSo+KkbgNqAU0kxReb6eIQqIFFH3puZdmYjsG0YeXyFA
	zoXqpf0K50lyih5HhLQ==
X-Received: by 2002:a05:620a:40c6:b0:7e8:5bb:b393 with SMTP id af79cd13be357-7e805bbb656mr127004285a.4.1754313261972;
        Mon, 04 Aug 2025 06:14:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQKfXoAA4iQAVx7vrakGz5rhAfhLmMpyLiivrawj8ql8YqoebUHyRY/Z++bxkV80jn4cAicg==
X-Received: by 2002:a05:620a:40c6:b0:7e8:5bb:b393 with SMTP id af79cd13be357-7e805bbb656mr127000885a.4.1754313261562;
        Mon, 04 Aug 2025 06:14:21 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8feaf2fsm6810919a12.38.2025.08.04.06.14.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 06:14:21 -0700 (PDT)
Message-ID: <dd278225-6680-4dc2-a0d4-e110fb2cfc20@oss.qualcomm.com>
Date: Mon, 4 Aug 2025 15:14:18 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] soc: qcom: mdt_loader: Remove unused parameter
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
References: <20250804-mdtloader-changes-v1-0-5e74629a2241@oss.qualcomm.com>
 <20250804-mdtloader-changes-v1-1-5e74629a2241@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250804-mdtloader-changes-v1-1-5e74629a2241@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA3MiBTYWx0ZWRfX/s/+RODkchjW
 ocCo2GiAQYUM0tpdTKiTtcQBw9R+lNmnV6gZ9fEE+SrTjvv7A+R+7cynuLgVg8v6cHbKPhisuUQ
 Zfv8UnZ+wTkt15PCGI8JjoEA2Jmt5YDvs6IBHWbtwA3e7/7OQY6YFYVDt3wcXbWSwkc+i8LOwp3
 nzzKz8JDIclsTNgz1n8zqEewsA7elDSCZyzekA7V+om1cXCeLJK/Y/EDrrjhf6bDs8s2Imn5Wsy
 MNDvn/wNV7uGulHp9+EulCWUbS/wNckulH8n851eQSJkM9lfQ2yWQPLApmPmboCxeZqt7yg5pm5
 uMrCRu9d71NX4HTdQMDbK116kqSIsZkeoDXD4OXWuhQ6jPMDag3n9DOb5gM7uSuYLh5u0EfgXJA
 i5euuLw4VxwW6VxYt90Yy+TDORiXfUUWq6t9vQj2SpkkeYAc/tMzMolAIVZ8zs5MkWY1DerW
X-Proofpoint-GUID: 2-bPDuQXO-945BX76u2bRdDvJo5RGmMC
X-Authority-Analysis: v=2.4 cv=OYKYDgTY c=1 sm=1 tr=0 ts=6890b22e cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=wXYMRSRB5Pq2Cuyld4wA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: 2-bPDuQXO-945BX76u2bRdDvJo5RGmMC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_05,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=923 malwarescore=0 adultscore=0 suspectscore=0
 clxscore=1015 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508040072

On 8/4/25 2:41 PM, Mukesh Ojha wrote:
> commit f4e526ff7e38e ("soc: qcom: mdt_loader: Extract PAS
>  operations") move pas specific code from __qcom_mdt_load()
> to a separate function qcom_mdt_pas_init() after which the
> pas_init variable became unused in __qcom_mdt_load().
> 
> Remove pas_init argument from __qcom_mdt_load().
> 
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

