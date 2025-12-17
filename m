Return-Path: <linux-wireless+bounces-29845-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C593BCC9425
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Dec 2025 19:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 95748300CD5F
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Dec 2025 18:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BF32C21D3;
	Wed, 17 Dec 2025 18:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XX0FTlGh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dnHvZqcR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5297E2D2498
	for <linux-wireless@vger.kernel.org>; Wed, 17 Dec 2025 18:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765995529; cv=none; b=m3X7B2zYmKmXKc4qjpObVz8Qy7yVHNFKn8L3PNhV+os1bPTnLZpPB0x9mpdmu8Mp9orxfJWV1A8FVO/sojWY5GJRbyKJ2rCPIp2kmkBAb7YHenc/Up0i7aIW6LwJP+g1YjAS04ddpvR9OsM/rt6RYl13D9obNMn5dtl2YcW72Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765995529; c=relaxed/simple;
	bh=KPCoPks2Y2/j+fWOc0DjbN2flfAgVDX5MiFdzCmlPxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Goi8jO9gpPhojCM4xXLkO2nQDrUtlBO8ZJNHx3qhWjHIzZLE2lTAMxhcwP460AuPX6OhAvQlMeBVJk+DGf5zsvUINRr4n0lE5zNc9HtrV1jEAc0vOCwMQbkYOuHcfcTheQzbDihcxjQpj02bRlHFXWicJdNhkB+vCTWPLrgaL48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XX0FTlGh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dnHvZqcR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BHCKrYY2673983
	for <linux-wireless@vger.kernel.org>; Wed, 17 Dec 2025 18:18:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wBmu9AzZ9xdbtIOjudSzxPBr2BE5g0gg/z6YBjxDbIE=; b=XX0FTlGhGcl0GgQl
	ByTU7cTPlDPk/BXambHGMBBrAFNZaJfIcs6xA6ew4ZJ9tR7UJQS+gqePcy3CuHsP
	vAotqv37mohmAfVk+eAvIYj7rZG2V0YacO0NNdP0m9w3yE0WWFoEoPEvo6maf4xs
	6DWw+J4IIVBayH2jAWjYTnjijGyHuVPMpR0JkPMA9P0/h03K2SoFh/RKObvRsWpV
	eE00BccsGUxbyFdW7MIQrXSXW3cfy70VmIAoj7vErrMdAHU142riKXQR00XrVdgA
	bnC0PryPEaCZPZzqHVwAwn49yCO1jVtKSjP0r7hhODK19mvYysQxYak3xA0We1cb
	FKeYhQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b3myj2qn4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 17 Dec 2025 18:18:38 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b98e6ff908aso15574687a12.2
        for <linux-wireless@vger.kernel.org>; Wed, 17 Dec 2025 10:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765995517; x=1766600317; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wBmu9AzZ9xdbtIOjudSzxPBr2BE5g0gg/z6YBjxDbIE=;
        b=dnHvZqcRtWDUre1eSfogviBxCN1JzyHdKmapu2M1qOVC3dThbDQ2E46ZVgFM8YO8co
         cnHlKpe30HIkVhPSD9wk/hsMp7B1QkWxRU19JFcDyyIEzwYb/ZIAijsxKCuCW7fxxnqf
         H9TdxfWDcUZ21KsJEqIsUeHy3o7IW9H17uzg8Zet2kh9fuOoeTaHjx7WngyiYzksfqyy
         vco0eLOEwX2L3/1Nph1uWmmQ/tK47ynkdnS9Orq8mVDCZK/eaQpSg8H5Um57U23qJsua
         uWPp/Zo9/eMIL7nV83cZ87zQ+ybvd9sjX+wf1Kh/XvKANbAXYDIRumejZZVbL7vshHdZ
         T0Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765995517; x=1766600317;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wBmu9AzZ9xdbtIOjudSzxPBr2BE5g0gg/z6YBjxDbIE=;
        b=BL44rtUceBovQn9xcSBeJ9pIrFHi4yLHtMArnqXKeuEuwmFj/q4HOLLiCkdVEYKgBD
         9JvQ8Gu0I8jvqiRys9PohMR+X+rtqZnNUJ2VTjUk5GyVSLpE4wnWGl+F9oYVH7QqWzXy
         M2NLK25j4YPXecVhmeF0dW3LlZabS89CZMTCv3g0o4Lq7tIAlmqqqrGtCy5qx+fnc5wA
         0rnYznKSqqHGMk/wDPicEbqYRA9o9i44GHx814cOpuItfkXhWYdKSybPckMQju3L2SL+
         wKVIq94VV80pSdrp8HcTQ/9gtC5deJHZx9bj8z4x+uEnktGKhAqbIQqwuPtCS6oik7tN
         saxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVS69oGQREcMkkAZyC6F8xtO59pNH9WDwJnQ89ydje6MOZNvdoGw0+ryHmrATN1DaoDoFmRTXGf1FrjAQED7g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw7mbcFTaJP0PsHy4tLM14e/DqSy+N94+LfbVg3vyNYeavjG1B
	MwxM58Vs/8Y8VwfsqBRcLWVCFpY8aX0Ff/m6qEPRxkut6/iH7xECuxH+DGfRCpfxREOFrdIPGS3
	A1QVZYOvr+9jijQf9Qpg5puRUi8jXyXj05A2GL9zQlD8DOuE+PgdbUsXDf87EYaE3edYpztfXUf
	5Faw==
