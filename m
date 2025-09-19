Return-Path: <linux-wireless+bounces-27526-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7771B8AE7D
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Sep 2025 20:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BBC91CC41BD
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Sep 2025 18:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC234254AF5;
	Fri, 19 Sep 2025 18:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pBI8VajJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A818264A77
	for <linux-wireless@vger.kernel.org>; Fri, 19 Sep 2025 18:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758306211; cv=none; b=ZNGa43vK5ZzFd/f6eIcCf7btLZSqLbVA2ag6elmVgyzFYULPQJuceEtGv+X3DLdAsim8+6eZfF2nlu6d3FQqA/o6/zzCgD3J7rp2iQL5PWXM/StSBHxRp5B1pm2ZCfrcW0FdKLphkqiI2Tw2O0dSWLmU0wtTPtBqMfa1bHYb9us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758306211; c=relaxed/simple;
	bh=ZMlanAxFKexgGCKXayKLLyUygjm2ZbznDAdzTjViEy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mTLmvejhHioL6PIJSpR+EciFzWIbM9kLxEA2k0aDvC4oYVJNNmQEF4AKPBa+YdQGb2ZyGHL87ZDSLkXXts/ZwulP/uzDXVMFOufIuiLIANSszRouWEJ36yVybrsExCVQbUBBoCSKPAjLcqaf059YjORXFM3FROS7dTn7esTx/aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pBI8VajJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JHVUTx013729
	for <linux-wireless@vger.kernel.org>; Fri, 19 Sep 2025 18:23:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t2Rn0Zhk2qgPlF/bJPji0KgeEB74Opf+t5Tm2Q0n1/w=; b=pBI8VajJQpCv0y8r
	ng1nup7uOt4/HbABfBpalOq8BFXke5Ysktwl/FHNyGRG/Mf/iTOp0/1iiHaKGNQh
	LRsu1C1aAtFw9Rba6HMies2sVcZMWncqB8+e60FXeJ1ykTe2ySTyjDSUA7nHwPrc
	tq0zluMNISUwnlPQGMkj7E9uBPXucO0Z6C0AJebUlTAiUFExLfouX4C7sO9kwFsX
	uqIqMi4u94DgvzCHlz5dcbYvwsva3JB5Gw8Ey2awCbDfDJpN8Qoq82ae/OS0wzCM
	HC9HrMUKY+F/Ccg1AhmPBiCCT5PiEIHhbLgMzEDu5GT/grIqNBVVxHv0d2pvlX6A
	hYx56A==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499bmy0584-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 19 Sep 2025 18:23:24 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32eb18b5529so2111606a91.2
        for <linux-wireless@vger.kernel.org>; Fri, 19 Sep 2025 11:23:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758306203; x=1758911003;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t2Rn0Zhk2qgPlF/bJPji0KgeEB74Opf+t5Tm2Q0n1/w=;
        b=Ivo78pOo9zAveWXnjMj4fn7g2dT6erl1g4i45ybKoTs9VK/GXhXO+lREAYXgSpZr6U
         3qc6cl+xlZSV4p3vs1VI021AhAmOrAq9bEGDKY1OKcMQusDSawD2eoQPA1FUuA0vgJb/
         wfc4WdkPpkgi3g5p3x1A3TO2wGmhT0PpHdbpk5aJ2pmgBe8arkMiqkxYlSisqWh4IREM
         cRAfEU3TEfzb2dz6BrVU4oBW0Ux1EqUau0Xzip7jsfNXQjwuwrORTcI44lybaBiRASTB
         Wj0njZC/TX+OhOU6FU0qy2M678/uvslQveAi/GZ/vxRozNhxZoQMQCexQxtShPwBxy3P
         NcgQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7fpBDH1uiv7sQQHvKV4SrZ0GrXyszGZkBsSVFdLl9AO6Kb3nGob9uo5F/YOO84s0ykeSyCXzp3lRpTgb3hg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3MJ7M5RQQ6VjDYQX2TjdYZ+NBL0E3M7zj6XMbkm4uYV9G9nbZ
	BM4kY/bkZ45mAAn8A1UN/5v6FCyuprD+6/OrJx5R96toVKfUsWhNld714LQU/fW/8R28gFTXlrX
	TBve073Wlhjwh9kuOjGrKNgjiX8DzHvLLglbwVl9sbcyg2dOb2+8tC/wK9AwpVoMIUfTJBA==
