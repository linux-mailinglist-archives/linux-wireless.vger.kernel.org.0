Return-Path: <linux-wireless+bounces-2508-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C379683D1D3
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 01:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 161AFB2146C
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 00:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B6638C;
	Fri, 26 Jan 2024 00:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XwIo/eUv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FFD387
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jan 2024 00:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706230772; cv=none; b=YePPMqgqLkswDLTF2SJLgoebFEer9jM2nceRtt/Q7QI74CDXse4U11MKY8FkC+We33Dkz/rXKbjhQP2HODw3/Qpmb4uJ8ZZ6Oae4MRy1Ap5WFhkDUqZ4H8NY2o0C+/kRtfnaAqE+DIofuiYJ0lBY/qaZh2meGr/0nDiOYVZpJ+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706230772; c=relaxed/simple;
	bh=kOW/V5UPCfFIwG3bX04ZgImda4Q7F1uKJuNY5Rbys0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=T3ny6amJETBsFinJFmUySxu/OOjanFGUv1dRFW+eRnFMRRQCWbXpkmOr6ZntjjSOihrvU2SqTIWi9OxZVftZe3HKpMZQz4QoBSLS6yIKh9sZO1T0vj3sbq9ywf1HP+42yhOqORpa6j9tbO4x/INSG+5SblFoPbDad89Qw3Sh28w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XwIo/eUv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40Q0eIpr023251;
	Fri, 26 Jan 2024 00:59:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=8Xv+o0s5fOAuXamrRBja4CjRuHhxmpvitV9OXxVdR1g=; b=Xw
	Io/eUv7eTY118RTJtZMH/i0KdobxviLpSJVKrwzRQ01DTNHsQheBbywNDBpJw9FT
	WUYJkfs8ll4wSo4INGRi7UpNvFlsMJJTZt2vTTxD9dtt3LuFQ2NOhM/g79SOAmj5
	VxxFUp6c74ABzcYia8kDcqAfJbmnXqpvdTdrQLNlWN81x8fwygIgdq4vlt6LzRhP
	27C0DNGFWi4VYkpxGRKxRSW50S+IcH3XkG6lv56lSYkyoG5r78uWAjFEL9nT5XyH
	lMdqFLb3TQZku1Wa+Up2L2Lmi0mEySX+1dIeJ9ieD8qxPJ8h5ZstfohOzLNzi+Hz
	UCCOyOmO17H32GiCn4tw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vuqra1nd7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 00:59:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40Q0xO6L032227
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 00:59:24 GMT
Received: from [10.110.0.209] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 25 Jan
 2024 16:59:23 -0800
Message-ID: <28a76ce7-7950-47b3-a5f2-292c353ae548@quicinc.com>
Date: Thu, 25 Jan 2024 16:59:22 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: refactor the rfkill worker
Content-Language: en-US
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240125154555.3169706-1-quic_periyasa@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240125154555.3169706-1-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 34tn6Zozpzhb3oo7q3-h5kX4Fdsx_Qtr
X-Proofpoint-ORIG-GUID: 34tn6Zozpzhb3oo7q3-h5kX4Fdsx_Qtr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxlogscore=528 phishscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 malwarescore=0 mlxscore=0 impostorscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401260006

On 1/25/2024 7:45 AM, Karthikeyan Periyasamy wrote:
> Currently, the rfkill worker handler access mac80211 HW from the radio/link
> structure. This is will be incorrect for single wiphy model, as they will
> hold multiple link/radio structures. To fix this, access mac80211 HW based
> on the number of hardware in the SoC/chip. This approach makes the rfkill
> worker handler compatible with both multi wiphy and single wiphy models.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


