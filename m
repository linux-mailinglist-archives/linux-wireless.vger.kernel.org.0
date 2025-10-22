Return-Path: <linux-wireless+bounces-28165-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 48439BF9E5D
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Oct 2025 06:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C2AA334E3BB
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Oct 2025 04:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4891C84DC;
	Wed, 22 Oct 2025 04:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GaXEME5U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E732E200C2
	for <linux-wireless@vger.kernel.org>; Wed, 22 Oct 2025 04:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761105642; cv=none; b=XJJHo6YMmtCzUg/RljtvuzqoePnpchpJvze0fhFMqA6AdwBAbzoO9yOHJmpYY8Hx54vmkz3FwvAItca+0YTA+bf9sXLRmxemolbBv0Gd8FE/E8UgfS9eJnxrVRcjqOKcpjjqPO2Tee6A8YZpRzsANClBY0H0Q9HNV03RsfgiQ/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761105642; c=relaxed/simple;
	bh=/QiGcfVzJky5uQKH/5Frl1iRLoglkeK9yzQmKYJgGqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UYghhmNs1Zxs7O+bSG0uY+6CjZhC3uSjBF89N2W+0Xl0VLnkBvvPKJciZtNYSVxnLEOrcc6qzkE6U4kcNpvhYV1c6zhQxSWE9u/bbqfg7DdIQNR46xevlyKkLdjdK/GNs7PVNvoX+5tbUxpB670jltwEHUbeNViMGuJmwP3rqPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GaXEME5U; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59LFmPTJ030213
	for <linux-wireless@vger.kernel.org>; Wed, 22 Oct 2025 04:00:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZYIRQ7B6jRrorPEwy8/HTa8e3SUlYSB9bsTlCadMTx8=; b=GaXEME5U/nMJTwHd
	1ROrsG8wFT3hh7yDIorKcp157z456dtVwkvpFiYNuUPnEZjf/A8vVlDLrupiLsuO
	jQAZyB5REvmmIoh57Y85osvKB1gXxjxTOqbcLeJpVdz0jXuboV9LznJIEPpMgGPE
	IeYg7iVOP3BnhwBLFEMXfI9ITAWAOjMmvmzVjTWLvg1NDQa/qVz1vDAKe1YpIqeO
	jRXJ+n3YtzjPe+wz3ZCP60tSDGr9jGZLzI6XAAmfHi85GOzbnnN3lo8h+z531SXu
	aTXjdXIHBLFp+NyuMpHOfZryvKXdtc8/PFmdgw5hIyCKB+sqSWoUafk+v60hQz6z
	3rnS7w==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v2ge34ja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 22 Oct 2025 04:00:39 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-77f5e6a324fso12331838b3a.0
        for <linux-wireless@vger.kernel.org>; Tue, 21 Oct 2025 21:00:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761105638; x=1761710438;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZYIRQ7B6jRrorPEwy8/HTa8e3SUlYSB9bsTlCadMTx8=;
        b=IqGySDEQPZixp33OqtOkkrGoR1ivaIBPPMZtkDR/WDDDgyHlDJ9BanKrv0woaLZFp8
         kowYRhv6aIUqC4JlapiASIKisNAKpyabZJnUjfnLO5THYvAoIQP1uC+hKpR8c5GvuJ2r
         Gydv8qrEbjxYllKzk3Pjan44/P1YLF7BbvDUxxQBkQGINfNqnOybBdbDHKKHcC+JNQu4
         TYjU37aBT9qcZRBCd0gaxLu7Hui8h8Hq1dnor00MyVVlyFdYq6jAW9R+tgIs7DEa18Bp
         eFbZHMMIOfpZ/ObKfr9WbtFFyhMNGmE+ffNs+FhXWXkmjRPzktaixUxKmi22PVM7Qqml
         9L7Q==
X-Gm-Message-State: AOJu0Ywgd+ooQXefUqo0lJeB5uz/3LqSpZlhCWPFCV/tNb1hFiwxwCJy
	G/FzSsUwHljiUJZz9nQ7cRpxCVKY1xlgabulIh2kTFcotk4eGAeEQaMckoZFVeDFEJzDUKjtjlO
	4ncZFj868vhJlrZp4joI6MgSIec2O1oEZWOoK4AaCs5iVp1pgFBlr+vJVq00CaWMJmKPtGQ==
