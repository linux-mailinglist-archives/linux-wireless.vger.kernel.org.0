Return-Path: <linux-wireless+bounces-5254-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FA188B394
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 23:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E582E1C3D1AD
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 22:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A8A71B49;
	Mon, 25 Mar 2024 22:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lfweCnAh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8D974E2E
	for <linux-wireless@vger.kernel.org>; Mon, 25 Mar 2024 22:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711404673; cv=none; b=hiMHW6xi8yM0aIr8FxJ38QGWw/+FyPTpFv9GUNY8NLnuV76AIn05BU0teH9CG/6psoeoFY1/F6y7n30eY5DxiQjrtFQt2c0HUL8PaFDrzJnfhWF+ydizKKWRswtRe++p46bjXqYm/yJpYTiz/NothOg69J2tpVUWNUi/WbDSJeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711404673; c=relaxed/simple;
	bh=43/KAOeJEOhIzs9eI1hxpC61uHliePsC4ZerMn82fU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=V5c54Cs4H+ZxjTIfpemQtru74yWvtRvbQRR8L3xmVFl/vl/0SNSBP0XgrAOaL52AMOR+QRlJIC4w427IItl5XgD+7MT3AoRJnn09V7fd/THLu7euzDxk4jj+8mGU9PzQXLKoy3TUUluvFLb2mAiGakKwoXSvCPD36Ai8xzF/zys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lfweCnAh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42PLf8TN029785;
	Mon, 25 Mar 2024 22:11:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=YpBSl8O78+PSY2dE+UGYMS+T0HSDA5iKZGlC/AUwaRI=; b=lf
	weCnAhcGe/MHUr6rD1w/WfWZsZ2pq0Fei1eKXva+feeygqq2rw6N436Io6BORGoA
	n+eqqZ6RymT++MY4XQfJ1RFHDMMzZv1qB9ZgsB16xcZbQQJTdSsU5ZV/3m7Zpne6
	OCma6NSIefre+uBet7NcrmRFr3JMoUS4tMWQkqbH0Fd5LSmm5f7qgc19qPEj/Qfc
	KiXeWS1zQpGykeFj/T1ZlscC85pa8R8Cgn8/+r2/4gLS7DNF0mF2Mo2zj7QosoYj
	amtOLDO/shG5mdjnYX6QQKgFJKoPK8NELXK48BH11Kfi0x02b7qirdVdwb7uYxkf
	1io3/NTuD/lt8Kl1b7kw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x392ms7ms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 22:11:07 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42PMB48t026557
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 22:11:04 GMT
Received: from [10.110.28.48] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 25 Mar
 2024 15:11:04 -0700
Message-ID: <35309bb8-f400-4b26-a217-cdecd4b43bd5@quicinc.com>
Date: Mon, 25 Mar 2024 15:10:58 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] wifi: mac80211: Add EHT UL MU-MIMO flag in
 ieee80211_bss_conf
Content-Language: en-US
To: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240325201031.10837-1-quic_pradeepc@quicinc.com>
 <20240325201031.10837-2-quic_pradeepc@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240325201031.10837-2-quic_pradeepc@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: fj_Fulrz6c9wfFVa0Hd-ltqVaVzY7-g0
X-Proofpoint-GUID: fj_Fulrz6c9wfFVa0Hd-ltqVaVzY7-g0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_22,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 mlxlogscore=824 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403250138

On 3/25/2024 1:10 PM, Pradeep Kumar Chitrapu wrote:
> Add flag for Full Bandwidth UL MU-MIMO for EHT. This is utilized
> to pass EHT MU-MIMO configurations from user space to driver in
> AP mode.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>


