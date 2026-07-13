Return-Path: <linux-wireless+bounces-38927-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HJ3dBBhJVGrikAMAu9opvQ
	(envelope-from <linux-wireless+bounces-38927-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 04:10:32 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A477468A7
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 04:10:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=hHFIh3rO;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=ht922Amy;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38927-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38927-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D97F4300A8FC
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 02:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7277A2DA765;
	Mon, 13 Jul 2026 02:10:23 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD4D2D063E
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 02:10:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783908623; cv=none; b=MQMl7OEXbnKpI8EQ7E/VjM7Ai/9w1xkyS7Mv7c59PJHgig4NRMag8EhbRNtYITmjzHX9q4qXy6chvqO4a2ZQRwi/U2pIriyhGOaiimAKsyoQntIJY6vTYMC1DesFLvn5mFbwvOyBn2HGlnteMh85l/ixayr2ucFW/+Wf2Uekyww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783908623; c=relaxed/simple;
	bh=aadSqNyFwReSJvQKhsKuOeZcMML6g1Iz9bnlDslIdyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cQuxVymwTnOzHECaphKxaEF2BVWfQF3Z8wKpSwSRrZhgLcG1jIsJUA36CzPQd7H9CEsh0xbTZ1msYY2p2RS/wFQYdozkJ0xIFZ987En6buLLSm1HkEtFmGMKPD37xAr30mpk5TzRd8hBsRUhNJU3FiN/yXwuxaVAHG1N83Wvr+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hHFIh3rO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ht922Amy; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D29vld4023417
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 02:10:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9XWJCEmyg6DWuWW7UHemBUpTITGGMRo7lHibMGuTIfg=; b=hHFIh3rOSrct0PJr
	F+W0yKaCvkkxicIF1Y3ljLgUnYNdTzlK2lKLI1dTtwI1vYL0Y7XUs6lDplN5EbtK
	dZh6/7ynWREaeY9rmRTyfylLPxkXDvRxCBCdwmA2jantwRPOGPFIB8mYojlQfT+y
	Zho0Dem3uck2i8WGncjmwEdFI1n7DU+CDoCZgqFyOcJuV1nQ5bDVlGWDWuDCmtvF
	y2C+FkJQeeL9A6Pkdvdgcyqcd6bnsRVyTnzdYJAroP23NUCl0C9AIzxViOJqafVr
	5c0JfeEDfLYT60mWqFkmNJD/eT9Ck9F/lTI3H/vNshVZpNyE0XPDOvl2TKDG/LVN
	NYQUWQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbf0gkvdy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 02:10:21 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e095fd889so170723a91.2
        for <linux-wireless@vger.kernel.org>; Sun, 12 Jul 2026 19:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783908621; x=1784513421; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9XWJCEmyg6DWuWW7UHemBUpTITGGMRo7lHibMGuTIfg=;
        b=ht922AmyNslvKSbItOm9W1EDV5C8//Tp7xhxeD3lq8JgXAdiU0+RzlKFzyG80P01Un
         KWh+wq6xGvJfXQniAzYWvJIxZ2OKnKSdGggwR2f/m+31AF4PopyTUm088kO/lCprtpKk
         yqQFYLF/dvrSXhPDVFuvbbee6WtG5XFS2XvR58W38eMrwEDRKLGhg4wu8SEghQa3yIh8
         kHACQG8FYH3PEiV4jLfJrBocAL0WvsnHTw7ibnon0inUrTjeNbbe0YjUIgN8stIf9SIr
         5eT5X1EuTt+JXJXv8QdxpbgF+NkNoh59DhWlc78kclLOCZGRNj/sBf74RqptEpQ363c5
         ZXig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783908621; x=1784513421;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9XWJCEmyg6DWuWW7UHemBUpTITGGMRo7lHibMGuTIfg=;
        b=aP4G8fTm660i2zm33MnKC+Kum+hDc2SUrKChb4nUPeeE5vovSThZPL02FjOGGtozDz
         N70Lv0liTN2+IvoSiuZOx2PQczQBxxiHHIf8PpvIXcqPQDvkkNa/ZB0fEGcLER8oA2fu
         DpoPrzXNVHryftz15yTQuKyEqZGlxThq1TYnZgN21faB6Aj54dQyKM7w4DusM7HPO4fL
         tMwN7GCTpx3vpW4yDjX5GWfrhwo0hofYXufZSk4ZX5MjBjQuXrNJAwve6UsTt+sGGnet
         jTF27WVLz6/XFZwQLGIS3Tl28mikLZggiIq1+0GTFq3Evt9W0oT92MzZ+pcY0AKQOMOx
         XSGQ==
X-Gm-Message-State: AOJu0Yy3licLx91AsbE7lP2VNJYJO9IiX0WErgOmUAm4yiYLEcN/Tj/Q
	r+GXRgQLfygydeiJ+gVT2hh7wIL/GYd7dhBmMyy7NfKznQXwqxHoQB6fOccwm89FgBojAq4+a/T
	KHLGX6sNmPnDEsezdbpKCqKj0p80zrMIRqG+w+hMihyz/Sb4A30I2DpcaNGwIpzLsCXc+Q0+4/T
	Nj40sv
X-Gm-Gg: AfdE7ck7Q+0/TGyBwbMjKVZKbRi1goyCSYuG5C18xALXu/Kciai2PhQeOuZHox2hSBk
	TZydwKF0jNXDlOdRO9S2uEZcbMcZ/Tyv0L9/VbJhmrArqK42uHSFpSr/rB5IypuM7TMpbN+s8Kg
	6eiDIjDPh4Z+XV+eGdqH3L8tBDEgnZSFlate6YLiARLD/E/DC8u4HJuSbCmoDCL65luxMNv3CFw
	hiHAbIAufuKWjtn+Zx26Ai5agW+X0/zgehC3RV0QIxniJnvaQxvMvljJChLNhy2Ug5LS6AWwSzT
	mcpajHzac4JtmhF+muiRU4N1exMzKklLcdhv3y8iKM3jHW49DeVCwWwmhaT7gJ1v9Ul2dcLLn+v
	hD1FXwdRTcRwVb6mz9HLT/tfL/e9TqV0c9jEMYp4hJElcxD8rn5lmRR+iTkp0zwg1JominJO3G7
	IdcQHtjro=
X-Received: by 2002:a17:90b:590c:b0:37e:1bc4:b6ae with SMTP id 98e67ed59e1d1-38dc73bdd28mr7221916a91.8.1783908620764;
        Sun, 12 Jul 2026 19:10:20 -0700 (PDT)
X-Received: by 2002:a17:90b:590c:b0:37e:1bc4:b6ae with SMTP id 98e67ed59e1d1-38dc73bdd28mr7221901a91.8.1783908620341;
        Sun, 12 Jul 2026 19:10:20 -0700 (PDT)
Received: from [10.133.33.33] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38deea72fc3sm591084a91.2.2026.07.12.19.10.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jul 2026 19:10:20 -0700 (PDT)
Message-ID: <fc273a69-d7a9-4c8c-b348-ef8755699c49@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 10:10:17 +0800
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
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260711-ath12k_wifi7_mac_op_tx-line-length-v1-1-10e4899b98ef@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Nq3htcdJ c=1 sm=1 tr=0 ts=6a54490d cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=jQJT05vtNkZUjgOhBCAA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: KjlCCYrU1pHLn3B0PDARGmeKNpCDOEA6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDAxOSBTYWx0ZWRfX8DXIBjN7stsJ
 aEJxLkUKrqDHhGNgb/JwiMt1NCORY7DPSeKWKfo6v+wmJSCLtthECbZutYuaG8M6HmunZW8Z5Bm
 fQdt48fQKGKJv9BhP8uLkFZDOdB9OOK/IsBkN6ONjrNvm/0Y6TLO3SltHCzOcStvoUkrhGIcipS
 1D576wvShjqUSFq2Wt8x5C2jeaSyrX/GzMfKxyJHjWqmr99aLwTFTYFznmhsg4AkLTydOYIwlFd
 lbg2YUObeCfVUXUrUNOoD32q5RAQGIyGIVnNE6SO6OhsFCfGJ2ll3WWomkpySVkbJBE4chXLQfF
 bWQfYWF4vqYAUHurWWHwfGiUTJtSfBDStO6g1AL6clBndh4ARzqPuk+mi8OJQEgzfNUAiGBGdOZ
 w5t66DSzlbHD7VB8JuO0Q6Cd0sOkqDIwJHJTe0z3VrptBtBSkJRZ/peOpt+XUrtB2Gjj603yyjA
 doeJVVY3nOVRhGlmWPA==
X-Proofpoint-GUID: KjlCCYrU1pHLn3B0PDARGmeKNpCDOEA6
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDAxOSBTYWx0ZWRfX56JiUW3ON9cP
 WYZCw0yPIjZWmeJRCQjofm04ue7XslBY44F47+tgOGIFVUCJ9LxwKW5I6uEPxsbJMJGBi7w2Z1H
 YNDKkamKl9ula4IwQo0YBCAxldj3CYk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-12_08,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130019
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38927-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jeff.johnson@oss.qualcomm.com,m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,vger.kernel.org:from_smtp,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
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
X-Rspamd-Queue-Id: 61A477468A7



On 7/11/2026 11:31 PM, Jeff Johnson wrote:
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

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

