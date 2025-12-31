Return-Path: <linux-wireless+bounces-30235-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CC9CEBF04
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 13:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA633300FE34
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 12:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E482F2FD675;
	Wed, 31 Dec 2025 12:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SqbFdJji";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bBVNJmCM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EBC2DCF69
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 12:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767183571; cv=none; b=A6Ok+dLfoaymkPUA6+Mknrqmp/aVSqb6CW7G3zCHsWWANr8hggwb6U3j14bXtL/F5dM6vjZnA70YZMJ95UtacVlZ2DXIeaokYS/mCUXBkIsxSZkbbls2FcDrQdIsKMWRrVQzt4El9OJJca2+vwGgidn9iCZskSy3hVbkD+sJDcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767183571; c=relaxed/simple;
	bh=5zE42THlvMDT8e78ERAJCP3VXwEkecj40vMqsrK/4bQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uv8pg8UY5yftQEW+rU9nJH5kb+gSW+L2lUwioPmidDduHLPby9L6ET8Y67mDDDXT15E++4HFeyOiyyWWIKP1NZI6ZLu0jOe5v/UabUCxG6KWYo73p09HLOwjfoYsyDvkW5rWyHgoa2gi+EiERecu13C5azgjVx5YHeAl4tlNHXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SqbFdJji; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bBVNJmCM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BVAi4J33367077
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 12:19:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Xz+xZs2XNmhxuGnfco4MJFSJELyf3YGCWmUww37g3ko=; b=SqbFdJjiHICg/tIN
	xEggnwI4mOibHhIycb28cGfoiu6ke+edR/CNYaNq6x/50ZcUqV1Pid+1IHErjiYD
	xtlpIcatn6HUYrB3UfUaC77I3TXUSOMMjyVm6ofcRIe6XLwj3AJe0d78Vbo4nYUT
	aK22TCMGj+/0mdnJ1PzMMrzehlrRn4T0uH8kWS1J1ezNwJDHuIKnsvAx2YYvAZ0Y
	zUG/GZjK6s7ur1B+ooUMcd/gnObBRPYqV54FFHkPSs64aAVzj5L1bSAwNJzhmHK3
	9WvkMlPxq5lRj645il/843Fqp1byQA1C36A2WHWhzONU75ubYJItuojOIsn7JFYw
	i6TRSA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bd2bb04g6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 12:19:29 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4f34c24e2cbso35493541cf.3
        for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 04:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767183569; x=1767788369; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xz+xZs2XNmhxuGnfco4MJFSJELyf3YGCWmUww37g3ko=;
        b=bBVNJmCM6B//HoSBP9RNTUsUGLRFpgwSOCq20S750HG58NSx7qpfp86uoEXP22hdYg
         j2DDswgUrVbBAPBEcNM8ljRL+DZVkbSFCLN3bbr+vIuQMiy9a8QR9K/SocGO0f6snmCX
         mDTnT61eSwWj1Q9zp1Q8HkhFppHL/suqvD76Fv+G/Kfsgq+QaIGAZpYekrEvayB9s5EY
         gSSovwlOoaGHuFiBwYCgDGwshOtBCjxA86NS7i1DuGppWGrPCSvOXsxUxiYPW87CSC9/
         VXuMoO51O0eeqTEevJ70hOeA6Y0wCNxxI/dzRBYgo5Pulx1M+PxzcfBZhp3a+20MDWFL
         PEPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767183569; x=1767788369;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xz+xZs2XNmhxuGnfco4MJFSJELyf3YGCWmUww37g3ko=;
        b=vrTi7s6qV4LXI23TgpjsFoJ3qqKTDULOnT6p2UkTRrhzlFrdykI1Nh/CjuO+/qeOhr
         kykUypUes5INqL1Hl10BleJRx6DfhO/a+Hlgj/jB6FtG2O5+BARd/y6JCRzzxsj7H0Jf
         Fwzt2heMFd+GEC56yZmKghf4FweeoT9xyXQLcnuBTHU3VxeYP0vJmew2mb5dJITuDsH9
         naBxq9Kf569+3BHrCZculMJeX61hPjujmUXJBN8ZdheYLKpP5Fcvw/5k6Am8vGLQPny+
         i1hgGlwbu0pbyaKsFrbNqYEhJUhHu4HFtEhEkQHuQGC9l88o7V57prs+J69oprD+Hkkv
         OIQw==
X-Forwarded-Encrypted: i=1; AJvYcCWrLajt+rbmryJ4pBNv/z/co3QRMcreE/t77hOf6Gy+UJFbztm6eIRwK6C0f5bDwBsFM2xNllNZJTSkYGIYGQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwMipPXWSYaeMtfcjF2bp8elhjEVvn/ft0XzycNWtv51d4hQ21b
	CJdNmz5SxpK6GrthJmYm6WDBf5KBYO/cFqm8llqc13tWXJM2I+aLfqiKUA9DPICt7bjMlNWHYn1
	luFWoWcaFKFSWkRfzHCiEzcsbcQFOgnh6O5XNCZWtQ4bjhVUAxGkgGR7okOSx62o/R6Rf4w==
