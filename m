Return-Path: <linux-wireless+bounces-16648-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4869F9775
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2024 18:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF856189A578
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2024 17:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FA821A450;
	Fri, 20 Dec 2024 16:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dd-wrt.com header.i=@dd-wrt.com header.b="Ap3Xr1wJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.as201155.net (mail.as201155.net [185.84.6.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7945221C169
	for <linux-wireless@vger.kernel.org>; Fri, 20 Dec 2024 16:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.84.6.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734713766; cv=none; b=bqsk8QjFHqfvZ/6PsOvYeUGksLciKxSH6a9hXm5n8LNjY2z76WzvA76bAH9rV085ZwnxJJUyohdvirWyICaX57L8lwPCDTZaSxl9uUEBGqMf6yEjUref7mPkoNqr139cqFs7FiqWQJYfO2GR20n+HnggdT0mDGfzIdfG7NQuwC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734713766; c=relaxed/simple;
	bh=CA6oZ97OzVkjm4kYVeThGAUyAFEGrQTm6SIWkv5hnd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iC6M8nUySWVxXYqYg8Y4po0SqzppXaCiGrCm2uugP3hdH2C+RHe0P5pvDbD7nRuwm4DmRREJDXBArbAaxoxVuXW9DRdRFk0wxHZs2D95Q7KL2zo6jOCacr2MGRf16g+HmvFuKnTwmBRLgpsOK3CGbUxtb3PiS3lLBvXVXZclTkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dd-wrt.com; spf=pass smtp.mailfrom=dd-wrt.com; dkim=pass (1024-bit key) header.d=dd-wrt.com header.i=@dd-wrt.com header.b=Ap3Xr1wJ; arc=none smtp.client-ip=185.84.6.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dd-wrt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dd-wrt.com
Received: from smtps.newmedia-net.de ([2a05:a1c0:0:de::167]:56196 helo=webmail.newmedia-net.de)
	by mail.as201155.net with esmtps  (TLS1) tls TLS_RSA_WITH_AES_256_CBC_SHA
	(Exim 4.97.1)
	(envelope-from <s.gottschall@dd-wrt.com>)
	id 1tOgFY-000000003pU-0l0R;
	Fri, 20 Dec 2024 17:53:16 +0100
X-SASI-Hits: BODYTEXTP_SIZE_3000_LESS 0.000000, BODY_SIZE_1500_1599 0.000000,
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
	__BULK_NEGATE 0.000000, __COURIER_PHRASE 0.000000, __CT 0.000000,
	__CTE 0.000000, __CT_TEXT_PLAIN 0.000000, __DKIM_ALIGNS_1 0.000000,
	__DKIM_ALIGNS_2 0.000000, __DQ_NEG_DOMAIN 0.000000, __DQ_NEG_HEUR 0.000000,
	__DQ_NEG_IP 0.000000, __FORWARDED_MSG 0.000000, __FRAUD_URGENCY 0.000000,
	__FROM_DOMAIN_NOT_IN_BODY 0.000000, __FROM_NAME_NOT_IN_BODY 0.000000,
	__FUR_RDNS_SOPHOS 0.000000, __HAS_CC_HDR 0.000000, __HAS_FROM 0.000000,
	__HAS_MSGID 0.000000, __HAS_REFERENCES 0.000000,
	__HEADER_ORDER_FROM 0.000000, __IN_REP_TO 0.000000, __MAIL_CHAIN 0.000000,
	__MIME_BOUND_CHARSET 0.000000, __MIME_TEXT_ONLY 0.000000,
	__MIME_TEXT_P 0.000000, __MIME_TEXT_P1 0.000000, __MIME_VERSION 0.000000,
	__MOZILLA_USER_AGENT 0.000000, __MSGID_HEX_844412 0.000000,
	__MULTIPLE_RCPTS_CC_X2 0.000000, __MULTIPLE_RCPTS_TO_X2 0.000000,
	__NO_HTML_TAG_RAW 0.000000, __OUTBOUND_SOPHOS_FUR 0.000000,
	__OUTBOUND_SOPHOS_FUR_IP 0.000000, __OUTBOUND_SOPHOS_FUR_RDNS 0.000000,
	__PHISH_SPEAR_SUBJ_ALERT 0.000000, __RCVD_PASS 0.000000,
	__REFERENCES 0.000000, __SANE_MSGID 0.000000, __SCAN_D_NEG 0.000000,
	__SCAN_D_NEG2 0.000000, __SCAN_D_NEG_HEUR 0.000000,
	__SCAN_D_NEG_HEUR2 0.000000, __SUBJ_ALPHA_NEGATE 0.000000,
	__SUBJ_REPLY 0.000000, __TO_MALFORMED_2 0.000000, __TO_NAME 0.000000,
	__TO_NAME_DIFF_FROM_ACC 0.000000, __TO_REAL_NAMES 0.000000,
	__URI_NO_MAILTO 0.000000, __URI_NO_WWW 0.000000, __USER_AGENT 0.000000,
	__X_MAILSCANNER 0.000000
