Return-Path: <linux-wireless+bounces-24713-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F014FAEF273
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 11:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E7C84449CA
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 09:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE088269B01;
	Tue,  1 Jul 2025 09:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QfBFl2yO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6241F224CC
	for <linux-wireless@vger.kernel.org>; Tue,  1 Jul 2025 09:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751360661; cv=none; b=rLK09A40XTAaWaVXtam0P6MlSoGy4TqLXWAw399mOiF1MRg2CNE0ZNzFCfQvFeBjYruX08gaMb6xx+fKXpWCYT4X4s//bRt7AH6h7KyyVFWUcXXqHS6+e/ErwWoD6O54ngra53RQl16x0ELMhh16zRJnIX3gIWiyJs4z//0l06c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751360661; c=relaxed/simple;
	bh=DLZCz6povLrmtSDq2cqlUm2uZz/h+I1J7zhdUk7vnUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d3h0ZvHuN6w92BpI4qFJ4eu9+oolgFgPGW5AnCwmFsnweGTp9rR+QZUQPR85+XBNaBm6mTTNS4X9EE2/gt8OKf41GMoLXJYAhuSwvBYwxQkVcvGtb5EXLr7zypNRbuB/hTA1tQa0Tn9urQi58WLsPYhzQZL0gpQ0vgsM6LO4nwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QfBFl2yO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5613MkYl032129
	for <linux-wireless@vger.kernel.org>; Tue, 1 Jul 2025 09:04:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	L5DcKP/Urr7dMC89ZWavo/I1vxkXFJxIQV2Y+VnmMyQ=; b=QfBFl2yO6FB6Mbqf
	eHGKdvmp4t1zFfzk6ugJN3JcXJ2MkA3bp7eDeI2SNZtzeD0x7nA25yaLk0swj23s
	E7GvHgTeqiuzu3R/4jxjzegGypjrHhohhfY4SOaPJKY3IMPRZzMPPOVOmPJStMFj
	b82Ciri2K/T7YluFNfnLbbdQL3b9V3bGwAo9YwXWYL/q0Y9rqhhv6e02qrB34yj3
	c7V+3wL0HxSCSJZe35MqixE5Tk2NuPQB3KzusN0OBrK+aUDSoYEVXsDn4azD3MAD
	njkJBklCETM4+eG++AV8snod3+YoKZLPD2zn1j/E9/S0hUPY8aV/Y8J2sJ2+9hRK
	iYmHDg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j63k86br-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 01 Jul 2025 09:04:19 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-236725af87fso65549615ad.3
        for <linux-wireless@vger.kernel.org>; Tue, 01 Jul 2025 02:04:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751360658; x=1751965458;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L5DcKP/Urr7dMC89ZWavo/I1vxkXFJxIQV2Y+VnmMyQ=;
        b=aUy/2i8Pq0Oc6D7gX8ecXN0biorzpy9Hznwq2HlT/RDoY/0dPx+WzWVjdh8zWZiyrC
         SoPMZVK4DwV/jAEJs/w1i516+8BFisNDQp2TPCB5cW8KiAlJIEaPuoZHQZG3d52zwA9d
         sSmYKDW0XJh/aqEOofTEJL9mY5zpzOECEAkHp9snAOu83HPCTF01hughni8WWLrJSA53
         cUiBbbrnDKG2ktqTHsWlgB4XmKxBUM53yxBHqo7HlkgaxVUy4BeRbtQYZpw4BvU7PNz7
         AlO42+sAWVhB8pto/dRI5zB8KFhXwIez6a3SFoAHzxqMhddPtnIMfw1NOSB/GI6i4RLF
         9v8Q==
X-Gm-Message-State: AOJu0YwDb5taGdc2plRj4rmWASeXB2S7KhrQS0lYosDFLKFW70COPSPv
	OVqpFkeMogANbrrue+2ThDF9a76SHa5ZBYysmXg5RObBhDNjPfqky6QyPYK/z0T9f3Hlnp+KdvH
	r5vCEZUoY+a17pSRJ6CmvAn6mp+HsEUvw7Ye9s1hG9EqOAxy1JBlUwU58Zh0qoKDptgHJOx6dgx
	AzpA==
X-Gm-Gg: ASbGnctYlS29W9AfHqjG2P+s1dZItJrCm0KnRkcNkY6C30ctflIuqOsncfA4wUvAr62
	JBrczJ6YMSUEiDJkrroNsANdwyxaA96lLXKbLmdtfIIhBvuz9PI3npfsyI52P7IHuZ5r3qVVDeB
	9FFJHq+3ijev/pA9KYsL7uHJLqglaEkWPv50pujZfS7MCsJKdyETrkcGA7mja7cdJEHehOigf5o
	lxeepoAiEbv4yqyGFGXpIQ6nTe71fRsgBLWJ3teMhc3sekoCF8Bbv9rG+NdfkDCbfW63P0QrgHR
	CQyMfTCwYJzZ4EaDYTcu0Z3n/wpxNlDvkXaCarpTQSKi6e55MQsYi/UPT9ddvwXT
