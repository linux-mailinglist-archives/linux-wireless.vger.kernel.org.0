Return-Path: <linux-wireless+bounces-22027-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E650FA9BA82
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 00:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1F361B83F7D
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 22:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230B985931;
	Thu, 24 Apr 2025 22:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Gg/7Eizp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D1643AA4
	for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 22:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745532953; cv=none; b=dthC2gJDr8gj+mgyJH45YskVvhSN0K8UwNFoFv9XMThZ3vNH3yIr3QKz2qP6U/WB9m9J2XeslW52U7l+Fpqh9CkQNjHdKzIkMLQx4gBHFOpNQyg6yogufv/loHBuD8kd55Tw7c28kKftn28vDlwA+blRDMNlcSIeE9cZ9IlTNzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745532953; c=relaxed/simple;
	bh=6IG40CSDspfBOCyMQnsK5PUSVcK3MSJsVGRNsYbRV4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qUm231FVvUVLVLElpU9DNQzPnUHHJ7intbLj3C99STkGDMlKf+jr1fYP5X0EilcNHjFNqSsjFE2iSnlNgIHx34H/SYgJmdM86teE3Uwfe1VNc8YLbCocB/TGexnF0UX6K7FfgoZ1e7/xL0RJV+D6aCZV9r8qRzMyp0aw9OihySQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Gg/7Eizp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53OJnTgE010652
	for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 22:15:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Vr6UAcTBHtz3bYIJUxJHWQ9CaAr472WSv/vlCBSVX0g=; b=Gg/7EizpTV7RjbaY
	cY5PookUELZPHqUGvOtrVlSm75UWRDnmMbh/RfPOlQNdtiYgXLil9WVeu5bFqTo2
	knYuZ2e+FGO5UGE8SbTx9nTmvg3YcNp5Ex3D3F3fcwVL4uACsQiAK8A8oDSDj/Vn
	t0YznN6AMRWA3LlhSeOuHgxeBFogI9LrbRw5YSD6U6y6I9bzoFU2IhSly0OTGI+H
	8w2bvLbNzVydS2ShGPMZuK6wDEbcJ30TzUeXtVzMukE8LazVr5s+WsODdanJIDWM
	uUMpEp5OZGMdrCVIo3RGKu/HHm57XJhjG/7NtFQBWZvX8gbvjVNdR/JbVM4xzvgO
	ykyxIQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh1q32h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 22:15:50 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-72f3b4c0305so1478882b3a.0
        for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 15:15:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745532950; x=1746137750;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vr6UAcTBHtz3bYIJUxJHWQ9CaAr472WSv/vlCBSVX0g=;
        b=rNMm2vHUNCQ3lHMpKwq9yhBEUB+OIDwNyghJAdI6Y/ku54fxA9nZ2+UjKbmecty+9v
         iIRyIBzyIWJTOha2WEaNRtmSk3mQdm+yVJ3uEZnMYX5jElx0XXT1mAxQSzkr93IcZTID
         I6hnhA+kxhUB9KzwbxFvX6QF5SK3v4dyiTZyASzBWmCGzH2rPAIMgq7BmgVhjntHvZuv
         gD81NWEXE2sfmS9OqW+/npYSGpKZPh/Jk9mpJg+hzwDa8Ih9rcXm3QUSbT4sWhaiDARH
         qGxKFfXpTW1Gvnudzem8UE1BMV+urb0oO8Vk4mwpim+y/w09X7quJvZ7sQx9CK3q177j
         nMVw==
X-Gm-Message-State: AOJu0YzeLaBK80SOca8moAp3nMXw2SllKZfg5LwQ+ETjWeUZpvKyH9Fw
	6G3jr1wpzzryuGwW+pKXXO7fX19LxIaLStA11wKQS6t4CZxDKQVgqTi6Z116rojtxzEbehRZA7r
	7E9n+d3INILDTBPZOzA+tm5cDM+N1PuRdNUt+bjqqjGiJx/06XJWOB1OqV+rSd53qHi0kwBrSqg
	==
