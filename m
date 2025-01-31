Return-Path: <linux-wireless+bounces-18236-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4B4A23890
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jan 2025 02:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E05BB1885044
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jan 2025 01:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E830D27E;
	Fri, 31 Jan 2025 01:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I5YOTDj/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59379CA6F
	for <linux-wireless@vger.kernel.org>; Fri, 31 Jan 2025 01:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738286147; cv=none; b=I3N41NEkxlPOPzx+12MVmCNpL+VApVk3AZZkqCEX3bpmMum5VRsMFRCP5l36DoipKNgth3JgMOY1t3nrJAN7AgA/NTQDE6af+hmTIh9eiKZASr7GcKr7HbBf/SY/l+n83R8iG+PpBKRx4PDw+TjvQAktSt9k0bJCAOQ9/P4uHN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738286147; c=relaxed/simple;
	bh=sQ12CBZHeLdk0Z48Yd2xb6N2hK8NRoqYW5w9ncDEzdI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hk2pyeWNP255WLyUs8Hgg/JFojisTi8ZwrBZokZPqOyKhEtDDpm66XOCuNOEdvoN2pSYT8q2MWmZmyJH8iHxKR7ww/2XpBgVwnrPKPhKbJLw/ZQXooNZgAI4CA5e3ZGozNQPrJs678UIm5N28sQPiBVXVM51pK0AI7r4ZJJ0s9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I5YOTDj/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50UJ1nvQ004512
	for <linux-wireless@vger.kernel.org>; Fri, 31 Jan 2025 01:15:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gMGVgR75MTrOYJ271BzFJz5EknBbsyiIL+wi6HeOkO8=; b=I5YOTDj/OFRXrbdh
	aNuRJgMiPlP+rfyLwA64b/hfgTSeCfe+sqR2et3NN0okTWf/YtAsMBy7HFBaIMul
	llUXMdF2peSgIcga/4D+xN+oTmtIIY7X2EMKYEbk2J93g1vnJ0EY5B+QRnhRyLvg
	YDjmhonHSVGCeE92hLSQJgq+cMZmaKz5zeIqo7MZj2uQFpixZGcrH47n94znCblC
	FaC7F7sKYxyVNw2PgsEvhGwuLJKiDG8ujiK8bhWHY8znKTqoquD67EuiWByUa2S+
	lOl5HXA+PXI2OGW74cT8VbX8DbpROHDjU6yO4Lb0oL0P0Rza+GpCQuoJanv9Lhjn
	bDuy6A==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44gf7j8m6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 31 Jan 2025 01:15:44 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2166464e236so42275805ad.1
        for <linux-wireless@vger.kernel.org>; Thu, 30 Jan 2025 17:15:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738286143; x=1738890943;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gMGVgR75MTrOYJ271BzFJz5EknBbsyiIL+wi6HeOkO8=;
        b=Qho5aR/YDNx62D5U+j42mAhXQsI0mywRHWiK9Ox6inkCwLtACS3eghw+5iq6beJvST
         e/gj66qYluWHQN6t4H7UZjQXU44hQCrVclsUNUQXxh/wC+9qJeHrzXbWIysLh76d6q0J
         FJuc+CTUp5p9X8RQ7ppYXdo/U6aExmvdp79N011x6NKnIXdkjz8qm7hWZ+sfua4KQVav
         L0B62oO8/lMeSLIvf5g03edCt4N/OB4mcbuKorzt/9MTTeghtPUWvrIBVsadbx+zslNJ
         0sFkB/LI4+L0rvsSiKXW58QBLQqwvhWrEjYtYupiQst+E5VioUi4OyJcVtCQ73u/aKAG
         f2sg==
X-Gm-Message-State: AOJu0YwvQ6K8UHwU4DcyUQkXbfiPtAbAoqytDfAnx/MHRmMW9zFXGvS7
	FAJUbCKHac1QzY4YIATrz2P2WQpKqq4FwGXGIzkXxbba++S1zoyPJ2YA/k3IgqN8pk7Skv6G6FN
	L/t0BXEX/7y+recT4WFb0THc80Z9P5OJjUDV/wq9R8l1PQ80XxYfrc8xyItdZOhWeuuusXSou1g
	==
