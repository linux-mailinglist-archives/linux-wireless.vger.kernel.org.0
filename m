Return-Path: <linux-wireless+bounces-31317-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGMnCCxCe2n6CwIAu9opvQ
	(envelope-from <linux-wireless+bounces-31317-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 12:19:08 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 91860AF8B8
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 12:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B715D303CC2C
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 11:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4EA03815D3;
	Thu, 29 Jan 2026 11:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YoNbLz6/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GTth05D9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2BC3859F4
	for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 11:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769685474; cv=none; b=cUXeIuwIv/XQfdM9LJNu8+yCk+Fh/sHxoorNzzrzXH5+UZd5HZyNpTTMu/Iae1AcOTdCSVCzySs1XkY4hp+INHVmS3SmO95hrNMHS2H5UWwroIW3IF8Bsg8FhXAvFQbo70mFYehKT8zWi2MJ9jew/pWWQZTO7370cOGlIQunoM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769685474; c=relaxed/simple;
	bh=dbHTz1D6Jlwf1wIyrQ/apXY4+TuUGkDmMmLYJHM3rQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hBOYZAHVNonBdcgPmtajY9xfTpk8eHYB1upzQqJfS0ObWCeymHcMuZarit6xt6ehzsmAt1kT1LFLYXui5esdOIwMG8n9j+tjVJIgUDmnKuxUOYDwwuqJNGfzm5VHdMNLjDw4MwOs63jLTi8W/9+xDfYsO6MZJ2YcJ3/Hf/4oCE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YoNbLz6/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GTth05D9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60TA2qI32033235
	for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 11:17:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	42D4Yqc3Zjl6wkobPB6JXQnteYWOrIpSff9Z6J5iluM=; b=YoNbLz6/fOuqh3kQ
	uw7DWabpo1ARyYCtEN7OOH7L1FjLx4SP42WgmB0FIM5js4/eHw3LSrHBiBE3UPM3
	ouVPYv6r8E1av3Npg5JikkRn5YKpyTf4/o+MW/n5co8qb4NFSOTlbV4K1KUme2tX
	SSvmXxQQLNffibRBIm3FqsLrFpZ9HhQIlcUZFh837otCakMiAKWuGb+l5x8V3nQr
	RC1+U2LMA5pQsRurkPmi47zPEgmUvPiSvifrxTkbWrulzyf/MrHQkQHo2OJghUAG
	2XenEdJBvBF/cjWAgGlQx8gzEMOUw/S83N1KV0A3fGNk21xd9T7L6pa4VxE0OY2m
	Ik5Nsg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bytqy285k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 11:17:52 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-352c7f19acaso699564a91.0
        for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 03:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769685471; x=1770290271; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=42D4Yqc3Zjl6wkobPB6JXQnteYWOrIpSff9Z6J5iluM=;
        b=GTth05D91KblgAsNEjTj5tFzn/WdET8TGXFxcijuubWbL9JCM1dAjZM7gnp4X+qzel
         34Zw6B/Zr50qsVqLj5q7PdHzCa3X03HcP4LgCQzIOVzgUss1H6XSd230uuEO3i+4Q22G
         IwTc5H2l97MV+KfRPOjjZ4uZ+RmK9zDNpIGK9Htbq/Hb8YvXYbYqrtGEEOSc99CnfMVk
         FNBAAls18Qqq4M+9iuglmhUpfconSnl3TlMpflaqC8zTSQcAi6W61t8lvCWTIW5G7T5L
         6gzsIlSJoEuwFlU8qIhraMaBsnpBY5SyXhrgJc948KnK6fTPHjNj0oNuoUSYvqOtKi9/
         jbSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769685471; x=1770290271;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=42D4Yqc3Zjl6wkobPB6JXQnteYWOrIpSff9Z6J5iluM=;
        b=WQrG5eSzIQHv1Jd3hpPGGK0jlBKB1zwUslpa5huU0DnPb/1hIMWou7T7JLRRmQbNxK
         aqdQQ3gaTsA2DV4vDtKfdCDYXatxh5Sme4Dtr+RF28Nvk2I2YwqXaq8ZB04asfeKRAZ4
         EE8mBG1wQwPODjOD5DXQ3DmJQf5AQKM4psqvPD4uVPWC938KZuuwtaEN2Z2Ub31nUNlW
         8+sWRN2CW5GLi9rVlglsNCSFEraZlf0eoJ8aOXPyS4dsmBJXHWHvHMyAur/dirYW/y1J
         +IE8T5Wz/UOz6jxYwwxEyU3N0OeNCCsyxESnV9jBuLQ5t45sedRWHCZ5EWXUf2QfwoHt
         CLIg==
X-Forwarded-Encrypted: i=1; AJvYcCVk3E8gOei0Fe0wCbbeaVC05IM8qgf9uGpJh35HHliPbhM3IksSZ7EbhMeZxQLVcz69VAzv16eMueNpdfJy1g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxL9kL0dDSbmGrOgeVF3saqsJecBPhIL1l4gn8eJ5TNFoakAX+p
	UjUez+f6GqhwAfE6JwpU23sf5+GhWz+DAH0PjhOe1d5Db1HMJrtigNrTXNvfY+THJVP6GG029WO
	L3U/y24NdALlpUrhs2NRdYajrz1orOHaPC0fnkVgb1dXw0J6PU56c3faHjrlWZJggLTN7hg==
X-Gm-Gg: AZuq6aK8fQApRO/j9vtUvV298Cg1TnVZF56eqK/9COo9PMDs2lmWtd9k/ffJ+6/XcxS
	ZiwLNJdJJX0DeD9R5q1d8QcFm+WuBHnRpuA8h/Zk4S/oTI66UnLUffk3Ah2Sv6CG038RcxVuZtG
	1rtiqVPwNx6dwB09R9HA9CRfXuD1pA0knPL3Jz8TI9Q8h/Ul8A8vGtm76RFw1qmTWMYPUZ5cvGn
	5c+fwbvjvdcGnTtkONchmJQ9haZkZCRadCYNcfAbm4aXdltjZ/u/Og+8cE6O12hm8bqKcsa97v6
	HiI6WBa8jC7Jezy2BJmcafReZIzcq/lbObVVt6zyoaO+rBJTAYHmIuFyToNjXIaECVeDNhzLPhe
	v2kMnjDWs059tLD8r2RjBLJtKcrnfAixXoISzvwonWtmHt4Yi1JVC5L8=
X-Received: by 2002:a17:90b:2d83:b0:34a:a1c1:90a0 with SMTP id 98e67ed59e1d1-353fed87a85mr6962679a91.28.1769685471357;
        Thu, 29 Jan 2026 03:17:51 -0800 (PST)
X-Received: by 2002:a17:90b:2d83:b0:34a:a1c1:90a0 with SMTP id 98e67ed59e1d1-353fed87a85mr6962659a91.28.1769685470908;
        Thu, 29 Jan 2026 03:17:50 -0800 (PST)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353f6103e9fsm7934690a91.2.2026.01.29.03.17.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 03:17:50 -0800 (PST)
Message-ID: <f30be082-036b-4554-80b3-da1dd19d8caa@oss.qualcomm.com>
Date: Thu, 29 Jan 2026 16:47:45 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] ath11k: support IPQ9574
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, jjohnson@kernel.org,
        ath11k@lists.infradead.org
