Return-Path: <linux-wireless+bounces-34417-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHMuG9V71GniuQcAu9opvQ
	(envelope-from <linux-wireless+bounces-34417-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 05:36:53 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF693A9706
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 05:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86F8A300C5AB
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 03:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288E9374182;
	Tue,  7 Apr 2026 03:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DEuD2d4M";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cxR8JWuX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D24272803
	for <linux-wireless@vger.kernel.org>; Tue,  7 Apr 2026 03:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775533011; cv=none; b=tuX1wwObaRSDxV/fLLInt7OeV0bNHGdEwLG+kPybMnFrW0mM0FseDUtFbIuZOU/1vEG0x4QriZDJ/1QEtLZ3ed9NCYvYvnLu/ffTgCqzrhRM+yhw+4WyUpn2UzaCaylUgHg4Y1yegRMZ9aQS6cABLity3a0FF2J4NuIPHkZiAi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775533011; c=relaxed/simple;
	bh=z391g2w7sv7AiQbBUH5trzn6m5Ncr8wOxsHwKHgxfM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a+eIuzLlQVll+9ZixMjaxsUKW4wHKn65mdSuFWkO/McZ1w202XTL2TjTicpyJWhQvzoMN6ISZvoHCIO2t0XtAPLKtIEXwNNm26sqdr+mQO6Cn2rOSY95HWetsMEhe0i8Zq7SKbl0CBseLGaOQFgYcxX2V27vsZ3h1+M7Kq/NQ14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DEuD2d4M; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cxR8JWuX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636LSBYR2327732
	for <linux-wireless@vger.kernel.org>; Tue, 7 Apr 2026 03:36:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NUqWdraFh569ddUKgSTTw8gCNpVCYPxYTZ+d/rwHnwM=; b=DEuD2d4MzKHmn+xD
	dG3A3/CrH2hUhrmOnJbDHoeMEsmSM02VNSOtgNA59pPT7xXC+KLkWTKZbX8gZ9kC
	amCBzA9hywFTYih1deDl3RF1jEHc5AD5kg2hblAdto9xFMdNeTia/qYJjJc0TsOv
	0PpiEUnC7chhmwrSTCkiejEpz5AL4JTyNno7K1umFMriM2LKs1P4MyinxC/FBsi1
	i1Sy8YM8ihnXU65sx3tbLlQ2VNFHXZ8MyU0KkOsy3OKjyHqNCaLL2C3AR05xHN9e
	UviZRu/HTTeEWsusWmCBEK/TETddsgK4YytsY2RQjqcne5G55T1Tw0oYatoBaMOH
	fqtH7w==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcms4rv0e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 07 Apr 2026 03:36:48 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c741b950511so2439048a12.0
        for <linux-wireless@vger.kernel.org>; Mon, 06 Apr 2026 20:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775533008; x=1776137808; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NUqWdraFh569ddUKgSTTw8gCNpVCYPxYTZ+d/rwHnwM=;
        b=cxR8JWuXPlc5FE/pUjumNtxP59IuJpsm1ZSF3wHx9az4VHwewijXAVG0vIgBpZoYnB
         ILp705+SKEw+y1rfDOrtqX+bgPigmUCE/4NthC11UcSdCq1EyTHTGdoLO1NLZdFJZgeH
         JkKrW27l0AVOMwx9wLMDPoyHMZChQSTy3d1VGSskOoknWdQakcIInK/dllbgYyPfKUUK
         7UlHJQH683bpodFkdlkwzXWqf8L/po62RVGI6cxAUIHUyy+uZGQ6HsCVsTlMe5X3QJyX
         7SF200c8jDjFSZB8v0u9X+H+OEx7tJ/KRER0eNVuXznTz4AKNXlg1JD2wniCuPcTfpO9
         OJkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775533008; x=1776137808;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NUqWdraFh569ddUKgSTTw8gCNpVCYPxYTZ+d/rwHnwM=;
        b=SlwfkOZ35EOFf50yv+W8X1Ve/7V8QdzgqyK3G8WnkXZNQOPdPEJLiLdDfBpx8n2u0E
         pMo7PjShBu0segEH8UVExvVUd+8mvMkQl/EmUuwzXn/2MfpTBhJPUmpk+QUIJoPnhH/Z
         OEuBwmLtwvFNVwwIepqOEp1pXWjGcdNzT1Jkkw+EZyi2z22/EhUvod9qIlua49rD6jXk
         ptqCAaXpNJZOV5HY5wSI112cITQ16Jayr5FeNSqM/12nbfi3k21v3W8jEtxknwuc/hny
         CVaCYPXXT8a/LAskW15QOc+wv3GqNqLjUKpACwDS7CQBbzv/fu8lJL89MtMCH8/yWJSk
         KuRg==
X-Forwarded-Encrypted: i=1; AJvYcCUyCMwlaTvh8e2f9wN7BuWjA1gruQEiHZOYS6MP/Uv2OyLGkV8NTeQkZ2p8lsMbyOiLtz9MB6duGVjz9bcCHg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yze40hyquB3ztYXU1TwO0S76UgYB9zGiBuBTS3FPhUrPpN4FdF3
	LLR2b7xHEqWFfO6HC4c/GV8xKr13SuaBCG2RxAOFWOCyo/mn1xKC4dKgGvsDdU4QOMNB0j3f4yX
	ydTUoschnI4CWpqunGauWDlhxHFNCfu94hYK5aP6fGF5P+0CQ3CxcOufhF9pdKojUJBDSXQ==
X-Gm-Gg: AeBDievmgLNQW259HS2IAFLHd6jqZbjDdajFbn1QrjFKFiYsNk44+OxFTfVKo5OJxhq
	yq4TqYvNJb4XkJPhuI2xJ63jEST7C1wQA6O2CyrXDLsglX/uS6diOFCvLPAtEtLHc5pxCoOzzrr
	eA9xp0rMDk4zdaDqm4/m70zs3Fed8Q70hJrgkFg5xA6Es4aOw0XqsY6uljt0qZyeW1IqVQgHzJe
	w3IPo+k+S7nqMqnRCqJXPhw47ezorvzX/1NlKa3SZQRPL/jcqX47dfvFbsQubpxSlnQOa+mUJjQ
	MXW73Xrj7gdHWoRejz8ZBqPlZQjSLtO780nl+nPwGsaQx96LpARTKzUQ5fC8XOPWPgEVIzS8Nre
	y5w62RjxfDJaRAaGOI3AX4bG2iX/dcRQ8kBowcQRgcoR6Mt6hYKchJDk0bEos+8vDFjBZyZRW11
	WvULWMTXq226x2wqFnW9Y=
X-Received: by 2002:a05:6a00:1805:b0:82a:1380:417d with SMTP id d2e1a72fcca58-82d0dbcfad1mr14887010b3a.52.1775533008199;
        Mon, 06 Apr 2026 20:36:48 -0700 (PDT)
X-Received: by 2002:a05:6a00:1805:b0:82a:1380:417d with SMTP id d2e1a72fcca58-82d0dbcfad1mr14886973b3a.52.1775533007669;
        Mon, 06 Apr 2026 20:36:47 -0700 (PDT)
Received: from [10.133.33.204] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b6113dsm14351181b3a.23.2026.04.06.20.36.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2026 20:36:47 -0700 (PDT)
Message-ID: <f970b6ab-63ed-48f9-a49d-06c172656379@oss.qualcomm.com>
Date: Tue, 7 Apr 2026 11:36:42 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] ath10k: Add device-tree quirk to skip host cap QMI
 requests
