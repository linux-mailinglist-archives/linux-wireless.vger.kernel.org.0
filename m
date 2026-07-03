Return-Path: <linux-wireless+bounces-38563-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9S14J/5eR2q+XAAAu9opvQ
	(envelope-from <linux-wireless+bounces-38563-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 09:04:30 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B276FF5AE
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 09:04:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=WWd0i0kc;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=HSl1rmDa;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38563-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38563-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A174304A644
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2026 07:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E469B38398D;
	Fri,  3 Jul 2026 07:03:33 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9711435E94E
	for <linux-wireless@vger.kernel.org>; Fri,  3 Jul 2026 07:03:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783062213; cv=none; b=VbDIkQvf4SxAXTzdOv7Id0nZtPxg6tKJjftLDKMAeqAJUczOB7dkWbSyo4Ojk7T3spt8E2cVpmEbtxDR0lFbWn9Gb/+J+uQ9vCfWpmZ5jsvkobclvU0JJi72cjUSJiyQSCKhcHO1AGFFD3gKMJ1QoH7nrjZDh3xFEB9beqXnmRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783062213; c=relaxed/simple;
	bh=RPtED5zfqWi/w9WwjIlrZ18aD5j4qypewMoT7I4C6+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qu09/4Y7wPNtK7jcCNcHPi4XtgcK48h/yXoUD/uggj3ZiS9qnxfRpTciXE3Z6Sjm25Lyvgyt+hZGOGL/+pZO7uM6BQ0zHdAf5Ocb0E+nK8fEwlmtz87pCPVFX+7DrN0Vo0EtIzcyTsBQHqTLMgQrkvpGO12VWiY28rdsyGSdJx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WWd0i0kc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HSl1rmDa; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6635s3rt3126906
	for <linux-wireless@vger.kernel.org>; Fri, 3 Jul 2026 07:03:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wkfKJwLnKe7l6BvxWFlusvv1HVqjZu8lHqA9bY//AHo=; b=WWd0i0kcRIEyUsuH
	fPgilMcZpwwOfIGNiDt87MQFpBKCEpo/lImkJM4J6gZPt0GlxSrVCrF7FkWnW9Pa
	Wt1FYhYNi2UklCr/Y8DFS6gXyG0tvKes9JX3ATrjOpsD+81N7YiRey8HokFutCfG
	yVMkaw3qgdx0KSS2sIZzyFHmD7TqPYhS1WNUpn5QOlEAu9GO5lj1AgrqL0KXOhRe
	r2y6YBnLKivfsb3D6qFac3xvH882B0oAyVmJDEueMWS5fyGOWl4XQ5xpaPlsRuBo
	jdhOm20hv4YUm2wLOYXbhWd4r3mzjSpOdgLBaBlYEcYaHXW/QewYS0yZBiry19RS
	6/8KHQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5tpnk7cp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 03 Jul 2026 07:03:31 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c88aab7c1fcso563242a12.3
        for <linux-wireless@vger.kernel.org>; Fri, 03 Jul 2026 00:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783062210; x=1783667010; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wkfKJwLnKe7l6BvxWFlusvv1HVqjZu8lHqA9bY//AHo=;
        b=HSl1rmDal/pe950bxznrQS19qbzu9n8Wf4H0pCCR7gL4HJxpUNeWGzLmQiSQPX/bTU
         PWK9P3ARle4IkCl8S3FcMdzS6mRU6THKgxJJkm7fAAjEo7udhIHlb38eLkr1JCXGuZQr
         Aeg7Y4iw6ORPcNbKeqJpvrqUuANufuPoMmGoQ0jp+x57X6B3W5dHEEfmQy+3OE8pN4qw
         NAMuoBeKJT7AsWtXpZ6ymzJxJkbiFwjJuOg6e4r4edW+1LZUFKOVvW0yUMBHCETxHosA
         C65y2CHuvnlJ8lgjkGGItRC2qKpMb0tzv7JZSl+vQ4JkvWSmhmssSshIvuqxer2E09Qy
         R4mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783062210; x=1783667010;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wkfKJwLnKe7l6BvxWFlusvv1HVqjZu8lHqA9bY//AHo=;
        b=dry++926fjRyiQbA333ix2t0XF/GHZPYmnk+S+Vw053QUjm350JJF1L8nsTCwvPJ2S
         hEuMBxFkDwcjMH1ORYUc0G/fYJVt6qN+9ZTque/hC3iSWErAjpfUJAHAmyiIOIvjBoTX
         5wtogmLrK28SfLi4l2W+9MQCSUMZ0b8eJT28uj5FNDtmmZuu/7KWMtF7BGsNbAKsApRH
         q7EzoyT5hcmxaWOyt+dKVRXapSoUXd4KsQbgSeY+YM9alkSlOBGOF4WwmW9DmY+a95Oa
         /LSKmW0M3R5ZaLX0aeAGkpANZd3ErL5hzRoCtzArfsua8IQ9F6u5xzaurTppJKP4pu44
         +1MQ==
X-Gm-Message-State: AOJu0YzRL8uX45OaCK09Wvutm5PZD9gt7fqlIwy0AoygqPLxHPWaoGOQ
	H5aTVHzpOezHG+CQa7pME5oMSSfukH94Ct4wToZbvQyNpP7soNu9iBhFdnCWuvmBnxOZPPNijC1
	+Qav+3VsFH3cPYblrSsdQck3RsTwwGhV6BWljo+9iAcSgH3Goa/s4WxuLdrwQKIFrmg+iNw==
X-Gm-Gg: AfdE7cklF8+HYaG/7bjkJSI7NUTTkkq74oWfvpn0w5gpvj1cxvATAlLFLctF294jzRl
	kt3V7JyMsWylSkj2YlZMG2WXVRF9X0pAjeRgWi1hpgo+pj8TcaaMs1iUl4vZFnCz6rxRAwX458t
	n9NTD4X565qAQi5/JzwY0KAsJKIymkGUqdWlD3w95gf6HjGHzSOzBSWwPn+dmz63/Uq2/FPZfQn
	4TYq9E046lyg1Hjz/VkuAB9pvR7MVqzf/EuFD4m5EHklfSbXQgyDV6Ee9Sx+5/WkaDntKWcmxfk
	jpavk/cwAV7zbNbYWsWyJkWI3Xc8qh9aoXQcGo3Ln1cMZWuGAd+lGRLGUgKUw39X70GbNdvXFW/
	Q4rOq1M0iPVT/4fdHpXZ/c0S+Pnzj6q73CnxXH8Z2hzRLruwUwlg/KfaTXAWCOsYYD1Ho/Xnt0D
	zNrp14juG3
X-Received: by 2002:a05:6a21:4688:b0:3b4:7eb0:47a1 with SMTP id adf61e73a8af0-3bfed2721b3mr12363081637.19.1783062210541;
        Fri, 03 Jul 2026 00:03:30 -0700 (PDT)
X-Received: by 2002:a05:6a21:4688:b0:3b4:7eb0:47a1 with SMTP id adf61e73a8af0-3bfed2721b3mr12363045637.19.1783062210031;
        Fri, 03 Jul 2026 00:03:30 -0700 (PDT)
Received: from [10.133.33.211] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9e8eb0ef50sm2384087a12.6.2026.07.03.00.03.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2026 00:03:29 -0700 (PDT)
Message-ID: <454222c5-53e1-4be7-b925-8a9c2bd04fb3@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 15:03:25 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] wifi: ath12k: Flush the posted write after writing to
 PCIE_SOC_GLOBAL_RESET
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        ath11k@lists.infradead.org, linux-kernel@vger.kernel.org,
        mani@kernel.org, Alex Williamson <alex@shazbot.org>
