Return-Path: <linux-wireless+bounces-4520-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FF6877296
	for <lists+linux-wireless@lfdr.de>; Sat,  9 Mar 2024 19:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D02581C20C63
	for <lists+linux-wireless@lfdr.de>; Sat,  9 Mar 2024 18:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C8D111E;
	Sat,  9 Mar 2024 18:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dd-wrt.com header.i=@dd-wrt.com header.b="Q/Eu5Pgn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.as201155.net (mail.as201155.net [185.84.6.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA632375B
	for <linux-wireless@vger.kernel.org>; Sat,  9 Mar 2024 18:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.84.6.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710007324; cv=none; b=MwSYZAfON40cgfCRiecgDCJbhqM/7/Chn2waMgaPrlCTyapHd6SyVv53y8EtNoYyt/JgOp8cDXkBVYzYZKxJiqoWtIj+dNQyp6r0slUq0h1DQH1ImzhbF5STbaC1BqnXZ6GyEvRcB6g8erLYkex/doUi2OFEn9QeJetjYHxziBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710007324; c=relaxed/simple;
	bh=t3NvgmyLuoXHg/mcs6TS1OxSam02oKhUanvsRS7ge9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ic55hlELbre0lbTl8tlRqAfgb8yjgKkYUbnZDAYOppqNO8cQPvLpybWo+QH/kpDrHJcFZ2miqVG/HtohroaKnbzPlvXdkPM/IaGYtk0VU6CTdPDUus4eIeIr65XUj4EUnWk4wPomNbEcpRMYJIQ67Kb/Fw28Vva6X9EfWOV9n2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dd-wrt.com; spf=pass smtp.mailfrom=dd-wrt.com; dkim=pass (1024-bit key) header.d=dd-wrt.com header.i=@dd-wrt.com header.b=Q/Eu5Pgn; arc=none smtp.client-ip=185.84.6.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dd-wrt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dd-wrt.com
Received: from smtps.newmedia-net.de ([2a05:a1c0:0:de::167]:57564 helo=webmail.newmedia-net.de)
	by mail.as201155.net with esmtps  (TLS1) tls TLS_RSA_WITH_AES_256_CBC_SHA
	(Exim 4.96)
	(envelope-from <s.gottschall@dd-wrt.com>)
	id 1rj0yY-0002s4-1t;
	Sat, 09 Mar 2024 18:59:15 +0100
