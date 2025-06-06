Return-Path: <linux-wireless+bounces-23808-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90601AD0310
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Jun 2025 15:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E611189DDC7
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Jun 2025 13:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4F1288CB4;
	Fri,  6 Jun 2025 13:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fMT03DN9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F144288CB5
	for <linux-wireless@vger.kernel.org>; Fri,  6 Jun 2025 13:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749216142; cv=none; b=l97LSlo6E6jm4yOiu+o7CIY0oCpKc5vsM3Yz0fUqpj+Ui1vWN09q5xnQQ16yrjq9w77pWTrBEoxxyJOiWsdJ9aI7DDtaF+q1QfXeG2i2SLi2bvGBP38N3y7o3qNDGWq4pWigh7T7nOopNsg6HoRgeSR/3i3q/eaLweiawkyqbN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749216142; c=relaxed/simple;
	bh=gw+OpkMGtD4oEGsQLqDRy81eSGw60CFhynEqLZ2PA3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cW5yP/uukifNJ3O8esxso39GY5ypwj5GKzYJwgXW2p4HzHmOS3dMEFZo94YJeAWC6LdIsfM+Fic9Ed580EOYGWtuhZbBMjgqAp6sRp24gKFIe8KymK/xLOVEBQQs44iLMgdrhdWxjoSkFeCjC6n4+sZtf7OyRuk5uwcJ+bqkNgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fMT03DN9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5566mx6G013479
	for <linux-wireless@vger.kernel.org>; Fri, 6 Jun 2025 13:22:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t+Xoc8jQg9mSaFRDtWyg0thEc3VLpGKQWUrFkyaMVVY=; b=fMT03DN9PRrl+O1d
	PE72bzKOqeuSiMEGr44xy0XKb/34eLUwJ6sffuBqJjyizdrQk2OJ4AhGZ83yC55+
	az9vT1ZCdWpcwtkhtRsN9wwlG5Jp9Qik054uNRrbeczRXOaQ+dWdmqkTWQbk681J
	bQQ3FfXq5Z5LHdtk1UvxtvYcCig4j6/pQbo8CK17krgPcuukYZF3fQcox8frhZKl
	7WkajRt4gve+XRKtFn0ePCjYW+Ej/vmpdxG1v/gCXPAAOOEGe237ZqlnMU02MD74
	jW1xdSjOfNmRjRfRusZLkaIBA6qe+5lGSLZlzra6w4QfhwVTVpcvf4yrVC2xB54R
	ZAH7Aw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g8nvnmf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 06 Jun 2025 13:22:18 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-22aa75e6653so18185265ad.0
        for <linux-wireless@vger.kernel.org>; Fri, 06 Jun 2025 06:22:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749216137; x=1749820937;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t+Xoc8jQg9mSaFRDtWyg0thEc3VLpGKQWUrFkyaMVVY=;
        b=SsKRtSkEMSndh1i/4+PVd+dc3N7FbvKtRg8Exfeob91eNc+P2y0lM/MkCAFI49GBDk
         7niPq9XDZkvfb4oQ2wdW8Ve272Z0y9WLjCy7TECRJhVojkhHs3WqWKgq+63DTb4YUsWy
         3GRNiBL4VgMX68gE67u6RuTsVV7FaJC4MVAzbsRuBqEeGAMFLnyZEQS7aRZK2pvzknJs
         /fKW5OBWReUpaVZBPBwP6STv8lxSiEBZ/vPOHdBrltB3lLtw4DHWNLOcFNRucEssAC6N
         wL5eYVMeE/v/4Ikecx7St5pTKYoyNWDV8IQ8V/bd5QrQT/eWtk1lqqSt5pmx5s5H4H6I
         zDqA==
X-Gm-Message-State: AOJu0Yxr3YAG4L9ZT8TOmKHwfKEnpOdA1xygkoj4W9lzEI0onTMU+AFE
	CjRJG/WlKTdIpfgxXJZEtvnM9oS5RPg028QAOpjqN+1tMO94g/675d8PLXARymIHxkQCt7WG6sJ
	i+udwPp4k1g0GoxCkXpmXzxX3BGOLc0gA1d6vX0gjCk90mi4zyl14PvTvXSbno8Uo883GH6SqzK
	XVsg==
X-Gm-Gg: ASbGncvJ93/5qFopU7Ao21/stqadwCm1enW61gHU/s2iSWqOUsvOsXxoVrjA6jWFSTr
	GX782985fMoDybh5o1pl3JMM5cwB+wVA1tDWPwc3EW99EZT9101LU6KItQ3ozlXMSOPewfZz/Tw
	WGC7qiPVoVKB0xSucMMcSqMHa0PZDWZN4+5UsDIfjD5ltEu1qCifB7sm0wc+fmGz/MxB5WAjmVM
	NwdjWPHdGvWUBvGcipL7AIHC6+Citm69sYlB+jjkFSPUMo11Ls07VTVWiB3f/sopxD8hJmzFkY9
	Ee1inPT506YqjN8w3XpgwqgXxpPcTT7L7xer5GvVP1ROzUYeQVd1w+5/IQp/Tlt0co3mN7Xan+6
	iYAXTgVLyT0xRcHzy5mgkPpFPCsn2vg0Hz6Ij29znBoXfwA==
