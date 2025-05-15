Return-Path: <linux-wireless+bounces-23036-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFBCAB8EB9
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 20:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4218116C561
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 18:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C6425A2C5;
	Thu, 15 May 2025 18:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ix+Vd4W6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D15253358
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 18:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747333222; cv=none; b=icBkjc6s+lkZLQCSHRYHNJ9/Dp97RmJxOPn6Qz5U3B2d8+cuY8fwQYuL75T7SiJk9dPcdjpoF11mNWG9sPAtEGeo3fx9K1aUrYeVjumAUF18ijerXdMg6AarDV8+gngJ8yFzqw+jbWETRU+xQdHwlD82Bum8QHbJha/hhtdHDlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747333222; c=relaxed/simple;
	bh=/T0gQauXa/ft2ZHRp8KMQbczqbe7LRrSucsbMP5v/Ok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TFOiLN29ktxSOx8bwrl934cvIoqJ+TngUFvk2G4LPlRT3JDTi0a6JVgfrAKmb8fIqqT5IDJCYzB2EwMKYWUeLY2Yg6hu5rfwaiXBZGCSlJRjDew0UJEH4Duqt6L1/3dnxke4QrI7g6cqrAHE8hKY60JiIgN/Tp6GV6E5OqWbkdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ix+Vd4W6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FEFDj5001792
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 18:20:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/T0gQauXa/ft2ZHRp8KMQbczqbe7LRrSucsbMP5v/Ok=; b=ix+Vd4W6VBnu2XFg
	0D28g9knno1jndoegUxnC3cpex01RYPBDcGqQ83lQ6c46fDzMIrhJm130ev+3K24
	VSY7l/l02P1183K2oQWcNddELtAVps02oJbZ9XhEDT+A83PEvZk1KvIYqR1PGYgP
	z0vymjp3P7ycwBOIOxV4ZZLKLReq0eAHS3OPxShzDT3Q3dQpaTScAQDttQWabvpf
	8fm2q4N/LXW77uq7A+HjXHLrNTrWaMoatZlOD8BfwJR6TuZw3xB8eomi2+Na/542
	GE2QsdjlTjO/h0aNAD10JzLU6vYINOZJZOxWv2ScuhPzPtjw/Hl0IwEJiQINOjxH
	L8FTuw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcrf3uc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 18:20:19 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-22e40e747a3so11663295ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 11:20:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747333218; x=1747938018;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/T0gQauXa/ft2ZHRp8KMQbczqbe7LRrSucsbMP5v/Ok=;
        b=M2J3EhBnI4vEN2IIZKwnGgvMq5eO1C3PszP1/M98fQO5YD8nbF7vGgOWJRt2IJQ7UV
         Tzgy6V6/DpT3DGtX62dAMGMyD22QnhodWKJ1Z6gZHT7tyXBcpk/i0P9ZB6uJXPWnUFnW
         SVHCJzWfOo5GlU7mFJp7mDHggsgIIdt2G+tzjdNy6DVG6+FJvQPCl0owjWIHcF8wAuj/
         jYLWGtYVt5UPP8xSYfJeqiJ6WE8/S6EWp8ZbhVuCWgxJhj/ge8oxD/OyLq9LUTeyfyp+
         IhN1va+Ie76g9haJsqZW/+mqKeJAoDgbOMdV463Rn1jtN/qSPNk37N6W8pX/WIgKbdUH
         jHxA==
X-Gm-Message-State: AOJu0YyFLvyWIfpZanUSRnTtDEAXrN4rfShT8PRV8t4gR7W38UFHxp0H
	4rd5YaOidVer5eVlFnXevBiqmr5Ydvu6mkW0+IIubHAFd1Zy1NSPIBD/GuauAZwd1BN0goLxgV4
	dj/lQmTKSxGtmgyVzOTWmo2GEgHX7/mzhdK+lwWqqgag1YGqtuL6Lsh4q3Hwle8djSK2Xs09Jrc
	80Pg==
X-Gm-Gg: ASbGncti18Vzs2cwKpNBPxONtkP9el2lUSIlFskNXYAk8MiRBmw4we3OcDvk/FL/KnO
	IoPQVdCuDNCAgLH7hd4OlH8LFzu+uLg9WT/DAsEa+ydnssYJs6eg9WNKBfB9Z+rED2wiKn74Yji
	BxMKwXzBPBbByxoO62GTWbEAlhpzz5SxO4m3d86d6vKg782hPeZHIyJ9+3sRJi+OnGQgYXHJMhZ
	WX/2jh/GZkYgFFx86QClQF/Njkz6rP+z2Qol0O5VUjfYH0Ijg5PKFMg7g+XTVm2cN8raoyQS315
	zzc9os6nUP6hlJEeLGjyyli/AL6MzWhUfifnC45hnlIzaleZ6sc9TPIopLQEb3FL5zE=
X-Received: by 2002:a17:903:4b4b:b0:22e:6bb1:f717 with SMTP id d9443c01a7336-231d452da38mr7360895ad.41.1747333218352;
        Thu, 15 May 2025 11:20:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEx5bYF/rzLIsywGqbz8vScGQIyVSypJBLovdyWgpilULyiGbEcK0yTCLXsjJbs14FK7DiA6g==
