Return-Path: <linux-wireless+bounces-35198-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBm6N1Es6GlWGQIAu9opvQ
	(envelope-from <linux-wireless+bounces-35198-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 04:02:57 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BF244139A
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 04:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06C08300E707
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 02:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A384817555;
	Wed, 22 Apr 2026 02:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cyfdFLUy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fK1BOhAK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E38240DFA1
	for <linux-wireless@vger.kernel.org>; Wed, 22 Apr 2026 02:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776823374; cv=none; b=fdn3ZXkKz9XniTXuM/xLtR0f9Rda1NQshTUF+2L6QlS12jy24wELcCUNvL2KRX5Lcxh7Rx5MxStirDqdrkT3DYsC5JFadceJrrPyeqNdQAKxwZoWXB6HbODmrLDhWb/eouLuwCeHQqk+2AdAYSGlrOXtGmiGV0s1KFeSOlmj9ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776823374; c=relaxed/simple;
	bh=nYulCX63OpwmyQNFSm5Jx4LQ6qJghBJpoaQH+flGfho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DFKdZElVSTt5PwLF6fc2GDA/lTqC2IPFz3P5bk3KNEJiki1+vUFKI6gAXDiJBaiN1HPgvkowQpfjBPQkj4kGdvfV+vQ4t6KROaBbsgI1D2hdVULW+nDAY+nek5pgvLiWIvbcCXu+uPkPTMS07qkEm36D8hSU0WMo4EIBGH8oxGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cyfdFLUy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fK1BOhAK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63LIZpCB2209084
	for <linux-wireless@vger.kernel.org>; Wed, 22 Apr 2026 02:02:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5+otJ0aJJ00Va4jp2OqKrQrKwOArOCOKj8wwK4/dtc8=; b=cyfdFLUyPaHRCRht
	UIA/OhVjoXKdfy5G3AZ4d57VPXTWKWrfYD9CqVDUHdt2X1Gbv/eIAlgV6D2MfMZ7
	ftx4Ce1xeRx5TwxbXe57nC97JwyKrGwB9N4qWnwOKUgBaqfHsCMP+9WurQhM8tB+
	h4CykvsE4GLTmoBLCWO47pRt7Gzrftk+/Zn2yDkk2ooFUfgpFAzZ1Bt5WSbmkxuV
	DaF8g5aECVdOWwSeeL3huc1TjbjY9R8+zDn0sbaD6vrKCD4HnZw00MuaLoVmNoUz
	Vzv+3V9NIUJCnO4UraoYGKlHFjXhrbpBZIy7PSPy3BuFG6mu1iX21C4NuEjGXVuO
	wF9HBQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpeng95tg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 22 Apr 2026 02:02:52 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35fb6cd0879so4645391a91.2
        for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 19:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776823371; x=1777428171; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5+otJ0aJJ00Va4jp2OqKrQrKwOArOCOKj8wwK4/dtc8=;
        b=fK1BOhAKFVlQbk3jaKglRO2e5y4+bIOfdXKrlf1FpsPM1CFJuS/tloo80Wyjs6pEFW
         KHytXIK/cJqhzh68N3TNTXAInlrbzNBQM16C8EsQIAVvMy6Z54glwot1qcYrhZwbP4vG
         S3j1PMzHdyCG+wYk9QYFLioa7VtJEE2cvNq6vJ0Rt4Zz0Lmtn3PhonctykOSWIz8GMwm
         j/SdUSdzYrwcUhJ/NpDm4Sv2cxPR930AV41fB3kl4jV/GF4wNWct95S4syLET04gtAtv
         RDxuOvJs+40XsOF02ZusVFjQGwJ6yfkY9K2T9xQhjwPYue40XEdIO+rRk3/P7lpWqZDD
         qrqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776823371; x=1777428171;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5+otJ0aJJ00Va4jp2OqKrQrKwOArOCOKj8wwK4/dtc8=;
        b=dG5L4QOzS5DC2K9bPSGNodUT4uHN8ljSktDfyZGV+KizYDzuovI50WTXxi/8rGsVgF
         6POJBeweMRcMt2glqX86h/FkT8yqrd3KQa9y0U+sOn3Imj5w67R/pjKQt/Zy7TS+G0Bm
         dll9wXVf6Rr3ljdZrD31zFfdydtXuG/bZEiu4NESz4smv5El1hch8vCu4oUCXnGfaaRh
         r+RQkq8YFkO2Tb5GZcTw5BJZF4F7kwxa7dF5FocAONt7hxEc9smat7Qx5a/RBLdvy4G/
         iwLEo9qGMxnH4Xf1zg4CPdcDeNSImUXBe9ugqqlvERgHhg12f2d42lFMnFjhZzNvF/Rf
         /T/w==
X-Gm-Message-State: AOJu0YzrPzs8f0PAe+rS8UvX+aO7jnLj6bCWtRekY7Hf+MOpxj7YZhgK
	wYyPz4p7lPcO+RAX+X4VQsGFGcESr8QV4TVwPr6yBUuuU3jn+PA68RMi5pTNi+QX5wrGZvgG9xe
	ZuopQRG4Q4vf+SSDP9IEFJ8go4/I5D/K1zePVQuvgfVOxPuucMfGSWK6vmCWh2ffSHEZeDm9Ew7
	BVlg==
X-Gm-Gg: AeBDies2/LMX6FzFIWpng5FBSpb1G1cNyiZmQpmmUZ5mGDmDzpUeaCAR+HEbdScpkTn
	p6qJqXJEwFYS7cjZyHuQfztgy443TgQx4J2rYwVoP9wIOjEdo9raK8qOZhQaNuip6X9uaCT+3M4
	qHg4zfI+DyXl+HOeXkK8/EP5T2dG/T14vsbIiCQLvp/586O07ERb4CDT2tdoA2UbGrLTA+WySdN
	aPX2Ter6eaBNUz7Of085WSN8+tXUFerGxhLui0GA3Uv1nclOvAjIVO7gYi1AyfCnq/dsQia6mb5
	iNU6Iasp7oLrXsUbHOWeTpJja4zVAjPB1oHYpmlm+0bgyqBZcUpjnUqgj9Pr/GFbQsQPX3AwqdA
	cZbtA6Kz/fUR+ikpn60yiuh84S66CpG7P6zphvDdeppyhkH1dVfQqlNrkS5JdfoCHxraw0qvvga
	EgJIYfXdPxRMD8PHHOoFuDk7AzjITSjg==
X-Received: by 2002:a17:90a:d09:b0:361:45df:102 with SMTP id 98e67ed59e1d1-36145df0c75mr12547182a91.17.1776823370872;
        Tue, 21 Apr 2026 19:02:50 -0700 (PDT)
X-Received: by 2002:a17:90a:d09:b0:361:45df:102 with SMTP id 98e67ed59e1d1-36145df0c75mr12547160a91.17.1776823370211;
        Tue, 21 Apr 2026 19:02:50 -0700 (PDT)
Received: from [10.133.33.231] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36140feea38sm15235217a91.6.2026.04.21.19.02.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 19:02:49 -0700 (PDT)
Message-ID: <fc552f09-d330-49f5-882c-fffbd0c5202f@oss.qualcomm.com>
Date: Wed, 22 Apr 2026 10:02:46 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v2 0/5] wifi: ath12k: thermal throttling and
 cooling device support
