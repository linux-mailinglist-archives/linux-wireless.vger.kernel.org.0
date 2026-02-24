Return-Path: <linux-wireless+bounces-32151-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GI4LCL7snWncSgQAu9opvQ
	(envelope-from <linux-wireless+bounces-32151-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 19:23:58 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BB03918B50B
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 19:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2CBFF3057647
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 18:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656852C21F2;
	Tue, 24 Feb 2026 18:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Pps5hXlt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bWw46EJD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16C53A7830
	for <linux-wireless@vger.kernel.org>; Tue, 24 Feb 2026 18:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771957379; cv=none; b=oSavtecJdXNXvvlL5Jkf+Y1i05U/XPLm79LXIMVt+Bailqa0LQY72ROUkUeO/CcxRS52Xy/h97g5DZpCJI1HgVptqbfgkliopIINmDomOAJcDTPbY9wpYVDeL1y45fsbxfWDbu/VqWiXu1mGANXAosxbWUE1VbTrHlgXA7e12ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771957379; c=relaxed/simple;
	bh=Bwe7RYtOtESsNmfYXYuQQdKSmhDLq+U43rTZ3qeAzlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k379UjcyPr1lu1hwQbifWejEZ/QmSUrwU5E89NhyE8TmgKvNvvucrCZG4/9Jvn35vVOpLzf3s5TZIkdx0EIN6l5olgqnV7NX4YqPYKYmsbeGaxbGv2LPlAbJ9NZHWBPZNQ9q5XMMdixnqdK8fBod5sd1ItvfM23pqzhk5rCkJUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Pps5hXlt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bWw46EJD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61OHDYU62220821
	for <linux-wireless@vger.kernel.org>; Tue, 24 Feb 2026 18:22:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ofaxOgMTcREZZ64NC12A3zFQ8J02tffDVN9hDMPm/kY=; b=Pps5hXlttlDBCUnZ
	JbYz2yOBpPhhpqqww1DKUvESdri7rVb5rQxsULSZk0XAGNJFdMjITPF+luYP2gFm
	p2sLhwPh1aoN5e48L4cNBlYAE6kMEqf/aLAi7mAh4vXHG9u3LJPznk5wywMJNIh/
	4pybzG5Jju+6bVBvJ/nnzqDB55Y4wpcGBU44yd/BQc3Uyrim6GMPGRwl4EAlALNN
	+KKOZKvE1DgzzG+PQvnW0PgYGzCqHtBYV0o7gGyuzlR2+743cn3pCLeQqRAw9d3n
	HfeXqCAeZPSxyR2E9dN5hbeSkcDgFoAXSvb3taBSvQ9qNiqTackvox/yeVwI0Xx9
	3xRBVg==
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ch4e3amnc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 24 Feb 2026 18:22:55 +0000 (GMT)
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-67999892f00so89127812eaf.3
        for <linux-wireless@vger.kernel.org>; Tue, 24 Feb 2026 10:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771957375; x=1772562175; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ofaxOgMTcREZZ64NC12A3zFQ8J02tffDVN9hDMPm/kY=;
        b=bWw46EJDIroq7BxM/5z6rjH/cs5JPj7DS38Txjwls9LAw/Dkz+jiIdyZ98dSWFW0ed
         drsIbwkncSNcH47NbyRzHFcG1fFdyz2qNwEQs/ZjiaFxNR1dvPYM0WcaYNqkSXHYbgCN
         GdBi9mYa1KYMUJcy3sDk1DptSwsx6fiUTZ0HqToZpcp0ye9umKnDgqFwV0iAPJDlO1QA
         Hf1MTYE9gWEbVZpWQgBi5P8DPeSOlWBcc2oJm4q7Y6tNbrabac/0lYxtl+GbervgXC98
         +DwJDIJ8wTGo8lUDeBc/oKw1EcUogmagNk+zqf7SWEQYluZp58O1rnAVBmASeT4RNuZ3
         uV4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771957375; x=1772562175;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ofaxOgMTcREZZ64NC12A3zFQ8J02tffDVN9hDMPm/kY=;
        b=lI2O3V8mfEROxAr875R2t//CzzQl5gNsb9n5cJKPN+ZtTxnVo08aE8cdsvPcEaccAq
         Ka7t5rVWH6zQtYfXQFilRQo4EC1o6X6m3/kzD1vauRNv9ZDUQo8qKPio+Z0tUm4cTsWS
         7M+lwDgb8vEoaPYLWuo3AHcyj/XKE/KoEMucm794nD8LpNT2dwyg0OsAKpQbYupUAk26
         NAZxX8e7cO7EE6VW4ZwbSo9StlfdjMGLKIplX4Qe1hCuMN/1fMT+s4tL5PoBjNw/hbFE
         HDmkQftRGJMJII8mpF08z2gv2Gor55E+7J5PI+32vB+Ny26YIblrStlP9zxyCiJtckMe
         IIYg==
X-Forwarded-Encrypted: i=1; AJvYcCXfwbn7zJUso5uKjweWIXZwob4eeH+vXQfdS6AW+Nxh+s1Q/Rkwbr0Rgi2Fukgvie01RgyUCPztsnjCRjHWog==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg9hbfA4dPlA523Ljhi3duM1gy76UMqygCpId3MSnCM2Cytxwq
	V8F7QxNfrsiC9FP4JQSPR9gJq28PgFVYGc3cM/1pCjvDfxyzhDZfhQ4LKvnLHrguriV/Ugh2AAY
	cRr9D+ssHlR8Fng2IXGQb4OMaOP1VYM3/RyVGnjZ+G+Ik4+3PHbMAgYlBRcXCEaquHK6z6A==
X-Gm-Gg: AZuq6aLW5ZVIuqniMjjTRg2iw7DnBHT7SAIZeI0iRvX49OeZxfR6/sdk0+SjsQ+oT61
	Hd0ZmMAJVW13uVK3Mb1XS31D/XA5wY6sAa0fFCbE/ZsOJwTnDhyFLB0W6IjfP+V3kseLt1GUKu5
	88FNEObPHaJhNtM6tekbYLjNJ45yR0Aq/x4f/EKqhB39hgqLLNvh3OqFUoDUll/6F0S9+ZUm8i/
	9s0V6olArdXRqDOp6ct75bTMynQ9gZGD7nqvCtakxBt6rQS3bq/SVRzEH46yNG/UU1zkGPZKZAx
	O3m5PxzyuIOL3NzdOqMIVyfOK02sFAnH8u078F4WJj265dDHBq1+iNlhGILdn1pA/o/gRPKSA5p
	Oqk1yqTh6YYfvBTsIz+Y2rbpTScNWab9JI6RnPjtj+pTmLqoM5Xf1DYkr18XMnZlJ5IAOozLau4
	9Kf3XvrQ==
X-Received: by 2002:a05:6820:1998:b0:677:a19a:567 with SMTP id 006d021491bc7-679c4611ca8mr7253511eaf.66.1771957375028;
        Tue, 24 Feb 2026 10:22:55 -0800 (PST)
X-Received: by 2002:a05:6820:1998:b0:677:a19a:567 with SMTP id 006d021491bc7-679c4611ca8mr7253492eaf.66.1771957374660;
        Tue, 24 Feb 2026 10:22:54 -0800 (PST)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679c5644224sm8900156eaf.6.2026.02.24.10.22.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Feb 2026 10:22:54 -0800 (PST)
Message-ID: <f4951f6d-ab1d-4396-9e0f-81a91ba778dd@oss.qualcomm.com>
Date: Tue, 24 Feb 2026 10:22:52 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 2/8] wifi: mac80211: change public RX API to use
 link stations
