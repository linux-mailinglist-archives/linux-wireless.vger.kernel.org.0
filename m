Return-Path: <linux-wireless+bounces-38963-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HtwrKGesVGrapAMAu9opvQ
	(envelope-from <linux-wireless+bounces-38963-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 11:14:15 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA847492C6
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 11:14:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=lA7xPbwb;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=B09C4WI0;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38963-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38963-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E680301D691
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 09:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403EC3DBD43;
	Mon, 13 Jul 2026 09:09:30 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8A23DB30B
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 09:09:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783933770; cv=none; b=BnZIRqwHwv8BwXOqCKE2oStYyQFGmSdiwF2mjfpkiGgdBfAErN7CeCyY0grfIDng1MSsB5kBSuxmBYr8niHtrQ/g636mUdc4SuCIFxIO98YQ9wMqQ8q4ygGupbwN/A4ZEDbMNoqgPQVi6sbD4gnCMSupjrQ0K51INOQI6OR4oT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783933770; c=relaxed/simple;
	bh=F4QZ9PfnfmugLBIxL1kYhTQzT2GbuYIJWOts6j62lxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n3lpkoZs9+QbCcFm8AQkpc86+yp4AMay0VaQEVQxbkCJp48bExTNxdwtyr535G3yZ/yQFkfha1dXbtQlsWsJF0firUze/PU9ikzr6uTTGorl62ek3COT90drEDAZkrB6jOv2mEOekk8toUkQAimkBwJ8y8VED5IR9+Lz2wPIhF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lA7xPbwb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=B09C4WI0; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D6Nirh507094
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 09:09:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rTdBr1+Sl+tJLVlr8nhC2OCra9+bjTqVmnJpVzYhVg8=; b=lA7xPbwb/8NHbDrh
	5mYjOraezw3xhLTwMANDboAfMMjrlgg9Jl8gKknojQGNTu/QCAtK1Co//8/93+4i
	TnYvT65fsDDogGDE2qnZeSc7SYb7W2BGcBTxxZiXDf0VEBRGZeE14ieIvjYcaGch
	bmlFiiOCfCyB6lxTAmeNAfOrCCi8R0dWd/b2UUnW1TPc8Uykz5Fx/wogTHzJCb97
	DGo3fXYX4GiJ4wkXdKwXcbM9BQa1F8DL95cqkmQifCG9nNT/It9kKE763hogFCyG
	1riyyK3Av+nDkOATQUyWmHjwF0NIhMDFl6BDaF/dbJPW7/D897mIxJPy8+fUECyn
	cvLMHA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fctc8gruy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 09:09:28 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c916d17dd43so5264401a12.3
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 02:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783933768; x=1784538568; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rTdBr1+Sl+tJLVlr8nhC2OCra9+bjTqVmnJpVzYhVg8=;
        b=B09C4WI0WuTck1RkoiJkTyO6cGoAhvjqwaRSJ4iSiDVt+EfqgNC6UYxEZVJq9Gkhjh
         qNhZuthROrqh8iq6klWw1Z9B0hMFX0g4Zxk5uXT/PM0CyKLeYk2MkTMpOokg6BdpX3oS
         3bAfD/CaOw5r3jS6+JZD11cyUlTTkQ3Iera1ojvhfsUldkCcUduB/G/25QQNBufpsdYZ
         3453SxUjbWW2VJb2GSmz0qttuCJg8jiF8txQYW+SSoFyITXjg28oTDID78YA5YVkP6EU
         YN2ZNuS+nco0OAyCatbZLidaTJtmP1Oz/gk/uFeB7Nm2r9LCr4TWGSKTcwuwBYtc5jTf
         65Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783933768; x=1784538568;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rTdBr1+Sl+tJLVlr8nhC2OCra9+bjTqVmnJpVzYhVg8=;
        b=AEm77/E5ZuUljDMEofyhS+ORXJHA9W5e+n4xPbUSWyQWSl1jF/zZhyCiVmCCsnAqS3
         loimvl84QneFlwJvgRGnW/nMjLoecroivr8fzVts8jYbFXIYOwoIqXp2AIhIxBpqrUHo
         ii2eLs+Jai1hGgCsf78OMpz6PZoImZGNENCLcPTRHBxCibTXEUiNFpcFH997W2gdy/L9
         G04uDH5evTkGJwynlMXb24HVxtQr1vPOjZ9v+4k99wsFAxZDAS/6R/ZymcKZk7bsWcfE
         fjOrOXF+jolWGbL1oyIexz22CvXQuqjVyD2JEevx+sJhV+c3K+mRdDtTLBVkiRVg69yr
         Ly/w==
X-Gm-Message-State: AOJu0YziWyKhScc5vllT+lcW/h/KJnsclvRDW5FkOgw74Se4s7EIeaIj
	ioij3VLDU2Ty+7JS3mbnVGsyK+wS9207U1RPkOuYTF9Alc4F7Hijldob174pNoG63zf5RJZ3F0i
	3C83yxaSStig0M30+RPKBxp3pXVDWp7nbWNofXbhw7ab9h/jM/zqrFzqF/p0ySKrraB6n9cy7k6
	X1Lw==
X-Gm-Gg: AfdE7clYisERyMzqQg6BLF45fO9UOlMSah/bZPe/F0vYZYBNg85wB3PhJOtVeXEZKD5
	tdewWOshnVSUAgFhFneeOQKcutleICtCGrkRDuZ77I3eYlJzxT90MaD41L3mOV2JlEHgBqXDufD
	Ajn0RWUs9zoY0GglAKAKnsjsE4IXhY9VQToo0uZieSP6R6UirgILAdJXGqxyaYwozTedhbhEDPc
	f5OqAH3ZORDlTpSMcPP+d/9gNf4hQoZerVjg8ZkOF2gfZ21h36DTSVZszeZ7RQX3BG4Y3sY7eEo
	MilH+SxZi6vc/rR3GxL6FYkmoslRg2mn3AG1RJUuV4EB3kwXrrhkqSAyt6qXTe0qMWNjvLUhgx2
	E3nU2McV6T+x3TYiojsTFn1x266E7yABx92eqyzol77WsL7YwNxw=
X-Received: by 2002:a05:6a20:729d:b0:3b4:888f:b3f7 with SMTP id adf61e73a8af0-3c1108cf4acmr8256084637.42.1783933767626;
        Mon, 13 Jul 2026 02:09:27 -0700 (PDT)
X-Received: by 2002:a05:6a20:729d:b0:3b4:888f:b3f7 with SMTP id adf61e73a8af0-3c1108cf4acmr8256069637.42.1783933767216;
        Mon, 13 Jul 2026 02:09:27 -0700 (PDT)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f72a6sm80168725eec.1.2026.07.13.02.09.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 02:09:26 -0700 (PDT)
Message-ID: <cadb2c3a-070d-42bc-b19d-a10fd2ab7822@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 14:39:22 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: Fix ath12k_wifi7_mac_op_tx() style
 issues
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20260711-ath12k_wifi7_mac_op_tx-line-length-v1-1-10e4899b98ef@oss.qualcomm.com>
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260711-ath12k_wifi7_mac_op_tx-line-length-v1-1-10e4899b98ef@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: GAu0MlvRe6YgwibA7VBlaTu0Msm6tcgZ
X-Proofpoint-ORIG-GUID: GAu0MlvRe6YgwibA7VBlaTu0Msm6tcgZ
X-Authority-Analysis: v=2.4 cv=UtRT8ewB c=1 sm=1 tr=0 ts=6a54ab48 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=VPYQ1-KmX3nvB3bNegAA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA5NSBTYWx0ZWRfX2Co0zH0uMf3s
 wr0+fj6QlbCv8xvc3KYkrlciSGATAbi9RRgpzhkmfaCDPz5YdeCZAc9dSCnOkXwv3xewHDDjCfp
 YHFva95RyulgRbJ7+G7p3JkzvNaaOtU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA5NSBTYWx0ZWRfX0yFCfB+xaP2m
 ord7UL2ZQv/ilkkxabWkkXt6qbQy6YZ3nAHc+9FSOobajQRPgwChA1l9XYqUxBZTOWDU052lWHg
 zICbpVjsWxEYrpaJ9T4AnDAlFd38+JtEitScg/L3Gnsc+FTppj5xrFmdzFGGGhCFEHoipbR3D+z
 7sYSuI/bk67nUMTurNdv9iB6VaAA2Hraj1Hbx7e4prfeJ5LbuXhMHatOXT9ijhw/rmiQBoVPEfc
 I/vPWc+huRE7lDFbHhXyK/5Xxu38zmfon/QWUh+/D+Dw4Jn0rx1I7G3qqjPwUTl5zQj8EwZWQQz
 98FNurAFTftIc8yPyYpMHiGis3rG2WaUokp+KpWmCrPbHIAScucPDvMFzzp82N/btbuW4EvpjK6
 XQ7a5Yr/Uxr6iHP6XbNCJXfaPhDMoUnRKjs4NnuRcsW2JArb9oKa4kSdkCJ/So0F4HLSBu3iaJp
 uRD5gwvZ+GyCddIr/lA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130095
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38963-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jeff.johnson@oss.qualcomm.com,m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ECA847492C6

On 7/11/2026 9:01 PM, Jeff Johnson wrote:
> Commit e47d6c9bb416 ("wifi: ath12k: Advertise multicast Ethernet
> encapsulation offload support") introduced a few style issues.
> 
> ath12k-check reports:
> drivers/net/wireless/ath/ath12k/wifi7/hw.c:1042: line length of 92 exceeds 90 columns
> 
> And automated review did not like one if/else that did not use braces
> for a single statement that also included a block comment.
> 
> Fix these issues.
> 
> Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

