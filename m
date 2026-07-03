Return-Path: <linux-wireless+bounces-38564-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jpx+GA1gR2ohXQAAu9opvQ
	(envelope-from <linux-wireless+bounces-38564-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 09:09:01 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C086FF67C
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 09:09:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=nrNDkJDb;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=Imlp9L3u;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38564-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38564-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12B553039CAF
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2026 07:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17B73749EE;
	Fri,  3 Jul 2026 07:04:37 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541BA3019AA
	for <linux-wireless@vger.kernel.org>; Fri,  3 Jul 2026 07:04:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783062277; cv=none; b=DGqOBRW7DqMt/Sy86ZqcafL0B2Ag8kzcLI7I09lBxf90FnWGjHOLjDr/GUcPsarT4R49NOKP8pOIhZBb7HTifnE3WSuZ87CLoURSdvXWW25X8oTOOuKIjABjpUZ9NPsjUxpiDqXxtPIvJtRygVpSUvsHwqAT0BVOLKQ1BphjJEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783062277; c=relaxed/simple;
	bh=oufE9al80XQ66N+B3RYC1+yX6qKZZaAXlQu2oB73wlA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YHF/BIT6MtlhhvZ5FZzqXY2eS+c/EIHK6Vd9sNKrQDtbw4TpCkGIsLkEqoN5T3q8DSOwx9fyBXdEmUZwmLqCchNioY8E0wzyy50Qb/EVyDrRZGX7KSlu6bmcmKiugyOTaPhUrGEzgp8Icf4tMyrJZCJG28Vb8Yh1wIMdltmOh2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nrNDkJDb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Imlp9L3u; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6635rfT22994864
	for <linux-wireless@vger.kernel.org>; Fri, 3 Jul 2026 07:04:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TDBcHrirnFEjY+454YJdrV3UGfnP7gb4/Xl0/8PlRnY=; b=nrNDkJDbZf52vEhD
	mZVr1thBY1A28KrgxnBO/Yy/uvv/KVwgj1HsCtYTGdNsX9klhAnGgVN4NwWUJW3P
	gnbT/i8x/RI6OFgx4QTp9occYnIs3KduMy2+gfgCyRvk7K4zi76LEkwvkO7M+GNM
	Eqggl7kfZklT7elualpvCSCHQnx0M7IV8V5KwWqw0YUoji/3RQ8B6jwx43dFknZe
	n0cvT/16tOjm1BgDEY8PXrJD1X4LrNWelWc5FL3Fa6JCh4iUo80K5sno8IBhIOcV
	XsIL+L8s9Pu5kDESafTLDAYP+ES49rYe2lpWIwOn+fV3hdd1ouk6ImavHuP33aRK
	0crM7g==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f648n14qm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 03 Jul 2026 07:04:34 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-380a0925d7bso516698a91.2
        for <linux-wireless@vger.kernel.org>; Fri, 03 Jul 2026 00:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783062274; x=1783667074; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TDBcHrirnFEjY+454YJdrV3UGfnP7gb4/Xl0/8PlRnY=;
        b=Imlp9L3uv9T6h8oPmKakowIVALiIoX3bdsrycPamIhImYOFKKXe1NzPsj1lzmF+YQI
         18amE9/C9bLWs/gh8z5dLl0Ao/RhsQ3uCp1Y7NmaKuoMVkzDrqZaN4+4zIOSXg+op9Sg
         AfkIAD8PEOi5ImxOxOouBpxPIXVJFXhCEhRa2YPqJVoSCG7jl0w77/Lrfl3uuYD/rNlS
         IvOw0DV7b2bUspp+7FIkLL3zjK0EJDixfKR6v+8gmj+vRbac9+o2vK6SGTstO32lb9ST
         uYnKDbd7RjT7M1XzK4Omh4t04PNHJPBiop0aWG2womDruBiTgPyBMid6EH3p3QbUZG3n
         kaPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783062274; x=1783667074;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TDBcHrirnFEjY+454YJdrV3UGfnP7gb4/Xl0/8PlRnY=;
        b=YsPibmiEh1Ya73U669WdPlP15l9DRX4wBghpsvDqY62GjcqD4dke2fFyrxeMuZ+ifb
         /CnKmrdqdQk1muxW1AChtjC67g4h9i4EW2e4sKuGIe2m7fuSINUFE93Fqk18n5rar+EC
         CAwdRmtqn16LxQIly2Wyb+lVlFqM44FBH7wYJK05t/URAHe7GXMhD1JlK+/vmwNditBE
         rPfKZ0gO+BttswuQ5qRauIi7qsZNPodGQZ1nNNMbfYcnksApYYXXkwPzhHrNyqg0XpjC
         MS3XqCwe90+st1d7AuDCH5ESVjOaO2Esjy6a8MbFlHUbvp9lgWWY6Lx1TciYxdyJLjCB
         9zBQ==
X-Gm-Message-State: AOJu0YxNuGbxSBW2dzC/2HEHn6J6dGgIy8tG+UCCf4FBf/UOJtEcQMnv
	frLQT5A9qkHVaiMTO37DkM/1R8QKtGR41rJHLV/BSlJ892ttBoDwceF+jTnwjjEs/7f9Bj6+xsQ
	VsFRocpDAyLA33VD02pDlKMB4m5dyr+UBd1PyaNU5eLdE8L8WgKeU6BqzqA3MIvFJM+xEKQ==
X-Gm-Gg: AfdE7cmV3CrPxAfAxmLm4ukIVxQizp8zny9n5UwqyaBT2x8RyEzSXwdEM/mOiau+Wnw
	wahCu6AZxXIqrXa4NEAjLZrR3O3YR+3gXjqA/d7Phh5ws8t7Tp8S342dKrBnmECBxk1TsRpVVDR
	DFAJoFl6kR5NNFgJs3smMn2JTC/pNt1CnzCo9fmXFKNIaKKMOQavyjQXjGSXM51tnA36YjXdoCJ
	ekoda31FY4GUEa5QWY2btXJ8okCYKALVoqUi4AIZbR4/ThWpFfsTr935FhU2Y8U8mHAlYID+beX
	78Qw1h0X4TT9Ka0kR8uY9qUTANczmkdO4+lb7LPtnOe/yuX62cqjh5GeKZc8hi7eTHPlt7otOij
	KHmWvwEd2dzvZfN8JqNQ/Gq1zPjWvW6j5f7IVZBc7AjIvH/bKBVGigW1PeuP4qfw9cvNMZjaeLx
	UMFdd+Ku/6
X-Received: by 2002:a17:90b:4d88:b0:37f:bfd6:8b40 with SMTP id 98e67ed59e1d1-380aa0952c0mr9548917a91.5.1783062273654;
        Fri, 03 Jul 2026 00:04:33 -0700 (PDT)
X-Received: by 2002:a17:90b:4d88:b0:37f:bfd6:8b40 with SMTP id 98e67ed59e1d1-380aa0952c0mr9548886a91.5.1783062273034;
        Fri, 03 Jul 2026 00:04:33 -0700 (PDT)
Received: from [10.133.33.211] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38097da4c32sm2853484a91.2.2026.07.03.00.04.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2026 00:04:32 -0700 (PDT)
Message-ID: <4c4b8f9a-32b3-4c8b-bd52-02434695b610@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 15:04:29 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-current] wifi: ath12k: Fix low MLO RX throughput on
 WCN7850