To: Benjamin Berg <benjamin@sipsolutions.net>, linux-wireless@vger.kernel.org
Cc: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        Ramasamy Kaliappan <ramasamy.kaliappan@oss.qualcomm.com>,
        Benjamin Berg <benjamin.berg@intel.com>
References: <20260223123818.384184-10-benjamin@sipsolutions.net>
 <20260223133818.f2ed2b718c41.I4a2d45609e94b52654b10ec572e59a45d09c41f4@changeid>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260223133818.f2ed2b718c41.I4a2d45609e94b52654b10ec572e59a45d09c41f4@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=DfIaa/tW c=1 sm=1 tr=0 ts=699dec7f cx=c_pps
 a=lkkFf9KBb43tY3aOjL++dA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=1OzSKncyFfgkNOlj7OgA:9 a=QEXdDO2ut3YA:10 a=k4UEASGLJojhI9HsvVT1:22
X-Proofpoint-GUID: Hcke9eZGRcn7XmaLwK-KwiGFxjzZ1rs-
X-Proofpoint-ORIG-GUID: Hcke9eZGRcn7XmaLwK-KwiGFxjzZ1rs-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDE1NiBTYWx0ZWRfX1tlAUF+kthNA
 CveBmRWSbtLQXqf/cM3+DdOpF8oK6gimPBRq4UrEPBZLEHXXXB7sGxHj7cK9ZmZ7r4jxbClcZdL
 K10SfPrqKctlH81fxuA3B6VvRGL1tHMoZ9g6HaK4iu78VgG8RU3g9Y7+zzQ9tyf5Cmhv8HqhPnS
 M0hJoPHJH5/zfB7B9l2xCCeKNd8SGqcve0bqPigmYkQIVGcexdSbX3j6rVj3pdYNnR0jJf85g0m
 LgGBa/ebPGw0usJ0EUvgdYbldOrMiPu3NHVT5CFj4XYnzi+OTZxhMnk1ZrT/+/eZvBoDiNHnaDk
 mqUE6dtNqzSbv/rqawlVs0rJ7BcVF0hO1kulo50eTjy13L9sk853qxLv3gcFPxqOuN1UQn6z6v7
 BrXMCGQLVBk0eHmS+ZPiKaqtrySvXdenJ6yDhVApwu4yLnXGSUiGujZo8N0cSBYs8uX2IgLkSca
 lheQwlJ5amlEKoirhSQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_02,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 impostorscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602240156
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
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-32151-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BB03918B50B
X-Rspamd-Action: no action

On 2/23/2026 4:38 AM, Benjamin Berg wrote:
> @@ -1340,9 +1341,14 @@ void ath12k_dp_rx_deliver_msdu(struct ath12k_pdev_dp *dp_pdev, struct napi_struc
>  
>  	pubsta = peer ? peer->sta : NULL;
>  
> -	if (pubsta && pubsta->valid_links) {
> -		status->link_valid = 1;
> -		status->link_id = peer->hw_links[rxcb->hw_link_id];
> +	if (pubsta) {
> +		if (pubsta->valid_links) {
> +			u8 link_id = peer->hw_links[rxcb->hw_link_id];

nit: Missing a blank line after declarations

> +			link_pubsta =
> +				rcu_dereference(pubsta->link[link_id]);
> +		} else {
> +			link_pubsta = &pubsta->deflink;
> +		}
>  	}
>  
>  	ath12k_dbg(dp->ab, ATH12K_DBG_DATA,

