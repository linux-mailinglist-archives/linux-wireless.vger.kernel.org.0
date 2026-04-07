Return-Path: <linux-wireless+bounces-34413-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MtMBSl51GlduQcAu9opvQ
	(envelope-from <linux-wireless+bounces-34413-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 05:25:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A77CA3A966F
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 05:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D75FB30059A9
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 03:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFF73612D5;
	Tue,  7 Apr 2026 03:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Dx7ksPEQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jSbm7LLI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0642DDA9
	for <linux-wireless@vger.kernel.org>; Tue,  7 Apr 2026 03:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775532325; cv=none; b=XtCHDuiPwUNVSrk6q14NIKx3c4+Xoqk5Ww6t5acC1K9wPYCMWH/WQDV5UJagX/eAbs4z6wIKH1z8cgvPicXap2BOK6euhWZk3XMr/zZv6xm6gtM5sAjdtX+iKzvqEyDoL8Akddb4IEDnzVA0WUy/aowLMItJRGXOXJSRC0g0IRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775532325; c=relaxed/simple;
	bh=6a9HyL131ZlGHlYasx1Lxwt+OQ7lQcXNO2hQSy9vCXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QHjOSgoVAeW0Rwl8alhShLWHw6tpwXi/JFj7ZETi+kwG6S7DtOJlUXmWBrT+pwc35LL23p5wA0O3y9NKiDbyyOtHyHIaUNBFEPvuZlJHX1DUFi/y5dMx5wiL6zyznK70fitw1FUkxHSSSexoUwgmUCQ7VbaqzaXy5S29lRFzERs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Dx7ksPEQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jSbm7LLI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636LQS782550321
	for <linux-wireless@vger.kernel.org>; Tue, 7 Apr 2026 03:25:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	b+E0zzEKdybd0FhWJhe4rpTtHjb1TkhRmXS5TeSU5yU=; b=Dx7ksPEQ7jGDCOr9
	pq/sT/Z/4PUTo+ow7nxZDbiE+97K9PMkjlWa0n4+z62vZ4Kgzn3As2hpApol4J+y
	4emEfdUtO+glSmAkHKfpNDWCfpF7jWFhWPJf5I+uiIZMASmysAaoKzNkxdiKMxih
	B/DgxE3eN79xgd51LQuU9alt1iTDL+fZmyi8Ya8C6RWC2rsd28Sl7S00iyMr5qVE
	W1EX7gZxss9JtvH7ehW3RwiotbUJrssAtcoXc5pPaeFuOVVjsAjKKjbKJxPswTcW
	PkdFcWDkMiOE4abKxlqBwsY+qPe3fzsFGsj6uPmTXZ0erL6uVOMR81bDZWLUIZ/d
	/VBVEw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmre8tkc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 07 Apr 2026 03:25:23 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35d9010602bso4719464a91.3
        for <linux-wireless@vger.kernel.org>; Mon, 06 Apr 2026 20:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775532322; x=1776137122; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b+E0zzEKdybd0FhWJhe4rpTtHjb1TkhRmXS5TeSU5yU=;
        b=jSbm7LLIbOUzwulIIPSF6nYM4TimPQudYT7qh+IgQwW3SXvkkL4fRW1SysF+QVRUl3
         g7fzD3LfmAnOOGb0Gq+7SEFd6pxUEUjzMU4ljej7GR6K1GqWOF3guBiej89IWxcMcP+1
         xDPW0I+9tSbhYhCtbLKu+qPFZF/uJO4xvfNF8Kn8lKEJPpkROMN0QRcTkqRbOw824vbH
         KQZRbV074L8Fg3Q6PqP0xCUXoXEU+4uu89g/49IWf8KdyGk6gpymdfcdC+/oCg81inv2
         oSfv6WeXajSzJsuDs0q1d3X0ZHvhybHbs9+40EGCYkC22mLifrkfJ3DTwnpQSmB5EZhZ
         SbuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775532322; x=1776137122;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b+E0zzEKdybd0FhWJhe4rpTtHjb1TkhRmXS5TeSU5yU=;
        b=ceiL5ADfnhwNy0+7D7hWBz6XRw5kKqbS9mO83eVrlAkM17Ot3ZVjLoayOTlqZqG356
         0x9LNZj2BuyF1PDpDJiI2n64g2DJNCq82q6YwWrMtN8+ShB2Q2v/7+saCGvXEp3TOL+v
         toVfb6XdpkDtr8WNTMPNEfkpIlMH7TvolaRWgicgexXv/pqQcu8HGQ68AJWOUoUskHsd
         kw3ujTYQe63HfhFNNwsXUCNL0RlrRnj+baRHj777a9dB1O6uZFrlVXJVt6sT0kU47Jgk
         h2WsQd2mCdMJpB5QEQUGYYzqMD4k2+8rNRvmzNZGtOZWS2nWCU/zcmtSLL0tdwJn3U66
         vxTg==
X-Gm-Message-State: AOJu0YyP9MPfeJiv7P+R9KmSowvQU6/ehQ1YCn9APXf52ESbsP40eLZw
	w8Pug0DATqsfqGlj+1OiZ5R2FFE093AWyfmGyvWWEsHdSlAvNeoUlJx4BkEeQntkSzRonecLcHV
	d5/Ys5+534cnVFz9ET1sKaogI916OQJBPECkXOecS9t03mfd+WbBcDXda4dXrAYNQrqJaFpMMqs
	cm4x5o
X-Gm-Gg: AeBDietwbuFH7XYT84WOjeatvoQJ3IGhO0Iu1pFB0dS/FAZqKEX6x+3lK7e88McPDL0
	b0Ye/jtY4scsYJ28/aiqOTnq6hW//s2rPkfX7bJjb8ptQfgB7dCFePR/8eUBtVRLmHJtdWPz72h
	okcheADwQcprlWDkqWjrBLW4C+wgAhJrmxAcyxxnvTTSFPJ33zsVVCc8T01ewkB0QdNeL2rePsJ
	Vd5IuHYZnsojo9/czIebEw8ILVUvmnvMZeXKSeRUU/U2sJFwLTRgh+Zmk6n/PzAa+8O9ew1MCP0
	4zhm81AmZlZ2V0F24fiTxCqsnQTqhfQfvr8b83n50eROkv+6f1ykLmmPCsauWrS0b/vShAHbImH
	efy6A7et5xyuuqxRHUSgJfwlHuqtStBB40eWTG+4jGu3UV3wtDGvdnrVH8VCcgRScvG3E29DPsJ
	fNxPVJ4h2nDBsJM8Ye1CU=
X-Received: by 2002:a17:90b:17c5:b0:359:f0e1:f8c9 with SMTP id 98e67ed59e1d1-35de678f2bcmr13245069a91.6.1775532322271;
        Mon, 06 Apr 2026 20:25:22 -0700 (PDT)
X-Received: by 2002:a17:90b:17c5:b0:359:f0e1:f8c9 with SMTP id 98e67ed59e1d1-35de678f2bcmr13245052a91.6.1775532321773;
        Mon, 06 Apr 2026 20:25:21 -0700 (PDT)
Received: from [10.133.33.204] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dd36a1d04sm19993403a91.17.2026.04.06.20.25.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2026 20:25:21 -0700 (PDT)
Message-ID: <47e60bbc-c707-4a68-af33-2cf2fa6ce946@oss.qualcomm.com>
Date: Tue, 7 Apr 2026 11:25:18 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: Skip adding inactive partner vdev
 info
To: Roopni Devanathan <roopni.devanathan@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Avula Sri Charan <quic_asrichar@quicinc.com>
References: <20260330040732.1847263-1-roopni.devanathan@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260330040732.1847263-1-roopni.devanathan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=OKEXGyaB c=1 sm=1 tr=0 ts=69d47923 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=RQiAibkc-cMzSS9pYhwA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 6K7kaGSeg11-sVGAyqbwnT3frwbzH34r
X-Proofpoint-ORIG-GUID: 6K7kaGSeg11-sVGAyqbwnT3frwbzH34r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDAyOSBTYWx0ZWRfX+xAKW6JPvvAU
 pL7tUGEn5lIIVWs1Ail4PcNHGbyWEZBmK/gOEOUIwz1RrAoiDLoVqn7dX5cWyMGjh3Up4UAVbuf
 GJzNlPJFUI8l6dll9VBVM+6b3kRxx8t5Hk6i2wqCDC6BLAbjiyI4Iqx5bifskXLwnbUJywBCeC5
 3lEd92ztU6L6OOL5yrQfwqSjBZS9muje8uToY34L+CJM7T8gzSdwzXpCsKiblOgcgS8PfbcSXWe
 TWUgf8GirgoSzVUKFPbjjhqmbDCHwUVK23lyt6a+E31CNyWGS3nNKaRp9IE+7cMrEcO6r01oeFx
 4tRQPGT7iaA0iadpraCPYreHshfF5Ul0nM/cTNzNkHAppVEpQmVhN0vKDzOxwoTrwdCe/VMzR96
 ga5sGIIdPbJkbq6I9bon22TMUbiMFBV1mn5C+4TOo2r9U6f8YdAD1guy3SebyVWhiv27GqtNKh1
 SmFmvRg7mB8+qFJu9/Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_01,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070029
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34413-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A77CA3A966F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/30/2026 12:07 PM, Roopni Devanathan wrote:
> From: Avula Sri Charan <quic_asrichar@quicinc.com>
> 
> Currently, a vdev that is created is considered active for partner link
> population. In case of an MLD station, non-associated link vdevs can be
> created but not started. Yet, they are added as partner links. This leads
> to the creation of stale FW partner entries which accumulate and cause
> assertions.
> 
> To resolve this issue, check if the vdev is started and operating on a
> chosen frequency, i.e., arvif->is_started, instead of checking if the vdev
> is created, i.e., arvif->is_created. This determines if the vdev is active
> or not and skips adding it as a partner link if it's inactive.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01181-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Avula Sri Charan <quic_asrichar@quicinc.com>
> Signed-off-by: Roopni Devanathan <roopni.devanathan@oss.qualcomm.com>
> ---
>  drivers/net/wireless/ath/ath12k/mac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index 553ec28b6aaa..c1a1b220f4dd 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -11131,7 +11131,7 @@ ath12k_mac_mlo_get_vdev_args(struct ath12k_link_vif *arvif,
>  		if (arvif == arvif_p)
>  			continue;
>  
> -		if (!arvif_p->is_created)
> +		if (!arvif_p->is_started)
>  			continue;
>  
>  		link_conf = wiphy_dereference(ahvif->ah->hw->wiphy,
> 
> base-commit: 15551ababf6d4e857f2101366a0c3eaa86dd822c

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

