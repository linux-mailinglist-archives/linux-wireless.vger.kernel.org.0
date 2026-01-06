Return-Path: <linux-wireless+bounces-30379-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7A4CF66D9
	for <lists+linux-wireless@lfdr.de>; Tue, 06 Jan 2026 03:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDB0F3013979
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jan 2026 02:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FAC7223DC1;
	Tue,  6 Jan 2026 02:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bs6X94Uw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FqPR1GqR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D08226CEB
	for <linux-wireless@vger.kernel.org>; Tue,  6 Jan 2026 02:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767665592; cv=none; b=KspWg+wV3DqpJw+Z59LM3RF28AcFsUho7WpBU44C7IyNZzVaXhwxSrJeZPTsUHar3fJ/NKRbmNqtweOI8ZDCepqlbEiFPU/lny/iOOEYJkrkVhxYkbE6QQk9Yche4iOgc/2a1MydyEuAclZa+QUHu1zVxRQ+/zsWh0smZvgWNc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767665592; c=relaxed/simple;
	bh=UzdO4Uv+yeH67fJIxsi8LLD72k4N7buHQqPC4HSs4gU=;
	h=Message-ID:Date:MIME-Version:To:Cc:Subject:From:Content-Type; b=dXtMqs8OT8o4MXk3WnEi37GjSa194Mxf44MCRjzA5daE5kfTCQikzOQU3joXBcCOQEPoCliS36ygdLEYn8yTulpe2dar9kR6GzRo6UgKPfSS+pkDHp0Jm7ETbIGEELSlqBKK3gfaquWJaKVNEXjUnp7CXYn9mYURlhsBTFVK0gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bs6X94Uw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FqPR1GqR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6060oWbq2107267
	for <linux-wireless@vger.kernel.org>; Tue, 6 Jan 2026 02:13:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=fqBVlJP8W0Ul/gyJXZHa7K
	8iOJjfBhqduGh/v2kAtHM=; b=bs6X94UwB2x2CjzU1MTqE7iFoxFIai7Y6nRVob
	tg7yBDZbjG4AvPmuu8czico0S6f7u+SodB5BVyGP0maIwWKxCnmuyIaq8xMXNf5W
	/JvCI/epX+cwPR6mKBS7jvxmN2IyFdgoFNiABzlaRWrdbEPOitUdlhptUeI10bw8
	fBH9ImcgNO97Z8YyZsDSRDu+nqro693DnHrskZJYj9yYsDTXaYSXfrTYH9KS63N0
	sslOvku80d5ZbhXvZO6fpoHG/NppBo56DyN8n0/GdPqDdqz1KskJd81+V/3GJfPK
	4FfAGh/lfrozmQChLqISGMI8IMOMvVBuuQIS2MktwvMcngXg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bgr7385um-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 06 Jan 2026 02:13:09 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-34eff656256so1230856a91.2
        for <linux-wireless@vger.kernel.org>; Mon, 05 Jan 2026 18:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767665588; x=1768270388; darn=vger.kernel.org;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fqBVlJP8W0Ul/gyJXZHa7K8iOJjfBhqduGh/v2kAtHM=;
        b=FqPR1GqRqwcQjuLVC1szQInT/E2fGM0IPbunLpYvhuk8mNJdCRGzGv0jHao4TZp6qB
         PW0G91dBq2E0/Iq9nevqRzzsFkc/WjFrqVsOwpxveDj5jWGEdbZ7JCnMaG5p6jIIbYyw
         IvPzEl8b1tR50w73ejAED+oKkfnbDD/WomnJacb3cj6J7knTOC7TUTq9akFMrd4BwfV9
         2N743QWCKn9WfYhTjbl2E5eBaN60uJz/7aSfZplbRBKIxSNjlGRghXe7eK2QhhEuALde
         +B1nS51CQf90Lzg6hQHCSpLcYgFfwVkrWgGCowhoLYnZfPgs5WHgLgMY5obFLhmv194y
         Fcwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767665588; x=1768270388;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fqBVlJP8W0Ul/gyJXZHa7K8iOJjfBhqduGh/v2kAtHM=;
        b=IXoGnOtXyzVFFhqu+Zcbn94Q7qJB6kRtH1KN8GV1LunAd2yuSX1P/5xROscDDepVMD
         6Wi6uz8xSWfYg/GK23ERIcyM3BOI4yIm1WMUnb4do8sHHa8M8t+UQ8gCPlYwYcYzM6lz
         GnN8ZnhZhiXEVJfbbUzU1LOw+0lOIMj0Sk0Szb7U7Sk15XlgdtwsN5H/wGCzuC0VAaWz
         5Z9VPdsIoSZ7aoK+CeX3VBAYxrVCM1XRGFAJHAKVaBCUndNySUYstJX3a2YAot14q5J5
         jSsEPJW9xkTn9zQip09m8y3Bwnuswv0aFkXcsmI5s4ePESmcj9z+YBuall3IaLcr0cU9
         tYJw==
