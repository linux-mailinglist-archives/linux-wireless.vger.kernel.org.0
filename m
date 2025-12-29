Return-Path: <linux-wireless+bounces-30165-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD2CCE81EC
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Dec 2025 21:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48001301C92D
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Dec 2025 20:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53E3267AF6;
	Mon, 29 Dec 2025 20:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DRwYQYc6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ByFV6TeC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFD1263F5D
	for <linux-wireless@vger.kernel.org>; Mon, 29 Dec 2025 20:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767039611; cv=none; b=Di8m4TkOC72BGIFkLal2BIINVwfFOPPSwwSh4Qt4Y8iwy45JLPD8I0QibjFUotwbj8ujP22LPYlTHsYDW/wqPJO0vHKFHtUcHB2/GEykZhqHnarcrFdhMABEi+Sjq5thn3qShpOTWvYVbBmLFQmirxbA0bWtIlEI755b6Zf1ehM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767039611; c=relaxed/simple;
	bh=BwsOeiT9u3rzrRz11E8mkHEqiVBgJs18hfyrJTOTuh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ED4cbs6uPDzvLOHv6RjsBsfBdetps+KAFira60oqEqinPJTbKZ/v/cW+1G16DIqC7+a4s1elgnbzSDN2XLpjNS7djJvb182j5z2uHWPuIPm4waFUaildH8RRIfkCSoCCdsSxsqzKlGF3VS3/oBL/jTdOvmV446QMVMPcjTX9goM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DRwYQYc6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ByFV6TeC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BTAmUVJ228780
	for <linux-wireless@vger.kernel.org>; Mon, 29 Dec 2025 20:20:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7MozNexHgJw4PP86LYlmpf5GcfoVsuHBu4VnE8EoW0g=; b=DRwYQYc6xXrnDYfr
	4zRQWdR3gjE1qZXQA0FLzBPH7KkA61L1rU+1UwsFW2KeVAg4ylPLhHzsLwcVreoX
	RBdj6tQj9QdRrgeLzrsl9GpeAnO+WoQdhvIEUBuimZ9l/doWI6ATiXrc9yweeazI
	0WGbiS69rwFLUA6BPpDQDeXEmw4d/qGbTHIsUTwP9aVSSxNsunYUOzvw1gSlvW27
	Z+BdYghv3ZbMC269yXSZDBdNq0HrXwcTmJebFHgnbGo9qXqrwliIMQNXSlZGqjrQ
	U2VvdGIzyWc78GnzV4TFHUmOHt54ps1lb6YANvyCvR1MDQXnnDmUngnPDhMu9DR+
	OcPABA==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ba7u5n9fk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 29 Dec 2025 20:20:08 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-11bd7a827fdso17718498c88.1
        for <linux-wireless@vger.kernel.org>; Mon, 29 Dec 2025 12:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767039608; x=1767644408; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7MozNexHgJw4PP86LYlmpf5GcfoVsuHBu4VnE8EoW0g=;
        b=ByFV6TeCwejM9c00g1m657kaLjF+tU6LuWF2ToVTI4euAP82wg7cbSedeHIsyVvfy2
         agaLvGol5K0YtXtI6yaGn3uXKWMKQMPtwizXVVLBwIRgP8PELlCglXliRZIvOk5dJTKG
         5vGaIIUMzZmUa7Nar5owsg6Ap9sDiH2FcNu5xhy73vgQWvFgdnzxgbMyJTyetDh2/fS8
         qXjrsE4jLahYIuipKrLqcw3NURMEi81VtQ44Blk7RuvR8xSGg3lhozeCDpf8eHJjCt8Y
         Y/en/m/uoIsHgNFDofXV8is5MhhV4he0R6PiI4XrHRVS7jBzlB67D/m6iDXGtz0Sp7Mt
         J+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767039608; x=1767644408;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7MozNexHgJw4PP86LYlmpf5GcfoVsuHBu4VnE8EoW0g=;
        b=F4HJI8KLak41H8oci9gTs0NmhBUep8EK+PwWRDwS7o2BQS6NxbA4QWddZijALj9SIN
         Alv7OnRbfZtUEfwDOjNbmR7xj7+v+BReRWiDxlClFBN/vax05wlcMUrEEY+PnQY75VKg
         nVL1lop087JibLmKA4GEMHCCXT6+noT76DZQpI4RE+LhC4KMOtZvMhyfMGYqaW2VuI4a
         /fLbxYMItW+f0nqp4B13DJ4MRoVWfIRq/6JFS3VuGXWkd+N1fWbB0Y5jEm4HRr/G/Inx
         8CSM7lwGdlDROqjESuiq4EwRRgUHyqJuG8cL/wmzHPhxxgo7Kv9fcvyj94QHXtURam9x
         fTtA==
