Return-Path: <linux-wireless+bounces-26202-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 392DFB1D65E
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Aug 2025 13:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33539561B29
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Aug 2025 11:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273FF25D53B;
	Thu,  7 Aug 2025 11:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fw4D04Ep"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A664A233707
	for <linux-wireless@vger.kernel.org>; Thu,  7 Aug 2025 11:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754565042; cv=none; b=CeObvvt0kxjAphVrNuc4z7INYI+PHRf/90VjBfLTrXgn9YUECr5HygJIVXWrqKJqW7jDg1TOJZXCU0Kfx6GKu3H92k4rT2ykBWjooegRJ3snu5cJfMmPMLyaLAgX2T4XEiNkBda0tfTty+Q+ARzO4ZRdFAsdTilsplipgRmpau0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754565042; c=relaxed/simple;
	bh=m5jWNEvGkMzDuErMr4s4xW21ahh0JKQb4e3hPiNzJGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RIeruJ9gLo5Qv/lwIcFvTxR1EzDW/rxN7NPNX8t+B5PwaVDV5ln1erxb5DUZLP0Hcif4fqLyrnoUvG3qz0EYb3momeh98o36Qd79HYqb28s/kpbwplJWLGrPoASgW9GH/XQ8dSUUMdj0G9IBu9lyt/pt3JMWozHeet1dyKW0fDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Fw4D04Ep; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5779Cv6s032585
	for <linux-wireless@vger.kernel.org>; Thu, 7 Aug 2025 11:10:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G6QbTd5oBtfokcdGnfaL3ss1dZtp3HHu7abxC5K6Xgs=; b=Fw4D04EpYVpdxFyC
	bM2AUmSmJA8+WxuGhswRdnZ39HAZ6qQuifSBmNHcr00zA5bo/oUZY5N4kG6fpODd
	Lzov9pK6fQyujbnQzGgZVhLgecEVgWV0cK/U182my6Yy1h83r1RDH6I4e4MP4rrD
	oPiGYhHpT4Ox4ql1MahzP/pUDZPM1oQaaVB2ja2+vB++Oyj/CRnQVMkLEbmypAaE
	erWiCb2JOYsjxt5Pzk9izkG87OqaHRvNDRm3lSGV9Epa0m25eVC2Z54n/lJvRGOD
	V4XXNixo1gVRuLBmZfXARCGIUcbcya6LRtBHZK+pAXvp23IWqMccuUgP69/PwBDX
	40yaZg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpw361un-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 07 Aug 2025 11:10:39 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6f539358795so2682606d6.3
        for <linux-wireless@vger.kernel.org>; Thu, 07 Aug 2025 04:10:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754565039; x=1755169839;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G6QbTd5oBtfokcdGnfaL3ss1dZtp3HHu7abxC5K6Xgs=;
        b=rK17FWVXLwHLabrlNBb6jhkpyZkUTQn3A09Q+2d+iQdA+a9lFsIucr5CaXOR3LOXx5
         hfifQB0oRxZ8mXb17zigdCt2eQDnBoIf3XPnaZMsotf+J0ovHnBjg9mD2i3ok020jMMJ
         2fA6iYW/m2qZVdu6vyTH17jkZrFk5cDa5h7bYJltWcW/LPpQiG33izdDv+bV/eqFr3sU
         +58IVfZaEtw1OgCiUo5IfkKjzYXLwER41Auk3xcn6CZ9xFududEFJAZi7nn5MK0oKaOC
         rfnriBrGkCkUIxNj5h7+f89v5cncH0pyGDFnSHDE6NqemnFYPaOIEDJ/FgT/qKAaTsg9
         dA7A==
X-Forwarded-Encrypted: i=1; AJvYcCW7vYrAozHEM0wZGLLnJ+jm/pg+82Y5sFEIV+eUM+WOCMnKSVq604jI5Ng1T2uh740L+Rn+Xhkqi8lDuT3zFQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/Vkk41g+5L3lUsBlidJnH6Xi3nml2g3qQAj1dt5JyxWywaqxH
	q+ongmUmx5Avc5GImoA6/lTz3GjSB26qO06Mt2AF2W4RbOUEt2kHl8YXE41VQhXWAKzrQ/QW9pD
	/6BkxXEE8GTgO64AqXEMJmn1eJ9sVLMoyGT5OdeXLVKxXKiQn8HYTp/G6MgMpL1I9ugEYNA==
