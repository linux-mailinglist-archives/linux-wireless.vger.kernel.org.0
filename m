Return-Path: <linux-wireless+bounces-5960-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC0789B68A
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Apr 2024 05:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4857A2821BE
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Apr 2024 03:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E7C1877;
	Mon,  8 Apr 2024 03:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DJdHhsFH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1711C0DEB
	for <linux-wireless@vger.kernel.org>; Mon,  8 Apr 2024 03:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712547930; cv=none; b=Dm7iQ5mZRx0Wn6km8quYgOXj/7uuSaClATdpLtXurdmEGA8wm1xrCcQzNlFR1uzcFCwMuYGAXyK6C9ELOErFjSjCxM0XyHPmWuZAW/m/PQ0WtGWSZ0o5TWD7IAOoTAYdkeKr7QgOb9dIExq5NFC6bmdNTPX/oz7V1AHm3faJxpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712547930; c=relaxed/simple;
	bh=KkMb4R1kiGwcbhJ28fzrqFsccfh5lqjh3XObTE1A420=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CQ5DCLsstVnl2sAOG5toQOb0UUpC8bdCMSHcVFdU8T6W84KgJUBmiFVypHCAW1waHqgSSoQhU5rFe8FM4PwuHpX1FlR5CpnNE9dWqJ0IxqiMqrL+uKmf17tR1DzeTnAyiOHy5fstcBx79PxKLD5m5hgOOJ90o1cLULbEtxg55WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DJdHhsFH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4382BAUH008670;
	Mon, 8 Apr 2024 03:45:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=slJn6FOUMTMvis8dDeAmu+VeGEP7mYQVAl5wGZQXhhE=; b=DJ
	dHhsFHoUVdqUJ7lmgM5xiQiAsVBrsntIXUbHUKEteELM1Rrqc5SJf86xT2LaE8ns
	0mX50Avdn9CIFZIc8kzD8Bj9Vsoh0htVHwclhUvkKNCJYz629YkMFCTTRzBbCNEW
	2knSqF/wLqxG35bowLS7aedOW5glZYsIyrerbSiwu9BL5SZLyUzUUOMxOc2YDp0f
	GClQadGUj7CBKplBPM9BSk0yZ41O+3r59LiTIGLV9YZEs22JGYC4zxi5qNH+dAUL
	o68zhJdFF1h1jztyi0Mf+6RONNc/uLdpe4PvxeHn1hUmcGsd1/WuB5YCX0XhV43A
	PDQ1ZYUhRRpYaKtP+BKw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xaursjrrk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 03:45:19 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4383jIOc016128
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Apr 2024 03:45:18 GMT
Received: from [10.216.32.4] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 7 Apr 2024
 20:45:16 -0700
Message-ID: <bb9940b6-a858-48e1-bc1d-999340b8eb5d@quicinc.com>
Date: Mon, 8 Apr 2024 09:15:13 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mac80211: handle link ID during management Tx
Content-Language: en-US
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>
References: <20240326045242.3190611-1-quic_adisi@quicinc.com>
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <20240326045242.3190611-1-quic_adisi@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PgiqR9ZI64rlVfc0qdwRYZSxWuMZ2z0J
X-Proofpoint-ORIG-GUID: PgiqR9ZI64rlVfc0qdwRYZSxWuMZ2z0J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_01,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 clxscore=1011 spamscore=0 mlxlogscore=819 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404080026

On 3/26/24 10:22, Aditya Kumar Singh wrote:
> From: Sriram R <quic_srirrama@quicinc.com>
> 
> During management Tx, when source address is same as the link conf's
> address and even when userspace requested Tx on a specific link, link ID
> is not set which leads to dropping of the frame later.
> 
> Add changes to use the same link id and set it if the link bss is matching
> the requested channel.
> 
> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
> Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>


Hi Johannes,

Any further inputs?

This is a dependency for the hostapd series change -

[PATCH 00/22] hostapd: add cohosted MLO support
(https://patchwork.ozlabs.org/project/hostap/list/?series=400904)

The newly added test cases needs this kernel change.

- Aditya