X-Received: by 2002:a17:902:d2c3:b0:234:bca7:2920 with SMTP id d9443c01a7336-23601d1870dmr52400785ad.24.1749216132116;
        Fri, 06 Jun 2025 06:22:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsI6ansVzfPzpY9PMXSQMUKHP5Xd4Qes2uNXHT+JrSwFFLoReCXfm9/USOKMsmeyKk9CSmiQ==
X-Received: by 2002:a17:902:d2c3:b0:234:bca7:2920 with SMTP id d9443c01a7336-23601d1870dmr52400465ad.24.1749216131675;
        Fri, 06 Jun 2025 06:22:11 -0700 (PDT)
Received: from [10.50.31.45] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236034108f2sm12044305ad.202.2025.06.06.06.22.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jun 2025 06:22:11 -0700 (PDT)
Message-ID: <5e6fd381-ead3-4212-9dac-a8d0109767b6@oss.qualcomm.com>
Date: Fri, 6 Jun 2025 18:52:07 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: allow beacon protection keys to be
 installed in hardware
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Nicolas Escande <nico.escande@gmail.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250421114711.3660911-1-karthikeyan.kathirvel@oss.qualcomm.com>
 <D9J8O65N947J.Y0LSNAOS0AYG@gmail.com>
 <57064b98-5950-4b9e-8d76-265e56127dd1@oss.qualcomm.com>
 <9605558d-e785-4eb8-a752-1f591eff393e@oss.qualcomm.com>
 <3249b83b-00e6-464a-a6ad-80e114ffd438@oss.qualcomm.com>
 <a949a8f5-1b08-4ba8-bd74-c2fd7fb754fc@oss.qualcomm.com>
Content-Language: en-US
From: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
In-Reply-To: <a949a8f5-1b08-4ba8-bd74-c2fd7fb754fc@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 9wfF2LmKjGFVyytxbk6g8PhIUJt1b-_v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDEyMSBTYWx0ZWRfX7tGRHCuKg37m
 dSTfUkX1GYKn26H6HfujttNUwSw6LFMeBxGDIyYRjaHsefJln7QW+09HFbzSW5gD9PaFRiqD2ib
 +vDwFWJByV7H++yGhX2ojZf4i+oT4kU6fChC9AyZZUMnMcueKNE6B6KeRXVu5TtuHxn9fW7LQy7
 8xIZpf8LaqIByvd528n6RI/VrAYUc6/fDcO2rQDTHGUeFLfGLrdh11Foj8/3Fsq4SkC8L55hYgZ
 3CPCelYr0zV8TaCafzR78W9bexWbMnxjuqJIvPjtKlnWazH6zPKIFBAVnpaupz2j0S4N1Ta9En8
 oQsL5PvF3a+c48Rh+8cstzcqMR0rBtxfTljmkBvgU+dFnQwos0bC6qi/0Hs+23cyY0tg/S1ne3n
 QFJAMf2j363WdCLPlpLCJHxxN8EjCPnW4A4XugAzdQH3ACctyWGSy02b81DntC5VUfNHj1Xj
X-Proofpoint-ORIG-GUID: 9wfF2LmKjGFVyytxbk6g8PhIUJt1b-_v
X-Authority-Analysis: v=2.4 cv=UphjN/wB c=1 sm=1 tr=0 ts=6842eb8a cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=_3B5WRsFI3aEWVz-x-QA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-06_04,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=862 clxscore=1015 malwarescore=0 adultscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506060121



On 6/5/2025 2:08 AM, Jeff Johnson wrote:
> On 6/4/2025 1:59 AM, Karthikeyan Kathirvel wrote:
>> On 5/9/2025 9:37 PM, Jeff Johnson wrote:
>>> Will you be spinning a v2? Note the dependent mac80211 change has merged.
>> Yes Jeff, we've identified and confirmed a firmware bug that gets
>> triggered during IGTK key installation, which leads to corruption of the
>> GTK keys in firmware. To work around this, I’ll send a new version where
>> IGTK uses software crypto. Once the firmware bug is resolved upstream,
>> we can re-enable hardware offload for IGTK.
> 
> Note that then means firmware must advertise that the correct support is
> present so that the host knows whether or not it can enable the offload.
> 
> /jeff

Noted.