To: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260413153840.1969931-1-maharaja.kennadyrajan@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260413153840.1969931-1-maharaja.kennadyrajan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDAxOCBTYWx0ZWRfX34kCiFDOHo33
 hE3Lq6Lcia4EUihNJXMcGENY3dhBPVYi5mg/EVnF+mChhjMe4+K68q1PCY+yNNK2LqH64WITC59
 dVrrsde1hCXY7ZLskMN15lkaGG5tSH5YQQzVSsFw4lwNSLES0ctyujsOEmYz6UHe6PVo3Ak9Pzl
 abkDMeTdtP499Njni2/DzozBWSt4UOntZbZmdgIv4UCcf/1P00gTPfRNhN7v1S6zxlOv1+9cjPa
 wdXqemI72Opgl2oBH5I7UglzVkrFbS2xsen0NQSHNLPFU6ogDacEFG+OaSbLy5q8ufKqrN0l6D4
 v/+4Xywog/oYkywmENMxwyZjU5oshjKA0ydZSemvHWgysARpibUFL6rTxfbBxP2W0n9jK7Ao8Dc
 7XSkaRP1NZlVgEnloHKCEFAsKOLy6iw1T6zi7CrE0pfylMvjSbYgedioQXp3LJ/tDwGEl8zLvM2
 IDgrr8/FBTcmOpi+bQw==
