Return-Path: <linux-wireless+bounces-32357-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOvVA20SpmnlJgAAu9opvQ
	(envelope-from <linux-wireless+bounces-32357-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Mar 2026 23:42:53 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 705111E5DB7
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Mar 2026 23:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FC2C35823FF
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Mar 2026 21:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6075038D003;
	Mon,  2 Mar 2026 21:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d5EcI/BT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UMhbC/b/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F101A6804
	for <linux-wireless@vger.kernel.org>; Mon,  2 Mar 2026 21:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772485656; cv=none; b=B5ppItNloCsOWzteMWKovy88VhsJ5yXWfYZ3rIFIVUDx1eagI4tglZOLiKczuB0bBEgJOG+kRaL0k0HddDI9bG8WxdIe7y6zhh7hNIexrKJ46QClMalSUOP3AVaPP0Jl3Wl6h45UtF7YqF/8tzfdZybv6yH/44iQihtOKrewPvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772485656; c=relaxed/simple;
	bh=m1lhH0Mp/H6A3WsuB5Z10uTPvOT18mKoSJAgm/WgWs0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KKdfsn7tYuv/Q5QYLzsQfb9c7/UgxmZ9EGuxbFHuJGepcLNMCwU+OIQSkgng3k+3zWOVBVbD7zXW5FsQIYg7yoIE9D0SmflkZSrMKoAKkAN+ZsX1w90ngnSEuC1cOz3of7Xf0vp4r1s7hN5pBtp4oadcmbs1rZGThPnJEnYEUH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d5EcI/BT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UMhbC/b/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622KosgY1675700
	for <linux-wireless@vger.kernel.org>; Mon, 2 Mar 2026 21:07:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	C5ZXj5N9aNqZSxL/OBjXVW7EXYIkiLOUpceEWatfCSU=; b=d5EcI/BT/ugSeRrQ
	2XXHqptkmBktwhuoxBS25du/EJTj1FqZjvbOSZZhYkJBiQVq37e3BOh24TYXq8tJ
	WNSQOlkpmAHd0xkqoOR3ycTXflREKHT60/fKzucRdETPhS9xLAYHuvEYhlGPB944
	iB8GGuniCW/11FMUNc2OW7ZnbR/xkL+fuWGIEN51osQ0IwZ3z2N63Cr3qEwpcdDv
	WASVlQK0ON4ikp7a97lc9iRvnDgE7/LocpbAhY4OKCYCAafu1upiC00ps/bAXy6Y
	TU0PzAcImodyxlh6p9n4ZhNwhFq4hNyo0eXJRcJrn+9BxAwA4DcluZgY9754s0ti
	/vIjyQ==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cnhxs81dd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 02 Mar 2026 21:07:34 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7d18e95c658so35203487a34.2
        for <linux-wireless@vger.kernel.org>; Mon, 02 Mar 2026 13:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772485654; x=1773090454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C5ZXj5N9aNqZSxL/OBjXVW7EXYIkiLOUpceEWatfCSU=;
        b=UMhbC/b/Pfxwd4qPV4B/yb9BLi5T1JN8G5WVm4HxW2LT/7jlBmBW+cqjCOZED3P5fL
         EC1lvEk2cx3L4xfu/hJfyLH4vHnfpTBR6DqcaEJFP+Jkly+5YL56eI1IJXaDNgvZIS+u
         iUiXuDUAWsUH/PAUUzrrL4vIeTlaAqqQtkosBYUxMSZptcpHf35RfPppXJSLlHmNXgMC
         DLZJzK+jGDnegNulURvSFeocUWVP6S21hhtc+wF9DRdjxCQSjsfrzDuvWuBRzdvBxNiC
         hCp++0xCle49c6XptlXZ47q0FjFbE4i2nxQG+ZGmnvRnNa7pfASjdFBaB5BdO6QM8uJa
         Le7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772485654; x=1773090454;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C5ZXj5N9aNqZSxL/OBjXVW7EXYIkiLOUpceEWatfCSU=;
        b=fnaWGBNE4jblLWWSDk5PkSFRsMvUIrRSRpojpb/7Ka3CNUZddjJf/J6N8ld/lfn7QF
         uv6x3fftBq74lugwt/5bil05DHcFr4b/LP8R0apFDTtr1p8c4MMAt1kYwyzUe5tCUS+f
         cl+PQcKz3VlFE2OEztriyzoVOssnbxTKh3P3RtI9xPnXkXS7Odlfuk6YhCKFeulg1hol
         YlcuB+E03+qNzRH3e4qayVB3QEIGCjHm/CLU6OfbWmrpRx/n9ZLcKG9L5SxPsi3b4nJs
         IHj1MUAet1CiCfTDjKzV9MnHnRD7AMNhT1Yww1V6kB7qqir1r7MD8dWrH3Rs4PJgZmwV
         VWaw==
X-Forwarded-Encrypted: i=1; AJvYcCVBosPUDlioKj/tjrqM3al1ZvQFV+kpkzNNULoxpDbVss4ysbRb0yyS6cUN/DWmwPlcrd+5RwMiAeZlvITMPw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3MnaiAPpkUV7llvAfR8oMGDEXThfW1bvDCKNdeNTi226kq/oy
	BKLvxEJA3rRNhDmEG+mXm0cK1KIrUV/0wU8YoLB4fcvIPe8+vfwqsCLvJ9zEQrqGiue09UTlY07
	+78grrwN/n3wBh2brLMtx6ohjq0Nlktc5L15voE5ZOerCEkajG1bKBCnZYSO5CH+6x2N/PA==
X-Gm-Gg: ATEYQzybfAaad9rv46CPKjI00W3SpCNasBmU4LvadMoDuDRcdXyYceNDG8ocLAWNAXx
	tVFAcJHcntuNmCMom7RRRXEiZ67beGa6i/S/VIS0yyr2TKGHW0Qkn10XXxbQjTDaNKafHyjSj43
	gwmlEnjk+RWePDhAAXUvAzui5HVvHtIB0zw/pjIOMTE6ujiQLtygn7XDoWfx8HY+BfUImmFlLF7
	sdGCPR5m3Wfgjcifc3laDPRMMKnc3Y6YuPc0oJrOwFzuZgZJVq2nrBnZv1OFbHcmAzmkA5m4Xnj
	WNCPj9G0Z4a2wtC1xvk1r0I8u3zswMtV2NuK64JsrryXzvb2LNEy7FRQNc/smsPKsC7LMMirtfa
	R7NeYsNj+ZQjhAsHD8xVUQ6lzOZeRhzxi5I4Zrlk5+psN2DyXdiCwMNOc8mrAX8Hy3KA6Hcpprm
	Ew
X-Received: by 2002:a05:6830:3786:b0:7cf:e32f:de72 with SMTP id 46e09a7af769-7d591b3e1demr9634970a34.6.1772485653686;
        Mon, 02 Mar 2026 13:07:33 -0800 (PST)
X-Received: by 2002:a05:6830:3786:b0:7cf:e32f:de72 with SMTP id 46e09a7af769-7d591b3e1demr9634957a34.6.1772485653365;
        Mon, 02 Mar 2026 13:07:33 -0800 (PST)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d5998bc31asm7449967a34.23.2026.03.02.13.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 13:07:32 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260212-ath11k-silence-probe-deferr-v1-1-b8a49bb3c332@oss.qualcomm.com>
References: <20260212-ath11k-silence-probe-deferr-v1-1-b8a49bb3c332@oss.qualcomm.com>
Subject: Re: [PATCH] wifi: ath11k: Silence remoteproc probe deferral prints
Message-Id: <177248565242.1002715.10369057286186394328.b4-ty@oss.qualcomm.com>
Date: Mon, 02 Mar 2026 13:07:32 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: J8I6VPPXcHOtHwhLfyqbX3Dpfr_0uEEr
X-Authority-Analysis: v=2.4 cv=dfmNHHXe c=1 sm=1 tr=0 ts=69a5fc16 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=6yIOY4caXks06VLbqCEA:9 a=QEXdDO2ut3YA:10
 a=EXS-LbY8YePsIyqnH6vw:22
X-Proofpoint-GUID: J8I6VPPXcHOtHwhLfyqbX3Dpfr_0uEEr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDE2MCBTYWx0ZWRfX9hq0utjwsKER
 NjT1aTIm/Iou13/j/cDwF0HPzq2ZUgSXZ5kJ58JmRum9vyxhoj58nCvGutASrEEPzY1zC5Xz9G/
 viTpr9kucYUEwbc/tC1Md0ozNqkqcesjcHq3nlRq13pHiIvm8jI6PL7EMdtJrIe7jXUFVLgijX4
 QEE/tLwgMieD+BoQMpIYWa7A2ouCKN0LYS1T0Ji8gUWHoBKnYBau3k1BSdTd2r4837IYuY+AySE
 uQrSm/gC/lJGB9jQypHBwztYHzrpj7AUMi8HvpYqEOj1kS48Xz1Xd6ae2HRz/37Dzs8jqn8RYov
 U0RtP9i3509OY5TYoB+wHRP39efE5Ati8N7LNgJvwgOoUYYlvmvIH7/mZI/wDSiS6EL+aoXLie8
 KpY8BKoCuLPYyL2a75QMHj7iwj2qTetdkXC1OfJl9KYR/8B8KXN8TQaHMm2wpbgOrua0+IGkD+K
 /F/fJPpAra3UmvCQJDA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 impostorscore=0 phishscore=0 clxscore=1015
 spamscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020160
X-Rspamd-Queue-Id: 705111E5DB7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-32357-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action


On Thu, 12 Feb 2026 08:52:52 -0600, Bjorn Andersson wrote:
> Upon failing to resolve the remoteproc phandle one ath11k_dbg() and one
> ath11k_err() is used to tell the user about the (presumably) temporary
> failure.
> 
> Reduce the log spam by removing the duplicate print and switching to
> dev_err_probe(), in line with how ath12k handles this error.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath11k: Silence remoteproc probe deferral prints
      commit: 6508c9752451a7e5e44a325e8563897a67f5344b

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