X-Gm-Message-State: AOJu0YyjULpBl+e4nYJuOxi/FvzVQSkdeD/VlxXR/CE6F7hhgHz4mvwz
	lQ7X6a3vaegf4TdFAFAT71dBRXJvjOeLA6e/p5ACxw5tZwBqH0EhV8WETGfyXaY1rGAuIy3W0/L
	zUZMEFa9+tyfTCPUasRXZcdpxHDHThI2CWQfW1k8chT0C5pN8HMFrzYr/6XDqoLBFhiFJlY+VFw
	UyRg==
X-Gm-Gg: AY/fxX5jnsMKwnEZtZa20oj3c+4ml/0VaSoVuUEs+xBgsXDsH0fe7Y2fKqav668AiAF
	KJ5yHeLtJ3AlMb3ohPaE7IoKqhqTuc/+5nB8xjX8y1jA+PfnrXwopf5bsullG3PDMUKHqEO5SpB
	5VJ6bqfNaoeSNMHwxsM811yiK5hwxwn6wigiFjIofUTnuFdUL040lh9zi0ABCF6cq1jQkaL+QfB
	+Ep+NFHtBlMbwam8Goy9gyRUPrzsJts9n5KunqL+9IQlplzGNyO/4TApQXTMXkkoSg/gWmkYjfe
	pSDs+/cDVmDqKzk8ySEQJMImYCsV6K0UpAyyzv6LwUF9ADtml4UBaF1v/JCT62RtKO+8obMAzza
	WeUGAjdEWnc9ILAVctlhjKHqok6Lk6VL/aj5NvA5EK2MXiQ==
X-Received: by 2002:a05:7022:6ba1:b0:11b:1cae:a0fa with SMTP id a92af1059eb24-121f18278e4mr1692585c88.0.1767665588196;
        Mon, 05 Jan 2026 18:13:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPLYS1SUQRcFX+9WGJoDBCE7WPO/nyvU53n8et8MAyQsi8zio7Bmzx5LEl7PwxE1A8poWzyw==
X-Received: by 2002:a05:7022:6ba1:b0:11b:1cae:a0fa with SMTP id a92af1059eb24-121f18278e4mr1692553c88.0.1767665587451;
        Mon, 05 Jan 2026 18:13:07 -0800 (PST)
Received: from [10.81.91.45] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f243ed62sm1755216c88.5.2026.01.05.18.13.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jan 2026 18:13:07 -0800 (PST)
Message-ID: <4ba3aecf-5194-48e3-a112-31da3a8646aa@oss.qualcomm.com>
Date: Mon, 5 Jan 2026 18:13:06 -0800
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
Subject: pull-request: ath-next-20260105
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=QrxTHFyd c=1 sm=1 tr=0 ts=695c6fb5 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=rOUgymgbAAAA:8
 a=hIcQITZmgDee9vmefioA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
 a=MP9ZtiD8KjrkvI0BhSjB:22
X-Proofpoint-ORIG-GUID: 6jCQEryy9urhJhIkDxzt3bnhOwVgrKwC
X-Proofpoint-GUID: 6jCQEryy9urhJhIkDxzt3bnhOwVgrKwC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDAxNyBTYWx0ZWRfX48w/XSmPHjRE
 /rVUZmoPjGdCQU7ezJK/t489TnuQ0iMs5u0xK9t1D/tEghuWy+i51ejsShYjW2fdhm/YVaG4ifH
 fqNgs8Ytn76Er1CIPJte+e8vCkkw2rcpRNZSMWWDkhgdBYOpZ8ltgoZ07qXjYRNLt1P2L35Tgex
 RDJ3Wu1WaDht4578r4OR48qF/G7CErp7litqVv5jUeDNB6GczpvYr1AxPumQg7NtZcYBMGEvZRi
 ekd/0ftK5hVWG2zVctt4em9qz+kSWpRwpirbiUB1HDccJTYySO6KrDlSIgYwPgC4ujjipT9ucLg
 m783zYn4OOT+lr73R2AIqNeQAwgd2x0qzC4qcyMrWtO5yDHhMIwX8i4qVCE2NFKChonAFqD4lp7
 0AYVKhhpjylAXxNC8j5VCQjpsIfA7kRkHDNvYtbND7aLbAF41ntuy8phglUdyp/89QN6HvvHyI0
 B9Cn+dEpOAQ+fOHSiBQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601060017

