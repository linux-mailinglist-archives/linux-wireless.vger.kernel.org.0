Return-Path: <linux-wireless+bounces-24042-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DBAAD6A30
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 10:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C8B817BB09
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 08:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA01226CF1;
	Thu, 12 Jun 2025 08:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gPPI86LD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D46F225A37;
	Thu, 12 Jun 2025 08:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749716096; cv=none; b=HkXmS9KvvrxpFJd81fMNcLXi1tBhnB+1AMQu0QsLYERGXuJyijePo0SBCD2caBkt2LSHmuUINmDeRNizEkvkkm3N5PlvQe+NhPjiBbub+tj2k/IhnDkNeSjWFUqh4RcivoJFNIWHU+aIIX8r3AiRleT1PPo+KgQ61HalsiAgvMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749716096; c=relaxed/simple;
	bh=CSCzDg77pjTCT23c+61nq16hO8ePvStoc3+J9Y/Niv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MHxH+fSDaT+7V344k5d6xl4orxY87dzS9LCYLRKLRQvTB9y9D6Quq3irqQ+lThEszvo3VRPFsuoSe/Qj5MR+a5KcrfNhRk/WUFcin1/UH3EtDIzahzVSDJZxzydjCjnFo0rBUHVNAckVsxL/ZcAeZfFWvWHQTHKeEPJYaltGAKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gPPI86LD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55BKKDcl014570;
	Thu, 12 Jun 2025 08:14:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	i1DsMF9bQe1fAE3hp7+oZe/bYHD5wUMyAR5wN2oIKBs=; b=gPPI86LDk1D1YPez
	43lrG+wGHMkro8X5iH85XqQNyEIogJgjsScDlv751lplAhPux3uA9v6JRF3chzbd
	uegKXjjvhQTsjCF5GkhCeSTlV6mHlNBUpkXLW23++tr264VwdKGFyzSOjN8al9cF
	l17McFSQA/BXwQHsIfS4lvAzFJ0d5Tp30SO31JH9mwlmAGAupnyH+rIB8nX3RIW6
	tZo2Lr5utlAAemKDPyyvnepr2F53BgH3QOd2TAjx374OW9RejM9iFNpc2qcTHDlV
	3y9DYdiURJ8Rvr0/3W3buz/IFSHtariv2PD9C8RzOUms3scz4BGfQRF2ZKPaJtkv
	YF3IbQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 476fmnfcra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 08:14:46 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55C8Ek89020510
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 08:14:46 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 12 Jun
 2025 01:14:44 -0700
Message-ID: <d48a228a-5f48-4732-b12d-78f03541ae9e@quicinc.com>
Date: Thu, 12 Jun 2025 16:14:41 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] wifi: ath11k: mark reset srng lists as uninitialized
To: Sergey Senozhatsky <senozhatsky@chromium.org>
CC: Jeff Johnson <jjohnson@kernel.org>, <linux-wireless@vger.kernel.org>,
        <ath11k@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250529035708.3136232-1-senozhatsky@chromium.org>
 <5857380e-ced9-4118-b9a0-ce926b25c11c@quicinc.com>
 <rxaibpgtf37w3th5lnt3w574w443yononqjoglyfktlcxe26qg@jpmtkckrotzp>
 <2f77045c-6763-4fc4-bf09-50fd9b76a394@quicinc.com>
 <xr3n5pbohquhaloonctfqvpb2r3eu6fi5jly7ms4pgcotqmqzh@msrgbaawafsj>
 <ce3c0e51-4df0-4164-adcd-e98f2edee454@quicinc.com>
 <qqhs2mzhg6mgq23wej5a65iau4ysfjh2raakcsvwc4fuqtpwk2@4ouqfld6mrnd>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <qqhs2mzhg6mgq23wej5a65iau4ysfjh2raakcsvwc4fuqtpwk2@4ouqfld6mrnd>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: luLERCugnvn7yL8ZQMCwbINdR597sg8r
