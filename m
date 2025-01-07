Return-Path: <linux-wireless+bounces-17152-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8633CA044EA
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2025 16:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C06018850C0
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2025 15:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6558770FE;
	Tue,  7 Jan 2025 15:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F12tsU3E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CEE2940F
	for <linux-wireless@vger.kernel.org>; Tue,  7 Jan 2025 15:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736264460; cv=none; b=bLUXcbt+glpb7/NR1ekx9+yi3ClOo1Um3BROW8OTh73dSnrBiOOuPqevmtF1/1hG60THoDMvhWJpvv8FyYmRzqRbRk1x1Rswg8HyZwgTPBY+eyqj98fdS8J0LeIkH9zofpB8mpUgWPlw+jUUz9jPQhzfX3bfYkpXTU+IU2YpiOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736264460; c=relaxed/simple;
	bh=zY5fPz/piu6hVm42d+D5OrjggabVdRmWfGhJbCeTDEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N5pxNUEmkePajPHs7k2pnlMYxSuP3E3IpVn/sYfrx8CUxRtx+8G2xmJaoPwTFCfKW6E5E5D4AmGNQ6SyEe29eSufNfekQGyoEiPckyPo0qJQHnTU6XAhSt3bNxOsFwmSG6ZOl7cFqBlgpLsVlgJaZj4GTPELmgKXe4nK03enAl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F12tsU3E; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507A8WC8023356
	for <linux-wireless@vger.kernel.org>; Tue, 7 Jan 2025 15:40:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ROVA0dL8wI4IAQHMDzUiyFTOabzV8dS56bVqXyw3GZ4=; b=F12tsU3Eq2qn4Kfd
	kC7lTjxgi5xG80diarSdtHAXehXFtx7A+QxlRj9hcXdshYxP5y7lpPB3L/A5XreM
	5vB17u8zA2TsdQ8he1Nh+q3Ky1eIDmhIzBPe8RhIlKZRftu1J7uWdCAe1gB561Fq
	2yQ4a/CfGeBYkwY29xXaP7LmijOEkvQoRAVsLMSOXfLwdC2MWKhTsYYTgkg3t3lk
	nDpi/xsQlHJiQw/w5XlcDEnkUnf6XEstv4cg/+3n9c0NyIzQSCxiMk2GHv/k9lZX
	2dRgFkfuLFlv9x2htaVm1EqFvwNjqcZ52vdAKCF33OS+LdlRxWUce9pH568CO9S6
	cj/H8Q==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44128nrt5x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 07 Jan 2025 15:40:58 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2f46b7851fcso30332732a91.1
        for <linux-wireless@vger.kernel.org>; Tue, 07 Jan 2025 07:40:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736264457; x=1736869257;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ROVA0dL8wI4IAQHMDzUiyFTOabzV8dS56bVqXyw3GZ4=;
        b=DEJ9iqtjrpgl5hB38GcWvhttcE9PmJqJSwQJvKd3UDezj6490BIwENE2UqjTwtkZns
         7vJ9RQxJnc4F5iUmz22erP07QJGbtvOCBHLxDtdoeRhrz6WmR770S4FPkivbafOBQAI1
         2IixXS1eFWbwuSfxJtvY9/Nyp5ZBi1BI+F0LhG8wYMMXXyceQCGwWqmYUloGoi5VC1UV
         61VLxKIOwml2iKT1dSQayhSwYH0gY1+0+HRHmEjo9F7R8xVyLNDmltaoya39Ba2rk1+1
         sW020EVgs/8jcjsEBuk6HMW2kn7hTauswcqM0YYu6pvCsoOHwfRlhaX+8iGU1n7p96nx
         6LQA==
X-Gm-Message-State: AOJu0YyGCMFye5/yPxvRkIAYg4muj1fxTBY1O9sXW/VednUykBXJwbz7
	aqW/IKV384+ttj+FMo9h9PO3HxONz23H5GR2uru9k7A2RjvP+cC105JmbUezB1hPvq/K3WFdtI4
	/hrrdWAHF7tbDTAQeEwGERMWwSPkLSK0q4bK5lwS9P6UmrkWOdG6dqJ2BWPm6Tbffdw==
X-Gm-Gg: ASbGnct+FgoYq5pPFD2kW/VBkxpihV9pfGOfgjLhbco6Fp3TrbKIAydBVQRKg9/duAp
	UTFm5+aNUZqK2YHnX8i2PyXwa0Uh9uz/5X+q4gEjIFp61Mj1UO4N3PXLuKc6/dnvOElC+dockzI
	Xt9hdSdAhfH1C+7aeTgyorcZdFBwqMA/pDVJpALWhKOaloc8jw0mGQoVbfBAXKl+Q8QAW8Jt4qV
	ZECEuRkNttb5Zn6q2VSqeTmMzdp05B2IFlD3snYP1+D+WddppfxTqFGIjQUiP2wePj95W9Oe+FP
	JhLrczUqGfuH/QWyHSJiQ3WX0tY+afx7V2n+
X-Received: by 2002:a05:6a21:3103:b0:1e1:a932:4a40 with SMTP id adf61e73a8af0-1e5e043f517mr88507829637.4.1736264457236;
        Tue, 07 Jan 2025 07:40:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHjp+ZhxLliIVZRlUZrskzL3M9JEI4yPjtJg3ItDoSn7XQG5HubHTSgbcLZIzAmfwRzfhSf8Q==
X-Received: by 2002:a05:6a21:3103:b0:1e1:a932:4a40 with SMTP id adf61e73a8af0-1e5e043f517mr88507793637.4.1736264456857;
        Tue, 07 Jan 2025 07:40:56 -0800 (PST)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-89eaa1c4fdfsm24924629a12.60.2025.01.07.07.40.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 07:40:56 -0800 (PST)
Message-ID: <53c80072-319c-4a5e-ab40-4a61f0ef022b@oss.qualcomm.com>
Date: Tue, 7 Jan 2025 07:40:55 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: cfg80211: rearrange kernel document for sinfo
 structure
To: Johannes Berg <johannes@sipsolutions.net>,
        Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
References: <20250107041727.3810446-1-quic_sarishar@quicinc.com>
 <5f774e0f0e00138240108bc0e4028b588e1ac927.camel@sipsolutions.net>
 <f7738ed3-d27a-48a8-b0cc-cb52d47e54f9@quicinc.com>
 <00982f1dfed63df24aa5d836fad1c577201754ed.camel@sipsolutions.net>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <00982f1dfed63df24aa5d836fad1c577201754ed.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ptipA0qidkv-PhBSF_5m-XakKN5qYLOP
X-Proofpoint-ORIG-GUID: ptipA0qidkv-PhBSF_5m-XakKN5qYLOP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=985
 priorityscore=1501 bulkscore=0 clxscore=1015 suspectscore=0 mlxscore=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501070131

On 1/7/2025 3:12 AM, Johannes Berg wrote:
> On Tue, 2025-01-07 at 16:03 +0530, Sarika Sharma wrote:
>> Actually, there is ongoing work to extend sinfo for link-level details. 
>> While working on this, I noticed a documentation mismatch and decided to 
>> correct the existing documentation first, as it's good to have aligned 
>> structure and documentation.
> 
> Why do you think it's good? I don't even agree with that. The code
> should be laid out to minimize holes, but the docs can be laid out to
> group functionally related fields.

Without any documented guidance to that effect I had suggested this during
internal review to help minimize the size of the diffs where members are being
refactored out of sinfo into a new per-link struct.

But we can drop this since I think we'll be renaming some of the refactored
members and hence the diff will be big anyway.

/jeff