X-SASI-Hits: BODYTEXTP_SIZE_3000_LESS 0.000000, BODY_SIZE_2000_2999 0.000000,
	BODY_SIZE_5000_LESS 0.000000, BODY_SIZE_7000_LESS 0.000000,
	CTE_8BIT 0.000000, DKIM_ALIGNS 0.000000, DKIM_SIGNATURE 0.000000,
	HTML_00_01 0.050000, HTML_00_10 0.050000, IN_REP_TO 0.000000,
	LEGITIMATE_SIGNS 0.000000, MSGID_SAMEAS_FROM_HEX_844412 0.100000,
	MSG_THREAD 0.000000, MULTIPLE_RCPTS 0.100000, MULTIPLE_REAL_RCPTS 0.000000,
	NO_FUR_HEADER 0.000000, OUTBOUND 0.000000, OUTBOUND_SOPHOS 0.000000,
	REFERENCES 0.000000, SENDER_NO_AUTH 0.000000, SUSP_DH_NEG 0.000000,
	URI_WITH_PATH_ONLY 0.000000, __ANY_URI 0.000000, __BODY_NO_MAILTO 0.000000,
	__BOUNCE_CHALLENGE_SUBJ 0.000000, __BOUNCE_NDR_SUBJ_EXEMPT 0.000000,
	__BULK_NEGATE 0.000000, __CC_NAME 0.000000, __CC_NAME_DIFF_FROM_ACC 0.000000,
	__CC_REAL_NAMES 0.000000, __CP_URI_IN_BODY 0.000000, __CT 0.000000,
	__CTE 0.000000, __CT_TEXT_PLAIN 0.000000, __DKIM_ALIGNS_1 0.000000,
	__DKIM_ALIGNS_2 0.000000, __DQ_NEG_DOMAIN 0.000000, __DQ_NEG_HEUR 0.000000,
	__DQ_NEG_IP 0.000000, __FORWARDED_MSG 0.000000, __FRAUD_PARTNERSHIP 0.000000,
	__FROM_DOMAIN_NOT_IN_BODY 0.000000, __FROM_NAME_NOT_IN_BODY 0.000000,
	__FUR_RDNS_SOPHOS 0.000000, __HAS_CC_HDR 0.000000, __HAS_FROM 0.000000,
	__HAS_MSGID 0.000000, __HAS_REFERENCES 0.000000,
	__HEADER_ORDER_FROM 0.000000, __HIGHBIT_ASCII_MIX 0.000000,
	__HTTPS_URI 0.000000, __IN_REP_TO 0.000000, __MAIL_CHAIN 0.000000,
	__MIME_BOUND_CHARSET 0.000000, __MIME_TEXT_ONLY 0.000000,
	__MIME_TEXT_P 0.000000, __MIME_TEXT_P1 0.000000, __MIME_VERSION 0.000000,
	__MOZILLA_USER_AGENT 0.000000, __MSGID_HEX_844412 0.000000,
	__MULTIPLE_RCPTS_CC_X2 0.000000, __MULTIPLE_RCPTS_TO_X2 0.000000,
	__MULTIPLE_URI_TEXT 0.000000, __NO_HTML_TAG_RAW 0.000000,
	__OUTBOUND_SOPHOS_FUR 0.000000, __OUTBOUND_SOPHOS_FUR_IP 0.000000,
	__OUTBOUND_SOPHOS_FUR_RDNS 0.000000, __RCVD_PASS 0.000000,
	__REFERENCES 0.000000, __SANE_MSGID 0.000000, __SCAN_D_NEG 0.000000,
	__SCAN_D_NEG2 0.000000, __SCAN_D_NEG_HEUR 0.000000,
	__SCAN_D_NEG_HEUR2 0.000000, __SUBJ_ALPHA_END 0.000000,
	__SUBJ_ALPHA_NEGATE 0.000000, __SUBJ_REPLY 0.000000,
	__TO_MALFORMED_2 0.000000, __TO_NAME 0.000000,
	__TO_NAME_DIFF_FROM_ACC 0.000000, __TO_REAL_NAMES 0.000000,
	__URI_ENDS_IN_SLASH 0.000000, __URI_HAS_HYPHEN_USC 0.000000,
	__URI_IN_BODY 0.000000, __URI_MAILTO 0.000000, __URI_NOT_IMG 0.000000,
	__URI_NO_WWW 0.000000, __URI_NS 0.000000, __URI_WITH_PATH 0.000000,
	__USER_AGENT 0.000000, __X_MAILSCANNER 0.000000
X-SASI-Probability: 8%
X-SASI-RCODE: 200
X-SASI-Version: Antispam-Engine: 5.1.4, AntispamData: 2024.3.9.173017
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=dd-wrt.com; s=mikd;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID; bh=RfEPUE/s2ovA9Fjpc51gZmR3vhNMiXC763Bj0mwC0dY=;
	b=Q/Eu5PgnXLQwMSES/d9nQ2JI7Flke2Sqa7KXKzVVIhJRf/fQMghpO9E1iIyejOBRY40V7H2b+bthUWYbumHEIkmos8UgQNNiw6rC9ENP6BYUmLgMSrwCZlJ15nCUTsrdcWViSQ+xmdQ2SxWQnvwmwTLhEUSuCzD65iB9pHyDd0Y=;