X-Forwarded-Encrypted: i=1; AJvYcCXgPqT5Guq7UGWYNTllTQlZ8gRInoOIEX6pxz+n+Ml6LwHDnTG3KnBYj4Zas/dZRzI+hLLwlCivFzTBKajebA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8bw5yXlO8xJuNXGT9+GpvOLVyZBgzgIdyXoEBBx7SIq5jFHot
	n0035KXb1lMsBF31v5Kp9OmsITi+EdihXld1vUJfWqdWELIk73SU9lc00H1CRpHFSd+3cWYk9GD
	gCz22YdNvVD0JA++rGUG1QpyZ2wz6PSvvjB4yt+/Z47WVNtVZAh9HoPy10xFsUFh9xOY/zg==
X-Gm-Gg: AY/fxX6noiHXMV0TOJrmWYFYS6rKXc10LPCP48Xz5pDcKpEjpqp4fJoAJA790jNxbTO
	JlM21lggvzWejb7yjE1RyTE4KjGpOQEoO2jqZNxjbslm2Cq3zFz7blvROvJd0VuOg0ZIQnkeEMP
	jLwA4A5xSNsMfyzIZ5v32bUX7iYZRYmvOoWQqtNsdEOtPb2JBr33QqTimIE8PmoISQqDxKufQKU
	6ib0pIWvTwkxgPTsKku+BfXuS8ougg2G7yrrA60JjaIfmdoEvgadxMenOkCS5/ZWvjl08fDhyhM
	16NZ4jmuXRNAWbPf6ifY2Z/leBMHpATix/C8T2PL5eBHvsmu635kPQ6Ii6s9fUU9x0mX1IaH9Yp
	0l2AmWJDbWRWI5YRA6jLl3j2Z1hPdd7E+sRZPJygTvCLXg9bQVvi8ZbGJDazIxEI=
X-Received: by 2002:a05:7022:e1a:b0:11e:3e9:3e8e with SMTP id a92af1059eb24-12171afd95bmr24941785c88.23.1767039607766;
        Mon, 29 Dec 2025 12:20:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/lwK2wTaR4697pd1i+xemc7zfhrLFxVX/r/0pN47IvpGex944GuH8FMyKdtpVLY3DVSOxHw==
X-Received: by 2002:a05:7022:e1a:b0:11e:3e9:3e8e with SMTP id a92af1059eb24-12171afd95bmr24941750c88.23.1767039607116;
        Mon, 29 Dec 2025 12:20:07 -0800 (PST)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217253c23csm117915702c88.9.2025.12.29.12.20.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Dec 2025 12:20:06 -0800 (PST)
Message-ID: <60aea371-915f-431d-88dd-3be633dc2bcf@oss.qualcomm.com>
Date: Mon, 29 Dec 2025 13:20:04 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] net: qrtr: Drop the MHI auto_queue feature for
 IPCR DL channels
To: manivannan.sadhasivam@oss.qualcomm.com,
        Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Maxim Kochetkov <fido_max@inbox.ru>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, netdev@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Johan Hovold <johan@kernel.org>, Chris Lew <quic_clew@quicinc.com>,
        stable@vger.kernel.org