X-Gm-Gg: ASbGnctBO0bcmSIyRRzl6yUhswwmGMuwwWGhlcUh2+Vy3jCrH8UAETiEfbl4106cTkK
	7VTbyfLfUV52QHDd8l+4DsfvlIa3lqr8630osCBBokccxokMZbRyWAPEsH2ErZMBCNe4xSP7VBq
	icQX+9/Z0joVKbQEgkQKT0s1/gihA2NTA0133mRhEUpidOzZdcHjMEBvHAkimU84aJ17fngROVv
	U1l6ockot31HgHhGasSWoXMSPrRaURgvNXoziVVIYQcQFp+oXYujkMEQqZxb7TngbkH/D4zrDdT
	CwlpFJWOjmoOH0Im6DBsZ5FBidZ0l/CT9oA7zKVLPARr81ek8aa0b3awBo3ThUne3P3D6h9cYg=
	=
X-Received: by 2002:a05:6a20:12c1:b0:1db:e0d7:675c with SMTP id adf61e73a8af0-1ed7a4c9922mr16931231637.13.1738286142995;
        Thu, 30 Jan 2025 17:15:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFUUaTKw8RFo6zih1oBkByL8kEw6QPB1jmjVF69kXUC5I3oIP5HsKduU9vCArUVV+bcLpxDA==
X-Received: by 2002:a05:6a20:12c1:b0:1db:e0d7:675c with SMTP id adf61e73a8af0-1ed7a4c9922mr16930621637.13.1738286134966;
        Thu, 30 Jan 2025 17:15:34 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe6424f81sm2105593b3a.37.2025.01.30.17.15.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2025 17:15:34 -0800 (PST)
Message-ID: <2af37a7c-567f-4687-b290-92beeac339f3@oss.qualcomm.com>
Date: Thu, 30 Jan 2025 17:15:33 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] wifi: ath12k: Support dump PDEV transmit and
 receive rate HTT stats
To: Aditya Kumar Singh <quic_adisi@quicinc.com>,
        Lingbo Kong <quic_lingbok@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250113071758.19589-1-quic_lingbok@quicinc.com>
 <552fd4f9-7787-456a-b6d7-de7b96fa60e4@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <552fd4f9-7787-456a-b6d7-de7b96fa60e4@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: L8ei_X765q8ZwiU2xIhkGopy03i3CE_z
X-Proofpoint-ORIG-GUID: L8ei_X765q8ZwiU2xIhkGopy03i3CE_z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_10,2025-01-30_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 spamscore=0 mlxlogscore=821 lowpriorityscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 phishscore=0 clxscore=1015 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2501310001

On 1/13/2025 12:33 AM, Aditya Kumar Singh wrote:
> On 1/13/25 12:47, Lingbo Kong wrote:
>> Support to dump PDEV transmit rate stats through HTT debugfs stats type 9.
>> Support to dump PDEV receive rate stats through HTT debugfs stats type 10.
>> Support to dump additional PDEV receive rate stats through HTT debugfs stats type 30.
>>
>> v4:
>> 1.used tab(s) to align the = to match the existing code
>>
>> v3:
>> 1.Rebase again to 48322e474f04
>>
>> v2:
>> 1.use TAB to be consistent with existing code
>>
>> Lingbo Kong (3):
>>    wifi: ath12k: Dump PDEV transmit rate HTT stats
>>    wifi: ath12k: Dump PDEV receive rate HTT stats
>>    wifi: ath12k: Dump additional PDEV receive rate HTT stats
>>
>>   .../wireless/ath/ath12k/debugfs_htt_stats.c   | 500 ++++++++++++++++++
>>   .../wireless/ath/ath12k/debugfs_htt_stats.h   | 182 +++++++
>>   2 files changed, 682 insertions(+)
>>
> 
> * drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c: 2025 copyright 
> missing
> * drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h: 2025 copyright 
> missing
> 
> No need to respin just because of this.
> 

Yes, I can make those changes.
Would be nice to get Reviewed-by tags if the series LGTY.

/jeff

