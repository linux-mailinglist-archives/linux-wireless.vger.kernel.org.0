Return-Path: <linux-wireless+bounces-23034-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48386AB8E6D
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 20:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D99A169610
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 18:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2DB1EA7F9;
	Thu, 15 May 2025 18:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dd-wrt.com header.i=@dd-wrt.com header.b="i8ZBX1bS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.as201155.net (mail.as201155.net [185.84.6.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6765125B1E0
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 18:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.84.6.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747332239; cv=none; b=Kc5dE5PwQUxlkFkZxXxbR64yaQ+uIcjd4ZfrRPvJ7AAsb4cXngBoXmHFZwA+qEZOD/shBjMJ0R9+lVhL5x5N23ABLCAQVB32QOnuvs7vwzSjrq+ZZiA31tuN9bo/K4XxYrxJ+8F8/SURARj2lTokRGrwBacBKF/IN3a2ronuYVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747332239; c=relaxed/simple;
	bh=b1iBNPEo6FAn17Wq9FdjzD2hyaWi/P1zDWkSLUdNWTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RnUuFS3z23TvVGmqy/D5r2rTtRLv2TslD/qTniyNVHhbDsNMRoPSEFvDOiqI9EcB+upnUGSRyzreY31L32t2AMCBrxvpqgsbbAunpbQjfU4pMJ35NgeGEILHnFy2KoDGo/cPjBAqR2loR1wP2ReY4dIYjm9JfpOKXqDo3TEI4k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dd-wrt.com; spf=pass smtp.mailfrom=dd-wrt.com; dkim=pass (1024-bit key) header.d=dd-wrt.com header.i=@dd-wrt.com header.b=i8ZBX1bS; arc=none smtp.client-ip=185.84.6.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dd-wrt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dd-wrt.com
Received: from smtps.newmedia-net.de ([2a05:a1c0:0:de::167]:57846 helo=webmail.newmedia-net.de)
	by mail.as201155.net with esmtps  (TLS1) tls TLS_RSA_WITH_AES_256_CBC_SHA
	(Exim 4.97.1)
	(envelope-from <s.gottschall@dd-wrt.com>)
	id 1uFcvp-0000000029E-17yJ;
	Thu, 15 May 2025 20:03:45 +0200
X-SASI-Hits: BODYTEXTP_SIZE_3000_LESS 0.000000, BODY_SIZE_2000_2999 0.000000,
	BODY_SIZE_5000_LESS 0.000000, BODY_SIZE_7000_LESS 0.000000,
	CTE_7BIT 0.000000, DKIM_ALIGNS 0.000000, DKIM_SIGNATURE 0.000000,
	HTML_00_01 0.050000, HTML_00_10 0.050000, IN_REP_TO 0.000000,
	LEGITIMATE_SIGNS 0.000000, MSGID_SAMEAS_FROM_HEX_844412 0.100000,
	MSG_THREAD 0.000000, MULTIPLE_RCPTS 0.100000, MULTIPLE_REAL_RCPTS 0.000000,
	NO_CTA_FOUND 0.000000, NO_CTA_URI_FOUND 0.000000, NO_FUR_HEADER 0.000000,
	NO_URI_HTTPS 0.000000, OUTBOUND 0.000000, OUTBOUND_SOPHOS 0.000000,
	REFERENCES 0.000000, SENDER_NO_AUTH 0.000000, SUSP_DH_NEG 0.000000,
	USER_AGENT 0.000000, __ANY_URI 0.000000, __BODY_NO_MAILTO 0.000000,
	__BOUNCE_CHALLENGE_SUBJ 0.000000, __BOUNCE_NDR_SUBJ_EXEMPT 0.000000,
	__BULK_NEGATE 0.000000, __CC_NAME 0.000000, __CC_NAME_DIFF_FROM_ACC 0.000000,
	__CC_REAL_NAMES 0.000000, __CT 0.000000, __CTE 0.000000,
	__CT_TEXT_PLAIN 0.000000, __DKIM_ALIGNS_1 0.000000, __DKIM_ALIGNS_2 0.000000,
	__DQ_NEG_DOMAIN 0.000000, __DQ_NEG_HEUR 0.000000, __DQ_NEG_IP 0.000000,
	__FORWARDED_MSG 0.000000, __FROM_DOMAIN_NOT_IN_BODY 0.000000,
	__FUR_RDNS_SOPHOS 0.000000, __HAS_CC_HDR 0.000000, __HAS_FROM 0.000000,
	__HAS_MSGID 0.000000, __HAS_REFERENCES 0.000000,
	__HEADER_ORDER_FROM 0.000000, __IN_REP_TO 0.000000, __MAIL_CHAIN 0.000000,
	__MIME_BOUND_CHARSET 0.000000, __MIME_TEXT_ONLY 0.000000,
	__MIME_TEXT_P 0.000000, __MIME_TEXT_P1 0.000000, __MIME_VERSION 0.000000,
	__MOZILLA_USER_AGENT 0.000000, __MSGID_HEX_844412 0.000000,
	__MULTIPLE_RCPTS_CC_X2 0.000000, __NO_HTML_TAG_RAW 0.000000,
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
X-SASI-Version: Antispam-Engine: 5.1.4, AntispamData: 2025.5.15.172728
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=dd-wrt.com; s=mikd;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID; bh=sBz/Ja5f1gktQ1PgWCfZnCZrLBBYmcdP46pxidQq15E=;
	b=i8ZBX1bS8kaFDcg+kqXDePGDnW2ohpUnwNk+d89kfDSpxnzVnSWaYNMGBLu0kd/W1mrxZXdaDvSE8fUYcj+qjvAWeVJShNWQoFTsyCyRxDfWfcoc2AO9U1oagtIPm9rXrhspJx+MVtUzIyJn5PBXHrGHiW6lGWT4dusZXfVZV3g=;
