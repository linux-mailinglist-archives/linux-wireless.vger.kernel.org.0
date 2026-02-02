Return-Path: <linux-wireless+bounces-31462-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDfdGWi9gGl3AgMAu9opvQ
	(envelope-from <linux-wireless+bounces-31462-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 16:06:16 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5B1CDDE0
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 16:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 69AF1306496C
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Feb 2026 14:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB44374758;
	Mon,  2 Feb 2026 14:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AMR2GOgu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HXNdlbSB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE37376BF7
	for <linux-wireless@vger.kernel.org>; Mon,  2 Feb 2026 14:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770044222; cv=none; b=i5CPRnmXv3fN7g/SbcyFT3oWFG9uFgPLnethrPuWy+ABrTZplKMSmObe9Hhr1vRxsA4fsu4v8//zbRioKjQzoRnQGKuKeLC4nGLzz0GWJ52IY0PF2kEVJOhlwYUGI5w+MvXUe56IX0S78j9h7ZirWRPGExjE5xEwTp3nQIsYpvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770044222; c=relaxed/simple;
	bh=eoMnNiRQlHPy/HAZwAnS7ON91dBARZx0qiRmBO50GNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nxgeY6SnUoB4JGwOO5RLoxbtx5KJHVz5j/uLds7oqTzRMM5MULpEbOLyFf3VQFgDcDrYefmmCScAHgy+9qNoQq04tVRxmW9QkB8Rfd7Vmdd6943YbxrVexvtl329bJqnvbgXlQaP7NZZpyUmk9rgnkF1mc0j8cFM0Z/4mcIAOhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AMR2GOgu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HXNdlbSB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 612CVFSQ255196
	for <linux-wireless@vger.kernel.org>; Mon, 2 Feb 2026 14:57:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eoMnNiRQlHPy/HAZwAnS7ON91dBARZx0qiRmBO50GNg=; b=AMR2GOgu4ajeo3oe
	MoJWGfzC1WK7NhbW29lXIO+Mbl0yd/k/HtvEhgxZ/kLgVDxR7PqZggVVGPzQs53S
	JbHeDjE8k/gF1WSk5y+ZegjdWpAAIh80NKVJoz5BidIMEvEOr9WKdpKGHFYf6hOz
	jd5aYCDkjfbeTM1N8Yjdl822NaRFdCXuUmeLF9RX6eSi967KtocExP+tYiGTHlPB
	7QpZk7ALDerekEZ4ZqxSXywqOlda8/ihf3y6NRGATufz7t5GZ+qS/XoHXw75bTlX
	CVpNYJyvcOjJeeUMMnioRbDZx3a0kx2nglLoRvO+f4jWo3rCDLV4DEbAS1InK50s
	YYKpUQ==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c2v0kgcqb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 02 Feb 2026 14:57:00 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-124aa710af7so35348331c88.1
        for <linux-wireless@vger.kernel.org>; Mon, 02 Feb 2026 06:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770044220; x=1770649020; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eoMnNiRQlHPy/HAZwAnS7ON91dBARZx0qiRmBO50GNg=;
        b=HXNdlbSBJCCQ2DT08ILVg0C+miOAhoniM6sccubA/852aq2/s+wGDo9572D67vgsBU
         2AVEnsmAImUq1TM/BeAYKPPw6+9VMRRnGCbRWf8fpHcT5qC2SNdcWu2cIJ8/V45wtzCx
         85WNLE76NmHDfkmn5D0vAx6Q02XvaH5isnLw5zEPHRSwMW2meAS+NBMvJaVBeY38fOS8
         OtnK9QoeDTo7fDL+NIS9BIE23MSNhmtQ07Y9QQ/E9FSPifbaYbFUA3lYzxqQ/irbzgKb
         RilEqx6sw66LTMypyoqtUH1YiRfC0EIF+531+O6qXFOJxRZ0mxyx6FXwyj6n6a102rRn
         SsHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770044220; x=1770649020;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eoMnNiRQlHPy/HAZwAnS7ON91dBARZx0qiRmBO50GNg=;
        b=mgS70EQ+oeXKypT9N1yqQIM4tx0oR1nN4fQGbbkSD2MuHGFD5KfiJtF40VDi+w1vfJ
         XnG2byBFApCAPrQSqiwz2ZyKYLLAmTJYdVqi79neStDQFQC9NcjxfCskxKlvw3/K/6Pn
         CXMr/TWqxNd8zcJxEXIpJtpDTbSNe3dqjt9nhFeAlXTnKlsWPeqsYdLwdeORMsbzVcUC
         EzBJz3eU9mok/VIylrUuLvgahgd4DknJtqp85I6OKqLiMvjoewxU1SfN+DE6G3ZRgZ05
         l+7vOVlT03AHJ6AvHCHvUCrf4lyThDdKAGk0kB08LgAqXXDGrOEm5QUB13kXqx8OpO/8
         ujnA==
X-Gm-Message-State: AOJu0YwwE0tGXBCQiq6oN3WLG/pPP84ClL/D9Y7sSxC5HbbB454TiRom
	ssZPwAbK8gBEjwcLx9pcgwxU2PeZo0swk8wiBj8HDSfi1MHjVhoO+D+2ETwK1BnjuAADyNPgOed
	lFjSA8kBD3DvMqF6qbSFaOXz9SeT18vvilKM4bkpCLrclH8ygY/8ks32zNZvh8Vw9b8r5gg==
X-Gm-Gg: AZuq6aIC/oSSXUK06LYx+9BvdrwPFB4SktMKJkUUr2cZNwA/XY5uFfmK/YYqJYyBpqu
	dAdFdnFw2Y9QjFcirDcW2o/Fdm5z9tqnEtl7+LQxA7+b+8u9jNEtFqK22R3qH3CsUJcQiMN2eMi
	RjdyXagP0xSkkAbd6NhgKVJWWwxw37DQrt2OrHmg/sMrhTZhQYm3LQn+vicxIdBEk1Nf+jZoP0G
	6vAenJclsQdxvEYw+wnaRLb/vAepzgrx0UHpCAowp06mZd+Cb4gkYJM7KcPxiw1wPqPTxPk1Hr6
	SXhtRDP557bLjm0Sj329qjUJa6+aeZrZCDDrKiZRV5TR/V3NQ34zwgi23xQVjmh9I4sx78dt3JK
	ZuuSHRVJeCmZWfxdldyMzv1UjVq7Zmrns5CFiWHX1ii91geN3VCspi+gATpQEqVO4Aly11g==
X-Received: by 2002:a05:7022:2206:b0:11b:f056:a1b3 with SMTP id a92af1059eb24-125c0f886b3mr5707487c88.11.1770044219566;
        Mon, 02 Feb 2026 06:56:59 -0800 (PST)
X-Received: by 2002:a05:7022:2206:b0:11b:f056:a1b3 with SMTP id a92af1059eb24-125c0f886b3mr5707469c88.11.1770044218940;
        Mon, 02 Feb 2026 06:56:58 -0800 (PST)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a9d8ba78sm17375022c88.8.2026.02.02.06.56.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 06:56:58 -0800 (PST)
Message-ID: <341268b4-7176-4297-bdc5-57d38989a02b@oss.qualcomm.com>
Date: Mon, 2 Feb 2026 06:56:57 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/13] wifi: nl80211/cfg80211: add PD-specific bandwidth
 capabilities for FTM
