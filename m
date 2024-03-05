Return-Path: <linux-wireless+bounces-4386-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A7087246B
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Mar 2024 17:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 722E3B255CD
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Mar 2024 16:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD474D520;
	Tue,  5 Mar 2024 16:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ODimuXf1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA0CD2E5
	for <linux-wireless@vger.kernel.org>; Tue,  5 Mar 2024 16:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709656543; cv=none; b=dZMJPEsbGEISJkmtXAIg2mpaa+kNLqjU3dqwHH9C/htztXnXFI+KDIB91mNvI6u+zRRlRFccCbUiDFMEG3xc79oUplR6Kfaj0zJrKJ9okOPoeousDb413ezgAm/tu3KHdFCRaA1RM2nID1dUpbT2hWJ2pR4Twjk/u2R8UrnARZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709656543; c=relaxed/simple;
	bh=82XJLf1Eb6uzHGPDxnaWQI3e3hDlt9+HoaQMlKGt7/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BQwVILIWj211Yh1H67votIiaW2G9nixZlKxl//Y7uNZCWWgC0V8TaMSaOL8xeFvsTa3f3+VfG+ef/DKSkDTKAxECNzmtQRuYYvgB3dpYwrUSpPpqpubhyEGjl4g7Y9fkjh8F4q0QjNkdeZTafKDdtprTwjdictYmNMpKPrlBeMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ODimuXf1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 425DGSOF018176;
	Tue, 5 Mar 2024 16:35:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=G1nKvEpnVwmHSgNE4k0QmhA8Pnhk1wsypLBDbxRdgpI=; b=OD
	imuXf16aSxfPr8iFVn9rxWfp3qQG3r8JhYIVB5Lk6pkdChQ4OQCS5RzylYUjSHr+
	PSFhZoBRs2OnFtfAt3/TtIS3A9cevhJQl2xMkanF+/AC+m4ePXTateffeKrrt7fS
	XmNhEVXYKdD+dRLSrOJvM0tT++Q5Zx1wbUCB/vGo0Dd5eSSr3qn8gchox1Q5bnEs
	zBVac20F/prRQQme/lnub0KzYf1ZeSiaFfVoygt+fmQmj26uPbrKeGZC1tlLqIzo
	J6CoW2Ibf7MhepfwAYYVu5nkEV3N3SDOH9P0wVHwG14qwtMyKGY+lnyOH/IgiLCl
	OXz2I0Hn1ZvSiOGmFADQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wp07w0ypf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Mar 2024 16:35:37 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 425GZan8001633
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 5 Mar 2024 16:35:36 GMT
Received: from [10.216.7.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 5 Mar
 2024 08:35:34 -0800
Message-ID: <e873f69e-e4b8-4dd0-a54a-191e9826ab56@quicinc.com>
Date: Tue, 5 Mar 2024 22:05:30 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] Add JSON output options to 'iw' for scan results
To: Jeff Johnson <quic_jjohnson@quicinc.com>,
        Johannes Berg
	<johannes@sipsolutions.net>,
        Isaev Ruslan <legale.legale@gmail.com>,
        <linux-wireless@vger.kernel.org>
References: <5c5be485dcfceb44fc731e47758d6be3.legale.legale@gmail.com>
 <12f91b008d6f2b4e6241794d2852c1c84fe6c12c.camel@sipsolutions.net>
 <7eec23f3-5e1d-4787-bba3-6b06549db091@quicinc.com>
Content-Language: en-US
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <7eec23f3-5e1d-4787-bba3-6b06549db091@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: fznGPginGOejR45eDtUP3nXYujBJm4XA
X-Proofpoint-GUID: fznGPginGOejR45eDtUP3nXYujBJm4XA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_13,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 malwarescore=0 mlxlogscore=907 spamscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403050133

On 3/5/24 21:25, Jeff Johnson wrote:
> On 3/5/2024 1:41 AM, Johannes Berg wrote:
>> On Mon, 2024-03-04 at 23:01 +0300, Isaev Ruslan wrote:
>>> v5 changes:
>>> 	- add json print to print_ap_channel_report()
>>> 	- minor refactor open_json_object()
>>
>> Alright, yay, so mechanical submission issues out of the way, this looks
>> readable :)
> 
> 
> Did the v5 version hit the list? I don't see it, and neither does lore:
> <https://lore.kernel.org/all/5c5be485dcfceb44fc731e47758d6be3.legale.legale@gmail.com/>
> 
> I received v4 directly, not via the list, and that was addressed to
> "Undisclosed Recipients". lore also doesn't have v4:
> <https://lore.kernel.org/all/8a0ba4b33aedd96f303db7cfe966b83b.legale.legale@gmail.com/>
> 
> So I don't think the mechanical submission issues are out of the way
> unless the list rejected the patch due to size, which seems unlikely.
> 

Yes it did -
https://patchwork.kernel.org/project/linux-wireless/patch/d9739fa6d3dd085587c4f413087dfd6c.legale.legale@gmail.com/

Looks like the first reply started a separate thread. Probably 
--in-reply-to was missed.


