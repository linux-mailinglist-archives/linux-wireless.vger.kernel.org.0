Return-Path: <linux-wireless+bounces-24436-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33138AE6B27
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 17:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6C0D16B812
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 15:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE29F2D5C90;
	Tue, 24 Jun 2025 15:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SUnzGllz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D00D2D3204
	for <linux-wireless@vger.kernel.org>; Tue, 24 Jun 2025 15:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750777904; cv=none; b=JMgqq9E7FMOo7B9fn5OzByJxn3G3bBCOWKUU6/WkMc6Ve+Ulvc88q5j+HnN3gZGVkWx2q8+m9GAOkfe/QBd32rUQ451FVp0rUazhxYv5USYv0Nm8TvJNtolWJ1lHDTI5qFN/p0Rvs/ONaVdtrgBizTxgQSda7beUPgWIehB4CUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750777904; c=relaxed/simple;
	bh=nL+o3QWsD8Q6/r9+nASdZ9ksUUyF+QydFWN+GEIYKh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WUc8x4Hud4xOC2AicFjzFqB6rJS7KrzIZlyxBmcVCl2p1T5VTGaAyDq/TdeBqA4OjvYXSVu4VFZJ00xUFpj95oBU2Uum2WqB6/udJBbxo0vIKQ0HEeWjyuW0NzQgPR/4eU4FMvVcBr4v1v7RudHW1zYxqy3HEL0+OTniHprt9Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SUnzGllz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55O983ef008157
	for <linux-wireless@vger.kernel.org>; Tue, 24 Jun 2025 15:11:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WROZRR9mmLK2PFxiaEc1SQNzlb0RAKYImQh60GijuC0=; b=SUnzGllzQe7mBZZr
	hyZgmrSuT1yzy+JMUqTlQX7iVh8DggcO9UlfTVvrnZR2HtiEAj74fPxEmWa+LEmK
	90SDxIHo5u4P6gqKkRhYI0ae9Q/ROs7BPuXXK6jfj2blftnAaQ3/roWgNW6P6iyu
	22mDwxX8hXL/vJvmeaXqGeQAoLNuyFDz3FM5mEhrvT7GT13RD5LMm0MZSnoi+GS0
	6un3BjI5QGfkoXTSOz/jbziJ/mGIbPPUxJ3nGPTrc8q+BSL6t27xl4hkTkW9H8X/
	98hvXCXzXvRUV9Uv6LOoxsUGB6EXxVXg3Tgd4gUaVTo3wKOo/DpCj7ogBee7fUen
	EFTb1A==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47f7ttut3q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 24 Jun 2025 15:11:40 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b2c36d3f884so4128074a12.2
        for <linux-wireless@vger.kernel.org>; Tue, 24 Jun 2025 08:11:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750777899; x=1751382699;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WROZRR9mmLK2PFxiaEc1SQNzlb0RAKYImQh60GijuC0=;
        b=LxgKhTzPA06ywPdOKDQJvTTS5qwmhfpH4NCMPTw/u97Et7L6oV5secS1oFYKThtJh9
         7s9gTKtcvXYcoFmjEHOdUKCGz+1doL+GJvSFLtOX6ZNHyewDYDtMsA0DfDoHKokbkH4D
         8fUMpqMaZFeR94IHSu4dXtUZQo0wpWQJeX7PVIMM3wslCBjHOS4W3UgrNK6UIp4KGSKy
         753bqRo1tCkR8TCqN4t65NFuMWdf/Uw+6MpVHkQCHQBAWZvuJrvvr02FJwdMXyCTbbfg
         v37+1HtqDwNSunqhsUL6zZnSC0xDCpOkerMzRR8UqrgZiqHJVO8xD3oh7ocHlbOQ45x7
         XwiQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2g4TE3AzwHQHhq/GflpumwYnlvDQF+OFylcSixtKceE+oIXFWq/FpHX3Twlr5fOS8dN0808fzvCM5ylfi5w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzBFbQ0yussqCQvySDQPs92uFhTC1Ux+1CiA5qcGU0sL27URP1o
	TgLJafRm2+CGoZeeb756ME9D2M/M06Aw1fB0qkanL605Z1gE5X+0G27Qfl8HpY6wE0clrEHiaRT
	I05XMmx04qkIOJrcmOGdeSARukIZV6S5h2dTYmrD3j/69xVWQO/tj4Kw2gbmGg7B7xnbX1w==