X-Gm-Gg: ASbGncsRaLdg5Fq6Wjo4bm512dgl0ydyT56FO5oHmUiAz5vYNsoqroKbrsivDnqciSI
	6/M/QiCVZLgXk+fcKstUvhYfVJTVZDkCUIKD9QfwjJB5jKa8Jf1900EoW/1BevHuCOmit7+F74F
	nLKUjyyqWijMX6yXzI62+xRn2T9VQPVvVk/GJ5durR22eusQtmUczb1em2rASjP3yOvTaweLehr
	kbFQbjVTVRLBEJEMqdbodz8XLgpnkrHzPp6rpesMFuCuic1Y9iCl/tGF+ftw0+rmyWnNKe36qa4
	X4GdjBDmBbBGB6Nx1ZniWUsOSqGa5T7sw2s/8xkzzmmcP6Q02c18WsF87yeifa5YMR+wLkXBCUr
	YJe/9laFlzxxkliAXTA7DZPAAqi+FR/6xKKcsqFYdpy70qp5s1g==
X-Received: by 2002:a05:6a00:2e98:b0:77f:4306:d248 with SMTP id d2e1a72fcca58-7a220b1cb4dmr23213054b3a.22.1761105638293;
        Tue, 21 Oct 2025 21:00:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9+ZWgEYuelPUMs8/IMbjqolr/hnJiZreB6vELWwQ/GYSAepBQAwadLK+pr3OtRUJnVF3AqQ==
X-Received: by 2002:a05:6a00:2e98:b0:77f:4306:d248 with SMTP id d2e1a72fcca58-7a220b1cb4dmr23213018b3a.22.1761105637779;
        Tue, 21 Oct 2025 21:00:37 -0700 (PDT)
Received: from [192.168.225.142] ([157.48.122.87])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a2301108f8sm13116740b3a.66.2025.10.21.21.00.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 21:00:37 -0700 (PDT)
Message-ID: <f99a3639-9616-8328-bb49-17c121db5bd7@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 09:30:33 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH ath-next] wifi: ath12k: Assert base_lock is held before
 allocating REO update element
Content-Language: en-US
To: Sarika Sharma <sarika.sharma@oss.qualcomm.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20251021112204.323242-1-sarika.sharma@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20251021112204.323242-1-sarika.sharma@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMCBTYWx0ZWRfX6yyRcpem79aO
 X7wQBJM1u6d5iEqFLjw1P3Y98tno9mavEX9EdmU0m9SbILDN39NtPby3x83Y+hVhsqm6yJKIyGs
 hEqgFSJIjzscZZsD81YYEvNAsK4esiHP0TexN03A/8UP31eTjx4BY7i/HjL8frtTBR2SUwSYYDZ
 YeE9PSKe6vUm1oGZXhPDf1AbYv0ZKLH56aMGyltLxFDgBuiac/sK3HM0Z5cIifS/vt6msizCuih
 V1l4vWnrf5t3l/zDahFi9LIAdbUsnV9nyIp/4RfcKvi/xv51UIDx+gI53S5F1Gy5jjYEeUF8f3+
 rqvX194cE1SVtUkhG0s5TaRv3MMIROtjr3RjZp9mIsZ2y7k1QGjsLT+d5vG7f+niQENCg/1G8OU
 /f/RXcNn+6gLgfczV5PaUK85wEHMAQ==
X-Authority-Analysis: v=2.4 cv=KqFAGGWN c=1 sm=1 tr=0 ts=68f856e7 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=MVWiM3nRykcdLg9H6cDE8w==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=ynOTO_sPihNLyZ3iqyQA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: 7jFo7j8jhDR9LdTro_OB673OSuyfsSdW
X-Proofpoint-ORIG-GUID: 7jFo7j8jhDR9LdTro_OB673OSuyfsSdW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180020



On 10/21/2025 4:52 PM, Sarika Sharma wrote:
> Add a lockdep assertion to verify that ab->base_lock is held prior to
> allocating a REO update element in ath12k_dp_prepare_reo_update_elem().
> This helps detect potential concurrency issues during development and
> improves code robustness.
> Compiled tested only.
> 
> Signed-off-by: Sarika Sharma <sarika.sharma@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

