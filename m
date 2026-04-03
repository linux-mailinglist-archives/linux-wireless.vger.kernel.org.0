Return-Path: <linux-wireless+bounces-34323-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eI5iALmFz2mwwwYAu9opvQ
	(envelope-from <linux-wireless+bounces-34323-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Apr 2026 11:17:45 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BCD392B00
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Apr 2026 11:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 028CD304A120
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Apr 2026 09:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE87345722;
	Fri,  3 Apr 2026 09:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J1rytX0P";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E+pZC2bJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30B04086A
	for <linux-wireless@vger.kernel.org>; Fri,  3 Apr 2026 09:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775207626; cv=none; b=n4YxFek6VAU2+0TQ8LZ4OkeEOpSJARIZkd08HLM6YSrQFwIqS7Ol/qhVLOSnvMj9yXQ0TDyFB1/6kt2tFTkJIKsKUGm1DTYMKBm7if8unnrFG9/E3dGGbR9Tdul2DLzZ9ajy8AwH552lpYdIgnjIl6wfjubNoUQM4WpKLRq860g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775207626; c=relaxed/simple;
	bh=X2VXeMBaIxyZUt/YcVufegZfY5Be+3VO95uEcUTh0N4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S/7uUOveXCtFsZwm/ApZ4zXr79tuYpjUFeq2qFtjzzgJN6RN9K3+zpvF0Y9wtjaX4gFmkqo0v7MOF0RjkqNeEnp01cussw5Zz1ZyBD0bEMrREyv/jQRsk/A4zNDNUunHqnzjthFZpVoU/bCrGGO7kQftOwsep/08KszsERLYfFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J1rytX0P; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=E+pZC2bJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6332IQcH1562171
	for <linux-wireless@vger.kernel.org>; Fri, 3 Apr 2026 09:13:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	O5YFDe8MFBUG75m/VVzNofZ9EsQEjcB7NmOeE9w7w40=; b=J1rytX0PjoSiJRDB
	YEtlUo41CHvxqy3DVcRqJxkwMcLU/sAE2kO0kHLWW79DmaHlKm3Ufix2P5pjt56n
	NhIM7p/JfE1Q4CVyZFfL6U7vgEMl38xMZSTXpgI53xTGhk2hesnDVIUsfP5/ZYpf
	SgwHrfJkq1hdux9Lda/kXnzTEHUfKfA8ZQ0WO0fR/rAv5gbg4r2B/NO2hPt4DNBu
	ljvWb4WRrdMHIav24514Cl5nEkvYYUsk9Mv0mKGE0ZBC5H6bINKfx9SwBvGUHzki
	gAEzfWjFmAmbrKBXlynkEtrTz3cAN0SKraQ8JQnJ72jUc/Etp+2wgRpwJiLPXKzj
	zk0xPQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9um72v6a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 03 Apr 2026 09:13:43 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35da8eb0553so1812175a91.1
        for <linux-wireless@vger.kernel.org>; Fri, 03 Apr 2026 02:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775207623; x=1775812423; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O5YFDe8MFBUG75m/VVzNofZ9EsQEjcB7NmOeE9w7w40=;
        b=E+pZC2bJvjtT6z0T1lFQ5v0EM9eBagyDZG4MBMTypKHLKfJtceMfJ6Apo72MjEviSM
         31rFauwJWtwiG3WVdzBo+Ac4vowf3Io/WI24mTPUjV8ew0tJ1gWd44GNjzclt64ShoVc
         r6U4Mgy5NtYpwYBqNlME459TSqS2EC4NZGtR6uiTNbxtbGsfxrsnIBWU8HwvNvyH22WW
         tgL64GRIrnp1xGA4FgPFYFs9Ugb6ESoS9/fsz3Asyo7xCpCLVOGEKZVCGO20L3xdrplZ
         pv0R+z6Gwms8Tdl7kvqcnt9zlDVokXhBIaR4HBfqvFCmbvNo3iCl+/dyk5GtjPG4MWIt
         JT/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775207623; x=1775812423;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O5YFDe8MFBUG75m/VVzNofZ9EsQEjcB7NmOeE9w7w40=;
        b=TCJob2lsFkAuiM6xANTPRb9f/gKjPPpejWhO6Y2/pK167BdexNedcAbyBvxQXTRdcZ
         ua8c+SkdSy3Ux3mhlHz3u7Bjrmg4R6bUmbajR9Ria3GFyuOLUKj5b5DA0LZek/jRTiO9
         Zr37A7rRnYAgMmoGvs5A8J7/1jm9KI2j/WNmRh9A8nLhud6nRG98dEhay190t2Feo4iN
         E9u987UUM1SRsusmywLUezVleiFpcsSMQ2ToPXsh9QqstHXt4KvolFuH5KUsSTLxnRmQ
         iOULGqR0RGGIOlXN4HT1nZG/l7l2zhh2pdrkjNEnuDM9GdSJAIiccUIr0kuZuxnITwtw
         YRgQ==
X-Gm-Message-State: AOJu0YwcoD1NMTGLlqPgZ9PjDBsLlthN1/rCNTpqUrc2LoOAT7PuBcUg
	Ku9qd5IiYM/VEndBEJnnz82woEk8KV7qwLd04oodvsxUIsvY2FXss8KGPvFiATMul5ZOyT2Ddr8
	Bc77F2MaoEMQNCkBt8sccxH6XEE/HZuThm9uObpkQqpfwkR9hfpNyaJrVH6dJRZOXz2MqSg==
X-Gm-Gg: AeBDieunG7OtwBjGEmSXeVQR10BOLKxmgq4kGZsgmCtYbmiq7+L5p1n3TtgJC8XG6A0
	3bz9Kr8xfXzgMYKtFPK4um2Vd2e7futdu2YhC3pXJeSQFEJA+wWNmYq2NdUwG/IKGU5mgTN9ynp
	/XgoyLXiqMNphrC5PuVzPIpKd1/xKTmpa2NFujiPazoww5UbdBKV7TQlUTj47YjX9sthRItz9Fb
	muz5Ju6xkOLvHO7gBPktMwdx+lXnNL2Ojj3A04nk1PQke5hk0Ai6G8zveEZ2gQZaHAQB0KcWz+M
	ISGrqQ5XOCHhBXYUc7ipQurp82EXXZpBEv30MWrt65pf+Wd/znpq/FkxYhviPsAoD+Ip7Y8+vDM
	QC1LfID8K3RDHkhjFgSy5b3ASSSWcr5qqOSwoPUdqJg28tm4CNP8tiP54Xf65SHL/7MOWtpQ3Cb
	qkgCqdL1aPpzm0zHR/RxA=
X-Received: by 2002:a17:90b:52c7:b0:35b:a44f:b80 with SMTP id 98e67ed59e1d1-35de591e934mr1457560a91.1.1775207623328;
        Fri, 03 Apr 2026 02:13:43 -0700 (PDT)
X-Received: by 2002:a17:90b:52c7:b0:35b:a44f:b80 with SMTP id 98e67ed59e1d1-35de591e934mr1457527a91.1.1775207622493;
        Fri, 03 Apr 2026 02:13:42 -0700 (PDT)
Received: from [10.133.33.111] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dd35f50e9sm5182277a91.6.2026.04.03.02.13.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2026 02:13:42 -0700 (PDT)
Message-ID: <5a606f7d-6665-4b0c-bbbe-32538b2315b6@oss.qualcomm.com>
Date: Fri, 3 Apr 2026 17:13:37 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v4 0/6] wifi: ath12k: Enable IPQ5424 AHB WiFi
 device