X-Received: by 2002:a17:903:17c7:b0:235:c9ef:c9e1 with SMTP id d9443c01a7336-23ac3bffdb2mr309498215ad.5.1751360658261;
        Tue, 01 Jul 2025 02:04:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2dEYYq5w2zcroM8eLEQvZUJSmsbU1eK7wu9G407TCwPIvh/KG6a3aTkbMYlPZv+zovXY6zA==
X-Received: by 2002:a17:903:17c7:b0:235:c9ef:c9e1 with SMTP id d9443c01a7336-23ac3bffdb2mr309497715ad.5.1751360657687;
        Tue, 01 Jul 2025 02:04:17 -0700 (PDT)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb2e1c05sm104454385ad.16.2025.07.01.02.04.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 02:04:17 -0700 (PDT)
Message-ID: <1fc913e0-74de-3079-d775-933e5496590f@oss.qualcomm.com>
Date: Tue, 1 Jul 2025 14:34:14 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next] wifi: ath12k: properly set bit for pdev mask for
 firmware PPDU_STATS request
Content-Language: en-US
To: Sarika Sharma <quic_sarishar@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250630064431.3446333-1-quic_sarishar@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250630064431.3446333-1-quic_sarishar@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ZKfXmW7b c=1 sm=1 tr=0 ts=6863a493 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=CUAva7D51FxePqYQcQcA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDA1MiBTYWx0ZWRfX/bOFsaeblQui
 I98/yLQjYJo0XDkZ5/GByxynD0qK7CCSs1COwqWMEsmA7q2CKsoCr8o6t/cdi2T3RdPR3pAqmms
 xKpbpwhj6PyPM1WZ942KSrqU4vnLT7TlQ48JtgxCeEnBe2T5BbvNnDe084C1HmMvQ8zwve5eQIU
 3sD3b/W6nF1oIM7s3A/Cs37/iukY5vdQJBXNSexMo30pffUTFhjK4ehVs005zFP/yiu7+4hFAhe
 42i+EpnLTR79kMt81Y1VIbehXzKDMmWSUw1eisfuCKDP2a45+nGUrCvEFCxzfpc9tBI8WD8koIe
 g+oKvFkWP5pk2KvbfX2YifCi1MNrBNPCXAJ6ioGQAtilPBro2DSTRzZCdsxu7OePgorfEOzD9zS
 JMMZlinYw/CSHFQvA8Pjv2PRM5Iy6CgbCv6adh+3KrJICJJyXiv/XVu9JFTsIUc82SYLdQfd
X-Proofpoint-ORIG-GUID: jk3wE9zMWV5e8Ei2JmR76n6maSbI4THW
X-Proofpoint-GUID: jk3wE9zMWV5e8Ei2JmR76n6maSbI4THW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507010052



On 6/30/2025 12:14 PM, Sarika Sharma wrote:
> Currently, the HTT_H2T_MSG_TYPE_PPDU_STATS_CFG request uses bits
> 8 to 15 as the bitmask for HTT_PPDU_STATS_CFG_PDEV_ID for firmware
> PPDU_STATS. However, bit 8 is reserved for SOC stats, and the actual
> PDEV ID should be encoded using bits 9 to 15. This leads to incorrect
> PDEV ID encoding in the request, causing it to either ignore the
> request or apply it to the wrong PDEV.
> 
> Additionally, pdev_mask calculation is done as
> pdev_mask = 1 << (i + 1); (i.e. i= num_rxmda_per_pdev)
> but this is not valid for multiple pdevs(multi-MAC configurations)
> with 1 rxdma per pdev, as this will mask the same value for all pdevs.
> To correctly identify each and exact MAC in multi-MAC configurations,
> the calculation should include ar->pdev_idx:
> pdev_mask = 1 << i + ar->pdev_idx;
> 
> Due to these issues, the firmware does not send PPDU_STATS for the
> intended PDEV, leading to inaccurate and incomplete statistics on the
> host. This might trigger certain WARN_ON() conditions in host that
> rely on these statistics.
> 
> Hence, change the bitmask for HTT_PPDU_STATS_CFG_PDEV_ID as bit 9
> to 15 to properly fill the pdev id in request message and change
> the pdev_mask calculation to consider ar->pdev_idx to mask pdev
> correctly.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

