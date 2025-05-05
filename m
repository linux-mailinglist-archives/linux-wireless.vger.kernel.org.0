Return-Path: <linux-wireless+bounces-22462-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF70AA9AFB
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 19:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D97DD189E358
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 17:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E975264A86;
	Mon,  5 May 2025 17:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IyQbVtES"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5290C1A23B9
	for <linux-wireless@vger.kernel.org>; Mon,  5 May 2025 17:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746467217; cv=none; b=hnKHTHtbBaPTv4eRzGljgzPfjUFMnDVj5pdVt/FPjaDHCmAh142tIF3D35uH8jgkohGYHYvRvwVw3+X/j01/J/WMDG64m5q9ObXi0I2Hp7wPaNdIb3j2cQqzA/3t//SJx4ooiL1o7EDo+huo3LjR2vQh3UBHY//DTCjfEk64Lno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746467217; c=relaxed/simple;
	bh=LgXCoxH+HBvXs5sLSOeVJ4nk4wHjIeokAturRVndvCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JhP6r3JQF4gKmYiBP5jOv3Nut2EqxOyk2VxXbUYV/jj8rB+mi8BBoJkU2CNzlEWlASuAnM9Y/bi/aYCnluH/tDQFxVInq5cEYKyuAeZHCZDT9OPTpcVp7wSq791jS7Quhe2yLM2YL4SRZrP2stM0I0SWpkpHeoT8Gi91TpZXBhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IyQbVtES; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 545CBiaO011474
	for <linux-wireless@vger.kernel.org>; Mon, 5 May 2025 17:46:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gc8xK7MUaegQ4Hd1zIE2N7VWBlBkfEVs+amTpWNe2X8=; b=IyQbVtESVCED85bc
	0o159F2/I6eCiRbpmmRSLFFcGOPMIQC4U0uTXBeP4b3ucBygj5v8Wh9cvwSj3Oz4
	uVe50o+c9GvzHk3N/3qnW1Ifi3oZscxgBJPShD6TAPJmw69tGPGYV4N8jL9fShAr
	1TG7XklVVBV7nOUcq1hFGlanDTnb2sy2wxVddYYCkew7M/WleXVPFiyUxpqJAslQ
	qSvGPv079bYRzjT67U/poGCB5kcnGsHm833e3sEq1juCYOz3ry1ovk1XfpF/Luey
	AM5WkJcSa6I0Gann/klPn5YfOJ89AeliJVPXEknE+cnDW+BdzddwieRwEs5oZsar
	i8oz+Q==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46dbwfmq36-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 05 May 2025 17:46:54 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7395095a505so3260066b3a.1
        for <linux-wireless@vger.kernel.org>; Mon, 05 May 2025 10:46:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746467213; x=1747072013;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gc8xK7MUaegQ4Hd1zIE2N7VWBlBkfEVs+amTpWNe2X8=;
        b=MPZfszM2vj+zrqJ9BjuWhn0REJjzTpW1B7u+w4RCI9+hKkq3M+MEKBgyqV24Jmrtga
         IPiH46ECjigIWkiNterNhacO5y4v0mO7jA8ToZS+JAdMGclaekCI/pCD8gtipkWttAEE
         Z00IoZZxmyFKllPABiKOIgpREqGIz5L737uz0w0bE1lvAhFnpa1NReKlJ7+75DBbN5SD
         HUBGvukrZToNSw2a80pUot/MsPwPklqY83ZS0PSfvRHTYq2Tlz0WOS8JHXTTvsr4GPem
         ZvMUeVaWSUFz1Wsemoaw9N/innQFMv0ltAPlMtKvWsxfpcf2Difk5zcZWXOX9ohJDhNi
         fjLA==
X-Gm-Message-State: AOJu0YxOH9Eoaq6o13AHgKfIbU2DWStpK2MEE0PM6wXWNhtbR0uUP8fj
	OGcr28qNm54+PS1xPLu5bW6gjHqJrnRqN6Ha0Y+yt65QhQ0NKzjmDsHxhZfKcMfae9cFCEScHaP
	Q3LcqvZymhlYGJvOeskhnJTfO4tWQ8BI9pCqlysdvlJjXp0quAJIOfqmU+zeQOxM4WA==
