Return-Path: <linux-wireless+bounces-5846-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A497B8977FF
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 20:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1F6A1C22312
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 18:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D7515356D;
	Wed,  3 Apr 2024 18:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QPx6d3YU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC2415356B
	for <linux-wireless@vger.kernel.org>; Wed,  3 Apr 2024 18:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712168243; cv=none; b=diZSnGXHGBB6PkWlf0iaq8Cw5cb6XWNb89leDsjQDjflZ0qgjmVLiwGm05KAhwZZC8bXKRwtfzelVxitBM7n8nGxdaAL0YQD2N0daoIcsXph7NNr7UTjQPSRUiSOKIbOPKLZt9lipKxS0Gsof17PPBxWMR2wUdX+W0YWQJi6Lmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712168243; c=relaxed/simple;
	bh=dBwd815h9Wqs6Hh3rugxbsuESBorZxtnTmlxexqkz+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fLyr7DBOiFUSH51dv6tNnpkqLimWznFNB53jGD05LB9gIIwgzM0Cr3T2D9Eb0B3W02+Jk8KOHPHu0fWmbxThpqp9pc2jKdaegCvRTyqtWmxpCw0Q8hgL+hiSpN5dwXlGjIW3vpTRN4iG6/aurYHC365BZeyf+9HXU0HTmQcg73Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QPx6d3YU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 433EfsH7012803;
	Wed, 3 Apr 2024 18:17:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=crUe7CFX78Cs/RfoZIW5DSMcdYOCZfq+Shoh3jCjvlM=; b=QP
	x6d3YU/I+JS4L/QG8shusr+yWxRMLnAyuUB7GYRSA+Oh2ja3G/z/ypodG0JpLrJ/
	CFM00P8e0ulySQ0ud34oZeuAsJNGP6En8fi/BPEgP9a3lqBsdbx9+KeEtrAtFdit
	My8G8BKN5jzrXdT5/vnqzgiXyL/gszflKGbuAjOHO+a5LVRDUcarxMUtfhXbD9Wb
	xylid50GBPUl1Rvg0tZfaBqA6NDV5Dq9ZG3OrZmC2wVx8mn+izyuHCO5gCpvgN9p
	ZWnr/wYBNqoJ/wr3yqS22CiTn+R38TN/kVZCnIjUwxHQQ2mkYCIR4PX+6kivXCI/
	qKBfwuR0ejGhFC89VHFA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x993u0hsg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 18:17:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 433IHJLP021826
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Apr 2024 18:17:19 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 3 Apr 2024
 11:17:19 -0700
Message-ID: <ee4e97e7-ec55-441b-8658-3d9f3f0ecbc9@quicinc.com>
Date: Wed, 3 Apr 2024 11:17:19 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] wifi: ath12k: add MBSSID beacon support
Content-Language: en-US
To: Aloka Dixit <quic_alokad@quicinc.com>, <ath12k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>
References: <20240402210538.7308-1-quic_alokad@quicinc.com>
 <20240402210538.7308-8-quic_alokad@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240402210538.7308-8-quic_alokad@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Gqdp83HynSj-IPF-tNr89db7ki2xvhHL
X-Proofpoint-ORIG-GUID: Gqdp83HynSj-IPF-tNr89db7ki2xvhHL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_19,2024-04-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
 mlxlogscore=945 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404030122

On 4/2/2024 2:05 PM, Aloka Dixit wrote:
> - A single beacon template is used for one multiple BSSID group as
> only one interface from group transmits the beacons. But firmware
> requires the host to send this template each time a nontransmitted
> interface is brought up. Hence, modify existing logic to retrieve
> the template from vif context of the transmitting interface. Also,
> firmware crashes if host sends a template for a nontransmitted
> interface which is already up, add a check to avoid this.
> - Set rsnie_present and wpaie_present fields for nontransmitted VAPs.
> - Send offset to the multiple BSSID element in the beacon template
> firmware.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>



