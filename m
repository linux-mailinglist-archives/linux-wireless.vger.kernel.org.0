Return-Path: <linux-wireless+bounces-18231-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85716A234E3
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 21:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EF083A4B52
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 20:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39E8194141;
	Thu, 30 Jan 2025 20:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="N0MqkcqH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577F114F102
	for <linux-wireless@vger.kernel.org>; Thu, 30 Jan 2025 20:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738267599; cv=none; b=Xd0hZxutoegwRIWOzXFp4+uoj2xP23LRolZULc6yXOfxeX2CDmMblKYvM2VKPAps0x0EWImxLCJmcwky02omSCDIK8IYmVmSvPYBVVRPq+fG6lH/U/0B497jbifSYP3VHKz8dl/41AF8FAfuQ+HXJINCX/gzoAKnW5Hm5Fw+OnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738267599; c=relaxed/simple;
	bh=IgnLvpQxDn+Mx4y1zzJkAujzXuU50/kYj9oA4G1rhJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GPviD7TGFEA9d0kB8qejAELMCxcep4aHqoSP0h39JuWQFK04tKhmTCPAjhSMSpYb6o1kGZgPWfOAW2Lx/NEFjcbh5yD0b0P0PCEq+7sRITd0r64eJx9y54yLKKQVIJ/vDsx1KYrE34AjJIMyoUzF9snV3gFlESPpNyCjw4Ibhls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=N0MqkcqH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50UJ1qQT011830;
	Thu, 30 Jan 2025 20:06:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	elDICj/q/FYey3BXsVqOFIdUS21Q0d0uvpkLxBMskGw=; b=N0MqkcqHWsE78GmY
	F3HKBIL0nrlZPeonCTjBB31d5MQbi3xRcTDYk6NVvup/c4tCe0bELtY4+Fak0DCE
	UyLA/6KhGWqs0P+WLDErRDbLkQ8in7+lkRKeU7/AYR5yBMZ+nXvxmDpx7JUpbgfN
	P+aI4injRgbpQZ2Uu8DfKi0qJs1AUnjvM60AKMzl//ou67rhppW7ayfGor5Ho785
	7ldVSHu+/6hOecge+SS5ej2jH2pgGwUechKfYq1Y8Vc/C3Qzfm6rHNsg4esz9+wA
	lNJ+0HyoLHJeMnnSzYhI1Wsp3P9XFIDnvwpCbBVO4TQiHZjssPxnqmCHdCzuFwjz
	cIHGDg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44gf7k04wc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 20:06:33 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50UK6WZ9028144
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 20:06:33 GMT
Received: from [10.227.108.41] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 30 Jan
 2025 12:06:31 -0800
Message-ID: <03c90a4d-64b7-4ad1-9139-7614bd33707c@quicinc.com>
Date: Thu, 30 Jan 2025 12:06:31 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 6/9] wifi: ath12k: add support for setting fixed HE
 rate/GI/LTF
To: <mbizon@freebox.fr>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Muna Sinada <quic_msinada@quicinc.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
References: <20250114003813.2783550-1-quic_pradeepc@quicinc.com>
 <20250114003813.2783550-7-quic_pradeepc@quicinc.com>
 <f5c6d874e9d7682d52c5ed107a0ede952b5cf53f.camel@freebox.fr>
 <5861c953-436e-4f36-ae8b-5ef52fceb3b6@quicinc.com>
 <2aba18dc3448b5a60a1a06b33fa591e562927693.camel@freebox.fr>
 <961df6e7-0b5c-4972-9324-5c4d430cb172@quicinc.com>
 <54d456f00aa8a806768099df55dc9f2ef734209b.camel@freebox.fr>
 <dedfdb8e-c5b4-42fa-bd76-ca866ab1cf41@quicinc.com>
 <1a6316872ecb6b49cbaab70d5e8fd01e78fe0ba6.camel@freebox.fr>
Content-Language: en-US
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
In-Reply-To: <1a6316872ecb6b49cbaab70d5e8fd01e78fe0ba6.camel@freebox.fr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 95q1PCxRa8a5N6-l2v6TXhmfkXW1Bsg3
X-Proofpoint-GUID: 95q1PCxRa8a5N6-l2v6TXhmfkXW1Bsg3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_09,2025-01-30_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 adultscore=0 bulkscore=0 suspectscore=0 mlxlogscore=718 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2501300152


> Assuming my understanding is correct, should you not adapt
> ath12k_peer_assoc_h_ht() to match this semantic ?
> 
Hi Maxime,

Thanks for your comments..Looks like the definitions were added mainly 
for test purposes to force SGI/LGI: 
https://patchwork.kernel.org/project/linux-wireless/patch/1389167162-3681-1-git-send-email-janusz.dziedzic@tieto.com/

While following the semantic might improve code readability, based on 
current firmware capabilities, we can force LGI when user sets 
set_bitratemask but cannot force SGI always as firmware might endup 
choosing LGI when PER is high.

let me make changes in next revision accordingly.

Thanks
Pradeep

