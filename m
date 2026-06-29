Return-Path: <linux-wireless+bounces-38239-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /f5RDm/XQWr1uwkAu9opvQ
	(envelope-from <linux-wireless+bounces-38239-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 04:24:47 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2316D57F3
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 04:24:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=KVt0bMgD;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=MEmxEinf;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38239-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38239-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6DF1A300B5B5
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 02:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB52245012;
	Mon, 29 Jun 2026 02:24:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525452EFDA6
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 02:24:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782699875; cv=none; b=QhqoHHywwBhB/Qupqm6qSM4xNw1oLmDfQPaTcqZiO30E1fr/+pe+NPDZkUkPqA+CJ0lYHd3tUO/7zuKd7W6wx+gDfXyAvfnkFZWqf1za7unY29Mh73hLikMoAP2qIEt+JvppQpQf4WGciLwXJhGpUpQt5CP6xRSErt6DpY8Dn68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782699875; c=relaxed/simple;
	bh=6BoDx9XQ35sWk3G1WI8qRrvTvi44PNqFCtCfGhWNZ0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t07mu+BCGqIgCHIU0gK/rH3vsFk52zK/P26sW+Z/qn5YPbvecXNrem+ipAhp6NdHVMZchIYwJfqRFz7B8nKUQ4XePx/L29KP/fixw8ZbSh25xlaEHfdd0LYmEUcFrmv7LDRbwBS4V4Oi3NoJ2YiyFRDiMa+IcbJVfY0LRyhJFMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KVt0bMgD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MEmxEinf; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65SM8qfQ936872
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 02:24:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s1KKM8fMshXRyPEZczpywDmW73CgGmBCjoqY13XiGxM=; b=KVt0bMgDIVEVGZo1
	cpBvP8U5FayJJIPFi4yeRaLmb+qeuxDM5lYnfiWAFqVXarbPchzBX/tOdK2snIIP
	GUS9MbeR+GrvxF4fs323gPP4k7++MyXfnM4OdmKxWVAhjcmJZP5z2fNlrALEGxd+
	4xv8afSlLoTaq5g5lHc0xTyJiUobjPckJVLpgLc82EDE0ICPOcVpRNpyAipB93VH
	lqbkAAtPbX9/rYbmVvAZWKVAoNPTw275lHFvS+Lv7y8tJtPGfHd8uU72W7GBwuAr
	/GbyVJoCNx6dchIAHzrc7CzY/Daoe7OAHhOIMP7oqsFAGHfXbr5d5DECnJoqK0tx
	NZr1bQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f27pf3ymr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 02:24:33 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8478e9c4bd2so126286b3a.1
        for <linux-wireless@vger.kernel.org>; Sun, 28 Jun 2026 19:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782699873; x=1783304673; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s1KKM8fMshXRyPEZczpywDmW73CgGmBCjoqY13XiGxM=;
        b=MEmxEinf/m/ClXVQYl/s9t9HhqDxEFy85DHtvoTxvDJtyqe/wllzPmcd38nqRKqfqT
         ux4bcnVuGL0leVVpIB7ahaQEpwUGzyABzPtq3qyQJRX83CY71ukHydbvXWzv1awjn4EW
         bLBMwrNxOPau//sGOy2gKkOW0MTWHZEIjdnQ6K+7BJ6zIWOw87A2y3XrFhCkyxhQy3v/
         sTfxhOd2xAZY1mVjK8ebtmr767JIx3dnSZ1n7nAOydS6Iuw/evY3ksma6iDxd6efJqtZ
         S8ydG9E9iai7zPMIi8kvwk6NGmtyHB8huAjFU3rA/IktrxcZtozHVWm/76qXoMNafLSE
         ZUtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782699873; x=1783304673;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s1KKM8fMshXRyPEZczpywDmW73CgGmBCjoqY13XiGxM=;
        b=rWlKqD2XND0OiG/B67i39RVXScc8JkwGRHW2386s+/bN4tcA+oiexQvjUdl3aAPtRq
         obQLbQdl0Vtd1NIJku/pqJMiqw7+VXegi+yBl/MqAQRuH8QiuRjnhXco0gAdKYo49jVy
         h5iv+wM00BZM+dRIRcu9jb8FeA0S7vE2c53fot7SNN4gqCul0r/rjTY5mIpMroFtlL0D
         k5HgV3VZk/xe4hhz2SGrijRBVc+CR+PWN59hhaKXwsZkIMo9ZWYbRbrZh5iTquGAPis9
         Ju8xOJdQGpJXfEHSmCYhF9U/Mkvzqe0cEnkFW/KNtNA227ziNj6lnevcYvac2y/gZwA0
         rwqg==
X-Gm-Message-State: AOJu0Yw7I5M1a8TVA0ozWj2ynMug/Wfd4To8caCiEv2TqP5GAp0cbvmb
	QJa/fP9UbETCS/ud5KjDiwI2y6pkn71re8HAmbFuEUGO1QgLsUw4UVW8gu9/njgqd1x3amgYjdI
	3VQTYPJUH5GPRmYm9uLRYv7NHivY/+K3bIgsyigUioKp8smDddelR+Nqmk3NRK+0kie4gHg==
X-Gm-Gg: AfdE7cl0YV1vQibaL6v+lTTpgNbsnfHqVTzs8OS9sVOR9TiZpowFfBhMwwDE5cIT1go
	zaBiXfnYtdXBnBDKXBdw5gWMBBYKD/cJyU2e9a2+eDFgO1/pqV1jLL1R408hlwCwsI5ASI17GFi
	fW0if6+fDG8b1CMfPpznktStMZxcz+2W52WdjRzgFHBRqrKdIp6BeNewE09Zcq2UdbrSiNuPdOh
	xeMvZtRsLbM5PfRS2qcjRDNHZZGazuk6HdiTe946InQ8BQpjZFoanCwTGV7tqdWsA51rBYgj3/T
	Bjz4iBFqifG53Gxn88SBHhjc4TLbykDKeOw5/tWxqU8TllVUDmn2YYFXDjkcGdZ8U4fzq/CRWYz
	22nyOhvi5TtfsVRrV8ZPGpgkjL0KPk96JFFCb3u4MgucflQYFs2JP/1xpTQGTwMZpT86kdwY/Vr
	3DaZtihg==
X-Received: by 2002:a05:6a00:400d:b0:845:e1a3:107e with SMTP id d2e1a72fcca58-845e1a31c43mr4488918b3a.52.1782699872805;
        Sun, 28 Jun 2026 19:24:32 -0700 (PDT)
X-Received: by 2002:a05:6a00:400d:b0:845:e1a3:107e with SMTP id d2e1a72fcca58-845e1a31c43mr4488909b3a.52.1782699872341;
        Sun, 28 Jun 2026 19:24:32 -0700 (PDT)
Received: from [10.133.33.8] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a40d23ccsm11383976b3a.36.2026.06.28.19.24.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jun 2026 19:24:32 -0700 (PDT)
Message-ID: <68b96ba9-bb13-48c3-9c57-7bd8ba80f053@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 10:24:29 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v3] wifi: ath12k: add QMI capability negotiation
 for dynamic memory mode
