Return-Path: <linux-wireless+bounces-19775-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 518B1A4EBF9
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 19:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F0918A61A1
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 17:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018E778F39;
	Tue,  4 Mar 2025 17:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GxrQBiOv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DD927815C
	for <linux-wireless@vger.kernel.org>; Tue,  4 Mar 2025 17:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741109823; cv=none; b=fWJFWx+FRwXP7Vf1sRT7M0vzm7yW25hfpRqMler3f5AfAPDD5WYDFVGEWh66aL6LSz39sqINUvWTvlAyKfeorEXaXq6D0CUvtZRT4dxZkcgb8tqpn3Wn8w+xqp61ngTzmzVciswkwlk1XTKMISeUxqfk/h6ynGlwxCDvMW91fJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741109823; c=relaxed/simple;
	bh=fMPBH9whDhhZocTSmFENpQEm0m51WHNrqlz0wufLvUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KtuJ+7YJiO6R9aMizZIgZ6OW0NfR5bVTwH9+vBKhTEqqiTOkP0CT9ocyV2kxBdD1EEUVZnE1/pE929wKdhuuttphXwW9O0pOIUaiHjUnLHs7o3AKgj8rmQvS67vneW2FROdJoSFTdzEMhiycCT1FREau6UoUgMkHC2VWrj+7nAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GxrQBiOv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5249sClK019573
	for <linux-wireless@vger.kernel.org>; Tue, 4 Mar 2025 17:37:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fMPBH9whDhhZocTSmFENpQEm0m51WHNrqlz0wufLvUE=; b=GxrQBiOv/FKDd2/5
	ySbn+6eSCD7PzUQESQZ97PcZDA3PL7TMc7bhd4Dj5dGkoF72DtFhYGihyzCKDimh
	QJBdDRpi7NUNK1/H1R+5b0slszNDqkRvvN1W/78bBi8WIlN2AgSmXFSp+vyG7U+Q
	AkU4Iq/WBzY2KFOqU0k4arnxP2bvBrW0pYxAGDs7XGvUb/oo3Hmws8rTffflJLyD
	i3upzxz/feGqxCikDLG8a1GJdXt332LORAJ1ElG7XDIhnWLMNh9uUnEna9p9UnPW
	WkiObYu6/564NDdE7BrueVxGhMi+6ZLTQ70Q4lVe4qzIE6S5H1KY3VWh9iSBZJH9
	wujz/g==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 455p6t2p52-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 04 Mar 2025 17:37:01 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-22355de1de8so104173745ad.1
        for <linux-wireless@vger.kernel.org>; Tue, 04 Mar 2025 09:37:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741109820; x=1741714620;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fMPBH9whDhhZocTSmFENpQEm0m51WHNrqlz0wufLvUE=;
        b=Gb6gLNDH4BGYfbDWbSFGITRXBYsMjoTf/6NPtsVxjyUXLC7376Ag9Bwf8+QCRgX3Op
         Zb1mp6/VHJ9Q5Q0Kn/lUU8bKHdcrjMcVyBLe04r4Ow1SXeUoWx/ng01Zn2Ch/9io6XCe
         I8KVIoWqFsDOclhSxRKaciel0NgFPy41NkteoJx9NltgYMht8RfVZJdcqwLXM4AV1Voq
         Tqlvtv1yUWJwg/qOaJgmCRiaFWPTZv7s1IvAZcRHd8NH7Qmqsts07S8Xlul58FgNzVx/
         7mpqHv1h7KTHT0FvTRZM53OquZ7O7lcxPOF5TwMJgeC7Wsbk4xAwxLxPoGc7FdAaFqr/
         cBfA==
X-Gm-Message-State: AOJu0YwcqSFEfuqY4ckQlLGm8x1mXUcfNKEX6QJRKF3uWmcgsXQQSEyK
	jHxZZ2aetQl9Mb0qHt4lhDiv3cP1OrradOvA3VmCLpfGn+w9mWlK04YfnTH5f1+g6u4yCsVjQ6M
	7F/zsP2vm6m3bOcEnlc4djI8Xhz5zTk+4kCbgNYn2omTIflgXIMxcxZonMoOrjWwzOg==
X-Gm-Gg: ASbGnctGcNk1P469Tg9z7iEC2syLXGiccgTBb46htWlU+Ys439Jaaa0YN/1phlB2ai1
	2tzQNbX3mdf0PpaX6hPsurJp8Rae7Kwm37KV6QeJM2Pml/xXDgoMPTAae1xO8HxnuPLHk9Q7KqD
	7rYoBtQHYv/rEp1SstgQ4sVmetn+rNdgjrAeIj6RJ0pcbPohGL1+DPGJkYe2Ct36AmuP8c6w/JY
	zMPk6cBiAtGSRnsYJqoxMdmO4Jc7ukBdUWyiRZTrK6vKIXS3w9p6jDluy420eg4sTmjvrFZzRmo
	hw4pBftE53axCgw1/GFvTc3cYPUufTjTNQOwOnaguknHSIhxnM+swbUncAo2yoY0dBQOKKg=
X-Received: by 2002:a17:902:e751:b0:223:3624:87b7 with SMTP id d9443c01a7336-223f1c81c29mr463745ad.13.1741109820411;
        Tue, 04 Mar 2025 09:37:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEDBzzNTgbhvaxB9lV356jrNGXZCtBSJY023NHNi55qmToPCa1RTuAfY6yPx7E78FmKbUKwyA==
X-Received: by 2002:a17:902:e751:b0:223:3624:87b7 with SMTP id d9443c01a7336-223f1c81c29mr463505ad.13.1741109820036;
        Tue, 04 Mar 2025 09:37:00 -0800 (PST)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501faa33sm97898575ad.66.2025.03.04.09.36.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 09:36:59 -0800 (PST)
Message-ID: <6eed9dae-7f4d-4757-9d49-b21aff8e802d@oss.qualcomm.com>
Date: Tue, 4 Mar 2025 09:36:58 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 7/9] wifi: ath12k: fix NULL access in assign channel
 context handler
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250222151926.379652-1-quic_periyasa@quicinc.com>
 <20250222151926.379652-8-quic_periyasa@quicinc.com>
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
In-Reply-To: <20250222151926.379652-8-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: hfNeVaQ3yx7fjuAINUxQTET-GC95Kc8f
X-Authority-Analysis: v=2.4 cv=KfMosRYD c=1 sm=1 tr=0 ts=67c73a3d cx=c_pps a=cmESyDAEBpBGqyK7t0alAg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=FWO0W7fNcufi70nTIj8A:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: hfNeVaQ3yx7fjuAINUxQTET-GC95Kc8f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_07,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 phishscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 mlxlogscore=984 adultscore=0
 bulkscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503040141

On 2/22/2025 7:19 AM, Karthikeyan Periyasamy wrote:
> Currently, when ath12k_mac_assign_vif_to_vdev() fails, the radio handle
> (ar) gets accessed fom the link VIF handle (arvif) for debug logging, This

WARNING:TYPO_SPELLING: 'fom' may be misspelled - perhaps 'from'?

> is incorrect. In the fail scenario, radio handle is NULL. Fix the NULL
> access, avoid radio handle access by moving to the hardware debug logging
> helper function (ath12k_hw_warn).

