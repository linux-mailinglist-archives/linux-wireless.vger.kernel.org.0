Return-Path: <linux-wireless+bounces-32312-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AORuEW0ro2kr+AQAu9opvQ
	(envelope-from <linux-wireless+bounces-32312-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Feb 2026 18:52:45 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3331C5287
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Feb 2026 18:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6D89530FACF1
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Feb 2026 17:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F9434DCD1;
	Sat, 28 Feb 2026 17:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kSSbuRNj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BVCOyayN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655CC34EF18
	for <linux-wireless@vger.kernel.org>; Sat, 28 Feb 2026 17:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300059; cv=none; b=fsHWCLzPjL5Vdch1m7G6V90r+BtgjFXdwBHOl+1ehxIvA7QUd6BXVbGLbhXVR4DlzeKxhdU+hKARV0xpufxnv+/e9Vr8q9SqQJa20tE2CSim9Crfr9zg0WA2m7tzR5mVGtluyk9AnQnZ9kqT4fkx40wUXuHH17n0BKH8yrabqSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300059; c=relaxed/simple;
	bh=hkZv4R2zNHOUHNQQDGVtUKZ5rfjsR6aI7SKFsAu0hBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NZuQ6YIiuec9m87omqAeKYmfTnB+KLZlAzPFydahMVPdLBbP6N+oIHGyyZNW5jiZvWKupdzr5UTGSf4lRMJkEG4AvG2abRoMtwxz+T+smcua5lsrLp8HPhwdgNHu9MnU0lkQp8F0xj9hc28hHgJGZj3t5LTYiJiajWxMtseQE1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kSSbuRNj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BVCOyayN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61SH02ue909503
	for <linux-wireless@vger.kernel.org>; Sat, 28 Feb 2026 17:34:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	a0fFfO0ZQhwAkJNDcDYSS5AH311BSoJ/QxT7ERmHq4A=; b=kSSbuRNjXaoVlUDz
	LqVvUO/N8qExFcbG9tc7G415XRwa4aLOVimHZN3eDrSYb9GSqhdKihH3ISLktE18
	6xT4cs8KIik8gJ+HTftxUjqXYxDblNXU0GeIoJZZ0pt6cCZRLJGW0OLMJkhtES32
	GKJ+3bWKNAZIMsayWHS71gmnv8w7PLFn62xCgm33yZSRe17dNGz3wlMKI7WAZcZX
	VVlnhMSjuaPRMviwHgo5mrl0x6r6me7LKdZ8H5NLcO6ZeL1Fr2NX4yn1mfXK0x7J
	8IEA0vu8oG0JSHX69KDItrrEASCr3Fw1ysffcE6OgSHCTnCQ9XdZOvPFvZNcwG/E
	Ziu17A==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cksf8hcy5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 28 Feb 2026 17:34:17 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-12711ec96fbso28038108c88.0
        for <linux-wireless@vger.kernel.org>; Sat, 28 Feb 2026 09:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772300057; x=1772904857; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a0fFfO0ZQhwAkJNDcDYSS5AH311BSoJ/QxT7ERmHq4A=;
        b=BVCOyayNBD+y6Yx47LdGY5iOqfmX2F889Npf/kWowX+dxRD/1cqGfz4xaf84ylk4pf
         Y38U+FX7zBqjDOLN7qbPFtFN7WQ5JNyabcmghZr/FnDMqS4P0Yo8anlmP0nJzW9cHux/
         UERWd4Qd1NcbDn9t3mdJYayHoYOmL8t5ZNczK3U1LnLNpaNoGOrnhppa+clUfqSM4Az1
         puEVlBN049itl4HbGC0GP/Z4VulZx6POYBwwTUFpNGGdeOHtwIj+etEEiNv04AtgLrGy
         M2P/4RW0kg3tAZOL5bAt7SB4MHAR3Gk+BkibnNSHleyWf6OxUcn/xybP1DupnVuWMmOa
         oYzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772300057; x=1772904857;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a0fFfO0ZQhwAkJNDcDYSS5AH311BSoJ/QxT7ERmHq4A=;
        b=qTd0BC9Voqtk5frRmOIBxPLkuWfVxVQeg9EoqgQIkW3iPo2yGUZqYaoWVR2ATPZt7Y
         zDBxJFdmYk5kUgfecOCHwj2shrSa4DCEe+9Li7+lTGwNoksHgvPnL/PwgL8fo9faRlMv
         K12EZX1dnJS02iF7Kfov+lVg5iuGFTVNsXxhOsbMCeAaOLbb/Ch+Ul/GHa2R1fLunlcg
         K5lPsoKXXKLQnqqjtdMhBvwnD+yzs92VN4EOEOeSZM7JdT+FKwBs1W6LGUCOxK7B0ijt
         VR8gYBBIceKcq1DcyBGlKJXR0Wu9CpzQY0POG8HYhzZqLKsGtvEayP5YdP0XcJVrWxaQ
         SIfw==
X-Gm-Message-State: AOJu0YxX8RsELghT0rqpb1kYlwq32M9Xn1iE1A2LBSkhH6qHrFSoh28M
	uK2wRT7aAypI93fbkd1qy5c9f3epaKrWeTmu7TUZXIyBP5Zs2b9wA8XLphTWBYB+trDpuaQPZ6e
	qJJwtmKSETVYXT/k3bU4jZbdrm46v9J3E53xzBU0v67KjgRoWdO1PP06nwvaA0Gy2w1hVOg==
X-Gm-Gg: ATEYQzwC840qXq7Jicoav9UHjpAAAbwltbJE8Fv5yiDIbJhpkH0LYzOyKTENc0uSCB0
	4jiJ21f6/TBFGZ78X1RmkVxgUcnPUBy9Oz/ogIsFg+sJCKaezTwEhFMRXzUR8o87yfYId3ckCGI
	4R9e5N9ACAR5AaaqqbrJyZn+cL3oyr0ACS4xGsRXt1YKLMtgxdabxC/9Z2zkevvBdW3I4tBd6Ck
	qk5d9fXc4Vtf/l7xUi05AOPZhH9jjFicWHO4GrKRE5wlmyHIthjRmCI0I9LOFTx3yb9MQnpYAjn
	iEmKF0Jq7YIiRgovfsKFYNLnFSWQnNnZD6SxsOnWxtxIUGkxiDxIAnr71no7i9juCtZXuzuazeD
	DSlfZlYU/hyNoNfzHjI6ENGOv/Eh8etopGE/DeLOqXnQ3c2FXQgCTcicLs+Fx/g==
X-Received: by 2002:a05:7022:6098:b0:123:2c98:f65d with SMTP id a92af1059eb24-1278fc453c2mr2634906c88.13.1772300056437;
        Sat, 28 Feb 2026 09:34:16 -0800 (PST)
X-Received: by 2002:a05:7022:6098:b0:123:2c98:f65d with SMTP id a92af1059eb24-1278fc453c2mr2634892c88.13.1772300055814;
        Sat, 28 Feb 2026 09:34:15 -0800 (PST)
Received: from [192.168.4.41] ([209.237.159.1])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-127899d499fsm10133238c88.2.2026.02.28.09.34.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Feb 2026 09:34:15 -0800 (PST)
Message-ID: <e007da67-a92b-44a2-a5aa-89444fd087e2@oss.qualcomm.com>
Date: Sat, 28 Feb 2026 09:34:14 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [DESIGN RFC v3] AP Architecture for Wi-Fi-8 Multi-AP Coordination
 (MAPC)
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        ath12k@lists.infradead.org, hostap@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <653a4207-38f8-408c-8067-c4960c11a71f@oss.qualcomm.com>
 <05381371a41f154058429f0a1079204c4a454f45.camel@sipsolutions.net>
 <59cec65b29ded381c85d1be943d88e956a4b7e74.camel@sipsolutions.net>
 <63ff0362-4ee4-4f13-a212-dc1351eefe08@oss.qualcomm.com>
 <52356be3d21920d84579d1a8fd803540c6f9644d.camel@sipsolutions.net>
 <88f05d03-2742-4b61-964f-54beafdd2e70@oss.qualcomm.com>
 <9ea4b65c3fa5750ef57e93dd04b70cc4ec5df445.camel@sipsolutions.net>
From: Abhishek Rajkapur Suryawanshi <abhishek.suryawanshi@oss.qualcomm.com>
In-Reply-To: <9ea4b65c3fa5750ef57e93dd04b70cc4ec5df445.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI4MDE2MiBTYWx0ZWRfXxt8GSCJSY7j9
 XRP/MmTChcaUQryysZL52j9kGTeGXxrbmcql7dApOtDVAGCx0/qNKbkl5Dj9rCESYTkTgWtaLlW
 xO1IIpD8m5LBvmvXmVO/Rzn8NV6SQ7fd4z5jTglIrbltxVBTggP2nX+ClxjCnpn6lEaCna1cnDG
 01VlVbFubmnQPsy/kZiBH+3pUGbbi44wfJS0GB6Xlnjrr8gkZ/YLC8qRyPFoxlF9v4o47/BVzLW
 s+DAfNG9HxtOX7Efc592LXzdCaDfY7XaWJIsG+X4JvHdiHvGs3mrRzOJdQ509lPzzcLcSRUEvCo
 SdZnNDCaWj97KlNNdpLFua+YNHH2WIZIOWLNQRKgOB4/IFoT+SI2fiRvySEQQfqQbI73ZEmdtd7
 PIGr7NG+U7U2fufC937SJhxm0Q4LnYz1/LHpQ7F7UDSKniTD/ZysoEvpGx48GtvG3BR5dApxwoa
 YD50oSZc0Upzqif1wkA==
X-Proofpoint-ORIG-GUID: NntGnh31up-XhRJ2GqjKl3wY8eM3sgX2
X-Proofpoint-GUID: NntGnh31up-XhRJ2GqjKl3wY8eM3sgX2
X-Authority-Analysis: v=2.4 cv=I5dohdgg c=1 sm=1 tr=0 ts=69a32719 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=T8DXQ4rxpc9enYjWm433SA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=AQ0eQXHchLfFNpycfwIA:9 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-28_05,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602280162
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-32312-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:dkim];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abhishek.suryawanshi@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EA3331C5287
X-Rspamd-Action: no action

