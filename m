Return-Path: <linux-wireless+bounces-15915-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0DD9E4D15
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Dec 2024 05:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C954168B28
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Dec 2024 04:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939AD6A33F;
	Thu,  5 Dec 2024 04:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FtMyrChz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E955014A90
	for <linux-wireless@vger.kernel.org>; Thu,  5 Dec 2024 04:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733373935; cv=none; b=S8mx65AfiBdt17hyHfzyBF8rJCJRt8ArHTia0WU/dunt/rPyZ90Uj6cQCfcNhvepK0OW895z68wd6w5kWB8N4rgM49kGIZCUSobepw3HsQwJcvIthhA7r6wVnqILW5+HFbuV4C7NMSViWglF1AsaV0a1Vh2Piyyla55Z5NNUquM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733373935; c=relaxed/simple;
	bh=kyVaXae4z91ov7+psWqxLjTtt6OTZFWZsDcIZWvhcOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LokfrTEUzVkPmn3dIlrwtXF5XvIPa7ViIwCgXfXEW2pZ+lCGXhmBLSFXr8f7TmJUnJNKnDhGlGod03+J1rZrIXuJbwxKnQ008nixtB18Ej0neB18cWPvH0RBCzDdMe/MvbugGdpULBGn1CnVHvoNXI6fk7VxrQgIR7+SJ3ov610=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FtMyrChz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B4E1qZk000364
	for <linux-wireless@vger.kernel.org>; Thu, 5 Dec 2024 04:45:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tA7vDpEtWnxdqqrfQGX83G+hxmpW0xSW+DnYSlevqn0=; b=FtMyrChzk/yZpnRm
	idmwf+4gD5wX2ZGkdf45o6OFBr+Phdbd4i9MkI9yvb4DpkabaMDXQs+pA/X5orbY
	/SlvI4yz+2fuSLrTk2DHLlaHsoz/m5UgyKC5uXBrNwaNWASkb72lolj5PGGobKHQ
	m7nb/LcqSPiCPRL3XAxc4Yui0VQLvrcrGyBZuAStc1i3BHwtOF1I/T8zsk7eXYwY
	wlOScNhzN3DLSP7vJZAucy1VXoezFsVrnbtm406wQj6Y8XoiiHS0/SKQHfCRGf7U
	+mJG6fhX6APitsoef7MnrHFbQDlah/m7J8+tC2KcCu4n9/BiacDi0Z/OMAmlQAbS
	vMfr1w==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43a3faw88t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 05 Dec 2024 04:45:27 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ee4866c419so961674a91.0
        for <linux-wireless@vger.kernel.org>; Wed, 04 Dec 2024 20:45:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733373926; x=1733978726;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tA7vDpEtWnxdqqrfQGX83G+hxmpW0xSW+DnYSlevqn0=;
        b=rp+JNE6Mf5x7wMkb0LKfjdFd89lyTjdMnRew5mZBiKS750c+BDdCC9Q1v++wMHDCe2
         t8ByRZay07uoH/9wpCH3lHndespBNfpb8dfDkZd/1Je4zJMqLUWCYVWjszYTs3Ll33Sf
         An0TJfYXRkf+lbMC51iet2iR0/I4BL1sK2nn0+8pcj1Tj/6+zgVPQGhb+Lzls7h5+fI5
         QMHNqHtmPny1w94KN9vdioCo7MSYeyHouxY2hPJl26301OIoKKHbT8CESl8HpagrnPAl
         YQj7PuuMCKAgsKYfEa0sE4yp5CLTK0OCRwsk4TfpoxHbVRVs9Mt6YSzmAj3E8xevjoUp
         W0ng==
X-Gm-Message-State: AOJu0Yx7yPMBYFfJg2AGjIPrFj+w403/+wDY4ym2Q4w3dxJgwhRt9oSK
	+yuLWCE/X6J2v/zru98xetOPDmijHfUHmpxv8JxdCVao8PxQj46ou7nlTBvl1pOKIkfdSrRgJth
	Sg19Wh7PHut1ZzhAJopeJ9ZHNgmbHA/HECac0Evmvvg3mtpPmIO8ysxzrDaDIiJ0nWlXXc9fqRg
	==
X-Gm-Gg: ASbGncvHHt16uoIlqDnPB3G8l1oLUijQ/uAyvyunAjE6a1YAteNZ6Qoh2eXPIUTR5+p
	NloqdAnnN5oxv44R0vPzcVhFNsEJLKUMuXmymZM9o7lllCUKX+uY49r7a+lytkMuSBY9w1iyKyC
	nChgt4OO8MDJfJFVxhVGxIccgO+d4UISSnWeocWtHd7GWuSBjTOhLltSaIjb+bhvSlNwTTZFALB
	CZY/LvPY+DLKvxLn/BAAONc9u5qUDnAxEvkRQdQrXtg79eWxiaFT6KC8YP1g3REAXrfDmmHsIMV
	asHVLzDi+gzYCFKOiPEHMuK1gwkuR/YEkkAGhy69izY=
X-Received: by 2002:a17:90b:1b06:b0:2ee:df70:1ff3 with SMTP id 98e67ed59e1d1-2ef00f15e0amr13617609a91.0.1733373926099;
        Wed, 04 Dec 2024 20:45:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4cFQBTtp29tsc6k4Dbg41pkutVJ6aXHH/7fhviR6XYSqAiczjHi5OqbnUOOx3fp1vYC6UoA==
X-Received: by 2002:a17:90b:1b06:b0:2ee:df70:1ff3 with SMTP id 98e67ed59e1d1-2ef00f15e0amr13617589a91.0.1733373925769;
        Wed, 04 Dec 2024 20:45:25 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef27078a7bsm2305780a91.32.2024.12.04.20.45.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 20:45:25 -0800 (PST)
Message-ID: <f39ef87c-f1da-4d32-b998-453bc50e3225@oss.qualcomm.com>
Date: Wed, 4 Dec 2024 20:45:24 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: Add support for parsing 64-bit TLVs
To: P Praneesh <quic_ppranees@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20241204071238.948885-1-quic_ppranees@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20241204071238.948885-1-quic_ppranees@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: HF12iOybzbA5zx2ZS-lpbjHMCO41q01p
X-Proofpoint-GUID: HF12iOybzbA5zx2ZS-lpbjHMCO41q01p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxscore=0 suspectscore=0 adultscore=0 mlxlogscore=966
 lowpriorityscore=0 clxscore=1011 priorityscore=1501 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412050035

On 12/3/2024 11:12 PM, P Praneesh wrote:
> There is mismatch between the format of monitor destination TLVs received
> and the expected format by the current implementation. The received TLVs
> are in 64-bit format, while the implementation is designed to handle
> 32-bit TLVs. This leads to incorrect parsing. Fix it by adding support
> for parsing 64-bit TLVs.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
Acked-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>