X-Gm-Gg: ASbGncvfDSE8uwf2EHyfFXRx7tCwozufgUHX8oyh/tbwfip/9JnID8pRNB5f3cAN92i
	D262bVpRekT2pPbXfQ1s6zdOSE7sP6662iZ+8LCAPajKjiCQBR576sTZOXtCftnh0PvlJiMw2zK
	2ZMkVZKKO5IlDEkETpmQUI0Kpdf7P6V0P2n/zv5dEp5L7sUoy4WtUXZcqXlzg+lJtW+6LM14HfZ
	F2XiBxZMqRsuv3od0uJ/OFHwUB74dYghrRhzrgQv7gc3S3bOp4j+qaBBDOHIErmfDVOWVbtAfa2
	p3fyXcuLTxNagkX10qPKPtJ+s8Z0f46bQ2HZG4CVq+WHW6b8UGbHoyfNKFzCxrwwQWBGePQAiSM
	oNunRKb8uNd0Jk6tCMPBdS6PnUAe8wwUf67oq
X-Received: by 2002:a17:90b:3c85:b0:32e:a54a:be5d with SMTP id 98e67ed59e1d1-33097fd51bemr4758849a91.2.1758306203186;
        Fri, 19 Sep 2025 11:23:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrPPr/A79RaXqsrPS/Xqqb+C4t+vc2ZLNFhqzMrVIkwPB4cvK1/aMVX2xJwlhu213uyd53HQ==
X-Received: by 2002:a17:90b:3c85:b0:32e:a54a:be5d with SMTP id 98e67ed59e1d1-33097fd51bemr4758834a91.2.1758306202765;
        Fri, 19 Sep 2025 11:23:22 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b551c279cd5sm2292066a12.3.2025.09.19.11.23.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Sep 2025 11:23:22 -0700 (PDT)
Message-ID: <dd5add54-c121-49dd-a3bd-0acc51fc3a33@oss.qualcomm.com>
Date: Fri, 19 Sep 2025 11:23:20 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] wifi: ath12k: enforce CPU-endian format for all
 QMI
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>
Cc: Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson
 <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20250918085406.2049559-1-alexander.wilhelm@westermo.com>
 <20250918085406.2049559-5-alexander.wilhelm@westermo.com>
 <e8d283aa-fb73-45d6-a89a-54ff31f205c8@oss.qualcomm.com>
 <aM0BRto3lYNJdBYz@FUE-ALEWI-WINX>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <aM0BRto3lYNJdBYz@FUE-ALEWI-WINX>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: sZBvdgDoNSPGb8rE6BORTn56jwZiRarW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE5MDE2NCBTYWx0ZWRfXyITG+6hVLMOB
 4J0sR3mTmZAUXVdodi7g5n2nwTkaFMWQd0AzvmUikhvOWiIILeH5D+e60tszAjDCxurXMGpviuI
 GMXuuog/eAzD95xIM7L2c6LfDMjELAeA0rzMeAGZ0ODRjeDK3AXivgL7ZnEYlUfx0WuY+U042eh
 hRp0zoh3A4s38oN8qAELBSTquXhB3lcecHifzZ/R0OwN/3M9J1G3M66EI6eUXBd2bayQbAwm+et
 QitclgJmTQwFa/VzehvBSNrLnejcR09w4tGCPzhOqxaLttJLNMkl54Vof94dcLfEh5VTIRlJAra
 y3DJsIVotXFLNOq9wOGULG7FMu7vjV2rbx9hwuzmz04ILXa6P9yFAqryNotob/xHGFdd5v3xDfg
 YXpL0aQ6
X-Proofpoint-ORIG-GUID: sZBvdgDoNSPGb8rE6BORTn56jwZiRarW
X-Authority-Analysis: v=2.4 cv=ftncZE4f c=1 sm=1 tr=0 ts=68cd9f9c cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=GsdoeonjsfuC13c6vpsA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_02,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 phishscore=0 spamscore=0 clxscore=1015 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509190164

On 9/19/2025 12:07 AM, Alexander Wilhelm wrote:
> On Thu, Sep 18, 2025 at 09:31:18AM -0700, Jeff Johnson wrote:
>> On 9/18/2025 1:53 AM, Alexander Wilhelm wrote:
>>> Due to internal endianness handling within the QMI subsystem, all QMI
>>> requests and responses must now be provided in CPU byte order. Replace all
>>> QMI-related data types with CPU-endian types and add the necessary
>>> conversions to ensure correct interpretation across architectures.
>>
>> I think you can break this out into a separate patch, but reword in a manner
>> that doesn't indicate any dependency upon your series (it can be a predecessor)
> 
> Sure, I will do that. I have only two questions:
> * If I split this patch series, should I start on each one with v1 again, right?

for the qmi series use v2 and in the rev history note you dropped the ath12k
patch. for the ath12k singleton use v1

> * When I mention that BE support will only work on future kernel version, should
>   I better avoid the "Fixed:" tag or not?

i'd avoid the Fixes tag.
If you eventually need this series backported, you can do it yourself rather
than have the stable team unnecessarily backport it.

/jeff

