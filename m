Return-Path: <linux-wireless+bounces-16430-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9509F3C1A
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Dec 2024 22:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9109A16A0C2
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Dec 2024 21:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D221D0E26;
	Mon, 16 Dec 2024 20:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ofVYo+j0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6A61D47B4
	for <linux-wireless@vger.kernel.org>; Mon, 16 Dec 2024 20:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734382160; cv=none; b=kiGseU6Dt6mWTfQKuuM5YKeEa17EsJYn2t0Bn3aMoJlKp71Oir6uR+UZHPJKBSh2+Yw7sv0/GB26P1GRAsdzShB0Ckdf6kdVQyoNGKon8XksdrmO9TqO7xJFMLzwy3DO5qpVu1b7NfDj+/aLzHZeQRr0IXE+77UBBeISgyi3lPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734382160; c=relaxed/simple;
	bh=kcycNG+bwN6f5dXL5wyCtF4e0Kmb4YfvpjfhYnRSqcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bZDWY7eaZ+IJmS0XgZg148N3m5lxMCZbkzEJpq4GpEcIMx6TAwFCvPCpJVjmEtZMdgZg//Mc3fY+pBt4kzHvafC17S/+D8dzwtFNFEq3B4iCYfUm8kMnyGOa/XWYbUWsB7/cKlVSNvv9fAYVsQSa2NtQPv9hobORl4r2Z+Iim14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ofVYo+j0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGE5cFb013337
	for <linux-wireless@vger.kernel.org>; Mon, 16 Dec 2024 20:49:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	anA2jlQouZqs/KtQZgTzzrTT65T1vIzf5Zeno12iots=; b=ofVYo+j0Rac0BlV3
	zRdXpHfkHrbGIXERCTYL8E8apPqPLIrDztDaBeEWypmE5hT/J5vJIiNJUijAriuh
	VdVGOvhIW+nm4zC4xmgEj/bOMCzPSstmt54a34t2NpScTAKH/WCyDA3/mxs3j6bC
	Jk07xDIZ2EiMcZT+RJIrJ4xqRwOYtdYZ4EpN5+4jN+7YNOGoTTMzf9UimWuAbgGo
	KEHhjqU00FrHk6VoKHYTgCb3Fuzclq0y2iCKzQo/56je0CfX8CMBACJOOUmF5sY9
	nZFl6JjELjRmPTeBTeCVdzyLej1aTib6Y7h7X3hB4A0n14cQ2hldTBWH5T9hRDCi
	0eyu6g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43jnnus09a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 16 Dec 2024 20:49:17 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2162f80040aso39616955ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 16 Dec 2024 12:49:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734382156; x=1734986956;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=anA2jlQouZqs/KtQZgTzzrTT65T1vIzf5Zeno12iots=;
        b=cI/lOdSrZ+OgigbXmqbfqfsWmj3lyIQGKrsH9mQSqHwR4bbxKoMuHFk7tcipUbh/OT
         DsxCYOUK6CQwHSSSlgvAuX4Yu9bFyS1MgghkJP5Yo6MZiB1BNreStfGclgpoJIZ3AqBL
         I3X3z8ZwLsiB6zmvRS/6775Q7KWmY0qFDlIxziIqWuvdVCrVmVbj09Y44ktQ3nFAoYb7
         FOVdA9/HAsBxOfRkSr0s2OGX93NZ8Yiel9hh2eYJDNGNg2+mMPtQCBnhWUVBixF5qYRH
         IyVcIlnIhPIlKy9JJ5uhinsxMvSkrANYQTa7tca3r22D/U5lSe/cDjaIOYrAWQ2cnyKn
         LXyg==
X-Forwarded-Encrypted: i=1; AJvYcCWv+oj3CeHOZldXIVOuaY1rHlM5ggl+CyyW+Vd8fZt8NLM6T59M8p4/64iR598VZeyUFho+KKPZ653SGiywTg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwYPE2Pt7nMYOPpT4zW58zcKvwKODUBogbvGFC+3TLwJMRvaYEq
	KhhmHkUTHezjC9WcVCvwIDuwV4KvUHuK0diPANT2URsUmbL973lc8vtqTzJPLWR9PzUoJ8bBkiF
	jrr1Vp4ElIP5tVDYb6910P923m4qJEmXw6hBRWJlZKuPLoGK5as2PPIm5Jid2ay8FKA==