To: david@ixit.cz, Johannes Berg <johannes@sipsolutions.net>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Paul Sajna <sajattack@postmarketos.org>
Cc: Amit Pundir <amit.pundir@linaro.org>, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        phone-devel@vger.kernel.org
References: <20260325-skip-host-cam-qmi-req-v4-0-bc08538487aa@ixit.cz>
 <20260325-skip-host-cam-qmi-req-v4-2-bc08538487aa@ixit.cz>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260325-skip-host-cam-qmi-req-v4-2-bc08538487aa@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDAzMSBTYWx0ZWRfX05pWko3dDcCv
 lsXBnU6PvGZIH8/s3ngxe162VZpHqt4sw3YybIl3KjjOtYTH4KNXh1wRGXa3tAzemLObevmL7Y/
 gInF8DcCxq4z507i1D9XGDTJUOs2aOpA1oGX7T5HRQ1pkYv6kfjoC9ZwsssD4xtvqb/oJdRDcXk
 24djCg8ApfFr+R81dZ3cQ/MNg0HwuGjX+1RI8AyiFdmCZoEpSgpQC/Y1OgUtDLde/Zen438mHKz
 DtzqDicDomDg/xHctnvCcmHkGFF/1n+VYDeOPjfqNV38G5lbKzJLc9vPM+cA6sZdWFhOmb2764V
 yahZVhcaerDnS49dew1CRUCiVh/YhkZvrIazKBa48u8oMJrnCeSULJOGwR/n/CXbPfSI5ShnQWv
 gRBqOB6m8wqGRd/ZQ8Ns+xExw+8MVBfZwin9v4DIxvgvkkLkLq7PpAXElRfpYak90qMrRAmLOKG
 HibikuSYMfSfV2fa6fA==
