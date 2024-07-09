Return-Path: <linux-wireless+bounces-10093-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D129692ADD3
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 03:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E53D1F22D67
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 01:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C96128399;
	Tue,  9 Jul 2024 01:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CpGPIJbd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDF926AC9;
	Tue,  9 Jul 2024 01:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720488821; cv=none; b=nmuiiZwq2IHgjkwtxcZbuYgcQl7kRxthvarz5P4QGXJDa8vClyRjSS5yHI1m8QiXLFfXG1kvAx7KqfRTj1+2AUZ5MYMIrwx2/TmL3w/ecgqEsANXwxWqNdSm1ERstis9fJZePl9oIq0nHZsCjBcbK2wJEOfjsoFqdZyPAyzE2mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720488821; c=relaxed/simple;
	bh=OCq3tETqwMmCUBz5byIAyK9DCVEJ9QkYtNEN7Aazick=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Xc56zJHuJD5y1LhNAJ5UFvjjQpwIiuwtUZe3iTWEQXkHt2e3ZtKxtuJSPo3ufYzEsUCzv6wyu7wuiF0kFbArzqIXCvsEg0iJvPOo1dPbzkBQSxzI+vpUKgXD74La1CnEc+2VdEjDgtVF8J2/U3o8G2MTYK+2g2wskcC6pLveI8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CpGPIJbd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 468CIglf016601;
	Tue, 9 Jul 2024 01:33:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6TZ2gaa2Be+UXDU0zBE43v2WaClgrIHp6alI1YJXBT0=; b=CpGPIJbdtsEKr2N/
	gp4nRw6gYD4sIFxZyUbmP/gmyGNfU9OdZYrXe/RswxHFnP65a/oCorSppbfwm6Ic
	wwPBKTHurgZMR/w3fXZ8rlTnOdPLjw1HMFIwSEPNfFUWxjpxdUYOItCnnJLi36n6
	AtXydUnGI0h2/TfzNzl8JHORnjU4AaqLbzh6MVS9qolYfMMn4azystOMUNAOWVR+
	JhLBkweO//w0+Zpg9TzPndZvuX29S0QelPJXUHMBqXJ4RBeLYJ3LHJtfes8mQplZ
	qqS2wYi+LVhvdiJri2tx/eowBCSDTaJCJiJNLv1h7fuYAj5mTIEnfdlY/uArLnNN
	bHk5Lg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406xa6517m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 01:33:18 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4691XHbC011688
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jul 2024 01:33:17 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 8 Jul 2024
 18:33:15 -0700
Message-ID: <dec60af0-d439-4e72-ba07-358996532e9c@quicinc.com>
Date: Tue, 9 Jul 2024 09:33:13 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: invalid vht params rate 1920 100kbps nss 2 mcs 9
To: Kalle Valo <kvalo@kernel.org>
CC: Paul Menzel <pmenzel@molgen.mpg.de>, James Prestwood <prestwoj@gmail.com>,
        <linux-wireless@vger.kernel.org>, <ath10k@lists.infradead.org>,
        LKML
	<linux-kernel@vger.kernel.org>,
        Chun Wu <chunwu@qti.qualcomm.com>
References: <fba24cd3-4a1e-4072-8585-8402272788ff@molgen.mpg.de>
 <1faa7eee-ed1e-477b-940d-a5cf4478cf73@gmail.com> <87iky7mvxt.fsf@kernel.org>
 <37ba6cb0-d887-4fcf-b7dc-c93a5fc5900f@gmail.com> <875xu6mtgh.fsf@kernel.org>
 <f7faff80-864a-4411-ad28-4f1151bc1e51@quicinc.com>
 <082024ce-fdd4-4fb1-8055-6d25f7d2e524@molgen.mpg.de>
 <462c97dc-f366-4f75-9327-04d9424b819a@quicinc.com>
 <b30307fd-4417-4220-a3ac-e3e80f23105e@molgen.mpg.de>
 <ceddb62b-61dd-44c9-babd-cd375c5a147d@quicinc.com>
 <87sewkcgwr.fsf@kernel.org>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <87sewkcgwr.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ABLAPEmiHLTZX01Anr7hRqQbp2PtLObw
X-Proofpoint-ORIG-GUID: ABLAPEmiHLTZX01Anr7hRqQbp2PtLObw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_14,2024-07-08_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=636
 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 spamscore=0
 clxscore=1015 adultscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407090009



On 7/8/2024 6:33 PM, Kalle Valo wrote:
> Baochen Qiang <quic_bqiang@quicinc.com> writes:
> 
>>>>> 2.  invalid vht params rate 960 100kbps nss 1 mcs 9
>>>>> 3.  invalid vht params rate 1730 100kbps nss 2 mcs 9
>>>>> 4.  invalid vht params rate 1920 100kbps nss 2 mcs 9
>>>>
>>>> OK, these are due to mismatch between host and QCA6174 firmware, we
>>>> can update host to fix them.
>>
>> Kalle, the root cause to these three warnings are clear now and if you
>> agree I can submit patches to fix them. Or I can also wait until the
>> NSS 3 issue is clear.
> 
> I'm not sure why would we want to wait for the NSS 3 to be solved? Based
> on my (limited) understanding I think it would be good to submit patches
> for solved issues now.
Sure, will do today.

> 

