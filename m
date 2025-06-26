Return-Path: <linux-wireless+bounces-24556-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0393FAEA1FA
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 17:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7DF47B1048
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 15:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435742EF9C9;
	Thu, 26 Jun 2025 15:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MLsyhEPS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC6B2EF9D4
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 15:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750950175; cv=none; b=JFoaF17ydao+qWbCTReoZTN4EYWCIPvxGnDG7PNZaUHkduUmXQ7r/+wRzeZ6dNGcZfqLHDsZoqIrGPFUyf/KZq3+0vmnMXiFcoVYvSRnxhArWinQPe6EdcyERfsWtSm9AvKhVRO+RL23crS/6C1wdPXy6z7iiMPFCZjFzKSOXuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750950175; c=relaxed/simple;
	bh=wGWJ1Sswd47PGcB2x/iOZY6omMkR+LwiTigIHQ5o8VI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vcb+/FUZD504imY2sK3Scm2uBUp/NjyQot8pgGpsT9DkeBdBCGR1AI3ScgKaD2A3UsKkaCcTocG5omjcobAPNmczMMCQqjE97NWpARKi0O7pylyjRk/Vkom9qOZAM2jp9TKZcNByo4vNOLMIMJ2Aw8UAqL6kft7yjusLBUYjqzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MLsyhEPS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q9xSXl013199
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 15:02:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wGWJ1Sswd47PGcB2x/iOZY6omMkR+LwiTigIHQ5o8VI=; b=MLsyhEPS0AYQuE/q
	0ZLQ6k+sCoYnDpqCYEoTp2zl0ZzzcUeT9AivWKJNd7XNPQ1YShEn8p5Wy19AeSc4
	1jhl4WVeHB9lOSVr56avIcBvdRUMwGG7lM/TTgYCfwYDpGALy/gi5ezbd+qnKeP1
	hzRxWpq5SzOiQOueWdA1gsOn2rpYgkJNNquG4wUYoU7JtoLkRU9FcRitf9Rga0gS
	VKGj5P4jwtn783sQrxHFkhIcmA3NgQf3/hAPn/CVRPxD7z18yFLtgUyPOVljzGRy
	rDh3hfcmMReJoms0UkcZBGRfogfAHKAEJlMGmIDssaHjffFXLvjc8v44sqFVYSue
	Y+OW5g==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47fbm22aq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 15:02:52 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3132c1942a1so1751363a91.2
        for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 08:02:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750950171; x=1751554971;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wGWJ1Sswd47PGcB2x/iOZY6omMkR+LwiTigIHQ5o8VI=;
        b=FzLPgwx1btBnNgnkdQGmWqWzlZRe2Xf2dizTSPFZoV7sNeQv+kpggr6VkFXZdw9FWT
         XlqmskFrc8ay756u8jVulrrytK+4fwYCBF0TGCxUZ1YppptZe4rCoIHmcaj7+mMuYKFA
         FHGFenBVij2Qmgd6X4ZnVcA++tk5jTXhxxGNi+gUglSGXXcWv8VxeyE4/Bo6IK37fIIw
         +9cXbNlYplGNyqjIWxJm9AeHIe8vXGtfEKM9kqMVD6HxHEzJ3h/yq2uYwg2mKvASSA3o
         fAvruwaxFS57e+EKYZuUc0oXamlPmpMx/BaPa3hjuWEr5mjc2Ce1m8LLx8o9/FSS4lAZ
         G56g==
X-Gm-Message-State: AOJu0Yz849B6aTdxbQczv3LqZ7adl32q8fnxZnS2/u7gFuL3juIb38XJ
	kh2QcEuKUP6qlwkyKkKBH+z/8XqhZHHA2P1to1uMCFqmR00pLrBm73qdc4GHPptAWQjeAjB6Q0u
	3EVfvc2Dymt7pu489WNzUfzM4UQtQ20sp6zfzR/k3fctQZsK+nIQqEJx/+9ZALHFKEYekeQ==