X-Gm-Gg: ASbGnctnrgaxBmglDzgdMSomQEjiGJU+pvyeRNyamiMJYQrolGAlDG5K+RtxjQTkic+
	Bg4qV5NNAYIsRRKqz+YcGvcUilBm6dmFyQD+gs2Bsv7cKgzl4BJW5XyK9+HIY03K+x+XBUNC+/9
	TvVaw0bw1mupfHUzgrxAiC5TZfxx+EqWQQ6Uiy2b/Y9tytD8dm1sBPYzIUNRt2qAzWF7PmSti1Z
	edNsCX/dZ4yae6Rml67LlvPcim1BlxLvj3LaQkVSAu83eOirUhp3CckpuvtnPm0m9Jb8sXoALnU
	PIcUrU/gSRsmRUWGova7BrNp2dsO/HO3ow+LrBIaxqV7IQ70wXW60yLxmfjLZY2U4NipRZCfiTi
	aY1/KWxy8IegRaxg=
X-Received: by 2002:a05:6a00:4b4e:b0:736:51ab:7aed with SMTP id d2e1a72fcca58-7490d7927edmr23738581b3a.16.1750777898488;
        Tue, 24 Jun 2025 08:11:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiedZO03xFRwWBJi+2VpVp76Xjs34tS60jMZH2JYRycd/Sa/hfrCCXMDiZ0p2GGGyen2az8g==
X-Received: by 2002:a05:6a00:4b4e:b0:736:51ab:7aed with SMTP id d2e1a72fcca58-7490d7927edmr23738523b3a.16.1750777897936;
        Tue, 24 Jun 2025 08:11:37 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-749b5e0978bsm2003208b3a.21.2025.06.24.08.11.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 08:11:37 -0700 (PDT)
Message-ID: <43b978a5-c1c3-450d-8340-dc1a6dddc884@oss.qualcomm.com>
Date: Tue, 24 Jun 2025 08:11:36 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: fix suspend use-after-free after probe
 failure
To: Johan Hovold <johan@kernel.org>, Johan Hovold <johan+linaro@kernel.org>
Cc: Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Baochen Qiang <quic_bqiang@quicinc.com>
References: <20250624082022.15469-1-johan+linaro@kernel.org>
 <aFpingRwP3foaKJ9@hovoldconsulting.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <aFpingRwP3foaKJ9@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=QINoRhLL c=1 sm=1 tr=0 ts=685ac02c cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=oKBW_v6FYzd1ttqmKkgA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=bFCP_H2QrGi7Okbo017w:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: n3q_Y8zNc2zdS_b74X4o_ASSTQjBphxG
X-Proofpoint-GUID: n3q_Y8zNc2zdS_b74X4o_ASSTQjBphxG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDEyNyBTYWx0ZWRfXxHxrONW6stJf
 KqqOGX2P0vSnGrrAtlB7dXxwNsrmcTeV0ZpNA9F/gJWu127uN8HWN+Q1zWA2xPm3uWN/lIck09/
 IsRiNM0e/5iE0PUV6urTo9ZqpTONsNLKfWPGwtRYg8VIjtl9oyu3NGpM7EvFIXkRShiRjFqz3h7
 FwzCXghdKUwQkWKUctCsv9qORZrE8SaJW4NiCniqHvu3oVd2t6Oa3o3P+boVySTpTRQU5RWxiz4
 8l3WALJFFhthQ8buJORZnAnn7a4ngRmQF4lI6fM6PP8HhsRwQ2K4q4enrYYfmlNOmfZd/xxtcMy
 2DzXl789cAplG/Gt6uBABk/jr574Wqr68ODpdubwyscHjhjZpYIfyaiPqvyeh44JqWA1voEgDPf
 CFZZwkop2lXx3KC3OfYnqJ02MfMIjuBqfBtAfThTBAdmsKz0X6yy8ewJKy/+K8brr4S20wpt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_06,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0 mlxscore=0
 clxscore=1015 mlxlogscore=999 bulkscore=0 suspectscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506240127

On 6/24/2025 1:32 AM, Johan Hovold wrote:
> On Tue, Jun 24, 2025 at 10:20:22AM +0200, Johan Hovold wrote:
>> Make sure to deregister the PM notifier to avoid a use-after-free on
>> suspend in case core initialisation fails (e.g. due to missing
>> firmware).
> 
> Not sure it matters in this case, but forgot to include:
> 
> Tested-on: WCN6855 hw2.0 WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41

I'll add that.
I'll also change the Link: to Closes: per checkpatch:

WARNING:BAD_REPORTED_BY_LINK: Reported-by: should be immediately followed by Closes: with a URL to the report

> 
>> Fixes: 32d93b51bc7e ("wifi: ath11k: choose default PM policy for hibernation")
>> Reported-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>> Link: https://lore.kernel.org/all/d0cd065c-1cd1-4e56-8c57-60777b1f3664@oss.qualcomm.com/
>> Cc: Baochen Qiang <quic_bqiang@quicinc.com>
>> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> 
> Johan