Cc: johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260109044457.3074510-1-mr.nuke.me@gmail.com>
Content-Language: en-US
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20260109044457.3074510-1-mr.nuke.me@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDA3NiBTYWx0ZWRfX1T81yGYXoF3W
 mZfTcWQb/EWReU0g1JKyLvWc24RZ632xUPrMdYi1dWkRe9yHtjryltu6vAIYyTg/tz7Bt0X8huN
 saVzvm5A8MVu4gI05eiCpELtfHPoLHKJIcqapW8+Q3dkOTUF2LJqAmMT6K8q4leoGXM8OBmG2Qd
 OBTWc1HWs8t0gA4/2+U1SPyaFsuSz1eaXTwzAVat+mMdWIG5Lvgo1kOvsSq696PaYHw+qIRrBvs
 rOinSzUGyfDIDis1441NIaoPfpYnq2TOF7yMpgYwPqFC3mlf+Xp6Rl1F8a+9p/LGCfBYsLAAKk7
 ryZYkZy3s8jiYUnWPFBbDbpyuJgsO4w/i4UrNHVzh//UovFhJY2kffs/gnhdXYvlS9lih/OLri8
 45WVmWBY/R8CtsxtzEaKrbOUn1UyNRNtT8tde6faamNYpfOV/yGrTylsgT9HD2qhMTY2KWCZTQU
 2kdOFuPxvAh0hRzyTRA==
X-Authority-Analysis: v=2.4 cv=Je2xbEKV c=1 sm=1 tr=0 ts=697b41e0 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VFJI8iCbsL4109xkWtAA:9 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10 a=zZCYzV9kfG8A:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: zhfMrKsaXEeq-M9tzyaPQHx2R5IZ3dr5
X-Proofpoint-GUID: zhfMrKsaXEeq-M9tzyaPQHx2R5IZ3dr5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601290076
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-31317-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vasanthakumar.thiagarajan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 91860AF8B8
X-Rspamd-Action: no action



On 1/9/2026 10:14 AM, Alexandru Gagniuc wrote:
> This is my attempt to make ath11k work on IPQ9574. IPQ9574 is intended
> for wifi-7 devices, so it seems the exception rather than the rule to
> pair it with a wifi-6 chip. That's exactly what my Archer BE550 does.
> 
> This consists of a wifi-6 (QCN5024) chip connected via PCIe to the
> SoC, but exposed to the OS via AHB.

Pls note that IPQ9574 has internal wifi-6 which is connected AHB
not PCIe. Also, host driver does not really need to worry about QCN5024
(that is not connected over PCIe either anyway). You may also want to change
the commit message of "[PATCH v2 2/2] wifi: ath11k: support ipq9574"
accordingly.

Vasanth

