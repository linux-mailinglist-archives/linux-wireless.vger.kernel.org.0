Return-Path: <linux-wireless+bounces-17170-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0CFA04DA9
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jan 2025 00:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32A6B3A4C46
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2025 23:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F78F273F9;
	Tue,  7 Jan 2025 23:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lt7H71nr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971C11F4E5C
	for <linux-wireless@vger.kernel.org>; Tue,  7 Jan 2025 23:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736293118; cv=none; b=Cn+S5PwynLbfkz2aPf2hQ7PaN0kgZXVJncsrSahStuE7TTAZhhqlbgmjtJYFyPkqK1J3cPYlyzDab/pXm2zRtooCa8LgkxRftMULyiR5Y4wu971mwws2Yp4BUGKF9qE7xdJjWySe+dYFOheJyIpGh2vm3zedna0vKrbZFwJgfAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736293118; c=relaxed/simple;
	bh=T72DYVbI99ip2XqzQLLdHIavS028Gl2D2YXuvyszPr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gSgcAmAOx6YrzV4dQ0jK5TjIRdES5a5uhES0kYD4N95KcolEes+2s273RiqKWZf7e8kUJqcAzFJ9oyyILNKm4va2y8hmPPFBkLOPVGXanE6JdNA3kcB2Ik6q9d3Gciv4LWYEFl765qxwHZ8hBcE42WZ7LaxyK5v5AE4SNblc5FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lt7H71nr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507L6VfO023921
	for <linux-wireless@vger.kernel.org>; Tue, 7 Jan 2025 23:38:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/OXOW4heDzfbMQ07OQGYi/eomE9Ei0nXstNi2ePc7UQ=; b=lt7H71nr5ZlkxQgt
	42qwhGtv8DmB1Xjacgcnx+R4Y/ICH0dWBpNhdWLo/9PfVwPeLpaq2XM/ObDp6i6u
	y3nb75lnu1gxF4lbSsYprXqWw55iGOaLQtUprM84qZ1FZVokDwk3928XruaXGhA9
	8jqnaDmsDXE4LRp6GaxSw3hRi/TyfKgEEyxaGZP4/Jku4cmFXCtDqCWzHPC8L3mx
	Wph3v/OF+DOTcknmIuNi9ZMo+kd0+Ricr1Bp+DZil16D2SpuFB7a9CCypzyJjyv7
	dgp7ODf957WqHmlcv35roI9EcSjBEkDMOr1kjrHO9kMfljgNLNxtwNmoatmfwts2
	yRjW2g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 441bvq08n4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 07 Jan 2025 23:38:35 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-21650d4612eso89383105ad.2
        for <linux-wireless@vger.kernel.org>; Tue, 07 Jan 2025 15:38:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736293114; x=1736897914;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/OXOW4heDzfbMQ07OQGYi/eomE9Ei0nXstNi2ePc7UQ=;
        b=I0d6ruWpGOJ9wnUpKRP4Gy3F1RF8zsWNDeY6Cow8mA2nvW/rgAkFdwuDOmYRpnRYBK
         J1YCjoPFs4RnTOyiAUKSvE4RPWFpdMC08T85j4KBLpxr65JAjb36EWLFrFl+N/aEYdm8
         s0skuaM2CpDXw4nqvdRE0kSrFgqa5MawTWiSw3+MiWwa/VrZPlrEcbLt6esFVnOquzDB
         SJ/3qFakWfzBR+7W0vcw5ZU6OF0JN4Sc8WUE50egnAwI2JtnvEqCAqy6BrF0ijNxGwga
         DCUq+hmwWUAKei5Q77rQncztQiTpDYHca/JpA9FPoDeeOAUFTPBHDLONf1LxtyBvE6lO
         bfXg==
X-Forwarded-Encrypted: i=1; AJvYcCVyQg4ALgKy/RAgBLoZO2+wka181ngScXXBh75WkHC1P7bjXgsv92gos2eL+oeJDiZJo71nfceLETM42zf/iw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwqEMTZHAnIUqJyve9IXqUxi9EV/ey4l9SyF9+H8ReX6VIk2jDc
	+En4aYFLRUiqlDbyNZ3p01s90jiAp25y5X/NTuqX/XYEte0M773vv/rjTGGFnxt6n5HRfhFtJd0
	s2eXZ+VAemVRzQc8jNr1MCcY/d5pdKz7cb81+X4hjWJHGEIoV7EaibqYcJDDJP/LxHQ==
