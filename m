Return-Path: <linux-wireless+bounces-25754-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CACEBB0C72B
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 17:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCE6A1AA0BB1
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 15:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD8428C85A;
	Mon, 21 Jul 2025 15:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hUeWniR4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109432E406
	for <linux-wireless@vger.kernel.org>; Mon, 21 Jul 2025 15:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753110172; cv=none; b=HEBQi7MEGsko6Poicd+2bswUktY1E0E9jy8ZJAcka95EwbNC71Tpslcw8oysm89SSBlFSAw8nDGZDX0c0TRz89aOaE3jUJFHIPDzWYcObe5jDTlOAWdrnZKDYliH7dyS6jxPG6KNFdYLmZjBtcOo+ETCH8eTwopZgQLQvbsen7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753110172; c=relaxed/simple;
	bh=eofeLjmAkk7W7YjS3cSK9gcatnYv8RmniWeC4jutwxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BKHaF+4xHk3wSfFLb8ayBb48DQ0Ciq50OzmMBxiSzA+XSLMBVH7EuSOoQ9iaagGJmG3q55Gh8V9i47RF68o7YgPtEyrArKIIovlnVOlBfj69c8OLw6+EfAxbGyRMHNhHmCz/nPFn/7e5azF4nf2jvoaGiWmcq9l/DEJC1DfWW8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hUeWniR4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LA4htc015762
	for <linux-wireless@vger.kernel.org>; Mon, 21 Jul 2025 15:02:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1CW4aMaaZ5mImU6JQMmqMB1qlsc8kOQ6Jf0KoRnrtK0=; b=hUeWniR4vW327qsZ
	FRwcFy79FPQcrtbKXEejuP4jwkgxB2HsuPqHrijVh3wN5Q10WVgatyRVkuT8YsmJ
	WR6xbs8C4+dsytZqWSqvRMqAWkCpJ/Fve3+453KV8Ak4azNHli2aCYKCcgxmSQ+M
	UYkFWIRukv/7Sksd2pa6eR3VcFXFVWN3x4/p0xkTaJUJMaJU4Uyt4lQbqtv9GZcF
	oTNu6ySLZkAWXJuMztE40MiR8YL4q24MYSPABU3ksFcFp7NeRBHrw41ekNbO0v7B
	MAWf8NFhDennRwEzPq9oepNjpD51LFAZY9WxekNNrMZZ1Nh4m3RgeJhFm1e8y4ga
	s5zUDA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 480451dp49-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 21 Jul 2025 15:02:49 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-23827190886so47447175ad.3
        for <linux-wireless@vger.kernel.org>; Mon, 21 Jul 2025 08:02:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753110168; x=1753714968;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1CW4aMaaZ5mImU6JQMmqMB1qlsc8kOQ6Jf0KoRnrtK0=;
        b=hb4P+6Ya56HTYVC4uMpv8lHiSVsBtNecZaO0RKaoJIeI7eHc6ZMCts26PpKEtpkQqV
         A4eHTdJN3SScSKyNFhw7iO1mY7t+1FwxcwrWz7eCWzQcBssMsesonq9MgqSrQ6dZNBXR
         fOol/RKOyPNZT7SNdhIjR0EKC1wE2gAXJjPUchhIax2EG0t5ixjed45idXxfuXG6GryC
         DIitMnji7w9P8q14YivcxTzUGXXl8AWMz5mlAYaaDe8R6m4g2XUpKaly2jtysBtH1NLe
         FBlN1WFv69/Ru4+ZzRHQu/ykbgb+r9xR2UdyHw6l8iP31JkO0cdQkon7t+vYlMIvG9ON
         Yuxg==
X-Gm-Message-State: AOJu0YxJkVFCVJOJcCh7VK/BY8VY6yKQ5K63z/UdPp9NztXd/UMb/O7M
	xE3jlOMobg1G3lxQIAEmOT3lHtfSTJvoCU4Ekzl5SImZNnOnqYSnMsgv9fGO4hBBiXJW4NTqmbb
	MtoEgSyzhJTZ6nVRZS9l6T+NzcyUKUOt1bY3JQOrHjLbsT4pdph0hoitUFGWAc4jwpGAxOhQdPx
	PWgQ==
