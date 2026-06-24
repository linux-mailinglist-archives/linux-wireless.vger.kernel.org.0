Return-Path: <linux-wireless+bounces-38051-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HxKdHPmmO2puawgAu9opvQ
	(envelope-from <linux-wireless+bounces-38051-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 11:44:25 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C1E6BD099
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 11:44:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=nsjZOmHa;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=UE7+Tldp;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38051-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38051-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA6553102FC6
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 09:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0916428506C;
	Wed, 24 Jun 2026 09:39:18 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38281233949
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jun 2026 09:39:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782293957; cv=none; b=WnAhdBW/lL1t92mMO8IciC/iLkR/HyDtcEGQ9dpX5jOidldBs4cdOv0k+bh0S1m8Iw4Av+BoT7HmINZZK3WRufGEScnOA/tr0RUKScFWsMcBOPXNbD4qNFvkpvnHmpvzIHCo640rWUNOfSNvjc2IEhLePh8pGBzRVPRczICyalE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782293957; c=relaxed/simple;
	bh=BmMITus+28snhmN+TUyWHH+n0Trodzt6ydlMD/2VMxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WuubP5xdzkPhnioVQOauHDIoezzXfVdsM3lFTaBzq2J61HA7N+a2+Mihp0REqfmUUh3u6Zn9QDnFsZy29Zpfm1gPs9XlVU/aT4islceMsTekUgemAOYJELBddjWgRckqpGjz4+bDr+TRTzS2VWBgv0afOld1p8sZTWrNhKZl5X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nsjZOmHa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UE7+Tldp; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65O7HmeH3753340
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jun 2026 09:39:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AdEudFNNt6xBTGu7wVRxNGhKKMAcyea0azkIR9tHKYA=; b=nsjZOmHaXZktUH+f
	ritX62w1PqVVDGVWaqI89vNxIf5QVzqljnls8YiOHMM1Xml13r/YO9hdFcXKPJNi
	LAWSdIZmoqidm3LSUjgTu/PwotCq9ZEkfNzQPni6VLTELI/tZvZLWKDbOZLTV97v
	niSsfeXlw7K31tlJB0IUVGv+XBG/KHe3XDw2XATi6mJhcEAz0jmmSED8SU/SREBw
	WJN2CthT+0OJD+K+7IcA2Vz8ca4LYgVKHvSEBF1ng2uk7D5n8mbs8Iqj/IYpIG6A
	Re5QvEPAfLkgkz11V6AmtnBC1KMuW/CVe0LxrMFNQA7bvTlfDcS37f7r0eqiD6OB
	K8Av7Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0aqp8gsq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jun 2026 09:39:13 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2c0a99db8dfso6937845ad.3
        for <linux-wireless@vger.kernel.org>; Wed, 24 Jun 2026 02:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782293953; x=1782898753; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AdEudFNNt6xBTGu7wVRxNGhKKMAcyea0azkIR9tHKYA=;
        b=UE7+TldpeV33zncRCd8n7tC+N4v0KzVjxE9KHaRvOHOuQ0w7qmtcZFD3a6cmT95fV2
         gKQgwFXh8lkIrSaFejDxnIjfnrPf2XRsUJch8c6AqueX2CW+BE8bFb/k5IbU84VDefUO
         8bq4fOtnIR9HrvSGi7AT7DkgEhEd4axDn7HybEYq+vmq7jmiqAmnFtpEP3L6voIZVcS4
         /RuLuuhK03ytRoanxaaM0L8GFsMgNPv8tAbrXlHU2TywY3PldQlDHhm5WBNyiNW+m2Ra
         WGec8kBjJAcXTkJmDob1iS4A4vueh8d0c054IYTuKIhVh0ABt5l7aQL7Avn3NAsLsXDA
         jd5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782293953; x=1782898753;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AdEudFNNt6xBTGu7wVRxNGhKKMAcyea0azkIR9tHKYA=;
        b=CuySRequxugrVgjJDNAhZNjGtpLbmuMFYPr/VHSGhbWm/4Z6Vt9RGSOOnM/F48Zje3
         FSHUjVgZ96k0044jxHLDnGH/spDx2HeMGrMfMBYfdAh3Zv50Nru6+9s8LckwLdX73/1z
         VKHelbURIEKw1fJpVufbfRlTP3+I+cbOawScMp26QZdoOYkuE1dtQEA8kbR1o0VwmHuP
         xj82MkcLXCoQoyPkbMFKgoYa3cSnJ7Naa5fEie2jBJCCENteqretUYY6OepXucFe8OyC
         DMO+lVX6AapUo9YaQyihhP4ZoRAvj6JlSbosAcXEN92IMjBbqTjT02aV08FpeeKjjSzf
         Jccg==
X-Gm-Message-State: AOJu0Yx5bOR028fh3svuFB8RihIB+kYQf+KHnTpl3KEUom3/kV1off7L
	rgIk+Yqfe1qBMQVP8L44H/eoPOOkfAbEq+TTnXYePOS/e0dysEeKABbWVwfquG1Bpec18ianKyE
	pVkaYBX9dWbXq+xg1QfkJgJoooC97XCnPP1tIclnrb0jLLcgEeKOuZzl1+9yW5FbcNGKFhA==
X-Gm-Gg: AfdE7clTRCRdbApRYz7Gp/0xV33yI6PPbHTMNMd2kAARkNWj8n4hO4gxThYgYr1uFUy
	3sJZA6rkqFdEO165hoAKdhhhnhjiF+dweux2kEH9vWqdJr5cChsNd68W8bZ5GclTvRb/s2VQf1j
	nYZTKIM31CmvWG1BigDjy+Ry6X99/OAmaoF5i5AHxA+an+09dSMPEOVbgKuJx/m2JwRjzyMTNJ6
	EMdP5KZXlmZ/y+jj3MOd+nrA/scBHCgRrjCQdSR6DTmupHHEegqWzc40RhPqcBpzqCPfQV/zqAJ
	OibtBLEhTAvN1K66ZUzTwdu5TqY6iH1TM5L+BJhFeTCVmdRV/zJ2oO9VDy2ijF3S4OV41hVSfo+
	V/FpdXUzsXOT9Un4rQ0kCDXtDSu3Oh1E8r/bgf8xE+ctOaN5g69dNCPyJOxmVxLvsbE5GL+bUDY
	9gcWQRxTeK
X-Received: by 2002:a17:902:f650:b0:2c2:dadd:940 with SMTP id d9443c01a7336-2c7e13c0212mr29602155ad.2.1782293952750;
        Wed, 24 Jun 2026 02:39:12 -0700 (PDT)
X-Received: by 2002:a17:902:f650:b0:2c2:dadd:940 with SMTP id d9443c01a7336-2c7e13c0212mr29601925ad.2.1782293952284;
        Wed, 24 Jun 2026 02:39:12 -0700 (PDT)
Received: from [10.133.33.165] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7444a9c5asm124861435ad.74.2026.06.24.02.39.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 02:39:11 -0700 (PDT)
Message-ID: <be02985b-f8b4-464b-9097-d46f1fd32349@oss.qualcomm.com>
Date: Wed, 24 Jun 2026 17:39:08 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: use %u for unsigned variables in
 QMI debug logs
To: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20260623-qmi-debug-log-v1-1-79471aa8b898@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260623-qmi-debug-log-v1-1-79471aa8b898@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 3nJlImP291aHx-EqBNcMh18JcZNNwiqW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDA4MCBTYWx0ZWRfX4KoyDB4jvUT6
 1fAVv5BwnHmIlAaJlP3vhw0pCY0SmroTUapKeFVte7HlPWw2FOMWmMVS9PeRufzTAmvLZbztStG
 J7kqv8IV8hg2GH+VunFDBEQBona74Y5sF0oXUIRQdrHuwFf+daQidbE1V/e1KmkA3/YN0HIFLbb
 DCLOCpUnhJzbweh6EQV/XqJc7wseE2uuitk024PTrzGQdouqPcFpvBVDURMFzZl1oXCR9GvWA6L
 HGDjeHshNJVBjK/m9dvuD8ERauM1/NHLuWHlpViY4zCb9J1fcbi1txwV3Z/rckZ+x5apvfBaxyR
 0exRHCNHmXeTHqoRKIN8oXzXNP0BvNvHOpq6e0JrpVMpuAPy7bVIp83YO74HrcC/7kQ2GI7zvIu
 eokWDyeRKyQ3Dl5oND+UaN0wW0lkHg==
X-Authority-Analysis: v=2.4 cv=QLhYgALL c=1 sm=1 tr=0 ts=6a3ba5c1 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=tGGASSKubhSInVnLuO8A:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDA4MCBTYWx0ZWRfX9gGvndmRnu6c
 Au9DdikhyvMyKVtLpYS7bxwHoZjg4Eo8zMjZg4gTFNjA/YFerH1lK7pNjLdhhXEevS2YQB0dBNz
 7jIcaz/d9WFzWhRnsnCzAIey5xw4YCk=
X-Proofpoint-GUID: 3nJlImP291aHx-EqBNcMh18JcZNNwiqW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_02,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606240080
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38051-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:raj.bhagat@oss.qualcomm.com,m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B9C1E6BD099



On 6/23/2026 12:04 PM, Raj Kumar Bhagat wrote:
> Replace incorrect %d format specifiers with %u for unsigned variables
> in qmi.c debug messages. Also add missing trailing '\n' in log messages
> to ensure proper termination. No functional change intended.
> 
> Tested-on: Compile tested only.
> 
> Signed-off-by: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