On 1/27/2026 5:57 AM, Johannes Berg wrote:
> On Thu, 2026-01-22 at 00:42 -0800, Abhishek Rajkapur Suryawanshi wrote:
>>> Taking this specific example, it basically says "FW sends a request to
>>> hostapd, hostapd does the handshake and installs the MAPC station. This
>>> is how we think we should handle the MAPC stations."
>>
>> hostapd controls and manages all MAPC related discovery and MAPC peer 
>> creation part. No trigger from firmware for MAPC Discovery Phase.
> 
> Seems to me you're splitting hairs. Clearly you have the *negotiation*
> trigger (NL80211_CMD_MAPC_NEGOTIATION_TRIGGER) prominently featured in
> the diagrams etc. Sure, it maybe that doesn't explicitly trigger
> *discovery*, but if hostapd doesn't already know about the station that
> the FW/driver is requesting a negotiation with, it probably also has to
> do discovery...
> 
> Anyway. I went to write a long email replying to some of your individual
> points but deleted it again, I feel it's not worth your and my time.
> 
> 
> Clearly, you have already decided on the architecture, and aren't
> sharing all of it, based on reasons you aren't really sharing either.
> Which is fine, I can't claim that we always share the full reasoning
> behind architecture decisions.
> 
> We should all still make it transparent _how_ it's intended to work, but
> that could also be just part of the documentation added to the kernel
> when adding the necessary APIs.
> 
> 
> Which then means that really in all the hundreds of lines of text you
> just wanted to ask whether or not "Option-A" or "Option-B" for handling
> the MAPC peers should be used, and I'd agree that duplicating APIs isn't
> good, i.e. taking "Option-A". Note we did something similar for NAN
> stations, even if they have different sets of attributes than regular AP
> client stations or mesh peers etc.
> 
> johannes

