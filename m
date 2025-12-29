Return-Path: <linux-wireless+bounces-30166-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B09ACE820D
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Dec 2025 21:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE52C301A18F
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Dec 2025 20:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B5026FD9B;
	Mon, 29 Dec 2025 20:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KlAdv2ub";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TtNdLZOY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5898C1FF7C8
	for <linux-wireless@vger.kernel.org>; Mon, 29 Dec 2025 20:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767039711; cv=none; b=UwxxoJ4552Ef0NO8zcN5wzPH+32aZyDLM4c97ZvTGMtLRmlg8Nn3TZqkuQhDrC0b1bXhADgf+dnLzg1v5zdiyapFJj45y84Z+0PVDjHhWS5vc9SQU6AqeApDgiy2sWrItgDRrNw/ZE4soeeW02H+4HSdMFYTOIYbmumV6WBGK6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767039711; c=relaxed/simple;
	bh=fQyhbdxLu2Yr8h7IfuKXCAVZ8vKSkQIrn0uwbz9tiK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iSjkUOx13KINxgrPlU9KKYRB+AkAtNocssvEFw+ZVzTNNj/sgdOMgUQFqFkkNOZ9SUqTrYWUVC6yfMDUYnoDRFM3CTJIi9VgMUOWILiTw/9fHzBMqkP+E6qKtFhXNIIz+D6CArhHvWclIwD7aVH4cxJh7VbuO/pmev4yN9V1Z5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KlAdv2ub; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TtNdLZOY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BTAIAxI181140
	for <linux-wireless@vger.kernel.org>; Mon, 29 Dec 2025 20:21:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dpoZ5UGiip2J0KzaYSKkI3NnTZPsWCC7W/z4CEwTEwo=; b=KlAdv2ubMWttmbER
	zK1m+HlhknlB9IltkrkURme8qcJDFJ+ZfDlbtrT4bO63ZP5p0yx+Yt8/PEmB7e22
	ahTfq8OgZvlgXY/Fsb8iq2Hnn0nKA7XFrPAgv5htE3T0qjnlfrTng8IXvQR38wtG
	dyS4TuVPF7yWnkc9+GkWwkgFnvdzpeOMNt3YbmgDgTpzxZ6IDNNMTu7cVEt0ApYd
	RQLEh2PAj9p1gENTP3jl3g3yILavYaUsbAem52ycezS2xmen9DpZqC0OGQFJUvui
	8gdV093GMKBOXuEyX5EfYy6KfwRshLAHXVDpYwIjScRmISHmwSoBA6hGexuUMRA1
	OFlloA==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bbc9v2jfx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 29 Dec 2025 20:21:49 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-11ddcc9f85eso18264838c88.0
        for <linux-wireless@vger.kernel.org>; Mon, 29 Dec 2025 12:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767039708; x=1767644508; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dpoZ5UGiip2J0KzaYSKkI3NnTZPsWCC7W/z4CEwTEwo=;
        b=TtNdLZOYJIyCM3BRagsAIL65UZIsoge8QquqZm/AqvL2MGhhkIR+CYPxHn+y4F5jbD
         3rZwwQYu/xTXo10KjfjlkxyU/KE1FGwhCEdHRRniFMtP4QiGDMfVpVBtWdSKRrKD4mtZ
         BAN1itOqJgJ4UOBA5BhJIjI/LOKSv7FBorm6GIYfSsw5Tu+8272U3gfRRLDkJfTIix3E
         BKfH/JJDuPpkwT4/OFGwWzFgrMoc0oBjtY6yU1C2iuGlKc+wrFwE3mlNnzSqqnQvVdbp
         B0qoZIHVrdDAHaha2jIrdtfnobTJaEL/5ClCOCOi4ZnrfVXdOEGK92G2VDaNYESxaWQ3
         Vmdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767039708; x=1767644508;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dpoZ5UGiip2J0KzaYSKkI3NnTZPsWCC7W/z4CEwTEwo=;
        b=TK7L5AOjJuELCB8P3AWYbAsKdZVMXACH6CDpqRnD10LbM7Om+3ki96lcD9638uKsK9
         nm8uy3Y0w6W8YRMF88aBdJ6WXXVidTJbCf5EEPq1/h/bdE3icVW0c0JA2fMuy64KZ0mp
         raGOIso4w3cKxBcI2os5yw2rEl96uVWV+scFuBw9i3lCppAAosbN4gxjPH092Z1KQ9JU
         exXnAjPvRz30Bn5BvLBTTmnGFCRdxfNKbz6tGJCtGMLQJrZ1zNy0caRw8K5hBK8vPDw5
         LCIOH0y33BwIJLCmQJVC2L0WRtkWGrS7rS2v5PW9bkaxTbOuYhwNYBEM3H1Sqlk73fCW
         9rNQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+E5UfXFyYfZmBWg3KthHK0uHzlrQTxm9L/2cDkZ42w11Ayew7YXsGFQ14yuOEJ/GwO+C+NIIirT9t9hOzQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwEU/6ZO4+PHa37SiizDzHR/VtkYYB0SdT5Q/B/BNeVtMRhAyTe
	ZasOa+dDtnejXHzbBpLvIQ1iGevOkiNIVX28/+lnsZjjcgvUtfcl/c3XVmfQrbrGW6mwV5hKD8v
	M6hsex+Pk1Vj2ucTKoPdRoRWI0ljpqK3u/lJLeMjgoy6Dzt4mUm3hbQfSp7qW7kkOyHpgdQ==
