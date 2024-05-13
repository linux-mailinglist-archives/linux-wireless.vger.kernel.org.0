Return-Path: <linux-wireless+bounces-7616-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE0B8C48E7
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 23:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AD42B23DCB
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 21:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA7B86126;
	Mon, 13 May 2024 21:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NHBZlh3P"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2288612E
	for <linux-wireless@vger.kernel.org>; Mon, 13 May 2024 21:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715636016; cv=none; b=uQ6eb4CWB2tN6phn2rZ9acYf1s3QJULs7AtUxLexG47qni5+IYO8b8txG2CNxxQfxTlxtbdERUe1TM43dbT5KgdAI1LMwaElL8vZ+jhqx5b0CEOfv3TXYSXIakzheZLeeEMZc+YDkEk2wgHactZS+6t6lb1M64/0M5yW/g+5/sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715636016; c=relaxed/simple;
	bh=HDTAPHpB5vBc5+NuPOKA7FKQSbIuytc81Af2qEatYQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ai+oUPy4jp+prTAzK6l8ADetzD28uIBXjT01QoqR2OCQATd6zI7qYMPSDWHrPWxyLpXaGdu2/7jDl1kZPytFYjzx77oQsP48nrkpQ3QhGKQrfQdOf23xgV5xIJmqf2TYiFQKl/cXZLg6yj3BhYYJ2Y634+gZQsG+0yujpbPs+UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NHBZlh3P; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44DJ8dPO018863;
	Mon, 13 May 2024 21:33:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=UIfdthUrUP3mcVeXO2qkv82/5p6EWQ7UmA1Ol7NcGH4=; b=NH
	BZlh3PktC8IOcwyEaWXrn3om6xqAEXrds+l0Ftvf4mqi89joi/9DAkAwtUmrzhJh
	/DY2Y/rAZvRJ+SLT1tn7yYyXbzNiRrO9XCsCMJtirbMHskNTlolxk50XZHWg00NV
	qHGnZMbKAaXCQ3aQdX44sXAk64kKRqd7gij5u62NbGSXNkDP5oMbu1p24noP10J4
	kaMCLHk3OdH3aW/UZFOcdgv2KKEim+0ayQmRnOWPy4rnLn/VKj4uefrR/39LT2oz
	c7AcSAPe5HNmBIcusPU35kKE8VBy8JE7wZmoXrTYY3hoi2rGAkEMHEdivCoLLlSa
	EZZQqJf+vr4zJrG0l2IA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y20rtck1j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 May 2024 21:33:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44DLXK6L003662
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 May 2024 21:33:20 GMT
Received: from [10.110.0.4] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 13 May
 2024 14:33:19 -0700
Message-ID: <927a397d-7070-4d64-9247-84a7cbae07d9@quicinc.com>
Date: Mon, 13 May 2024 14:33:18 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 5/6] wifi: ath12k: refactor SMPS configuration
Content-Language: en-US
To: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240508173655.22191-1-quic_pradeepc@quicinc.com>
 <20240508173655.22191-6-quic_pradeepc@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240508173655.22191-6-quic_pradeepc@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3aq2xaRg_uKAV9dmVmYPvFvXfd4k4een
X-Proofpoint-GUID: 3aq2xaRg_uKAV9dmVmYPvFvXfd4k4een
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_15,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 mlxscore=0 malwarescore=0
 adultscore=0 spamscore=0 priorityscore=1501 phishscore=0 mlxlogscore=797
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405130147

On 5/8/2024 10:36 AM, Pradeep Kumar Chitrapu wrote:
> Move fetching SMPS value to a new function and use u16_get_bits
> to extract it from capabilities. This will help in extending the
> functionality when SMPS support in 6 GHz band gets added in
> subsequent patches.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