The following changes since commit c99ebb6132595b4b288a413981197eb076547c5a:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-11-13 12:35:38 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git tags/ath-next-20260105

for you to fetch changes up to 631ee338f04db713ba611883f28e94157ebb68e5:

  Merge branch 'ath12k-ng' into ath-next (2025-12-15 08:55:21 -0800)

----------------------------------------------------------------
ath.git patches for v6.20

Propagate the "Next Generation" of the ath12k driver to wireless-next.

NOTE TO MAINTAINERS:
There is a conflict between this tree and the MHI tree. This conflict
has already been resolved by Stephen Rothwell in linux-next. Please
refer to his resolution comments in:

https://lore.kernel.org/all/20260105154243.7cd5d049@canb.auug.org.au/

----------------------------------------------------------------
Alok Singh (12):
      wifi: ath12k: Move monitor ring processing to Wi-Fi 7 module
      wifi: ath12k: Move monitor status processing to Wi-Fi 7 module
      wifi: ath12k: Move MPDU pop functionality to Wi-Fi 7 module
      wifi: ath12k: Move RX status TLV parsing to Wi-Fi 7 module
      wifi: ath12k: Move TX monitor functionality to Wi-Fi 7 module
      wifi: ath12k: Move HT/VHT SIG processing to Wi-Fi 7 module
      wifi: ath12k: Move HE SIG processing to Wi-Fi 7 module
      wifi: ath12k: Move EHT SIG processing to Wi-Fi 7 module
      wifi: ath12k: Move remaining SIG TLV parsing to Wi-Fi 7 module
      wifi: ath12k: Move MU user processing to Wi-Fi 7 module
      wifi: ath12k: Move MSDU END TLV processing to Wi-Fi 7 module
      wifi: ath12k: Remove Wi-Fi 7 header dependencies from common ath12k module

Baochen Qiang (2):
      wifi: ath12k: add the missing RCU lock in ath12k_dp_tx_free_txbuf()
      wifi: ath12k: move firmware stats request outside of atomic context

Harsh Kumar Bijlani (14):
      wifi: ath12k: Move HTT code in dp.h to newly introduced files
      wifi: ath12k: Move HTT Rx specific code to newly introduced files
      wifi: ath12k: Move HTT Tx specific code to newly introduced files
      wifi: ath12k: Move HTT specific code from dp.c to newly introduced files
      wifi: ath12k: Refactor ath12k_vif structure
      wifi: ath12k: Move DP related functions from peer.c to dp_peer.c file
      wifi: ath12k: Rename ath12k_peer to ath12k_dp_link_peer
      wifi: ath12k: Add hash table for ath12k_link_sta in ath12k_base
      wifi: ath12k: Move ath12k_dp_link_peer list from ath12k_base to ath12k_dp
      wifi: ath12k: Add hash table for ath12k_dp_link_peer
      wifi: ath12k: Define ath12k_dp_peer structure & APIs for create & delete
      wifi: ath12k: Attach and detach ath12k_dp_link_peer to ath12k_dp_peer
      wifi: ath12k: Use ath12k_dp_peer in per packet Tx & Rx paths
      wifi: ath12k: Move DP specific link stats to DP link peer

Jeff Johnson (1):
      Merge branch 'ath12k-ng' into ath-next

Kiran Venkatappa (13):
      wifi: ath12k: Restructure PCI code to common and Wi-Fi 7 specific logic
      wifi: ath12k: Move Copy Engine configuration to Wi-Fi 7 specific file
      wifi: ath12k: Move Wi-Fi 7 WMI configuration to dedicated file
      wifi: ath12k: Move Wi-Fi 7 MHI configuration to dedicated file
      wifi: ath12k: Rename hw.c to Wi-Fi 7 specific implementation file
      wifi: ath12k: Rename ahb_hif_ops to reflect generic usage
      wifi: ath12k: Restructure ahb.c into common and Wi-Fi 7 specific modules
      wifi: ath12k: Move Wi-Fi 7 specific init routines to dedicated file
      wifi: ath12k: Move hw_init invocation to target-specific probe
      wifi: ath12k: Modularize driver into common and Wi-Fi 7 specific components
      wifi: ath12k: Rename ath12k_* symbols to ath12k_wifi7_* for clarity
      wifi: ath12k: Remove HAL defines from shared PCI code
      wifi: ath12k: Remove HAL define dependencies from shared AHB code

