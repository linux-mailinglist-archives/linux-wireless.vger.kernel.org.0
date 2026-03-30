Return-Path: <linux-wireless+bounces-34191-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKdAIEnRymmsAQYAu9opvQ
	(envelope-from <linux-wireless+bounces-34191-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 21:38:49 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E2295360828
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 21:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1B94A30309BE
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 19:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CBF39B48D;
	Mon, 30 Mar 2026 19:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I9t9xDsz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="B8fQIOEp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9625939A05F
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 19:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774899505; cv=none; b=gs1gnqbTTIrq0g4pEAC5GnFARZBPDTltQlvBLCYYLxwZxiyGgfdAXSwHGJCiLldNLD3HG5Kw8pCgoI7kMQElhKxggnLfbtPmw3lcDyU5l/P7Qwb4kbydx7FemMfOXSCyCkEiF9NRTco6vp0vKS34sAwcqhXxkK5/xGLYb0/+77g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774899505; c=relaxed/simple;
	bh=0HnOVNODhRmgFiMxGT5XLFjM17gPwfkzyABAnDASf4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d2aT4PpkpZ5bGacm0RS6NeKsHh5JCB4hhIqedTIrtOUfkYmgTj5e/olKqHpnWGf2tH47x4bFxzXNU/q7dGltSLW3Tr2juryPUx859sSRQ7gP7xB1YNAx2mXGRukCgSeMFI0arDP4dJE2LEFsAaXOwnUpt5UOXZ5htANa/WwDRrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I9t9xDsz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=B8fQIOEp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62UE4YCo2458298
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 19:38:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uB7eB9kR1LYcji31gD2yBzuADC6j70gibl6FfhtVnUA=; b=I9t9xDszy7GuTtL7
	Ldp7s5z4wVrA+k4I01HlsJhunPp+ttN1FWkiy+iL+bGgJTVlN5K0X8zSZaDmoD8i
	VPyioQO1GeNcy0/HW6jKZ5GXD7enRk9GBJb8hUqvF6tV5S2TQS1pue2YAnQvdG5t
	reYtZJsJBkNe6wWZRiZka4pS2SxX5JpomTvPN8ZvCtAw6hDxDKdLHx6InYLJrqI0
	oYEIKmI4BP3+8HoA0or84O824venxans32lPYjrPdjGyYK+QrY5WUVQ/aRjbASnC
	EdMT6hh7M0q83jVUWW1uVZrKwL/xLlVMMB7sSc5cPRL6TDT4xA6KBU+SgG52eLeq
	5NihZw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7nnmtrm2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 19:38:23 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2c16233ee11so4974452eec.1
        for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 12:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774899503; x=1775504303; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uB7eB9kR1LYcji31gD2yBzuADC6j70gibl6FfhtVnUA=;
        b=B8fQIOEprDuMXF79IjZmm4wneGgdMOfCdCOJLQgCFBxKlQoQoOZSzBlPHR6tgJ91S7
         VETJqsCfH+/ezTH557E0aYrYav9sqzGvGiXmYavgeksEoOU6x/Chdtm1KvGvJOghXFl1
         LxQbv/r/3c2kvdTBG5glevXEHKEms413QkfFlbayQDu4PLFdWCVelfUipelJdG9BLboF
         MIp35FH1P2cvweVvIK6E1iHVPzHHVgiV+2ZG41tKWBcKNCxQLbnXf/yd5UKWFdWjXECA
         /pMgswAw/1U3nngozif6KXXUTT5zYH41Yb5+fXoD4vMmoKWVy6dFq8PxjSpa7b2UVRfu
         3jWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774899503; x=1775504303;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uB7eB9kR1LYcji31gD2yBzuADC6j70gibl6FfhtVnUA=;
        b=mlXwXiIoUntn8QSCttaM0GwAeWgk2fnSjKhwT10OHTzGvSbatIra1ApUb1rJGpm6t0
         ohTKgo5lCWYNeoxvSqpLh752Zvr/IzXZZngUkQ7h8KB/7dSY/sWaIAeJM9Z9pf/VeLxB
         Lzr3EgLuPv4/zbHzcNYrQbIHFSRIX0qhWoJpPSiy3FYZwAFVgcxQVSpmy5qAQc2Sc+6F
         sL4NgOk6tgphuswUkE5bTaZybgFofXsY9dzL5VcXxWEiWj56BHa1kTpr42gABSASkrRP
         JfK5Osm/a2gAB9z3qA0tiTdHHfZMCyxjNz3cpSeO3jyPx7Trzo1/EaUaLfqVGM/2id+M
         UYwQ==
X-Gm-Message-State: AOJu0YzTo7nu92nPRswrcvMpUIA5KbbqOFzHnj3v6W7+BKgt7cSmU65S
	aSVrKreB7DNQGM7wVZ7LXMvY1YU75mzIJX1XFsidIGxfzsshQk7PaRDcRqmsXWla0Ltw4TkTD1T
	J5P42ovdWDYPuernL9gbMoHvF8Qo3skZZkFLCO9Dz0PHn1yEj6IvqVvkQM47s4/fMV0FMHg==
X-Gm-Gg: ATEYQzy+Z4lDrBl7pSvVYz87UQvIm0m+/WRWSyQkhQOBf6/TbJYvLRjzP1cgurX9HUF
	wylElI55ja7yUaoB2hMtNOVhmwLS4HwcyT1is8prMz+XnVeefmI9NYreGvhYn6ya5Pc855jCtRE
	hjALQeoq+S+5fITyvuZrY2qyORzHP8H3o+LUaL+8kN9eQepJtyvgBWGFfW8EGMl521cNv15cn6o
	HowBMbWbGwsu4doCNhLdLbY/ZL2GFGS8C17dL+bOkqZ1FJrWHKx1OLOTBGcEmS4lFjB01ilernk
	uNkQNglcW2GMlHct2IcxZIiiJZJlqa4Ug5kkFtEstCFAjxIPIXb9Xrm6D3iYV/bM1b28skVe1Ev
	P5d7zj4XAH5iuR3vmpnJGi/12nbc6DdkZYD2spjJ779s5Lodx2ctEW/xKYnGBoFVDaCFJ46ZrZx
	QDey8YoaeBKH3YtQ==
X-Received: by 2002:a05:693c:3008:b0:2c1:6cfd:73d4 with SMTP id 5a478bee46e88-2c185e8e172mr6729077eec.23.1774899503102;
        Mon, 30 Mar 2026 12:38:23 -0700 (PDT)
X-Received: by 2002:a05:693c:3008:b0:2c1:6cfd:73d4 with SMTP id 5a478bee46e88-2c185e8e172mr6729061eec.23.1774899502528;
        Mon, 30 Mar 2026 12:38:22 -0700 (PDT)
Received: from [192.168.1.41] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c747e410sm7978573eec.25.2026.03.30.12.38.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 12:38:22 -0700 (PDT)
Message-ID: <a124d5d0-ef46-448b-b226-8642da61e0cd@oss.qualcomm.com>
Date: Mon, 30 Mar 2026 12:38:21 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v5] wifi: ath12k: avoid dynamic alloc when
 parsing wmi tb
