Return-Path: <linux-wireless+bounces-17331-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 425C4A096DD
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 17:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CCCC160F8F
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 16:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED69211285;
	Fri, 10 Jan 2025 16:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dAPEUd7Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA35212D68
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 16:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736525566; cv=none; b=ApjJoPGURBSN/Xlj9j3tJqBwvE6Yqr9wxW6WMqcuwC8heIm/Xpek2pnSeuPX8cxtsSYFYs5FF8NYt7rgZIyk/3hEgdTTyXhmmUb5gHhczS12QfD8gsvuhM3+GaMaE2JduUa+0SZDt+D9KvePE6IRvBU2uKOxYo+tCFJZDCapnuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736525566; c=relaxed/simple;
	bh=uS8t+eG04Ni3AC8G+VrEuiNEd5PCqi+sWEejRVXxA+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fAkAtMo9Hbirnl49mpyq+ZHvfitYsophR8Is684dHa/w5eEMiJSYBa9MWAr3P1Wep3Trx+/Q8IsnDB+htTCSRe7ch2b5mkI16IyMRs+U6pu8jDa+SqpAv3TrU6mQVl+iQrdx/NnEQBcYt6gz2tF/jbFrf50+1LsB+7tWPZAHcaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dAPEUd7Q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50A7oi81012099
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 16:12:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zbBr/2YV+43XYtiAHsrETIQDU+mB0rvIRAZTp0sqqQ8=; b=dAPEUd7QQwdBcWzs
	exgj5dU5Nxz0Q3Koaq2VLwmBMlE+ypyEtH9Hf401/rJJbNmE+ecMYiJ/ShO9r/aQ
	/Jn7osgUd5bTCElNV35vXHoAyPhh++VPkwaeS0qk4c9icW3U8XoYufEEBaRzwAHh
	th4dQJlA9KbTEhZFvxBeIWo9eYXBJFR83beGmihi8V7Qrlzb0fpAOARrCpnD/TXe
	Z+IuFji9W2HP0SobT26yDQfUlHLR3M20ca8uduoSoGe4NnajN8sXmh4beQBU3DCs
	2HekKven68lLlOunojY8pWTLM3o2bo4CL3XmyquhryYyKHbkAEUwdfhha7Vbhvhr
	p+i2Wg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 442yh3hc9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 16:12:42 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-216266cc0acso55400955ad.0
        for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 08:12:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736525561; x=1737130361;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zbBr/2YV+43XYtiAHsrETIQDU+mB0rvIRAZTp0sqqQ8=;
        b=LxjJmcPm22WOtLDg6gsONt9/iYcudqgc82XebgE2yFUTmkrcTUjLQmaBAZdphorgLC
         wk9iTk49PQlddaF8BmCKboODmOqCofeAxJDVAtRwkG+UIjrrP3d4hvt2hprp16OwGAcz
         XgpxXpF5Kuxf2xVvPB4UbpdyyeRdzm83TPBAE+pnBT88L8HC8dLuyA3DnbenT1gpWCPm
         kEM9d1ZBXPrxqSByuhGU601UWaqMoXurQAWYLsVuBXz41c6LN449l5N0UV3+QTBoREf0
         JCdM0feeq1nbGgrf9sLGxBMYVx7WolFw4xnS0fDWjimQodhDIE4zft4kLf3HSY5d2Lq3
         W56g==
X-Gm-Message-State: AOJu0YxbyDRIc6pg2GpyVs7YMmFHw9zUa1bNns5ALqRCQrzi/Rc/ianO
	ZetcBETLaycOXJ5xqcI/IjgTb3hTQRG98QWecmcNucoEuLmXqt/SY6pP/ywdv4Dv6jZRW886bC0
	cXTsgldX5uv2lHnbzlHCMM7kfv7s5X/e7owc/rlxRxOABWHKUzNEBYO+Yz+iV9YMYew==
X-Gm-Gg: ASbGnctmT3+CBJCIobmGXwPasvj26muivfLTRtFbCuW7Iqnq0+vONBERfp92/pURz5a
	TCn2AKy7COEDz5uDd0Zd0HP9+n2jz3F3xDy7X7Z49qj4f/I5ajfmENvgU8PHnS3NPmcn11Pf0yE
	FMvMevlu36HCeu9K4zfKkFYrLJIisFRbKMAyPkmTgm3CEoTyAmPmNmaOkxNCvecMf6ZnqwyaHRP
	AisVcIA3iqa4+5+LAfAj+avRDtSYwijNaF1gb0X3wBkT9CoVVO90DoZHfVinsZKX9MZ0r7bVT0w
	zB2M1CB2Tg4sBzoj+L9t56aXqqv4wxSvbxeqSrA8XggZTKsNDA==
X-Received: by 2002:a05:6a20:a108:b0:1e1:f88a:3106 with SMTP id adf61e73a8af0-1e89c91f577mr11297481637.7.1736525559989;
        Fri, 10 Jan 2025 08:12:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENi+S940ap8/hhfB7Iq2nbBER+MXuNzad2FWMXp9TGJipSuQYikl3bjuJUKtZkTElDI1lqCg==
X-Received: by 2002:a05:6a20:a108:b0:1e1:f88a:3106 with SMTP id adf61e73a8af0-1e89c91f577mr11297346637.7.1736525558105;
        Fri, 10 Jan 2025 08:12:38 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a31de807786sm3034286a12.76.2025.01.10.08.12.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 08:12:37 -0800 (PST)
Message-ID: <7ce4b4d6-acb2-4972-bd65-7f682cbc564e@oss.qualcomm.com>
Date: Fri, 10 Jan 2025 08:12:36 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] wifi: ath12k: Refactor ath12k_hw set helper
 function argument
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20241217035920.2683568-1-quic_periyasa@quicinc.com>
 <20241217035920.2683568-2-quic_periyasa@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20241217035920.2683568-2-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: SDe1u_3xLUjqIOg6fDOdrSPEptwJ1c7R
X-Proofpoint-GUID: SDe1u_3xLUjqIOg6fDOdrSPEptwJ1c7R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 mlxlogscore=980 spamscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501100127

On 12/16/2024 7:59 PM, Karthikeyan Periyasamy wrote:
> Currently, ath12k_hw is placed inside the ath12k_hw_group. However, the
> ath12k_hw set helper function takes the device handle and the index as
> parameters. Here, the index parameter is specific to the group handle.
> Therefore, change this helper function argument from the device handle to
> the group handle.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>

Acked-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>