Pavankumar Nandeshwar (46):
      wifi: ath12k: Move hal_tx and hal_rx to wifi7 directory
      wifi: ath12k: Move hal_tx.h file to wifi7 directory
      wifi: ath12k: Move hal_rx.h file to wifi7 directory
      wifi: ath12k: Move HAL Rx wrapper APIs to dp_rx.h
      wifi: ath12k: Move Rx error related functions to wifi7 directory
      wifi: ath12k: Move hal_desc.h file to wifi7 directory
      wifi: ath12k: Move rx_desc.h file to wifi7 directory
      wifi: ath12k: Move rxdma ring config functions to wifi7 directory
      wifi: ath12k: Move rx error and defrag functions to wifi7 directory
      wifi: ath12k: Move regular msdu processing functions to wifi7 directory
      wifi: ath12k: Move srng processing to wifi7 directory
      wifi: ath12k: Separate arch specific part of RX APIs
      wifi: ath12k: Move arch specific REO functions to wifi7 directory
      wifi: ath12k: Move arch specific rx tid and related functions to wifi7 directory
      wifi: ath12k: Move arch specific tx APIs to wifi7 directory
      wifi: ath12k: Move ath12k_dp_tx and related APIs to wifi7 directory
      wifi: ath12k: Remove non-compact TLV support from QCN
      wifi: ath12k: Replace ops with direct calls for rxdma ring mask
      wifi: ath12k: Move hal_rx_ops callbacks to hal_ops
      wifi: ath12k: Add new infra for the rx path
      wifi: ath12k: Change the API prefixes to ath12k_wifi7 in tx/rx
      wifi: ath12k: Move srng config and hal_ops to hw specific hal files
      wifi: ath12k: Initialize desc_size through hal_init
      wifi: ath12k: Initialize hal_ops through hal_init
      wifi: ath12k: Move wbm_rbm_map to hw specific hal files
      wifi: ath12k: Move hal_params and regs to hal from hw
      wifi: ath12k: Add direct HAL pointer in ath12k_dp
      wifi: ath12k: Use hal handle instead of ab handle
      wifi: ath12k: Move HAL CE setup and SRNG related APIs to wifi7 directory
      wifi: ath12k: Move HAL SRNG shadow config and get ring id APIs to wifi7 directory
      wifi: ath12k: Move HAL CE desc related APIs to wifi7 directory
      wifi: ath12k: Move HAL CE status and set link desc addr APIs to wifi7 directory
      wifi: ath12k: Move HAL Tx, REO and link idle setup related APIs to wifi7 directory
      wifi: ath12k: Move HAL REO and Rx buf related APIs to wifi7 directory
      wifi: ath12k: Move HAL Cookie Conversion and RBM related APIs to wifi7 directory
      wifi: ath12k: Segregate the common and wifi7 specific structures
      wifi: ath12k: Remove the unused ring inits in wcn
      wifi: ath12k: Add callbacks in arch_ops for rx APIs
      wifi: ath12k: Move DP device stats to ath12k_dp
      wifi: ath12k: Add helper to free DP link peer
      wifi: ath12k: Remove the wifi7 header inclusions in common code
      wifi: ath12k: Move ath12k_dp_rx_frags_cleanup API to Wi-Fi 7
      wifi: ath12k: Move ath12k_dp_rx_get_peer_id API to Wi-Fi 7
      wifi: ath12k: Remove arch-specific HAL dependencies from common DP
      wifi: ath12k: Build all the files in wifi7 directory into ath12k_wifi7.ko
      wifi: ath12k: Use dp objects in performance critical paths