To: Nicolas Escande <nico.escande@gmail.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260330102434.13136-1-nico.escande@gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260330102434.13136-1-nico.escande@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDE2NCBTYWx0ZWRfX2klCqzimUaQE
 EZX60Bx5zAydK4wpdUdphBmFoieJnWo5gXKQqQ1SoAOgI+QVKKcfn5fuhNtRtD9i2Hlfbj7QoR0
 1zVoiWHGISt/lsrZFxTMJFn9j5h3AXljEkovGKh47UqJV1PLJc/qLTE24dvAHK+q6JXNpsyKnI+
 WyRMKDHZbMheBApPCvIJ7Yehcx9Z13BSHw46Fab1zeXgM3CCHybEkxMGgS22S7zbnWqNWz2139F
 DCTSTZf/tKZuu+50FPXeVUtUFORHGE30d7+8EXUCushcHzOsnnl26PX+14MkG/bnB4S46osr/XN
 NmvVIDULpmMzMpiFgxQPJEUX+1GFgwU5bRe+UyPHOWuUih/iKOd2umfi+WjyDPUoy+qswRrz7lH
 GYP3PKPFqnsObklhf82ns5X94HI+wHMa9RI3SgI1vnF7LLVZM7sj1n7vRMjgFxQvKHVCI8YS7dE
 LFS113xTkEAzzY1JC4Q==
X-Authority-Analysis: v=2.4 cv=M4FA6iws c=1 sm=1 tr=0 ts=69cad12f cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=3dl2j7VrEyBlj6byImkA:9 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: i9N1yuMvJEILQaDTqspc1HJVBavZjooE
X-Proofpoint-ORIG-GUID: i9N1yuMvJEILQaDTqspc1HJVBavZjooE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-30_01,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0 malwarescore=0
 adultscore=0 impostorscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300164
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34191-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.infradead.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E2295360828
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/30/2026 3:24 AM, Nicolas Escande wrote:
> diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
> index c31c47fb5a73..76060d448920 100644
> --- a/drivers/net/wireless/ath/ath12k/core.c
> +++ b/drivers/net/wireless/ath/ath12k/core.c
> @@ -2258,6 +2258,7 @@ void ath12k_core_free(struct ath12k_base *ab)
>  	timer_delete_sync(&ab->rx_replenish_retry);
>  	destroy_workqueue(ab->workqueue_aux);
>  	destroy_workqueue(ab->workqueue);
> +	ath12k_wmi_free();

nit:
the order of init is ab, wq, wq_aux, wmi
the order of free should be reversed: wmi, wq_aux, wq, ab
which matches the init error path

>  	kfree(ab);
>  }
>  

other than that, this looks good to me