Message-ID: <3b57d932-0848-40f4-ab2d-a8d4afe11df1@dd-wrt.com>
Date: Sat, 9 Mar 2024 18:58:47 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: New staging repos for ath1*k firmware
To: Kalle Valo <kvalo@kernel.org>, Robert Marko <robert.marko@sartura.hr>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,
 ath10k <ath10k@lists.infradead.org>, ath11k <ath11k@lists.infradead.org>,
 ath12k <ath12k@lists.infradead.org>,
 linux-wireless <linux-wireless@vger.kernel.org>
References: <bac97f31-4a70-4c4c-8179-4ede0b32f869@quicinc.com>
 <CA+HBbNFQ+25u_PK2j3vYtiCZwv+shVAVeAHKqQCwhyCopORt4Q@mail.gmail.com>
 <874jdigf76.fsf@kernel.org>
From: Sebastian Gottschall <s.gottschall@dd-wrt.com>
In-Reply-To: <874jdigf76.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass (webmail.newmedia-net.de: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=s.gottschall@dd-wrt.com; helo=webmail.newmedia-net.de;
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: s.gottschall@dd-wrt.com
X-SA-Exim-Scanned: No (on webmail.newmedia-net.de); SAEximRunCond expanded to false
X-NMN-MailScanner-Information: Please contact the ISP for more information
X-NMN-MailScanner-ID: 1rj0yD-000FpE-At
X-NMN-MailScanner: Found to be clean
X-NMN-MailScanner-From: s.gottschall@dd-wrt.com
X-Received:  from localhost.localdomain ([127.0.0.1] helo=webmail.newmedia-net.de)
	by webmail.newmedia-net.de with esmtp (Exim 4.72)
	(envelope-from <s.gottschall@dd-wrt.com>)
	id 1rj0yD-000FpE-At; Sat, 09 Mar 2024 18:58:53 +0100


Am 07.03.2024 um 17:49 schrieb Kalle Valo:
> Robert Marko <robert.marko@sartura.hr> writes:
>
>> On Wed, Mar 6, 2024 at 8:23 PM Jeff Johnson <quic_jjohnson@quicinc.com> wrote:
>>
>>> Historically, prior to being incorporated into the linux-firmware
>>> project, firmware for kernel.org ath1*k drivers has been first published
>>> to Kalle's GitHub:
>>> https://github.com/kvalo/ath10k-firmware
>>> https://github.com/kvalo/ath11k-firmware
>>> (ath12k firmware was pushed to the ath11k-firmware repo on a temporary
>>> basis in anticipation of this move)
>>>
>>> But in order to have repos with multiple maintainers, as well as to have
>>> a hosting platform with more control, we have moved to CodeLinaro:
>>> https://git.codelinaro.org/clo/ath-firmware/ath10k-firmware
>>> https://git.codelinaro.org/clo/ath-firmware/ath11k-firmware
>>> https://git.codelinaro.org/clo/ath-firmware/ath12k-firmware
>>>
>>> Note that most people should not care about this -- normally you should
>>> use the firmware that is in the official linux-firmware repo:
>>> https://git.kernel.org/cgit/linux/kernel/git/firmware/linux-firmware.git/
>>>
>>> You should only need to access the staging repos if you need a previous
>>> version to work around an issue, or if you are testing new firmware that
>>> is supposed to fix a problem that you've reported.
>>>
>>> Please let Kalle & I know if you have any issues with these new repos!
>> Can I please ask for IPQ6018 firmware to be updated to 2.9.0.1 as well?
>>
>> We have added IPQ6018 support to OpenWrt but we are forced to use the old 2.4
>> firmware since anything newer is crashing on IPQ6018, we had the same issue on
>> IPQ8074 but it was fixed with 2.9.0.1 firmware.
>>
>> Even for IPQ8074, there is newer 2.9.0.1 firmware that is only
>> available as part of
>> QSDK and the community would benefit from being able to use it.
> We are working on getting the AP chipset firmwares updated but
> unfortunately no news yet.
why isnt qca releasing the latest firmwares at all. i mean we all know 
that the qca networking tree contains way newer firmwares for all 
chipsets since a long time

>

