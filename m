Return-Path: <linux-wireless+bounces-8041-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 934E28CE21F
	for <lists+linux-wireless@lfdr.de>; Fri, 24 May 2024 10:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 279B7B21822
	for <lists+linux-wireless@lfdr.de>; Fri, 24 May 2024 08:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D166182D9E;
	Fri, 24 May 2024 08:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CQ0Cp/z/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EE937703
	for <linux-wireless@vger.kernel.org>; Fri, 24 May 2024 08:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716538478; cv=none; b=jGTwv6O91P9HYjuoV0m+fzJgKKm9JN1kQ/9JzECoZqV9bnKE1513txPt3wpNz5M6RHZunBX07fSPpym6JzEDSlEa/SnUf8zTIxOJUgtXtyGxyTaLHSccQ1ShnKPuREfR85pCQ017klYO0yLIkEDkkstPqIv5KgDdHseGvQSrh7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716538478; c=relaxed/simple;
	bh=YrBWMFQ5PXTKKvVnBp0LSTf8swvdywvn162NmMp0qGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=O0yy8/llW//qZs3vs0cdWYc0XzSnIHaCE9+vtVv1L5hjQkB/QlTDpnMgTJ4BoYRtcWO8z3JDwHCGxmF9C5lWUknNogojWc2gIjTO5WXwB7iBUxXMKAL9Eu2GWuVNTpzhTAANZtUvjU8qh3zH7XKcntwP2s/2tW8bvRgXKk4/iFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CQ0Cp/z/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44NNOsRf012346;
	Fri, 24 May 2024 08:14:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RgYf5MB7r/0mk8aB3LLbW/fm/qJZ0PkJuMoA5teU8cM=; b=CQ0Cp/z/zl0XQfKF
	Z2jac5LduY6iit3loTo4iZN+90FKK9QDj5C+IwYUEPbv9T1zTVyvlOxJKoC8sDq3
	fjXmu1Cw3glHpnMNMB1qlsbni/gp7lCBJplIJBFUSqvI4VJSk5iTVXag7ysP3ocz
	yo8dCd2COyjRqRj7Dyf9tBDYxqr55JrU968K3Okw+jxm4/fRlk1Reb1qKcvxCVrk
	q5N5z/p9GSb2luZyTb0VbGbXGzw+l620b3qwaXagavMGVbDBZRzQ4ZzLRyOTuSeY
	VcR+97jKSm7WoEPWb4Fu7uih14H+eRiRTXASEWPWTa5uRWiI7ajys+I9odq+GwPm
	5SFAnA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yaa8hskv6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 May 2024 08:14:17 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44O8EG4Y021498
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 May 2024 08:14:16 GMT
Received: from [10.253.73.87] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 24 May
 2024 01:14:15 -0700
Message-ID: <279f4d5e-692d-430b-b0ab-312e1ee3c8d2@quicinc.com>
Date: Fri, 24 May 2024 16:13:58 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] wifi: ath12k: add 11d scan offload support and
 handle country code for WCN7850
To: Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_jjohnson@quicinc.com>
References: <20230914090746.23560-1-quic_wgong@quicinc.com>
 <87ttrd6s4j.fsf@kernel.org>
Content-Language: en-US
From: Kang Yang <quic_kangyang@quicinc.com>
In-Reply-To: <87ttrd6s4j.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: HuRvH5YUC8FBifv9ePF9r6oGrpMgkLUL
X-Proofpoint-GUID: HuRvH5YUC8FBifv9ePF9r6oGrpMgkLUL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-24_02,2024-05-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 clxscore=1011
 impostorscore=0 suspectscore=0 mlxlogscore=768 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405240055



On 9/29/2023 9:11 PM, Kalle Valo wrote:
> Wen Gong <quic_wgong@quicinc.com> writes:
> 
>> v2: change per Jeff.
>>      1. change alpha2 length from 3 to 2.
>>      2. change wmi_11d_new_cc_ev to wmi_11d_new_cc_event.
>>
>> Add handler to send WMI_SET_CURRENT_COUNTRY_CMDID which is needed for
>> 11d scan offload to firmware. And add support for 11d scan offload for
>> WCN7850.
>>
>> Also fix firmware crash for country code set for WCN7850 and store country
>> code for device recovery for WCN7850.
>>
>> Wen Gong (4):
>>    wifi: ath12k: add configure country code for WCN7850
>>    wifi: ath12k: add 11d scan offload support
>>    wifi: ath12k: avoid firmware crash when reg set for WCN7850
>>    wifi: ath12k: store and send country code to firmware after recovery
> 
> Patches 2 & 3 had trivial conflicts with rfkill patches, fixed in the
> pending branch:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=3261a8fe9de8fd5a94215eaf0c8738c3f0051105
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=0f82a7f8a8d1944faea458f992d492daa74a968e
> 
> No need to resend because of this.

Hi, kalle

	This patch-set is important to WCN7850.
	Without it, WCN7850 cannot even set country code with board-2.bin now.

	iw reg set US/CN..:

[ 4623.473098] ath12k_pci 0000:03:00.0: Regulatory Notification received 
for phy2
[ 4623.475719] ath12k_pci 0000:03:00.0: No reg rules available
[ 4623.475775] ath12k_pci 0000:03:00.0: failed to extract regulatory 
info from received event
[ 4623.475825] WARNING: CPU: 5 PID: 0 at 
drivers/net/wireless/ath/ath12k/wmi.c:5789 
ath12k_reg_chan_list_event.isra.0+0x5d4/0xb30 [ath12k]
[ 4623.476823] CPU: 5 PID: 0 Comm: swapper/5 Tainted: G        W  O 
  6.9.0-wt-ath+ #17
[ 4623.476836] Hardware name: AMD Mayan-PHX/Mayan-PHX, BIOS RMH1001gC 
05/08/2023
[ 4623.476848] RIP: 0010:ath12k_reg_chan_list_event.isra.0+0x5d4/0xb30 
[ath12k]
[ 4623.477032] Call Trace:
[ 4623.477059]  ? show_regs+0x63/0x70
[ 4623.477080]  ? __warn+0xcb/0x300
[ 4623.477096]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 4623.477118]  ? ath12k_reg_chan_list_event.isra.0+0x5d4/0xb30 [ath12k]
[ 4623.477155]  ? report_bug+0x318/0x400
[ 4623.477186]  ? handle_bug+0x85/0xb0
[ 4623.477205]  ? exc_invalid_op+0x1c/0x50
[ 4623.477225]  ? asm_exc_invalid_op+0x1f/0x30
[ 4623.477263]  ? ath12k_reg_chan_list_event.isra.0+0x5d4/0xb30 [ath12k]
[ 4623.477305]  ath12k_wmi_op_rx+0x6a1/0x1900 [ath12k]
……

	Also, 11d scan need this patch-set too.

	So, what's your plan on this patch-set🙂?
> 

