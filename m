Return-Path: <linux-wireless+bounces-10563-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 721F493DE81
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jul 2024 12:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 058082839A2
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jul 2024 10:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A9642045;
	Sat, 27 Jul 2024 10:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dd-wrt.com header.i=@dd-wrt.com header.b="sijTrzUr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.as201155.net (mail.as201155.net [185.84.6.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70922328B6
	for <linux-wireless@vger.kernel.org>; Sat, 27 Jul 2024 10:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.84.6.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722074584; cv=none; b=M2aqRaikEJfIkPREBJZHTfN0wFIq9Ma9//MzBjiEfqzPvdZiM+TfmfbLboVt8ktm62MyqTLFlP4Z9pKl9prIY1e74IZNmwLDorqpIefxIjWUE9gWOk9pfO9uV8BAUYDjmtuZOm+dlGlYQkrVlaPB/Lv1CTBntEcbmydWZDztgaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722074584; c=relaxed/simple;
	bh=tEd7ooambl03GIxeUt6rGYe3J5qo1MovlOtmTFvXhww=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=DMEu+fQ9r7p4B0gkRLXecV4oQeh5BCeILdCXarg5PyfnEVrvsItdEN966ZjxwbMyNc/YCLNR09m/k0KCDSZqlUAGXQ1moPL4g55Usx54FNm5nllNWoPNz//fEkQEtjlF3F9hLR2sEHW1TaBb7/DaKObfvKs2QxL1ebAk9fk+AaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dd-wrt.com; spf=pass smtp.mailfrom=dd-wrt.com; dkim=pass (1024-bit key) header.d=dd-wrt.com header.i=@dd-wrt.com header.b=sijTrzUr; arc=none smtp.client-ip=185.84.6.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dd-wrt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dd-wrt.com
Received: from smtps.newmedia-net.de ([2a05:a1c0:0:de::167]:48362 helo=webmail.newmedia-net.de)
	by mail.as201155.net with esmtps  (TLS1) tls TLS_RSA_WITH_AES_256_CBC_SHA
	(Exim 4.97.1)
	(envelope-from <s.gottschall@dd-wrt.com>)
	id 1sXeDa-000000000zF-1wpG;
	Sat, 27 Jul 2024 12:00:03 +0200
X-SASI-Hits: BODYTEXTP_SIZE_3000_LESS 0.000000, BODY_SIZE_1000_LESS 0.000000,
	BODY_SIZE_2000_LESS 0.000000, BODY_SIZE_5000_LESS 0.000000,
	BODY_SIZE_500_599 0.000000, BODY_SIZE_7000_LESS 0.000000, CTE_7BIT 0.000000,
	DKIM_ALIGNS 0.000000, DKIM_SIGNATURE 0.000000, HTML_00_01 0.050000,
	HTML_00_10 0.050000, IN_REP_TO 0.000000, LEGITIMATE_SIGNS 0.000000,
	MSGID_SAMEAS_FROM_HEX_844412 0.100000, MSG_THREAD 0.000000,
	MULTIPLE_REAL_RCPTS 0.000000, NO_CTA_FOUND 0.000000,
	NO_CTA_URI_FOUND 0.000000, NO_FUR_HEADER 0.000000, NO_URI_HTTPS 0.000000,
	OUTBOUND 0.000000, OUTBOUND_SOPHOS 0.000000, REFERENCES 0.000000,
	SENDER_NO_AUTH 0.000000, SUSP_DH_NEG 0.000000, USER_AGENT 0.000000,
	__ANY_URI 0.000000, __BODY_NO_MAILTO 0.000000,
	__BOUNCE_CHALLENGE_SUBJ 0.000000, __BOUNCE_NDR_SUBJ_EXEMPT 0.000000,
	__BULK_NEGATE 0.000000, __CT 0.000000, __CTE 0.000000,
	__CT_TEXT_PLAIN 0.000000, __DKIM_ALIGNS_1 0.000000, __DKIM_ALIGNS_2 0.000000,
	__DQ_NEG_DOMAIN 0.000000, __DQ_NEG_HEUR 0.000000, __DQ_NEG_IP 0.000000,
	__FORWARDED_MSG 0.000000, __FROM_DOMAIN_NOT_IN_BODY 0.000000,
	__FUR_RDNS_SOPHOS 0.000000, __HAS_CC_HDR 0.000000, __HAS_FROM 0.000000,
	__HAS_MSGID 0.000000, __HAS_REFERENCES 0.000000,
	__HEADER_ORDER_FROM 0.000000, __IN_REP_TO 0.000000, __MAIL_CHAIN 0.000000,
	__MIME_BOUND_CHARSET 0.000000, __MIME_TEXT_ONLY 0.000000,
	__MIME_TEXT_P 0.000000, __MIME_TEXT_P1 0.000000, __MIME_VERSION 0.000000,
	__MOZILLA_USER_AGENT 0.000000, __MSGID_HEX_844412 0.000000,
	__MULTIPLE_RCPTS_TO_X2 0.000000, __NO_HTML_TAG_RAW 0.000000,
	__OUTBOUND_SOPHOS_FUR 0.000000, __OUTBOUND_SOPHOS_FUR_IP 0.000000,
	__OUTBOUND_SOPHOS_FUR_RDNS 0.000000, __PHISH_SPEAR_SUBJECT 0.000000,
	__PHISH_SPEAR_SUBJ_ALERT 0.000000, __PHISH_SPEAR_SUBJ_PREDICATE 0.000000,
	__RCVD_PASS 0.000000, __REFERENCES 0.000000, __SANE_MSGID 0.000000,
	__SCAN_D_NEG 0.000000, __SCAN_D_NEG2 0.000000, __SCAN_D_NEG_HEUR 0.000000,
	__SCAN_D_NEG_HEUR2 0.000000, __SUBJ_ALPHA_END 0.000000,
	__SUBJ_ALPHA_NEGATE 0.000000, __SUBJ_REPLY 0.000000,
	__TO_MALFORMED_2 0.000000, __TO_NAME 0.000000,
	__TO_NAME_DIFF_FROM_ACC 0.000000, __TO_REAL_NAMES 0.000000,
	__URI_NO_MAILTO 0.000000, __URI_NO_WWW 0.000000, __USER_AGENT 0.000000,
	__X_MAILSCANNER 0.000000
