Return-Path: <linux-wireless+bounces-15843-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0985F9E15C6
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Dec 2024 09:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C35AD281E49
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Dec 2024 08:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39B61D4348;
	Tue,  3 Dec 2024 08:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hBGiVZPb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627EF1CEADD;
	Tue,  3 Dec 2024 08:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733214539; cv=none; b=kskk8HQ2cyd3Ecwe/vKhBD1ozJnNkv3oM3dxA1RqY+xLKFqLRDTx4v1VB9PNZdtVavdFFGBYTV9kQK7EYcnnKsbH8KQJDGfciD42YKbhnrDsieJmdzl14Jte6Yz0Ne2ctUZovVv0UeLuuc6RZKgFJK+o/D5kJ5LD9rzLad9iYx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733214539; c=relaxed/simple;
	bh=Xq5ghKrS6nkEZzS+1k8Gfr6kU2WuaJCFrshdevSI2BE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UXmgR5/IFwSxc6NhLdsJ1yEIhowBpz8bnsr2AQAIB6D1WnvfYzChmmTb32plRRH/7N8LH0cQ9r1zWC/3mHwpVtyu5h9hbA/BRN7XlPyNDx6+3qZZsnQHxTiSySX0CEFgdBOHTmNyLslzniM4MsiCfFhf1Vo6LRbPRvQbA6me8KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hBGiVZPb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B36N3Zv024524;
	Tue, 3 Dec 2024 08:28:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PoxayZ/Ep75tbDRlcroT8T9ljKtekUwd8MzgGdd+9u0=; b=hBGiVZPboZVEnVFT
	yxe8bJpA2pUXW9qve7Dwdg2OgzcIRmuxiAqW7QJGPaOW5LyZozbISL5EteC2gV7U
	htPY0ERvwnMnIAAq95lLzdDCvBU/SRCtc35JLRV6OnXCI9AZ1rnc9eHQLPTZoBJn
	3zda3tgjJwT4zmOQZWrUHwbQ//gXbzP20pQcoee+bK24POVU/zMYYZsZGUGuk/Sa
	UWaMLHso+0DPwCUBa1ugzZozHCaXNAI4aANhd9fqf4h9zz8V6rIZBK9ZZw7R0Nw3
	h65AJp7pM/oR1huRFKYhSPLw7AXwGL/peLLvsYZ762o5zDV0v4cGIGyVlvoP/S/G
	WqcmGg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 439vnyrabb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Dec 2024 08:28:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B38SoE7012996
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 3 Dec 2024 08:28:50 GMT
Received: from [10.231.194.79] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 3 Dec 2024
 00:28:48 -0800
Message-ID: <20bf2693-ce53-48e9-8b54-7e3273815033@quicinc.com>
Date: Tue, 3 Dec 2024 16:28:45 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: allow APs combination when dual stations
 are supported
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
CC: <ath11k@lists.infradead.org>, <jjohnson@kernel.org>, <kvalo@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
        <quic_cjhuang@quicinc.com>, <vbenes@redhat.com>
References: <7ccd4b98-9557-4a8b-b493-e01b157c71e2@quicinc.com>
 <20241203080407.100913-1-jtornosm@redhat.com>
Content-Language: en-US
From: "Yu Zhang (Yuriy)" <quic_yuzha@quicinc.com>
In-Reply-To: <20241203080407.100913-1-jtornosm@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: h59Aat92eRQXnNWi4cuVL5_TvCZWWJhC
X-Proofpoint-GUID: h59Aat92eRQXnNWi4cuVL5_TvCZWWJhC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 mlxlogscore=813 bulkscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412030072



On 12/3/2024 4:04 PM, Jose Ignacio Tornos Martinez wrote:
> Sorry, but your solution is not working for me.
> We need to be able to setup 2 APs, as it was possible before, and with your
> interface combinations it is not possible either.
> I was trying to create a second interface combination to recover the old
> scenario as well, but I couldn't, that is the reason why I have implemented
> this parameter.
> 
> Thanks
> 
> Best regards
> Jose Ignacio
> 
Which chip do you use?

I can't be sure about your scenario, but based on your description, I 
tried it on the 6855 and it works:
sh-5.1# iw dev
phy#0
         Interface wlan2
                 ifindex 6
                 wdev 0x3
                 addr 12:03:7f:21:84:11
                 ssid QSoftAP2
                 type AP
                 channel 149 (5745 MHz), width: 20 MHz, center1: 5745 MHz
                 txpower 18.00 dBm
                 multicast TXQ:
                         qsz-byt qsz-pkt flows   drops   marks   overlmt 
hashcol tx-bytes        tx-packets
                         0       0       0       0       0       0 
0       0               0
         Interface wlan1
                 ifindex 5
                 wdev 0x2
                 addr 02:03:7f:21:84:11
                 ssid QSoftAP1
                 type AP
                 channel 36 (5180 MHz), width: 20 MHz, center1: 5180 MHz
                 txpower 5.00 dBm
                 multicast TXQ:
                         qsz-byt qsz-pkt flows   drops   marks   overlmt 
hashcol tx-bytes        tx-packets
                         0       0       0       0       0       0 
0       0               0
         Interface wlan0
                 ifindex 4
                 wdev 0x1
                 addr 00:03:7f:21:84:11
                 type managed
                 txpower 18.00 dBm
                 multicast TXQ:
                         qsz-byt qsz-pkt flows   drops   marks   overlmt 
hashcol tx-bytes        tx-packets
                         0       0       0       0       0       0 
0       0               0