X-Proofpoint-GUID: luLERCugnvn7yL8ZQMCwbINdR597sg8r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDA2MyBTYWx0ZWRfX6pifoiT+9CGa
 DTzafXBl6EljcqN0eeWBTbSwZsEHhTKqsMd9m4f/IVgScTUGN/c/u+RsnO/8LK6ERZVbNBRUP+c
 SmMeETLvWzHZuJ9ZI0ooJaEZhQHF6FmeKk44j1b7b98HuMDEAmOAwl9ajcsLfRJ197slIVB67u1
 R0JcRLbr2kzcnCOLpRlKWw+jjspQs5P1nmT3pfpF3+cWGoeTuofVaCHsjyyrrZ2+d+hCrQa6TQy
 NyxsHL7uHYsH4CIgQPTkvG2niSbBwg2wV2G1WHWfEBVAVipMLLotOdlfrelzPnuMZVewZtihJN1
 b6Oc2bLevc90X5VVbRLlC24z92mQKkCAJ5CzCR1IVPDAV0K3QikeutUL7KaN/Ki4iwPhDCHG3wA
 qVYxDU7Hv1fM6Ut/5YAo8BVJM9hzYP/G3mLkQwctpylVrITMnINzx/pZ21xvFCAbd8bYZaf2
X-Authority-Analysis: v=2.4 cv=K8wiHzWI c=1 sm=1 tr=0 ts=684a8c76 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10
 a=PQx6h1c_D4Aj2YnHI-0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_05,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506120063



On 6/12/2025 4:00 PM, Sergey Senozhatsky wrote:
> On (25/06/12 15:49), Baochen Qiang wrote:
>>> My understanding is that the driver first fails to reconfigure
>>>
>>> <4>[163874.555825] ath11k_pci 0000:01:00.0: already resetting count 2
>>> <4>[163884.606490] ath11k_pci 0000:01:00.0: failed to wait wlan mode request (mode 4): -110
>>> <4>[163884.606508] ath11k_pci 0000:01:00.0: qmi failed to send wlan mode off: -110
>>> <3>[163884.606550] ath11k_pci 0000:01:00.0: failed to reconfigure driver on crash recovery
>>>
>>> so ath11k_core_reconfigure_on_crash() calls ath11k_hal_srng_deinit(),
>>> which destroys the srng lists, but leaves the stale initialized flag.
>>> So next time ath11k_hal_dump_srng_stats() is called everything looks ok,
>>> but in fact everything is not quite ok.
>>
>> OK, we have a second crash while the first crash is still in recovering. And guess the
>> first recovery fails such that srng is not reinitialized. Then after a
>> wait-for-first-recovery time out, the second recovery starts, this results in
>> ath11k_hal_dump_srng_stats() getting called and hence the kernel crash.
>>
>> Could you please share complete verbose kernel log? you may enable it with
>>
>> 	modprobe ath11k debug_mask=0xffffffff
>> 	modprobe ath11k_pci
> 
> Unfortunately I don't have a reproducer.  We just see that some of the
> consumer devices crash on resume and all we get is ramoops.  We can't
> do any debugging on consumer devices.

no worry, below log is enough.

