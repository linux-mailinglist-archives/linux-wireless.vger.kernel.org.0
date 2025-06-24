Return-Path: <linux-wireless+bounces-24377-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 534B0AE598E
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 04:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E21AB1B67F0A
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 02:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BA67B3E1;
	Tue, 24 Jun 2025 02:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LAZm6Zyp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6088335942;
	Tue, 24 Jun 2025 02:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750731149; cv=none; b=Mb19iU5UG5U0Kjr/W7GVX8NELL0Sp22+DdWQPhXMO3NIP6nJ3uZduXti0ERDHFsep0Au6SpDbJQSOaJ7GZWHuquHuwQnTYp9oj2DXMz2dM9jmz2D161KzejYo6YUa1eyr71ENqu2BMruqlG2ke6zizWs4PINbJViBzjpH1RarY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750731149; c=relaxed/simple;
	bh=8666e0nanNGy42Jm4Q0zyb2v47frZuWLWSvTjdxZorQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZRdGoemjdJ5htIngIrNk2tlVPo+SG9jE0Brcu6jG69QLe5HX68n+R9m/I/QFt+C9py9c2iJ97XYEkEf+aXWbv1Ka0BiesAp3dHR/IA1Po7UaqKYY1uGUoU0VDc9z6+0WfA0IIHVnqZEEmnA2LDZouhSPCxSVBG1sKOO3eOTppBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LAZm6Zyp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55NKlEpK021903;
	Tue, 24 Jun 2025 02:11:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kQUdPPfct8mwW0ApkYrYtEC/iPMH8KqKsaWj3JKLFeo=; b=LAZm6ZypNY1a3TJS
	Gs5tAcq1HLlINcsIN1kg7UJdYN3KW0yvbDubrlxpdT8vo4rWTFb65NrnPnfEe1T9
	J5uPAnUCCF1XnuwWdlH0Rn/m5onqbezlQe4u5OOwoOJfUuAKeNGMJT4l7gZ+bo7/
	ixZzMda2WA8LfGw2d4nCq2UFyU8Z0EJWbExfg911xzYs4cQSO36oHOW4ln/oDnof
	2k6oErEuWMGem+C2zW2Z06Mn/L1iBHLjJNNCP+Yt8qXFSZS706YWUPtJ8a6iQXfV
	P5uElwYTRBPgb9eYyUSF3EUa7iYRyWY+5t9ROya4RJQ39MCTBBLVQJnhOPqHAX+W
	IIA+aw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47f3bgah76-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Jun 2025 02:11:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55O2BiPH010778
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Jun 2025 02:11:44 GMT
Received: from [10.239.28.106] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 23 Jun
 2025 19:11:42 -0700
Message-ID: <5b77ff7e-13c9-4083-9273-b8d3050e5116@quicinc.com>
Date: Tue, 24 Jun 2025 10:11:29 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v3 5/6] wifi: ath11k: choose default PM policy
 for hibernation
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Johannes Berg
	<johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath11k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>,
        Bjorn Andersson
	<bjorn.andersson@oss.qualcomm.com>,
        Johan Hovold <johan+linaro@kernel.org>
References: <20250328-ath11k-bring-hibernation-back-v3-0-23405ae23431@quicinc.com>
 <20250328-ath11k-bring-hibernation-back-v3-5-23405ae23431@quicinc.com>
 <d0cd065c-1cd1-4e56-8c57-60777b1f3664@oss.qualcomm.com>
 <51da74b0-d8d3-4520-9fc9-06b50b552bb2@quicinc.com>
 <08a310dd-6982-4e63-9f6a-02bd9d579167@oss.qualcomm.com>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <08a310dd-6982-4e63-9f6a-02bd9d579167@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: FCtXXJNbWgFx4ZC3Tl9VxloQmdkGSe01
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDAxNyBTYWx0ZWRfX5Lqu7XEkkwHs
 naANXP7YJGSGmLElZ2izECRr4TRKngSbTDdSLnPFrlGzIz+g2vrB76GWT7fFdWotkYWVbgAH83V
 0N/6bdC+RBR7E4flDMwXnC2Mh+44PONSjBbqZYHTtxEW8z8LLo63KTVMbnNCVjPHreMyQLmDNg1
 fN+owkJAsZv2HcMFlMddv/mPUB9Emqr9/3nh1tsamuwzcfLAZaRWkycMcfRwskcyjawakwh2KQB
 8XaIXRCoZwqQrdx3kzrl5x/6jOWWJ258x5E2LvJyjGu1Ii1ePF+1tMtVJzXdYoAHiSBtImFR6vB
 Ms21U8YW1QQ84qg1yCtHJ6XgQBR2wkDJwGq8dgJV5yTAYLQ/tCXDD57bPHzTicMVe4hPWPKZ2Hk
 y4outvOGjNAq4UhqlLzDm0YRG5lE638/U2b2dipOwdDVWXTmDDixodoffZ0Xns+a79boQfSV
X-Authority-Analysis: v=2.4 cv=L4kdQ/T8 c=1 sm=1 tr=0 ts=685a0961 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8
 a=COk6AnOGAAAA:8 a=FTT0Ydu4DhEltKgSIdUA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: FCtXXJNbWgFx4ZC3Tl9VxloQmdkGSe01
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_01,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 bulkscore=0 clxscore=1015 suspectscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 phishscore=0 mlxlogscore=889 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506240017



On 6/23/2025 7:30 PM, Konrad Dybcio wrote:
> On 6/18/25 4:00 AM, Baochen Qiang wrote:
>>
>> On 6/18/2025 8:15 AM, Konrad Dybcio wrote:
>>> On 3/28/25 6:32 AM, Baochen Qiang wrote:
>>>> Now WoWLAN mode is chosen for those machines listed in the quirk table.
>>>> This works for suspend (S3) but breaks for hibernation (S4), because
>>>> WoWLAN mode requires WLAN power to be sustained, which is not the case
>>>> during hibernation. For hibernation, the default mode should be used.
>>>>
>>>> Register a PM notifier with which kernel can notify us of the actual PM
>>>> operation: if system is going to suspend, the original PM policy is
>>>> honored; while if it is hibernation, overwrite it with default policy.
>>>>
>>>> To summarize: for suspend (S3), WoWLAN mode is chosen for machines listed
>>>> in the quirk table, non-WoWLAN mode for others; for hibernation (S4),
>>>> non-WoWLAN mode is chosen for all.
>>>>
>>>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
>>>>
>>>> Tested-by: Takashi Iwai <tiwai@suse.de>
>>>> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
>>>> ---
> [...]
> 
>> Could you share complete kernel dmesg log?
> There's nothing interesting in it, but sure..
> 
> [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd4b0]
> [    0.000000] Linux version 6.16.0-rc3-next-20250623 (konrad@archlinux) (clang version 20.1.6, LLD 20.1.6) #12182 SMP Mon Jun 23 13:27:07 CEST 2025
> [    0.000000] KASLR enabled
> [    0.000000] Machine model: Qualcomm SC8280XP CRD

[...]

> [    7.669494] mhi mhi0: Direct firmware load for ath11k/WCN6855/hw2.0/amss.bin failed
with error -2

Thanks, this helps understand the issue.

And BTW, WLAN firmware is missing in your setup, you may get them from linux firmware repo
to avoid this issue.

https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git





