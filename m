Return-Path: <linux-wireless+bounces-19776-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70874A4EB0C
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 19:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3D3A8E0BF7
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 17:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4BD1F3B96;
	Tue,  4 Mar 2025 17:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ML5EUbOv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0A02E3385
	for <linux-wireless@vger.kernel.org>; Tue,  4 Mar 2025 17:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741109979; cv=none; b=Aqs59pANgMK5HNSfAlwvXkfoD+xbcNNiY4gTFT7UX83eLdjiIj6D4/BfuJHryhVQD5IZTNQGmEFvcXjuNtF2oYeCxeWawV3RW/t8c/OhQStFJGoCc4JWfkseRpcob7vjArGofO368UYe0UW5mSUo8OkuMk9Dh9Vsbz0H79LO8Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741109979; c=relaxed/simple;
	bh=R5mt0/KAIwHLuDlo1ze8Uyr16A9iyOnem3ebCM2Sd08=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=M6n7BTiwm+o77gZIOfE6xDZOygmMRHEHlRXqJQdntw+cHtiztXWTUEkF3TTw7pVWVoWfJgzNWCW3D1eRo7Kj1ALZq0quOoXdKKb93p/LyAvYtAvycvm5EyXFCn7uM55TJF4HV+vY+/4bqKhClyapFkzwQxk5rJfuwgFGaDqDFzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ML5EUbOv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524AViCf016469
	for <linux-wireless@vger.kernel.org>; Tue, 4 Mar 2025 17:39:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lzNhBaJRhdX9T9M6TvLdhgrrQqlpW+5PC3DyW/VSNH0=; b=ML5EUbOv02uyIcYx
	EtS+Z/+4uq/PF5klQml+rsj6djCrsWdl9K0HcqeZ3ltKFOFwkBPYr8k2s+D4ZXGZ
	S6guY2v7JK06/phQCecR2QJr+Oa/wZQvgJsE/Qs9V2wly0hQ/vYB7PYXzL7Hrdff
	P9PkXD6NQOBGY+4Q2N98gzlAXfWsijZ1REXzeJieFfNxREV7z1/p5C0rJffAJNp3
	O2BlDodXHQNG0czfSnQLb+IkK7V24PynjEfEKcMZra+PqA5YtM10BQpXkHdJsQmF
	+GuScjqmFQMQ+C+UVmvgDv9pdxPrsdqOdasdxZolY8ZsTKgxXjUVQeWQ57BTISkm
	wAoDhA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 455p6v2n03-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 04 Mar 2025 17:39:36 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2feda4729e9so10394821a91.0
        for <linux-wireless@vger.kernel.org>; Tue, 04 Mar 2025 09:39:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741109975; x=1741714775;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lzNhBaJRhdX9T9M6TvLdhgrrQqlpW+5PC3DyW/VSNH0=;
        b=mYEqcPA9faF8a+7CcMQDY0yMvtSAFyO/VD70O47O541RdU0sLHoW4b45xpDlpXuZYM
         qIFJxD3ubHp7sTSulcFyU+AZyIqCpA1/KBzKekpDpukX4FfX7lqSHfXmLluH7eCvpoEu
         paGwE6CN41fsPaL3SZyEcHXYOTr2AlToVBiVpvEvRLPFX9yFz1ajnEK3SufJR7eQhc1H
         ADO04eV/VXU57ubkaTHyr0we/TjjmFWtps8pQJLcqkxo/4aA/VFg44ZW01F5GRFjIhn1
         pMUZq6VC/3gRR++LakYdFcHVRquqFpggTjqqt8FRRBM2ano8sjPV7lJtMQVr3plCQ5Hr
         ltQg==
X-Gm-Message-State: AOJu0YzN0Goj6DLHJKe3CqB3Dryzkf9i6U++snFBrPTNTC3IX+Qp2dIz
	0ED2z2O9xki3IhGBuGOLogv3t8qUSdJhmt27sm6Z7kkxIH04qGpdPqtX5x8kFrMo711maOESYwG
	meW1NvW1j+Vf3dQ+mpIJTZ5oC6QhzgeX2sq9KEIELGq0TSE/qyF8I9gnkwlMAn4u8ww==
X-Gm-Gg: ASbGncsRec5tBehUTuo2Dj2aeYsk6sI+IR6V1eP+QXpM0GrRsQ19toAelCkhR84IVhX
	U4wgD3LL3JQjo/FwAIS2Ipfoq2chrD7rvpMEMt5Kv7t4he3PJuCZfCXeNjv96rX+nL57vyfbn7e
	KESPSbV4nKo3uEGAvaxiOo4aHV9XkZYFCbYXAQnNxC6axhQLQKjLd6lGH2XJ7uKIqiTBecktq+J
	kCj/usP7FXMu3B5y0cbZl4iw32CkHrAOa/KRt+R6RfurP1muAOR3Kko4LN+L/CR+MYxMdx1IoW/
	X2zHAZ88iL/lor3ZB1iyPdmDB7UFcLDTfmVqA4GnvEE4YLI1EMq9qjCk5X3fkaFztdnXbow=
X-Received: by 2002:a05:6a20:7487:b0:1f3:321b:4f95 with SMTP id adf61e73a8af0-1f3321b5257mr11231337637.34.1741109975352;
        Tue, 04 Mar 2025 09:39:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG4ilrvoy58HBAd8NmoEttAzcssRc6/1hOb0Yyi8934R6godAGYMBjjGwKySjA5ICypNEAACg==
X-Received: by 2002:a05:6a20:7487:b0:1f3:321b:4f95 with SMTP id adf61e73a8af0-1f3321b5257mr11231296637.34.1741109974915;
        Tue, 04 Mar 2025 09:39:34 -0800 (PST)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7de1f7a6sm10286098a12.30.2025.03.04.09.39.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 09:39:34 -0800 (PST)
Message-ID: <9177444b-fcd9-4b44-889c-ba38145aac69@oss.qualcomm.com>
Date: Tue, 4 Mar 2025 09:39:33 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 7/9] wifi: ath12k: fix NULL access in assign channel
 context handler
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250222151926.379652-1-quic_periyasa@quicinc.com>
 <20250222151926.379652-8-quic_periyasa@quicinc.com>
 <6eed9dae-7f4d-4757-9d49-b21aff8e802d@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <6eed9dae-7f4d-4757-9d49-b21aff8e802d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: HxhCgmDAMZc_XiEoqvYDCBqjUuszkh8l
X-Proofpoint-ORIG-GUID: HxhCgmDAMZc_XiEoqvYDCBqjUuszkh8l
X-Authority-Analysis: v=2.4 cv=fatXy1QF c=1 sm=1 tr=0 ts=67c73ad8 cx=c_pps a=vVfyC5vLCtgYJKYeQD43oA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=3-wCbd5yTIyj0ScaWrAA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_07,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 suspectscore=0
 phishscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503040141

On 3/4/2025 9:36 AM, Jeff Johnson wrote:
> On 2/22/2025 7:19 AM, Karthikeyan Periyasamy wrote:
>> Currently, when ath12k_mac_assign_vif_to_vdev() fails, the radio handle
>> (ar) gets accessed fom the link VIF handle (arvif) for debug logging, This
> 
> WARNING:TYPO_SPELLING: 'fom' may be misspelled - perhaps 'from'?
> 
>> is incorrect. In the fail scenario, radio handle is NULL. Fix the NULL
>> access, avoid radio handle access by moving to the hardware debug logging
>> helper function (ath12k_hw_warn).

(hit 'send' too soon -- I'll fix this in 'pending' if there are no other
issues in the series)



