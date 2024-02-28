Return-Path: <linux-wireless+bounces-4215-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D3686B9E5
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 22:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FE4CB25551
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 21:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070894D11F;
	Wed, 28 Feb 2024 21:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ivj2GeXU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5C386241
	for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 21:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709155906; cv=none; b=XPd0iv7C6GBuvnVPZtEv5T/gpHqkPDSvymZ9NxOl8rJGpXAME2yyBH8BLStY00c0EJrl9RDiOax4x/erhebg78J2EVuGIeoCIBz8HlL+FNhrMZ8Y9Lr5fERAGFJKLLOYdEBfHzCDpQx1KW9UhoS6LCzMKiozaihE8zGcefRL5yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709155906; c=relaxed/simple;
	bh=xb01DgcWC2Rf1HATvElQvabbiV4YP21tooQv3Vn6zSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YGlxP+dPEo76MkLWVWDEA8yhkQMJize+ZiY0GpNRuJtv+bMTFNj7m2CKou/HIdB8jF0bvwAULgi5kKFx2OFMqBeLbDsmPwl7ixfSTb/RvAIQ3LylK4mWWlUdPrtGrVMywIy8FTwc0BxzANyVBy+dLfNi+RVEtIjxO9DkXG69TY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ivj2GeXU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41SKN8N2021167;
	Wed, 28 Feb 2024 21:31:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=451wk6Gj4os3uNZiTxefFakbJBiJlZW30ZzigJca/Ok=; b=iv
	j2GeXUOjQSniroen2UTZsHquwjdvB1fP+xWxs4wxnK4f46Iz4uegtPcyI8ybevtB
	hzTdKx8JcBB1adTjNguco1znjvTh4BjndfGvJpoa+NWU/0yTe7DWEtBuCOsi+kqb
	V3abt2su4mO44mnGekKL9hCWiX2ocOaFTuFNUQh/HXbpwIEUtmF2KZzLeL/5Zolf
	hbxZk21agR/Rd/zt2XzMTx6WtZoOyLUBsWgWdrW6XsrUgEYdA42+ry59DrQgOsUR
	PNb+D1wa+KMCH38K2bvMMt1lnSB661+cOEQ+rKr+b7qAvGv5F51Umyd0gqLCCrrg
	DMCQ481lDTLWeqC/VTug==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wj2149tss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 21:31:32 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41SLVVZ0011064
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 21:31:31 GMT
Received: from [10.110.113.97] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 28 Feb
 2024 13:31:30 -0800
Message-ID: <18ab7c1e-daa0-498d-ae01-d34784199474@quicinc.com>
Date: Wed, 28 Feb 2024 13:31:30 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath10k: poll service ready message before failing
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>,
        Baochen Qiang
	<quic_bqiang@quicinc.com>, <ath10k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240221031729.2707-1-quic_bqiang@quicinc.com>
 <d67fb4f4-aea2-4668-aac4-6e7eca8db4fa@gmail.com>
 <0ee7ae2f-8034-4908-b6e3-fa17a995c661@quicinc.com>
 <6362d9b2-6ed2-4454-bf1b-8614d181bc93@gmail.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <6362d9b2-6ed2-4454-bf1b-8614d181bc93@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: uaqCM6AoucRR8wVFCBG33EjyBeCYuP6H
X-Proofpoint-GUID: uaqCM6AoucRR8wVFCBG33EjyBeCYuP6H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_08,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=919 clxscore=1011
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402280170

On 2/28/2024 10:46 AM, James Prestwood wrote:
> This does appear to have fixed it! For reference this was my test:
> 
>   for i in $(seq 1 100000); do sudo ip link set wlan0 down; sudo ip link 
> set wlan0 up; echo $?; done
> 
> I never saw the up command fail, and after a while I noticed one of the 
> iterations took a bit longer to complete. Checked dmesg and saw:
> 
> [ 1006.017198] ath10k_pci 0000:02:00.0: failed to receive service ready 
> completion, polling..
> [ 1006.017295] ath10k_pci 0000:02:00.0: service ready completion 
> received, continuing normally
> 
> I then started IWD and it was able to connect fine (data frames were 
> being passed). I was able to trigger this 3 times relatively quickly, 
> each time IWD connected afterwards. So from my end this appears fixed.
> 
> You can add tested-by me if you like:
> 
> Tested-By: James Prestwood <prestwoj@gmail.com> # on QCA6174 hw3.2

Thanks for the initial report and the testing :)

/jeff