X-SASI-Probability: 8%
X-SASI-RCODE: 200
X-SASI-Version: Antispam-Engine: 5.1.4, AntispamData: 2024.12.20.161246
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=dd-wrt.com; s=mikd;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID; bh=tdv9e/Jt/cPRciMakOMf1qco3ohYpd0DydId7EL4h5w=;
	b=Ap3Xr1wJbBrM2QVb37Ic73N4t4MFBbTNyVUR9pF4j4LXtm97k8LbJlv9ofcrOc1/eBwpEC/a5NqrQYfdQ96izJpwvMf+WbP0DPFGYGJYS8wSVTkkQTZovA0P0xko4/tumV9GAkdgrmtTJm/JPEj0lBtePO1hwSCD1RIXMD4NhFk=;
Message-ID: <12798910-71aa-46da-b7b4-139669abfdb0@dd-wrt.com>
Date: Fri, 20 Dec 2024 17:52:56 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: Potential Broadcast Issues After GTK Key Exchange on ath11k with
 IPQ8072A (QCN5024/QCN5054)
To: Remi Pommarel <repk@triplefau.lt>, Steffen Moser <lists@steffen-moser.de>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
References: <c6366409-9928-4dd7-bf7b-ba7fcf20eabf@steffen-moser.de>
 <Z2Q9POuV-6MIdzRf@pilgrim>
From: Sebastian Gottschall <s.gottschall@dd-wrt.com>
In-Reply-To: <Z2Q9POuV-6MIdzRf@pilgrim>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass (webmail.newmedia-net.de: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=s.gottschall@dd-wrt.com; helo=webmail.newmedia-net.de;
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: s.gottschall@dd-wrt.com
X-SA-Exim-Scanned: No (on webmail.newmedia-net.de); SAEximRunCond expanded to false
X-NMN-MailScanner-Information: Please contact the ISP for more information
X-NMN-MailScanner-ID: 1tOgFG-000DFv-9R
X-NMN-MailScanner: Found to be clean
X-NMN-MailScanner-From: s.gottschall@dd-wrt.com
X-Received:  from localhost.localdomain ([127.0.0.1] helo=webmail.newmedia-net.de)
	by webmail.newmedia-net.de with esmtp (Exim 4.72)
	(envelope-from <s.gottschall@dd-wrt.com>)
	id 1tOgFG-000DFv-9R; Fri, 20 Dec 2024 17:52:58 +0100

Hi Remi

Am 19.12.2024 um 16:35 schrieb Remi Pommarel:
> Hi Steffen.
>
> On Thu, Dec 19, 2024 at 04:02:30PM +0100, Steffen Moser wrote:
>> Hello everyone,
>>
>> I've encountered a possible issue in a DD-WRT [1] setup where broadcast
>> packets stop being delivered after a GTK (Group Temporal Key) exchange. This
>> issue occurs on a system with the following hardware:
>>
>>      Access Point Hardware: DynaLink DL-WRX36
>>      Router Software: DD-WRT v3.0-r58819 std (12/13/24)
>>      CPU: Qualcomm IPQ8072A
>>      WiFi Chips: Qualcomm QCN5024 and Qualcomm QCN5054
>>      WiFi Driver: ath11k
>>      Firmware: WLAN.HK.2.12-01460-QCAHKSWPL_SILICONZ-1
>>      NSS FW version: NSS.FW.12.5-210-HK.R
>>      Kernel: Linux WL-AP-EG 6.6.64-rt29 #1791 SMP Thu Dec 12 16:41:51 +07
>> 2024 aarch64 DD-WRT
>>
>> The behavior is such that after a GTK exchange, the AP can get into a "weird
>> state". When being there, broadcast frames like ARP or mDNS are no longer
>> reliably delivered to connected clients while unicasts come still through.
>> In this "weird state", the channel quality (active time vs. busy time) goes
>> down and latencies to the still reachable WIFI clients rise.
> This looks a lot like an issue we hit a while back. There is this patch
> [0] from Qualcomm's wlan-open repository. It is a revert of [1]. Using
> that the issue was never reproduced. Maybe this can help.
>
> Also adding ath11k list.
>
> Regards.

thank you for that hint. i  will integrate it into dd-wrt asap

Sebastian

>