X-Gm-Gg: ASbGncvFBoh0cEQWd5k//IsVG7PpmvuvIZ6gwyf87zsvFFk+dFnYV0+kTf7a6+0zmsX
	1+k2adaGTsYVvLNUeBZBUl9+G0mNsClFSUIT8jG6PA4cVhaqBSHo0C0oPOeRgLKTmQZnSv4n2QG
	jiWs1MtfEp0KRU0YZGQHR7vKGa3e0geRoKG8YsuzkgTQExGVeqHOS8JVY4NW+P2bZWs6Usx1cKE
	JHv6oRfbdR44ENa+xKsuGPC4FZ8CzKGveCyCbRoO6q6UnJDXkWFYKbCgDamFmzCbC4TjTh4e2YM
	Y2TbCxTS2pQnLMGnr6PJCA0pT65R/mvgKdE86hpJUAhvKfesV3Hf/VTLNCoQpikHBEc=
X-Received: by 2002:a05:6a20:43a1:b0:201:8a13:f392 with SMTP id adf61e73a8af0-21181146f0cmr49162637.20.1746467213356;
        Mon, 05 May 2025 10:46:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNurxKi73dxQdNRKjVd5IgfE8FJGdhrSPwkrS9BHFQeVceJ4PrtyFTQw5d58wQk/Q8BTJEmg==
X-Received: by 2002:a05:6a20:43a1:b0:201:8a13:f392 with SMTP id adf61e73a8af0-21181146f0cmr49135637.20.1746467212931;
        Mon, 05 May 2025 10:46:52 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b1fb3b7c309sm5782394a12.38.2025.05.05.10.46.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 10:46:52 -0700 (PDT)
Message-ID: <5fcbf500-8005-403c-a9db-597fb8a54bc1@oss.qualcomm.com>
Date: Mon, 5 May 2025 10:46:51 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: disable pdev for non supported
 country
To: Muna Sinada <muna.sinada@oss.qualcomm.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Karthik M <quic_karm@quicinc.com>
References: <20250502230240.3692678-1-muna.sinada@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250502230240.3692678-1-muna.sinada@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: lYrs-FlzODGKWdPihLB9loZeoJQI_VnO
X-Proofpoint-GUID: lYrs-FlzODGKWdPihLB9loZeoJQI_VnO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA1MDE2NyBTYWx0ZWRfX3MwXlBNhlyEZ
 m9I1+C2OblwkeChRZNeQ1M0Ie+S4/QN9npmK6huTwd/cjIuVcrJga3XHokd+nuwXY0B402dxWjK
 a14qWgpzGjdTFWxAAtSTLP0DYHN1GJx0A6f+FLdf0vCWZpyK1P157XMuSW7chF4+CcHlyO8G3j3
 qT19akYKibmFZ7B0jdSd/TaCGIjJmDjR9Kn2T2IWo0i+qIm9AzX7sK0AXH4oTKpmGaXg8QcB7zf
 F+zhU0tGttCjbL1JE1P9K6ue4U4uptlDfR4YLeElXHqf+Y2E+CJIa6JVdYUxtDd+1A/O4O+vFG8
 usutJQ+F7LPicoyaf6ccO47cS5rXsIzpGRqQ2llO9CE4rV0qTYsJHjrzGQ1osEl/EaszfcPKYcd
 IiRQ0jN+AqADpqP6cREurlxEFx4D9HaoyxskzLETNIssNDhkSmrK7SF0lzjxfAXYXRgMjVOv
X-Authority-Analysis: v=2.4 cv=AfqxH2XG c=1 sm=1 tr=0 ts=6818f98e cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=zEEqOW7EwutULFlLG24A:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-05_08,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 phishscore=0 impostorscore=0
 mlxscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=600
 spamscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505050167

On 5/2/2025 4:02 PM, Muna Sinada wrote:
> From: Karthik M <quic_karm@quicinc.com>
> 
> In MLO configuration, ath12k_mac_radio_start() iterates through all
> the radios and makes the ar state 'ON'. Even though some bands are
> not supported in certain countries, ath12k_reg_update_chan_list()
> tries to update the channel list for all the active pdevs and ends
> up in the warn_on for non-supported band.
> 
> To prevent this, disable the pdev when the num of channels in a band

s/num/number/

> for a particular country is zero.

Can you explain what is meant by disabling the pdev? There are plenty of
countries where not all bands are supported, but I'd expect the pdev to be
active on the bands that are supported.

Or is it more accurate to say:
disable the pdev when the number of channels across all bands supported by the
pdev is zero for a particular country?

I just want to make sure the description is accurate.

/jeff

