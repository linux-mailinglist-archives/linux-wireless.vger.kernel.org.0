Return-Path: <linux-wireless+bounces-2784-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86449841C46
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 08:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7A191C2428D
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 07:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24EB524CC;
	Tue, 30 Jan 2024 07:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FHILCMzG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6059C524AC
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 07:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706598152; cv=none; b=gbWfj5kpLmj08/x7ggxlL661RPZP7VRViuaGBie0hYaTqpbIN4+ETozKbGUEN4fIzjdHpd6PQe1HS4e8JdPyeFm3v1ApfC92FTFyl4a1J0U/CKhKAPzy7dGtztax6E97864Nl1A92A8plnNq4GjN265sKO1tUrSw4udVQfyLAzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706598152; c=relaxed/simple;
	bh=iptHtuGHuZZsqWnf01yYm5FjFYAVJ9MO5CTfbvC4n9Q=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:References:
	 In-Reply-To:Content-Type; b=YRJYNiMcuthCM0/4cqon7DXM6GLDjmgaG2bZlkjBO9S4WUXa1e3KK7AZU/BJ/EQl5M5dvh/1Eq7piY8333FdPEjTM5RUH/Wm4wBO7rbi95KbqweXHLpA8FFoOIGY+a8Sn60u5RVSDeYJrRI5BLHDNxC97OWR2QhjfBvUBXjD/WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FHILCMzG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40U3eLwo008188;
	Tue, 30 Jan 2024 07:02:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:from:to:subject:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=BaQi+uffQx+bcT8OByEnpa5PdA/yCPnBVInhhhMRdt4=; b=FH
	ILCMzGtUtogTK7smXJtzeCVJL0JDWJ+hVrBwvUUyV1Z4vcSrm5R613jtbQmopDXE
	SC0/2FMp6biD9EDpkL7y0HuTCkC36B6Y2t+Zatvt8l9uMwSMPnal60qhjMQoiUBz
	5zbnKYR8zwtItn8k/FbrhbMpZ0Mj+WaNoCjZPIBLEtYbO6P7N2pDlz6DV14HCrdS
	4Y3S2L1TJWwedSlcieAHzXfaoOJedAFNeQhAW28NgGuAZOzmlXRLv/m6K4BmYR/C
	LlU0AMjrvI1n59oOyC+4igR8B/TRZthA083ToRYXtlStYC6QOGaVvZIKPy4XiNKK
	xn7wkG7QLD2qMxvXe0rg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vxevdsn56-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 07:02:27 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40U72Q6r003672
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 07:02:26 GMT
Received: from [10.253.12.70] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 29 Jan
 2024 23:02:25 -0800
Message-ID: <67810e6a-331e-49f1-b50e-d4b398ef9eae@quicinc.com>
Date: Tue, 30 Jan 2024 15:02:22 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: <quic_kangyang@quicinc.com>
To: Kalle Valo <kvalo@kernel.org>, <ath12k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v3 00/10] wifi: ath12k: P2P support for WCN7850
References: <20240122113904.8938-1-quic_kangyang@quicinc.com>
 <87cytp1nhd.fsf@kernel.org>
 <9a90fab6-18f1-4664-96f4-6795174d636f@quicinc.com>
 <87sf2gwaw9.fsf@kernel.org>
In-Reply-To: <87sf2gwaw9.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RDTKN1XWgKdz9KcD9231qcul85oe6foM
X-Proofpoint-ORIG-GUID: RDTKN1XWgKdz9KcD9231qcul85oe6foM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_02,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 clxscore=1015 mlxscore=0 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401190000
 definitions=main-2401300049



On 1/29/24 9:02 PM, Kalle Valo <kvalo@kernel.org> wrote:
> Kang Yang <quic_kangyang@quicinc.com> writes:
> 
> > On 1/25/2024 10:44 PM, Kalle Valo wrote:
> >> Kang Yang <quic_kangyang@quicinc.com> writes:
> >>
> >>> Add P2P support for WCN7850.
> >>>
> >>> Kang Yang (10):
> >>>     wifi: ath12k: change interface combination for P2P mode
> >>>     wifi: ath12k: add P2P IE in beacon template
> >>>     wifi: ath12k: implement handling of P2P NoA event
> >>>     wifi: ath12k: implement remain on channel for P2P mode
> >>>     wifi: ath12k: change WLAN_SCAN_PARAMS_MAX_IE_LEN from 256 to 512
> >>>     wifi: ath12k: allow specific mgmt frame tx while vdev is not up
> >>>     wifi: ath12k: fix broken structure wmi_vdev_create_cmd
> >>>     wifi: ath12k: move peer delete after vdev stop of station for WCN7850
> >>>     wifi: ath12k: designating channel frequency for ROC scan
> >>>     wifi: ath12k: advertise P2P dev support for WCN7850
> >>>
> >>> v3: rebase on new ath-tag, use ath12k_ah_to_ar() get ar(Karthikeyan).
> >>> v2:
> >>>       1. add Tested-on tag of QCN9274.
> >>>       2. update copyright in patch #1, #2, #4 and #10.
> >> I have not been able to run any p2p tests yet but during rmmod with
> >> WCN7850 I now see:
> >> [  136.260660] ------------[ cut here ]------------
> >> [ 136.260909] UBSAN: shift-out-of-bounds in
> >> drivers/net/wireless/ath/ath12k/mac.c:6005:38
> >> [  136.261008] shift exponent 255 is too large for 64-bit type 'long long int'
> >
> >
> > It seems you enable CONFIG_UBSAN, CONFIG_UBSAN_SANITIZE_ALL and other
> > CONFIG_UBSAN_XXX.
> 
> Yes, I try to enable debug facilities as much as possible. They are
> really good at finding issues in the code.
> 
> > I will add them to my config file and debug this warning.
> 
> Thanks.
> 

Now, i fix this warning with new patch '[PATCH v6 02/11] wifi: ath12k: fix incorrect logic of calculating vdev_stats_id'.

Please ignore this version.


> > It's been a long time since the last update of kernel config. Can you
> > share the new one if convenient?
> 
> Yeah, it is. I updated it now.
> 
> 

