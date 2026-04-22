Return-Path: <linux-wireless+bounces-35217-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CErvCejQ6GklQQIAu9opvQ
	(envelope-from <linux-wireless+bounces-35217-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 15:45:12 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1C3446E3B
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 15:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 89DC83004047
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 13:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8374981724;
	Wed, 22 Apr 2026 13:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JWwBRp5y";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DcvyV2AX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E29C126C03
	for <linux-wireless@vger.kernel.org>; Wed, 22 Apr 2026 13:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776864831; cv=none; b=KhSF9g/10NKf+C27PcXnzXAe0IJtS1z3nTu/d6bfw2nvhRWL6ny+xluulTqlhgOfAXSPefJldZtb94TWY0ez//TvDXxu2+0stWp1Gr4RUZ48N4qX2kj8akRFM4faEm8pwGy3qYUH4o2gCZpjNArghAAjrRTsiyK3gL5cEAAHSBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776864831; c=relaxed/simple;
	bh=4j4NWGPFsHfvtb4eIQbqLKEU5VRM4jl98L1Wy5B+oCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rlBelDVkDwp8Mc/FFUSfhpePfjMQqsM4Z9zvWKXw3qnQK3pjSLDHVRVc6XASU5/RDqg3np/bUoaJum/HttIMo7+KpwyJg5n9Go19rqIB13F7d2GnlM6d3vdN+8M7DXzlNTqOXIBKYreySkuAFIBDMrbMlRlvrA5zb+Gdb3VPHlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JWwBRp5y; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DcvyV2AX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63MAMZdu976180
	for <linux-wireless@vger.kernel.org>; Wed, 22 Apr 2026 13:33:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yQ4bPzlWEYxjbJF2kreOp9MPUnQ0acpYT1N59TN47uE=; b=JWwBRp5yiYEvuszc
	5vmuY0T+vuGqB9GymLxDU3t6ZHEXTjN1eugjAvaNYTJu4gsBbsVurHzAr7619j1O
	1QUW+g4uaewoD+p8bXMctqnFIr+UkWjIPofLJl/YK9cQF4Swx2HbrfUP3hCy0j5I
	eDKySbiBcE5GtnUOrmuWaqdw4V8sb3nyattc3OmArpr+qEXdmupK+qxf9M32WGzn
	495dKQ4V3VZpP3c/wT8nJz7yb98dUydHUfNxSdI9C7igW8uOQDOKRrP8HilZi2RZ
	WyQKWbFKgjrwBJu8yU0FKG9iKa7dYNn/A67Tlb226BCHvE6dD6cru/lyFbjVXyRq
	sLMcEw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpenebntc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 22 Apr 2026 13:33:49 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2de07c12745so5078195eec.1
        for <linux-wireless@vger.kernel.org>; Wed, 22 Apr 2026 06:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776864829; x=1777469629; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yQ4bPzlWEYxjbJF2kreOp9MPUnQ0acpYT1N59TN47uE=;
        b=DcvyV2AXXcb/K4+RFJtUyxEtGRmRjCdrEuk5q7fX1+gvKwIw70QNvy0mhcPiHCfuLM
         Ojhlw/Ydgnxykevvh62X0GdU0Hw38Lrt5hYSOkVE21JiG/RXc9o7Bf6002PfDmv3HUaf
         iLT6MPf0NxrlYWi/BsseK8aWFCJXZsQMkQlCuPR6mheTYowbqrN3ljUOUNULV8aJrIRq
         NtV+p/ZYv+xwmqWrIwohrq1n7qc+emXcFAgEz5F7UasJ9AKD0XrXoTwmwdBNxpPFeGOI
         wFdDla6sB+wGIjLMI8PShAC0ctmVyRBgZzHNlyGlVDFhksWj8gkxkFeoMFPy52icUyDS
         xigw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776864829; x=1777469629;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yQ4bPzlWEYxjbJF2kreOp9MPUnQ0acpYT1N59TN47uE=;
        b=NLU5GiW0ni8dFWAd6oXwKGE9lg7oyhVgk04455fn32ZNB5yvE+Xc/XQjwGzmgSBaDK
         jFXoHlmmg8mLOckD8yaVt5NDvIlxiW/bwYQe6jSs2n/xjufcK/uUSKSv0JTtB/JImdfv
         BnZinzoFPNr29Wi3kjwAUdWWZ187OkCtes6NbG4OWiCc5wh//SimctVmgTZKbqEQWmYM
         I8S11ILhQCUF26qlCu9/iGh9j1uGKSjkYkcbKXbM1iDA9AXtSj8rPeHfWE4x5Q0ArGoA
         12lfVYoQrfIGPNOn8pPYkGnhOQHOWLxdpdY25dipla1mu7DrfZWkC3OWQ0iJiZBLI5gx
         X8FA==
X-Forwarded-Encrypted: i=1; AFNElJ/OVdVR+rVDsrwaHkgQC1BNB0YRIokxFO9nLg+w1NgcoHJLzjG7Aq5NSbKkqeZOPH9WKPKzgJJtyQ0sK8tAyQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyyZQUk/eh3C7ELAupu2H4iGB4MtPUm0WaSh+TKFWOp/BSXw3Pc
	hlTiARxmUbN5rT01z7r9LRlDJs9OeMedZFW0N8yVSkAoq9mH9gI3NKfVtFbjF/5HbUUDJ3R2HxC
	8Ilewdmjc1yJiOQ08H4DHdFiukPR9CK5dp+boiw3t/7s2VFFujJPacOyfeciUik29z1jMfw==
X-Gm-Gg: AeBDiesnRmvQG+nFcTxhd89t3yoOt0XQLoqt8oIIMcqyyRMW4JXWueYuvRbEZ/kEJgr
	uJ8823IIV0D1yLTMfI5CEmqEwlOi9KyHmL8MyeD70OJRy+ZrJWAd6PHVmtOV0/qIcR1+M7irxzi
	xNMtp8MxB9Bz2mc1o/FKePuyy9XdSHxH6SBPvRGFYvTnZCc4WIYmr5PbvieZ62W3ehiR3uTCoOL
	GBZa2z5cxm1V04z/coFHINXGAu7rezZ66cWKYJJ97XxsWY4Z1P+yubSEKIUMZsm+OsWZzbfOPil
	ZhPw5PvJPH3gclorpFcP1LAlSR4KgF+b1sUaQ7AaqzJPMe7mh7t6dQ/pJ5CB5FxDhFF3doo7rVH
	HlVSgfTy3DrGdVurQ2TIR6mpLq2Y/mcOwjrceDYjAltUUNkrYAfi4hYT0BuW39Qwwa/9wp0+vtP
	vvNQDqJPjDYeqkQNoH
X-Received: by 2002:a05:7300:6c27:b0:2da:1a81:5ae with SMTP id 5a478bee46e88-2e475b3994cmr13676057eec.10.1776864828536;
        Wed, 22 Apr 2026 06:33:48 -0700 (PDT)
X-Received: by 2002:a05:7300:6c27:b0:2da:1a81:5ae with SMTP id 5a478bee46e88-2e475b3994cmr13676038eec.10.1776864827980;
        Wed, 22 Apr 2026 06:33:47 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d2cfd3esm22934305eec.21.2026.04.22.06.33.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 06:33:47 -0700 (PDT)
Message-ID: <5209fd4c-eee3-46ed-b731-1e822a04b03b@oss.qualcomm.com>
Date: Wed, 22 Apr 2026 06:33:45 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath12k: fix false positive RCU warnings on
 PREEMPT_RT
To: Yu-Hsiang Tseng <asas1asas200@gmail.com>,
        Jeff Johnson <jjohnson@kernel.org>, ath12k@lists.infradead.org
Cc: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Clark Williams <clrkwllms@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
References: <4cdf2e61-fe69-4168-9df7-55bb71585dfe@oss.qualcomm.com>
 <20260421172500.1050754-1-asas1asas200@gmail.com>
 <a396cf77-81ff-45a7-ae62-fb4e22c18497@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <a396cf77-81ff-45a7-ae62-fb4e22c18497@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDEzMCBTYWx0ZWRfXwJkRlVocstJy
 fO22Uep9LxZGp1qTzt31HNg1uygwT+KZ7nCGvpAJ5oB8LLUm6s20zWHNexoMe/n6Rvr06dxWuLw
 i2XY1WeJnmNa73qBAUWtGdt4bM0o+og/i+qAX9Nzx24AWGiMd7+YTfUbjXlb7z8NyDughEW1As7
 XoCBq+1V7Ra8HR3AAR/5nlj+TQJNSN+TPe5SMjsHJQR+k8aXnd3555bivaaIquzjB1zqXz7Hqa4
 roY5Ha8f7o6420epxTw8EtHH5KyD3xNeh9xQiO9KZDziiKoci7xYB8r5SIF3xrpEkEsPsDQmR4i
 VtogIHUsgkD1pCVVD8sw8quSXJFftJn5iN7XQYpjJRowZglj7kpjVNfPgSUeQrPX9ytFLnqiSJt
 6KA7v+NktMu6aqxsIegURjV+QuCYZcKbHKdmvC3PobIHNsle8i+AtoZXF8QMFls2ya9FneT0/fv
 FITqO3koOtc3K8DOOTg==
X-Proofpoint-GUID: EnBWS8rGQll0l8xNgd2eLT1Mi0U54GAO
X-Proofpoint-ORIG-GUID: EnBWS8rGQll0l8xNgd2eLT1Mi0U54GAO
X-Authority-Analysis: v=2.4 cv=RoT16imK c=1 sm=1 tr=0 ts=69e8ce3d cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=t_iSBFEcjObAjGY-HZQA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604220130
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-35217-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2C1C3446E3B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/21/2026 2:27 PM, Jeff Johnson wrote:
> On 4/21/2026 10:25 AM, Yu-Hsiang Tseng wrote:
>> Two functions in ath12k assert that the caller holds an RCU read lock:
>> ath12k_mac_get_arvif() and ath12k_p2p_noa_update_vdev_iter(). Both use:
>>
>>     WARN_ON(!rcu_read_lock_any_held());
>>
>> On PREEMPT_RT kernels built with CONFIG_PROVE_RCU=n, this produces a
>> false positive splat whenever these functions are invoked from paths
>> that do hold the RCU read lock (e.g. firmware stats processing or
>> mac80211 interface iteration).
>>
>> Root cause:
>>
>>   - On !PROVE_RCU, rcu_read_lock_any_held() is a static inline that
>>     returns !preemptible() as a proxy for "in an RCU read section".
>>
>>   - On PREEMPT_RT, rcu_read_lock() does not disable preemption. A
>>     task can therefore be preemptible while legitimately holding an
>>     RCU read lock.
>>
>>   - Callers such as ath12k_wmi_tlv_rssi_chain_parse() (via guard(rcu)())
>>     and ieee80211_iterate_active_interfaces_atomic() do hold the RCU
>>     read lock, so these warnings are incorrect.
>>
>> Typical splat seen on a WCN7850 station with periodic fw stats
>> processing:
>>
>>   WARNING: drivers/net/wireless/ath/ath12k/mac.c:791 at
>>     ath12k_mac_get_arvif+0x9e/0xd0 [ath12k]
>>   Tainted: G W O 6.19.13-rt #1 PREEMPT_RT
>>   Call Trace:
>>    ath12k_wmi_tlv_rssi_chain_parse+0x69/0x170 [ath12k]
>>    ath12k_wmi_tlv_iter+0x7f/0x120 [ath12k]
>>    ath12k_wmi_tlv_fw_stats_parse+0x342/0x6b0 [ath12k]
>>    ath12k_wmi_op_rx+0xe9e/0x3150 [ath12k]
>>    ath12k_htc_rx_completion_handler+0x3df/0x5b0 [ath12k]
>>    ath12k_ce_per_engine_service+0x325/0x3e0 [ath12k]
>>    ath12k_pci_ce_workqueue+0x20/0x40 [ath12k]
>>
>> Replace the WARN_ON() with RCU_LOCKDEP_WARN(), which is gated on
>> debug_lockdep_rcu_enabled() and therefore compiles out entirely
>> when PROVE_RCU is disabled. PROVE_RCU kernels continue to get the
>> full lockdep-based check.
>>
>> Fixes: 3dd2c68f206e ("wifi: ath12k: prepare vif data structure for MLO handling")
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3
> 
> Note that Tested-on: is not a official upstream tag, it is an ath-specific
> tag. Since it is not an official tag, it should be specified separately from
> the official tags:
> 
> <commit text>
> <blank line>
> Tested-on: ...
> <blank line>
> <official upstream tags>
> Signed-off-by: ...
> 
> Unless there are are other review comments there is no need to send a v3 to
> address this -- I can make this change when I pick up the patch.
Amended patch in my pending branch:
https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=pending&id=32f70ee38388bb9089b9cffa9791f5ef8d5d32cd

