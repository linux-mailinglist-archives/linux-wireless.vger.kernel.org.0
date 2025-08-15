Return-Path: <linux-wireless+bounces-26401-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B74AAB27DA9
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Aug 2025 11:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FC0D588019
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Aug 2025 09:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF932FAC1F;
	Fri, 15 Aug 2025 09:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dd-wrt.com header.i=@dd-wrt.com header.b="Rm7iApXJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.as201155.net (mail.as201155.net [185.84.6.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2012FD1A9
	for <linux-wireless@vger.kernel.org>; Fri, 15 Aug 2025 09:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.84.6.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755251884; cv=none; b=ewTkC00sdOzRscE67EtUxa26/sSKqH5IryUYNDj7ePONNRCCWWG7nB6ZB06kNglxv0CWztCriJrPQnVj00f9YCNnL6F6SENlIgOvU1gQRPFOy1dxlpuK5+Lvd3mZJYJusEHoWOPYjA5KjmtSkbfmAFX7ZCl82BwYZf6A0/zlnf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755251884; c=relaxed/simple;
	bh=ZMu8zKFvzteV22JrMqO4hwGpCxpD8VV1+4U6K+9q3rM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fj+m9oJjxiUf+FDt6tQHtGD20qm9iqsQQZuSsGBKw8C5H6ieMY/Ha8QLmHYlhafCHzrVmrv12l5QJnV53ESPiTbkFgfEXUYbQqoxYqUNULfOkvRJgB2sP3DWmKdFHhm1rSp+FkJCxGl8Bgd7SOuOFbvClvonPINxy3i2ARgBKOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dd-wrt.com; spf=pass smtp.mailfrom=dd-wrt.com; dkim=pass (1024-bit key) header.d=dd-wrt.com header.i=@dd-wrt.com header.b=Rm7iApXJ; arc=none smtp.client-ip=185.84.6.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dd-wrt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dd-wrt.com
Received: from smtps.newmedia-net.de ([2a05:a1c0:0:de::167]:36976 helo=webmail.newmedia-net.de)
	by mail.as201155.net with esmtps  (TLS1) tls TLS_RSA_WITH_AES_256_CBC_SHA
	(Exim 4.97.1)
	(envelope-from <s.gottschall@dd-wrt.com>)
	id 1umr9X-000000002zK-0vox;
	Fri, 15 Aug 2025 11:55:15 +0200
X-SASI-Hits: BODYTEXTP_SIZE_3000_LESS 0.000000, BODY_SIZE_1400_1499 0.000000,
	BODY_SIZE_2000_LESS 0.000000, BODY_SIZE_5000_LESS 0.000000,
	BODY_SIZE_7000_LESS 0.000000, CTE_8BIT 0.000000, DKIM_ALIGNS 0.000000,
	DKIM_SIGNATURE 0.000000, HTML_00_01 0.050000, HTML_00_10 0.050000,
	IN_REP_TO 0.000000, LEGITIMATE_SIGNS 0.000000,
	MSGID_SAMEAS_FROM_HEX_844412 0.100000, MSG_THREAD 0.000000,
	MULTIPLE_RCPTS 0.100000, MULTIPLE_REAL_RCPTS 0.000000, NO_CTA_FOUND 0.000000,
	NO_CTA_URI_FOUND 0.000000, NO_FUR_HEADER 0.000000, NO_URI_HTTPS 0.000000,
	OUTBOUND 0.000000, OUTBOUND_SOPHOS 0.000000, REFERENCES 0.000000,
	SENDER_NO_AUTH 0.000000, SUSP_DH_NEG 0.000000, USER_AGENT 0.000000,
	__ANY_URI 0.000000, __BODY_NO_MAILTO 0.000000,
	__BOUNCE_CHALLENGE_SUBJ 0.000000, __BOUNCE_NDR_SUBJ_EXEMPT 0.000000,
	__BULK_NEGATE 0.000000, __CT 0.000000, __CTE 0.000000,
	__CT_TEXT_PLAIN 0.000000, __DKIM_ALIGNS_1 0.000000, __DKIM_ALIGNS_2 0.000000,
	__DQ_NEG_DOMAIN 0.000000, __DQ_NEG_HEUR 0.000000, __DQ_NEG_IP 0.000000,
	__FORWARDED_MSG 0.000000, __FROM_DOMAIN_NOT_IN_BODY 0.000000,
	__FROM_NAME_NOT_IN_BODY 0.000000, __FUR_RDNS_SOPHOS 0.000000,
	__HAS_CC_HDR 0.000000, __HAS_FROM 0.000000, __HAS_MSGID 0.000000,
	__HAS_REFERENCES 0.000000, __HEADER_ORDER_FROM 0.000000,
	__IN_REP_TO 0.000000, __MAIL_CHAIN 0.000000, __MIME_BOUND_CHARSET 0.000000,
	__MIME_TEXT_ONLY 0.000000, __MIME_TEXT_P 0.000000, __MIME_TEXT_P1 0.000000,
	__MIME_VERSION 0.000000, __MOZILLA_USER_AGENT 0.000000,
	__MSGID_HEX_844412 0.000000, __MULTIPLE_RCPTS_CC_X2 0.000000,
	__MULTIPLE_RCPTS_TO_X2 0.000000, __NO_HTML_TAG_RAW 0.000000,
	__OUTBOUND_SOPHOS_FUR 0.000000, __OUTBOUND_SOPHOS_FUR_IP 0.000000,
	__OUTBOUND_SOPHOS_FUR_RDNS 0.000000, __RCVD_PASS 0.000000,
	__REFERENCES 0.000000, __SANE_MSGID 0.000000, __SCAN_D_NEG 0.000000,
	__SCAN_D_NEG2 0.000000, __SCAN_D_NEG_HEUR 0.000000,
	__SCAN_D_NEG_HEUR2 0.000000, __SUBJ_ALPHA_END 0.000000,
	__SUBJ_ALPHA_NEGATE 0.000000, __SUBJ_REPLY 0.000000,
	__TO_MALFORMED_2 0.000000, __TO_NAME 0.000000,
	__TO_NAME_DIFF_FROM_ACC 0.000000, __TO_REAL_NAMES 0.000000,
	__URI_NO_MAILTO 0.000000, __URI_NO_WWW 0.000000, __USER_AGENT 0.000000,
	__X_MAILSCANNER 0.000000
