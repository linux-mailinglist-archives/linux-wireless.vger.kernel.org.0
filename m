Return-Path: <linux-wireless+bounces-4024-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCE6868018
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Feb 2024 19:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7906928C668
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Feb 2024 18:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3927712E1D5;
	Mon, 26 Feb 2024 18:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WzdP0eHw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C4B12C815
	for <linux-wireless@vger.kernel.org>; Mon, 26 Feb 2024 18:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708973603; cv=none; b=qVjw0+4zNnSFFb/Xax0SiHy1e+CWsJ8k4vlu7ShotKvENJ7oJDVxJISQg6cG0HGWKj5sg2t2Oo36CAcwIzN852VR3e1Px/q4m7PKhLdzzxqrIjFEMpqpGDs6ppIiwaTvX1lt4Z8yElMZSK9nz/ba4L00Cn7Mvuwo/B6iq//rJ7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708973603; c=relaxed/simple;
	bh=2jLksdW9Lmlv9nUqV398qtvApNgZ+sIiwb98airpIqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RmSXPeiIU75HLpGftxjzJifWm3MDOGy3GncqSfiAaKO0R4mCmE5enCNiam4XHG2KGWEb0GnBsDm00WQvdiKRsRpBTZElQxqyfxBHubpI/CNlT/Du2kFO8bEcwi1sCI9h9R8YK/B2na6MKdoaHxDOwnpagHgZ7SxTdU7+x2g0bQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WzdP0eHw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41QF8G1c002103;
	Mon, 26 Feb 2024 18:53:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=PYDckl6CHcQHSj0iKCVuzDHRH7dEPUgLnUMSA1NXEqw=; b=Wz
	dP0eHwLkCLZXyUAHHITguNhmkogRvF2EW2aYPtl/RHfplzl3GdbnKEANncujL96z
	fq2dwmWFITJoqiOweuJrzG5+HVf6JMnvHUlskRSw8rfg/b+dXZZUfbzpRQ+tyE1N
	ysFnljUMqi6j/A1sBhDXYZLx2+AF34IJ1T0ecHK0LcbCyfuyRRGEzHfksSKlopXD
	N5CL+csmhqAdhSNWxdy4T9xZYb57bPM3ecEoqu4U+1ehuQ818EPGHqjQgwe2lUbb
	Ns0FndPZvfNZuTVO57LazXY5XEipUgof0qxDJ2a44ifOpUhFMXiKbwVIs8CAo0vS
	qBkQKEIA4u8H1l03niBw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wgkxksu7y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 18:53:19 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41QIrIUv028820
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 18:53:18 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 26 Feb
 2024 10:53:18 -0800
Message-ID: <290eddc6-494c-4e34-98a7-3a40c86bd33a@quicinc.com>
Date: Mon, 26 Feb 2024 10:53:17 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] wifi: ath11k: change interface combination for P2P
 mode
Content-Language: en-US
To: Kang Yang <quic_kangyang@quicinc.com>, <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240226060203.2040444-1-quic_kangyang@quicinc.com>
 <20240226060203.2040444-2-quic_kangyang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240226060203.2040444-2-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: DzxLtB6IbORadadY4vYyrllgjCy4M4jA
X-Proofpoint-GUID: DzxLtB6IbORadadY4vYyrllgjCy4M4jA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=868 malwarescore=0
 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2402260143

On 2/25/2024 10:01 PM, Kang Yang wrote:
> Current interafce combination doesn't support P2P mode.

s/interafce/interface/

Kalle can fix this in the pending branch

> 
> So change it for P2P mode.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.37
> Tested-on: QCA2066 hw2.1 PCI WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.2
> 
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


