Return-Path: <linux-wireless+bounces-35140-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OE8IApF852nC9QEAu9opvQ
	(envelope-from <linux-wireless+bounces-35140-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 15:33:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9113743B66B
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 15:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24E7A303207A
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 13:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E8B1F91D6;
	Tue, 21 Apr 2026 13:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HMuEFEvm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FpiOIe6J"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8853D6CB8
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 13:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776778222; cv=none; b=oqUME7jFD5cWPGkF9WSxKHM0wnMAi0GxqHTvt+HhDMy+l8LrVav0vSyLX+CLHmI6oxiwRTAXWc8suVdVyrytapyA9wWk8Mz2zoh51xOreqs+R7ep6jGHhc4+Ub1SFfAyg1ia8W/hK8qvwZvosECl7vDl7j3MPtySw5unYIc6Bbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776778222; c=relaxed/simple;
	bh=y/sjaZ8cSYK8x+cypFnrhVJA84dIzuBhTJ7ixlq2GNQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jP698h4qka2qGmH2hRmPvau/Qm/d7cANYHJHNkNLcMdsSMgvEzIp9WpXFtNufQ3pxkFoXA09dMPMIvekn0juQZlEsqDry6gMc0aCDTO9F1p5d25djxhnFg0nVA8mAB3RUwPngSy00BgAsxwFfdjyKR4LYkmSvM6ZjoZeC5PG7Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HMuEFEvm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FpiOIe6J; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63LCw5o63574145
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 13:30:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xzsp6UDhZW+yTfp3yNKZwac94XGWbSTow4ypteK7LbI=; b=HMuEFEvmtljgmVGj
	MQdp9oNZUp0eL7j0CUvCDBoVQs9KJgdPvqC+XYRtQqZ7CbtA81YpeQrpcLbD41bD
	FyVnFY16f3+/e+qRlCq0lAH6gggNSITHckQWDIWSjsh4BG6bXs2/dQtZ1Qqip0FI
	uXGjR8UfKOZz4SERllcHm+naIdxAMW7Nw+8d/Nq4vM+HxTLxbs+1ljumGbWdFB3G
	c9FwBIrldY6UOH5C5Z1eqMH8DP0bmhOHCO+LjJyaN87qbnemfAI3IZ29r2YDH0k6
	KD8dQ/xMpj+8+29q8PpDNUgsOUUWbNFhT+w4CNzdzNmIExzGgfWnz8ajE0ZfUchi
	eY4sdw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dp465hfqw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 13:30:20 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2da19227bc1so2774045eec.1
        for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 06:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776778220; x=1777383020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xzsp6UDhZW+yTfp3yNKZwac94XGWbSTow4ypteK7LbI=;
        b=FpiOIe6J7bbRgcD/1892hOLjE+HvP+BWuK19IM0fAGB1o5siPR4/HYtnsbwS5+uQgd
         hQZNEHWxBE/MluExuwQafJ/WivwZ8fi2XsH+oEejf/6v9Vv/wPHfl3TloAN6mzQlKQZz
         UemheQcUP3d95zhkfVyf8jmQUldG9kJLEwDNdHO//RAQsS4mbwqAR1Xwxby91Med2brM
         t73GGy27dYNj2J0PaLatR3bv4kLVRGsF6HOJ4Wl47qMiiPlrPxmfzsP8yqINYQHT/S8M
         xySsNS+8q42NPini/T6/PT6jVXw84OsbiKxkJSsjegIF+dHkrkWX+SSwmlvlrAwAaI3f
         jNDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776778220; x=1777383020;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xzsp6UDhZW+yTfp3yNKZwac94XGWbSTow4ypteK7LbI=;
        b=jolR3gTNr5MCk3agrjXTPtcyzlx66xAe9iUKK5cWp1Ptz616qakOWcqf54v3ghkLjN
         ZqqrX7QdLWZEiLV6LIQxMThhpguvCXeQkXIaws00PHvqpUMkZG85CLakNllq5sxKKr2G
         +YeA3FjWPSNRb6d5zWmZ3z4wmqWCeG7jrdu5PQBSdL+YA0QyIudG1IekieDPrtwyB7Gr
         FTH1Is25sbcv7FBR/zO06Ko+QQbgHkmDAGB8dkOtUnH6nhjHZr5U6E1UJEpoR6Ro7u5/
         nW++zZ0eYYaYtui2nhNpzpCxzC55/MUbRPsPAg5lXDtJrowZxt5SzGQB0QPjuw2yr2l3
         Bj5g==
X-Gm-Message-State: AOJu0YwpVYaEZCmWHnmnMITsse9WM8aGX7MQaVFxG4ZltVNALE8eyzOH
	srfwopZqsuLGg6QTYbiWDSaJZ0zLZs391DpEAK/S6k3Up7oN5vZ64ZoaodEtwGCiDWNIW1OCUBB
	3obKwmD8jaHYerONJAov6gfHPJSD7RiDmfI17gO9FKKXTYAReqHeDoezMSZWmHWXX7J67Zg==
X-Gm-Gg: AeBDieuZZTmg+ab49GGLmdjUyppq+f5UusKTpzA8Kqot8UMvZ6XKXSXTr/P+Phi+aBS
	nVtCILqidcKNVHY3SGZsSbz/1/bCgGXg6lBbmBOhvfZqt3fI1WgIfE0DYugRoO32D4OWT76fxtF
	BARaiK2t5XcKn+6l1IwjV4OqOCuuprdv4UECz160pu03v6HLwZwuGen0o0FZ20DbEdijMdHkPkw
	4MAdZGn9KAXYnhWOp6ehHcWf+ppO9jr0eiL9LHW7bR+lqClieNsWImo+x1R2jWwyw4k7A9AgONx
	tM77Om7daT3JjrBC6+3ChPEVC5GDWYhob2NQlaB+6BSaxz6tM+0QTFTWFXeUsn70xNjqJzywg2Z
	7ZGhy0J8W4ocdCHpenSuyw9ki58A03dzPiRfeG1UHGT0lfC6s6Kb47tKFPJoOq7PA77C3cEiTEY
	bK98Y064i5vkA=
X-Received: by 2002:a05:693c:300c:b0:2dd:c066:bfe with SMTP id 5a478bee46e88-2e478a331bfmr11148008eec.21.1776778219439;
        Tue, 21 Apr 2026 06:30:19 -0700 (PDT)
X-Received: by 2002:a05:693c:300c:b0:2dd:c066:bfe with SMTP id 5a478bee46e88-2e478a331bfmr11147822eec.21.1776778215177;
        Tue, 21 Apr 2026 06:30:15 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53ccce440sm18480206eec.14.2026.04.21.06.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 06:30:14 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20260414062829.2371761-1-aaradhana.sahu@oss.qualcomm.com>
References: <20260414062829.2371761-1-aaradhana.sahu@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: Fix invalid IRQ requests during
 AHB probe
Message-Id: <177677821410.4175191.9930496878940728154.b4-ty@oss.qualcomm.com>
Date: Tue, 21 Apr 2026 06:30:14 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDEzNSBTYWx0ZWRfXx0fccsHP0ppc
 pW/uIvTOA/DvHzwjRr+csy3oBAkpy67xA7ktknu0KnRLGTgB932V9ScXj/t4n+xreqtCJIbnrM0
 MNzapEEvoIlfXsUQ3FMKTaT+APjUXYS5BAFBl13gWn0m62J2u5Zb7IMQM32BL1FchX8uiVu06hS
 qxhjFmJfaCW+hNZ+GPGh2Axgdw7Wlte0YvVsAzxjXn8810qTiaETGzOd2nIytaKxX/iLHgNUiWm
 aHeKQlW2n5VhNGh9t6MfbedZfyXWC6ehD6yciNTffyzJZsAu0Hx6yUm49WsoFcyHb8lJZ6hCyY+
 Xr1G1RSWUHUR2OBAyxWGG70BA/QqvQPrrKOBiyfY8VbwRkPJ37YUxYWGOHn5X0RkwGi0U/b3v7O
 SxKCs/3xhP7WdlaBOVawnEOVFW2qlAmY9MNwq43fCM0VzYPsgdtVV1Z2VIDHBVeioDAwMJPFn+u
 6KCze69/UBprmyKfoGw==
X-Proofpoint-ORIG-GUID: T2yq6R1pDeovPTVLap9I6_eDMrKJk-ag
X-Authority-Analysis: v=2.4 cv=YOSvDxGx c=1 sm=1 tr=0 ts=69e77bec cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=G7bOcmE9FAL1y-DpTj0A:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: T2yq6R1pDeovPTVLap9I6_eDMrKJk-ag
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_02,2026-04-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015
 spamscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604210135
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35140-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9113743B66B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Tue, 14 Apr 2026 11:58:29 +0530, Aaradhana Sahu wrote:
> ath12k_ahb_config_ext_irq() iterates over ATH12K_EXT_IRQ_NUM_MAX (16)
> entries while checking TX ring masks, but the tcl_to_wbm_rbm_map array
> contains only DP_TCL_NUM_RING_MAX (4) valid elements.
> 
> When the iterator (j) is greater than or equal to DP_TCL_NUM_RING_MAX,
> it accesses tcl_to_wbm_rbm_map[j] out of bounds. This results in
> reading uninitialized memory for wbm_ring_num, causing the driver to
> evaluate incorrect BIT() conditions and request IRQs for rings that do
> not have an assigned interrupt line or device tree entry.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Fix invalid IRQ requests during AHB probe
      commit: 590182b72213ef04977ab0b16b8dadfcfd25ff73

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