To: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ath12k@lists.infradead.org,
        Saravanakumar Duraisamy <quic_saradura@quicinc.com>,
        Sowmiya Sree Elavalagan <sowmiya.elavalagan@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
References: <20260402-ath12k-ipq5424-v4-0-cd1e0f0a6c88@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260402-ath12k-ipq5424-v4-0-cd1e0f0a6c88@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=U/WfzOru c=1 sm=1 tr=0 ts=69cf84c8 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=0McBQ3JIi2lqW2-U6ZoA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
 a=FO4_E8m0qiDe52t0p3_H:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 0ttzsRr-dyoTC7R4oOl9AEL791qB8A4d
X-Proofpoint-ORIG-GUID: 0ttzsRr-dyoTC7R4oOl9AEL791qB8A4d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDA3OSBTYWx0ZWRfX5elGi2nFoi+j
 pOPERnvuzHoO94vyothmHdL+a1SApfTDfZz/dDNZNErx0nVMBmwqD+z91wU+gOsukeB6mzKeCzV
 s4jHI67YQYAhHspSY2rMsffQr99KGGAuL0InjjCfSrd8Ac8MtxbTndbRwQgLuN0w7x7TL5jpWyg
 2v5W3Y+emgqKs1o1ufgpBKoWUHJo+awmn3rLE5j1s0ghSU/8cVOz7kHGTbd8BvVsXowjJbSO7Nx
 /urU7xabhTv3deGj7DUGun+3How2I1JUkaZCaZ8ybQaW+dvhcQxbYPxvRZ3k2lfop6ucG0QtwMC
 n1/QLj6XOms1Qw2hQT6x0tr28TqYuxkF1C4kp6M7n2/hcvaZuO5ZE3OoJ+W8Qw8ispFgXLJY0M3
 BJwXfhCI639sjS1JsGAnI/Sawvqs49Fth0ELN2Wyte/GXyZe5ioR8sdA4vexdNvlMDXwzoxHOIM
 jMNdsJ2KftEGDPdAFOQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_03,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604030079
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34323-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 63BCD392B00
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/2/2026 11:53 AM, Raj Kumar Bhagat wrote:
> Add support for the new ath12k AHB device IPQ5424, as currently, Ath12k
> AHB only supports IPQ5332 WiFi devices.
> 
> The IPQ5424 is an IEEE 802.11be 2 GHz WiFi device, supporting 4x4
> configurations. To enable the IPQ5424 device:
> - Add the necessary hardware parameters for IPQ5424.
> - Modify the boot-up sequence for ath12k AHB to accommodate the
>   requirements of the IPQ5424 device.
> 
> ---
> Changes in v4:
> - DT binding: dropped copyright update as per discussion in v3.
> - DT binding: Used DT binding from v2 and retained Acked-by tag.
> - Link to v3: https://patch.msgid.link/20260331-ath12k-ipq5424-v3-0-1455b9cae29c@oss.qualcomm.com
> 
> Changes in v3:
> - DT binding: updated copyright.
> - DT binding: Dropped Acked-by tag as copyright is updated.
> - Rebased on latest ToT.
> - Dropped ath12k_ahb_ops because qcom_mdt_load() and
>   qcom_mdt_load_no_init() now have different number of arguments.
> - Link to v2: https://lore.kernel.org/all/20250518-ath12k-ipq5424-v2-0-ef81b833dc97@quicinc.com/
> 
> Changes in v2:
> - DT binding: Removed the redundant example for IPQ5424, as it is similar
>   to IPQ5332.
> - Added driver probe data structure to eliminate the redundant switch-case
>   logic in the ath12k_ahb_probe() function.
> - Validation completed, hence changed from RFC to PATCH.
> - Link to v1: https://lore.kernel.org/all/20250130051838.1924079-1-quic_rajkbhag@quicinc.com/
> 
> Signed-off-by: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
> 
> ---
> Raj Kumar Bhagat (2):
>       dt-bindings: net: wireless: add ath12k wifi device IPQ5424
>       wifi: ath12k: add ath12k_hw_version_map entry for IPQ5424
> 
> Saravanakumar Duraisamy (3):
>       wifi: ath12k: Add ath12k_hw_params for IPQ5424
>       wifi: ath12k: add ath12k_hw_regs for IPQ5424
>       wifi: ath12k: Add CE remap hardware parameters for IPQ5424
> 
> Sowmiya Sree Elavalagan (1):
>       wifi: ath12k: Enable IPQ5424 WiFi device support
> 
>  .../bindings/net/wireless/qcom,ipq5332-wifi.yaml   |  1 +
>  drivers/net/wireless/ath/ath12k/ahb.c              | 36 +++++----
>  drivers/net/wireless/ath/ath12k/ahb.h              |  1 +
>  drivers/net/wireless/ath/ath12k/ce.h               | 13 ++-
>  drivers/net/wireless/ath/ath12k/core.h             |  1 +
>  drivers/net/wireless/ath/ath12k/wifi7/ahb.c        |  8 ++
>  drivers/net/wireless/ath/ath12k/wifi7/hal.c        |  7 ++
>  drivers/net/wireless/ath/ath12k/wifi7/hal.h        |  3 +
>  .../net/wireless/ath/ath12k/wifi7/hal_qcn9274.c    | 88 ++++++++++++++++++++
>  .../net/wireless/ath/ath12k/wifi7/hal_qcn9274.h    |  1 +
>  drivers/net/wireless/ath/ath12k/wifi7/hw.c         | 93 +++++++++++++++++++++-
>  11 files changed, 231 insertions(+), 21 deletions(-)
> ---
> base-commit: 15551ababf6d4e857f2101366a0c3eaa86dd822c
> change-id: 20260331-ath12k-ipq5424-cddb63a46a97
> 

only nit in patch 2/6, so for patches 2-6/6:

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

> 


