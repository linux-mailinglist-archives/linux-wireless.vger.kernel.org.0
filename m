Return-Path: <linux-wireless+bounces-22061-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDFEA9C421
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 11:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D59491BC0851
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 09:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191EF2367BB;
	Fri, 25 Apr 2025 09:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HltCvKoz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183E31F542E
	for <linux-wireless@vger.kernel.org>; Fri, 25 Apr 2025 09:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745574625; cv=none; b=WhDpCvtTlCiU1USLjxlwkk2Gmb389pX+pB18hAO1U34A6MWujdFq7jdGu7xs6cqYoC/o99eDg6OS+8VQ67CR/0PcKJFsf+uNkelMR6x1LmQZpP0tldTAk6+4ZT8S5hLpvvnRGPhmDkTsEfAgE3m7sn8wLYPcR0ImO8glZqGBr9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745574625; c=relaxed/simple;
	bh=yplk4VfClwHuj0/20QFrs8l4zYyI6nz5RzifJsuY+hg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AK7SKIJEzED/CRXBSVMh7atAy1dtYli+eEVRVof1puOe5m3dwXU4liVshHFcfQP6all+QLIno+AYXKvDF1d0fmLy9Z32IBk1Ic+1M6B0VFnFaihjSUZNalfccZswdhq36R6+Tb9+Ye7Dj/FU/jyKrDo4AJS393vb3WI2XO46SMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HltCvKoz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53P8TIT4015915;
	Fri, 25 Apr 2025 09:50:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YgrZOy1N7nemxGS32mJw6l2PCkczZjAlBgr99nOAv/Q=; b=HltCvKozkvrWlLdV
	Mw8MRfR5CQRonXhvchakFlrG/vIbjMenznqQbbre3JeOP0vcZRHol94f9oVavwdj
	MXw2KbYnuLv1U9nJlq2v1ZIMwYkxgS3EFdGr7SohT8f7Dv1FCr4a3QKuEEZTdxYX
	LeewQmaf4IksJbPX0EQf6yCpqkh10aawvciuDGCWVXhlvl3yne5NCUCLxfv723/M
	AXrT8QXVS4Vr9BDXXkY0pjI4J3FChlzQPVDePkuGoNn3hgcSHKeltArgXp/8Pc67
	uG8AhfpDiT2wycG3oUtBDb4YJ6PxIBoqzpROxfNpPI1+kH3jvrL8p4Iu6rvbXTm/
	CVH9Ow==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh3ghxm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 09:50:16 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53P9oFLK029330
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 09:50:15 GMT
Received: from [10.216.33.96] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 25 Apr
 2025 02:50:12 -0700
Message-ID: <07013bbc-296a-2403-a6ca-70de220495c5@quicinc.com>
Date: Fri, 25 Apr 2025 15:20:09 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] wifi: ath11k: pci: Fix msi_irq crash on driver unload
 with QCN9074 PCIe WiFi 6 modules
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>,
        Balsam Chihi
	<balsam.chihi@moment.tech>
CC: <jjohnson@kernel.org>, <linux-wireless@vger.kernel.org>,
        <ath11k@lists.infradead.org>
