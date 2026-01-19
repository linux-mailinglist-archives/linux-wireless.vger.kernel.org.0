Return-Path: <linux-wireless+bounces-30941-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AA8D39F4E
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jan 2026 08:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2ECC4300672B
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jan 2026 07:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD972494F0;
	Mon, 19 Jan 2026 07:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Uure3fB/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GKyP7i7g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B683C6A33B
	for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 07:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768806389; cv=none; b=FQS/wcp2SWc3Mx6PlckrXPwMMtT7AoCloiqQMm9SRm3ua1BG71zb8IUzcZa1jVG5FXi2IzUqcBW1PZ3Ljq3/0YIurkGMo+qGOTbTwbdznbtlMO6cfJlKsso+PTd6MdphskiJRjlI/MXtPDBgLMDtruH62RxWwk7PJJK5wXpanyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768806389; c=relaxed/simple;
	bh=yXxfhfaJnei8WzgGxbRwboeGLD4C+GK8Ypz92Cq/xl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SkQehGm66P6gTLhsalstXpGcSXigGsPnGrIVWMKwROamI6d57a/eDaeeEbfTLOaiEQIzX326JMMZ5JJUSJw+StaosYVguWB8Py/JkW2Asnf35+ac0Wy1ceFLm0zPT2yzdcO6A+vn2U8hRORlcpjf+NVleUnt0eZDorvsxxnpk7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Uure3fB/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GKyP7i7g; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60ILGHNJ3749040
	for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 07:06:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yXxfhfaJnei8WzgGxbRwboeGLD4C+GK8Ypz92Cq/xl0=; b=Uure3fB/xhwBGYgQ
	ofPsqUE39pFcZRdPhUEp+vf7voPvpKrh144bLa4zWMiuEmWkNlC4jWzNq7tNw0Z3
	FfMbZJEuUAN1BE+eW8LBasxS4o9KdTo3tduuouEivJso/8RRe6ubMK43Ynz4n48E
	MDqJ0JKr/PcJeeFOGIqGRAsOqxTo7dDF4DTpmQSzpPHEQ4LU7MmHgCBpwfLdQQwP
	Zs0GbdkmFkq9Ld3BWLi9PA6kTAa3QnoU4Mol9VYntsZlp7OwuOzXdWHWe3/mIcA6
	b6PKFHfUWCCLjfkyQohUYoJT0YWNN4/Sx3WukyDslohhLEXBqRKxgpfWB/xvheCQ
	lhlYvQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bs79eh21k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 07:06:27 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-29f2381ea85so90615125ad.0
        for <linux-wireless@vger.kernel.org>; Sun, 18 Jan 2026 23:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768806387; x=1769411187; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yXxfhfaJnei8WzgGxbRwboeGLD4C+GK8Ypz92Cq/xl0=;
        b=GKyP7i7gcmX2lvqnblImvLiUo4hTJQS7ZFOOWOV/5+V2X3AXC/+P2LWdp/OgzffAvh
         AqntZorQZPt32Mve/5W/qv16W5WHxuAF+mQcJcL9N3m4DbUOiNjSmleabO+g9MklKV4T
         y+J/Pkc1RgTSp0udkE2TWC34t4SP5JHEEukOWjjiVc3cHJdALgZsMuQRR2vDtH43Nacq
         CGjrbJBHE6m1yfWebHO3XV8EaXqkjHuWVtMLLgucrnzy5yk9XnNfNqGW9C4sicc4/Oqq
         0nOc+T/NGza4vrx7+tUHvEfOo2FGRsGX3LH7q9Y+1EskkTbna7veChelgMCd9dTuTX4h
         R6UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768806387; x=1769411187;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yXxfhfaJnei8WzgGxbRwboeGLD4C+GK8Ypz92Cq/xl0=;
        b=iJaoiD4msjR5ma7h+wdN7iw1WnJHBkU4iayowSg2aOy6G5kXv2JAjOQ41QEgflazgI
         LIJL5e58m0PQ7s06VuIIQTg6byCJeZvejig+d1sTxau84PWPPgHky5ZmtajPd2xufN4a
         sEJaK3BS5X0Xkb7XbhOF+Vav4jVvFNqN0FDcQ64J78LUzC77AxwDsizDDnCk9onpmZJp
         Ag/wAdi/qPbK5Yj+dN527jspZ0bhETP6hurGktJdHDe/x5oBtzNubAdf5y0/pyV6IsHH
         9Cek01qWZtBHnsRXQynVXAv/LeEvBd9rQ5I2VVnWxXOEBBBZkXO3l/0/7fGZkfZNcWyR
         ltBA==
X-Gm-Message-State: AOJu0Yx2Xc8G53uauSoHHiRf9+NqBmY6tyQvt1SJ/WRIAS1UEWPItdQP
	OZTXLZCu6MgARTWtpHnJQ5/+Rc1vMGcZvkoue5t3yYtCzLqAhL7ZnzzHNz8e1bYZNx1s5MfcHLv
	OevXrsJsVZ2wBCYxSQuaugznWkGIpg1ah5l2Mr3EaJ/lP+oWighdtpIKsqTG0E/SxefVSsg==
