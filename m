Return-Path: <linux-wireless+bounces-6901-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0AC8B2D43
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Apr 2024 00:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA20A281CFC
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 22:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5222E6CDB4;
	Thu, 25 Apr 2024 22:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="giq73Pi6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D0D3EA9B
	for <linux-wireless@vger.kernel.org>; Thu, 25 Apr 2024 22:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714085216; cv=none; b=SXowIFg1JG/YvcxWiHANzRgz7mDlu6t40ksa5TJX5JSnU1mFlfjIqDJ6/NzyBpc53dhioF27x7sz5T8o5HurkJHRNiHYmFQcWQ0JYFO98nTbbkCFzNJm8RtZVzGq4za29tV5mM9OiGI5jOf4gQ5f+57PP6PjNzBceWm6kVDU8B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714085216; c=relaxed/simple;
	bh=+lfbwEZM3ssJfOh4OMA1NbCsaUXgG8uGXAIyMyNe9AM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=s/60xiW2QDyyhvMmflQZERpY5uuc2u0pgrLpQXcpORxVeH6VNVpqvyIZL33AxRzkF+RKK7/b+BhAOxmAzY/12ePAgeguYRquQvq/yTDzb9jCGES8hUtiW3HBLM9f4BUZ9brgSGtfTP9wmcz8BcPgwRZmicwcm7k5QecyTR9L2A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=giq73Pi6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43PMZCHB010738;
	Thu, 25 Apr 2024 22:46:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=+lfbwEZM3ssJfOh4OMA1NbCsaUXgG8uGXAIyMyNe9AM=; b=gi
	q73Pi6c1fV8FRjWt8BIpZ7pkLtv0SZZqbpET+esAh8chMfx531NMEMskNpk8GzVa
	0FyU1kn3GHl8z3JkYrFcP0JrMtYHoGxBp/0IbbDk0CuP3rZIenzLwYdDx1Updav/
	j5lYWLEzhXPt0+2SMqPtAD6n1YdN+DVglpjlFaqhHGeB0PzIzn92HPB4yktg3IHd
	h8boHopIjNogNEQrm++2jSbenxomBgglxMOnc5J/T9M7dEFxeIcL7m8ppA0+ACQA
	sSZlnxo7YGt53OnwTuBrbg7JhTWy1Me4SRg/2oDSefzocf9pK3zGMeZGxFzBBEnZ
	VzTBDfykk2Fs5Uet3RhA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqenhuwck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 22:46:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43PMkoI2012380
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 22:46:50 GMT
Received: from [10.110.19.58] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 25 Apr
 2024 15:46:50 -0700
Message-ID: <026f333f-5f8d-43cd-bbcd-d55dcae0e976@quicinc.com>
Date: Thu, 25 Apr 2024 15:46:49 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/10] wifi: ath12k: push EHT MU-MIMO params from
 hostapd to hardware
Content-Language: en-US
To: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Muna Sinada <quic_msinada@quicinc.com>
References: <20240424201959.935-1-quic_pradeepc@quicinc.com>
 <20240424201959.935-4-quic_pradeepc@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240424201959.935-4-quic_pradeepc@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: nP87kKwpdd6jvJr4P13FAHNyVhtOTHu3
X-Proofpoint-GUID: nP87kKwpdd6jvJr4P13FAHNyVhtOTHu3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_21,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 mlxlogscore=599 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404250167

A couple of your patches, including this one, have subjects that refer to
hostapd. The driver should operate agnostic of the userpace entities that are
managing it, so please avoid referring to a specific userspace entity.

Describe the problem in terms of the operation being performed, not the entity
that is initiating the operation.


