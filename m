Return-Path: <linux-wireless+bounces-38983-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id x3QVCvwGVWpwjAAAu9opvQ
	(envelope-from <linux-wireless+bounces-38983-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 17:40:44 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C55674D2B3
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 17:40:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=dHnMPtUA;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=HxMCDm64;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38983-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38983-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A93D33035D77
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 15:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744DA320CCC;
	Mon, 13 Jul 2026 15:35:34 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BC431A572
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 15:35:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783956934; cv=none; b=LGazYvmp8SFOz1GKgh1GH6ufvFSpledcUBlKkesubc6w4PXUv5wOKI5qJwhZhjFZEw3r8BmaZhxLkXip/uKYG5CPK8rNKoF1RGJRIWpkAIHM0RZdkH1G9BtseRzkqBa8TmZMQpLgTrKjem3S/b1DLDSZubuJCSqC66O/9MpT2Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783956934; c=relaxed/simple;
	bh=v0u8vdUqwLHt7rDHLsFBfjgJq5f1VDbowWmwoKPYMJU=;
	h=Message-ID:Date:MIME-Version:To:Cc:Subject:From:Content-Type; b=mMGBKGo7ceerSI9twqQ3U45uvULaYhIP7SnRrAu4ZLAiKjFGECQ5IJyb3z+5ErXI+6lpK0A2Qx25mE7M4WjordugJESWHa6lI4ZwDPPwJa7/FPP7hAJYZ2oo2HJ7mU1PVVAb5wxL49R9wXiRiYP2qMgDpoAD7DnBv6RbfiaASQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dHnMPtUA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HxMCDm64; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DF87A31734693
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 15:35:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=U391dl/rHMTl9C9E5Z5fW5
	rknvjeA+bREnwXmKRRurs=; b=dHnMPtUAX3V+AWzBQXHIqLRCr6rpFOL4zexwqp
	TUK5PdVvJ5eszJE8HvZ+UZD1GIZ0tm6zM+yOJ6Q/ecoETiGxLLCJsIR1EFQmgI9b
	Ep3fbXlHITHwr3xMY7r1CXIvCm2ir5g5NADArfopEtyRoaFBxxu16JAFXOxQiGVk
	qlkbgvUXhR24I3n2McFEajPK9BHvL9bXBDD899YpakNFGv1yxC2mKi0TZBPP1SZW
	0htD37EEBHB+UyvQgN+FFgxj479j8jBqOQmRZmXKicOPnrC+jVFMmfULIOB73zaU
	tlz8eKjvh2k9sKgUaSOe2X+QyikUQeAVnrRCHH0Moyj8hBYg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fctc8j9qy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 15:35:29 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38dbf293831so38499a91.3
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 08:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783956929; x=1784561729; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:from:content-language
         :subject:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=U391dl/rHMTl9C9E5Z5fW5rknvjeA+bREnwXmKRRurs=;
        b=HxMCDm64rJXxZpweo4rYSjZafZR4n3RwLCJBStKNBVyK3dCGFgaSTVBkbSzoJV3aL/
         l8p//ng/B3xClySL9kMW6ky3JOTUGnvb4EWcNNzQDb3PZAmEJ4b5mf/Qss4XjnG52AnL
         /I1bMH32qk+55GbiG9+Vj4A3kYAclPwsD3rA4Qh9Ckt7kmCV1JIupYQrutFSlhSn53Jr
         B84cQ+El2c/mtSVCBvOAPwS9y/uBcUlI2k/HmHNKahMVLGkUT9bAzX8JxxRYNALbKkY0
         F2GVpMuy68HXEzyDNdPCZtlHCukd+vmIFN/1zLLHhoHQM7FaDVa1ojZuthLVlR7bJ6yP
         cp5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783956929; x=1784561729;
        h=content-transfer-encoding:content-type:from:content-language
         :subject:cc:to:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U391dl/rHMTl9C9E5Z5fW5rknvjeA+bREnwXmKRRurs=;
        b=JTQP9e43Tmj0CdkNKWemZ0wv0L/yUQCvPvUeTrfMqeq7T25ptFgqz0Dlq3hs/UWxJS
         iTJtv3LXnCYCrB1Ao06GFJwRubLi1sgbepKXqWXgywJwRYh4l8HzQgQMfUW8rwwLBqR7
         TVpdvmslXDX3mACfY8tswz7X5R+HrwLeMvKZRl4Ve3+NSZGBgcuwhjC4HfyHfvJyLu8e
         PgUPa9xxr0U35TSNgw4zc8FAtwCozvlSyql1WSQ7g2+gp9OqQWImnXhVw38hfre//5vC
         r0qyzLR7g2T2L4IppvLgxu2sQ3DaOfnKyB+Fu99bPVV/OuTNUYJKWGPpaRWAzgYDAb4/
         pmIw==
X-Gm-Message-State: AOJu0YxBgdvpOcThZIVORpBzl72rPsGLO5W1b44J1Ra37TTC1cC/zrhr
	FoppAJCVyZSrSqRo580OA1Y1tIfg0hzGish5EiTy23Imi8XwKRjVyVvjyltal3tP8Si4cDmiJ8R
	hyIhsh6i2x6rB7j1ZQ5UrA5Dr4tnMrqyBaW6vsQljcew1H3GrxW89QG9hwCetsbA9Jx8hR4ouiS
	CJFg==
X-Gm-Gg: AfdE7cn/UTaxwYE5gq2uxBnZhqyxoK+Cd4AHy69mq3CV5xBFk93p49/fF+BpbziZy3A
	LwrmpTPbFa83ROPgpz091rPUyjApwteQWPVKEKm7PVJYV6VBQiA7Q57eObzQjpcogZMPmS07E9A
	mbD1H7gz827hxIB7nDCC5H21uW0ypE1OodJtkA3lx8gCjS81nX633JlPZ834eXdQJO+GOH3jA5y
	lPUqLAcw6lVXCseTMQHTnFWTLG89+4RsBsrigaFCXS/GVPuV8ZPwQTdfDrTmVecKAPMBtCAJ6Gr
	XBFbP8fIUxY506i31HTQDf/JEsgyp/swtEnb0Qqu6r59xls9cPPelXSgn/ndySFnnwUvuptRFU8
	7bN6rwgq5CVQ3RgIWqsW/nOU061F20gR1HqN1/S09ZMMSaLc=
X-Received: by 2002:a17:90b:1fc8:b0:38d:ec31:4843 with SMTP id 98e67ed59e1d1-38dec314a44mr5219711a91.41.1783956928880;
        Mon, 13 Jul 2026 08:35:28 -0700 (PDT)
X-Received: by 2002:a17:90b:1fc8:b0:38d:ec31:4843 with SMTP id 98e67ed59e1d1-38dec314a44mr5219688a91.41.1783956928429;
        Mon, 13 Jul 2026 08:35:28 -0700 (PDT)
Received: from [10.81.91.45] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3118ee6091dsm81030633eec.14.2026.07.13.08.35.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 08:35:27 -0700 (PDT)
Message-ID: <c4207979-e004-43ff-9a11-519302a15f77@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 08:35:26 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-wireless@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>
Cc: ath10k@lists.infradead.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, jjohnson@kernel.org
Subject: pull-request: ath-current-20260713
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: CHw7ffnWn-HFSyG6N_zkq7Zs5NVP11Pc
X-Proofpoint-ORIG-GUID: CHw7ffnWn-HFSyG6N_zkq7Zs5NVP11Pc
X-Authority-Analysis: v=2.4 cv=UtRT8ewB c=1 sm=1 tr=0 ts=6a5505c1 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=Zsz1XpRDJix6TB4E5yEA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE2MiBTYWx0ZWRfX2C63Xnz4JS+y
 SesnAXcufL24fyBFlboLGALLhkNwvqT8V1Np4AwNcalFHWMJ1gtncCEAWg86slLTPLapqe3P1zS
 J2yzpfA6eAqb3SMxRv1opJHlvGHwuS4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE2MiBTYWx0ZWRfXz6l43uaZYT28
 DZSC4BMcr7vf4Fx/aOu8sg9GKVYf6Jr8Tyw7/BJ9hrR0xtCYqxJIT5pinxP7/muTKu9dYQFhIK7
 P7PrtoD82OR2GH4GvxvjHkbQAZITCyXhMKvBWJeoLoe8c0GVbMYlQHl3AwqtDdTD6JdVpqe10gh
 Jrrf6Jfr+QIYKi4ZHFv7X8tKtXMUzIOWVvz6eR6UIFT7SYg6YayaImWCmHoapgD0OZuwJfx7oR3
 yLqOq6G+XRM1hxw9szS+ieJzOseYEv38NSJ5DpqHTsA3PzMuM7bmmzh07hJhYsuEUUboWLPjFFv
 ImyJVqZXVwm0KTpL1Vn6RTi2E8UAMc5hZcl18v5NQuxfXCfRm82lhXMSaeOjylbNcDCjWXR6izT
 iEakS2/gwO1vtTJ8szb0sfl+snI217yTNJgA93//I9uspBAucRCoai6POKN+s3D4UK2KOWDHfvh
 PKkG+rrpWH8Th/DlXHA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130162
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38983-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:johannes@sipsolutions.net,m:ath10k@lists.infradead.org,m:ath11k@lists.infradead.org,m:ath12k@lists.infradead.org,m:jjohnson@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7C55674D2B3

The following changes since commit dc59e4fea9d83f03bad6bddf3fa2e52491777482:

  Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git tags/ath-current-20260713

for you to fetch changes up to a1a21995c2e1cc2ca6b2226cfe4f5f018370182a:

  wifi: carl9170: fix buffer overflow in rx_stream failover path (2026-07-13 06:55:20 -0700)

----------------------------------------------------------------
ath.git update for v7.2-rc4

The most significant change is to fix an ath12k regression which led
to low MLO RX throughput on WCN7850.

The remainder are an assortment of minor bug fixes spread across many
of the ath drivers.

----------------------------------------------------------------
Cheng Yongkang (1):
      wifi: ath9k: hif_usb: don't dereference hif_dev after re-arming firmware request

Daniel Hodges (1):
      wifi: ath6kl: fix use-after-free in aggr_reset_state()

Dmitry Morgun (1):
      wifi: ath11k: fix potential buffer underflow in ath11k_hal_rx_msdu_list_get()

Gaole Zhang (1):
      wifi: ath11k: fix NULL pointer dereference in ath11k_hal_srng_access_begin

Jose Ignacio Tornos Martinez (1):
      wifi: ath12k: fix NULL pointer dereference in rhash table destroy

Manikanta Pubbisetty (1):
      wifi: ath10k: fix skb leak on incomplete msdu during rx pop

Manivannan Sadhasivam (2):
      wifi: ath11k: Flush the posted write after writing to PCIE_SOC_GLOBAL_RESET
      wifi: ath12k: Flush the posted write after writing to PCIE_SOC_GLOBAL_RESET

Tristan Madani (6):
      wifi: ath6kl: fix OOB access from firmware ADDBA window size
      wifi: ath6kl: fix OOB read from firmware num_msg in TX complete handler
      wifi: ath6kl: fix OOB read from firmware IE lengths in connect event
      wifi: carl9170: bound memcpy length in cmd callback to prevent OOB read
      wifi: carl9170: fix OOB read from off-by-two in TX status handler
      wifi: carl9170: fix buffer overflow in rx_stream failover path

Wentao Liang (1):
      wifi: ath11k: fix refcount leak in ath11k_ahb_fw_resources_init()

Yingying Tang (1):
      wifi: ath12k: Fix low MLO RX throughput on WCN7850

 drivers/net/wireless/ath/ath10k/htt_rx.c      |  2 ++
 drivers/net/wireless/ath/ath11k/ahb.c         |  1 +
 drivers/net/wireless/ath/ath11k/dp_rx.c       |  3 +++
 drivers/net/wireless/ath/ath11k/pci.c         |  4 ++++
 drivers/net/wireless/ath/ath11k/qmi.c         | 11 ++++++---
 drivers/net/wireless/ath/ath12k/dp_peer.c     | 11 +++++++--
 drivers/net/wireless/ath/ath12k/dp_peer.h     |  1 +
 drivers/net/wireless/ath/ath12k/dp_rx.c       |  7 +++---
 drivers/net/wireless/ath/ath12k/hw.h          | 16 +++++++++++++
 drivers/net/wireless/ath/ath12k/mac.c         | 10 +++++---
 drivers/net/wireless/ath/ath12k/pci.c         |  4 ++++
 drivers/net/wireless/ath/ath12k/peer.c        |  3 +++
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c | 33 +++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h |  6 +++++
 drivers/net/wireless/ath/ath12k/wifi7/hw.c    |  3 +++
 drivers/net/wireless/ath/ath6kl/txrx.c        | 12 ++++++----
 drivers/net/wireless/ath/ath6kl/wmi.c         | 20 ++++++++++++++++
 drivers/net/wireless/ath/ath9k/hif_usb.c      |  7 +-----
 drivers/net/wireless/ath/carl9170/rx.c        |  7 ++++--
 drivers/net/wireless/ath/carl9170/tx.c        |  2 +-
 20 files changed, 137 insertions(+), 26 deletions(-)