X-Gm-Gg: AY/fxX4iHFeKCOmDnGiC/3JOj2K75FG5wM6b3ahRCGUzY3U8ZHQUejMSef7F0joYzOh
	C5EZ2FJFGLFIFWjKGLptWbHvP7nsbCn6b4zWndFb9NQw0d46WLI51cGF++oRQ6fREA5RTlbJRL+
	muD7a7OLD1cvB2/uhTr8vY9X61BVD3Lbx7mjHwy6Jx2vk0BB2PRgp6gJSNTOvd/pR5XIVnw6cFQ
	DqhTprmw2CrCMgY/wTb8lH9I495wuqTHtK9q/BhbHiHpWs8isJ8CWfPiUb/QUmN2HNn1CDP19vh
	y4KEmcKKvMezBbaXKyjStdpPS20qbG/b0oUZDxQKHrwYf2rmwMkGl6WlZNO96vEeHjbnciidMKM
	cgN5H78LAcO5Wwn31rRTrBX0R6vlarM0/+V2W2s5M3WDGDTBEbyjpSnmNkxrM2XrNjw==
X-Received: by 2002:a05:622a:1922:b0:4f1:b3c0:2ae7 with SMTP id d75a77b69052e-4f4b43e3a80mr373002481cf.6.1767183568703;
        Wed, 31 Dec 2025 04:19:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE17gAkMD/VQbxKbGwU9yVlfZFQ5opbRwOVwkfXCULRVa3rxvdDFea3lTOfrcxDClnLVCPsfA==
X-Received: by 2002:a05:622a:1922:b0:4f1:b3c0:2ae7 with SMTP id d75a77b69052e-4f4b43e3a80mr373002211cf.6.1767183568144;
        Wed, 31 Dec 2025 04:19:28 -0800 (PST)
Received: from [192.168.119.72] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b91599844sm38020443a12.25.2025.12.31.04.19.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Dec 2025 04:19:26 -0800 (PST)
Message-ID: <ed3e9128-cf11-4ba7-a7f5-cac2c537c2e3@oss.qualcomm.com>
Date: Wed, 31 Dec 2025 13:19:23 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/14] arm64: dts: qcom: sda660-ifc6560: describe WiFi/BT
 properly
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
References: <20251231-wcn3990-pwrctl-v1-0-1ff4d6028ad5@oss.qualcomm.com>
 <20251231-wcn3990-pwrctl-v1-12-1ff4d6028ad5@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251231-wcn3990-pwrctl-v1-12-1ff4d6028ad5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: eHLepx504BZr4XVqO9ZKHGVR53OUuJHG
X-Proofpoint-ORIG-GUID: eHLepx504BZr4XVqO9ZKHGVR53OUuJHG
X-Authority-Analysis: v=2.4 cv=dMKrWeZb c=1 sm=1 tr=0 ts=695514d1 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=YN4nVyxdPvXl5XCbABQA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMxMDEwOCBTYWx0ZWRfX+tXrAlfmzFFF
 f0bbd3cpigaAc8oHutO3VnCajrcD7KL5F8YgZs/ZbqbvYztM7TlI9/EUbdBRb0LWRFSbbAFyGTz
 NzNVSZkxQGKgBAXy5J5gAQE1kD85lHuic9aNstkXiKzL+T/vZ5mgWKUjLGvyNze1BSKikeReI18
 7LRj0JVSkeNuZafyaHDinURIkgBYtu8uqAOB7N678cBC/2FVpucQSJXBB9osYU4pc6mMrf3XSE3
 dI7KAmcixzu3HUQrMv21nDqH6Tp2hAkJNJUgh4uuuxv2AEMV3EVSwWvlTdNanz57oy4qauk7TMg
 DIWUyuK0bMr0oYlzQenzf+abTvLVBMpcuhvBbu7IP0cLa+pAtHva99Jv4TvLzJitLxURCixF8dq
 56kQjaOy4bBGoBbkY06zoAL0xASe7Z/6L2StlVfvDWRF+eTIfmjT4GC+59q3X+vk/ssXfjdGDVD
 RQ8pwUyODIqvFZjwYNQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-31_03,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 spamscore=0 malwarescore=0
 impostorscore=0 adultscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512310108

On 12/31/25 12:36 AM, Dmitry Baryshkov wrote:
> The onboard WiFi / BT device, WCN3990, has a simple on-chip PMU, which
> further spreads generated voltage. Describe the PMU in the device tree.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

[...]

> +&pm660_gpios {
> +	sw_ctrl_default: sw-ctrl-default-state {
> +		pins = "gpio5";
> +		function = "normal";
> +
> +		input-enable;
> +		bias-pull-down;

Ideally

func
(no \n)
bias-pull-down
input-enable

anyway:

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

