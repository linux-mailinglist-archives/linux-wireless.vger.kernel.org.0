Return-Path: <linux-wireless+bounces-38249-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id a9ETEkEEQmrgygkAu9opvQ
	(envelope-from <linux-wireless+bounces-38249-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 07:36:01 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A036D6109
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 07:36:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=ZMDZtHW8;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=Q5J3JDBZ;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38249-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38249-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8E522300404F
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 05:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E73D38947F;
	Mon, 29 Jun 2026 05:35:51 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7024389459
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 05:35:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782711351; cv=none; b=omkL545nDsx5sU6+9yUMr970L0X2YKwu8iqpJXnFSXZHqLJ8+WDwnKAWvGvPaa2wPBi9B7Vmgrj2lCulqeMVQcfhikWYbUQDridaMubVaeIjXfsU0H5QOQUKgctvEPrywDdWVlZLpbTZmUuTENJEQPLi+S5SpQGpxzwXRvf7EXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782711351; c=relaxed/simple;
	bh=f5FPIFPcbQ/u4WtB5LXEFRgr12gQWaEwlg1urNU/KWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lCip7dmlzLoEjHsud6NnAmvPFrNuFUjM3LgDtGNEatT0XkD3uefy+jXTU2zFxECmxjp9laT8VnWPXbwuQ4L2DaiMcH8AQv+ivHV1yCUanTSdH63d/yud08UR+gMy9L15Vdo2v3+KiUoH/mpTZMIH+GPWaZN0UqDDTfM1Z9SuEDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZMDZtHW8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q5J3JDBZ; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T4NDP91718813
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 05:35:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8phPWSksCjeCsY5PX4ukL4G28A+omK3tTKgilFv7DgE=; b=ZMDZtHW8FJzXiA+F
	a3Y4Gu5bmY/fDnJqzdfe8Ww8v5ykCigliD6ltpFxItHijaM8X39LlGgz1D+s3Nqh
	DcBv6CuPALT3n1p4PrDkw7X/2MPQ2kgrEwPyybGCLcKQr169kO6eVw7J4bfiO/jU
	b0S5+P5mjhneGetjkL6ANWCOEIcHkevdrarDQAM9ECrFWh3C/DCjO+xp+Z+CpYE8
	kL9gCxQQiEfntsqG1QxvNGg65P1uhVnqTUeGaLCcquevkbqnc5A0UuxLK59Xd33k
	3bPeR5iDCPJ4mfDax5+gJSjgz0WsPCDAZwxPPa9F/smgiJ2CNImLdAifv6NQTZQH
	YpaCfw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f27pf4gup-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 05:35:46 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30c9bd8b9c7so3476120eec.0
        for <linux-wireless@vger.kernel.org>; Sun, 28 Jun 2026 22:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782711346; x=1783316146; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8phPWSksCjeCsY5PX4ukL4G28A+omK3tTKgilFv7DgE=;
        b=Q5J3JDBZkUEOMDhFwbDfTXSG80bmTWspkARy6gJFMwgMARvACfAnn+G9rv9PnveSyZ
         SW2MKPXIbwu8xQoBv2TFfWowX0RDvm11isgz1xuJcbbA2U0R+SKszFF8V+ZxHujiuZuk
         U08r3qqBW4Vifb/2aQETi6nveCoN0UfSi86jVDYi62eF6HuO/mAjWWIUtWVzZ0cB8A1M
         7u02l8uVhhTcszXD++aWGxXgBTLyHMJLq8jk/xRZu0T6QCB71NPgGCQnh89BCI/ZbWy7
         tWLjY++OcK7CKzfr5QUvlJybAzyn1XEzUvkyG8UZb+DsCrgm+EakN+4H/hJliljcNN9P
         cpTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782711346; x=1783316146;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8phPWSksCjeCsY5PX4ukL4G28A+omK3tTKgilFv7DgE=;
        b=JSjtAF1kyBAPC8pACx4xHGWfI9/MnZByFTGXRd19IeXTi5ZXeohvPknjtqfGAamgHq
         hZ2kZYv2PjFaQQ/rYvRYFD2LJw7aVK3l3kR8jT5YHmqVQMeEdTFK64fVZeTzT4yDUKqY
         Sm+P7mlpI44HLTIr72WDb7/VfdMzWwojvC5pcCgT2HI6ynxGll3cZeu78sWWgWifUsVK
         Hnz4MRnyt32EDfExWsyV4TBGQUQGf1S7lYIEM2O6jkI7wuCwNoRCNky8HZIfQB1cD8Vr
         QI98yLl89G445wK2dwlicC+CKeLTIOvPihwdmwGrD/FDZuAZ1YdJOz6wEI2JTpQyiQEg
         RO0A==
X-Gm-Message-State: AOJu0YzES5TEMq6NtLRDKb/rx3Hw3yUPqgK+nmDxsszzlg/rBfrwv97T
	7YXDCRAfskiTDrflWepfYyvBnU/CPlNeU/L7Zr/yO7BfLioZVoAMB70C1u3vuFx8CHtq00dM/Ru
	bvTJBCeIexwXbLWJaS3S/N+E6MiUaVPrv9hH8Vk0zvVaMWau++LjqYy+Vi+Z6ASNLLbJjqQ==
X-Gm-Gg: AfdE7ckw9GxhsKnsX82KZUMgzgGCEhCUI7O+mbgg8ippgw1TnefuZ6U1bOPwZCDaC+x
	FYqQ8OlYQpyhQgoSscxmGhkcMHEu1KHKgcM1OC4DjGRRu9wSAFPEGWEv6HM/DyFSthV3pKiAbBE
	1AF+2NoO1kG5SgoPLmQKLOTcGa8aRU2P7hTC+j8Xlp4Pxe7YH/q+5vu7p48X8zQZAKKCIsMICmb
	ye5xYDEVieZGpkTJRLSacniYS+UESWRQAvWdwwZI8iII2BIV8s1gNBt0n9OG9Ys4fsUJhvfHNwe
	Gl//WMw52NNap6ms0VMgv8XoE3M2R2lrQhKA+uM1swH/CCz1mwiZEqgDopg7VlTTve9LCc8ZecD
	JcgoDS9YokWkz8+Qt7KGt8nv/1tcRimJaAo2u6TBqG7Dk4Xcxh54=
X-Received: by 2002:a05:7300:1903:b0:304:819f:5029 with SMTP id 5a478bee46e88-30c84d109cbmr14031404eec.2.1782711345991;
        Sun, 28 Jun 2026 22:35:45 -0700 (PDT)
X-Received: by 2002:a05:7300:1903:b0:304:819f:5029 with SMTP id 5a478bee46e88-30c84d109cbmr14031350eec.2.1782711345425;
        Sun, 28 Jun 2026 22:35:45 -0700 (PDT)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c52eed6sm40005912eec.9.2026.06.28.22.35.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jun 2026 22:35:44 -0700 (PDT)
Message-ID: <538b932f-5858-420f-bac0-cb027eadce1c@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 11:05:41 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 1/2] wifi: ath12k: fix dp_link_peer dangling
 references on AP vdev rollback
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org
References: <20260617-ath12k-mlo-peer-delete-race-v1-0-ab3c4f455dfb@oss.qualcomm.com>
 <20260617-ath12k-mlo-peer-delete-race-v1-1-ab3c4f455dfb@oss.qualcomm.com>
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260617-ath12k-mlo-peer-delete-race-v1-1-ab3c4f455dfb@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA0NSBTYWx0ZWRfXyIW3o4Ww+BEx
 AxXC7AhhYpZePnBfKO6vhR1PgVwW+52teMErDyZ2vQX02G/zPvMjXpR3NtZ+3wgkOxCmYBGyGRR
 rxhWUWpEF4DCLdnahBoBaVmU8x7bq6U=
