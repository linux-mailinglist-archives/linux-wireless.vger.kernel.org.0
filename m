Return-Path: <linux-wireless+bounces-26208-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0E1B1DC5B
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Aug 2025 19:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E02107AAB94
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Aug 2025 17:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711791EB1AA;
	Thu,  7 Aug 2025 17:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bz6yMIvr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046C93208
	for <linux-wireless@vger.kernel.org>; Thu,  7 Aug 2025 17:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754587119; cv=none; b=rUikkhP2DFyS1a75sV4bI4Qqiyea92ntnOSXhqZyRKz99hBqbZ8EB0gv5hdG9tQ6tUAB5bKJSOfJD7tMCmkCKBq42CF2djKKhZrDwtKQ8zol5yvrb+XkKMmGkeqwG7kH/WP2gqNBNfXxo3nU5R5uC4HTt9a9jRGeUrQwga/SD2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754587119; c=relaxed/simple;
	bh=ix4wfzIRuANwVsXaP/80+i/iUtqcmQAOhg9cFDtjiV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d1V4WxZCRIhv85531OfTNdCINbvIcV6NtIownnoy6IPTDtoD0sgUZWjrGzLCFffsbvlOF8fM0tC+eJj6EB55KghyM4c0m4DEkSkkMse9uNaHAYBkVPZsy/9lO6yslDYqZB1GOb+83zuxvKQ36tJIBd9W9mI0wAOXZ3hFz3snyjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bz6yMIvr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5779DDde011920
	for <linux-wireless@vger.kernel.org>; Thu, 7 Aug 2025 17:18:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nLC8GBJ52JS4DT8cnivnM/XJofTs0u4QYcTbqVdpwM0=; b=bz6yMIvrF9kz4XD5
	JXh1ZKRAyPHsw7ms/x/AUct7v/ZICwoDIGWBEoXLH+y3rHmxk0r2ynysiQgGvbK5
	M1NeeLuLYhvy6mhM3394k5ccr3MZ6tgu54fwlz1o+LVJbRoRdvMbRq4zz2hqrQXc
	Klmc41t1EACwREobXBIWgMsIqpIb2TI4id8u3aWiwszLy8ISiEzfp3e2gSL2xCN1
	SlryyDV+M26I+zlwStMSAxdGM4AG8wsFy8c9HS18M+Z4ZGYqD/xyoMy0z0TQ+j7o
	mhIRzysGp+bw0kpmFtT5fTjzrl5jsOVQvzLOOdXJIzeEYIkATxpAVsyK9rYrtHr2
	ij5G1w==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48cpvy1thg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 07 Aug 2025 17:18:37 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3215b3229c7so1404135a91.2
        for <linux-wireless@vger.kernel.org>; Thu, 07 Aug 2025 10:18:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754587116; x=1755191916;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nLC8GBJ52JS4DT8cnivnM/XJofTs0u4QYcTbqVdpwM0=;
        b=vlx/06QXW0qkrUd/AUMmGrJ7bZgsmCg7Xbvqvq2ZuCWeP8qa8hTMHnObYBvasZtunC
         hLXUgOew+vDHuDesT8skjTIKHkYyvrUsl4DcYCYTWhiMQzmkMw/rqI1yMJH3ErrEytzH
         +uYC6wedeSuUh/e0FC2fQMXkRR6a12p04ZDP7aIx4zEu0W8uLqGj0/Jn/CoOKmaP/mzC
         dxkKRAit2GoEThx2SE26mRHMiM132IDeBrCvFS+tSclYX+zndRiEOxUE+vWw+CC/g6AJ
         P0p+KbZimZ0qc0INDZ5yXgqlxCKES+ENJ7mLlGHxXc8eyxjDIacwvltzhfY9rZv1/MW0
         x46w==
X-Forwarded-Encrypted: i=1; AJvYcCVNUuurr+g/dG6+wizJPYJHO0Ccijyzajbv98Wt/+CaEVRrmKokbktmJdz5gWzA7mAXDGGUadTwdObs3qVvkQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyT0uASCdqLRNzFHC82zOsJ56arZr24RuNDVlwOe9Dg6GoVQFEP
	65WGMNGDx+aG4zu/fjU/B4aZCdgWZHxjG1/g6lnsoMlGBzOV9cgwvwojkX54e5+YTsIipRe8rXl
	mnUmWhApvntluBeWmo4KPMC08tMjiSO+8SPGuXgOduCPNnlwvdd2F3yb0Oe34H3pUd1csEQ==