X-Gm-Gg: AY/fxX7gqAjAu444Y26u84FoScxMBI5Unr3OPpQewR9JjI3+m5RbyJeLCuI/Wv9qxqQ
	bvsn4o7qMST6jEOkZm+zmu630LFXSqGuoU4fEEb3Ra5Ie13Otn9xuBN2bNPuOnG5r+BmlQqoHhC
	OFYPQkfMxtBO7dLhLEFmgnv4ksjERrhxuuDzL927s8fR6UUywt88zjoq9TzYgnhU9RCuFuIglva
	ZIqqc7FxUQpZVAPLCpe1cFJhBCfrSF3++LRAmYL4eMl07D/KX97SXtdlVn9tYjDX+6I877F5zxL
	v5aE3dMNLHhzaNcoupK+Ny4sCbxvc0VD3o59ksuKDLzUCt9bfwya/MPlx2VzTB6OxQ3Uqdga4qy
	gkZN+aYhxO3ohuKsb8nXMx0eFQgeIC6vD5XIFdAXYBPrY58kXi7JCQ1nIqO89QiY=
X-Received: by 2002:a05:7022:204:b0:11f:19f9:c5f9 with SMTP id a92af1059eb24-12171aca672mr31221583c88.12.1767039708190;
        Mon, 29 Dec 2025 12:21:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IETQHo90sIZ9Ah2oFCPURRgJ6JOFVSXKLGKjyL2O2wo5JOl3Bs3GTMtBAiIr30Ft0lRKlNsqA==
X-Received: by 2002:a05:7022:204:b0:11f:19f9:c5f9 with SMTP id a92af1059eb24-12171aca672mr31221563c88.12.1767039707617;
        Mon, 29 Dec 2025 12:21:47 -0800 (PST)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724dd7f5sm120318362c88.5.2025.12.29.12.21.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Dec 2025 12:21:47 -0800 (PST)
Message-ID: <9e6d2c54-6c63-4cb9-933b-3647c25fe72d@oss.qualcomm.com>
Date: Mon, 29 Dec 2025 13:21:45 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] bus: mhi: host: Drop the auto_queue support
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
        Johan Hovold <johan@kernel.org>, Chris Lew <quic_clew@quicinc.com>
References: <20251218-qrtr-fix-v2-0-c7499bfcfbe0@oss.qualcomm.com>
 <20251218-qrtr-fix-v2-2-c7499bfcfbe0@oss.qualcomm.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20251218-qrtr-fix-v2-2-c7499bfcfbe0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 5AWJ86Tiodvpg0P7n8V5aJ-ux5i-94wF
X-Authority-Analysis: v=2.4 cv=R/sO2NRX c=1 sm=1 tr=0 ts=6952e2dd cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=gPICEALkPRU_h5exja4A:9
 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDE4NiBTYWx0ZWRfX/x7aXlaU0Y92
 hQJnQTdwFiAP4qqF6d2ViCoeautQrtWpqu71usiM6J7udXw4/oqzlsla56C/TJFywTiljIZT2vn
 HIw9NvtdC4Mrag5ZONcT0JMWrFvU6ku+MBNaPwZC5++lMcz4cH2rPh4kRrgPVUBhO7YkVcgau7m
 PjNJuGp4yr6DQoLkuRTWqc75CAafe+PXO/cmfbOIjmj5MX5LZG2LNIhYjqUnDPvLvTRA3XFxy+B
 r+rPEHJJHuE8/fKbb5Y1ksyA15pIBPdQRi+mUzQnTQg4h89d1TtDixgDmDlCtMp0tAxbV2AGkGO
 eMjSHZHUmYD9M/DbUYVxbGpD31qfk8axpBxNt9U3ljSJ9k2bps692EiCJpjKs/oHEcZXEUEylmw
 lXKvVJlY1FiO/3mjlHw3i+NqP752OOan7CWin8vuTUD01EEZk9mYhllIrcN5dW4oscRjlM/2CH8
 V1NVqraGGbHhkYhhNEQ==
X-Proofpoint-ORIG-GUID: 5AWJ86Tiodvpg0P7n8V5aJ-ux5i-94wF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_06,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512290186

On 12/18/2025 9:51 AM, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> Now that the only user of the 'auto_queue' feature, (QRTR) has been
> converted to manage the buffers on its own, drop the code related to it.
> 
> Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>

