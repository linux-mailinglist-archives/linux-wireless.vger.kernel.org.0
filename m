Return-Path: <linux-wireless+bounces-35247-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 9Sb8MaVe6mmrygIAu9opvQ
	(envelope-from <linux-wireless+bounces-35247-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Apr 2026 20:02:13 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B30B9455DA9
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Apr 2026 20:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E862E3051E90
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Apr 2026 18:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62063A63FB;
	Thu, 23 Apr 2026 18:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dTw6gGBs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VzqWvXuq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E851FBEBC
	for <linux-wireless@vger.kernel.org>; Thu, 23 Apr 2026 18:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776967260; cv=none; b=C710BbgxFEbPrBZU1bnl2x7J6Gcc78UiJ9o/dezKDlR86qYHv57Y3kQJVW8rlqBdFnfIyhjB2qebKAeIxnr6jNogjuebsdaiS+m5r1TRVh7LEqeyKn6b9sy/XlFbZYNv4hl3tHeGarOQTBrd31IvCUbCBF6ysw/LMNvqAxbGlts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776967260; c=relaxed/simple;
	bh=1nKjoackfevZu3JFRBwWq91N2VUU2w7EPNF2BC3bl48=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hARyw7CO+kRrSTC0CJcSIOmCLpQtHq7AGHHpS4Ft/w+vv+9dHKErk2YuJuTUHvboEm/UUQZ2N1VFqbYpwZi0e146I+n6Deqcqtv7JEGujc5JUni5TDSQCmBFYseq65ABYE8zokDkUGOvx+CygqjbkPtfSlHc/JqrMttGbxEXtbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dTw6gGBs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VzqWvXuq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63NFenKo1888545
	for <linux-wireless@vger.kernel.org>; Thu, 23 Apr 2026 18:00:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sDahGGWgE+f2YJGiyUkd+oixBxcr9ibcWlJr8Hhfk1g=; b=dTw6gGBs+jt/1OHo
	0oY8vCek1sc7qU2nroAsyGufDMY3Rmke92kCZZGfH4ABOyV7MeSWV/76qB+dFQEe
	/fpDD5LVhNxfhPgOV9iLF6mMu3iW8Y66zr6M8U3gsoZsctoGhoclrvVfoi56QAWI
	utTb5i7herqbObHUqLuzFZNMhMmqYuX2ylHpKQQ6mzJSvwCEoDarrWxnnDL+sXXq
	NYA6gH88FWrgNjsPdp0KGiF3pF++ELEEhfdtgVUKt9sW7Hf3BbbpmAQcTrNubLsF
	OOAaCdj+gfedtkivFPXYHzIl19f6WFN8ywV0sw8EOks4dc+iZP3Ht72p8WXnHYA+
	sIbIqg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqp9drm23-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 23 Apr 2026 18:00:58 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2dd1c74508cso11339446eec.0
        for <linux-wireless@vger.kernel.org>; Thu, 23 Apr 2026 11:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776967257; x=1777572057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sDahGGWgE+f2YJGiyUkd+oixBxcr9ibcWlJr8Hhfk1g=;
        b=VzqWvXuq8aZObX4SnlHtqta7ZGCaNjYIs0tciNPS6/v9SE6EFji56akpRAd8C7zj91
         Er4gBdzmHVYqY+fAglzMt1ubHo4Z/vB41OY5Mh9mWa2iCG0Cqst2iiy7dls5vzt0Yfux
         ybZFUMTMyg92x1ZksT4nTpcwWJmkDvb0kaOcL6dYKpO3MzTV5HtU0Tu7VviEDcwVI3VA
         uc86Aly44643ZQ2493dlPgxXTODSJU0TZJuN84r4KSiRsEc/jSJLwK+EraFWi1qfdZ1U
         C/AxtIplkLJu1rlHTQa02DhEHrcQUmGZWBd0tNvRRgViQJ0KLMW3uDECHQQSQadXcP/q
         bAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776967257; x=1777572057;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sDahGGWgE+f2YJGiyUkd+oixBxcr9ibcWlJr8Hhfk1g=;
        b=hSSy2erNb1VKC/1yk+NQZVCxDCyyonCSacGlHYsifI6cMAdNOZUQiQDRD90Diu2S31
         IZO7/CnCyZIaq4eqsKolEwHuhiXHUsk5v4Z4txGYdad6+P7N2WY/8wqXzVE2q1iorvtX
         GLYt8DwvSeTHAuIAKrI7yQTCm3athGgXAapVwxmoywoFg7R0gm25cGYP1OLAcbUI1BaG
         rq0aXjSUyIwbK6SSAW4ZAM0d0oj9w8E/LlsAj1SaBMtBi5acdnlUvp3pfTiQFZ47X2qE
         H7csn3GszHYUxIAwVswp9hzunl3YafflcJ5s/pnIhSWOy7tNXToJ/vxq/R6AbAXurA5l
         bWQQ==
X-Gm-Message-State: AOJu0Yy9jcy53Q200bQWkW2J6Bavy8aAqr1U6orSCvhKRS1COS7CQjln
	1BSFab6UGGgBv9xImvmZ7O4y7DuYtPRSIguyPxPU85q9Q+odzvmrz64XT5zvHddPl7wZDudctga
	JyS2/Yf4amljIuK9vCTa9MEsppwJ6aYRXdNnjplliM5ynWUFSNYIyCyhfMTgtHK/o7O01zK2ash
	wgYQ==
X-Gm-Gg: AeBDiet8JC5gAn9L3xMyo40ZoLfN3ce4loi/knHnCBV3buo2OPIrzlf2L7b1rKfIyqa
	y1SB/L1TiyV07s2MniXOYCm3vJy24HNU8nUGWuRP2XFPUCLTmGxakaPHhKcgKUojuwEieYFCcZf
	jIJYkfzo9GaMimvJ3wbTl1RnpK2IC/5uzaCNWirCUb5VDhImfTKbdNHm+ziUrR2QGGbALMKI6B0
	EQyOpExkVoqBt4365GipVyokE3R7gGrspTCEa6U4iY048MMO84+CgWbvdjIlgG2Hjp7KcbhKe9/
	gW7P8IlqCNpIJ95vifM0xVoAo2Nn84UlPI1p9uLc3ieY54YtYdhAVoOZDlFoJBvwhLK0NRgwmYj
	gsLDwl5RwZkaaAvJ17zl8mgPKetHACiTSH6VzSVE5BHF+IbLMvv3Glms6686SRgI5SXfNlIAxaF
	BRq1Bb57pMHz0=
X-Received: by 2002:a05:7300:dc88:b0:2be:171c:5048 with SMTP id 5a478bee46e88-2e4646cbd46mr13880332eec.5.1776967256802;
        Thu, 23 Apr 2026 11:00:56 -0700 (PDT)
X-Received: by 2002:a05:7300:dc88:b0:2be:171c:5048 with SMTP id 5a478bee46e88-2e4646cbd46mr13880303eec.5.1776967255955;
        Thu, 23 Apr 2026 11:00:55 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e539fa244csm27867887eec.2.2026.04.23.11.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 11:00:55 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20260210-ath12k-rxtid-double-free-v1-1-8b523fb2886d@oss.qualcomm.com>
References: <20260210-ath12k-rxtid-double-free-v1-1-8b523fb2886d@oss.qualcomm.com>
Subject: Re: [PATCH ath-current] wifi: ath12k: prepare REO update element
 only for primary link
Message-Id: <177696725494.2493545.13936818593082724681.b4-ty@oss.qualcomm.com>
Date: Thu, 23 Apr 2026 11:00:54 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: x3MdJ15dZPKIqtKIvTnFq-cfOZXzwMO2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE3NSBTYWx0ZWRfX0rGr5DSLoQRV
 YM3YbXdAkC9pJkqDfsE8n9jyw1IAe0YrIYAYDLcYVlGcpkVW8Ndi9pNaSQZvG4X5hN+lVQ6snOG
 0XXvVMFX1NSgrN648pWskOCuXzhP7hxe/+ZLPnHzuftfRoJ4F3imd4Xx40SauC9OsdZMI79eCG4
 urXu4hhDz0RN+pXSOsohDxuJPrrHjIjLn7appR+sNI20RaZol2oVdCVTixpGzIhFvxjqIJCF+Ve
 GyKC1L5itUUzeVRedjkG6haqnPTae0TaXjdqGwpW4j5JQCxwt4qN3SdCfzmn/Po9REqLM4uZFtA
 uWv8MlUBCZ3jzEsLvkgCADDhAQytIR3gZYm3TIZ0B0nvic9C8eMvHqbKrPYZ5ojNRczUwSJI5cJ
 IWuAKgrpmsW08fSK322mdf1edc4Af2HJG02zpuF7jeHjBekn4bXzEZft0KYFqhDJ8/p/ZBewjaK
 KAbwY7uI0J/CdSG281A==
X-Authority-Analysis: v=2.4 cv=fP4JG5ae c=1 sm=1 tr=0 ts=69ea5e5a cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=Q8EUVOj_abkwYjJFVU0A:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: x3MdJ15dZPKIqtKIvTnFq-cfOZXzwMO2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 adultscore=0 suspectscore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230175
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-35247-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MAILSPIKE_FAIL(0.00)[2600:3c04:e001:36c::12fc:5321:server fail];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B30B9455DA9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Tue, 10 Feb 2026 11:07:31 +0800, Baochen Qiang wrote:
> Commit [1] introduces dp->reo_cmd_update_rx_queue_list for the purpose
> of tracking all pending REO queue flush commands. The helper
> ath12k_dp_prepare_reo_update_elem() allocates an element and populates
> it with REO queue information, then add it to the list. The element would
> be helpful during clean up stage to finally unmap/free the corresponding
> REO queue buffer.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: prepare REO update element only for primary link
      commit: 4a1b534177395627579c1fb9e7f9100ee88955dd

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