X-Gm-Gg: AZuq6aL13q7Yog9xKixncCcDwOaGwM4+wU6YVyA16zwN+jAn+cTJAfcn9Zg/l9xATIn
	MqmLZoAIGuI2yll4zmP4Drc6P66e3s/nK0wXoLhn4NIM5kDp1ymowBJjWzVC3OxoIgK+Uqp3J4f
	W/g1I+aEB6SVb9z448EtouUejr834LuFFcc9qmCKR/fW936sMN06PSKOaR4+KIesmp55R4zw2Ab
	uN0/OuHHSQkV1RmjkE/OKy3AZ/bMNs13Vf6BeTL0ya0MfcpgoaZHutwMwXWEZejwiPmELhZLfEf
	WmJ5bYLJ+XCtrqtRXm6IQyzfBpVT+nHXI/WaBJTOQLGfzzPN3cxXhTi5ZN2IqE2SAdAgA+MYfAs
	KcL6wG5ylB/0mc9u3K6zlBn3ap5OVek+emhhzWnhVbeU=
X-Received: by 2002:a17:902:c40e:b0:298:616a:ba93 with SMTP id d9443c01a7336-2a718857417mr80958645ad.9.1768806387245;
        Sun, 18 Jan 2026 23:06:27 -0800 (PST)
X-Received: by 2002:a17:902:c40e:b0:298:616a:ba93 with SMTP id d9443c01a7336-2a718857417mr80958505ad.9.1768806386799;
        Sun, 18 Jan 2026 23:06:26 -0800 (PST)
Received: from [192.168.1.10] ([122.177.243.119])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7193dedacsm85091615ad.58.2026.01.18.23.06.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jan 2026 23:06:26 -0800 (PST)
Message-ID: <df708bef-7300-4df1-a5b1-9acd2c346fe9@oss.qualcomm.com>
Date: Mon, 19 Jan 2026 12:36:10 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v4 0/9] wifi: cfg80211/mac80211: Add Support
 for EPPKE Authentication
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, ainy.kumari@oss.qualcomm.com,
        sai.magam@oss.qualcomm.com, quic_drohan@quicinc.com
References: <20260114111900.2196941-1-kavita.kavita@oss.qualcomm.com>
 <4f8e174edf63c00f3c277e86e7de472fb7520422.camel@sipsolutions.net>
Content-Language: en-US
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
In-Reply-To: <4f8e174edf63c00f3c277e86e7de472fb7520422.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDA1NyBTYWx0ZWRfX954HJk4PAMwB
 BjScTPFEMKCPBqu7rnsPUQy6Frb3GcyETULmd+qZ2FeVvAdVA7/e2SXpeYs2uewtrZQmmPRe2T4
 kwQ9JnsUNCHEayzg9XwZZp1Ie3DkJmRIdeoBvJWvAsEP8T7lXyDqLUzffFoZ0iwLrKfSGbFQ2dH
 G5J6/DSetnT7uI6uDXghfW8MAiVUw6qJiGqtUkOqT5baVHtNAu6F1xj58N7lZs8ej3wn5SrxMLE
 aV36LLhTydA4DrxqoW0ihsQfLYgtzYRursPdbv93CUtwiRTGYEnX1+CLb6jFE0F9kaAcpMBSRO7
 fmfMphOFpgYStPcriWj+z3K/Z6c51qXSPyV9ekbBg4p9jo9m/6LeAheJE1SqDlc5GmRGqrGN88T
 8CyVRTVP787Zabpvr/Wqz9KZkUIkbRsiwA13QO5JfvmmWlkmKdumPVXO7tzH8GL5A7r2JwJPXz1
 F4JhQ0fNWWjJWNfNQKQ==
X-Authority-Analysis: v=2.4 cv=NY3rFmD4 c=1 sm=1 tr=0 ts=696dd7f3 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=DU46sZVHPS8ldjTCDKEQHw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=H3jVFrJ92M4DT-wRHUMA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: 7ntnuW6czQBo9c_xUwYWva7OMVTdyERy
X-Proofpoint-GUID: 7ntnuW6czQBo9c_xUwYWva7OMVTdyERy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_01,2026-01-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601190057


On 1/16/2026 1:47 PM, Johannes Berg wrote:
> On Wed, 2026-01-14 at 16:48 +0530, Kavita Kavita wrote:
>> This patch series introduces support for the Enhanced Privacy
>> Protection Key Exchange (EPPKE) authentication protocol, as defined in
>> "IEEE P802.11bi/D3.0, 12.16.9". The implementation covers both AP and
>> non-AP STA modes, with clear separation in the commit descriptions.
>>
>> The changes have been validated end-to-end using the hwsim tool.
>>
>> During development and testing of EPPKE feature, we encountered an
>> issue in mac80211 related to incorrect AAD/Nonce computation for
>> management frames when MLO address translation is involved.
>> Depends-on: [PATCH wireless-next] wifi: mac80211: Fix AAD/Nonce
>> computation for management frames with MLO
>>
>> Without the patch, EPPKE functionality will fail for MLO connection.
> Because of that, I've only applied patches 1-8 for now, so the feature
> isn't enabled anywhere until we fix that issue.


Sure, Thank you.


>
> johannes

