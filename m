Return-Path: <linux-wireless+bounces-27513-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D904BB88ACE
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Sep 2025 11:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F4353A8EC6
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Sep 2025 09:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2A91E260A;
	Fri, 19 Sep 2025 09:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X5l32HgL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779F62264D5
	for <linux-wireless@vger.kernel.org>; Fri, 19 Sep 2025 09:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758275809; cv=none; b=IS4hV+nIz1+VmpJuKTfNOvFj0EDImx2vkwDN7Uw1hermpymGGydZ5yZ2TlHOqRs3s4iLjlvCpWYiGroAHoGU2o/btmgq4qD33iM+Hi9/LlE+3lXpgAGgg1UEdCFxhe/owPAhoPbP+8ZXhd/Ad/jkjkt41jipavj9/r5gAeFPQcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758275809; c=relaxed/simple;
	bh=nSRn0/4l3FCU+Z9UyEpLOaWa3yvoewbL0YByBlxUuXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cQh73zcxGQ/ZpYcrrVDqFfqIeB/n1lusG6G34UpT42J5Q9nvYjmABOZlVkHekUpl/23vZWgRD/r8Fd+lpaPGhK8ZVGYNdZmoA0mPEA86KJ5+Np+pmWa8ZVR1NwzenS1E1l/MemkNN68lQmpIySNwi4uqjlKrEQFlp7ZE7u5rIlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X5l32HgL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58J6oaac010955
	for <linux-wireless@vger.kernel.org>; Fri, 19 Sep 2025 09:56:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	S7jfB/eM3aZtCpbT62ScXfA6sMSuPXQ48dOM19I3DCo=; b=X5l32HgLGSlEMNIt
	LC6x9xThmWIajG0QGPUHE6VK+GCkU6z2/RNfB1TYfUYWq5X6m4123POW5q5FcYZn
	YFU/3Iohq1Si88XsN0e9VMH+n25L9I/rOxGFiJw71WKLtWBTLUBgJum7jTOlYoS4
	ODlkl6imA9+b7+zApNu5Zxa0TbjVp5IvAoyMxqeo1K5W2QHF6aO9Atw6gyQPMMPn
	si1CXlXeoQXckA8064QgWmzhARt3nZD+DesFvRT9slWd4k0CCg3s2v7EUUNAc8xP
	B91R2eWLybLnR2OuA0x64ON7VDvC/tw0Or35WG0TlWbL2B6oiczNuyUmUzgzptzx
	PhOrtA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxy1w5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 19 Sep 2025 09:56:46 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7779219ccc2so2308811b3a.1
        for <linux-wireless@vger.kernel.org>; Fri, 19 Sep 2025 02:56:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758275806; x=1758880606;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S7jfB/eM3aZtCpbT62ScXfA6sMSuPXQ48dOM19I3DCo=;
        b=Htm3YtNv+i6K5hWtiNn0lHLUWY8ovsGXZZ2xTrYULzij35sgKv4wvV05jdPjFMtqb1
         d1wwH7HJpbrCt3jJxwkvTGQK3mB6vKCEHZ9pWGyZRrL/KsUN8UTrED89G4rOHxBg2FcB
         sKFxM28KTgqYHA5yMAkYwd/VSSN+HoeokIaBDSkP9SnmUAP2zOj3YEjjbqPLFE5PlDI7
         g5dFMHqMh3fU7noiocLMVV8VJqgBp2TVJGQQihy5Ufz5Md+Mwe/P1caBXGGHC8e+/25Y
         BwZ9vbxBtrG3XAWLMNlEXPofunEen0iC3ZiFomiKqmBx1XSM41r/xwtE39nYHsAtQw79
         qO3Q==
X-Gm-Message-State: AOJu0YyKtbvnl+vLJyvIE5isRlCrX4SSdL8jlfd2/UC4GGR3KrITYvdM
	vHYndjuVuoAYQv9x3b3xgA9PR2MutjjI7w6uHK4UfgqseKJSbnT514ljL8qxVkRDeHbxLN1Ds7H
	hvKGYYMSFcfpLHwCbL7cp3b0B+njWjpUE44k6MZclUy10MnduaVKINurmRtnaZnYFp/5kMQ==
