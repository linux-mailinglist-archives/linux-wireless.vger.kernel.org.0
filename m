Return-Path: <linux-wireless+bounces-35429-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGzEBhcW8GldOQEAu9opvQ
	(envelope-from <linux-wireless+bounces-35429-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 04:06:15 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E8D47C9C5
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 04:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E62A03022AB1
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 02:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A79351C34;
	Tue, 28 Apr 2026 02:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UsZytqrF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kaCwxbm4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63F732BF24
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 02:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777341954; cv=none; b=FRKzvjs5msEMBSKOmI9QXUxmvMk4BdI12LNGtN47f9p0W+QDbId/gAmzy0161vzAxB5vk/yX7qsf0aywpdpc1W14iSeLOg5aRcTSWEDbZAsT+MMUqHcRWQ0BohNpTYUlVZMF2DW0FtHdzSZdq+BT66rDDs2IHCUh87YADGgF7OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777341954; c=relaxed/simple;
	bh=2hhwXirIdVQ7AOLAJsT7xoc52MI2ce7Ub4Ea6KE9IH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bLt55yUhV0PtegdZjBHAGlxY5yet3EtR9R5/alg+h9UvdO9PAjsk3okH15APhfM62OVxDcbQSekkJZ6qk5TeSr+QxW/aOqbFU9zBhU9SVH+T5LSh/XR4Ym/7nkglSJcqi+gQpcKEEn2pHNHqcy7okCI1Hpt1858k9/Ax9EMf06o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UsZytqrF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kaCwxbm4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63RJ3cwn2112686
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 02:05:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4wVcCD4RrGGxb9mwsikZgQXgvSMM4iURlDffudqtC14=; b=UsZytqrFzA0sqWAh
	lpUP7lFrvxx4cQiYL/5RiioKPm0Y2iE85nfJHVJESwSi+YSi/Bc3VeDY1xe3OsMK
	xq+3yZFSl5EpdQtU5/aVdUl0pKt+8s6IiMHG3uCQIkF15LbqtyfoKHSKMY+uLprS
	lKYov9CvcGlMwkptqlDkYDN6ypmBzw3SOtul0ncatRnKpxl1+R+TJTNhKTtP3oHc
	7c7GzYoADUE0j8paznsv5PVonLHe2rfcrLRSWCxThUFCVhiqU4S512KLruL6LWaQ
	4oBciUn9oZB7PMoVTIeGlSGDXWQeO1P73VEqZA4knjxVoN1ctM24rEWwh5kZ73Ne
	umypBg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtdmbha2c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 02:05:50 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b24308165dso153872105ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 19:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777341950; x=1777946750; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4wVcCD4RrGGxb9mwsikZgQXgvSMM4iURlDffudqtC14=;
        b=kaCwxbm4hOy9g2tIwrWp2HarGDOioOpCP3oDPnh3pAEIX4BtF1qLoFU1aA474ZebYj
         FnB6D0fg7Su8dOwtjJNAuCTWy2T3dYC15gVtKuCw8revEJxdJYiTGVZbS9bEdOUrcq9G
         zcVgD1i08zYa4nFggoxE6hEb3Z68aMH1SjxT+bLPbmBFZF1YsE7qqjWCqGSKczNpkZm/
         q8tShXC/U0yAJ37YBwIpBAwcZS3LjwRL0PCYqJBBKpFC3TBNDvNBKP09L6rVRaOUYb6y
         PGo2in1BWtIaurYx9ZOyBZEtDIs5cveWkrErEVNEgWVAEhkIbSuTUPdae6jYSnsj1Gpw
         3kWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777341950; x=1777946750;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4wVcCD4RrGGxb9mwsikZgQXgvSMM4iURlDffudqtC14=;
        b=WbNCpJB+4plIQ/sSJ7OLM65NLdL16aWuCETX2PR+D7uIgAcyQQ5fnWiPw6Ib4I2Mwk
         N/zcvcOIOiJnKpr0DrHrWnXWb8BFKBGIkKyllu6VJLVEiQ/jtCSaPmFd12GyF2Ly+O8p
         2jb9J6TK297fG1c2Nf6QXJZguA2TCyZKA2+wuTiwWTaUyflb3VAISXG67Aw32w+RWg6Z
         5a97B4ubO7eayqpNvM10w9dXB40swiKDYVC6TeCgAQZl5Jrt/jRo4ldVfvV7U7g28+Zr
         ORssWFNvsy77ooo/QlMVIkfIhSlG6FhQMEpPzjDHi+nVUe9H4rhkQlSWetGflVufO1l/
         DZyA==
X-Forwarded-Encrypted: i=1; AFNElJ8PlSrpaY+bwNYPgw6St2mklZSjkx6lVXCx7vXXpFYGDlOjCiwF2+Bna6OT0Jq7uV0WRU8Soj1vWcPH2MGXHg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxnYJOdANr7oVsGIWX+WB5QURiVblR8H/K+7SqD3rz4sdwmykbd
	LSiqC/yD+IYn8xfKV0HAmEgRXzLuDvX9UAFQvzvjLLKJhx33MttZ1TW7cH89CAU+1m+QsYQuW8J
	Y512PLnNS0lxaBN94ePoB48ik9xeGq+Bye3tF/9tI4/A0Ipgt+0VANq4ivE99E6CzCIZuym0mep
	NNmOUy
X-Gm-Gg: AeBDievDg6hiPie3jPwyOQI6KwropM5+OzyLiTp8qg2qVj17GsxZ32VEhfgZu0cNb2p
	99Me959oYKwGFp+hi1j654PwMpZmhY5meC3xdrxu1Zl8QhiZt39NzjY22GcjA3Gm8H2gbzOmPY1
	xY1abM2Ukn5EPJ7jb8ps7E3RDpiC3elPjc21PK7xJ2WBFeHQMfav1gFj/iTj1lLp4q08KHnmzoZ
	HtkCjgNSKxF00vxMS4BcnpwIBCRgcbUxGd3anaduq2DoGGSdZQ79tpbZV4RUC8q00XjGM0sZUT8
	ZyEIvnhtSCm4S+Ct/RgosD2hTMf1J8aOJi1OGD38kxuuJWSKtnLIaC61Q70q5GthI1CRpO2BKgy
	9PupZTnp5BqVZiSH1yxdP98ABEwe3h97NOkP3rGsIX804dk/cowz4hb/D9yTtpjvsojS/8A/HYz
	MB7W53HWhhlDYkA58GNYIKug6gNuiVSg==
X-Received: by 2002:a17:903:2acc:b0:2b2:4cd2:e162 with SMTP id d9443c01a7336-2b97c48d869mr9555875ad.34.1777341949775;
        Mon, 27 Apr 2026 19:05:49 -0700 (PDT)
X-Received: by 2002:a17:903:2acc:b0:2b2:4cd2:e162 with SMTP id d9443c01a7336-2b97c48d869mr9555605ad.34.1777341949264;
        Mon, 27 Apr 2026 19:05:49 -0700 (PDT)
Received: from [10.133.33.153] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b97aa93329sm8048505ad.20.2026.04.27.19.05.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 19:05:48 -0700 (PDT)
Message-ID: <6826ce13-ed2f-42a2-8b46-1357b4a9b4ee@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 10:05:45 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath11k: cancel SSR work items during PCI
 shutdown
To: Wei Zhang <wei.zhang@oss.qualcomm.com>, jeff.johnson@oss.qualcomm.com
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260404043050.3433754-1-wei.zhang@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260404043050.3433754-1-wei.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: xrIOky5uLyt4KdQs8GykLL0LtpEsxR7T
X-Authority-Analysis: v=2.4 cv=PcrPQChd c=1 sm=1 tr=0 ts=69f015fe cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=G9A0gv2bhTP1aVYgofQA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: xrIOky5uLyt4KdQs8GykLL0LtpEsxR7T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDAxOCBTYWx0ZWRfX3Xg/m21BFK1b
 d9U5VrPQyZBd5FG+xxuTL9KAmVjmwSWZxJOUWpQ0Fs0uQuVfsrqdA2u//k3iZUsm9vC9dYzFbPb
 7A/PUmICzEEjSzjueV42mhAicjB3Y2Bg1yGvMR9t9NZhh7QSiVJMiITAgmHmNRGqsl0btTJQQjO
 1wJeCK2doNMopd8iol+e1o6C6S542DlTn1mqqncFS572CNcCAgk/EzKKn8BRqm21Mr8jOOCnrrh
 T9E0UWAaQkftDcpUiVIat/q/xXAzQsXaDIEXrbWb53FvW5PPUNclQdl59DPlaOsEMDKnA/JwtBg
 NNkIQGiae1+W6c2Jwe+8awHDKBJiKZKYpEBRSJFqWKL82WcjqRJZ+JNXxjJnChkD+6viSrzToP+
 t/S7epLQQnieCmX6QQUp0UEf5oY0M9r+o1PrACLUxbqZl8/I6bb9C6FbFvxizhmohUTs83VsmVb
 RSaQvmZ4/LJMfjperAw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280018
X-Rspamd-Queue-Id: 58E8D47C9C5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-35429-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]



