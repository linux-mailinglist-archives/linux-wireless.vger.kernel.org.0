Return-Path: <linux-wireless+bounces-33262-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GH3tCTNjt2nkQgEAu9opvQ
	(envelope-from <linux-wireless+bounces-33262-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 02:56:03 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BED8E293B20
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 02:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A497930055AE
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 01:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AE9257423;
	Mon, 16 Mar 2026 01:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BrQgQLge";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ky52NW0W"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBCF176FB1
	for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 01:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773626158; cv=none; b=gHMF8HuRt0XBFiZ/kReOCJvgYkTKAJcUxaYo5fOfXAkiADIJPXTeAhuPE09lT37eFphC7nR0wXt9VRIXoFn7hFR2OTfq+38VQWn/rkik5mM7FivwggAjKUZmcb1Phs+CGdOKHjOVPIerSafFNBA5wlgRlCY1g31TGYUcddgz9nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773626158; c=relaxed/simple;
	bh=Pzf2fD5bYjse1ifwYoys0kjaUYeQtWfw5/AeAXYmd7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GZk0THRAl7Xnq5gZOeF8L9AF5pqX4FLLMrhTzm5HD4RwoG5w6i/lSywv/o91X+7Mz6uvNb4gSEYu9rYYSa+Rvs5Z0slKWu9JmjEZeneuBY4rvZo/ykonvbJBESUgpbGICCtsZNrbS0/xon5+/QbOvbQGl5gM0Em+FrYBIkl5gFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BrQgQLge; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ky52NW0W; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62FAdkrc275657
	for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 01:55:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	98Xp3trSyk6WtVDhuSr+iYDxKiQNTLAfq4L/owqfT1o=; b=BrQgQLgehe1X1mUh
	Dhjbf3QTGlp+HXXqqNNRPuPfKTB4hd8M8lseQRUUvsShXLxYu3+OjM/B01h/LYdH
	z7riJErIGM0RkE3qDlXmnAY/4yVSaqlz9XIEmPRcEEFwPw5e2K8Qqde2NnJpZ/YD
	L8Y/FrNo8ppm06rpOMiD20oqbzQoLszIkRlutO9AFJF5vBpyNp7DFOCobvE7sFGd
	QqUeaOH1jkg7uLAkHbwy3bjXZQBP+hdZh2P2L7sfUyjUw1j2f8d6E88r3yoLpBlg
	OduTc/Exso/jeCHQ0/JV7p/PvhRgOctqtAfUAuq0OMH1K9f8ETC8C3nUKI+M2+vL
	H7bsTA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cw03xks7b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 01:55:56 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-354490889b6so20138988a91.3
        for <linux-wireless@vger.kernel.org>; Sun, 15 Mar 2026 18:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773626156; x=1774230956; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=98Xp3trSyk6WtVDhuSr+iYDxKiQNTLAfq4L/owqfT1o=;
        b=Ky52NW0WvO9Mc9ECY1aDQfMXaGo/x/ee3TxzT33IsSPE0z4iK2u3TkrL0w1f7dQz6f
         O/CVjWso+EGw9y6+QOu0U9/V44hAe4zYUq5GmMEyC8tWZWBL7vqwhdh99gTN4UFKjcmw
         Bnb9jQZEIQwuwo6lESUaNnLEXegA6ydWmdYzxl2XmCc30z9wGMzfXFnDGO3evtpyyEnW
         48i3PlMg+2gvNFDnwyT6US41wA+JD4e/pj2Od7/hENbTtzQUO4zRnPf0whblgzDL4QgL
         Qzjd2uV+7emnN/+JSSqzAlnVTxq5wYisPp7jM28Yl9xf40D4MyDF3nxH7u7IWERcqIEe
         GmQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773626156; x=1774230956;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=98Xp3trSyk6WtVDhuSr+iYDxKiQNTLAfq4L/owqfT1o=;
        b=cun2zlaA6rOovnTqB6iXe/mEBXJYmRjuzIN6UTVKctxh41Ep0vFfk7KrLuvAF76MCF
         UnB67lrJ4P2ExO0QtKR8Q5hGqObIJo8dtTCHAk9HGGcy0w6ulDQggZP70lxe06U0Hlld
         v3sOXbisZppIOvr0P/LX/GA2kv4vLwCGX4QFp1Pf6laT9tWG/ee1/pIm0pBls9ITML5/
         aEGykpLmjyKr74cQSPqWPMzH/v+aoxCHW9uW+5M+rARK7K+7bYM0a1bxQik649TZlBjD
         wJQlDHsvXpc1EJXXR+l7KGDVmDMMUVldcucTPWUcDGYqVQSpabHylp1cjl4uU7qB7NF5
         13oA==
X-Gm-Message-State: AOJu0YxIsiIEdMSz1N5VEdxOwdTm8gEOPu2SB994FKcerfFDUTmH6A7U
	iV5v8hieRLr/J4Mwi2N1wCYrLUrY7vUWjdm/VH/iWLRuhSwUgd2As9tSZVclB8X1rWF1ko5GMPv
	QmQ2E6fbLx5TDQVmH85uMaVQuaNhWPlYyky+golcPQFsjsu8NjSht9rJhLYj8myYI5wd3TA==
X-Gm-Gg: ATEYQzySGV6b/cpCawLQ0FiJh/ihQqrmdNwv5z/jLu/FTtp+1PDwd5MIBXGF/kWDqzO
	ClB7tsl/LpplksZIfveGtXidK0iw70p8I2vcW9594A3T72BN3hLITaRXxrzKO7lsDDYd/ZZBiZp
	w1ux+vAcIZpKnPraijIC6yhIflqhGljjR2UMbBQQRm+8/nS7KUgcA8y/pnLz9fQ5B3fxHTeTLdp
	WdDzDVUa7iF0PCnLXge9qytpXQ0tv/YoK0xiiQWeyTHaDfyoeKSyZ/pVNuDv7VuTM27Vo6xhYEZ
	vGhys+QjbGMcU4kMCjatya83eedlL5fqaMORtxtJMih83xo9juxUOg3Q2RQA3MMgapnEA4I0v69
	pKSjeThXDH3Ek4O6a2TFjiEiF8i4o9kFPgo2ksQd+hSZ7GGUuziajPK6OwQg6S+/FwfWlMgGWj5
	BgJOR3kDhhUaz0/m4uwu8=
X-Received: by 2002:a17:90b:4e8b:b0:35b:a53a:7d08 with SMTP id 98e67ed59e1d1-35ba53a7e81mr360859a91.26.1773626155842;
        Sun, 15 Mar 2026 18:55:55 -0700 (PDT)
X-Received: by 2002:a17:90b:4e8b:b0:35b:a53a:7d08 with SMTP id 98e67ed59e1d1-35ba53a7e81mr360846a91.26.1773626155398;
        Sun, 15 Mar 2026 18:55:55 -0700 (PDT)
Received: from [10.133.33.128] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a248042d3sm4503351a91.0.2026.03.15.18.55.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Mar 2026 18:55:54 -0700 (PDT)
Message-ID: <6d481a12-8243-4996-99dc-9fcc5a75b014@oss.qualcomm.com>
Date: Mon, 16 Mar 2026 09:55:51 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 0/2] wifi: ath12k: Clean up the WMI Unit Test
 functionality
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20260310-ath12k-unit-test-cleanup-v1-0-03e3df56f903@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260310-ath12k-unit-test-cleanup-v1-0-03e3df56f903@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDAxNCBTYWx0ZWRfX1+vHTGHtF+RN
 GT42YmaL93YF/eL7da6frm8qJt6t4/pYQbSiROCnT2f5xYsIxIIaJwIkYJp6g8d9Ci1+zp492BA
 w7Pfq9WPOXI/D/CRLY8hDjSrPD6Mpz+/0vj11SR3xqEY2ON0CjeGYvZnrSU5L8rTjPByBQu/+cZ
 1f5Ri3jb/mF1wtG1KoiympRL8HoqfpEUuzUKp1+Uxr8UmnxDFToeFV5m+4z5MW5Z4Xj/CH2pEni
 V/AvXtGeRuO8MhYjONoLac7dSK2XA338HnVOSp9EDBBj1bAkMBf9A1ev4a72XnARzmC5NgkHe7G
 jfTMtBwrWLCoU/1G3aTnivx4aIG5hxkLYIIAyTcszPT2r6Gf8SBugHHJ7kQbYPlXoXC0TAnBs+4
 rY+zlG8GAiN2bc/SE4fl0k8RHX+T6tbkxvU7wQ5l8ZxXV+7sjOJdrSP/dqthgeW9HBGmV38vmP4
 CHwyu3yH9GVWzBIfeDw==