References: <20260623141649.41087-1-manivannan.sadhasivam@oss.qualcomm.com>
 <20260623141649.41087-2-manivannan.sadhasivam@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260623141649.41087-2-manivannan.sadhasivam@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: s0NkAKx2iDGcy71jQck6u-rQY86Zc8xN
X-Proofpoint-ORIG-GUID: s0NkAKx2iDGcy71jQck6u-rQY86Zc8xN
X-Authority-Analysis: v=2.4 cv=UMft2ify c=1 sm=1 tr=0 ts=6a475ec3 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=r1p2_3pzAAAA:8 a=EUspDBNiAAAA:8 a=fjTVS2QutaehiSyZ5pEA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA2NSBTYWx0ZWRfX2reoFKmhkyPh
 ZdIlvWLWdf8BKF65G/+UlnUhi5pPxDg9waGNdg5+9LzfugT9w6/i/5HR/cz0bTtioSkI/q7v1EI
 WFft8zVV+p6HLu++98yW+sBcCv6wYdk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA2NSBTYWx0ZWRfX9edsPuRJGSvO
 xRXy5tVbgBoMkkDjYgUWnrtQklwnj4PrDB+HbfzFWKRMY4vYpyP1Nk46ZTi7yDtop/c7dbOcSBw
 sqhi/YB/ga7Eh+D4WGhYjRHSWJQInp8BJHTHctmYHX/yHmB4NtsoVLp/bdoVYk06tHFWoksmk7H
 71j5TTkIPojt6RKuFltx+6W3vv9VV5UR7ZA+zTXaY+p3nKFtweADByuWDfH53GZs99Ek0GbP/B/
 PCE7aDclwKiPyp40zac212F/3F5EmbfmDWt2uv75Yx7w1r69Xsv7oJpmPz8ZYJIhhj/d+k2wpQC
 M/lIFFmaBtvKekrFfAJyoA3oD0Tl12VsMSNlW7NMIAi9MlH1bT2edudgpAhl0ppl8GWnDwmJRHt
 OK4UTi2rFVAMapQk2x2psxjQPpVmEnDVk+jwcViarJvXsHgdkR+7Lkxg5smEkH03Tg1wd6jf2k7
 q5x+tyYNCnnov7SrSNQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030065
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38563-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:manivannan.sadhasivam@oss.qualcomm.com,m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:ath11k@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:mani@kernel.org,m:alex@shazbot.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,shazbot.org:email,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:email,qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F0B276FF5AE



On 6/23/2026 10:16 PM, Manivannan Sadhasivam wrote:
> ath12k_pci_soc_global_reset() tries to reset the device by writing to the
> PCIE_SOC_GLOBAL_RESET register. But it doesn't do a read-back to ensure
> that the write gets flushed to the device before the delay.
> 
> This may lead to the delay on the host to be insufficient, if the posted
> write doesn't reach the device before the delay.
> 
> So add a read-back after writing to the PCIE_SOC_GLOBAL_RESET register and
> before the delay.
> 
> Compile tested only.
> 
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> Reported-by: Alex Williamson <alex@shazbot.org>
> Closes: https://lore.kernel.org/linux-pci/20260622160822.09350246@shazbot.org
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