On 4/4/2026 12:30 PM, Wei Zhang wrote:
> A reboot can crash the kernel if it overlaps with WLAN firmware crash
> recovery (SSR). The crash is a NULL pointer dereference in the MHI teardown
> path while freeing DMA-backed MHI contexts.
> 
> Simplified trace:
>   dma_free_attrs
>   mhi_deinit_dev_ctxt [mhi]
>   ath11k_pci_power_down [ath11k_pci]
>   ath11k_pci_shutdown [ath11k_pci]
>   device_shutdown
>   kernel_restart
> 
> On the host side, SSR is driven by the MHI RDDM callback, which queues
> reset_work to perform device recovery. reset_work power-cycles the device
> by calling ath11k_hif_power_down() followed by ath11k_hif_power_up(). The
> power-down phase deinitializes MHI and frees DMA resources.
> 
> Shutdown/reboot runs fully asynchronously with this RDDM-driven SSR
> recovery flow. As a result, the shutdown path
> (ath11k_pci_shutdown() -> ath11k_pci_power_down()) can race with the SSR
> recovery sequence.
> 
> Fix this by canceling SSR-related work items during PCI shutdown, marking
> the device as unregistering, and serializing the RDDM callback path that
> checks and queues reset_work. This ensures that no new SSR recovery work
> can be queued once teardown has started, and that any in-flight recovery
> work is fully synchronized before device power-down, preventing MHI
> teardown and DMA resource freeing from running more than once.
> 
> Note: This issue only affects PCI/MHI-based devices. AHB-based ath11k
> devices do not queue reset_work in normal SSR flows.
> 
> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-04866.5-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1
> 
> Fixes: 13da397f884d ("ath11k: add support for device recovery for QCA6390/WCN6855")
> Fixes: 5edbb148bc57 ("wifi: ath11k: Add firmware coredump collection support")
> Signed-off-by: Wei Zhang <wei.zhang@oss.qualcomm.com>

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


