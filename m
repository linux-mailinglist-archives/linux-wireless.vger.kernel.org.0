Return-Path: <linux-wireless+bounces-31464-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WG+KOiS/gGl3AgMAu9opvQ
	(envelope-from <linux-wireless+bounces-31464-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 16:13:40 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 051E9CE002
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 16:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E9F193073B0B
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Feb 2026 15:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CB9376BCC;
	Mon,  2 Feb 2026 14:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="avRsWBs+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H4ax/Hcw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEF8374725
	for <linux-wireless@vger.kernel.org>; Mon,  2 Feb 2026 14:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770044312; cv=none; b=RUgUZG/FeGArpGpaF+yX1CDAPg22QbbLutFHSbesU7UqdnOxVpOM4H+NLgY5jT6xaXpgsG+VuqKy+6JOp+CuWS7zeyGGorxR4UakZAp9amo7SULcVBNbcCs4KZsxFO2JtSsciJq42KuiB9ftXIyUDf0+7K6hY30IK0FvExiPu64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770044312; c=relaxed/simple;
	bh=SZKmZXD2k/VLpjUaSnmLLCm6AdwFDtEDW0ZurDK4v5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qbz6s1uJBQ9MqjQqfr+su+bzH+l7+Wuu8lXM6wZiUSrj0EP63prUt5pjeJBtS9B5AqoQ2zp9EiegRlL/yUPqnStz1jDV/VVpA8113nlPr1oF6q8kJuFDtQKvIuC4i8ljKOS4lePQCKOpWUHhtOyTghqcxaIrSufglLsJf7VJ014=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=avRsWBs+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=H4ax/Hcw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 612B0Lvq2899840
	for <linux-wireless@vger.kernel.org>; Mon, 2 Feb 2026 14:58:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	b8Vp0KWOFlctdCON5JmlQmck84JpEvsvqViwQSYpYpY=; b=avRsWBs+1iUdoDZg
	PBpANb3ttQxC813CDNHdIH4DmWp0p7QX2jeCEXyjD7BUyLjKNtnx73MfQW+vCf3h
	OcPGQhRGjS5RXEwT9kNd9dSOZptpz37U5K1VL5aNbB4fVyFsYOWv+o/vFyaZ+PCQ
	ARbaZkH9C5//5sN2bpdMVU/SNmI7Fb2r405dTHkwrfhhwBzlQ1uhrSCEMJUXu1mA
	orw3B0B9dFWlud9u/7nLfWx5S2TF0r/owMPm5jbRdEDwHewGXuF9+alMHWk/dvD7
	xMUyJnhkF7Cafq3yrJPM6oaDMOQTTmzozUIP8rWHjOd92ZLd9BVI/1cogBfkUQKe
	unupsw==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c2tp0rmke-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 02 Feb 2026 14:58:29 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-124a5098029so11163240c88.0
        for <linux-wireless@vger.kernel.org>; Mon, 02 Feb 2026 06:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770044309; x=1770649109; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b8Vp0KWOFlctdCON5JmlQmck84JpEvsvqViwQSYpYpY=;
        b=H4ax/HcwdTE7iI1xSH2CfuotccLiCr9Dxj15tSzitbhS/k3VUI+KPXOjZ5SdEHxnZb
         X3saWQh73yffG5JD3I87xCRpCxi6jUUgZL8sE/19mujlje5gE0/ALEJqwLLBZL0XIHX1
         b4I87JhwrfmB4T6jjQ5KDCUXYCJ//IzIU/3tsDYbj86e99I62qBruEx5IM20MZFFdSV7
         TNnib3R23VRVm2Wt/T4NRRiEHl/bVoeVso/ljcAqU2S3mFzEY7lLJ3tkwPFenaBmTW5a
         yMIWLQdZIktv3syNxEyaqNWYXBfsWjD76dbCL2ZFVT9a5n9Pt9BnEKlnnT1CQAuhvTPx
         5l/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770044309; x=1770649109;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b8Vp0KWOFlctdCON5JmlQmck84JpEvsvqViwQSYpYpY=;
        b=o7XyHp33uP91A0hQkLHjZFKkyikI0q003g9qDb3zkPIv0vYKU7axMDs8rnwmHLLmeB
         JPIfDAl4YZ0xPxW8YPLJc0bgKYbMBZPYfYnWFXk7Lx9PUmJEW4ZGsYYLBeQyQ85cvHsX
         uAFdc8oeAXou/vYDi1EO5CgL0ZlWCc9a5JQrfMqcR86Qg4McScKSEzuInElvTt1GQkph
         D6ocgRVNgXFEbQgSKfMihgVhqtdRvIetEm1+Et+3QVxD1k/+h5lH+S2cdCrMgtsZE8bj
         01r7rbqYmjkU78ff6XUMVyjZimPAaWHp4CDN1N5RUn54aEOiiYVuNJKZfkDhCo8G/9zZ
         3cWQ==
X-Gm-Message-State: AOJu0YxsLrGvxLZ+T3lwnJkoK0NGB4A/QrgYGlMBFPeftrY4JDFJEehp
	ksIKOtbtPmcRhmeSKzlvIP0hcgJvCdPd76VvA4dKBrQXvvVBkX9OlaKmOlOoqrEMpbfLQPCC/O6
	8nh97RbO8dEK6qGffJEbiza/C4rfNQZCTmz+AAf4ky0LGs4qsT/symlz/K9dVMnHKr/yemQ==
X-Gm-Gg: AZuq6aKgMlegVoYVam3S4seYj4HRDHpmRPXfn29kB7A0RAXevRgLwOGgHrk5eb3LPlV
	bLavENjYI/2g4GGqk1fWtxurraiHrxgEPiaqJuGWQ0nB+DLR7susmGC8zoxeAUWESCT6n51iL44
	qeKy/skUBthQ3b9mKSSXNpa5wzlsHGLbKAkzf9XPzsGdlzOxntdrtziQmtgdDHclDedydc9U9uc
	si4xGonjdTftz264+VjlsTdEZZDNMPJQPvpquEUPaSMj+1h9Ff7JlYYBWFTz3Z/S7L7K+FOqK3G
	tbbxlAs/VeJcAC7qFglYbGYuQsUZ2nIQ8n8tq15Ve2lXq33lfZHNInQyTt/zlWpYq7j5jbcCyU/
	4S838Kl5ttIEvIR5cujAtQOJItn1R16Bx72AG9B+90yAL2e3Xz9qKCvbPOGw+IE86zgeaSw==
X-Received: by 2002:a05:7022:a8a:b0:11b:9386:a3bf with SMTP id a92af1059eb24-125c1042286mr6743049c88.42.1770044308858;
        Mon, 02 Feb 2026 06:58:28 -0800 (PST)
X-Received: by 2002:a05:7022:a8a:b0:11b:9386:a3bf with SMTP id a92af1059eb24-125c1042286mr6743026c88.42.1770044308315;
        Mon, 02 Feb 2026 06:58:28 -0800 (PST)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a170ca0esm20314655eec.15.2026.02.02.06.58.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 06:58:28 -0800 (PST)
Message-ID: <e675a59f-e053-4ffb-aca8-f18cf94e9670@oss.qualcomm.com>
Date: Mon, 2 Feb 2026 06:58:27 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/13] wifi: nl80211/cfg80211: add result reporting
 control for PD requests