To: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>,
        johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
References: <20260130160039.2823409-1-peddolla.reddy@oss.qualcomm.com>
 <20260130160039.2823409-9-peddolla.reddy@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260130160039.2823409-9-peddolla.reddy@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Reqdyltv c=1 sm=1 tr=0 ts=6980bb3c cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=ms3VzW8au12bkc5G5IwA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDExOCBTYWx0ZWRfX6dvcqAc50Mq6
 NNiihHgDvYMhUm8lu4pjKheAa2B6Jm3eDTDPiVVyZST6QjIY+bdBNqPoGcVm286YXBBfjN2uo+d
 AAfPwfBn5377dcysJHmKX4EfrkeqhGchRt91vbg6HfYN4820XH61TM+/EMzAg5ZDA9dG7AhOkf5
 QEdA2JAbhQMiQGhqHw0Iurgpc0QtJcxZD8cdzr6S9R/lHU4KkfWUZZlz++EBKij/XwOHXRGPe23
 j/AysaeoamzwdrpEEDKZzWei3UdgeiNZHhDIx+rGIo37/S8djY4LbeO/Y5ZAPT060oxJY1Gyl2s
 g39gsCEPJ6fhXQhHS5p7um7zphRZn5LqIhzH6b3dAamYuqHZVasGHWfdU2NApODjyoW+zNEvnAz
 dfVz+1whkKLylnNBMBfcvLyezCY09CWVZnbCvVc6PGzs2ZFlfl1TfModnKI2oDSX60tdZlNFFLP
 G05zCjtAjEELYGVc6vA==
X-Proofpoint-GUID: WUEyWs07qiAcRDRMeZwToVpeAwDE5rWi
X-Proofpoint-ORIG-GUID: WUEyWs07qiAcRDRMeZwToVpeAwDE5rWi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_04,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602020118
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31462-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1B5B1CDDE0
X-Rspamd-Action: no action

On 1/30/2026 8:00 AM, Peddolla Harshavardhan Reddy wrote:
> Add separate bandwidth capability reporting for proximity detection
> (PD) requests with EDCA and NTB-based ranging. This allows devices
> to advertise different supported bandwidths for PD operations
> versus regular FTM measurements, enabling more flexible capability
> negotiation for proximity ranging scenarios.

Normally in kernel commit text you describe the problem first, and then
describe how to solve the problem.