X-Proofpoint-ORIG-GUID: _XskE9SdWLqoUejvLm91GwjOmAgNy1WK
X-Authority-Analysis: v=2.4 cv=WNZPmHsR c=1 sm=1 tr=0 ts=69d47bd0 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=hFweg1R52QcHjneruXIA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: _XskE9SdWLqoUejvLm91GwjOmAgNy1WK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_01,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070031
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34417-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email,linaro.org:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: CBF693A9706
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/26/2026 1:57 AM, David Heidelberg via B4 Relay wrote:
> From: Amit Pundir <amit.pundir@linaro.org>
> 
> Some firmware versions do not support the host capability QMI request.
> Since this request occurs before firmware-N.bin and board-M.bin are
> loaded, the quirk cannot be expressed in the firmware itself.
> 
> The root cause is unclear, but there appears to be a generation of
> firmware that lacks host capability support.
> 
> Without this quirk, ath10k_qmi_host_cap_send_sync() returns
> QMI_ERR_MALFORMED_MSG_V01 before loading the firmware. This error is not
> fatal - Wi-Fi services still come up successfully if the request is simply
> skipped.
> 
> Add a device-tree quirk to skip the host capability QMI request on devices
> whose firmware does not support it.
> 
> For example, firmware build
> "QC_IMAGE_VERSION_STRING=WLAN.HL.2.0.c3-00257-QCAHLSWMTPLZ-1"
> on Xiaomi Poco F1 phone requires this quirk.
> 
> Suggested-by: Bjorn Andersson <andersson@kernel.org>
> Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  drivers/net/wireless/ath/ath10k/qmi.c  | 13 ++++++++++---
>  drivers/net/wireless/ath/ath10k/snoc.c |  3 +++
>  drivers/net/wireless/ath/ath10k/snoc.h |  1 +
>  3 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/qmi.c b/drivers/net/wireless/ath/ath10k/qmi.c
> index eebd78e7ff6bc..e7f90fd9e9b83 100644
> --- a/drivers/net/wireless/ath/ath10k/qmi.c
> +++ b/drivers/net/wireless/ath/ath10k/qmi.c
> @@ -808,6 +808,7 @@ ath10k_qmi_ind_register_send_sync_msg(struct ath10k_qmi *qmi)
>  static void ath10k_qmi_event_server_arrive(struct ath10k_qmi *qmi)
>  {
>  	struct ath10k *ar = qmi->ar;
> +	struct ath10k_snoc *ar_snoc = ath10k_snoc_priv(ar);
>  	int ret;
>  
>  	ret = ath10k_qmi_ind_register_send_sync_msg(qmi);
> @@ -819,9 +820,15 @@ static void ath10k_qmi_event_server_arrive(struct ath10k_qmi *qmi)
>  		return;
>  	}
>  
> -	ret = ath10k_qmi_host_cap_send_sync(qmi);
> -	if (ret)
> -		return;
> +	/*
> +	 * Skip the host capability request for the firmware versions which
> +	 * do not support this feature.
> +	 */
> +	if (!test_bit(ATH10K_SNOC_FLAG_SKIP_HOST_CAP_QUIRK, &ar_snoc->flags)) {
> +		ret = ath10k_qmi_host_cap_send_sync(qmi);
> +		if (ret)
> +			return;
> +	}
>  
>  	ret = ath10k_qmi_msa_mem_info_send_sync_msg(qmi);
>  	if (ret)
> diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
> index f72f236fb9eb3..3106502275781 100644
> --- a/drivers/net/wireless/ath/ath10k/snoc.c
> +++ b/drivers/net/wireless/ath/ath10k/snoc.c
> @@ -1362,6 +1362,9 @@ static void ath10k_snoc_quirks_init(struct ath10k *ar)
>  
>  	if (of_property_read_bool(dev->of_node, "qcom,snoc-host-cap-8bit-quirk"))
>  		set_bit(ATH10K_SNOC_FLAG_8BIT_HOST_CAP_QUIRK, &ar_snoc->flags);
> +
> +	if (of_property_read_bool(dev->of_node, "qcom,snoc-host-cap-skip-quirk"))
> +		set_bit(ATH10K_SNOC_FLAG_SKIP_HOST_CAP_QUIRK, &ar_snoc->flags);
>  }
>  
>  int ath10k_snoc_fw_indication(struct ath10k *ar, u64 type)
> diff --git a/drivers/net/wireless/ath/ath10k/snoc.h b/drivers/net/wireless/ath/ath10k/snoc.h
> index 1ecae34687c21..46574fd8f84ee 100644
> --- a/drivers/net/wireless/ath/ath10k/snoc.h
> +++ b/drivers/net/wireless/ath/ath10k/snoc.h
> @@ -51,6 +51,7 @@ enum ath10k_snoc_flags {
>  	ATH10K_SNOC_FLAG_MODEM_STOPPED,
>  	ATH10K_SNOC_FLAG_RECOVERY,
>  	ATH10K_SNOC_FLAG_8BIT_HOST_CAP_QUIRK,
> +	ATH10K_SNOC_FLAG_SKIP_HOST_CAP_QUIRK,
>  };
>  
>  struct clk_bulk_data;
> 

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