> 
> This is all I have:
> 
> <3>[23518.302240] Last interrupt received for each group:
> <3>[23518.302243] ath11k_pci 0000:01:00.0: group_id 0 22511ms before
> <3>[23518.302246] ath11k_pci 0000:01:00.0: group_id 1 14440788ms before
> <3>[23518.302248] ath11k_pci 0000:01:00.0: group_id 2 14440788ms before
> <3>[23518.302250] ath11k_pci 0000:01:00.0: group_id 3 14440788ms before
> <3>[23518.302252] ath11k_pci 0000:01:00.0: group_id 4 14736571ms before
> <3>[23518.302253] ath11k_pci 0000:01:00.0: group_id 5 14736571ms before
> <3>[23518.302261] ath11k_pci 0000:01:00.0: group_id 6 14440789ms before
> <3>[23518.302263] ath11k_pci 0000:01:00.0: group_id 7 22541ms before
> <3>[23518.302265] ath11k_pci 0000:01:00.0: group_id 8 24724ms before
> <3>[23518.302266] ath11k_pci 0000:01:00.0: group_id 9 23315ms before
> <3>[23518.302268] ath11k_pci 0000:01:00.0: group_id 10 25238ms before
> <3>[23518.302270] ath11k_pci 0000:01:00.0: dst srng id 0 tp 5312, cur hp 5312, cached hp 5312 last hp 5312 napi processed before 22541ms
> <3>[23518.302272] ath11k_pci 0000:01:00.0: dst srng id 1 tp 27664, cur hp 27664, cached hp 27664 last hp 27664 napi processed before 24724ms
> <3>[23518.302274] ath11k_pci 0000:01:00.0: dst srng id 2 tp 12432, cur hp 12432, cached hp 12432 last hp 12432 napi processed before 23315ms
> <3>[23518.302276] ath11k_pci 0000:01:00.0: dst srng id 3 tp 1424, cur hp 1424, cached hp 1424 last hp 1424 napi processed before 25238ms
> <3>[23518.302278] ath11k_pci 0000:01:00.0: dst srng id 4 tp 0, cur hp 0, cached hp 0 last hp 0 napi processed before 22512ms
> <3>[23518.302280] ath11k_pci 0000:01:00.0: src srng id 5 hp 0, reap_hp 248, cur tp 0, cached tp 0 last tp 0 napi processed before 14440789ms
> <3>[23518.302282] ath11k_pci 0000:01:00.0: src srng id 8 hp 950, reap_hp 950, cur tp 950, cached tp 280 last tp 280 napi processed before 22512ms
> <3>[23518.302284] ath11k_pci 0000:01:00.0: dst srng id 9 tp 19526, cur hp 19526, cached hp 19526 last hp 19526 napi processed before 22512ms
> <3>[23518.302286] ath11k_pci 0000:01:00.0: src srng id 16 hp 3832, reap_hp 3832, cur tp 3832, cached tp 3824 last tp 3824 napi processed before 22758ms
> <3>[23518.302288] ath11k_pci 0000:01:00.0: src srng id 24 hp 0, reap_hp 248, cur tp 0, cached tp 0 last tp 0 napi processed before 14440789ms
> <3>[23518.302290] ath11k_pci 0000:01:00.0: dst srng id 25 tp 0, cur hp 0, cached hp 0 last hp 0 napi processed before 14440789ms
> <3>[23518.302292] ath11k_pci 0000:01:00.0: src srng id 32 hp 12, reap_hp 8, cur tp 12, cached tp 12 last tp 8 napi processed before 14736834ms
> <3>[23518.302294] ath11k_pci 0000:01:00.0: src srng id 35 hp 96, reap_hp 88, cur tp 92, cached tp 92 last tp 92 napi processed before 21573ms
> <3>[23518.302296] ath11k_pci 0000:01:00.0: src srng id 36 hp 176, reap_hp 164, cur tp 176, cached tp 168 last tp 168 napi processed before 22447ms
> <3>[23518.302298] ath11k_pci 0000:01:00.0: src srng id 39 hp 0, reap_hp 124, cur tp 0, cached tp 0 last tp 0 napi processed before 14440789ms
> <3>[23518.302300] ath11k_pci 0000:01:00.0: src srng id 57 hp 54, reap_hp 54, cur tp 58, cached tp 58 last tp 58 napi processed before 22485ms
> <3>[23518.302302] ath11k_pci 0000:01:00.0: src srng id 58 hp 584, reap_hp 584, cur tp 588, cached tp 588 last tp 588 napi processed before 22429ms
> <3>[23518.302304] ath11k_pci 0000:01:00.0: src srng id 61 hp 1020, reap_hp 1020, cur tp 0, cached tp 0 last tp 0 napi processed before 14736834ms
> <3>[23518.302306] ath11k_pci 0000:01:00.0: dst srng id 81 tp 116, cur hp 116, cached hp 116 last hp 116 napi processed before 22485ms
> <3>[23518.302308] ath11k_pci 0000:01:00.0: dst srng id 82 tp 1176, cur hp 1176, cached hp 1176 last hp 1176 napi processed before 22429ms
> <3>[23518.302309] ath11k_pci 0000:01:00.0: dst srng id 85 tp 0, cur hp 0, cached hp 0 last hp 0 napi processed before 14440789ms
> <3>[23518.302311] ath11k_pci 0000:01:00.0: src srng id 104 hp 65532, reap_hp 65532, cur tp 0, cached tp 0 last tp 0 napi processed before 14736836ms
> <3>[23518.302313] ath11k_pci 0000:01:00.0: src srng id 105 hp 0, reap_hp 504, cur tp 0, cached tp 0 last tp 0 napi processed before 14440789ms
> <3>[23518.302315] ath11k_pci 0000:01:00.0: dst srng id 106 tp 245496, cur hp 245496, cached hp 245496 last hp 245496 napi processed before 22512ms
> <3>[23518.302317] ath11k_pci 0000:01:00.0: dst srng id 109 tp 5704, cur hp 5704, cached hp 5704 last hp 5704 napi processed before 22512ms
> <3>[23518.302319] ath11k_pci 0000:01:00.0: src srng id 128 hp 3182, reap_hp 3182, cur tp 7428, cached tp 7428 last tp 7428 napi processed before 22541ms
> <3>[23518.302321] ath11k_pci 0000:01:00.0: src srng id 129 hp 0, reap_hp 2046, cur tp 0, cached tp 0 last tp 0 napi processed before 14440789ms
> <3>[23518.302323] ath11k_pci 0000:01:00.0: src srng id 132 hp 1690, reap_hp 1690, cur tp 1692, cached tp 1692 last tp 1692 napi processed before 22429ms
> <3>[23518.302324] ath11k_pci 0000:01:00.0: dst srng id 133 tp 0, cur hp 0, cached hp 0 last hp 0 napi processed before 22512ms
> <3>[23518.302326] ath11k_pci 0000:01:00.0: src srng id 144 hp 0, reap_hp 2046, cur tp 0, cached tp 0 last tp 0 napi processed before 14440789ms
> <3>[23518.302328] ath11k_pci 0000:01:00.0: src srng id 147 hp 1948, reap_hp 1948, cur tp 1950, cached tp 1950 last tp 1950 napi processed before 22429ms
> <3>[23518.302330] ath11k_pci 0000:01:00.0: dst srng id 148 tp 0, cur hp 0, cached hp 0 last hp 0 napi processed before 14440789ms
> <4>[23519.369310] ath11k_pci 0000:01:00.0: failed to receive control response completion, polling..
> <3>[23520.393292] ath11k_pci 0000:01:00.0: Service connect timeout
> <3>[23520.393302] ath11k_pci 0000:01:00.0: failed to connect to HTT: -110
> <3>[23520.394087] ath11k_pci 0000:01:00.0: failed to start core: -110
> <4>[23520.710478] ath11k_pci 0000:01:00.0: firmware crashed: MHI_CB_EE_RDDM
> <4>[23520.710550] ath11k_pci 0000:01:00.0: already resetting count 2
> <4>[23530.761544] ath11k_pci 0000:01:00.0: failed to wait wlan mode request (mode 4): -110
> <4>[23530.761562] ath11k_pci 0000:01:00.0: qmi failed to send wlan mode off: -110
> <3>[23530.761595] ath11k_pci 0000:01:00.0: failed to reconfigure driver on crash recovery
> <6>[23561.813605] mhi mhi0: Requested to power ON
> <6>[23561.813627] mhi mhi0: Power on setup success
> <6>[23561.899318] mhi mhi0: Wait for device to enter SBL or Mission mode
> <6>[23562.530990] ath11k_pci 0000:01:00.0: chip_id 0x12 chip_family 0xb board_id 0xff soc_id 0x400c1211
> <6>[23562.531010] ath11k_pci 0000:01:00.0: fw_version 0x11088c35 fw_build_timestamp 2024-04-17 08:34 fw_build_id WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41
> <3>[23562.575723] ath11k_pci 0000:01:00.0: Last interrupt received for each CE:
> <3>[23562.575742] ath11k_pci 0000:01:00.0: CE_id 0 pipe_num 0 14781107ms before
> <3>[23562.575751] ath11k_pci 0000:01:00.0: CE_id 1 pipe_num 1 66758ms before
> <3>[23562.575756] ath11k_pci 0000:01:00.0: CE_id 2 pipe_num 2 66702ms before
> <3>[23562.575759] ath11k_pci 0000:01:00.0: CE_id 3 pipe_num 3 66720ms before
> <3>[23562.575763] ath11k_pci 0000:01:00.0: CE_id 5 pipe_num 5 14485062ms before
> <3>[23562.575766] ath11k_pci 0000:01:00.0: CE_id 7 pipe_num 7 14485062ms before
> <3>[23562.575770] ath11k_pci 0000:01:00.0: CE_id 8 pipe_num 8 14485062ms before
> <3>[23562.575773] ath11k_pci 0000:01:00.0:
> <3>[23562.575773] Last interrupt received for each group:
> <3>[23562.575778] ath11k_pci 0000:01:00.0: group_id 0 66785ms before
> <3>[23562.575781] ath11k_pci 0000:01:00.0: group_id 1 14485062ms before
> <3>[23562.575785] ath11k_pci 0000:01:00.0: group_id 2 14485062ms before
> <3>[23562.575788] ath11k_pci 0000:01:00.0: group_id 3 14485062ms before
> <3>[23562.575791] ath11k_pci 0000:01:00.0: group_id 4 14780845ms before
> <3>[23562.575795] ath11k_pci 0000:01:00.0: group_id 5 14780845ms before
> <3>[23562.575798] ath11k_pci 0000:01:00.0: group_id 6 14485062ms before
> <3>[23562.575801] ath11k_pci 0000:01:00.0: group_id 7 66814ms before
> <3>[23562.575805] ath11k_pci 0000:01:00.0: group_id 8 68997ms before
> <3>[23562.575808] ath11k_pci 0000:01:00.0: group_id 9 67588ms before
> <3>[23562.575812] ath11k_pci 0000:01:00.0: group_id 10 69511ms before
> <1>[23562.575828] BUG: unable to handle page fault for address: ffffa007404eb010
> <1>[23562.575833] #PF: supervisor read access in kernel mode
> <1>[23562.575837] #PF: error_code(0x0000) - not-present page
> <6>[23562.575842] PGD 100000067 P4D 100000067 PUD 10022d067 PMD 100b01067 PTE 0
> <4>[23562.575852] Oops: 0000 [#1] PREEMPT SMP NOPTI
> <4>[23562.575873] Workqueue: ath11k_qmi_driver_event ath11k_qmi_driver_event_work [ath11k]
> <4>[23562.575896] RIP: 0010:ath11k_hal_dump_srng_stats+0x2b4/0x3b0 [ath11k]
> <4>[23562.575916] Code: 6b c0 44 89 f2 89 c1 e8 4a 14 06 00 41 be e8 25 00 00 eb 6e 42 0f b6 84 33 78 ff ff ff 89 45 d0 46 8b 7c 33 d8 4a 8b 44 33 e0 <44> 8b 20 46 8b 6c 33 e8 42 8b 04 33 48 89 45 c8 48 8b 3d 45 93 fd
> <4>[23562.575922] RSP: 0018:ffffa00759ed3c50 EFLAGS: 00010246
> <4>[23562.575926] RAX: ffffa007404eb010 RBX: ffff9eab4ea60000 RCX: 382d128991c49600
> <4>[23562.575930] RDX: 00000000ffffffea RSI: ffffa00759ed3998 RDI: ffff9eac66017488
> <4>[23562.575934] RBP: ffffa00759ed3c90 R08: ffffffffbd649d80 R09: 0000000000005ffd
> <4>[23562.575937] R10: 0000000000000004 R11: 00000000ffffdfff R12: ffff9eab4ea61c90
> <4>[23562.575941] R13: ffff9eab4ea60000 R14: 0000000000002828 R15: 0000000000000000
> <4>[23562.575945] FS: 0000000000000000(0000) GS:ffff9eac66000000(0000) knlGS:0000000000000000
> <4>[23562.575949] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> <4>[23562.575953] CR2: ffffa007404eb010 CR3: 0000000136e24000 CR4: 0000000000750ee0
> <4>[23562.575956] PKRU: 55555554
> <4>[23562.575959] Call Trace:
> <4>[23562.575965] <TASK>
> <4>[23562.575978] ? __die_body+0xae/0xb0
> <4>[23562.575987] ? page_fault_oops+0x381/0x3e0
> <4>[23562.575995] ? exc_page_fault+0x69/0xa0
> <4>[23562.576003] ? asm_exc_page_fault+0x22/0x30
> <4>[23562.576015] ? ath11k_hal_dump_srng_stats+0x2b4/0x3b0 [ath11k (HASH:6cea 4)]
> <4>[23562.576034] ath11k_qmi_driver_event_work+0xbd/0x1050 [ath11k (HASH:6cea 4)]
> <4>[23562.576058] worker_thread+0x389/0x930
> <4>[23562.576065] kthread+0x149/0x170
> <4>[23562.576074] ? start_flush_work+0x130/0x130
> <4>[23562.576078] ? kthread_associate_blkcg+0xb0/0xb0
> <4>[23562.576084] ret_from_fork+0x3b/0x50
> <4>[23562.576090] ? kthread_associate_blkcg+0xb0/0xb0
> <4>[23562.576096] ret_from_fork_asm+0x11/0x20
> 
> 
> There are clearly two ath11k_hal_dump_srng_stats() calls, the first
> one happens before crash recovery, the second happens right after
> and presumably causes UAF, because ->initialized flag is not cleared.

So with above we can confirm our guess.

Could you refine your commit message with these details such that readers have a clear
understanding of this issue?