References: <20250416100939.282481-1-balsam.chihi@moment.tech>
 <0e129e2a-67fc-48cc-9773-efbea3f7391d@quicinc.com>
 <fa16bad6-305f-77c1-3f56-703564e2dfee@quicinc.com>
 <CAONkfw6m9O_6FZHBrPYdpv+=AxSgsbh1T7+GaS+U+bnjyVVJvQ@mail.gmail.com>
 <3da5d47b-993c-405e-841f-1d16d8715610@quicinc.com>
 <1d0682c0-ee5d-f2d4-199d-4ebc4e71f9ef@quicinc.com>
 <3660fcfb-be29-422b-a352-3996ad3fc41f@quicinc.com>
 <CAONkfw5-bfYRwHZ9iHhgJP2f8Zqyz5SZVbdL4n9EPhKU+=ONPg@mail.gmail.com>
 <CAONkfw7xjJjMAZSfHg5avEV=Bc5aJZqrRxMDvKWK4g14bLNjRQ@mail.gmail.com>
 <d4b01807-0770-439a-a77b-1e0f078687e3@quicinc.com>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <d4b01807-0770-439a-a77b-1e0f078687e3@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA3MCBTYWx0ZWRfXyMGkgIga9Kz0 QNr8QMFjNSDzLUZHg8/46oGXJMoY6ngoSrfHwvSW7nfoUsnpSYoiTUVduMWRTH/i0ndsOY06h8P Y8zljDNZcRkxvtYOEB+PS+V9heQ1sltBaIjzRTtELhDxm+q9qNHUisVJQo3lL545205F3R3Jz9B
 a3NbLVKxbOui4FebTCRkvn1aUD7nmtbRFA3bTfTllTNogIekFf3n9/X1Ib6a5Iu+hrMUmZe0Eh+ b9EKsv6Jai3Z9CKIEn1BZUIz782d3mOfGUJIB+ZWI5gAnOIXdmffIioJi82lS8LfhEM3eyNft/3 h3xPe+PoFdTxuOKaIv/Gyx4SZJ2h/o1sIFreyb7YfnEdYeUOTiQDmrKMO06VOpVMuOJcXmSEwsr
 Ir97MxCkSuQMYDVzj/QHLH0UpjfghK9NvRSN7CDSvpEQP1xmXPbJIRQMbW9Eqy3nJPeaUbd/
X-Authority-Analysis: v=2.4 cv=bs1MBFai c=1 sm=1 tr=0 ts=680b5ad8 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=7rrHA7QNMJ-wWQh4610A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: znQ8zuhr-FV5GRspcv4VuRqDWJHDXHyl
X-Proofpoint-GUID: znQ8zuhr-FV5GRspcv4VuRqDWJHDXHyl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_02,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250070