To: Yingying Tang <yingying.tang@oss.qualcomm.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, yintang@qti.qualcomm.com
References: <20260610053315.2249912-1-yingying.tang@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260610053315.2249912-1-yingying.tang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA2NSBTYWx0ZWRfX8kHl6R1iDNB7
 4Kq/6f5EorQy1OLPS5b8YwWhte4jbOgB5eoMLywPn4lWYeOoaV1EIlfvGw7TExsJrGCWEwVTS4y
 W1OgSPklsdp2MuxjLJLPav38qbxnvZs=
X-Proofpoint-ORIG-GUID: HDk6mjsP11V5SjS-EfDNO3aiIAWvCIVl
X-Authority-Analysis: v=2.4 cv=O4wJeh9W c=1 sm=1 tr=0 ts=6a475f02 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=OnWgCjIbBKlE7jiPxrkA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: HDk6mjsP11V5SjS-EfDNO3aiIAWvCIVl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA2NSBTYWx0ZWRfXytJ4CNM/C6bD
 pEE8CWdwiV83x1+74BXwL51f4GLL5SR2+MfuGhIkux/GpAbSZSSW2NoakS4KepNwqX6qlcxIQ3m
 mXItEjyttcdeS61XNBJCPvap1BerODXYu8AOKnVM/sg5PVCP478ciSmsKmIod9WwoEu9qHj0mk0
 Ru/Z6jTtr4MMkylScVClPifV5xvk51yyoPt5eVhzXpg8sPv1KxJ5nd6U8Fj1LbAqGmTqZAwa0th
 SwisjwemnvOczkUrX1r4MkCrG+CsFQfOyo00qQmN/XUUnOCrNnbL2mgwWzeo+mvkia7ofhhbca2
 qUUZ5d760ysvJ2oltLlTu3h1rzDbhKPyKEjQf+lBFn2t9M2ImPE6hmyjb7yKYbutG77Xp+2lIPz
 7fzAarVhr8gKdEPmKc7eMm+lD71KzRvZtmPVNbSVM6anUHf7tmCdTcZGliKMoxh7aJ1DUS82U9b
 BT7lbBldld/74mHlyHw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030065
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38564-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:yingying.tang@oss.qualcomm.com,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:yintang@qti.qualcomm.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,vger.kernel.org:from_smtp,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A9C086FF67C



