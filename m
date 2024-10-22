Return-Path: <linux-wireless+bounces-14308-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 923DD9A9FCE
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 12:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 241D5283DE3
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 10:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F39F19994B;
	Tue, 22 Oct 2024 10:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nXcnw76O"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A071F18E02D;
	Tue, 22 Oct 2024 10:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729592478; cv=none; b=fKtJiP/wdtUBYfR+rX6alcFxskPuCSF9fY6hoP21/4AVggVMn5f2L8YqF3LP+QNYho3nPQMwpL/7tLVleQz+vSV1yY9pLxFMQDCWsqA8voRebUwUPZHox7MrkNBVSlcrQFpSYsrUaj6XSf/OPVKEMCjBKpPDb/OrKDkcKuqStHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729592478; c=relaxed/simple;
	bh=H/OQLMP1D3Pzj6veo2hkf4Mks7xnJVi14u2jVIBrjuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qVMZ/4Xz/ifPkxV0bKxTWMpDUdSzVNE5G/zepuCAGJEYabCu17nhpT87TvwmCGoYbV4bwvEeTGhMR8Hx/9ULtdGDui0zyi0FftEtvtpVJDvGsjoZ/XREP47K72TpEAuCPi5fJy8NaNuA6KsK6+fpI69mL7J8LpZhrXbrMM/6WAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nXcnw76O; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49M8rwPu029542;
	Tue, 22 Oct 2024 10:20:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	N+s6AQopGnxwcBNHC7PWJg7SZl5oszgpZ1Oj13OA6Es=; b=nXcnw76OAD9D9zCC
	lZmabVRP2PFvS4nXp3K+TRdePhwI1PZbfGbsqU0nLMIKMo4MLfaO/4RaTcHY7lhY
	XYuVOocnS1c9oWMz0BH75+HNr8AYyp6XMvVpD6NawuR3uuqtcC6JtbLFciquw0Uh
	u5Gnnju8ApTKBevv4CWChXTmUsPHvK89VuqluG/xALP1456VYxZSaPYaCWYHugpC
	DK6qcQNrHOoPdTXwQMv6EcpLGxMH+2vKmAPuNMa98maUEif2xDE18+ioAJx9VBF+
	DdzkPH/olh7IHPcgJexjNuoIn/GQs5cM6ZLWh3b3iCp23RFzE/G+ClFITPdHmyo/
	U6KFJA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42c6vc7y3t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 10:20:56 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49MAKtVM014405
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 10:20:55 GMT
Received: from [10.253.13.77] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 22 Oct
 2024 03:20:53 -0700
Message-ID: <1c5f5c93-db06-4490-af2e-bbce2d184c94@quicinc.com>
Date: Tue, 22 Oct 2024 18:20:50 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] wifi: ath11k: add firmware-name device tree property
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <kvalo@kernel.org>, <quic_jjohnson@quicinc.com>,
        <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241001033053.2084360-1-quic_miaoqing@quicinc.com>
 <20241001033053.2084360-3-quic_miaoqing@quicinc.com>
 <smgbishqbin4kcpshqvue3ivvfko2l6rj2w4ikwydosbkq6kde@pdbzhklj7znm>
Content-Language: en-US
From: Miaoqing Pan <quic_miaoqing@quicinc.com>
In-Reply-To: <smgbishqbin4kcpshqvue3ivvfko2l6rj2w4ikwydosbkq6kde@pdbzhklj7znm>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ookBtTEFOklfLVemqbibubzxo3qtZxKi
X-Proofpoint-ORIG-GUID: ookBtTEFOklfLVemqbibubzxo3qtZxKi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 phishscore=0 bulkscore=0 mlxscore=0 adultscore=0
 mlxlogscore=860 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410220066



On 10/22/2024 5:57 PM, Dmitry Baryshkov wrote:
> On Tue, Oct 01, 2024 at 11:30:52AM +0800, Miaoqing Pan wrote:
>> QCA6698AQ uses different firmware/bdf/regdb with existing WCN6855
>> firmware, which is customized for IoE platforms. And the 'pci-device-id +
>> soc-hw-version + soc-hw-sub-version' may not be enough to identify the
>> correct firmware directory path.
> 
> Why is it so? What makes it so different from the existing platforms
> that you can not use WCN6855 firmware?

Just as I said, a new customized firmware for IoE devices.

> 
>>
>> The device tree allows "firmware-name" to define the firmware path,
>>      wifi@c000000 {
> 
> You are describing platform node, while the commit message talks about
> the PCIe devices. Could you please clarify, whether it is a PCIe device
> or an AHB device?

PCIe device. The change is for sa8775p/qcs8300 those non-AHB boards.

> 
>>          firmware-name = "QCA6698AQ";
> 
> Could we please follow the approach that has been defined in the commit
> 5abf259772df ("wifi: ath10k: support board-specific firmware
> overrides")? In other words, instead of creating another directory under
> ath11k, create a subdir under the WCN6855/hwN.M/ which contains your
> device-specific data.

Sure, thanks, will update.

> 
>>          status = "okay";
>>      };
>>
>> Tested-on: QCA6698AQ hw2.1 PCI WLAN.HSP.1.1-04402-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1
>>
>> Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
> 
> P.S. please CC linux-arm-msm for future respins of this series or for
> all other submissions that concern board-specific DT data on MSM
> platforms.

ok.

> 
>> ---
>>   drivers/net/wireless/ath/ath11k/core.c | 12 ++++++++++++
>>   drivers/net/wireless/ath/ath11k/core.h | 11 +++--------
>>   2 files changed, 15 insertions(+), 8 deletions(-)
>>
> 


