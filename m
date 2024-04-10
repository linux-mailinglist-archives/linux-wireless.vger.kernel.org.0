Return-Path: <linux-wireless+bounces-6127-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A10E89FD71
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Apr 2024 18:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97F151C21925
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Apr 2024 16:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614A117B501;
	Wed, 10 Apr 2024 16:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PaefrWIf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D893153361;
	Wed, 10 Apr 2024 16:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712767949; cv=none; b=k9Qg8c8/iOthturJgm+VlQRC+mq1ZVvddVEEedyyUWR6e3RqdaN8waSg7xZsxpDWirYIOpIVUYWOjSmR1vWepCsskvHQ14bzuT8jT8NRFcjGGb8Jzuny8zHYOsk28qA6iXdjcyn3fefTMiWjLKo5twkZgXe8UAYFvsF4+/Ac8ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712767949; c=relaxed/simple;
	bh=PZ5Xd+5UAr5QCT79N09AiNz7T8/on2P/RvirmiBIQio=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=k/A3V1wTGKowy/1Vgiki8eAhD/LRhgho0WohsvoOaNUFlcLiSuhnaGvtGlSz59FmcooTYVSMKNBZF6JX/SnUPmfClPi1MWoCZ7taPSt4QrOqDNudWME66cnR+goFpdAWzIGQMryCfAvuEg4TZAKL6Q3thlC/T16wm+oW39ZecjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PaefrWIf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43ACJVCl015865;
	Wed, 10 Apr 2024 16:52:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=PZ5Xd+5UAr5QCT79N09AiNz7T8/on2P/RvirmiBIQio=; b=Pa
	efrWIfS+h+r+4XOBuFAiI5GuZhEuszSzCf490t7rPk6fA8sxaKNTK78NZ4EJuJed
	5xVPTGTSQ6GHsWl46XYqWYFGD4D9/l2hqRTlFItdSnOXc1pkEn6lKXs8mz7wylh4
	A+wsOSpBRyfqPkZgE7sVrNWvFqbIRRDQ6ym/ReTAiKc9oFLZEm7Igo6UUcd7sZzn
	H1VzRzrjUoSGTdJlZcSSuTTOfFB/rgVnTQ5Pm32HseF8vgnNkYAS+pa1zGRAmc4q
	zj7cqk4KgeoyIwp/1293M6acXLla5hiUJF80Lqyp4H0K3rPBDTiRUz8Mu4nkKrTZ
	pC1/DlCa6VMQnnor8S6A==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xdrkp9t9c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 16:52:17 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43AGqGuP018813
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 16:52:16 GMT
Received: from [10.110.37.144] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 10 Apr
 2024 09:52:15 -0700
Message-ID: <3c9ea861-3964-4ae3-9c49-06760ef15406@quicinc.com>
Date: Wed, 10 Apr 2024 09:52:14 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/13] wifi: nl80211: send underlying multi-hardware
 channel capabilities to user space
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>,
        Vasanthakumar Thiagarajan
	<quic_vthiagar@quicinc.com>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        Jakub Kicinski
	<kuba@kernel.org>
References: <20240328072916.1164195-1-quic_periyasa@quicinc.com>
 <20240328072916.1164195-3-quic_periyasa@quicinc.com>
 <6d92d0ba4a8764cd91cc20c4bd35613bcc41dfcd.camel@sipsolutions.net>
 <9d5c2f9f-19b5-af4d-8018-1eb97fac10d6@quicinc.com>
 <9d0f309da45ae657cd2ce0bc11a93d66e856ef64.camel@sipsolutions.net>
 <b455f267-9552-be3b-95b0-a036bfa8e14a@quicinc.com>
 <902dd36fa5ab0503377e558b92505fe499f666fa.camel@sipsolutions.net>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <902dd36fa5ab0503377e558b92505fe499f666fa.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: e_vJnnS5KvkjJl3oh0dXumNhbB-g4bzS
X-Proofpoint-ORIG-GUID: e_vJnnS5KvkjJl3oh0dXumNhbB-g4bzS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_04,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=853 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404100123

On 4/10/2024 12:59 AM, Johannes Berg wrote:
> I found the code that needs it later, just that Karthikeyan was using
> the wrong explanation for it ... I'd hoped he'd understand your own code
> better ;-)

Internally I'm stressing the need to provide sufficient information in these
patches so that you (and I!) can understand the entire scope. Please continue
to let us know when we are failing.

(bcc to our internal development list)

/jeff

