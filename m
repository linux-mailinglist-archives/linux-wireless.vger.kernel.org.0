Return-Path: <linux-wireless+bounces-12964-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0128A97BEF2
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 18:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FA271F212EF
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 16:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48ED8493;
	Wed, 18 Sep 2024 16:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TkSaSpNa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDB613B78F
	for <linux-wireless@vger.kernel.org>; Wed, 18 Sep 2024 16:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726675510; cv=none; b=PEN9WzIbq69mspTlk0eh03CKmyaU115GPWsTp/ZP78a9PAwtCrPDkJLhMEUWKnIDDTuyD0tnz2X2HT6bf5ll0F4zr4WhB/wcicyoLn6Hmg9YF5oU+BjZtIA89xnx7fBEGbYpCZP6lKiasp+qJ2fSMghkfkxB6V3n4sQF1WXYZF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726675510; c=relaxed/simple;
	bh=UMdcQe8SvBNW+xF4IsEmZXSt4Ixv9BghymUkuh3wYdw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Xl4ILUoPOciIWTcDVfR5ER/CCHCzZ7KAxesWGAK9cFmT1Eg0P6sqCCzq7DXLP6P3ed+Ht7g4hfZ7cgWNHEw0ONE3U8nU/undt9jDQiCyt4+fnWMy8ZPMBJjOQjEAiRAoO9bmDpgUDzTCBoFgPHsNIjICXiJQe0O+ITYonSg8JVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TkSaSpNa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48I899Ra004510;
	Wed, 18 Sep 2024 16:05:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TzkXt872mxbQerJAceVioQ85MeBrGZaTcPINJyyvl9s=; b=TkSaSpNaATwpqXZg
	eeK6I8MR6QH88tZYC9M/Vyc4SXbG/Xru2h+Yv7nN7CMPz8o5HIxQrIU2mkCDcvfW
	7pvjOaC49TF0zBFjUaONJiHzlA0Z/lijziguscDBka2t3MqHtnATgRHShw4DQRJl
	QBKcSZdO9HskSSQXmyyRGbBmQwGWrnGCpUt1hflYVYS8ZDfVxMDba6S0CnN5Tgaq
	PzRhIRN3FJUnoLP8UJ+DOxtVGuxK7sjxcXq3qYJX6i4+DlZGz9ryazzY1BC/zWh7
	MtsfCJRePDxLUlJTJwV82H5fQQ9KX8xZ94EYr8ExiNNAhhyRxM0YmSz3DuZ7Otsj
	SDa4tA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41n4j6tkx4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Sep 2024 16:05:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48IG54Jb008570
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Sep 2024 16:05:04 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 18 Sep
 2024 09:05:04 -0700
Message-ID: <7488ed13-82dd-4b41-97c7-5692cacfa631@quicinc.com>
Date: Wed, 18 Sep 2024 09:05:03 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath12k - HTT timeout error with NCM86
To: Dieter Knueppel <dknueppel@online.de>, <linux-wireless@vger.kernel.org>,
        <ath12k@lists.infradead.orgi>
References: <14e17e9a-638b-4bfe-8a2a-99b524a20acf@home.xx>
 <1MvJjz-1s0CoP3EEz-00rhmL@mrelayeu.kundenserver.de>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <1MvJjz-1s0CoP3EEz-00rhmL@mrelayeu.kundenserver.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gCoVlI8nwZl02uSFOgL6omUJKsoo4LnN
X-Proofpoint-GUID: gCoVlI8nwZl02uSFOgL6omUJKsoo4LnN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=813
 mlxscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1011
 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409180105

On 9/18/2024 7:40 AM, Dieter Knueppel wrote:
> Dear developer team,
> 
> I have to admit, the earlier post "HTT timeout error with NCM86" is my
> fault, sorry for causing confusion.
> 
> Due to earlier tests with legacy cards, the PCIe slot was still forced
> to Gen2 :-(
> 
> Putting it back to <auto>, with "MSI HERALD-BE", similar to "Gigabyte
> WC-WIFI7" i
> 
> consistently get: "Unknown hardware version found for WCN7850: 0xf"
> 
> Which nails down to the question whether any of these adapter is already
> supported?
> 
> The M.2 NCM865 card as such seems to be supported.
> 
> I'm wondering about the difference, as there seems to be no additional
> logic compiled
> 
> on one of the two PCIe boards, just bit of glue logic.

For better support on ath12k driver issues please include the ath12k driver
list (I've added it to this reply).

In your original e-mail you said:
> I'm trying to get "MSI HERALD-BE NCM865" up and running within a kvm

The ath12k driver does not support running in a VM. Even prior ath11k-based
hardware doesn't support it.

For ath11k there are some manual steps that have made it work, so if you are
adventurous you can try doing something similar with ath12k. Refer to:
https://lore.kernel.org/all/adcb785e-4dc7-4c4a-b341-d53b72e13467@gmail.com/

/jeff