To: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>,
        johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
References: <20260130160039.2823409-1-peddolla.reddy@oss.qualcomm.com>
 <20260130160039.2823409-11-peddolla.reddy@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260130160039.2823409-11-peddolla.reddy@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: bwAJel-WHj7RwEvPmcUYYvNpeBwjhBdI
X-Authority-Analysis: v=2.4 cv=VJ/QXtPX c=1 sm=1 tr=0 ts=6980bb95 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=R4XRkOP-yPQ6kiGeUUkA:9
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDExOCBTYWx0ZWRfX8KHv4rOGXUEV
 3INConrTQl7NUIpG6d4FhHo5F/71TpTb4e0MDvxOwjRXr9RynV1Y+SlOwS0cLyqsItSUouVlFTb
 Fv/BLu0E0Brkz/UMYy2MM9Zp3dh1Th5CvLM5oc8QQGd0JC+NIUpkCvWULYLCdv4WDpuSs2bDdoI
 cXmS9fyVv6L+nsDpkoOWaiI8IrHiOFeY582CZMwpFk8IAtll9vJklfNTmuhzMbit2DODZRHuhaI
 gjMg1gjW3kRz/laQnImoCJ6D4BAxx6xFNZZDn82FfKzg8Bck6G6TFPwd/JRj7Dzsq9uDdX0D1IG
 dZv8RfS2EooL+dLMKrerJhDnNeEaADchSnJZbGgyxTwLtBXvCxzD+ZWEpFTJl1HkhcrZmcq1sYg
 0epS37TYeY/DVKyQ87seO71K4cH9W2Jbjd1Th3fHi1j5wH6BmNAp2cPIjJkfbvP081PD+NTWY3Y
 NtAknive5JMwqhG8Lsw==
X-Proofpoint-GUID: bwAJel-WHj7RwEvPmcUYYvNpeBwjhBdI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_04,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602020118
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31464-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 051E9CE002
X-Rspamd-Action: no action

On 1/30/2026 8:00 AM, Peddolla Harshavardhan Reddy wrote:
> Add optional result reporting control for proximity detection
> (PD) requests, allowing userspace to disable ranging result
> reports when measurement data is not needed. This reduces
> unnecessary data transfer and processing overhead for
> applications that only require proximity detection without
> detailed ranging measurements.

describe the problem first

> 
> The implementation validates that result reporting control is

use imperative tense

> only used with PD requests and ensures proper configuration
> when operating as responder (RSTA role). For RSTA operations
> requesting results, either LMR feedback or range report must
> be enabled to provide a mechanism for result delivery. This
> prevents invalid configurations where results are requested
> but no delivery method is available.
> 
> Signed-off-by: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>