X-Gm-Gg: ASbGncuYqTfqHsICrJQm4FLmOC9rnKS4RL9JysuHY3T48kVZqS/Kjyk01hQll4IIwev
	Dqmy4JUxCm4I4xWHVEn49UnYzrOOcwjYWU29f1WYeLMKEuKk9EWvidbR/Z01+yYQN0FmHXlvUmm
	yw0krfRyz99wCRVZcLbQVnQJuJpmCbbXTCwQjxO08DbxP+V/Smjb9zawCa3CyGnxXfnLxw8pteq
	nkzILIxKWPq1rwhBusUQ/oIaNLIfDmyTF4d4OmPGQK8IKv1+vjhkSCHwLziCq0uc5ZmGBoBTlfw
	Od6NaheQZ1UOxvQX+molc+f3Hc0eMXN82DuNsumaHejl8c2XGxYPzoGcfDVe56EzFToZd0fbeqp
	+0PiJe17HbkQ=
X-Received: by 2002:a17:903:2445:b0:234:de0a:b36e with SMTP id d9443c01a7336-23e25787fc8mr290709725ad.49.1753110167296;
        Mon, 21 Jul 2025 08:02:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2IYqBemqJkI7bKVlzfLxf9TkkqsVx/A2wifBAHj3ybtLf/ZKbY34M7YL+28bOIZsjriNcQA==
X-Received: by 2002:a17:903:2445:b0:234:de0a:b36e with SMTP id d9443c01a7336-23e25787fc8mr290707995ad.49.1753110165748;
        Mon, 21 Jul 2025 08:02:45 -0700 (PDT)
Received: from [192.168.225.142] ([157.49.224.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6b4a04sm59362985ad.91.2025.07.21.08.02.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 08:02:45 -0700 (PDT)
Message-ID: <3272b2f3-c5e6-7163-d2d8-61e6c81520c3@oss.qualcomm.com>
Date: Mon, 21 Jul 2025 20:32:41 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next] wifi: ath12k: Correct tid cleanup when tid setup
 fails
Content-Language: en-US
To: Sarika Sharma <quic_sarishar@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250721061749.886732-1-quic_sarishar@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250721061749.886732-1-quic_sarishar@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=EIMG00ZC c=1 sm=1 tr=0 ts=687e5699 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=jjkvTE25TcCRIAzKtE2jAA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=grRxx7Cr2Ne4EJ9EsKUA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: qMDlmg6693Xc8OqLz8ZW0Ka8hxZOFK21
X-Proofpoint-GUID: qMDlmg6693Xc8OqLz8ZW0Ka8hxZOFK21
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDEzMyBTYWx0ZWRfX9DxjWrJvncJq
 GmGhPRc3Y1dV000uEbgHoyA2bLJimQU63djtxHErRJSxedA3B4uQcoIbkHMS/IC0D4p/QGcXNwh
 WCn2p4vsh/YVxlPzyJKQTCPT00pg1fx5Y8/Sd7E+ZJpLNjOeNXX8onU0gCpcxV+EJtAbBlSnRBN
 9EkWmASWa/Yn1GibKWcDva0xN+LhAHKRq7gO+2mJHUfPC8F9Xg2XmaLmRvQG6SAtCVQvRdXlpWa
 +DOSXYb5Ac5GIXybmUkATG5/rEJM3WMD2chU7O3KIAtGKrA0CNsMAQQWxHVZceZXYG4Ve73k/bb
 YdH1+1H3ZWM2KFsk5pyUDjM4KzHZGrpReVbmnIm3dFDJ4ADpUnTHZOVOYJ+I96dDb7THJZNRIrl
 TmguLcWYMKia2YDUrvrKL1sis+d8XAUCt6hT4jdZqZKgbQjytgzN1SwQPxdX4Jra63oXl2eq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_04,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=808 phishscore=0 mlxscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507210133



On 7/21/2025 11:47 AM, Sarika Sharma wrote:
> Currently, if any error occurs during ath12k_dp_rx_peer_tid_setup(),
> the tid value is already incremented, even though the corresponding
> TID is not actually allocated. Proceed to
> ath12k_dp_rx_peer_tid_delete() starting from unallocated tid,
> which might leads to freeing unallocated TID and cause potential
> crash or out-of-bounds access.
> 
> Hence, fix by correctly decrementing tid before cleanup to match only
> the successfully allocated TIDs.
> 
> Also, remove tid-- from failure case of ath12k_dp_rx_peer_frag_setup(),
> as decrementing the tid before cleanup in loop will take care of this.
> 
> Compile tested only.
> 
> Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