X-SASI-Probability: 8%
X-SASI-RCODE: 200
X-SASI-Version: Antispam-Engine: 5.1.4, AntispamData: 2025.8.15.92719
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=dd-wrt.com; s=mikd;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID; bh=4vBUeuXNDIqoWiMlVcX7q5VBbBd1IYHnZHLNnL49+N4=;
	b=Rm7iApXJ2z8XcI7Jyc9tKHcV7DuAC+8jeKdrW8aQU+1cCYcnxoTAKsl8rAE0z2C1qhFX+80W38Q7a3NxEtIexf0/u2SBDtlSA97J59oZ9thwU5UnbH3e4Rk8RkJKRT7qmptFHFZhHjE0eKyjIzrjHmI0sCqCnIB7SmqeEayRSqQ=;
Message-ID: <573c76a8-c2a0-4b9c-b5a8-762b8d094b81@dd-wrt.com>
Date: Fri, 15 Aug 2025 11:55:14 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: ath12k: REO status on PPC does not work
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>,
 Jeff Johnson <jjohnson@kernel.org>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <aJ7sDOoWmf4jLpjo@FUE-ALEWI-WINX>
From: Sebastian Gottschall <s.gottschall@dd-wrt.com>
In-Reply-To: <aJ7sDOoWmf4jLpjo@FUE-ALEWI-WINX>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass (webmail.newmedia-net.de: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=s.gottschall@dd-wrt.com; helo=webmail.newmedia-net.de;
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: s.gottschall@dd-wrt.com
X-SA-Exim-Scanned: No (on webmail.newmedia-net.de); SAEximRunCond expanded to false
X-NMN-MailScanner-Information: Please contact the ISP for more information
X-NMN-MailScanner-ID: 1umr9W-000ATi-TP
X-NMN-MailScanner: Found to be clean
X-NMN-MailScanner-From: s.gottschall@dd-wrt.com
X-Received:  from localhost ([127.0.0.1] helo=webmail.newmedia-net.de)
	by webmail.newmedia-net.de with esmtp (Exim 4.72)
	(envelope-from <s.gottschall@dd-wrt.com>)
	id 1umr9W-000ATi-TP; Fri, 15 Aug 2025 11:55:14 +0200

i played already with big endian platforms and ath11k (not ath12k) for 
months. there is also a problem with the dma descriptors. the firmware 
simply doesnt support big endian with host communication at the end even 
if there is a endian flag for the firmware.  dont get into this rabit 
hole. (i worked 3 months on it and gave up)
at the end (i was working on a cavium octeon platform at that time) i 
just switched the kernel boot to little endian which is possible on many 
ppc platforms too.

Am 15.08.2025 um 10:13 schrieb Alexander Wilhelm:
> Hello devs,
>
> I'm currently working on getting the 'ath12k' driver running on a big endian
> PowerPC platform and have encountered the following issue.
>
> In the function 'ath12k_dp_rx_process_reo_status', the REO status is determined
> by inspecting memory that the hardware has previously written via DMA.
> Specifically, during the call to 'ath12k_hal_srng_access_begin', the driver
> reads the value of 'hp_addr' for the destination ring (in my case, always with
> ID 21). On the big endian platform, this value is consistently 0, which prevents
> the REO status from being updated.
>
> Interestingly, DMA read/write accesses work fine for other rings, just not for
> this one. What makes the REO status ring so special? I couldn’t find anything in
> the initialization routine that would explain the difference.
>
> Could anyone give me a hint on what I should be looking for?
>
>
> Best regards
> Alexander Wilhelm
>
>