X-Gm-Gg: ASbGncvtfcphH3hTCzrJnIT2E37W1p2iB9Tcu+XFpWgeUe4yqXFsHRy494lN2gzM6iz
	YpqGmFLNrjg0JAtwEzWCBpBJQSd8WiXZNQKASMT76oS6EvbM5NQRsb1xU73nY2CkS8+0sZkyeMH
	CQKmu6P4IkRFafCNwxMukp7W2jm4ZiOHMg5FzQPcnUgrwOXlMmHAY0ysegGa/vC78/iZdCI7rqu
	0nWMWloh76DJ3bHgvbmyqZPVSRx/nABZMLQhRo9v9LWFQQ6l3p1XHvhFgDD3rOApLSY8NzlrJ3n
	NZemcfzzpUPaVactVrcnRWc6AZn9sT0xqspcnxYQVWhNmaODFH5ZyNlWtCXRTbgmtPzSykrbki4
	i9Q==
X-Received: by 2002:a17:90b:3b8f:b0:311:e8cc:4248 with SMTP id 98e67ed59e1d1-315f26d29ffmr11663500a91.33.1750950170678;
        Thu, 26 Jun 2025 08:02:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdptXbuCusOcSSm1v4l2+op7oqmsQT4Ib4rFlDAj00T7SkOzlBe2kguaZuOM+pV5f/S3t6xw==
X-Received: by 2002:a17:90b:3b8f:b0:311:e8cc:4248 with SMTP id 98e67ed59e1d1-315f26d29ffmr11663420a91.33.1750950169970;
        Thu, 26 Jun 2025 08:02:49 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f539e6aasm4593623a91.15.2025.06.26.08.02.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 08:02:48 -0700 (PDT)
Message-ID: <3f6c106f-cbd3-4f9a-8e7c-e43b51457bfb@oss.qualcomm.com>
Date: Thu, 26 Jun 2025 08:02:47 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [question, bug] regularly disconnecting wifi on RB1 and RB2
 boards, ath10
To: Alexey Klimov <alexey.klimov@linaro.org>, jjohnson@kernel.org,
        ath10k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <DAWJQ2NIKY28.1XOG35E4A682G@linaro.org>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <DAWJQ2NIKY28.1XOG35E4A682G@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=YYu95xRf c=1 sm=1 tr=0 ts=685d611c cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=sXrhvLzian3437fu5cAA:9
 a=QEXdDO2ut3YA:10 a=B0GORZ8-IyoA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: Q132XPfFoS-Px3yns6Gzg4Ze0fgD-swT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDEyNyBTYWx0ZWRfXxDwBqchO+3x8
 Yyt0adOHKJWqR6iA4fzv+CFOc0IwLFm2Ht5tedYTf9JiN+UNuLI0tp4WerNw840X3WYhJBr5yAA
 b1T97/zyA9ogjvoba9Q8YqHdSnEobx2oJ+75aGArU9lYzd25dEuGPaM1aWPtkOKVRsaPsLqhU6C
 DdpU+BOO0zyXG+6CBOSclIUVFcm0F+PlGPZQuR1Xf/qYDpqEwQpeQ5/b140IvQuAwNJL2Dk+hjH
 C4lpShXBWpn4A2qAwhK5X5GeUnTnfaCRGb6/+6MVAYlmHq4mpvx69KDb8C4LhOq5Be7gTZkc2DC
 D+VtiW11QoKoy/Ydxp9/XUUOEOmpF4+ql0o+F5TptavMvMhW4RKFpnh2K0bHv7QQ7aBnsa4hV38
 MKP98SvaP84sor3Rcg98pslNNZ+H+FrPbz4MfiEGp+8WT+hM0VbgrC6vGd1GpEWOpQFD5jHZ
X-Proofpoint-ORIG-GUID: Q132XPfFoS-Px3yns6Gzg4Ze0fgD-swT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_06,2025-06-26_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 mlxlogscore=755
 clxscore=1015 mlxscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506260127

On 6/26/2025 7:48 AM, Alexey Klimov wrote:
...
> Any hints on how to debug this? Any debug switches I can toggle to debug this?
> I am happy to provide more info or test changes/patches if any.

https://wireless.docs.kernel.org/en/latest/en/users/drivers/ath10k/debug.html