References: <20251218-qrtr-fix-v2-0-c7499bfcfbe0@oss.qualcomm.com>
 <20251218-qrtr-fix-v2-1-c7499bfcfbe0@oss.qualcomm.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20251218-qrtr-fix-v2-1-c7499bfcfbe0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 4jkIcAI-WUTOkfRG41YQgorUBkTIejl3
X-Proofpoint-ORIG-GUID: 4jkIcAI-WUTOkfRG41YQgorUBkTIejl3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDE4NSBTYWx0ZWRfXzEe/cvGPYc53
 SzN5MXiIm6GZnbyqLcKcUJ9I5y3jl+OCLW60OqBkcmk4yL2TRStOUSEpajpgzMahzk0XqBhnDsJ
 /ijn1ATrbx0mu8NBEcHO0deVF9b7hpqGkrmJRUNmRWt/hnwSduMjyL7T0arAajT2SipjJ2ONqGB
 qhR7OqwLz45ybJzaAJcGOILjIY1KOJZPhLKI+U0ZjtZ/yA39pEK2N5oXsGaNY7asNsSf//EJPNy
 vwrGYWKyjHi4e4UFMczZjqGdkJrnQb5M6UZWsfgzmzUiSJtEmWO118cySYu1y289sBZDoGU3Aiw
 gfUTs7xB2DNN4q6zYFIToE+pxc7TjyxZXQPkyh44mRx0SMQptSuxzsRNtxfyQuwndBZ6NIHQ65T
 SLfnYL7XjSLMzzoLMbVtIk1UyjdzkzA01A2CqvbUDN1ZrBlsU/qmfzdzEWcrkMVhgKdD19I/Dk1
 Y+IE/Fds9vcsd46zxRw==
X-Authority-Analysis: v=2.4 cv=DptbOW/+ c=1 sm=1 tr=0 ts=6952e278 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=zitRP-D0AAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=isMaZ9OHK7bkWVW8W2QA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22 a=xwnAI6pc5liRhupp6brZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_06,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1011 spamscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512290185

On 12/18/2025 9:51 AM, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> MHI stack offers the 'auto_queue' feature, which allows the MHI stack to
> auto queue the buffers for the RX path (DL channel). Though this feature
> simplifies the client driver design, it introduces race between the client
> drivers and the MHI stack. For instance, with auto_queue, the 'dl_callback'
> for the DL channel may get called before the client driver is fully probed.
> This means, by the time the dl_callback gets called, the client driver's
> structures might not be initialized, leading to NULL ptr dereference.
> 
> Currently, the drivers have to workaround this issue by initializing the
> internal structures before calling mhi_prepare_for_transfer_autoqueue().
> But even so, there is a chance that the client driver's internal code path
> may call the MHI queue APIs before mhi_prepare_for_transfer_autoqueue() is
> called, leading to similar NULL ptr dereference. This issue has been
> reported on the Qcom X1E80100 CRD machines affecting boot.
> 
> So to properly fix all these races, drop the MHI 'auto_queue' feature
> altogether and let the client driver (QRTR) manage the RX buffers manually.
> In the QRTR driver, queue the RX buffers based on the ring length during
> probe and recycle the buffers in 'dl_callback' once they are consumed. This
> also warrants removing the setting of 'auto_queue' flag from controller
> drivers.
> 
> Currently, this 'auto_queue' feature is only enabled for IPCR DL channel.
> So only the QRTR client driver requires the modification.
> 
> Fixes: 227fee5fc99e ("bus: mhi: core: Add an API for auto queueing buffers for DL channel")
> Fixes: 68a838b84eff ("net: qrtr: start MHI channel after endpoit creation")
> Reported-by: Johan Hovold <johan@kernel.org>
> Closes: https://lore.kernel.org/linux-arm-msm/ZyTtVdkCCES0lkl4@hovoldconsulting.com
> Suggested-by: Chris Lew <quic_clew@quicinc.com>
> Acked-by: Jeff Johnson <jjohnson@kernel.org> # drivers/net/wireless/ath/...
> Cc: stable@vger.kernel.org
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>

For the qaic bits

Acked-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>

