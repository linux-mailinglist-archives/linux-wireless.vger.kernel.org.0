Return-Path: <linux-wireless+bounces-14257-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C8C9A6189
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 12:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3A35283C17
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 10:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0117C1E3779;
	Mon, 21 Oct 2024 10:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ohCUoCj5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244361E0DD6
	for <linux-wireless@vger.kernel.org>; Mon, 21 Oct 2024 10:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729505208; cv=none; b=Q0ZA0NhBXcyc6BPX6/g8u0+y27XLBunQSO20B9Qzd4h8c4Y39FexCWnADiu+6Dr30Ta2B5yhyhZM4boaYlWcUSd71HTU+Ae9sOalvhDP2IlI6s9nYhrxx0oucLl44Qeu8jxuyhj3oMTtoHEAUwu3l31KrYoioPCYUweLO8J3lRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729505208; c=relaxed/simple;
	bh=kwQD4wTMqVv9hr6SZl/ZIpxdiaBDvmy+28Pa2igQtMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UjNJ9ilZQYns0aIeL5/73JZgcIQ23JsJbdTQWDLd1W+z0HImG0JbB6AbfioW+mH6fKqOzbYMecBsWVWfsXtFLhE+DuL3jRD05MrarM7M/5K2P8JmdYA5WpTAdY2Iy4d5GDfQ5vdGlyuBYjyh5WZOE8pMCpLoypwcoaRdO7/OyMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ohCUoCj5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49LA3PUo015846;
	Mon, 21 Oct 2024 10:05:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	e2FSkyZiommDAWJXlldFvygwHhkgWob3Z1N6MuQpzJ4=; b=ohCUoCj5EWW92HTh
	eG/gq2wyHmBLITio3/HYRXYbl0FuBWUcW1JIjAY2jEcD4K3C+iupne5DRNX34O8V
	PCkSyatSk6yWTd31MkLUhnkiMr/dy5taiJG6fnFPGBLk5aKAG5K5i06wgJXuPIac
	by/ZObE+dgs+Dr66mXahzMNCnt1Vcnz7RrN9jIkIYkd6hGwcZLRHHB8ysosFyE2C
	aRRjXEgc+dPUIksRfyacPj0gykCtMZsM8hZ0sJiHXAUZdMkA06nlW2chQ9V00fBF
	hD+NIXMXl1BElDVK0Wvi4yiCuvMdIhfcduT3mT+UZyt91rvvNvcJUg6RGK17KaJt
	zQkpFw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42c6rbc6ee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 10:05:16 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49LA5FTS029074
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 10:05:15 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 21 Oct
 2024 03:05:14 -0700
Message-ID: <a45e6c7a-7348-45a1-9ce6-7a5425b21a36@quicinc.com>
Date: Mon, 21 Oct 2024 18:05:13 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: iwlwifi GTK rekey is not working with WPA3 SAE encryption
To: Johannes Berg <johannes@sipsolutions.net>
CC: linux-wireless <linux-wireless@vger.kernel.org>
References: <9840f652-7d4a-4693-90da-844174dc30f5@quicinc.com>
 <ee5e7f5020bc874f477def3b1ea79339f0812b40.camel@sipsolutions.net>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <ee5e7f5020bc874f477def3b1ea79339f0812b40.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Z66HCyC-h8S_HoUbRWzd_uD3IgU0_YkF
X-Proofpoint-GUID: Z66HCyC-h8S_HoUbRWzd_uD3IgU0_YkF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0
 impostorscore=0 phishscore=0 mlxlogscore=637 lowpriorityscore=0
 clxscore=1011 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410210072



On 10/21/2024 2:53 PM, Johannes Berg wrote:
>>
>> HW in use:
>>
>> 00:14.3 Network controller: Intel Corporation Ice Lake-LP PCH CNVi WiFi (rev 30)
>>         Subsystem: Rivet Networks Ice Lake-LP PCH CNVi WiFi
>>
> 
> I guess with the issue you're describing, the interesting part would be
> the precise _firmware_ version. There should be a line printed on driver
> load (or firmware crash) with the exact git revision (and hardware type,
> which would be easier than trying to map from the platform above.)
> 
the version is:

Oct 21 17:50:17 xps13 kernel: [  153.733492] Intel(R) Wireless WiFi driver for Linux
Oct 21 17:50:17 xps13 kernel: [  153.741608] iwlwifi 0000:00:14.3: Detected crf-id 0x3617, cnv-id 0x2000300 wfpm id 0x80000000
Oct 21 17:50:17 xps13 kernel: [  153.741637] iwlwifi 0000:00:14.3: PCI dev 34f0/1651, rev=0x332, rfid=0x10a100
Oct 21 17:50:17 xps13 kernel: [  153.741641] iwlwifi 0000:00:14.3: Detected Intel(R) Wi-Fi 6 AX203
Oct 21 17:50:17 xps13 kernel: [  153.754977] iwlwifi 0000:00:14.3: TLV_FW_FSEQ_VERSION: FSEQ Version: 89.3.35.37
Oct 21 17:50:17 xps13 kernel: [  153.758773] iwlwifi 0000:00:14.3: loaded firmware version 77.0b4c06ad.0 Qu-c0-hr-b0-77.ucode op_mode iwlmvm
Oct 21 17:50:18 xps13 kernel: [  154.006138] iwlwifi 0000:00:14.3: Detected RF HR B3, rfid=0x10a100
Oct 21 17:50:18 xps13 kernel: [  154.072512] iwlwifi 0000:00:14.3: base HW address: 0c:dd:24:6a:0e:2d
Oct 21 17:50:18 xps13 kernel: [  154.421002] iwlwifi 0000:00:14.3: Registered PHC clock: iwlwifi-PTP, with index: 0


> johannes


