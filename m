Return-Path: <linux-wireless+bounces-25993-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F4CB10BD8
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 15:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7CDC1CC772E
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 13:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E882D8367;
	Thu, 24 Jul 2025 13:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UJ6Ti3aK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664C92D6614
	for <linux-wireless@vger.kernel.org>; Thu, 24 Jul 2025 13:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753364930; cv=none; b=Hquq0GXYrqGjkhfyZxKdWZleyIq7iUFPOrILk4zI7QtllfxWKG03TMEjqehDx1YQ6Eu5HZf1HekVUu7GQboQ391exsLRhs9HwkgEX3uwUNO4eEA3lGqZr6INQ2tq6sznjOmU52qFLi6Quj31+BblTybjWeaImPoLadz4Pt7Kl3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753364930; c=relaxed/simple;
	bh=dohAmmkKZsPbPh6JXfwL4x37QOcnoLN8mLe5LMh2YAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VRwpmkIEJT8hD/D3pQSQSQzSUuIlHmh3Q/JMTt9siLTBkELZQl6BvUk4PjUQRwcOcLu4C2y8cygj2/w0Gwjn1EbSh1QRoTw9yJISJRPrpIiTJ+P079RUYbvkxIJas3DKHzFg3rCoXsSvj5iQ+X+TtnDwPwsBD7vmAM4ZynSoiU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UJ6Ti3aK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O9gjeg031246
	for <linux-wireless@vger.kernel.org>; Thu, 24 Jul 2025 13:48:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rGqrP/aQVaXySa58Rt8CvoRFTXgwU18B9470T3EO5aU=; b=UJ6Ti3aKRzzekPJl
	b1sq+Rc+0ZFTLYRdeTzXzhrCTip3KdOWL5ydHHzs4n7DEqlewhaMViPKWvDe2KuE
	IgRohc7vHdKXfQCv9dOn1mGk6t1rAWr9xEoYQ1rzom36fB8xkIoftBWlFmvmez2s
	D8bUu1wigpI6a8A6cin8BFiljuBIX1Qh0UcHT8lEvJD+TxFLjGCH+KUcIC2ClKIp
	WQyo+jbMxem6T1cnFlDKut2QUn+vWQs8JH1t85zw/GU1ppVxomnYr6CRPDDBBUpH
	r0PFWmdwlrPKixmK3JKsJjn2Ue7HmWI6ZGkBUEYx10/KY8s50ZHgeCHRkphP7KPT
	UxKtEA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48048vf8t0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 24 Jul 2025 13:48:48 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b0e0c573531so800412a12.3
        for <linux-wireless@vger.kernel.org>; Thu, 24 Jul 2025 06:48:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753364927; x=1753969727;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rGqrP/aQVaXySa58Rt8CvoRFTXgwU18B9470T3EO5aU=;
        b=hEm813nexRBKaFRB6kIqxEZQ0d74ODY2juiVWzhVDVqmCK947QKJS7w4LrwbXKjI1p
         Y7V+aUDCj1H6zSInsbJfYgNss4xC+oqDGj3jaqJeGyltBqAe4Fshbj6ifeXIBvW2nleg
         BBppAjQKOchbDFHqsSAU9MeqzT+FWyei28f1zRRFYc29Nv4mC9E5VEID0jLQ8kITZKho
         i59kZ67Ak7uB8HjadUa5HE6yH9kEpGJZKn6Y02GAwi0F0eJ5vc9/AeJyLItvEcehGVdz
         emIXNeiC8MYqeJ6UxnC7YwkXcHzPmValLqfC9laZNdlpNZxJFYyd8Ni0wdC2xNkm6XAB
         L5nQ==
X-Gm-Message-State: AOJu0Yx6QbsvUT1S7E0azV/NTplLIZS4VDlSVQaiH5x7ULtYnsLNau9e
	c589tMYp2HNTAxprfT7hAcX9WIwIO8hK2P+UHP6Myj9+I3fnoCy2jIkJ/KgcOZefUg97mSF9gbN
	iNYPOfviAkoG994usp2txyxQc9jup5nCs+lhWy/0dnPiel2JFE64ZruQE4SddS1lhYxwxa7PEom
	wpcQ==