X-Authority-Analysis: v=2.4 cv=YLOSCBGx c=1 sm=1 tr=0 ts=69b7632c cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=jYuOhbGHmjOzu_srz9kA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: 3ZRJl2J9uoKjL2rFK0FjMb2lo9yadjTr
X-Proofpoint-GUID: 3ZRJl2J9uoKjL2rFK0FjMb2lo9yadjTr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_01,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160014
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-33262-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BED8E293B20
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/10/2026 11:16 PM, Jeff Johnson wrote:
> Patch 1 updates the core Unit Test functionality to address multiple
> existing issues, and patch 2 removes unused DFS Unit Test definitions.
> 
> ---
> Jeff Johnson (2):
>       wifi: ath12k: Clean up the WMI Unit Test command interface
>       wifi: ath12k: Remove unused DFS Unit Test definitions
> 
>  drivers/net/wireless/ath/ath12k/wmi.c | 58 ++++++++++++++++-------------------
>  drivers/net/wireless/ath/ath12k/wmi.h | 14 ++++++---
>  2 files changed, 36 insertions(+), 36 deletions(-)
> ---
> base-commit: 9942b3f80f4ebe6852663e0d35ecaf6b7a97c8da
> change-id: 20260305-ath12k-unit-test-cleanup-07622698c994
> 

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

> 