X-Gm-Gg: ASbGncvYeB8bWRtyAgtSuBO1wGzvtFS2vZtgJN20gy7E650coXwptbOaUvkNb/dvpGn
	q7/PsLAUDZG06otZrAFt3SmxGVa3NuxYwcOyTTzc16LOhSek9Xm7vpZuUlJDkEt+L5swAd42HHA
	MHhWTKfq56XQhlpj7+9yTGNyCjDTBsJlnDPMR7VvunBytSyzQvde9oBY3aH1HaAVTLbxP6/brgI
	kDwqKun8wo5XmYVWW0nyox1lO7uYDUkSqaVXsY8HI27hixadVK8lTpdWYGakQeFqSBiHLZVWEY1
	XuEggGPSJrRtQ+FiQ6XosUjKAyMi7swZ58QYvU/3eN+/d3qAEg==
X-Received: by 2002:a17:902:f545:b0:216:5b8b:9062 with SMTP id d9443c01a7336-21892a706c4mr203037435ad.54.1734382155845;
        Mon, 16 Dec 2024 12:49:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWk9BZqboU3KwoVaqiVx3b8FL9B1OgxFHeyI/TAlRb715kIMdwZ9CqdRLUEBmLRsARD7gw0Q==
X-Received: by 2002:a17:902:f545:b0:216:5b8b:9062 with SMTP id d9443c01a7336-21892a706c4mr203037115ad.54.1734382155473;
        Mon, 16 Dec 2024 12:49:15 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e6634fsm47133905ad.246.2024.12.16.12.49.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 12:49:15 -0800 (PST)
Message-ID: <feaad284-9dd4-40c2-b6c2-a2a8411598ef@oss.qualcomm.com>
Date: Mon, 16 Dec 2024 12:49:13 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/8] wifi: ath12k: MLO support part 7
To: Conor Dooley <conor@kernel.org>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: ath12k@lists.infradead.org, Kalle Valo <kvalo@kernel.org>,
        linux-wireless@vger.kernel.org, devicetree@vger.kernel.org
References: <20241211153432.775335-1-kvalo@kernel.org>
 <173436785894.3413746.14923997859754791913.b4-ty@oss.qualcomm.com>
 <20241216-moonlight-perpetual-d49029337c17@spud>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20241216-moonlight-perpetual-d49029337c17@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: m_ZFa0zSRcVqEKONfKdMBciHIcgyFMYT
X-Proofpoint-ORIG-GUID: m_ZFa0zSRcVqEKONfKdMBciHIcgyFMYT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412160171

On 12/16/2024 11:56 AM, Conor Dooley wrote:
> On Mon, Dec 16, 2024 at 08:50:58AM -0800, Jeff Johnson wrote:
>>
>> On Wed, 11 Dec 2024 17:34:24 +0200, Kalle Valo wrote:
>>> Implementing Multi-Link Operation (MLO) continues. Bindings document is added
>>> to get WSI information from DT (patch 1) with the code parsing the information
>>> (patch 2). Rest of the patches are about configuring MLO in firmware.
>>>
>>> Device Tree bindings were reviewed as RFC earlier:
>>>
>>> [RFC PATCH v3 1/5] dt-bindings: net: wireless: Describe ath12k PCI module with WSI
>>>
>>> [...]
>>
>> Applied, thanks!
>>
>> [1/8] dt-bindings: net: wireless: Describe ath12k PCI module with WSI
>>       commit: 30e36fa89d8266d9221ee992d4f43553a59a3431
> 
> Delayed through being unexpectedly afk last week, I left an r-b on v2 a
> few mins ago. I don't give a shit about getting credit for tags, but
> figured it was worth mentioning it on the applied version of the series.

Thanks for the review.
I've force pushed an update which contains your Reviewed-by: tag.

/jeff