X-Proofpoint-ORIG-GUID: NaAZv5lc4nJAvcUHkfsx_Pc6trNp8Wxx
X-Authority-Analysis: v=2.4 cv=RYygzVtv c=1 sm=1 tr=0 ts=69e82c4c cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=ZeLpQyFM_iFLYNy5nMIA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: NaAZv5lc4nJAvcUHkfsx_Pc6trNp8Wxx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220018
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35198-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 45BF244139A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/13/2026 11:38 PM, Maharaja Kennadyrajan wrote:
> Patch 1 handles the firmware stats event so we can track the current
> temperature and throttle level per pdev without spamming logs.
> 
> Patch 2 enables thermal throttling at bring-up and programs default level
> tables to firmware via WMI_THERM_THROT_SET_CONF_CMDID; the driver picks
> IPA/XFEM defaults based on the firmware WMI service bitmap, supports 4 or 5
> levels as advertised, and only fills optional fields (pout reduction,
> tx chain mask) when the corresponding WMI service bits are present.
> 
> Patch 3 refactors per-radio thermal hwmon cleanup to reduce code duplication and
> ensure consistent cleanup across thermal register and unregister paths.
> 
> Patch 4 reorders the group teardown logic symmetric for safe thermal sysfs cleanup.
> 
> Patch 5 exposes a thermal cooling device per radio so the kernel thermal
> framework or userspace can set the TX duty-cycle off percentage; writes
> are validated against the throttling state range and host state is kept in
> sync with successful firmware updates.
> 
> Examples:
> echo 40 > /sys/devices/pci0000:00/0000:00:1d.1/0000:58:00.0/ieee80211/phyX/cooling_device/cur_stat
> cat /sys/devices/pci0000:00/0000:00:1d.1/0000:58:00.0/ieee80211/phyX/cooling_device/cur_state
> cat /sys/devices/pci0000:00/0000:00:1d.1/0000:58:00.0/ieee80211/phyX/cooling_device/max_state
> 
> v2: Addressed Jeff's comment by rebased on latest TOT with wmi tb - alloc and free
>     interface change.
> 
> Maharaja Kennadyrajan (5):
>   wifi: ath12k: handle thermal throttle stats WMI event
>   wifi: ath12k: configure firmware thermal throttling via WMI
>   wifi: ath12k: refactor per-radio thermal hwmon setup and cleanup
>   wifi: ath12k: reorder group start/stop for safe thermal sysfs cleanup
>   wifi: ath12k: add thermal cooling device support
> 
>  drivers/net/wireless/ath/ath12k/core.c    |  50 +++--
>  drivers/net/wireless/ath/ath12k/mac.c     |   9 +
>  drivers/net/wireless/ath/ath12k/thermal.c | 252 ++++++++++++++++++----
>  drivers/net/wireless/ath/ath12k/thermal.h |  35 +++
>  drivers/net/wireless/ath/ath12k/wmi.c     | 108 ++++++++++
>  drivers/net/wireless/ath/ath12k/wmi.h     |  50 +++++
>  6 files changed, 447 insertions(+), 57 deletions(-)
> 
> 
> base-commit: 9a4f673eb08d2a7713b258d671b4a45f2a6e68b7

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