X-Gm-Gg: ASbGnctbgjE+FINf066YXMqlFXnCjr1COdeoZCJ7sxiSb9v+nLTjXZruWsisWanrfYs
	GRhouDQmvFkLmQaoDgNGOdUJKHf+d3RVx39xveUG+RI0mP8iJrpt3sGHxOTaGO1x+tgpSxtKzIh
	SMp3QjFiCtJCyknE5M2yCyiopjg50yMm8GMMSJBnzO37leKIEcny9sHh+tLzgXOwlVTepxlBuUN
	imuoQ70OSh0QPJ2kmH886+bhGwlH+FKszZgXjD+BMlVyWb7m9wHOGWCeQJFxgjg98LCK7v+WLYM
	gI0WfeCLmhpjFl3rS/TorZ5eUPUv6wqKHkmqH0yW0ssVP3sBaJXUKOrm/7k65iMt
X-Received: by 2002:a05:6a00:32cf:b0:73c:a55c:6cdf with SMTP id d2e1a72fcca58-73e244baf7emr5617615b3a.1.1745532949796;
        Thu, 24 Apr 2025 15:15:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQw6Y4u7NIb4vjYTCtAAk8q84Jj+Eq2zrXWlj+UW8hdGkdREhKcn2OY/pw8j/33iRxafWYUA==
X-Received: by 2002:a05:6a00:32cf:b0:73c:a55c:6cdf with SMTP id d2e1a72fcca58-73e244baf7emr5617589b3a.1.1745532949367;
        Thu, 24 Apr 2025 15:15:49 -0700 (PDT)
Received: from [10.227.106.66] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25962f61sm1934011b3a.74.2025.04.24.15.15.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 15:15:48 -0700 (PDT)
Message-ID: <30457c04-460e-4bde-8e9b-99cfd9d8f570@oss.qualcomm.com>
Date: Thu, 24 Apr 2025 15:15:36 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: Prevent multicast duplication for
 dynamic VLAN
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250310230105.3534334-1-muna.sinada@oss.qualcomm.com>
 <d2e6a1e9-7831-4342-9458-4628f9cf7182@oss.qualcomm.com>
Content-Language: en-GB
From: Muna Sinada <muna.sinada@oss.qualcomm.com>
In-Reply-To: <d2e6a1e9-7831-4342-9458-4628f9cf7182@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: vaC09gzVmTyM9UEkiD8P2qHYPTMosE7D
X-Proofpoint-ORIG-GUID: vaC09gzVmTyM9UEkiD8P2qHYPTMosE7D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDE1NyBTYWx0ZWRfX6VwWa7AgGbd4 2Fqymj0yDSDh+goURBru6MmYuwvjdDT2fSy4OjRNru4F0pohHqkCvDJbLLepyoxWAiGkao2Sf12 Xr+SIqtcWupgv1HowIZaUfug37Tugk1DhEBJdgZHC5TDKLwL+XWUptZlUQv7G56yDVlS123UowT
 qOv5DAvn4uYYf7NnutqnGdJyW6W1jqfB9eSmctF8FpLzO5caaiu624PiuX8Bje5ekMQmJFFRToG 5pw8otL/oIvWO2EQc2RVp5XPQHJgH03om3h78O5ExreKNA9irAR/3a19ZO7T42NnczvrymiUrt5 TP9tX4o/zCp1xvRbqNnmjQ5JTon71orrKhEnjJnJPW55FQGcu+Gk0kWF2EGB8nk2mTz/2qB2jJ8
 hIddvMGkNWLeKYIciYrHlesv5y13FQ4UpuW0sH1FhUnbGfUTj+6BFn58vviUM2zfkHa6z01H
X-Authority-Analysis: v=2.4 cv=ZpjtK87G c=1 sm=1 tr=0 ts=680ab816 cx=c_pps a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=McVu47brbZajC1vxsbUA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-24_09,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 mlxlogscore=498 spamscore=0 impostorscore=0
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504240157

On 4/24/2025 7:08 AM, Jeff Johnson wrote:
> On 3/10/2025 4:01 PM, Muna Sinada wrote:
>>
>> Signed-off-by: Muna Sinada <muna.sinada@oss.qualcomm.com>
> 
> Don't spin a new version just to address those comments.
> 
> I can make them when I put the patch in the 'pending' branch if there are no
> further review comments.
> 
> /jeff
> 
I went ahead and sent a new version since the patch needed to be rebased.

Muna