X-Gm-Gg: ASbGncthHo+iMhKQK4U0GDSAIPUR4FIpZrQx8ntlh6j3ABOzbxBl/x/Gvuh1/Q9VXC2
	YejAlgEMCRY8aJl5ZsLfxr29O+o0EpzvhuQG3z64ua+wEw/40wDVr8zcP+8DmWT3EvcdS/oKZIz
	41aN6AWTCr/mUaweJDvSn+oBpTja+pWx6xWyup97/jE4qsn5FtkoHybno/TbYeIL2pxxlJmICg3
	G+rx3pMJ8DoBbjQJjc58hdeJWYckD0G1MmAaok+l0LRU9rohA9UFDQG8dQtyk7PawewUa2k05/B
	xn3pJIMtMM+AJc1Dm6dKMZ87O5gGyr1cArkERdTkH0IwPnnSVKMqXVxZ7nq6jtPVQD7BJsBrFUw
	An3ag17N12rELV4hYmw==
X-Received: by 2002:ac8:7e83:0:b0:4ab:67a3:ec09 with SMTP id d75a77b69052e-4b0913bb1c0mr45527271cf.6.1754565038629;
        Thu, 07 Aug 2025 04:10:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0EgQGvuGZuwaUug6DIZAl5YiLhPSTetS5nLC8plJAjvhb/juDcAiunqpwFSjSp5lL0p+Glw==
X-Received: by 2002:ac8:7e83:0:b0:4ab:67a3:ec09 with SMTP id d75a77b69052e-4b0913bb1c0mr45526901cf.6.1754565037949;
        Thu, 07 Aug 2025 04:10:37 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a21c099sm1288976466b.108.2025.08.07.04.10.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 04:10:37 -0700 (PDT)
Message-ID: <f6432247-7455-417e-9bf4-068b564461ba@oss.qualcomm.com>
Date: Thu, 7 Aug 2025 13:10:35 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v3 3/3] soc: qcom: mdt_loader: Remove unused parameter
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-remoteproc@vger.kernel.org
References: <20250807074311.2381713-1-mukesh.ojha@oss.qualcomm.com>
 <20250807074311.2381713-3-mukesh.ojha@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250807074311.2381713-3-mukesh.ojha@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOCBTYWx0ZWRfXx8SpFhHuevlH
 rGleyiJHD6224QoTJsrZktOaOzEPRWNNIwwg0ECPAeGbqIzOWR3b5kFIKcAjCmh9rZ2Pyc8hs8s
 bqRlpo/9bf80o+TEXZWm8gtCM8ITDVAWbPNpAjdDk0NvCkT5O+G/vIml0LA96cK0gjtbUNfda8p
 qz135mGIxiNgm6IwhccPc/EIWXD6G0NsJEsgj36Ai0T04Dbo3DChNmm4foO/dathTfAVimMHcbm
 G0puCcehHp6ptB5oZJ2HlsxeNEAasBKTrN5+jx+3w8+kK5FmYpFSVf/Ll+AL/6QPk0h6M0uo4Q2
 TbEmOKsuVS9603Xc1ofE4+2S7oLrVE3fLjgx4y3pjzRQdVxXfZVcWz+WfVs8v7pZJ2zSgNCFBBt
 A6prDoPE
X-Authority-Analysis: v=2.4 cv=J8Cq7BnS c=1 sm=1 tr=0 ts=689489af cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=NyTICe1PHtTOfF-B13wA:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: w82PvQAAyXCrQmwF3h5e5SNbB3scdgw0
X-Proofpoint-ORIG-GUID: w82PvQAAyXCrQmwF3h5e5SNbB3scdgw0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508060008

On 8/7/25 9:43 AM, Mukesh Ojha wrote:
> fw_name in qcom_mdt_bins_are_split() seems unused now, it may have
> used in the past for logging it but due to code refactor this parameter
> is unused now.
> 
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