X-Proofpoint-GUID: z5cypGn3BM0ICUX8VXypcyhR6Z7PkPGl
X-Proofpoint-ORIG-GUID: z5cypGn3BM0ICUX8VXypcyhR6Z7PkPGl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA0NSBTYWx0ZWRfX2dVfBB4qsQPK
 aTIOOJKfJltxOqbFLbHFgFyS8hAbN5zCGr3jLdOWVg7t5IadsIrzmJkA30xOxHJm7TqoIxlyQdk
 7Ya9vZodHNI5Kcof6c/5XcqVoRMkkvnSTI1qN0acR2BquU2Lvlfei7mtHsn9p5CsrfcXqBdhng+
 ojm0utEDCrm9HnOwmUjrOa2IcM29XBz/fEJzPnMS5S8Q9Q3R+fXuyISeNOzph5uiuA/HrtOLllS
 cIbxTw1zBeTs/qOd5zrivvqI/MBrWo5pDThKNxJpXI9XHaaAqASIPyx5IWGK/p2G3vIGhTdjofK
 boM28KzTbKHVJDQWCfj+xHeVV8QpUt24KdaNc0rGsZm/tmv4adAY3OJNLpx+LFV3LNTmxPfwIAN
 mYbNKqTK+Cy6aTtlPfPXRChjDAM1MpZvzc5bxsOpSFR6fU4PisdOmu/A4XWUbIaBrGwAWwNWmgN
 qjRCrq1szda4wENxyxA==
X-Authority-Analysis: v=2.4 cv=R7Mz39RX c=1 sm=1 tr=0 ts=6a420432 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=_EJcpLEw30hKsFGvHqkA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290045
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38249-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:baochen.qiang@oss.qualcomm.com,m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 48A036D6109

On 6/17/2026 2:58 PM, Baochen Qiang wrote:
> ath12k_mac_vdev_create() for an AP vdev creates the bss self-peer via
> ath12k_peer_create(), which finishes by calling
> ath12k_dp_link_peer_assign() to publish the dp_link_peer in the
> dp_hw->dp_peers[peerid_index] RCU table, in the dp_peer's
> link_peers[] array, and in the per-addr rhashtable.
> 
> If a step after ath12k_peer_create() fails the function jumps to
> err_peer_del, which open-codes a WMI peer_delete and waits for the
> unmap / delete_resp events. The wait_for_peer_delete_done() path
> relies on ath12k_dp_link_peer_unmap_event() freeing the dp_link_peer
> when the unmap arrives, but err_peer_del never calls
> ath12k_dp_link_peer_unassign() first. The published references in
> the dp_hw RCU table, dp_peer->link_peers[] and the rhashtable are
> left pointing at the dp_link_peer that unmap_event then frees,
> producing dangling pointers and use-after-free on subsequent
> lookups.
> 
> Replace the open-coded sequence with a call to ath12k_peer_delete(),
> which already does ath12k_dp_link_peer_unassign() before sending the
> WMI command. This drops the published references before the
> dp_link_peer is freed, in the same order as the normal teardown path
> in ath12k_mac_remove_link_interface().
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c7-00108-QCAHMTSWPL_V1.0_V2.0_SILICONZ_UPSTREAM-3
> 
> Fixes: 5525f12fa671 ("wifi: ath12k: Attach and detach ath12k_dp_link_peer to ath12k_dp_peer")
> Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>



