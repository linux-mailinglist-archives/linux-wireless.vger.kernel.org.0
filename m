Return-Path: <linux-wireless+bounces-19251-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2EDA3EBCB
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Feb 2025 05:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B4DB165F76
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Feb 2025 04:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A629B1D63F0;
	Fri, 21 Feb 2025 04:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h63G9IRR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D660C17C9F1
	for <linux-wireless@vger.kernel.org>; Fri, 21 Feb 2025 04:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740111630; cv=none; b=ncDEM3SBZsM3wr8eZkgEhNsVFMDFm62yy8YFzDX9PPybWOOaC0N5V4cUIErZ8rOR/l3aZGwZRwD/tgxixPHzlC9hNyBLzyWgz47emVLsMaUkPHJgJSWGAl3tnN9H/qRZWiCj4vrkWZiUo0pwi3UjRz16ugAlXws61TXOA6L1YyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740111630; c=relaxed/simple;
	bh=m9CJ42Pt7z+4ei0I3jWOxdEmImN146uDwChMn+996H8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PxzLu/8LjEKgfIbTE5zs8X60+eCIasPJoW91PO+jNEPt/3V6zRl09exzaFMQhZZ01Cc+jSGv3TZzd7nnfXwl5Aukydium1V6B9Hueg/1FCW6RhYm3TfdxxqynUzMeB4c7tcJU/IbGPXC4FPIY3zOIWUwTy8IwcBFxroRjY6ugBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h63G9IRR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51L4DJnX009745
	for <linux-wireless@vger.kernel.org>; Fri, 21 Feb 2025 04:20:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2ahKVge7tG8auzKckmrmQty95JVdReoaJrd58xKCWsY=; b=h63G9IRRBdzIjrD2
	gQIhaCYbNBHMjoPIM+DPjcusJZfYErElUJO0iRPF0ptUBRZSCR6CEZD18KF5YoNA
	pyYTkJHuXdrH3xl1qxot3rGhy9u6xsa23dr84czaff0JprB6r6qJAqHwO0QGBt+Q
	DvlGxNGGlAXfYGZl8mEUDrOJmWZ12vkaR+KFJwLZ+lh9emDwxCBy5MP4mK3d8Gyb
	CDsMTP+623FxAyHMzPHSibLAl77qnjr9jvkhTxdhJ+G/anprJD1ssb5QT2IVQ0e9
	XlBXLr5SWEoHAFZOLue/LyiBPM7cmUqFHk69uhi7Z8Yz4gERxANz9xIVIj60KKBl
	387fZw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy20fy8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 21 Feb 2025 04:20:27 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-220fff23644so44473155ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 20:20:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740111626; x=1740716426;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ahKVge7tG8auzKckmrmQty95JVdReoaJrd58xKCWsY=;
        b=q8EvwCGl/uXSq6OYqMtaJ9ao4VW9+yRujvstS7RDe3DJvdqlLLhScsFSH9tNUrTGoO
         xy3MQi9o1LkXa1+q0YPqyBW6e8Moylxgxcddryf5m4kB+LHpmIWwJlmxhKzQUzaeltbL
         bNqZDPEM18bjD00meMExQabdnE0WfRRiBSM7Vaqm8XQaXEJ5oBSCtyx3dJTEzGLIodtG
         bjFAZ24UQbTZGS24LpB64pAF84IKLjrEYZZh5msMeVAEHCAOF0b0qoSKTzNBPRZ2AtEo
         Hq/6Cph0DgztfiER1KHSdcuQvAHAIEB0oBrsrJoEhSLqek1cMou4wHwQM9RDCmHdKCj2
         Oopw==
X-Gm-Message-State: AOJu0YwFohV4qhDIXERXftReg63xxjZIoRdyvfZ92l8DMhhCDvPh8fIN
	jgdLgi7/c+m5FB4QFsiof4xHG6SBdMObMSaf8jVNXSVf7HPH0HchK8hZwHx9ryeVPtf5RzVUi6J
	3Np7LW+a984BbzWRelTXPrrW7TNBee4yr1vYe/zchRHKVM4LxXHnhSqzkEIsbqQjWjbOaXRNrEg
	==
X-Gm-Gg: ASbGncuY+2QFQyKlhM7H/J+RXqgT6U4jqbsCTFVK/P7GtRoV9wp/CXlraKQ5Fw4NsR9
	/Wr2WHkQbOxkDdCZKvXwo/EHU5AfVzf1uO+qB9SHqLD/cJrNZ1yRHd/6htLEBYi995NiWNxQZvj
	ZJMiyTxglHwZSQWIb8BUSPwI2o8nlmbq5h2saZ0ukMBwDPROfzhqC6sVaqmY4p0M/Ao3Fke0gFr
	1Aism3CnV6YXs+LrOGIJLfmaF6wRI9JakCb0jLMR0aWSGwPRaNcHiYDTSQPbzckbtNgHimASG/Y
	80buqHJFY2wSCHz5zHKBPcFdOcxacSSbRIN4sTPg9SEz5YyZnKBSLvtxXg==
X-Received: by 2002:a17:902:dacd:b0:21e:ff3a:7593 with SMTP id d9443c01a7336-2219ff336bamr23412255ad.6.1740111625816;
        Thu, 20 Feb 2025 20:20:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGYAZ0isTl26l+K+/h4SL5AimCIhTElJu3b3IN2jh30CEjYVe8OExqTwqjwKLTD3zqr6+fFOg==
X-Received: by 2002:a17:902:dacd:b0:21e:ff3a:7593 with SMTP id d9443c01a7336-2219ff336bamr23412075ad.6.1740111625488;
        Thu, 20 Feb 2025 20:20:25 -0800 (PST)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d53492d0sm128456335ad.35.2025.02.20.20.20.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 20:20:25 -0800 (PST)
Message-ID: <8cc7fb91-16a5-5458-6405-5fbcdd903c33@oss.qualcomm.com>
Date: Fri, 21 Feb 2025 09:50:22 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] wifi: ath12k: Add NULL check to validate tpc_stats
Content-Language: en-US
To: Roopni Devanathan <quic_rdevanat@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250221041250.769491-1-quic_rdevanat@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250221041250.769491-1-quic_rdevanat@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: LCT4lpqutLEyXpP0ZBKywCZw-QqTlqP0
X-Proofpoint-ORIG-GUID: LCT4lpqutLEyXpP0ZBKywCZw-QqTlqP0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_09,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=944 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502210029



On 2/21/2025 9:42 AM, Roopni Devanathan wrote:
> While processing TPC stats received from firmware, there are chances that
> the tpc_stats might not be filled and the data is not available. This can
> happen under two scenarios. First, when firmware sends a non-zero event
> count before event count 0. When this happens, tpc_stats will be checked
> for data before memory allocation and the tpc_stats will be unavailable.
> Second, when memory allocation failed when event count received is 0 and
> the firmware still sends a non-zero event. When this happens, memory will
> not be allocated for tpc_stats though event count is 0, so when non-zero
> event count is received, tpc_stats will be empty. There are checks to
> validate if tpc_stats variable is filled that are used in two subsequent
> places, but these are placed after tpc_stats is dereference without
> checking if it is NULL or has valid data.
> 
> Fix this by removing the mentioned checks and adding a NULL check after
> assigning tpc_stats to check if it is valid.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> 
> Closes: https://scan7.scan.coverity.com/#/project-view/52668/11354?selectedIssue=1637145
> Fixes: f0c3bb78e42f ("wifi: ath12k: Add Support to Parse TPC Event from Firmware")
> Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

