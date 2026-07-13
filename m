Return-Path: <linux-wireless+bounces-38941-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tmq0CjiPVGo/nQMAu9opvQ
	(envelope-from <linux-wireless+bounces-38941-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 09:09:44 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B02747CF8
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 09:09:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=bnRTVtvt;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=QgqpSpGz;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38941-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38941-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6D1A430034AF
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 07:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A04368D4B;
	Mon, 13 Jul 2026 07:09:38 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A2A3546C9
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 07:09:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783926578; cv=none; b=nA9spwoU9LfjGU/WW4K3E5xEn9LXkiAYd1y0QyugyK3uK8Fzi1HeW6VslA+orEoeWJbtaznsg7ox0ev2BdqyTzMc4C6N1elnchxUs8zg4uYPsFKlrrrwAxfEut4GYCDRNTneXIMfGn4983ePODAxlr0QdLT/k4M842+fN9FwxtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783926578; c=relaxed/simple;
	bh=Wn4JgGOXPAn6H+cyBybw8PFXpj33UTx2pyYRT4n+y7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h7vNv7BKrBinzMNckL2XOG9iD7DG8S4X3xc4/rLNlLIxUYo3IPFoRYCpIUA3tWx45Zw+rxniLefebKp4qWz62kMcz3vThYEg/hHmSLxyn35XwrqSH6gd2JBO+UyWpHtztKDKvKQ7KEjKZMnVzNlYAGyHwwe/RRZXPZmW91gCaiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bnRTVtvt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QgqpSpGz; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D6ObwX605104
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 07:09:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	54aSgbJTAVEXIL1r3f/ANoogoAnhGadGwn99SJxuhf8=; b=bnRTVtvtojw2+pKi
	WVJmT1wu8P3YdB+UWPnz3f3z1i6LFyOLJm+3+CLK1G/JkmXtWoshmI9GVILMCTiP
	Vh9Xi+8WiBlDpxbCxwW9tkgKTe+T2f/uu2O+x1yY3ddY6kAv+PWVe3aSLjRFLTXi
	ykRp8axaCzmOUO9Rcg67009KrO9ku2KWHkMjiKH1hN2kJLsNDH7NyAFqT0pcwHF/
	18uLWdq3K1mK8Ty6QaTBRWTKZTQkcGEilyF4WUe4ROhiXYrx5Zfvhl+CZdXqAgCd
	PkVZ+FksQSfikXeXXEPqrE40hVtYhbAIt15pjQ28dOWJeqE4+u8bXJi9UZ9LVdz9
	41Z9CA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbeehmwd1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 07:09:35 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-380b630c505so3547828a91.1
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 00:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783926575; x=1784531375; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=54aSgbJTAVEXIL1r3f/ANoogoAnhGadGwn99SJxuhf8=;
        b=QgqpSpGzSiaRX+1aFibsTtD1UQD3W0Nkg2HEqgsXaBnn7lSvtQut+D2XUC30MXX4im
         VXKGuIjKw9/0GJ++h7aza/YiZ4z2PFd4mhsBXOtGdIl4KtaL9nQiYhHfcUAf1sWIHONX
         pkh4xBnfxgRSvY3n2hlq46NMwu9SaZ9xi5Aa2ZGzpVyt6BcFvmbA2lX2P3jtfNI50EcU
         WCXH3op2/sH2a8zr89AMwc1LxMTvyW/4C8l70ilvNDmHHCaHKQFQuaHJsCZ5RNvUu4jj
         kJEYk0ofk1U1gGQh/4ZgtF+ajT35p/4VGg5deN0RQHZiDyhoQui9tea/NtxlTNCmFONv
         vtSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783926575; x=1784531375;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=54aSgbJTAVEXIL1r3f/ANoogoAnhGadGwn99SJxuhf8=;
        b=DMbkjknoktQivRDXrtmZNn7EETkMTiVj8IbB1BCKG2GOtt9sBRoixdloR8ZUKGQOcy
         5I6RAb7fYDxDNzXTOZ+PGjHiEtCgmaTI3JXQc7tI0p8PiKVM9A/HrInAamUU4vCaflq/
         AshQsmtbhXqcJNNDTBAwJzAgzwLX78QsgNCNn2W8edqRst8QqcQBy9LdeFNrcgtCr3Nf
         rMWHj8uWFIW9JGqOVAK888qEXdRdmJLZ46XWgmZGt5loG9L679MOyeLnbK7aPG2G4c3w
         qY63Ac4T0Bypv5EOZ9iLrL6iSCEJ4spQixry7HF1CAmw//jvLoV72fSv46KL9xcvVjXu
         3I1g==
X-Forwarded-Encrypted: i=1; AHgh+RopAb7D8hSWPi4mUWHpZXKLXIM4F/BSJMVV8BFnO3iDDskE6FhODC9re1iGdQuad45fnPoD+wqOwEWq/SUmSQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzud6LrElOL3LIE5LIcsyigvz4ysuVwwI5a76b5PwgaYmE4J6vg
	2XKkrfFbk3xttdf/Eoj7FlLU7SzSTSrwC7O8O7DjK38wzjJ+8IxhbJi7gbNgNhce44M0j+1McSC
	D8oK7Og2nhZ/Y56fNTM118/ql/y3buhHSoCbYbCf2znBG+bFICUhgp/v67vMuQq9uxycXjg==
X-Gm-Gg: AfdE7cmdzEHszp0z9AaZt8J2uPEBxtrtVU/w/DJn5ie7YJW0il5w/yE4JlO8KmVYnNy
	oovNFepFGBN2/VStvCMwuJxObMt7iafGgbf+KZ6qVjglQIkKX/GfFlxBryM8MMbWv0YqnpKNn9N
	2YP9hzqfdeaFUOtFgU20DEnxchXfnyMvFFXs8O+uLbyA7FZw1osBj70JNPA87SZChokDb5lrXDs
	HiwEetbIgVDktVm3BazECrPpNdkaZvJlYt1GKsytz2zN07V3slJ1tiGHtU0Eh2oWXTrdT4ZRqWG
	hRWRiWy8vHaFbltBadD7221f+D5s/mwLuGjq3uGwYt6KGtOm2JeiE3fGYYCr6/pHbo1fnhP/H9A
	ArWhfAMzLdds8NuikBcDgPkgHkC7zuGneCXRxr2Ni8eDIMJqGi9k=
X-Received: by 2002:a17:90b:510b:b0:387:e0bb:57f5 with SMTP id 98e67ed59e1d1-38dc7798fdcmr7551753a91.38.1783926574737;
        Mon, 13 Jul 2026 00:09:34 -0700 (PDT)
X-Received: by 2002:a17:90b:510b:b0:387:e0bb:57f5 with SMTP id 98e67ed59e1d1-38dc7798fdcmr7551736a91.38.1783926574250;
        Mon, 13 Jul 2026 00:09:34 -0700 (PDT)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311a6115e61sm49182704eec.22.2026.07.13.00.09.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 00:09:33 -0700 (PDT)
Message-ID: <47dbde08-bf2d-444d-b2bc-b802289205fe@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 12:39:29 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: fix rx_mpdu_start layout for
 QCC2072
To: Wei Zhang <wei.zhang@oss.qualcomm.com>, jeff.johnson@oss.qualcomm.com
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260629061529.1993932-1-wei.zhang@oss.qualcomm.com>
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260629061529.1993932-1-wei.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA3MiBTYWx0ZWRfX7bCb2dTys/xC
 BUl1uTuYCxzSDAc7VQ3oznIqqXt1OnB7L9XOFPoRrj6yDNsGJP3ZPE2JwcTPQcEHTVNXqrWksM0
 aWL6VmM5BiFcH1jjVO+b1HQy2O7Y27M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA3MiBTYWx0ZWRfX5pypQA2bceme
 WjKNcPnvQSq+LumLTribfqjNgGr1KAsDYNjjRHGDJshoBpL7fKmQX3KG+8f+4RsE0lnnYl4btW2
 YQsC76nC8c2XwFrFSJWJwBmrq/CKrhMnC110ZKv7wGEXt8yQVjdLyRMmn7zLgtH+JA3ZFjWmOuF
 9fmQPVHhYHSG0vMV3baJwYkmLS+Znw0qd4HtM7Vt1kTqZKs5yjvA/nXtRbxB8Czx7r3po7C6aae
 f6MxZktl4u5ll++UUa8+MN9FpjcgM11HczhuUn98aX/8DVLXc69f7GnE+yQWx2/34tPyuJQJRge
 V4GLauaNX/p0jmxXxrl9GeEJzrbgedTKXO6l517NECTBC6DGeDZqsq9dDVCfJDOr/AKaBShAvOK
 a+7zcxZUagtcmrfGIYBCAJijA5LpjIVuip1X8DQeDTbzwoEgc6azcONv7KThwuOY5SxYoXTVj2D
 04qEy/MKKWo2dnbynQA==
X-Proofpoint-GUID: qiVn6nKTpgSsPL_ZyLZDfI7nJksIqWsI
X-Proofpoint-ORIG-GUID: qiVn6nKTpgSsPL_ZyLZDfI7nJksIqWsI
X-Authority-Analysis: v=2.4 cv=aPvAb79m c=1 sm=1 tr=0 ts=6a548f2f cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=EB44UgcCvd3G_oUa3FEA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 spamscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130072
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38941-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:wei.zhang@oss.qualcomm.com,m:jeff.johnson@oss.qualcomm.com,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,vger.kernel.org:from_smtp];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 29B02747CF8

On 6/29/2026 11:45 AM, Wei Zhang wrote:
> QCC2072's rx_mpdu_start TLV has a different field layout from QCN9274.
> Reusing struct rx_mpdu_start_qcn9274 in hal_rx_desc_qcc2072 causes the
> RX datapath to read the wrong offsets for info2, info4, pn[] and
> phy_ppdu_id, producing corrupted sequence number, PN, ppdu_id and
> mpdu-info flags (encrypted, fragment, addr2/addr4 valid).
> 
> Add a dedicated struct rx_mpdu_start_qcc2072 that matches the actual
> hardware descriptor layout, and use it in hal_rx_desc_qcc2072.
> 
> Tested-on: QCC2072 hw1.0 PCI WLAN.COL.1.0.c2-00188-QCACOLSWPL_V1_TO_SILICONZ-1
> 
> Fixes: 28badc78142e ("wifi: ath12k: add HAL descriptor and ops for QCC2072")
> Signed-off-by: Wei Zhang <wei.zhang@oss.qualcomm.com>
Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