X-Gm-Gg: ASbGncvKIWhPrJlyIW9bhqGAUO/O2uqs8RAx24eTb6ztUGoVCcDkeoW4K3UNY6SPgcp
	rbkXy2fIFNCogououJ/QdiC4Dz7S91XtueYphO65pEnd0LH0uPQseMN2iyR3atC/qF1oNgaz6hW
	WfQMqW4NmlK+pd4aFzLEufrTOdT4v3IjuL29xpQBJ3GMJgiCA5pwwl7X/W6HNFRIVFzpqmCJyJw
	CRJW0kEqpxj4oxl7TyleH8xyIE0q06RvZPmjGy+IcmmNAtD5So1JGu5jXV/+og/M+n9HR3YwOYB
	UOWvtbtAM0xpQK3hQcZ9D+rwTsu61I/a07Z5UTuixBc7Z50mpg==
X-Received: by 2002:a05:6a20:244d:b0:1e0:b5ae:8fc1 with SMTP id adf61e73a8af0-1e88cfa6852mr2133059637.13.1736293114008;
        Tue, 07 Jan 2025 15:38:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFYieOQL5DVKrFFboGaDv3rB+c6tkPaA2Lq7M09HgpEjKdIDfk9vyvwRMmgQFREUOCgiV2ECA==
X-Received: by 2002:a05:6a20:244d:b0:1e0:b5ae:8fc1 with SMTP id adf61e73a8af0-1e88cfa6852mr2133031637.13.1736293113626;
        Tue, 07 Jan 2025 15:38:33 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad816305sm33823525b3a.31.2025.01.07.15.38.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 15:38:33 -0800 (PST)
Message-ID: <c776b5ee-0e25-4d21-be21-dd318ae33d1e@oss.qualcomm.com>
Date: Tue, 7 Jan 2025 15:38:32 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] wifi: ath12k: Support Transmit Buffer OFDMA Stats
To: Kalle Valo <kvalo@kernel.org>,
        Roopni Devanathan <quic_rdevanat@quicinc.com>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
References: <20241128110949.3672364-1-quic_rdevanat@quicinc.com>
 <20241128110949.3672364-3-quic_rdevanat@quicinc.com>
 <87jzb6flwz.fsf@kernel.org>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <87jzb6flwz.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 3_QkOmkQ_95WnewKOW8QSX-mNNUxz419
X-Proofpoint-GUID: 3_QkOmkQ_95WnewKOW8QSX-mNNUxz419
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 phishscore=0 mlxlogscore=978 mlxscore=0
 suspectscore=0 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501070193

On 1/7/2025 11:45 AM, Kalle Valo wrote:
> Roopni Devanathan <quic_rdevanat@quicinc.com> writes:
>> From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
>> +	len--;
>> +	*(buf + len) = '\0';
> 
> Please avoid pointer arithmetic, this is simpler:
> 
> buf[len] = '\0';
> 
> Or should it be just 0 instead of '\0'? Don't know which one is
> preferred.
> 

well my take on this is we have a lot of similar pointer arithmetic already in
this and other debugfs files, including all of the scnprintf(buf + len, ...)
calls which could be scnprintf(&buf[len], ...). And we have existing instances
of trailing comma suppression in:
print_array_to_buf_index()
ath12k_htt_print_txbf_ofdma_ax_ndpa_stats_tlv()
ath12k_htt_print_txbf_ofdma_ax_ndp_stats_tlv()
and others, all of which assign '\0'

so this code looks ok to me.

that said, while i've been reviewing the debugfs implementations I thought the
code would look much cleaner if we had a wrapper function (or macro).

Note that the input to the current debugfs functions includes a struct
debug_htt_stats_req *stats_req that maintains the buffer pointer and filled
length. what if we had a wrapper that took just that, the format string, and
the optional arguments, and all of the pointer arithmetic is encapsulated in
that function, rather than being open coded?

so instead of:
	len += scnprintf(buf + len, buf_len - len, "some string"");
have simply:
	ath12k_scnprintf(stats_req, "some string");

that function would extract the buffer pointer and current filled length from
stats_req, calculate where to write the next string, call scnprintf() or
vscnprintf() to write the string, and then update the current filled length in
the stats_req. That would eliminate all of this housekeeping from the callers:
buf + len
buf_len - len
len += scnprintf(..)

/jeff