To: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260626084327.2022076-1-aaradhana.sahu@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260626084327.2022076-1-aaradhana.sahu@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAxOSBTYWx0ZWRfX+6u6/76SFp6n
 xBe0GfMxU0Nqf9L9Nqanu3sxij4LrfqYTDXh5ZBQv0TT4pSF/gYEuTMvr3Ok6I5470XmDmYSWjt
 Kt1sovwpeBOQPqIR/wWCsxNQhSq+i70=
X-Proofpoint-GUID: UI0tpBPIKvQzj49d5r7RL_CDufShIpH6
X-Proofpoint-ORIG-GUID: UI0tpBPIKvQzj49d5r7RL_CDufShIpH6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAxOSBTYWx0ZWRfX/+sp52yMpzWo
 tKbKCExE+DVmKjTMHO8tsEqRLPX+nD1HeXzKafMP7u7JW1/M21GU1kZWSkwZqqG+R/V9nR7+gYA
 FwxbBnYoBHvhELBfpYAr3POOxinmgkhrSD4O65vChMdIWOEfIMx0vhfDwTOcWH4xHNlzWu8HqNF
 BufP5KJXJ6syhZcRT4vG/kaCCCZWITN14f7fIw6E2s4XpDVwy+7k0nPubRqNbErGr1NKAg/s/6C
 8Jt6VUu094cByAKyGl8sKHomHBp2B1ArN2/U/VkWe+UTLgDl0/uQrDUUap6MpppLCxp/YCGPUlP
 ligWB6HjqJxisnwerP6nVpH5DmZZqBiMhsMPXVu4nt7XbYiiYCnd0u5GE4EOF+EuCKse8mkDfQg
 5RDkLDUjor4TkhBK56wj2FhrY9GSwj35UL6UYOk2geYtxm+z3LomfWnWfwkklrP2jKvWNovECw6
 jbPO3YSkA3JTgFoN6Tg==
X-Authority-Analysis: v=2.4 cv=R7Mz39RX c=1 sm=1 tr=0 ts=6a41d761 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=vXOABIWjEGlRoqXTTScA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-28_06,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290019
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38239-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:aaradhana.sahu@oss.qualcomm.com,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BA2316D57F3



On 6/26/2026 4:43 PM, Aaradhana Sahu wrote:
> On AHB platforms, firmware operates in two modes: fixed-memory mode where
> firmware uses hardcoded addresses for memory regions such as BDF and does
> not request HOST_DDR memory from the host, and dynamic-memory mode where
> firmware expects the host to provide memory addresses including HOST_DDR
> after the Q6 read-only region and relies on host allocation for all memory
> types.
> 
> Introduce QMI capability negotiation to support both modes. Add a new QMI
> PHY capability flag dynamic_ddr_support which is advertised by firmware to
> indicate it supports dynamic memory mode. When the host detects this
> capability, set the dynamic_mem_support flag in the host capability message
> to signal the host is ready to provide dynamic memory allocation. This
> triggers firmware to send the HOST_DDR memory request and use the
> host-provided address.
> 
> For backward compatibility, if firmware doesn't advertise
> dynamic_ddr_support, the firmware continues to operate in fixed-memory mode
> where firmware uses predefined addresses.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1
> Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.6-01275-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