X-Gm-Gg: AY/fxX4y7G5zklmQlkBAJ9PHtGux5/olKyOvwr13zqj69hktSu1h4D6dvQr+VprvVQN
	OLjJGOoUVtEGNGwHuA/AC/PTreK1+YHIXaMs8MYjc9Q6DCNk3IkDQ2NLdGzWW3B9WB7GAHq3s39
	PqjoY3nsaGHziq28GAFyD140vFoHwKftjH6w9N03FnOCzYj3hy45uD9grl0xfBnZARv0AhGfnRU
	r+zSvyvSAR4qDMKeS3024k3b4bgq/xPTga0zhqnIeg4pDHEhN/NAwUOlnbAwxEU+ODZrMHKio8F
	tq4uFazLKTie6vbMxmsoAvw9pkZT3V52ezRXZVWR43Ve/ApUJifqEOWh66v/XSuiiDEdEm7piTb
	EDvpHRtj6Wyi1Rp7c0AsYYtMafeY6CrTXhgGOPYKE9/KodkVoE7Kef4u8t2x7Avn3k8nEdg==
X-Received: by 2002:a05:7301:182:b0:2a4:3592:cf83 with SMTP id 5a478bee46e88-2ac303958camr10594094eec.39.1765995517159;
        Wed, 17 Dec 2025 10:18:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6ScF6p2dbGaIAlfPTuofAf2/eZTtk6ONOKBGl/Qm27pAQp9ttnZa9kTtvsKTJrPW0AuH8SQ==
X-Received: by 2002:a05:7301:182:b0:2a4:3592:cf83 with SMTP id 5a478bee46e88-2ac303958camr10594041eec.39.1765995516561;
        Wed, 17 Dec 2025 10:18:36 -0800 (PST)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12061a93616sm517453c88.14.2025.12.17.10.18.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Dec 2025 10:18:36 -0800 (PST)
Message-ID: <5e568034-20a3-4ed5-a8e0-c010e5aa7b82@oss.qualcomm.com>
Date: Wed, 17 Dec 2025 10:18:34 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] net: qrtr: Drop the MHI auto_queue feature for IPCR
 DL channels
To: manivannan.sadhasivam@oss.qualcomm.com,
        Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
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
References: <20251217-qrtr-fix-v1-0-f6142a3ec9d8@oss.qualcomm.com>
 <20251217-qrtr-fix-v1-1-f6142a3ec9d8@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251217-qrtr-fix-v1-1-f6142a3ec9d8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDE0NSBTYWx0ZWRfX4OIE9em1LPAk
 9kIPjXNTDnr/z6qy0vZpEVQAwzlmrli8Eykd8se5oPNLuoHyibrwacIo5bS9T0uz/3UGHF7HS8b
 MRlFBOyJbEnGZAcsvZpQ4PZ7V7oMt6S4HV+F3QVLn5/VFH+PvETTdwM6nXmEQg1kWEx7LuD0/Gd
 po+YYqpbIyRRJ2rZxva0sNUdquSb/h3oCv+nnsbU+sfHi5kb4Gf9V+lqdJH8ujITF2YE3dT0/l2
 9MCbWDr4xN4iknpJbOWq4pNmeIQ/BeV3bn5+DPVgVWCEo3/FxQWH5pmQCrC4V4oGhleABpS8cHT
 pZ4nK7PkgcHcmPcZmCgnot2g2T2DhddECQFQmEOqJMvR6fs2UMDBsoN6Azp19FIS+ZpYDxwkKuH
 BY7H8AKEFdhAkkh1gSm8+E5C98tCCQ==
X-Proofpoint-ORIG-GUID: XC3lNkU-lJaPE8x7U14WeMO1oQCILrWd
X-Authority-Analysis: v=2.4 cv=CtOys34D c=1 sm=1 tr=0 ts=6942f3fe cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=zitRP-D0AAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=isMaZ9OHK7bkWVW8W2QA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=xwnAI6pc5liRhupp6brZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: XC3lNkU-lJaPE8x7U14WeMO1oQCILrWd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_03,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512170145

On 12/17/2025 9:16 AM, Manivannan Sadhasivam via B4 Relay wrote:
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
> Cc: stable@vger.kernel.org
> Fixes: 227fee5fc99e ("bus: mhi: core: Add an API for auto queueing buffers for DL channel")
> Fixes: 68a838b84eff ("net: qrtr: start MHI channel after endpoit creation")
> Reported-by: Johan Hovold <johan@kernel.org>
> Closes: https://lore.kernel.org/linux-arm-msm/ZyTtVdkCCES0lkl4@hovoldconsulting.com
> Suggested-by: Chris Lew <quic_clew@quicinc.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Acked-by: Jeff Johnson <jjohnson@kernel.org> # drivers/net/wireless/ath/...


