Return-Path: <linux-wireless+bounces-22183-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A3FAA01B3
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 07:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A84663B2C0B
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 05:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BE51A5BBB;
	Tue, 29 Apr 2025 05:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LGA86+EI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7361BC5C
	for <linux-wireless@vger.kernel.org>; Tue, 29 Apr 2025 05:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745904096; cv=none; b=VEPEYdl+ByezCDXNFbVUQRQeoCjBBLIsZVbfZIYu/pMhX0llaZ6Kof5TB4gYtlh5UeOJADyfAWZ/dNvoGUTmy+srAyvMeAXRZFSXnJHE33xpjtBQwGthds66SqCTbSV9+ToUbVJA0lknC+CNQgE3GSYVrNeUO99zeBbzQAkOxWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745904096; c=relaxed/simple;
	bh=q4vT8LWbwhGdJjRSK3W6lms4LZoznD1cZ7sCF76Po68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nAvx6JXrxuOVmGaA1z7Te6weXkm4L1mmRvij54UrvoJxi5hnpbi+rt49duQmkFdtjHdqjSU8LXXQj0OTFKoGgxXI1Imk+L0UXuEFQxOclMkJ/uGUpmUnAi31CMEHlwCJf2B0kDkbW1U5yLXWVJuyKdtaincciLVpe1FolGZhZkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LGA86+EI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SNq09S000496
	for <linux-wireless@vger.kernel.org>; Tue, 29 Apr 2025 05:21:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WzATX6zxhYJia28pC2CarcpW6OO4zSyxT+uOihKZvr0=; b=LGA86+EIPoIfhHXS
	ya1ESK+5iZzjnZ7N2dOVnBD4o61r0DuBIUAdT+Mrtp5556CDHq8xjRfZAi8R60U3
	TjTT2Q+3y3xmaccf14GpqIjWvVhkgx51prNjuqS9tGiZsDCQMEzwmJbjKlcKb5QJ
	ACbTMenmMZpKVOBOp2X67jM390ONMC3ZHKIQ6wAtXzgaoCpBOAhE9Gud7wZGioJk
	Wbk5JkEuEI5DarVQfB+WtGNbmapKo98H+8w3FsC8pW7i4nqAsWQYG+LxgChoQPm8
	7K472OhnFHGSwDhDBVcI2t+J2GOx2n8hEwiuKv0oCcPoAS+FQz8Spn1zJuwqNl0o
	Ln4S5w==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 468qv9k9wt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 29 Apr 2025 05:21:26 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-736a7d0b82fso5723038b3a.1
        for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 22:21:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745904085; x=1746508885;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WzATX6zxhYJia28pC2CarcpW6OO4zSyxT+uOihKZvr0=;
        b=Q7De5JX8kUfMjVbT4uv1nbDwzmp2yHzDzF7Ka0KtPhFtUCYEv8k9kbjcgKTizeIwvB
         HZTeJGHu9BY/etZOed57VzS388u3wEkHV18NgsoFXF94acT3xvDnhlR99lfCdeGmwH2O
         VHtCIWGOrVHvAW9XC0TosGXUeQSE2FqbJuHOXonjPBz8IG1DPnRyKWyQil2PKE51F+X9
         5aDHMMYk0hJAYbUe+kGauF5tRLpPKysxvfG+unIEQ5kYtUWBhxBXQwvGfyn1r1HPl0NK
         t3nUe6zoRQ7jHEVXK2Gk94C8RldMcRsoJjXO1J1Rau9wPWPbxLbPvgDGw0ZgQZTFIm0L
         JnVA==
X-Gm-Message-State: AOJu0Yy+pgF3I07s665lC3IXUYsawSJhdk1dI5kY2lS8afPYvRfk/lgv
	RXtjZtexiXVtJyPDoiKMUT9Q0ZvxvTODSeqN4qdDMLii0EXw9nV0mG2iM3ZEt7G+5fSZLeZWV3i
	gb0Guj2FZShmtQ5LbmXVMddnPyJ2g22cwRLBJNbIPkDm7+NJF8gcraedAuKe1TqAMGA==
