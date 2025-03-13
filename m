Return-Path: <linux-wireless+bounces-20358-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44128A60639
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Mar 2025 00:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 937D13B762A
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 23:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518331F560E;
	Thu, 13 Mar 2025 23:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RPjRJhj4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61165CB8
	for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 23:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741910015; cv=none; b=d8zlobahWXVZCO8IP4CmljmNrvyyXcoHEpWTXl6I/kdGRRBI3rHkVA+GSWJAXzR6D8FaQ0YxQVAYIX2cFZKvm/dXY3FMvAe5Y908z8v37fN5ienc7kASxWF3Su7rnEA64Uz1IxjRVNdQ5MB5pJ1MeavpnaBiycwORnyo4rt32i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741910015; c=relaxed/simple;
	bh=/WF7lCXlqMJQXcnRe/Nj0OUVnpD4zUFuEEAmeWVowgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FNVwTx66RJU9a9/LovPAUkn0C6SQpPsVKnH9e70YOEO5av2feB1l89Vw8036Fu+TZcojhqubrsMGpV4VJHS5YAbIljXVxCzG/WgZAORRPIFkYSwSA6E26YQo6PKd38BXIBlSijV3G65/4RvTQKlo+akakPlYMiMeNHNPu5p5tBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RPjRJhj4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DKiG3f018487
	for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 23:53:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	c1qHYlOfwaIa9F8NhGAepXYgOg3iVgKToWFIujHQr7Q=; b=RPjRJhj4i13DyISw
	zz5+4A/xR1gTJnoZrUKDpkGEAz1a929GrLPfOG0t5ajBs96ENsHjpaf/VtV9oCFj
	PjL2OKh0GXkehenNDE1/GbfhF6g8VqEd2n52DYKuajcz7WB/1MZpCRijGgLJtgtE
	sDiMD9iBrwj7cRVmGIx/Fx7QeKTjgmGlDRPSX/mDXnK9UZjPCIo6azdhpPNW+fXt
	C/PNF5GvyskW5GF82kpXmp6F0CDr61bZr1B9TAU3GhHvop4tIKmqiFrDMllI81PU
	xPxi2ywG+JJgOwJj+emdaZynXNzPokFVcuK+8LZflrQq89dHio+eZYbNu3/P1Zcb
	5jKXOA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au2nyhgy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 23:53:32 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2241ae15dcbso31038345ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 16:53:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741910011; x=1742514811;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c1qHYlOfwaIa9F8NhGAepXYgOg3iVgKToWFIujHQr7Q=;
        b=NLhxB78tcLGV0POgFKq5MyUyok4iyJn/ZCLQlDYzXHeQBiC+59SjN0y0UgILkxjb/K
         eDHNYDdyRhvUcgcfyai4qpLYX7CSGyuTX5WNpdNwJ6XxAv94xKJjVQCc0UD0/tosaJ4E
         n2UCBqXHJJJvMjTKC0OMaM6wpVJdudoneLT0inzJ9FaL3ZkeOOg9YiMijHEssgGan4D2
         ZChh3m7YC5LX29lqEV7Qk2FwaN251/eFdBJlsULWLTk92aWqVho33bYqwmIA9WXJNuHh
         ljT6YvGtzl+PhkeFXmJbQ72vc64cskqVkyPvRX2YwMtl7RXu1rIf3ujey7XfyHoiD6Xe
         JiKw==
X-Forwarded-Encrypted: i=1; AJvYcCVSUbtVXsvzu+CsxsgpWH1qgU81J1Dh5y6e1YGa8ogRkfVgqGuI4eQzxxFNZ11jkaUCjsrTT4Zkia62jdXzEg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxMFahdj+lewN9YPgnJYiY1muM6YTKaFXXqzgf1Yuo8dcfrcdGC
	l/LQKAVZ6EVR9R3Ym/QZIw8UMup8FS3KxKpbTrJK4t/1N7YPt2Uu2QdL9F3RhBrHI5EpTYEFyIM
	IepUxkE5zjnuKKAIClqGRJUD5/9u7aspVXP8aMWALQj3FR+jKDU4Dy+TzNOADy9GJuA==
X-Gm-Gg: ASbGncsSAYjQwDpMSVepTn7z4nDKvUpCksZdGMn6jAPr+V21Xi0qfBrX1MNHuAd9PtS
	BjP25avqevQobdME6wpLQWIjN1R2vo9w10wH7dVSWrwuSiSFEkuXpEej5i2N0d19gmj32CkCDuo
	+A3GUXWKy5A8egfyfv4tDxQ+UWLOjML98ULWomjA9OvlQUxsUyCMaJffZ3qT9b+ZviDqeiWNuar
	WsLVusCGVxPuZomL1dnD19h+nyFCKPapjBTfY5PvWB/SgSpvZDZRO92QSSC5AScDPzV+iECxCbo
	+Jj5135SGxGdSdbxWO+DZ+i9fNxFwMBbyUcmq0yNITT+8Gf9kRA4X/CxswLjKGscMrIux0ualOP
	Hj/LEYkzV
X-Received: by 2002:a05:6a21:328e:b0:1f5:8e94:2e7f with SMTP id adf61e73a8af0-1f5c12c790dmr698727637.33.1741910011158;
        Thu, 13 Mar 2025 16:53:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHM6b+l2sHUOM4fapHzw2f4ilNzLLFqdXS3SQzF+UQWAtBtRNPOP8tJRZpq6HKBejspqZR3Cw==
X-Received: by 2002:a05:6a21:328e:b0:1f5:8e94:2e7f with SMTP id adf61e73a8af0-1f5c12c790dmr698706637.33.1741910010801;
        Thu, 13 Mar 2025 16:53:30 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56ea0428fsm1864011a12.38.2025.03.13.16.53.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 16:53:30 -0700 (PDT)
Message-ID: <06a86ae9-6537-4d48-82d9-60fb7e123054@oss.qualcomm.com>
Date: Thu, 13 Mar 2025 16:53:28 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/10] wifi: ath11k: add support for MHI bandwidth
 scaling
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        quic_pyarlaga@quicinc.com, quic_vbadigan@quicinc.com,
        quic_vpernami@quicinc.com, quic_mrana@quicinc.com,
        Miaoqing Pan <quic_miaoqing@quicinc.com>
References: <20250313-mhi_bw_up-v2-0-869ca32170bf@oss.qualcomm.com>
 <20250313-mhi_bw_up-v2-10-869ca32170bf@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250313-mhi_bw_up-v2-10-869ca32170bf@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 6e9ZMlHj87-Pf87uuJiVN9z5klQ3SBXE
X-Authority-Analysis: v=2.4 cv=Q4XS452a c=1 sm=1 tr=0 ts=67d36ffc cx=c_pps a=JL+w9abYAAE89/QcEU+0QA==:117 a=e70TP3dOR9hTogukJ0528Q==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=DXIUzMgivY99M8N_Z1sA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 6e9ZMlHj87-Pf87uuJiVN9z5klQ3SBXE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_10,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=826 adultscore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503130182

On 3/13/2025 4:40 AM, Krishna Chaitanya Chundru wrote:
> From: Miaoqing Pan <quic_miaoqing@quicinc.com>
> 
> Add support for MHI bandwidth scaling, which will reduce power consumption
> if WLAN operates with lower bandwidth. This feature is only enabled for
> QCA6390.
> 
> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-04546-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1

Tested-on is not an official tag but an ath.git-specific tag, so it should be
separated from the official tags by a blank line

> Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>

your S-O-B needs to be added

/jeff