Ripan Deuri (16):
      wifi: ath12k: Move the hal APIs to hardware specific files
      wifi: ath12k: unify HAL ops naming across chips
      wifi: ath12k: Remove hal_rx_ops and merge into hal_ops
      wifi: ath12k: Convert ath12k_dp member in ath12k_base to pointer
      wifi: ath12k: Support arch-specific DP device allocation
      wifi: ath12k: Rearrange DP fields in ath12k_hw_group struct
      wifi: ath12k: Add framework for hardware specific ieee80211_ops registration
      wifi: ath12k: Add framework for hardware specific DP interrupt handler
      wifi: ath12k: Refactor data path pdev struct
      wifi: ath12k: Rearrange PPDU radio stats
      wifi: ath12k: Rename hal_ops to ops
      wifi: ath12k: Drop hal_ prefix from hardware register names
      wifi: ath12k: Add lockdep warn for RCU
      wifi: ath12k: Move ieee80211_ops callback to the arch specific module
      wifi: ath12k: Replace lock/unlock with guard()
      wifi: ath12k: Skip DP peer creation for scan vdev

 drivers/net/wireless/ath/ath12k/Makefile           |    8 +-
 drivers/net/wireless/ath/ath12k/ahb.c              |  165 +-
 drivers/net/wireless/ath/ath12k/ahb.h              |   31 +-
 drivers/net/wireless/ath/ath12k/ce.c               |  326 +-
 drivers/net/wireless/ath/ath12k/ce.h               |    7 +-
 drivers/net/wireless/ath/ath12k/cmn_defs.h         |   20 +
 drivers/net/wireless/ath/ath12k/core.c             |   75 +-
 drivers/net/wireless/ath/ath12k/core.h             |  176 +-
 drivers/net/wireless/ath/ath12k/dbring.c           |    6 +-
 drivers/net/wireless/ath/ath12k/debug.c            |    8 +-
 drivers/net/wireless/ath/ath12k/debugfs.c          |    8 +-
 .../net/wireless/ath/ath12k/debugfs_htt_stats.h    |    4 +-
 drivers/net/wireless/ath/ath12k/debugfs_sta.c      |   62 +-
 drivers/net/wireless/ath/ath12k/dp.c               |  559 +--
 drivers/net/wireless/ath/ath12k/dp.h               | 1742 ++-------
 drivers/net/wireless/ath/ath12k/dp_cmn.h           |  106 +
 drivers/net/wireless/ath/ath12k/dp_htt.c           | 1353 +++++++
 drivers/net/wireless/ath/ath12k/dp_htt.h           | 1546 ++++++++
 drivers/net/wireless/ath/ath12k/dp_mon.c           | 3685 +-------------------
 drivers/net/wireless/ath/ath12k/dp_mon.h           |   58 +-
 drivers/net/wireless/ath/ath12k/dp_peer.c          |  690 ++++
 drivers/net/wireless/ath/ath12k/dp_peer.h          |  182 +
 drivers/net/wireless/ath/ath12k/dp_rx.c            | 3522 ++-----------------
 drivers/net/wireless/ath/ath12k/dp_rx.h            |  191 +-
 drivers/net/wireless/ath/ath12k/dp_tx.c            | 1634 +--------
 drivers/net/wireless/ath/ath12k/dp_tx.h            |   39 +-
 drivers/net/wireless/ath/ath12k/hal.c              | 2088 +----------
 drivers/net/wireless/ath/ath12k/hal.h              | 1493 +++++---
 drivers/net/wireless/ath/ath12k/htc.c              |    3 +-
 drivers/net/wireless/ath/ath12k/hw.c               | 1680 ---------
 drivers/net/wireless/ath/ath12k/hw.h               |   94 +-
 drivers/net/wireless/ath/ath12k/mac.c              | 1076 +++---
 drivers/net/wireless/ath/ath12k/mac.h              |  139 +-
 drivers/net/wireless/ath/ath12k/mhi.c              |  132 +-
 drivers/net/wireless/ath/ath12k/mhi.h              |    5 +-
 drivers/net/wireless/ath/ath12k/pci.c              |  237 +-
 drivers/net/wireless/ath/ath12k/pci.h              |   42 +-
 drivers/net/wireless/ath/ath12k/peer.c             |  453 +--
 drivers/net/wireless/ath/ath12k/peer.h             |  112 +-
 drivers/net/wireless/ath/ath12k/testmode.c         |    3 +-
 drivers/net/wireless/ath/ath12k/wifi7/Makefile     |   19 +
 drivers/net/wireless/ath/ath12k/wifi7/ahb.c        |   75 +
 drivers/net/wireless/ath/ath12k/wifi7/ahb.h        |   20 +
 drivers/net/wireless/ath/ath12k/wifi7/ce.c         |  973 ++++++
 drivers/net/wireless/ath/ath12k/wifi7/ce.h         |   22 +
 drivers/net/wireless/ath/ath12k/wifi7/core.c       |   68 +
 drivers/net/wireless/ath/ath12k/wifi7/core.h       |   11 +
 drivers/net/wireless/ath/ath12k/wifi7/dp.c         |  181 +
 drivers/net/wireless/ath/ath12k/wifi7/dp.h         |   20 +
 drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c     | 3385 ++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wifi7/dp_mon.h     |   23 +
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c      | 2202 ++++++++++++
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h      |   59 +
 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c      |  978 ++++++
 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.h      |   16 +
 drivers/net/wireless/ath/ath12k/wifi7/hal.c        |  705 ++++
 drivers/net/wireless/ath/ath12k/wifi7/hal.h        |  564 +++
 .../net/wireless/ath/ath12k/{ => wifi7}/hal_desc.h |  298 +-
 .../net/wireless/ath/ath12k/wifi7/hal_qcn9274.c    | 1032 ++++++
 .../net/wireless/ath/ath12k/wifi7/hal_qcn9274.h    |   45 +
 .../net/wireless/ath/ath12k/{ => wifi7}/hal_rx.c   |  221 +-
 .../net/wireless/ath/ath12k/{ => wifi7}/hal_rx.h   |  422 +--
 .../ath/ath12k/{rx_desc.h => wifi7/hal_rx_desc.h}  |   55 +-
 .../net/wireless/ath/ath12k/{ => wifi7}/hal_tx.c   |   23 +-
 .../net/wireless/ath/ath12k/{ => wifi7}/hal_tx.h   |   30 +-
 .../net/wireless/ath/ath12k/wifi7/hal_wcn7850.c    |  805 +++++
 .../net/wireless/ath/ath12k/wifi7/hal_wcn7850.h    |   39 +
 drivers/net/wireless/ath/ath12k/wifi7/hw.c         |  945 +++++
 drivers/net/wireless/ath/ath12k/wifi7/hw.h         |   13 +
 drivers/net/wireless/ath/ath12k/wifi7/mhi.c        |  138 +
 drivers/net/wireless/ath/ath12k/wifi7/mhi.h        |   11 +
 drivers/net/wireless/ath/ath12k/wifi7/pci.c        |  191 +
 drivers/net/wireless/ath/ath12k/wifi7/pci.h        |   12 +
 drivers/net/wireless/ath/ath12k/wifi7/wmi.c        |  105 +
 drivers/net/wireless/ath/ath12k/wifi7/wmi.h        |   15 +
 drivers/net/wireless/ath/ath12k/wmi.c              |  138 +-
 drivers/net/wireless/ath/ath12k/wmi.h              |    7 +-
 drivers/net/wireless/ath/ath12k/wow.c              |    5 +-
 78 files changed, 20210 insertions(+), 17421 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath12k/cmn_defs.h
 create mode 100644 drivers/net/wireless/ath/ath12k/dp_cmn.h
 create mode 100644 drivers/net/wireless/ath/ath12k/dp_htt.c
 create mode 100644 drivers/net/wireless/ath/ath12k/dp_htt.h
 create mode 100644 drivers/net/wireless/ath/ath12k/dp_peer.c
 create mode 100644 drivers/net/wireless/ath/ath12k/dp_peer.h
 delete mode 100644 drivers/net/wireless/ath/ath12k/hw.c
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/Makefile
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/ahb.c
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/ahb.h
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/ce.c
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/ce.h
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/core.c
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/core.h
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/dp.c
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/dp.h
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/dp_mon.h
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.h
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/hal.c
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/hal.h
 rename drivers/net/wireless/ath/ath12k/{ => wifi7}/hal_desc.h (91%)
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.h
 rename drivers/net/wireless/ath/ath12k/{ => wifi7}/hal_rx.c (84%)
 rename drivers/net/wireless/ath/ath12k/{ => wifi7}/hal_rx.h (75%)
 rename drivers/net/wireless/ath/ath12k/{rx_desc.h => wifi7/hal_rx_desc.h} (97%)
 rename drivers/net/wireless/ath/ath12k/{ => wifi7}/hal_tx.c (87%)
 rename drivers/net/wireless/ath/ath12k/{ => wifi7}/hal_tx.h (88%)
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.h
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/hw.c
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/hw.h
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/mhi.c
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/mhi.h
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/pci.c
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/pci.h
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/wmi.c
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/wmi.h

