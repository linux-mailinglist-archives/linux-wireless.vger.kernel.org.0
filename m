Return-Path: <linux-wireless+bounces-5841-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E056A8977F8
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 20:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 174661C2267F
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 18:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E369153511;
	Wed,  3 Apr 2024 18:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZKzo1Aj9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8011534F2
	for <linux-wireless@vger.kernel.org>; Wed,  3 Apr 2024 18:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712168226; cv=none; b=kmt2VSTW6diojmCa481Np8stCSFnUl6Xakn+iO8haZmWU8dK1YIoN3VGNr24vFt4x2j7aDfswrLWlCjzihg9WjXJPfNNmT8vyaEV6K/GFg+0ffRqedVTddpmia2e7dATwcyJnac/MVe6YNySxUIOGiegqblcObpcMAy8oAleRTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712168226; c=relaxed/simple;
	bh=9Z4uXYM/k1iEg/a8oP2Scac0MMrBAmQTyNVZbuqJiyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=K1UJQfYOvK4sK8VmJ1pnu3vWZkbvLGPbMVKA2s7a9kNqsy5KxPfklTenXPbTuG1IQSC5ylw1kGhTboqKKLUaw6PHf0lPnxOxe4A7XIdEiTXJe0gywc5RfaIdwOGxLVvXOMUrQI3+zqbAdFDDYwTqLHfYzTxMVDmVi/ulkvuhr/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZKzo1Aj9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 433EAhgR019132;
	Wed, 3 Apr 2024 18:17:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=/9M3Qn0EuIcdC2HRRa/RV3G/cIedAwMvCJxX4WPF+Us=; b=ZK
	zo1Aj94LAw+v1/mP/eiDYFUqTuoh4i2qwmZ2ScSBnJiPk3l0kTrPlab2pUpbTqW5
	pUNkVGCRGLbXqhakMaFcr8/wMe9mG38YeSFxVTW31Gb/UH4b4BNbDtWknm8tFK9P
	hnEFdqifAksim7V/XfuNZSp4rE9VM9NfwXDl1uomKqvzC44VYuzFE2BC0jhur1va
	VVbIBCC3Ym5LqrOIDUw4WJ6vv0M488knuDk8UsJ4mjSoCFi8yZKJi51HIgL5der1
	JxfGRd01amHLtZ7btVaAuVsLL3yHpuhGzIJGS3usByiyxaTkJq0kUBwMba8qiYMN
	XIC8u0eQGCDcP980gumw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x93pw9fc6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 18:17:00 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 433IH0Li021109
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Apr 2024 18:17:00 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 3 Apr 2024
 11:16:59 -0700
Message-ID: <c3fbfb5b-aa5c-414d-98b4-64324f839df6@quicinc.com>
Date: Wed, 3 Apr 2024 11:16:59 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] wifi: ath12k: configure MBSSID params in vdev
 create/start
Content-Language: en-US
To: Aloka Dixit <quic_alokad@quicinc.com>, <ath12k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>
References: <20240402210538.7308-1-quic_alokad@quicinc.com>
 <20240402210538.7308-3-quic_alokad@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240402210538.7308-3-quic_alokad@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1WsL3pZtASGfPshNu_nIuGRNSYaXRYXs
X-Proofpoint-ORIG-GUID: 1WsL3pZtASGfPshNu_nIuGRNSYaXRYXs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_19,2024-04-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 phishscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 bulkscore=0 impostorscore=0 mlxlogscore=787
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2404030122

On 4/2/2024 2:05 PM, Aloka Dixit wrote:
> Configure multiple BSSID flags and vdev_id of the transmited profile
> in vdev create/start commands depending on the service bit
> WMI_TLV_SERVICE_MBSS_PARAM_IN_VDEV_START_SUPPORT.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>



