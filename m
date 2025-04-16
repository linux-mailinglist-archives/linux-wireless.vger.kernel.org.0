Return-Path: <linux-wireless+bounces-21607-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65175A90D22
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 22:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13D627AF884
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 20:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A61022A7EB;
	Wed, 16 Apr 2025 20:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bdAnfQLx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1190224AE3
	for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 20:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744835227; cv=none; b=QxZLCTirBOV2OiFScUsnGe99agD8aZKsgQYdv/0Jt+NnOL3bCjwGdcDM0hqAJvrGjNY7f9CV6djFCMOfR2HFDJpO/++ecxJqNhePVji8rbaWqhvc2UKQKY8PwdX2QrvY3WybWWP4Hk/sJTzeNgyrwsw9yiXV2WnUFHsF1Z1M3ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744835227; c=relaxed/simple;
	bh=XU+cG4Rl/BauvGaZuqJSxBXPHrt+N5HECp9+iIJrFUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DAMPV6YCiVj2RskaWjRMdk+cB3hwjSk8KdxbbyreeBBcPb2TrZk8+nBIcWKqd7CLzSfDQZJNRYnyQoL2rrYqenVnbhkzRL6Hy1KWlPQ1s0EC9PENueas8F24Yg02kZUnG8c+zhBx0GEefnZ4Agq5RaHmpl1jKIp3y5XIwriirBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bdAnfQLx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53G9mJws003645
	for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 20:27:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XU+cG4Rl/BauvGaZuqJSxBXPHrt+N5HECp9+iIJrFUI=; b=bdAnfQLxqVZGCsnY
	RH22UHKRIGaAfAKrhh+oUpqe6goVwFcCvkLr56UaT5Nat/Xqg5d3IpfnMJSPH68k
	AteP+6jdMdG/PtfMAWomBLP4sH7WLmT1ESR3VszOLhW96Dhkt91iNhc9V8O+Wk6Y
	bFpB9+Wvj9UvCO2b0NnqvWUQavDUO2PUoNEz4kSvAsq0zbs6swouXOPaQwfCkP6u
	mDwpCSuqv1OKfjmpFWzkmeCAl4VREJ8+tNIB/h2ZION03Ay0JzWrGOnGoggUd+00
	maYsIq6LI4PEx/fEbt/EleaMTCvYq8cVduS3wPhlFIo+qYJePGC7y4IcLbTJGFy8
	HLklCg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4628rva07j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 20:27:04 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-af5310c1ac1so19549a12.2
        for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 13:27:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744835224; x=1745440024;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XU+cG4Rl/BauvGaZuqJSxBXPHrt+N5HECp9+iIJrFUI=;
        b=eZqtQiOttqLTkH6r932xdqbDFKlmfvDtQ4Ci3Gg1M3NdG6XHAzu9cTBS4RncUQRg8H
         JSzeErtJi3iB2yc0TD94O/UJOtc8W1ExHRzLYYKVpTerF3O9YI8w75E7dPiLQoq1SZ2B
         kUJ7APgw0lD/Dt5c0SEDNzEVTxPlWuu0U36cIDRI+HAnF7xIpQRpMm2eBfEtYOCwLkQH
         Atw0O+Tq24ecUGmhjg6DPV7qf1kdSAYK6atoZEYez4nYGPDOWYIPGqCIQIqu3kG9k/2l
         B2ReqdcMcCF6F1fTO8N19esjQdRSwvwlawMqiU3KTpZ06itxkEnmf4hOMwEjNSl5mkwf
         2afA==
X-Gm-Message-State: AOJu0Yysne3TyINOwq7Fxo5TVl4AkrGjVM5Dhd1c0j5rCpnmqZUWfyEp
	7VuKKHyOYRy/Lq5pRF/ffg/Vxt8eeX9mFFFYEkZ/yE8l4B4U2Wyh0XgIAP3oZ9/COCVTWq0ew3Q
	A5QN2Jm5GAYTHWsanTt3rh7z7ZNW2Wd7gGlD3VVstE0R+OH5YdxlbwEWcQsvkilG9eoFTd+k6bQ
	==
X-Gm-Gg: ASbGncs0i1DrN31dbZ4EMsAI8NwcJqFfdHbzvjGheqI0HeX6iA/FFLTXGV1bccOQ/X4
	XRMo5RxYbVWvHnW7vh45xGP9vjWE1HH+SkHb1NJDrpPMIa/LmKddrI9wubeYRAqXs2ZyRMbLOPo
	BKjA8V/vr0gvuDFED+mzYZJvvPGO21lG7eC0BdR3r9w60jORQWw+hmn4Qjg7ydloAfZpyRTzB4S
	fbZMeO9VoaG1WVVJNmQOgmYnBoUsWK7yLc1SD793cIKuA0FWzge44FjAlfJXBAobbfqqx/LcrAH
	3iVf+Wn/wnfslqxkdmd76yS1xXQFBK/2YsnOsa4OpTGl8SQII97pmnyVlMuH8mUALnFWmXQyPVc
	8u0cn
X-Received: by 2002:a17:90b:5188:b0:2fa:157e:c78e with SMTP id 98e67ed59e1d1-30863d1dd4bmr4826686a91.7.1744835223885;
        Wed, 16 Apr 2025 13:27:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuo7zvWoyCf/GU7A2RTisM4TY7siZHVq4sAVZKlpNh7JppDbecdnn/W7Fuo/7ITI3MuDLLrg==
X-Received: by 2002:a17:90b:5188:b0:2fa:157e:c78e with SMTP id 98e67ed59e1d1-30863d1dd4bmr4826663a91.7.1744835223529;
        Wed, 16 Apr 2025 13:27:03 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-308611f00f1sm2092884a91.13.2025.04.16.13.27.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 13:27:03 -0700 (PDT)
Message-ID: <3bacca4a-94c8-435c-a480-1c18c0f9f5f2@oss.qualcomm.com>
Date: Wed, 16 Apr 2025 13:27:02 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v2] wifi: ath12k: Add MSDU length validation for
 tkip mic error error
To: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, P Praneesh <quic_ppranees@quicinc.com>
References: <20250416021903.3178962-1-nithyanantham.paramasivam@oss.qualcomm.com>
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
In-Reply-To: <20250416021903.3178962-1-nithyanantham.paramasivam@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: FFXgdro1UxtEQK_7lXD3VU9FWBdY5udq
X-Authority-Analysis: v=2.4 cv=RbSQC0tv c=1 sm=1 tr=0 ts=68001298 cx=c_pps a=rz3CxIlbcmazkYymdCej/Q==:117 a=e70TP3dOR9hTogukJ0528Q==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=pYjfoAi3eAWinmu-FJwA:9 a=QEXdDO2ut3YA:10 a=AurkjTAPaLoA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: FFXgdro1UxtEQK_7lXD3VU9FWBdY5udq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_08,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=481
 suspectscore=0 adultscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 phishscore=0 priorityscore=1501 spamscore=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504160167

On 4/15/2025 7:19 PM, Nithyanantham Paramasivam wrote:
> From: P Praneesh <quic_ppranees@quicinc.com>

In the subject: s/tkip mic error error/TKIP MIC error/

no need to repost just for this; i can make that cleanup in 'pending'


