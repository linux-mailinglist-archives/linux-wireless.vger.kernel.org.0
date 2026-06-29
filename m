Return-Path: <linux-wireless+bounces-38262-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Lmx/NtwcQmrG0QkAu9opvQ
	(envelope-from <linux-wireless+bounces-38262-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 09:21:00 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6CE6D6EED
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 09:20:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=FdHDvbEt;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=YdGpISO+;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38262-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38262-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3A32030D46B0
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 07:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FA81B87C9;
	Mon, 29 Jun 2026 07:02:34 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DB52F7462
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 07:02:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782716553; cv=none; b=bHU9e/e7KkU2OhiQTFGqN3jYTKUnXEnzU2Tz8ryZ2JF/Wqun3GJya2l/Qm7oOaRl5VZ1jOGaeav9gpcH17LZ+UoxPD1WacPUW7VQTueF8nO+apRGU3xCHb2NZhwE1Izc45RCMfv4+giAw10vne9+AR8mXceSQRZy7J101XQe0B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782716553; c=relaxed/simple;
	bh=ncW8SSY9dlw2nMTZH0mHUaN/zl5k7d8Af4BDZZ+1eJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GKJgpKW0I/viXXc5ocU5dMnihFq07VlWm9v289ahu1zqmlA0Lch4lAyX7zlHK/1OneYhDbh+fxvQKL7wR8noYpmEu4a+ey2EcVQvtIf67ApNtwsVc4DEVogrMCLXbF6tCn+vOsqCJKirXw94+6banppEs8g1/YkPuvKU4BVxtTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FdHDvbEt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YdGpISO+; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T6rIsT2139404
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 07:02:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	D3qdojYutaM36nMSvUN9enc2D/jGPsCfjBQ0NFTNC1w=; b=FdHDvbEtRPRww5E3
	zv3Lmr4oP9ce8pAjWq4ofwnNPIlUOkWwo474dQocjfdlWnuXjwirpaVUBxhv5ySg
	C9WzHrdc9HU6yp0TA+Kl1pBX6vr1MwB/Amh9uYIqHIXutfXq5R11jTjwk/vRy2NX
	SgMtHWgluPWoCL/OJf5W5qK/nv0hfoCSzhJlJYQrpnSoYDXZc1NMrp89952YUYL3
	UJ/rRftKsXKjoO00yJWsvY+VSAjbAhHExqDqqRBjC7QKD/y3C60sDmUU/fyRXz83
	3CXHwxrDC89uSn/w2QqXN9prZwoMm8T5pEZQd3ymaKWnhTsExDHJrKOVPLRFXxt/
	xVxt4A==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f2708538k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 07:02:31 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-845d3bef1e2so1599213b3a.0
        for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 00:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782716551; x=1783321351; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D3qdojYutaM36nMSvUN9enc2D/jGPsCfjBQ0NFTNC1w=;
        b=YdGpISO+W30NlnREd3+jdJN5IHv6jcFeAsfkKnUlobyzoVDiFZK8HocQ5pr79kWSjs
         1nwRkx/BLlNcYOz/+yEho2f7UC12nFAmR2u79rn//QWOD3xAipWfgvTXLoSFNbkK0R6i
         VU+xioaiuiC6wPo+qU0HzALEv4KdsOm9JnnIbqf65MAz4hQsyzULF/Ec/TGEZEl6s98U
         YkZ//CrvZymzcGTlBRhcJqEkHGP1XJ/CHJOTM58Q/khuY0nps9Fln8U/FXrj6z3BUz9n
         k+YO1dZNtJPj7vwRzp270BSphfPw7xgItB5Kc7f+GqnVhoVIwzi8KozFQTjRu/9KNrJM
         Oadg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782716551; x=1783321351;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D3qdojYutaM36nMSvUN9enc2D/jGPsCfjBQ0NFTNC1w=;
        b=rBLj6v/gsaKWd/5Pa4xoqvXIUjJ/B3bVPuQkXYZnb7p7BZsuelwc9hQTfrAkTjfLMK
         3VaC7Jogf+7RSNKgEbsirpoYY5lOeiGgsbV7LuQo7Sn5hK/9Y+DUv/GOdQe8ZKl9Usws
         mnkCu7S0wHa9srUDU+VfJwRh0yHojpWf2rkYfSLaGkOPQH8+BMy0ktTYJwcMwjF03SOw
         O9UUjfr6snAI5RPWR28jBJZPWubXAEt/WrO9/ZqSxvpXuATDM+0qr09HGK5ZfsyRCdK7
         r8ERya51E8srLnseqFqV/MhjMK0KRkfPuC/xBEPW9Ev7SSszvWoa0+o7I6RSIq48cswy
         qNNA==
X-Gm-Message-State: AOJu0Yz0UW3u1ErPZP6xEiJ/nNm9xempM7hLsI5zmrshRrvxUmovTsPc
	+LpsTOiRxmbYW1tgvFqpMOMyvDzu0jiI42WqW5DFNWV2jMatwRcpe57UXbhD+P4kusp3anx2un6
	wjKDzmUIIorbNyUC0aj8QS7JvT6kzMKRjwt0Ogevnu2vZJ9jX6V2j1c8ttIBbK2TChcD1qQ==
X-Gm-Gg: AfdE7clSvAuXCC47kfAkLhYIo7+lr9U/Arr/PzhWdgfrhoiu6edRJEMxJRW6SmpqBUR
	eeplg8KblSqVu1saxR8Lh8F14abyah+z1Ne5NR7SOJU51QuAbOHHfcYAwAdeQSSbAOWmXHXnMS6
	oL8jhfoYnheAQA3ozCYRFIid+cu6b07qiEhDQ43nFPjQ+ZCt/LL7/IvIfOjvJ3CZnBu6pYz704A
	m9pD8AuJZsn3Iiyr1RPIeK3ie4ZGXGHFD1A+yvqtoYIx3M5RRgK7vlED6wHgKFGUTLNwmDFZKWh
	XFpKghrCuT/Fb2T9AjG6/Sj2/ppj3dlZCqcCpuoojoZ2GWPXZXH/z2cBHoYilyg5phwu7x0xL5R
	3cshe1has6w5t1p2s9vc6G7UaNGGpvCBz1IPYGEU2vdCXyJjIv1xKmmaczKg6ymy0c1ovmSb7kz
	ldc1iEdw==
X-Received: by 2002:a05:6a00:801a:b0:845:e8b9:347 with SMTP id d2e1a72fcca58-845e8b915a7mr4702207b3a.13.1782716551270;
        Mon, 29 Jun 2026 00:02:31 -0700 (PDT)
X-Received: by 2002:a05:6a00:801a:b0:845:e8b9:347 with SMTP id d2e1a72fcca58-845e8b915a7mr4702183b3a.13.1782716550814;
        Mon, 29 Jun 2026 00:02:30 -0700 (PDT)
Received: from [10.133.33.8] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a3fec0f7sm11106095b3a.22.2026.06.29.00.02.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 00:02:30 -0700 (PDT)
Message-ID: <e4b3ad21-0bdb-49bf-9c41-8ae0d0f96c0f@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 15:02:27 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v2 1/2] wifi: ath12k: fix dp_link_peer dangling
 references on AP vdev rollback
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org
References: <20260629-ath12k-mlo-peer-delete-race-v2-0-362b25590d19@oss.qualcomm.com>
 <20260629-ath12k-mlo-peer-delete-race-v2-1-362b25590d19@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260629-ath12k-mlo-peer-delete-race-v2-1-362b25590d19@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ObKoyBTY c=1 sm=1 tr=0 ts=6a421887 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=_EJcpLEw30hKsFGvHqkA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA1OCBTYWx0ZWRfX1gXuGrHVz6ob
 srDf2DbYXqBiwp3Lfqg+SRHmzbXXOv/WDaY8k+f/2+6lB51okKKCgNPjBm0CRrp76pWrAcIOfmD
 5p/m8dT1AXrh8DZgnQilSgcROcz4qS9JPLC4sgaWsdmP9bf9nUOT7AQm9+ry5lv1Ot3UBA0g0bx
 m4skcuWWHZ3NqplDuROgDafFE+fwdQCR/1+XqtYM9iJe7Iz77XHRhrXGfvnshP5hVlRGcK74zA4
 TTNAC8XocDKlySGVRSDNyEYYmLRwq2ckWx2FX2GBuasjVD4dtEIo1So0eIJoG0KqLWyONpiBbeT
 hXQTgdHVGtP/ie7d8vr7uCXWf34jDsSMY3iV2NZ/OkBjKcf6KfHB3ebixpv4JIky6DynJG2P9y/
 PYnuHtME/MqkZxUT+Cq0+Qv3z3NYi8m7miXq4ukaYoaYtInL3YPh5Cs6ynBKgf+juLm8LoYnLXm
 TRVUnJyNQDGuJcdPDjA==
X-Proofpoint-ORIG-GUID: rD7mblR4edK82v2wzxMsklbOhjEQhF8e
X-Proofpoint-GUID: rD7mblR4edK82v2wzxMsklbOhjEQhF8e
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA1OCBTYWx0ZWRfX7wyvtZbe3VIO
 XHQ8fe/PukCypqvSdjlr+gGzuUiFMOLM70eYPQktBumlSx9EkssdCj56jh6g3Y9IUSQrNqyixzS
 xSoMH26NUs7/3hO+vqDe3mqjri3FLwA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606290058
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38262-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,qualcomm.com:dkim,qualcomm.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ED6CE6D6EED



On 6/29/2026 3:01 PM, Baochen Qiang wrote:
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

forgot to pick:

Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