On 4/25/2025 12:35 PM, Baochen Qiang wrote:
> 
> 
> On 4/24/2025 10:07 PM, Balsam Chihi wrote:
>> I just rebuilt a clean disto and enabled the debug_mask=0x1020.
>> There are the logs bellow :
>>
>> root@OpenWrt-WAP:~# uname --all
>> Linux OpenWrt-WAP 6.6.86 #0 SMP Sun Apr 13 16:38:32 2025 aarch64 GNU/Linux
>>
>> root@OpenWrt-WAP:~# cat /etc/modules.conf
>> # examples:
>> # options mod1 option=val
>> # blacklist mod2
>> options ath11k debug_mask=0x1020
>>
>> root@OpenWrt-WAP:~# cat /sys/module/ath11k/parameters/debug_mask
>> 4128
>>
>> root@OpenWrt-WAP:~# dmesg | grep ath
>> [   15.093627] ath11k_pci 0001:01:00.0: Adding to iommu group 2
>> [   15.099326] ath11k_pci 0001:01:00.0: assign IRQ: got 0
>> [   15.099512] ath11k_pci 0001:01:00.0: BAR 0: assigned [mem
>> 0x2840000000-0x28401fffff 64bit]
>> [   15.107879] ath11k_pci 0001:01:00.0: boot pci_mem 0x00000000880f25e0
>> [   15.107886] ath11k_pci 0001:01:00.0: boot pci probe 17cb:1104 17cb:1104
>> [   15.108483] ath11k_pci 0001:01:00.0: MSI vectors: 16
>> [   15.113538] ath11k_pci 0001:01:00.0: pci msi base data is 0
>> [   15.113545] ath11k_pci 0001:01:00.0: qcn9074 hw1.0
>> [   15.118336] ath11k_pci 0001:01:00.0: FW memory mode: 2
>> [   15.125643] ath11k_pci 0001:01:00.0: boot failed to load firmware-2.bin: -2
>> [   15.125658] ath11k_pci 0001:01:00.0: boot using fw api 1
>> [   15.125668] ath11k_pci 0001:01:00.0: pci msi assignment MHI
>> num_vectors 3 user_base_data 0 base_vector 0
>> [   15.125675] ath11k_pci 0001:01:00.0: pci num_vectors 3 base_vector 0
>> [   15.129780] ath11k_pci 0001:01:00.0: pci msi assignment CE
>> num_vectors 5 user_base_data 3 base_vector 3
>> [   15.129933] ath11k_pci 0001:01:00.0: pci msi assignment DP
>> num_vectors 8 user_base_data 8 base_vector 8
>> [   15.129964] ath11k_pci 0001:01:00.0: pci irq 369 group 0
>> [   15.130013] ath11k_pci 0001:01:00.0: pci irq 370 group 1
>> [   15.130059] ath11k_pci 0001:01:00.0: pci irq 371 group 2
>> [   15.130110] ath11k_pci 0001:01:00.0: pci irq 372 group 3
>> [   15.130157] ath11k_pci 0001:01:00.0: pci irq 373 group 4
>> [   15.130204] ath11k_pci 0001:01:00.0: pci irq 374 group 5
>> [   15.130250] ath11k_pci 0001:01:00.0: pci irq 375 group 6
>> [   15.130295] ath11k_pci 0001:01:00.0: pci irq 376 group 7
>> [   15.130359] ath11k_pci 0001:01:00.0: pci after request_irq msi_ep_base_data 0
>> [   15.230443] ath11k_pci 0001:01:00.0: pci ltssm 0x111
>> [   15.230456] ath11k_pci 0001:01:00.0: pci pcie_hot_rst 0x11
>> [   15.235499] ath11k_pci 0001:01:00.0: pci pcie_q6_cookie_addr 0x0
>> [   15.235514] ath11k_pci 0001:01:00.0: pci wlaon_warm_sw_entry 0x0
>> [   15.255530] ath11k_pci 0001:01:00.0: pci wlaon_warm_sw_entry 0x0
>> [   15.255545] ath11k_pci 0001:01:00.0: pci soc reset cause 0
>> [   15.275554] ath11k_pci 0001:01:00.0: pci mhistatus 0xff04
>> [   15.285571] ath11k_pci 0001:01:00.0: pci link_ctl 0x0000 L0s 0 L1 0
>> [   15.446403] ath11k_pci 0001:01:00.0: boot notify status reason
>> MHI_CB_EE_SBL_MODE
>> [   15.494739] ath11k_pci 0001:01:00.0: boot notify status reason
>> MHI_CB_EE_MISSION_MODE
>> [   15.515587] ath11k_pci 0001:01:00.0: chip_id 0x0 chip_family 0x0
>> board_id 0xff soc_id 0xffffffff
>> [   15.524423] ath11k_pci 0001:01:00.0: fw_version 0x290b8862
>> fw_build_timestamp 2024-09-23 10:51 fw_build_id
>> [   15.534202] ath11k_pci 0001:01:00.0: boot using board name
>> 'bus=pci,qmi-chip-id=0,qmi-board-id=255'
>> [   15.551970] ath11k_pci 0001:01:00.0: boot firmware request
>> ath11k/QCN9074/hw1.0/board-2.bin size 786836
>> [   15.551992] ath11k_pci 0001:01:00.0: boot board name
>> [   15.552001] ath11k_pci 0001:01:00.0: 00000000: 62 75 73 3d 70 63 69
>> 2c 71 6d 69 2d 63 68 69 70  bus=pci,qmi-chip
>> [   15.552007] ath11k_pci 0001:01:00.0: 00000010: 2d 69 64 3d 30 2c 71
>> 6d 69 2d 62 6f 61 72 64 2d  -id=0,qmi-board-
>> [   15.552013] ath11k_pci 0001:01:00.0: 00000020: 69 64 3d 31 36 30
>>                              id=160
>> [   15.552018] ath11k_pci 0001:01:00.0: boot board name
>> [   15.552024] ath11k_pci 0001:01:00.0: 00000000: 62 75 73 3d 70 63 69
>> 2c 71 6d 69 2d 63 68 69 70  bus=pci,qmi-chip
>> [   15.552030] ath11k_pci 0001:01:00.0: 00000010: 2d 69 64 3d 30 2c 71
>> 6d 69 2d 62 6f 61 72 64 2d  -id=0,qmi-board-
>> [   15.552036] ath11k_pci 0001:01:00.0: 00000020: 69 64 3d 31 36 31
>>                              id=161
>> [   15.552041] ath11k_pci 0001:01:00.0: boot board name
>> [   15.552047] ath11k_pci 0001:01:00.0: 00000000: 62 75 73 3d 70 63 69
>> 2c 71 6d 69 2d 63 68 69 70  bus=pci,qmi-chip
>> [   15.552053] ath11k_pci 0001:01:00.0: 00000010: 2d 69 64 3d 30 2c 71
>> 6d 69 2d 62 6f 61 72 64 2d  -id=0,qmi-board-
>> [   15.552059] ath11k_pci 0001:01:00.0: 00000020: 69 64 3d 31 36 32
>>                              id=162
>> [   15.552064] ath11k_pci 0001:01:00.0: boot board name
>> [   15.552070] ath11k_pci 0001:01:00.0: 00000000: 62 75 73 3d 70 63 69
>> 2c 71 6d 69 2d 63 68 69 70  bus=pci,qmi-chip
>> [   15.552076] ath11k_pci 0001:01:00.0: 00000010: 2d 69 64 3d 30 2c 71
>> 6d 69 2d 62 6f 61 72 64 2d  -id=0,qmi-board-
>> [   15.552082] ath11k_pci 0001:01:00.0: 00000020: 69 64 3d 32 35 35
>>                              id=255
>> [   15.552087] ath11k_pci 0001:01:00.0: boot found match board data
>> for name 'bus=pci,qmi-chip-id=0,qmi-board-id=255'
>> [   15.552093] ath11k_pci 0001:01:00.0: boot found board data for
>> 'bus=pci,qmi-chip-id=0,qmi-board-id=255'
>> [   15.552100] ath11k_pci 0001:01:00.0: boot using board api 2
>> [   16.910820] ath11k_pci 0001:01:00.0: boot firmware request
>> ath11k/QCN9074/hw1.0/m3.bin size 340108
>> [   16.934188] ath11k_pci 0001:01:00.0: pci msi assignment CE
>> num_vectors 5 user_base_data 3 base_vector 3
>> [   16.934216] ath11k_pci 0001:01:00.0: pci msi assignment CE
>> num_vectors 5 user_base_data 3 base_vector 3
>> [   16.934228] ath11k_pci 0001:01:00.0: pci msi assignment CE
>> num_vectors 5 user_base_data 3 base_vector 3
>> [   16.934238] ath11k_pci 0001:01:00.0: pci msi assignment CE
>> num_vectors 5 user_base_data 3 base_vector 3
>> [   16.934249] ath11k_pci 0001:01:00.0: pci msi assignment CE
>> num_vectors 5 user_base_data 3 base_vector 3
>> [   16.934258] ath11k_pci 0001:01:00.0: pci msi assignment CE
>> num_vectors 5 user_base_data 3 base_vector 3
>> [   16.934273] ath11k_pci 0001:01:00.0: pci msi assignment CE
>> num_vectors 5 user_base_data 3 base_vector 3
>> [   16.934284] ath11k_pci 0001:01:00.0: pci msi assignment CE
>> num_vectors 5 user_base_data 3 base_vector 3
>> [   16.935322] ath11k_pci 0001:01:00.0: pci msi assignment DP
>> num_vectors 8 user_base_data 8 base_vector 8
>> [   16.935333] ath11k_pci 0001:01:00.0: pci ring not part of an
>> ext_group; ring_type: 11,ring_num 0
>> [   16.937172] ath11k_pci 0001:01:00.0: pci msi assignment DP
>> num_vectors 8 user_base_data 8 base_vector 8
>> [   16.937185] ath11k_pci 0001:01:00.0: pci ring not part of an
>> ext_group; ring_type: 12,ring_num 0
>> [   16.937196] ath11k_pci 0001:01:00.0: pci msi assignment DP
>> num_vectors 8 user_base_data 8 base_vector 8
>> [   16.937203] ath11k_pci 0001:01:00.0: pci ring not part of an
>> ext_group; ring_type: 6,ring_num 0
>> [   16.937212] ath11k_pci 0001:01:00.0: pci msi assignment DP
>> num_vectors 8 user_base_data 8 base_vector 8
>> [   16.937219] ath11k_pci 0001:01:00.0: pci ring not part of an
>> ext_group; ring_type: 7,ring_num 0
>> [   16.937489] ath11k_pci 0001:01:00.0: pci msi assignment DP
>> num_vectors 8 user_base_data 8 base_vector 8
>> [   16.937497] ath11k_pci 0001:01:00.0: pci ring not part of an
>> ext_group; ring_type: 5,ring_num 0
>> [   16.937934] ath11k_pci 0001:01:00.0: pci msi assignment DP
>> num_vectors 8 user_base_data 8 base_vector 8
>> [   16.938396] ath11k_pci 0001:01:00.0: pci msi assignment DP
>> num_vectors 8 user_base_data 8 base_vector 8
>> [   16.938405] ath11k_pci 0001:01:00.0: pci ring not part of an
>> ext_group; ring_type: 5,ring_num 1
>> [   16.938823] ath11k_pci 0001:01:00.0: pci msi assignment DP
>> num_vectors 8 user_base_data 8 base_vector 8
>> [   16.939059] ath11k_pci 0001:01:00.0: pci msi assignment DP
>> num_vectors 8 user_base_data 8 base_vector 8
>> [   16.939068] ath11k_pci 0001:01:00.0: pci ring not part of an
>> ext_group; ring_type: 5,ring_num 2
>> [   16.939468] ath11k_pci 0001:01:00.0: pci msi assignment DP
>> num_vectors 8 user_base_data 8 base_vector 8
>> [   16.939635] ath11k_pci 0001:01:00.0: pci msi assignment DP
>> num_vectors 8 user_base_data 8 base_vector 8
>> [   16.939642] ath11k_pci 0001:01:00.0: pci ring not part of an
>> ext_group; ring_type: 2,ring_num 0
>> [   16.939765] ath11k_pci 0001:01:00.0: pci msi assignment DP
>> num_vectors 8 user_base_data 8 base_vector 8
>> [   16.939872] ath11k_pci 0001:01:00.0: pci msi assignment DP
>> num_vectors 8 user_base_data 8 base_vector 8
>> [   16.939959] ath11k_pci 0001:01:00.0: pci msi assignment DP
>> num_vectors 8 user_base_data 8 base_vector 8
>> [   16.939967] ath11k_pci 0001:01:00.0: pci ring not part of an
>> ext_group; ring_type: 3,ring_num 0
>> [   16.940135] ath11k_pci 0001:01:00.0: pci msi assignment DP
>> num_vectors 8 user_base_data 8 base_vector 8
>> [   16.940417] ath11k_pci 0001:01:00.0: boot htc service 'Control' ul
>> pipe 0 dl pipe 1 eid 0 ready
>> [   16.940425] ath11k_pci 0001:01:00.0: boot htc service 'Control' eid
>> 0 tx flow control disabled
>> [   16.941453] ath11k_pci 0001:01:00.0: boot htc service HTT Data does
>> not allocate target credits
>> [   16.941570] ath11k_pci 0001:01:00.0: boot htc service 'HTT Data' ul
>> pipe 4 dl pipe 1 eid 1 ready
>> [   16.941578] ath11k_pci 0001:01:00.0: boot htc service 'HTT Data'
>> eid 1 tx flow control disabled
>> [   16.941633] ath11k_pci 0001:01:00.0: boot htc service 'WMI' ul pipe
>> 3 dl pipe 2 eid 2 ready
>> [   16.941641] ath11k_pci 0001:01:00.0: boot htc service 'WMI' eid 2
>> tx flow control disabled
>> [   16.943010] ath11k_pci 0001:01:00.0: pci msi assignment DP
>> num_vectors 8 user_base_data 8 base_vector 8
>> [   16.943267] ath11k_pci 0001:01:00.0: pci msi assignment DP
>> num_vectors 8 user_base_data 8 base_vector 8
>> [   16.943476] ath11k_pci 0001:01:00.0: pci msi assignment DP
>> num_vectors 8 user_base_data 8 base_vector 8
>> [   16.943604] ath11k_pci 0001:01:00.0: pci msi assignment DP
>> num_vectors 8 user_base_data 8 base_vector 8
>> [   17.246410] ath11k_pci 0001:01:00.0: htt event 48 not handled
>> [   17.252661] ath11k_pci 0001:01:00.0: pci msi assignment DP
>> num_vectors 8 user_base_data 8 base_vector 8
>> [   17.253260] ath11k_pci 0001:01:00.0: pci msi assignment DP
>> num_vectors 8 user_base_data 8 base_vector 8
>> [   17.253871] ath11k_pci 0001:01:00.0: pci msi assignment DP
>> num_vectors 8 user_base_data 8 base_vector 8
>> [   17.254512] ath11k_pci 0001:01:00.0: pci msi assignment DP
>> num_vectors 8 user_base_data 8 base_vector 8
>> [   17.254528] ath11k_pci 0001:01:00.0: pci ring not part of an
>> ext_group; ring_type: 16,ring_num 0
>> [   17.255170] ath11k_pci 0001:01:00.0: pci msi assignment DP
>> num_vectors 8 user_base_data 8 base_vector 8
>> [   17.255743] ath11k_pci 0001:01:00.0: pci msi assignment DP
>> num_vectors 8 user_base_data 8 base_vector 8
>> [   17.255759] ath11k_pci 0001:01:00.0: pci ring not part of an
>> ext_group; ring_type: 19,ring_num 0
>> [   17.284419] ath11k_pci 0001:01:00.0: pci msi assignment DP
>> num_vectors 8 user_base_data 8 base_vector 8
>> [   17.284438] ath11k_pci 0001:01:00.0: pci ring not part of an
>> ext_group; ring_type: 20,ring_num 0
>> [   22.039565] ath11k_pci 0001:01:00.0 phy0-ap0: entered allmulticast mode
>> [   22.050081] ath11k_pci 0001:01:00.0 phy0-ap0: entered promiscuous mode
>> [   30.709682] ath11k_pci 0001:01:00.0 phy0-ap0: left allmulticast mode
>> [   30.716078] ath11k_pci 0001:01:00.0 phy0-ap0: left promiscuous mode
>> [   36.330610] ath11k_pci 0001:01:00.0 phy0-ap0: entered allmulticast mode
>> [   36.337503] ath11k_pci 0001:01:00.0 phy0-ap0: entered promiscuous mode
>>
>> root@OpenWrt-WAP:~# iw dev
>> phy#0
>> Interface phy0-ap0
>> ifindex 14
>> wdev 0x2
>> addr 04:f0:21:bd:d7:99
>> type AP
>> channel 100 (5500 MHz), width: 160 MHz, center1: 5570 MHz
>> multicast TXQ:
>> qsz-byt qsz-pkt flows drops marks overlmt hashcol tx-bytes tx-packets
>> 0 0 0 0 0 0 0 0 0
>>
>> root@OpenWrt-WAP:~# iwinfo
>> phy0-ap0  ESSID: "OpenWrt-WAP-5GHz"
>>            Access Point: 04:F0:21:BD:D7:99
>>            Mode: Master  Channel: 100 (5.500 GHz)  HT Mode: HE160
>>            Center Channel 1: 114 2: unknown
>>            Tx-Power: 0 dBm  Link Quality: unknown/70
>>            Signal: unknown  Noise: -101 dBm
>>            Bit Rate: unknown
>>            Encryption: none
>>            Type: nl80211  HW Mode(s): 802.11ac/ax/n
>>            Hardware: 17CB:1104 17CB:1104 [Qualcomm Atheros QCN6024/9024/9074]
>>            TX power offset: none
>>            Frequency offset: none
>>            Supports VAPs: yes  PHY name: phy0
>>
>> root@OpenWrt-WAP:~# reboot
>> [  343.663492] Internal error: synchronous external abort:
>> 0000000096000210 [#1] SMP
>> [  343.670992] Modules linked in: nft_fib_inet nft_connlimit
>> nf_flow_table_inet nf_conncount ath11k_pci(O) ath11k(O) rndis_host
>> nft_socket nft_reject_ipv6 nft_reject_ipv4 nft_reject_inet nft_reject
>> nft_redir nft_quota nft_queue nft_numgen nft_nat nft_masq nft_log
>> nft_limit nft_hash nft_fwd_netdev nft_flow_offload nft_fib_ipv6
>> nft_fib_ipv4 nft_fib nft_dup_netdev nft_dup_ipv6 nft_dup_ipv4 nft_ct
>> nft_chain_nat nfnetlink_cttimeout nfnetlink_cthelper nf_tables nf_nat
>> nf_flow_table nf_conntrack_netlink nf_conntrack mmc_spi mac80211(O)
>> ftdi_sio ch348 ch341 cfg80211(O) cdc_subset cdc_ether cdc_eem
>> usbserial usbnet usbmon usbhid ums_usbat ums_sddr55 ums_sddr09
>> ums_karma ums_jumpshot ums_isd200 ums_freecom ums_datafab ums_cypress
>> ums_alauda tps23861 tmp103 tmp102 spidev spi_gpio spi_bitbang sfp
>> rtc_pcf8563 rtc_pcf2123 rtc_ds1672 rtc_ds1374 qrtr_mhi qrtr
>> qmi_helpers(O) of_mmc_spi nfnetlink_queue nfnetlink nf_socket_ipv6
>> nf_socket_ipv4 nf_reject_ipv6 nf_reject_ipv4 nf_log_syslog
>> nf_dup_netdev nf_dup_ipv6 nf_dup_ipv4 nf_defrag_ipv6
>> [  343.671198]  nf_defrag_ipv4 mhi_pci_generic mhi_net mhi mdio_i2c
>> mdio_gpio max6697 ltc4151 lm95241 lm92 lm90 lm85 lm77 lm70 lm63 jc42
>> ina2xx ina209 hid_generic compat(O) cdc_acm at25 adt7475 ntfs3 configs
>> sg hid tmp421 tc654 adt7410 adt7x10 adcxx ad7418 i2c_gpio
>> i2c_designware_pci i2c_ccgx_ucsi i2c_algo_bit gpio_pcf857x i2c_mux_reg
>> i2c_mux_pca954x i2c_mux_pca9541 i2c_mux_gpio cryptodev(O) hwmon_vid
>> msdos bonding nls_utf8 zram zsmalloc eeprom_93cx6 crypto_user
>> algif_skcipher algif_rng algif_hash algif_aead af_alg sha512_generic
>> sha512_arm64 seqiv sha3_generic jitterentropy_rng drbg michael_mic md5
>> hmac geniv cmac uas usb_storage xhci_plat_hcd xhci_pci xhci_hcd dwc3
>> dwc2_pci dwc2 roles ohci_pci uhci_hcd ohci_platform ohci_hcd ehci_pci
>> fsl_mph_dr_of ehci_platform ehci_fsl ahci_platform ahci_qoriq
>> libahci_platform libahci ehci_hcd nvme nvme_core exfat gpio_cascade
>> mux_gpio phy_generic usbcore usb_common microchip mii
>> [  343.842432] CPU: 7 PID: 9435 Comm: procd Tainted: G           O
>>    6.6.86 #0
>> [  343.849746] Hardware name: LS1088A
>> [  343.856969] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>> [  343.863933] pc : ath11k_pci_get_msi_irq+0x18a0/0x1900 [ath11k_pci]
> 
> is this instruction causing the synchronous external abort? which src line is it pointing to?
> 

Below data points may be useful along with the above one.

i) Was this working before for you and broken recently or it has been
    like this since you tried first?

ii) Running into same issue during rmmod of ath12k driver instead of
     reboot?

iii) Is it possible to attach the console log during reboot also?

Vasanth

