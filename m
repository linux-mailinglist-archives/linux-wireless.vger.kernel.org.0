Return-Path: <linux-wireless+bounces-38264-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pDfgJlMgQmqs0gkAu9opvQ
	(envelope-from <linux-wireless+bounces-38264-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 09:35:47 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9E16D70F1
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 09:35:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=A2ankhgD;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=fW4i336z;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38264-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38264-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5084D303098F
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 07:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD62F3C3447;
	Mon, 29 Jun 2026 07:28:26 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73403CCFD2
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 07:28:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782718106; cv=none; b=t1k80oT2aOjW8W3xwhtPYIfLnezctTWoUOpBu0drKtGlmyXD+uoi5w7V75FeiVEDffqmxZ0b51Kb7FZZFS4+GOIg2tLlU3DMTWRy3bN/5/f3eIcgr1skIF4BzbvQKvFCp+83zMpGeVIWxpZsX/+LZWC3pHopX9hNqmwrYRMaBxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782718106; c=relaxed/simple;
	bh=YAimveRM21/MHwiJH3SFuuB4MAvW3X65+q8mFl0kT4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tYv1nFwGhVbUENN8gBjYoexn3mKlVAYyDfEqNjrI2CLlgvVBRI8K/Rqh3JYSmdhEsara8PfmYe992mxUylcxNGMoK3Ho2Ha9iHc8kZaTwFWrPWO3sS7rEI0psK0hstr2se6duWdk1oqYBfFJa+jzBuA/t+YJa2iG9Nh0e0L4qc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A2ankhgD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fW4i336z; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T6r4AJ2076412
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 07:28:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	D3WWEn498wRT2F5GSO0e507MOXabcK3QFPlbhvF3mgA=; b=A2ankhgDRercu57J
	aB0xNFHWLyHicORK1TxB9Ce5p43eZ0KVUADJufPPqw9+zLHJ/rbup+RBldyuWY4y
	F972R9/wWM3EEQRSRkuOlfrDIw7EsKjXYK/qs0nxri+mhoxTqWqAZAhJQ1IsU4b2
	6yuPC/1tEEXV2DEk9P2rbz90DSdxwnArYjZcN7xwS4A0I4oMPLNNt/6ytDD0YC6f
	nSGaI5U/VZB6t8kU9+KI8AcawhF7Ol33Ba1KcLaHodAHYpsg3MKa8M5tUFHJXIn+
	f+a6lBiQr1hLBzuzvhAhyViJB5shUj0jlUjFEcDBdK7uF88yH6sunL8oHFFBmEjj
	ldwQJA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3kp7g5vs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 07:28:22 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2c79e5de32cso23702725ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 00:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782718102; x=1783322902; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=D3WWEn498wRT2F5GSO0e507MOXabcK3QFPlbhvF3mgA=;
        b=fW4i336zwS2auxOmQcSMxgX7Wb93RBeDRZQS9tnXQGTN5tHruovk42C4c6AON7Ep9U
         ETTy8SeyH9hprURKxk1fEq2PSs8uj+uo13zGvveIE/ZQ2Re6wWYzqi28ZDx6vgcUMFrt
         RpY42SZWDSCfS/Gtf7nB4oaX2NhP4POoanwq49KgzGHhqYnyUWpCoIv8FTGzFhRwz8IT
         HeR0Bc1hnPGHvSoqCxDkdT1+DXq8RUdR8UNtOKR7UZiHbPl4qW+zhkB9K/nm1RWG7eGY
         dwcZeaaRPTLRgCFv2lcEPeam+F+QKBIc710Hx1ATN4A6MqhVekq0YPInSdZhmKyTP3zT
         L3og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782718102; x=1783322902;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D3WWEn498wRT2F5GSO0e507MOXabcK3QFPlbhvF3mgA=;
        b=rPya3mn9ST4UNux2UY0ca17ARO1nuJkwDWr9kdvksC9KXnc3wLQjw9F54ex7xi09pN
         YcPyi/3EavPdT1MfU8Tt4WItN40bkSwUyytd4dLFD60i+UIKsfX6O+uolSnkQbjHCKdV
         33KsRtTHngi4v/Ti17yoTnty9CdX36+FS0m3cyif4jg0TFryhjNpxmvF8dL4T8GvJq5O
         U/uRGUAStCIByRtZwbnab9VIb5gZXIMc7HsVpc+HLtQFXvUhxqbWOpmnBs4XX3KqqQp6
         vW6KNGFeu9XcefF+zUKvQPSrq2r3ocwnyLHT0ETPAJZUMeh3ii1rS60DM3NuscCKN6HE
         EA6g==
X-Gm-Message-State: AOJu0YxfvdMlVB1CupIzTnCOuWXUWlEP0OMxZ8xz2ioxWbvJFLOzGfCF
	CkEWcJtuFCwES9X52354WeekweMSm+Br8fQtywMySe0jASdoCdRe2JoghtWT+M9PxvOFl3mBKc3
	TZ7Jr99dcNUXt4qoF4bAsneRA5tpH7s0AlYAgtCqTKBBTJmZ6/bWpJgyEXZLOejVgjbvsuQ==
X-Gm-Gg: AfdE7ckRZaMzepuF8yBOvKua6GmiagHkJp38HwkuHdncwuL/0ttihPYHjdzhNx8N2eC
	g4hfNi1rP5XZuOABuJYoJT7MjjSjdq9lluEvlegKAiGoD+tEcsFoCMUODuIKdNxP/9mv96IeFoP
	aY1G1jmDlQdo2V60gHLlOLxpXBzLUnCUSHiT+O5+PpK9FhUk9g45uMCqaQLyFeiKjTQq7ittA4+
	H4pXli7hfd+rYZ33iOKbE9cvRSIhfqo3OHkLDwmIwkHOTIBzXIlJDXVnOI9XHCz3dXC0SCREZqQ
	mr2kQoBsjacsGg9hWQcBbZ11lY3EaGWRU+FADcl+WmdXi8toe9lxXf1bvMWVzPjCALin5hIwInU
	SkAdjrCzpy83MPMJKVH/izDTQwpIrUz9Rnp2UX/AAzM2cuqPghMMGeppgwWaaxKtaS/CL1J1YkX
	6/ihxP2w==
X-Received: by 2002:a05:6a21:3115:b0:3b4:b24e:27b4 with SMTP id adf61e73a8af0-3bd4abed61dmr15513099637.1.1782718102178;
        Mon, 29 Jun 2026 00:28:22 -0700 (PDT)
X-Received: by 2002:a05:6a21:3115:b0:3b4:b24e:27b4 with SMTP id adf61e73a8af0-3bd4abed61dmr15513087637.1.1782718101671;
        Mon, 29 Jun 2026 00:28:21 -0700 (PDT)
Received: from [10.133.33.8] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a40ee417sm10938965b3a.40.2026.06.29.00.28.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 00:28:21 -0700 (PDT)
Message-ID: <91d2bcce-f85b-444b-b016-572a07742754@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 15:28:18 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: Advertise multicast Ethernet
 encapsulation offload support
To: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260623100501.2100119-1-tamizh.raja@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260623100501.2100119-1-tamizh.raja@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA2MSBTYWx0ZWRfX6VdK6ZWJUoSi
 FSMh+KZgP6FSAU8yBKxhuBYgfBNGYXnnU2v/M/CPAP6gG1B7UgA1p1aWwxu7LI9n7JnFsaRC7zL
 jbBOBg0jVXgWAD+/g7BqdfJaGxlwRco=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA2MSBTYWx0ZWRfX8qh+4V/4xqEm
 jRW0UTpK7TUXneWs6HsEBbfsKMkq04fzdFi1HWLSFV4uHOlPggJT12YKiAgVupnJmh2RJlX3OIl
 4OfHuEjhu9qOm4Nipd9+m/XaltPbTThYB2Ts0O48+JE+aMhB4TaSyyn7LDW2GKu8AeevXIk3aPT
 9OVed9lAl4c4xB0/ZmwuTb9w1Q9SYiOyBeKlI64I1hz77X2uYtjJaUyyWYeeDBhEfiD8b/nMLjX
 lGdsCrCOBFfifUv2408dkUaYSGZY3sQIq6zaV4DuqCCIw1iWXFRkXJrWoHscVNaj7oVk6CDso24
 52Az+SMroKyT9W73RkraYOiz2Iq1GXtrbfW9IT8gnplfFWXXBlYAe5RHKhHGLalKepgirTjiuTF
 KlVxpmAThcVeNI5wUNwU49opiiEkfIr8A16OjOUcHyXvJfgFlSb9sHY7pcx+CTSZwU4saO2KjxK
 281mgS9ns8wAU7EJp7Q==
X-Proofpoint-ORIG-GUID: wwUUsoNfCHBGlqFHxb13lBIECpuTexjz
X-Authority-Analysis: v=2.4 cv=MZJcfZ/f c=1 sm=1 tr=0 ts=6a421e96 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=ON_mxGkP88hWkZQB5WAA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: wwUUsoNfCHBGlqFHxb13lBIECpuTexjz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290061
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38264-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:tamizh.raja@oss.qualcomm.com,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1C9E16D70F1



On 6/23/2026 6:05 PM, Tamizh Chelvam Raja wrote:
> Advertise IEEE80211_OFFLOAD_ENCAP_MCAST to inform mac80211 that
> multicast frame encapsulation is handled in hardware. This allows
> mac80211 to pass Ethernet-formatted multicast frames directly to
> the driver.
> 
> In ath12k_wifi7_mac_op_tx(), refine the logic that selects the MLO
> multicast replication path. Add a sta pointer check so that only unicast
> Hardware-encap frames use the direct transmit path, while multicast
> Hardware-encap frames fall through to the MLO replication loop and are
> transmitted on each active link.
> 
> In the MLO replication loop, use skb_clone() for Hardware-encap frames.
> These frames are already in Ethernet format and do not require
> 802.11 link address rewriting by ath12k_mlo_mcast_update_tx_link_address().
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