X-Gm-Gg: ASbGncsOvjF6oALppWfwsAU11Ajzn0mSx73vgODnmQQUujKM1DN6UH1YvlJvx6BVCnT
	Lr0NjntWZo0aWuBueXwE16TmK0UhFOG0ry8rxeKQYKumncZQmTqfN37+ax1gMOQLcDTazpTDAHb
	LRL186xkxvy7EIFac2gRFTxhW9LQGod2qpcjmPlaierUxXY/J7/5wIZYNSDflQTcSNA2O77FtaY
	feCt4btZbRMiafDyRr2NSVkOvAQvnTeFIj2p/Bxq9TCuZngVSFWNi9/BX0gOZ7AR8PQJgQZiK+V
	Qx+08gVD8Zvh/GKWiTeKhWdO4tD95rTtAHdHc7Q/iIbhrHsS19UJudkjaPvPgV5XUascN2D8pwY
	ybqF82msWXOzCUcNXYJvBVWtCMowRqAEc+sAT
X-Received: by 2002:a05:6a20:3d85:b0:249:9c7a:7715 with SMTP id adf61e73a8af0-2925c275680mr4158385637.1.1758275805746;
        Fri, 19 Sep 2025 02:56:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaaiAHpsZgqhNCWxPlJIASuEA0qV/NZaJTBDHc6ByLkt4zBGQcL4Y8Ftso5oUD2dqTCgeoyg==
X-Received: by 2002:a05:6a20:3d85:b0:249:9c7a:7715 with SMTP id adf61e73a8af0-2925c275680mr4158341637.1.1758275805116;
        Fri, 19 Sep 2025 02:56:45 -0700 (PDT)
Received: from [10.133.33.30] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b551905bbbdsm1597080a12.31.2025.09.19.02.56.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Sep 2025 02:56:44 -0700 (PDT)
Message-ID: <5dcbc728-b440-4f84-bc36-cc75da6ff16e@oss.qualcomm.com>
Date: Fri, 19 Sep 2025 17:56:39 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: Fix peer lookup in
 ath12k_dp_mon_rx_deliver_msdu()
To: Aishwarya R <aishwarya.r@oss.qualcomm.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Hari Chandrakanthan <quic_haric@quicinc.com>
References: <20250724040552.1170642-1-aishwarya.r@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250724040552.1170642-1-aishwarya.r@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX9mp3v2C7q3VQ
 RlBVHqINX4sLzEbV3V/eUHhP88u8RjqY115ZJRhqPoUk48HCZJiX+IXqcLgMB3qg1QPJW7CYRdi
 iyOO0x40CAEUSvJJH1wxFlvdkncYKg2SjrVNqfpL4L8zpiCUvr0kxRyRhF4ENv3eSrVfIIRCvJw
 DoIhoY9PrOEcQ+uCthmIXyh6/GIXpWh42Qw4uL1yrufpitafO1mGDkBW1UZISfeFTAqtXrF3yQs
 x5uVYWQpLnrh6nalS0ieV5GxvL89NexMEInlm3zht+jKzf2s+IucScEPkXnmrh9Zwucn9pVCdQr
 k2q6dD7i7ezSUckqQaKQX7pZMP95Ikt81gwaX76xvobAKx69C9qsD1aJfXmUvvy/g4RvShau2UQ
 vikh2Dae
X-Proofpoint-ORIG-GUID: vyTY3GJ5wcS_mnSMuLenZiy6e4jsc1Mn
X-Authority-Analysis: v=2.4 cv=KJZaDEFo c=1 sm=1 tr=0 ts=68cd28de cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=BhMcNSPQYusP4RIe-kMA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: vyTY3GJ5wcS_mnSMuLenZiy6e4jsc1Mn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_03,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 adultscore=0 impostorscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202



On 7/24/2025 12:05 PM, Aishwarya R wrote:
> From: Hari Chandrakanthan <quic_haric@quicinc.com>
> 
> In ath12k_dp_mon_rx_deliver_msdu(), peer lookup fails because
> rxcb->peer_id is not updated with a valid value. This is expected
> in monitor mode, where RX frames bypass the regular RX
> descriptor path that typically sets rxcb->peer_id.
> As a result, the peer is NULL, and link_id and link_valid fields
> in the RX status are not populated. This leads to a WARN_ON in
> mac80211 when it receives data frame from an associated station
> with invalid link_id.
> 
> Fix this potential issue by using ppduinfo->peer_id, which holds
> the correct peer id for the received frame. This ensures that the
> peer is correctly found and the associated link metadata is updated
> accordingly.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> 
> Fixes: bd00cc7e8a4c ("wifi: ath12k: replace the usage of rx desc with rx_info")
> Signed-off-by: Hari Chandrakanthan <quic_haric@quicinc.com>
> Signed-off-by: Aishwarya R <aishwarya.r@oss.qualcomm.com>

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