X-Received: by 2002:a17:903:4b4b:b0:22e:6bb1:f717 with SMTP id d9443c01a7336-231d452da38mr7360665ad.41.1747333217949;
        Thu, 15 May 2025 11:20:17 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4e97db8sm822345ad.110.2025.05.15.11.20.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 May 2025 11:20:17 -0700 (PDT)
Message-ID: <ad255f5e-d1be-42e0-83ca-40fdc4eb25a4@oss.qualcomm.com>
Date: Thu, 15 May 2025 11:20:16 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath12k: No 6GHz Wireless found
To: Walt Holman <waltholman09@gmail.com>,
        Kang Yang <quic_kangyang@quicinc.com>
Cc: linux-wireless@vger.kernel.org,
        "ath12k@lists.infradead.org" <ath12k@lists.infradead.org>
References: <CAMb39_ngQs8=FUML5QXMh2RmEZBZ2NwUHefhGoTkGtHat+KWJA@mail.gmail.com>
 <ef81db9e-99cb-4802-b17f-94eb623a8b32@quicinc.com>
 <CAMb39_m+4dNBDbkZmn-rDA7T+u84y-dx1jSfmPNWnse=R1=gCw@mail.gmail.com>
 <18788f02-e374-4aa6-ac4a-fd53bc93754c@quicinc.com>
 <CAMb39_=G_TEL1pbeF_PAZLQh-JOFcncSfqZChPmEj63NjsEOLA@mail.gmail.com>
 <16ccbe02-b315-40d1-8600-232b592d4dd6@quicinc.com>
 <CAMb39_n4tyrzS=-j0L+ekJVer=KiZyDYFhMqrrcpr9py_itU9w@mail.gmail.com>
 <0933d8d6-5b72-40df-95f8-69f6fbbdfde7@oss.qualcomm.com>
 <CAMb39_nHO_TbHPQawdLVY8nt3yt4wDuEHyEuzMa-p5Ab1n94sA@mail.gmail.com>
 <CAMb39_nQ-uyKAqCz1HEUDt5qjszbhzf3oikVcvzHcVwt4_qt=A@mail.gmail.com>
 <CAMb39_n89hBL_GvfXb7Jw9h5-h-+Qg-3GyqvpahL7MT5ewpvJw@mail.gmail.com>
 <CAMb39_=YPYg0q7Lf0sMgTx5QwKOqcyJrZR7kTspyXEDa6qz9Bw@mail.gmail.com>
 <e9da4ad5-52cb-416d-991a-259140469e2c@oss.qualcomm.com>
 <87774003-d0a5-4408-b710-20bd3c194cec@quicinc.com>
 <CAMb39_ntK9Zv3pOuMSza5hRfs_KZBhya=GAPnpBWjN2wZDst9w@mail.gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAMb39_ntK9Zv3pOuMSza5hRfs_KZBhya=GAPnpBWjN2wZDst9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 51idRGGKky4w6BlWOD6qzY55R0ih288m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE4MCBTYWx0ZWRfX8eqlx3PEUWr4
 tfaH7R2mBGlBVxAJh2YqJrnRExEhUFjUQxw/+fmtLsKKVhOUFbz1p4bFSq6dKacl/muj3E9aJtF
 nwKPydefJWZp0cSUJcjRufr30C9JSXBIUvthk5BPvjvh75kX1SV+9ZBIDRyzwFJt+f+O0lFvEYJ
 9egwSIEOPvLrepT+36fL6OgNL7zjcu+47AZapOuol0qirWPGYgok5nSZc6awbyauCekJAIUt5sp
 XsV4F4JTo4+J7EiOflfMgr9/DvfspbMyPrSFo4eLrahwQE4JElPPyXs32gjf0mJ2y9GS12eVcKO
 nwpmOAoafJv6vTSpW0G6wXdJsrxALHqNG9As8VaNwJHpvClAx55z5rrrdbP+spsgs8cqk4NOD+s
 ko6A4CDeZHvw1OEAKR+8+ScXQsIGxIg9uPzegj+eJJNWdNPL1tYPUKHFc15OjQQp/3WHhxj7
X-Authority-Analysis: v=2.4 cv=K7UiHzWI c=1 sm=1 tr=0 ts=68263063 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=bC-a23v3AAAA:8 a=3HcdUk5iCOaaV_Z1s7AA:9 a=QEXdDO2ut3YA:10 a=-FEs8UIgK8oA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: 51idRGGKky4w6BlWOD6qzY55R0ih288m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_08,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 malwarescore=0
 phishscore=0 mlxlogscore=698 clxscore=1015 bulkscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150180

On 5/15/2025 10:47 AM, Walt Holman wrote:
> I adedd another network with 2.4 / 5 / 6Ghz settings and still only
> connect to the 5Ghz network portion. This is verified through wavemon
> and the AP. I saw some patches recently to address 6 Ghz operatoins in
> various modes (https://lore.kernel.org/linux-wireless/1692f2f8-c77e-87ce-db70-00b4d9fc7c95@oss.qualcomm.com/),
> but the patch doesn't apply cleanly to current or ath-pending. Don't
> know that it would help, but it seemed interesting.

That series is already part of the pending branch, hence why it doesn't apply
cleanly. So ideally you could test with that branch, but there are some other
issues in that branch that are still being resolved, see:
https://msgid.link/7db2e4b5-377c-4d3b-b51f-290accc9ddd9@oss.qualcomm.com

/jeff