Based on your feedback, we re-evaluated and modified the architecture. 
Here hostapd along with MAPC discovery, will initiate MAPC negotiation 
with discovered APs based on programmed rules(hostapd.conf / hostapd_cli)
& the criteria specified in IEEE P802.11bn/D1.3, sections 37.14.1.3 and 37.14.2.
Additionally, a hostapd CLI command will be added to trigger MAPC negotiation 
for controller-managed APs.


Figure 1: MAPC Negotiation Sequence (ESTABLISHMENT/UPDATE)
---------------------------------------------------------
+----------------------------------------------------------------------+
|                          UHR AP-1                                    |
|  +---------+       +---------+       +---------+       +---------+   | +---------+
|  |         |       |         |       |         |       |         |   | |         |
|  | hostapd |       | cfg80211|       | mac80211|       |  wlan   |   | |  UHR    |
|  |         |       |         |       |         |       | driver  |   | |  AP-2   |
|  +----+----+       +----+----+       +----+----+       +----+----+   | +----+----+
|       |                 |                 |                 |        |      |
|  +----+---------------+ |                 |                 |        |      |
|  | init hostapd & HW  | |                 |                 |        |      |
|  | MAPC support update| |                 |                 |        |      |
|  +----+---------------+ |  MAPC Discovery |                 |        |      |
|       |                 |    Request      |                 |        |      |
|       |                 |(MAPC capability)|                 |        |      |
|       +-----------------+-----------------+-----------------+--------|------>
|       |                 |  MAPC Discovery |                 |        |      |
|       |                 |    Response     |                 |        |      |
|       |                 |(MAPC capability)|                 |        |      |
|       <-----------------+-----------------+-----------------+--------|------+
|       |                 |                 |                 |        |      |
|  +----+---------------+ |                 |                 |        |      |
|  |alloc sta_info store| |                 |                 |        |      |
|  |MAPC capa & params  | |                 |                 |        |      |
|  +----+---------------+ |                 |                 |        |      |
|       |                 |                 |                 |        |      |
|    +--+-----------------+-----------------+-----------------+---+    |      |
|    |                     MAPC PEER CREATE                       |    |      |
|    +--+-----------------------------------+-----------------+---+    |      |
|       |                 |                 |                 |        |      |
|  +----+---------------+ |                 |                 |        |      |
|  | Based on configs   | |                 |                 |        |      |
|  | and spec criteria  | |                 |                 |        |      |
|  | Initiate MAPC      | |                 |                 |        |      |
|  |   Negotiation      | |                 |                 |        |      |
|  +----+---------------+ |                 |                 |        |      |
|       |                 |MAPC Negotiation |                 |        |      |
|       |                 |     Request     |                 |        |      |
|       |               (scheme params & APID1)               |        |      |
|       +-----------------+-----------------+-----------------+--------|------>
|       |                 |                 |                 |        |      |
|       |                 |MAPC Negotiation |                 |        |      |
|       |                 |     Response    |                 |        |      |
|       |               (scheme params & APID2)               |        |      |
|       <-----------------+-----------------+-----------------+--------|------+
|       |                 |                 |                 |        |      |
|    +--+-----------------+-----------------+-----------------+---+    |      |
|    |                     MAPC PEER UPDATE                       |    |      |
|    +--+-----------------+-----------------+-----------------+---+    |      |
|       |                 |                 |                 |        |      |
|       |                 |                 |                 |        |      |
|       |                 |                 |                 |        |      |
|       v                 v                 v                 v        |      v
+----------------------------------------------------------------------+


