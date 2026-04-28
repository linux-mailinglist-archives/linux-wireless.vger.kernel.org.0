Return-Path: <linux-wireless+bounces-35437-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FijElEj8GlhOwEAu9opvQ
	(envelope-from <linux-wireless+bounces-35437-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 05:02:41 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C0D47CFAF
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 05:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F02CF30151CC
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 03:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4B12D5C68;
	Tue, 28 Apr 2026 03:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P01Tgrx6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DF4ywG9n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EBA2DF13A
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 03:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777345358; cv=none; b=byMpnvPx4qN9xD77vY9+qRE+6YrR5mide6Ob5KRxkH9bxSRO0CqWxHB45QALPPPyFk7eLLnI/l5rGswRBn4rO5nsG6PVEfdpTJW9BIARgicmJwcjGd7L03RRuBF2EYMLFgpphcrXojwByVEuQVR2tveSdEu9W1Khkm1qUOTFexk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777345358; c=relaxed/simple;
	bh=t0n4635vakk2cAS4+sKU4AKWkiEplNdhCEeCCPfIWMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a4uJKrflwBqAMBq4QbXF6Z9SLw+gxEX4mIzWHT5+iPSRGjIJv5t8mHbbnpDY7oNY3tIE6yTpZcoyHsE0YY/4px//1PZc2GRT8b/MOev2eksEtmi7sisgec3s65p+6+8VdWXQX3H536SQlMY5b9rCgWHCCNE7vFF+D9LXMODF97Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P01Tgrx6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DF4ywG9n; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63RMTKWV1625050
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 03:02:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wvbBNvK59z0ts17Fz8Tuv/cBWhhNAtDBIorhgFmFXp0=; b=P01Tgrx6vkDmiZgS
	hwSwrWbKRaK9h3v0RgVTqipsi/zVgvRRy4T1XUxv3sx4RQN9wzD9929bTbdCk3sn
	tXg8NheUqco/9CN1FF55Q+rlRjQFxQmVT7uPtixADS0zfNAnmtiba8iUNIaoaklA
	FvMI1rPMOLHivYDd5DnAqpm9p8pjiVCGjtmrPhRUwoFRl3uc8z5Ac7A5X4G+zQJf
	prQeHKhtkGt7HhMIAjbBxfvIviaHbe8B3BlrXjQ3r7wfJf6ZmFrNvWyUrmtWLNo3
	OVAhoSxkpyWBOzOsfDIu+EdhQMk79uZNAMvapu5gRHl6yaPpayI/6E0NfDDThudD
	vyoeaw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtgms8v01-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 03:02:36 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c7989b7cdd0so11362512a12.1
        for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 20:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777345355; x=1777950155; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wvbBNvK59z0ts17Fz8Tuv/cBWhhNAtDBIorhgFmFXp0=;
        b=DF4ywG9nn0Y3/Zmp3beq8NRucHMNFLyxx7NJHtkFfZoQ8OW/T3nmD5OEJQ1eHULyDY
         uNQJw2Hc676TEIPdFZ8yYSCchbkBhc4VRglVH16fMcF4ufGziuPveNwmFFec6WW4I/xw
         0WXTfQIeo2WNJs2cDL/GPKzZpt95q0nP91ZGi0lO6FXPuCeluJtFeZatDj2wOxxlEz0S
         Z813ag7n3dx7ZiZ6Nqj3Wdjr2YjdqI+VZ1JhoBg2wymc8IMqzkvYrcRleg8y8eQySEYB
         nsO4FIBG2+Sy9NKHb3CKXPPnSblZAbEyWnGv9wf2Ekj6m04LicLTi3ynlhN4QdAvdENh
         CRNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777345355; x=1777950155;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wvbBNvK59z0ts17Fz8Tuv/cBWhhNAtDBIorhgFmFXp0=;
        b=fu4ax+yGUbesfAEEmlViGY52D5NEyCL61rFSi8dwd3ECnIiqksSrIE3aCiUmf69kwQ
         7a2FGp3NzQIuSSCj1hSTHfRlfb9EE5nx7Qp3uEMXgnotSlqkso/LhQ7l3Dp/Whm1A1jt
         dstOXAgLyYp8iqilwOBjP0p8VgAk94DxTp1dtr4cFaEWALbxxrvfU+1c1NLgnv0o7tCv
         bZq6oJwv/KTsKSeOyeZt5phSsfHpucxla+NCx3B5iaAN0sHozB4EVUUQPFX18hrpnf4/
         IFDeNR1oVHcbEoT/Zg7bl+pKSLYxsk5CgNoq91UPQ/+Cxeh1hLLCzmojx8osYeMPNPVU
         NlnA==
X-Gm-Message-State: AOJu0Yzmb5NII2h+m5oMsXNAOx3WHKH/xIacD8KaLY/ks5Q5qY2IvqAh
	7PtMUtV2JYiD9/MpYaLo+Sho/jbsMUu89pZHOs6s4X9uj9onKKx4lpAYVk7kmXz5Z5xehihQ1Kl
	TRBWeL2zk7JFA/5Twr79rRDuxdIGXKhLnU7X8uoDmp3UrUlv1VEg32AIXxpGtXTyJXE+gEA==
X-Gm-Gg: AeBDiesYiQ1ZvJc4Tqf9eeaW70+sUf5+mHI87EMudlSbOyz/2uBfrL0n6GIcYl7OAj2
	gQxaY2/Hhea9de8M2w5evmAB7T7V4dO+wL3fY+tk0KSJDe0xjwDzM8o4OJp7K2oVBrevi7x8z1W
	+vb+cOCKPzjNMfiWIA9Jv5bpAkZ3JSfF/qPKQRCiQOZ319zuPGaLsd+wcfnj6NhAS+3l0o8prKD
	Cqa4KFQhYb4QqMpFbDUtYc4CFrSMp6amgymhveSf2RCpnHTVpP/LgYJKaMzPNwHTN2RJLhSEMdA
	y/ltqG+/og4RW2WhvoomEGMAz6Ra7y/fkgLW+fykV5ienD5u5g9NeYElktBQpsRnBm70PhufOhO
	QZR+HOeqm8oJvpTv99Agddod5fiA3YIkbrxpuI2OQo/k8sAUmpGlLW4m1zvMvHROWpjwSvA7xKF
	iIGPDY6nFfDys+jFk8dYVlccq8bnvoEw==
X-Received: by 2002:a05:6a21:3388:b0:39f:ebf7:5ba6 with SMTP id adf61e73a8af0-3a39c1bd8eemr1424592637.25.1777345355528;
        Mon, 27 Apr 2026 20:02:35 -0700 (PDT)
X-Received: by 2002:a05:6a21:3388:b0:39f:ebf7:5ba6 with SMTP id adf61e73a8af0-3a39c1bd8eemr1424548637.25.1777345355085;
        Mon, 27 Apr 2026 20:02:35 -0700 (PDT)
Received: from [10.133.33.153] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7fc35d94b2sm683426a12.31.2026.04.27.20.02.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 20:02:34 -0700 (PDT)
Message-ID: <7289c0d5-9cf1-4569-97be-f0812b1b2dd5@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 11:02:31 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath 0/2] fix leaks in some WMI error path
To: Nicolas Escande <nico.escande@gmail.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260424144813.1708214-1-nico.escande@gmail.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260424144813.1708214-1-nico.escande@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ZckYKut31fCedSaqPm8BWqzCZVn7t1P-
X-Authority-Analysis: v=2.4 cv=R4gz39RX c=1 sm=1 tr=0 ts=69f0234c cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=FqyUr2HIOI8AG8dd71AA:9
 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDAyNiBTYWx0ZWRfX7+osbXBFIk4A
 tgol52TYNclnABT92uDXTmqi7MarnmZ+eukA/ekNI4sMV9/4xE6NU2k27NYjDVL39eNMUtYM0Gj
 tFWThpU2y3Zi77JdpykfBndFnKBR7agW0cekB/cQteQoal5nkU8if50jRau77tcOg+L7/75FYPn
 YOh2Gc99eNOiTxGODwik2qIqd1h02OLY0m98S6/yobxFfVdHTcK/jzlT2O65ePHRelJ0NpuKmoZ
 DTDvJQEPDHFE0s/0f9/D4NPWno4CofXRfFLbYDbrT8a+wVvuatV1kZJ2H+if2VmYI+TJJQJGE04
 wveCfNzAARPqb+sTrezaOTYdLKumFk4OCZURZ9qrBOGYydLzGwX9GfkjPL32z9lZs4hJ3R8Fn/M
 5h8XJD3mPszQ7vmCGXULTkuasXAhuuA/gZ/rU/R1Arz5vd1tKEWgkNf1c2LnhMBobuTHh2RCkuh
 mmbfC/Vck6fVvJiCs3Q==
X-Proofpoint-ORIG-GUID: ZckYKut31fCedSaqPm8BWqzCZVn7t1P-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280026
X-Rspamd-Queue-Id: A2C0D47CFAF
X-Rspamd-Action: no action
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
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35437-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.infradead.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]



On 4/24/2026 10:48 PM, Nicolas Escande wrote:
> So this is similar work to what has been posted here [0] for ath12k.
> 
> When we use the pattern 'return ath11k_wmi_cmd_send(...)' without
> explicitly checking the return value we fail to free the allocated skb.
> 
> This has been split into 2 patches per Jeff's guidance to hopefully
> ease the backporting process.
> 
> [0] https://lore.kernel.org/linux-wireless/20260422163258.3013872-1-nico.escande@gmail.com/
> 
> Nicolas Escande (2):
>   wifi: ath11k: fix leak in error path of some WOW related WMI commands
>   wifi: ath11k: fix error path leaks in some WMI calls
> 
>  drivers/net/wireless/ath/ath11k/wmi.c | 131 ++++++++++++++++++++++----
>  1 file changed, 112 insertions(+), 19 deletions(-)
> 
Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