Message-ID: <2cf0a878-1ced-43e4-b8bc-f0dff9c56dd9@dd-wrt.com>
Date: Thu, 15 May 2025 20:03:41 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: Question about TX power
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, ath11k@lists.infradead.org,
 linux-wireless@vger.kernel.org
References: <aB3AK83USvOdTvDv@FUE-ALEWI-WINX>
 <73b2bd16-66aa-405c-acda-237d56be63dd@dd-wrt.com>
 <aB3uKfu3frLyJ/2c@FUE-ALEWI-WINX>
 <592e4722-d7e1-4202-897f-e2a522074fe6@dd-wrt.com>
 <aCG2q2vNcLe4z/ff@FUE-ALEWI-WINX>
From: Sebastian Gottschall <s.gottschall@dd-wrt.com>
In-Reply-To: <aCG2q2vNcLe4z/ff@FUE-ALEWI-WINX>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass (webmail.newmedia-net.de: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=s.gottschall@dd-wrt.com; helo=webmail.newmedia-net.de;
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: s.gottschall@dd-wrt.com
X-SA-Exim-Scanned: No (on webmail.newmedia-net.de); SAEximRunCond expanded to false
X-NMN-MailScanner-Information: Please contact the ISP for more information
X-NMN-MailScanner-ID: 1uFcvm-000Bbt-R3
X-NMN-MailScanner: Found to be clean
X-NMN-MailScanner-From: s.gottschall@dd-wrt.com
X-Received:  from localhost ([127.0.0.1] helo=webmail.newmedia-net.de)
	by webmail.newmedia-net.de with esmtp (Exim 4.72)
	(envelope-from <s.gottschall@dd-wrt.com>)
	id 1uFcvm-000Bbt-R3; Thu, 15 May 2025 20:03:42 +0200


Am 12.05.2025 um 10:51 schrieb Alexander Wilhelm:
> Am Fri, May 09, 2025 at 03:49:55PM +0200 schrieb Sebastian Gottschall:
>> Am 09.05.2025 um 13:59 schrieb Alexander Wilhelm:
>>> Am Fri, May 09, 2025 at 12:54:47PM +0200 schrieb Sebastian Gottschall:
>>>> Am 09.05.2025 um 10:43 schrieb Alexander Wilhelm:
>>>>> Hello devs,
>>>>>
>>>>> I'd like to understand how TX power setting works on ath11k devices. For example
>>>>> when I'm using channel 36 for ETSI based regulatory domain, I can set up to 23
>>>>> dBm. But then I get only 20 dBm as a result. On different channels and/or
>>>>> regulatory domains I get different reductions. I tried to follow the source
>>>>> code. As far as I understood is that 'ath11k_mac_txpower_recalc' sets the
>>>>> correct values and 'ath11k_mac_op_get_txpower' return the different one.
>>>>>
>>>>> My question is where this reduction offset is encoded. Is it in the module's
>>>>> firmware or is it part of the boardfile? Thank you in advance.
>>>>>
>>>>>
>>>>> Best regards
>>>>> Alexander Wilhelm
>>>> the boardfile contains chipset specific calibration data which also defines
>>>> the hardware power limits (more specific data also included in the on board
>>>> calibration flash of the device or if its a router, in flash memory of the
>>>> router itself. in addition it includes a regulatory database which is used
>>>> by the firmware for managing the total power. you have also to consider that
>>>> the 23dbm are specified without antenna gain.
>>>> so if the antenna gain is 3 dbm, you get 20 dbm in total. this antenna gain
>>>> may again be specified in the boardfile.
>>>> so you will not find your answers in any sourcecode. its all encoded in
>>>> binary data.
>>>>
>>>> Sebastian
>>>>
>>> Alright, thank you Sebastian. Since I'm not using any calibration data on my
>>> router/AP device, all data come from the boardfile. I've also understood that
>>> the power limit reduction is related to antenna gain. I'll ask the radio module
>>> manufacturer to create another boardfile for me that matches the required
>>> antenna gain for my router/AP device.
>> my answer might be not accurate here. which chipset we are talking about for
>> ath11k?
> I'm using QCN9074 chipset.
okay. then we are at least talking about a common chipset i was talking 
about.
whats the vendor and exact name of that device? i have some sorts of 
boardfiles from vendors collected.
>
>>> Best regards
>>> Alexander Wilhelm
>>>