X-Gm-Gg: ASbGncs4uFo8pBFnzGhXveoP5ELvWOxz8DW2a5wZi6c8/Itad57j+Ipae5UFuapfzkW
	fo+MKe9oHF2RbyOxt406aDdI9zfRPoRVcQcO8EXF3hhkWJLeki7BWd7pO0WwGphNWtreaTj0RAn
	FWjL3Sx/xO3x9Z4CnmZXtMQBfguhFtz36ov5jf9wg+WgnY42TSjszTW6oyK6f76CGlvI8KVssyF
	oyp+3+EO83NIKLK9M61qAWPEf7iCTjK2Eg+WjE370BwYfCwXs9aeNVMcWTPqWGszdQM/trB+rKJ
	TNcZRHJmSaAhNEGYqXLVOVxMEuWBnbK94uTY7UkAT9Cl0AhVSqJVQiSYB4bTST2chtvZIEfQWbs
	GYPn9GTn8cl6HYT+hsQY=
X-Received: by 2002:a05:6a20:4324:b0:218:96ad:720d with SMTP id adf61e73a8af0-23d48fa6829mr10616819637.1.1753364927409;
        Thu, 24 Jul 2025 06:48:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpMXglJxY9355KWoyV5236pDrOu8pQnRf7U+5SAGv42cxvOZrorpf9pzeVf+kpJ5Hej2ZTpQ==
X-Received: by 2002:a05:6a20:4324:b0:218:96ad:720d with SMTP id adf61e73a8af0-23d48fa6829mr10616782637.1.1753364926924;
        Thu, 24 Jul 2025 06:48:46 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-761adb7c079sm1756212b3a.26.2025.07.24.06.48.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 06:48:46 -0700 (PDT)
Message-ID: <0083826f-f58d-4df3-ad93-52adbd162c01@oss.qualcomm.com>
Date: Thu, 24 Jul 2025 06:48:45 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL net-next] wireless-next-2025-07-24
To: Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
References: <20250724100349.21564-3-johannes@sipsolutions.net>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250724100349.21564-3-johannes@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: WPfbBTXvMF1dTwR0BRSyRbQgSiD4rlQh
X-Authority-Analysis: v=2.4 cv=SYL3duRu c=1 sm=1 tr=0 ts=688239c0 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=2Dvxz2razoWmXKoefC4A:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDEwNSBTYWx0ZWRfX+h31grVTYz4+
 nzMunQRlGYf5jZQVDwvOrr/G9EiAcMskv7hoeq9mFK8xtOREeiyUy1dqoaoFPwqU846LETMJ55T
 96gomnCPEIOh1B91rED+graOLd01XHuI3/uqFkqr/5FCcvvM+LAURj1/YDbw2mPw5sFRNgjALQj
 MTYRgeu6tlB3gdM/jcxKIS/u8ckLu4i609jocJ5vDBsh7yNKGOcCUYkafWedoWQYMs8xFjupn2l
 e7jHxsB9ce5QVyG56otB0at/x0F0ICe4BKeBziyWANTaH4Oeel+zd+wI5fRjIc6/5efqT9XRnz+
 qbARgcITlJaLzlvx9j4wPb1J+UufH0EHMd0+h4q9v77M8Fa3vWBzzWWDJzOz8aVbxlL9Hqk2INp
 LkCHmB01AsoRiKey3bhIBbPZZNk4pAYXnQDRRpwgiayFeOBX9NweA3LvjVaqJ1gxZ8Z6FmIL
X-Proofpoint-ORIG-GUID: WPfbBTXvMF1dTwR0BRSyRbQgSiD4rlQh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=967
 lowpriorityscore=0 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507240105

On 7/24/2025 3:02 AM, Johannes Berg wrote:
> Hi,
> 
> Here's another, almost certainly final, set of changes
> for -next. If we (unexpectedly) get -rc8 _and_ there's
> something important to fix immediately I might send more,
> but at this point that seem unlikely.

FYI if there is an -rc8 then I will have a few patches I'll want pulled in.
Trying to get as much into v6.17 before we start our big refactoring of ath12k
to allow it to support both Wi-Fi 7 and Wi-Fi 8.

/jeff

