Return-Path: <linux-wireless+bounces-37616-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LlUGC9EBKWr+OgMAu9opvQ
	(envelope-from <linux-wireless+bounces-37616-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 08:18:57 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EB4666285
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 08:18:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=QUBwL3FF;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=QGEgRf5h;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37616-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37616-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8DD131855F9
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 06:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E78370AFB;
	Wed, 10 Jun 2026 06:12:49 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A382E92B3
	for <linux-wireless@vger.kernel.org>; Wed, 10 Jun 2026 06:12:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781071969; cv=none; b=h5fZLbb5DJe90kqYJI+M8Cr8PWYGj4FmOha66D2xIHzXa5NjnB8Djw75Z/pi28OlzRsDr7l2TzBA77fx/N8vJZEB7NFSLg6L9O1x7/NRwb0ozUxFgtMgc/19GRjRahf8moVVK0dH2oLu/ytvQK8ZMxPSHpCIRLP/zLjIR1gwGCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781071969; c=relaxed/simple;
	bh=ih2VxhK9UOobWXGBe7+p35b25bqPaqrHtO8lV4tTprg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M4NOrCkGXAYhEDet0XMKESBffpzPA0thJvso9XCk6+rTbBLY9XZj0pYgzPj5YeCJuV2IxDOh2Rw8MjsvTOlifyukdGoEK75s+7AivVxLt55ODkIpLgtvZhR74DvX/LRm+gd/poCyzZoUrLTlcCvJyWYT6Dv8pr8DPgN7RcSjGBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QUBwL3FF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QGEgRf5h; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A2ewg64097458
	for <linux-wireless@vger.kernel.org>; Wed, 10 Jun 2026 06:12:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OC7ZsgO+uB1177IYXfTaG7U4Jmv7/q1Wf0xTfPebL4M=; b=QUBwL3FFUPQaTZ/o
	fr+grlE0xvL4zOwUcdmEQmik9qzzkfKIUjfzCrz7wOJ2LkfEL9Xvn7kJigigwZ4F
	wtxgwVBdAYLYz7OqjO/R4cuovHGFyXcMWFWa6Vh9wDppKJnx4voRkdd2OPJ9kOpZ
	C0QXubRXJH/cbYhFIJFeD/w/0C8gjvBme85Xy/jOy1pya0ioAF5WWNn4UQi5Bkkh
	6AHcGi/RFfJZEUSfMFonQ55VdXJlTKAn34zcueX+CbYjy2nHV8DqWybvBs59u9L5
	kzG3RQxgbllmTSy4mHkCfEMNJrocSZLzekyAzMAxZDhiKGX3Ksy1dNxf9Enad3hi
	MTwT8A==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epg3jw74f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 10 Jun 2026 06:12:47 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2c0d0516ad7so65048275ad.0
        for <linux-wireless@vger.kernel.org>; Tue, 09 Jun 2026 23:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781071966; x=1781676766; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OC7ZsgO+uB1177IYXfTaG7U4Jmv7/q1Wf0xTfPebL4M=;
        b=QGEgRf5hu/01Yog1iGLB4eOhDiefoEeIaj9K0WPmZZN/K14O73UfqRkG16lDEwJfv3
         acVCJLVUMHsnOyU4S4MWpuFxsZpIhqRBJWghnUDV859mq9qxTOr3G7nTP1TXq2iU7fhG
         g6dE56hSFZ76wXzrXySTZGJwXJuqH/HHysu6a+Yyo8PC8XxRsGWrj4pOpjHhXp2Oljkt
         x1RUGgsPS1vxqB2VvRhOgT4v1QRaW1SYq4DJXAt+V9VFIRe3ocOyOy1l8tGqE+QyNUF6
         znLjqT7Uc3LdCj/ZKyUWLeK8Xc6dKuvznDL2XB9mQ7bpQb6AViJi63/MFhCPd7JmAwoB
         OmvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781071966; x=1781676766;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OC7ZsgO+uB1177IYXfTaG7U4Jmv7/q1Wf0xTfPebL4M=;
        b=dVi1FVSRmcGHTUnIHseBSH5Ax+c6R6npf201AFDlyli+g4aWFWHH482Qk5z7QUyG9p
         w1XUhMW96B8VeEQTesyFFGGwPYLgZVz6ifv/JENAGoNBuTL0J5x7/4Oba468LofPO0HU
         Vy288pZ+hVfJh/W4duoX9xMnr0bVYO2AxI76NjluSpV8MRLdXZH+re7FaxezWFMa72PV
         Zkpsa9MnUgsOML+e9aioPY7bSKUFrYaGsmIRtwwmiWQ+a1nu6+HOB/CHpUC3pUwWQ0GI
         pQ36iz8f4HTeiCATYlClqGMOAiqjRYPNIY7A3mejAQt6fVWFBxCOrOnyplMhNYSpZEhw
         TYrQ==
X-Forwarded-Encrypted: i=1; AFNElJ/9j+eTm9Qn86WLiT3Qaa/yjrhx/hIpYOGb+GMfLrf8aU9ojDks5XWgYc0PbIn5ujRsRLedBxRSLn9GwuP/9g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJu+dehWmP+9avSA24hChRAP0DhEmBiFBlXA1FWhV+9T6nShTj
	Pop9pxpEZug+/kGvT/sXxpNSfS6QD6UpVB67aa6BhJMNAE+nU/9VyOX2SaX9Kj4K7lOFN1c/pMK
	3NlaCiqhpNSrx+1EdxLbRWgQN6KZv4u9kMTu4w8Zg0gJCPTix+/4BFLZgf8U1EiWAiOYcbn31bs
	YfpA==
X-Gm-Gg: Acq92OE+blsn/HShqkWPXyPuW1sBVBBYlppMXm1r0P9V7T1zMqQVikZxXXK/cun3N1e
	mnY/wC+6PjATICceF88y98+2AQYXzV+Uflo+Ty7VHoYbbeccVILl13ggU6DjESXnMoIV3K1IBTC
	vsh3ylL6Q7y2UReq8/0MOnJQkckd53Rw4B5uhwMkJ7NPcesAnwCPuGB8rKI+CA3CCG8Vq3zAsjS
	xk2jKDzgxvl7fdQYLo7nx/TMXWYhDvb/el+TAf1TZiGkL7NviD/kEfKo+8tRRNW4HEKyVXFGL/b
	6Xe2h8YCSNGbXAbvPlODsOJOLYh4WCKVbPXp2wHZs52fg26XgTNDvahIEVhe1KAxConcvB1sDeC
	I9dAWlCzvhg1bkB5qIAJafCUV8QbGvAsrTu4ZlnLM+iJ26AfzzS505qPxkLlJ7rHdKwQ00mi0uH
	swVU2SYqXNqNY7/i9DW1kAlHCimahNfg==
X-Received: by 2002:a17:903:2405:b0:2c2:8659:da44 with SMTP id d9443c01a7336-2c28659dc77mr131827595ad.36.1781071966585;
        Tue, 09 Jun 2026 23:12:46 -0700 (PDT)
X-Received: by 2002:a17:903:2405:b0:2c2:8659:da44 with SMTP id d9443c01a7336-2c28659dc77mr131827235ad.36.1781071966136;
        Tue, 09 Jun 2026 23:12:46 -0700 (PDT)
Received: from [10.133.33.184] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16629d40asm224303375ad.64.2026.06.09.23.12.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 23:12:45 -0700 (PDT)
Message-ID: <f8d875b1-c230-4489-b5b7-7677ed2ba38d@oss.qualcomm.com>
Date: Wed, 10 Jun 2026 14:12:43 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ath-current] wifi: ath11k: fix NULL pointer dereference in
 ath11k_hal_srng_access_begin