On 6/10/2026 1:33 PM, Yingying Tang wrote:
> Commit [1] introduced a regression causing severely degraded MLO RX
> throughput on WCN7850.
> 
> On WCN7850, there is only a single ar instance, but MLO uses two
> link IDs. ath12k_dp_peer->hw_links[] is indexed using ar->hw_link_id,
> which causes both MLO link IDs to be stored at the same index.
> 
> As a result, an incorrect link ID is assigned to MSDUs in
> ath12k_dp_rx_deliver_msdu(), leading to severe MLO RX throughput loss.
> 
> Different chipsets identify the per-MSDU link differently:
> 
>   - On QCN9274 / IPQ5332, the host owns multiple ar instances and the
>     per-MSDU hw_link_id from the RX descriptor maps cleanly through
>     dp_peer->hw_links[hw_link_id] to the IEEE link_id.
> 
>   - On single-ar chipsets like WCN7850 / QCC2072, there is only one ar
>     instance for both MLO links, so dp_peer->hw_links[] has just one
>     valid slot and cannot be used to distinguish the two links. To
>     resolve the link, walk dp_peer->link_peers[] and match by
>     rxcb->peer_id, which on the link_peer side identifies the link
>     peer for the MSDU.
> 
> Add a new hw_op set_rx_link_id() so each chipset resolves the link
> on the RX fast path using whatever signal it actually has, and let
> the op itself decide whether to populate rx_status::link_valid and
> rx_status::link_id:
> 
>   QCN9274 / IPQ5332 : always derive link_id from
>                       dp_peer->hw_links[rxcb->hw_link_id] and set
>                       link_valid.
>   WCN7850 / QCC2072 : walk the link_peers[] of dp_peer to find the
>                       link_peer whose peer_id matches rxcb->peer_id,
>                       and set link_valid only when a match is found.
>                       Otherwise leave link_valid clear so that
>                       mac80211 can fall back to its own link
>                       resolution path (via addr2 / deflink).
> 
> For WCN7850 / QCC2072, walking dp_peer->link_peers[] is bounded by
> the number of links actually populated, so introduce a link_peers_map
> bitmap (unsigned long) in struct ath12k_dp_peer that tracks populated
> slots and use for_each_set_bit() to iterate. Non-MLO clients hit one
> slot, current MLO clients hit two; the full ATH12K_NUM_MAX_LINKS
> array is never scanned. The bitmap is maintained with WRITE_ONCE() on
> the write side (under dp_hw->peer_lock) paired with READ_ONCE() on
> both the lockless RX read side and the write-side RMW for KCSAN
> correctness.
> 
> Also guard the dp_peer dereference in ath12k_mac_peer_cleanup_all()
> with a NULL check, since peer->dp_peer can be NULL for self-peers or
> peers not yet fully assigned, the pre-existing rcu_assign_pointer()
> call there had the same latent issue.
> 
> This restores the correct link ID on WCN7850 without changing the
> QCN9274 / IPQ5332 data path, which keeps its O(1) hw_links[]
> indexing.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3
> 
> Fixes: 11157e0910fd ("wifi: ath12k: Use ath12k_dp_peer in per packet Tx & Rx paths") # [1]
> Signed-off-by: Yingying Tang <yingying.tang@oss.qualcomm.com>

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