X-SASI-Probability: 8%
X-SASI-RCODE: 200
X-SASI-Version: Antispam-Engine: 5.1.4, AntispamData: 2024.7.27.92417
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=dd-wrt.com; s=mikd;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:Message-ID; bh=OFbtf2rb8LQbBQsG+YxU/GYv6bh3Zq86eK1TSFfuEV8=;
	b=sijTrzUrD8D+ASeNn+hlf4rrR6aU6OxQuJUQvaoPg+EnExZGDlIA2JeJ4tnWbB4FrezhAu5JNGLrT0Tg2GHXiu+QkMPqdElxVWyI+U0bi9uk04BNODFt2j7uzVIq7dsj3Kkur/YX4L6Xo9/q9Sgp235Ir3Esoc2F23CF8thhkOw=;
Message-ID: <dd2e9f4b-2cc8-486d-a6cc-2f7f77217109@dd-wrt.com>
Date: Sat, 27 Jul 2024 11:59:40 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC PATCH] ath11k: fix peer addition/deletion error on sta band
 migration
From: Sebastian Gottschall <s.gottschall@dd-wrt.com>
To: Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>,
 ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20220603164559.27769-1-ansuelsmth@gmail.com>
 <420ae7cf-7b7a-4350-9dbb-00f00485acb8@dd-wrt.com>
In-Reply-To: <420ae7cf-7b7a-4350-9dbb-00f00485acb8@dd-wrt.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass (webmail.newmedia-net.de: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=s.gottschall@dd-wrt.com; helo=webmail.newmedia-net.de;
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: s.gottschall@dd-wrt.com
X-SA-Exim-Scanned: No (on webmail.newmedia-net.de); SAEximRunCond expanded to false
X-NMN-MailScanner-Information: Please contact the ISP for more information
X-NMN-MailScanner-ID: 1sXeDH-000FWd-Uw
X-NMN-MailScanner: Found to be clean
X-NMN-MailScanner-From: s.gottschall@dd-wrt.com
X-Received:  from localhost.localdomain ([127.0.0.1] helo=webmail.newmedia-net.de)
	by webmail.newmedia-net.de with esmtp (Exim 4.72)
	(envelope-from <s.gottschall@dd-wrt.com>)
	id 1sXeDH-000FWd-Uw; Sat, 27 Jul 2024 11:59:44 +0200


Am 16.07.2024 um 04:49 schrieb Sebastian Gottschall:
> I honestly think a correct solution would be have a rhash list per 
> vdev_id
> or per mac_id but again this is problematic for some function that 
> just handles
> data and have only the addr as a way to identify the peer. 


regarding this comment. i made a patch which exactly does that thing and 
solves the problem. there are just 2 functions which
have the problem. but both can be handled in a easy way. these are wmi 
events for kick station etc. in such a case i just kick them from all
mac's