To: Gaole Zhang <gaole.zhang@oss.qualcomm.com>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc: miaoqing.pan@oss.qualcomm.com, hangtian.zhu@oss.qualcomm.com
References: <20260609090609.4041009-1-gaole.zhang@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260609090609.4041009-1-gaole.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: DLCprvYydQk2dTPqdGAT4H3AGkF5a_z-
X-Authority-Analysis: v=2.4 cv=aa9RWxot c=1 sm=1 tr=0 ts=6a29005f cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=E4ruc0QeprPoJUAD4lkA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDA1NiBTYWx0ZWRfX4ITO6aw+OcS4
 bguF8jVXV8oFoiFrJetgHtrymHItEnAjYBI3LRFOlxukaChwDhBdmaWMjbn2Uxis9+hRUVb4N5P
 y5WCmIAeZtP79Ld/DoruAye8Sh1cTMB/zJJ82GNfbms0/J6IkkggQdOp1q/+/T3hMFntw21hPz3
 VyC/LxcijgHR+CpOtL5mP9ykFPs+1D4H6qi/osWfXc80baiiZFromqfHqXCrfHYTnxf5ILjD1U1
 cNknuEbDzXA3ceTa8smPywctyr+2kKIHUM8L80dt8goiziQOwNYwN/1HZjbM2wBksEJCscf1Px9
 4fw9vXTKR6ht6viG5qC9aiLk8oaL2GXNuUgYUpiz7/Uf+2oWNK5k6a97MxYzga9LoNYoX7ZE8eT
 SorBt2EEh3QoLJk/aLZM2kSjsF0rZtqL0Wq+LaCDLKhWfY2riToVaemfajDnZgOK5qeHNswM+wp
 wmw+Ri8jrQCWUxjXe5A==
X-Proofpoint-ORIG-GUID: DLCprvYydQk2dTPqdGAT4H3AGkF5a_z-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 spamscore=0 bulkscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100056
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37616-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:gaole.zhang@oss.qualcomm.com,m:ath11k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:miaoqing.pan@oss.qualcomm.com,m:hangtian.zhu@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
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
X-Rspamd-Queue-Id: 64EB4666285



On 6/9/2026 5:06 PM, Gaole Zhang wrote:
> In ATH11K_QMI_EVENT_FW_READY, ATH11K_FLAG_REGISTERED is set
> unconditionally even when ath11k_core_qmi_firmware_ready() fails.
> This leaves the driver in an inconsistent state where
> initialization is considered complete although the firmware ready
> handling did not finish successfully. During the subsequent SSR,
> the driver enters the restart path based on this incorrect state
> and dereferences uninitialized srng members, resulting in a NULL
> pointer dereference.
> 
> Call trace:
>   ath11k_hal_srng_access_begin+0xc/0x60 [ath11k] (P)
>   ath11k_ce_cleanup_pipes+0x17c/0x180 [ath11k]
>   ath11k_core_restart+0x40/0x168 [ath11k]
> 
> Fix this by:
> - skipping firmware_ready if ATH11K_FLAG_REGISTERED is already set
> - setting ATH11K_FLAG_REGISTERED only when firmware_ready succeeds
> - setting ATH11K_FLAG_QMI_FAIL and aborting the FW_READY handling
> on error
> 
> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.2.0.c2-00204-QCAMSLSWPLZ-1
> 
> Fixes: 6fe62a8cec51c ("wifi: ath11k: Add cold boot calibration support on WCN6750")
> Signed-off-by: Gaole Zhang <gaole.zhang@oss.qualcomm.com>

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