X-Gm-Gg: ASbGncvXFIiwSWO48dGJ34jielP/8GKwNJ2GzWrCosNGHXGep7PTj3LeSKG1yry7+lj
	8lJeem7+vKARWleQ80Wtfijr+2od0O1Xj75nhrquK13A0YZZ6VvnGj4sEp3VJniKvRNa0dovbOi
	9th2oVXNI35VMCuFYMfd0b5ojUIM5ZMOGULYqAzxSfvTgOq9SUnXXGa2L7q5OX6V6xsTQK9hvCv
	MAVn0JEm/j88p4yhGt7WhvhyAXHCkgJznu8OUUK1+8nfIAznC/ohMQQX9n7TPfEyKG3/+nYqzvP
	cPjndgzQyXZ2qfzXzjQdjgGupm2stgiWS3VPWsnX+wf8hhJ43vpE/A==
X-Received: by 2002:a05:6a00:1383:b0:73f:eeb:84bb with SMTP id d2e1a72fcca58-740271dec45mr3673307b3a.19.1745904085258;
        Mon, 28 Apr 2025 22:21:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3KMrIHoIFeZNETaFU8v9QkPiKuy+plcJdaRstmwKz3TkdKekqZHPWJ8ksxvfGeszqhm4xTA==
X-Received: by 2002:a05:6a00:1383:b0:73f:eeb:84bb with SMTP id d2e1a72fcca58-740271dec45mr3673281b3a.19.1745904084857;
        Mon, 28 Apr 2025 22:21:24 -0700 (PDT)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25a6a171sm8988485b3a.87.2025.04.28.22.21.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Apr 2025 22:21:24 -0700 (PDT)
Message-ID: <44c0415b-b5a9-2e29-6dfb-158ff9e14308@oss.qualcomm.com>
Date: Tue, 29 Apr 2025 10:51:21 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH wireless-next v5 4/4] wifi: ath12k: update EMLSR
 capabilities of ML Station
Content-Language: en-US
To: Rameshkumar Sundaram <quic_ramess@quicinc.com>, johannes@sipsolutions.net,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Ramasamy Kaliappan <quic_rkaliapp@quicinc.com>
References: <20250327051320.3253783-1-quic_ramess@quicinc.com>
 <20250327051320.3253783-5-quic_ramess@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250327051320.3253783-5-quic_ramess@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=AO34vM+d c=1 sm=1 tr=0 ts=681061d6 cx=c_pps a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=sqzE39mHLPIEPpc8iXcA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 4z4x6lJoaL5YbKyynRMvZLfdfifcTBdN
X-Proofpoint-ORIG-GUID: 4z4x6lJoaL5YbKyynRMvZLfdfifcTBdN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDAzOSBTYWx0ZWRfX11eNwn7133PE IXK2TxFbkHKeuXbxrGejvIIXpzIRxIhmXDneSZMCtgv1ywwlLf229+c6HIqV/cGi9C0hn6P21uN 33eGyyeUK/iZ55/3VZ2M7GskC3PU4QMcDS8x+3F3oEnffxHYxv5ceqooLNiDp1GQzgK7z3u0nX/
 Dru7eatouot3T0YoPWapEsta+AjrfckHY29XItTKrN30IdsRo03Mhr359xAuMMrwdwEPJy+4fDd BdaNOYw5TaVPuRl3UK03liNE6ewlWb9UCDE2oquAZnPMTefRWBVaHPQiUg//Z/GD9V9O0wIlMeg M5hQ9Jy1xkbUl5RTQIzN0sXXl4Hki3otuwwABfjm+J8Vqcgy5QtwiHV8b7dkKL73cS3F2+3rWXT
 8KF39xyRCodHrurx8GnIHLgFvb8CtQoKpcq99L6iGq1jA2C9WuvfJQMZHdkHUUwoR960FyU4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_01,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504290039



On 3/27/2025 10:43 AM, Rameshkumar Sundaram wrote:
> From: Ramasamy Kaliappan <quic_rkaliapp@quicinc.com>
> 
> When EMLSR operation is enabled for an ML Station, EMLSR transition
> timeout, padding delay and transition delay should be updated to
> Firmware. Above parameters will be used by Firmware to do EMLSR operation
> such as sending EML operation mode notification frame, initial control
> frame etc.
> Obtain above parameters from EML capabilities information present in
> ieee80211_sta object and update the same to Firmware in peer assoc WMI
> command sent for ML station.
> MLO is not enabled in WCN7850 and hence this change is not applicable to
> it as of now. This can be a leverage once it is enabled in future.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Ramasamy Kaliappan <quic_rkaliapp@quicinc.com>
> Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