X-Gm-Gg: ASbGncvH8xSWJ4wtWISJCROiV2QS/22yiylTuvJiiO+5gm6h+3GG73wWHm7jB0kb0QU
	d94QNnGH4W1MMiJW+R5R1sP2UkS63vT4tAjVW1yw7mUfnqqUOOElHaVpoS5AvPmdTUFLgIEbbxf
	C4brO6m6bGtF8nX9A9BsmTpHWlko8NdGOX3iH6optjfEWTiM4Un3QUTntrOe+4/GB5mgyaJVjpt
	SLpf/EykBC7AfAhejOog3NKtdoBXm71/7j6sfqs/8LnbkA+F+5tnSjswQ3iSoUaRy8iqCyKaGeR
	6cODIEp5IqQAd764Ji7OSuSSjqHSE+JnCX0Ulj8DM+HTuEowKNc/2IWOEJzW41KjU1LawdjBBoL
	Sfsvcypgpu8co3dz1o5M=
X-Received: by 2002:a17:90b:3806:b0:311:d05c:936 with SMTP id 98e67ed59e1d1-32166ca78dbmr12228073a91.17.1754587116440;
        Thu, 07 Aug 2025 10:18:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDSBIxZMtyLHjJ8ZZPSYmQQchctU93wo3YtjIAb6ci0mllkfGZXT4TLleL1LzuppQ6KSZiwg==
X-Received: by 2002:a17:90b:3806:b0:311:d05c:936 with SMTP id 98e67ed59e1d1-32166ca78dbmr12228044a91.17.1754587116004;
        Thu, 07 Aug 2025 10:18:36 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3216129c8cfsm6088656a91.34.2025.08.07.10.18.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 10:18:35 -0700 (PDT)
Message-ID: <9b1f4ea5-2948-4807-a4d2-0efe7b672a4d@oss.qualcomm.com>
Date: Thu, 7 Aug 2025 10:18:33 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v3 3/3] soc: qcom: mdt_loader: Remove unused parameter
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-remoteproc@vger.kernel.org
References: <20250807074311.2381713-1-mukesh.ojha@oss.qualcomm.com>
 <20250807074311.2381713-3-mukesh.ojha@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250807074311.2381713-3-mukesh.ojha@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=TJpFS0la c=1 sm=1 tr=0 ts=6894dfed cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=NyTICe1PHtTOfF-B13wA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: 572QbYQ3J6d_SrGl41bABU2gdjbwBwiL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDA0NiBTYWx0ZWRfX3Hs2Z/lPCmOQ
 ZFeRKezwaYzFHIm+Xm2ygW1/U5hTtofnEqaTm6lcBsaumaIpVncLZCISXA48pYH2hd6p3P00I/I
 BKC0Fzg2RGnkJr4WKQqhh/j02E2QjkNRQz6yTydJx5B+YI1w/TvKgug9KorlNZuLssmLUcuLMEA
 vmJ2eC0XJ1eJph6EP9JG5IqoZocfziH2eFFdqdMT6grKBGr0fkkpS8CCW5fBvX26Bds/ikSLndi
 UpxYceBKs85DsXJ72ubuEK5OT0wpPW0IdB1KSUa8tq5Jh6oVpWlc1Pyl6O1DMDyE5OW90joR5E9
 cpaKTt/JoEJtLkvc4SHL6gCnLSN1Mxu4911Py8xOHTRawigt3GKbHlQeF6HjcDl4W4GqIydNilp
 w4PNmnVe
X-Proofpoint-ORIG-GUID: 572QbYQ3J6d_SrGl41bABU2gdjbwBwiL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_03,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 adultscore=0 spamscore=0 malwarescore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508070046

On 8/7/2025 12:43 AM, Mukesh Ojha wrote:
> fw_name in qcom_mdt_bins_are_split() seems unused now, it may have
> used in the past for logging it but due to code refactor this parameter
> is unused now.
> 
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

Reviewed-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>