Figure 2: MAPC Negotiation Sequence (TEARDOWN)
-----------------------------------------------------
+----------------------------------------------------------------------+
|                          UHR AP-1                                    |
|  +---------+       +---------+       +---------+       +---------+   | +---------+
|  |         |       |         |       |         |       |         |   | |         |
|  | hostapd |       | cfg80211|       | mac80211|       |  wlan   |   | |   UHR   |
|  |         |       |         |       |         |       | driver  |   | |   AP2   |
|  +---+-----+       +---+-----+       +---+-----+       +---+-----+   | +----+----+
|      |                 |                 |                 |         |      |
|      |                 |                 |                 |         |      |
|      |                 |                 |                 |         |      |
| +----+---------------+ |                 |                 |         |      |
| | Based on configs   | |                 |                 |         |      |
| | and spec criteria  | |                 |                 |         |      |
| |   Initiate MAPC    | |                 |                 |         |      |
| |    Negotiation     | |                 |                 |         |      |
| +----+---------------+ |                 |                 |         |      |
|      |                 |MAPC Negotiation |                 |         |      |
|      |                 |     Request     |                 |         |      |
|      |                 |   (TEARDOWN)    |                 |         |      |
|      +-----------------+-----------------+-----------------+---------+------>
|      |                 |                 |                 |         |      |
|      |                 |MAPC Negotiation |                 |         |      |
|      |                 |     Response    |                 |         |      |
|      |                 |    (ACCEPT)     |                 |         |      |
|      <-----------------+-----------------+-----------------+---------+------+
|      |                 |                 |                 |         |      |
| +----+----------------+|                 |                 |         |      |
| |If agreement count   ||                 |                 |         |      |
| |is zero for MAPC peer||                 |                 |         |      |
| |then initiate MAPC   ||                 |                 |         |      |
| |peer delete          ||                 |                 |         |      |
| +----+----------------+|                 |                 |         |      |
|      |                 |                 |                 |         |      |
|   +--+-----------------+-----------------+-----------------+---+     |      |
|   |                     MAPC PEER DELETE                       |     |      |
|   +--+-----------------+-----------------+-----------------+---+     |      |
|      |                 |                 |                 |         |      |
|      |                 |                 |                 |         |      |
|      |                 |                 |                 |         |      |
|      v                 v                 v                 v         |      v
|                                                                      |
+----------------------------------------------------------------------+

Abhishek

