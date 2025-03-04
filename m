Return-Path: <linux-wireless+bounces-19734-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C3CA4D0B4
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 02:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D310A16B806
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 01:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B240273FD;
	Tue,  4 Mar 2025 01:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dd-wrt.com header.i=@dd-wrt.com header.b="lbqxS/E+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.as201155.net (mail.as201155.net [185.84.6.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219B777102
	for <linux-wireless@vger.kernel.org>; Tue,  4 Mar 2025 01:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.84.6.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741051384; cv=none; b=sSVT+2j3HW8mymNvfi1smkc0gnJFzOADnZRddp3hKuCLKrL+Frc/bU3KfZVIouii5ELgk08DM3dSck5vsC6mlkOvGxGK3U+csoEcHWr6+s1pcvrX+/unGOeGqZUZ+YmAVKGJByJRDLJYecjQFAJQ/guKd3VNBgV9FEV9xJoOjb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741051384; c=relaxed/simple;
	bh=0AaUMBzSiDW9zqz+6fPAt+s3RJxCw9Pu2Mq9f3W47JQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R5DiI7xNVYa7QVKHFSOGQfooOewjrp2V0Okhr3Ch6teIucfbhJ9W3ljj0typkOA/Yp0Hht7jHZYI5Zt/CrG3I++rgvAdCkcOe/DDBBlm4ZdWQHWceZtiVvXW9wd5EzXEd9dw/Va26y6gMsWfNX8gyWmP3+6iLUcmwkM9R702128=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dd-wrt.com; spf=pass smtp.mailfrom=dd-wrt.com; dkim=pass (1024-bit key) header.d=dd-wrt.com header.i=@dd-wrt.com header.b=lbqxS/E+; arc=none smtp.client-ip=185.84.6.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dd-wrt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dd-wrt.com
Received: from smtps.newmedia-net.de ([2a05:a1c0:0:de::167]:40580 helo=webmail.newmedia-net.de)
	by mail.as201155.net with esmtps  (TLS1) tls TLS_RSA_WITH_AES_256_CBC_SHA
	(Exim 4.97.1)
	(envelope-from <s.gottschall@dd-wrt.com>)
	id 1tpGyl-000000007ra-08gn
	for linux-wireless@vger.kernel.org;
	Tue, 04 Mar 2025 02:21:51 +0100
X-SASI-Hits: BODYTEXTP_SIZE_3000_LESS 0.000000, BODY_SIZE_1000_LESS 0.000000,
	BODY_SIZE_2000_LESS 0.000000, BODY_SIZE_5000_LESS 0.000000,
	BODY_SIZE_600_699 0.000000, BODY_SIZE_7000_LESS 0.000000, CTE_8BIT 0.000000,
	DKIM_ALIGNS 0.000000, DKIM_SIGNATURE 0.000000, HTML_00_01 0.050000,
	HTML_00_10 0.050000, LEGITIMATE_SIGNS 0.000000, MULTIPLE_REAL_RCPTS 0.000000,
	NO_CTA_URI_FOUND 0.000000, NO_FUR_HEADER 0.000000, NO_REAL_NAME 0.000000,
	NO_URI_HTTPS 0.000000, OUTBOUND 0.000000, OUTBOUND_SOPHOS 0.000000,
	SENDER_NO_AUTH 0.000000, SUSP_DH_NEG 0.000000, __ANY_URI 0.000000,
	__BODY_NO_MAILTO 0.000000, __BULK_NEGATE 0.000000, __CC_NAME 0.000000,
	__CC_NAME_DIFF_FROM_ACC 0.000000, __CC_REAL_NAMES 0.000000, __CTE 0.000000,
	__DKIM_ALIGNS_1 0.000000, __DKIM_ALIGNS_2 0.000000, __DQ_NEG_DOMAIN 0.000000,
	__DQ_NEG_HEUR 0.000000, __DQ_NEG_IP 0.000000,
	__FROM_DOMAIN_IN_ANY_CC1 0.000000, __FROM_DOMAIN_IN_RCPT 0.000000,
	__FROM_NAME_NOT_IN_ADDR 0.000000, __FUR_RDNS_SOPHOS 0.000000,
	__HAS_CC_HDR 0.000000, __HAS_FROM 0.000000, __HAS_MSGID 0.000000,
	__HAS_X_MAILER 0.000000, __MIME_TEXT_ONLY 0.000000, __MIME_TEXT_P 0.000000,
	__MIME_TEXT_P1 0.000000, __MIME_VERSION 0.000000, __NO_HTML_TAG_RAW 0.000000,
	__OUTBOUND_SOPHOS_FUR 0.000000, __OUTBOUND_SOPHOS_FUR_IP 0.000000,
	__OUTBOUND_SOPHOS_FUR_RDNS 0.000000, __PHISH_SPEAR_SUBJ_TEAM 0.000000,
	__RCVD_PASS 0.000000, __SANE_MSGID 0.000000, __SUBJ_ALPHA_END 0.000000,
	__SUBJ_STARTS_S_BRACKETS 0.000000, __TO_MALFORMED_2 0.000000,
	__TO_NO_NAME 0.000000, __URI_MAILTO 0.000000, __URI_NO_WWW 0.000000,
	__URI_NS 0.000000, __X_MAILSCANNER 0.000000
X-SASI-Probability: 7%
X-SASI-RCODE: 200
X-SASI-Version: Antispam-Engine: 5.1.4, AntispamData: 2025.3.4.2728
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=dd-wrt.com; s=mikd;
	h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From; bh=ki1xzJwWP7McZPBsrabm7H1wwyJdZgQzYrmKGW6mHNo=;
	b=lbqxS/E+06P3zdBIAjvUq+D/zKk10kN4Lmo6iL3YPevua/D2zJK3FRelVjJKorexj4y3jjl41gf4r/h3Fm4fDiJolly6/v5gl+FNC4OJLrizpC0zn1bp4Bfr7zbxJ8w0ACiPigJM0m4VowOAB/BiSsFJG7IScXo1ovCj16RTLjw=;
From: s.gottschall@dd-wrt.com
To: linux-wireless@vger.kernel.org
Cc: Sebastian Gottschall <s.gottschall@dd-wrt.com>
Subject: [PATCH 0/1] wil6210: fix support for sparrow chipsets
Date: Tue,  4 Mar 2025 08:21:30 +0700
Message-Id: <20250304012131.25970-1-s.gottschall@dd-wrt.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass (webmail.newmedia-net.de: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=s.gottschall@dd-wrt.com; helo=webmail.newmedia-net.de;
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: s.gottschall@dd-wrt.com
X-SA-Exim-Scanned: No (on webmail.newmedia-net.de); SAEximRunCond expanded to false
X-NMN-MailScanner-Information: Please contact the ISP for more information
X-NMN-MailScanner-ID: 1tpGyS-000C4T-Fe
X-NMN-MailScanner: Found to be clean
X-NMN-MailScanner-From: s.gottschall@dd-wrt.com
X-Received:  from localhost.localdomain ([127.0.0.1] helo=webmail.newmedia-net.de)
	by webmail.newmedia-net.de with esmtp (Exim 4.72)
	(envelope-from <s.gottschall@dd-wrt.com>)
	id 1tpGyS-000C4T-Fe; Tue, 04 Mar 2025 02:21:32 +0100

From: Sebastian Gottschall <s.gottschall@dd-wrt.com>

the wil6210 driver irq handling code is unconditionally writing
edma irq registers which are supposed to be only used on Talyn chipsets.
This however leade to a chipset hang on the older sparrow chipset
generation and firmware will not even boot.
Fix that by simply checking for edma support before handling these
registers.

Tested on Netgear R9000

Sebastian Gottschall (1):
  wil6210: fix support for sparrow chipsets

 drivers/net/wireless/ath/wil6210/interrupt.c | 26 ++++++++++++--------
 1 file changed, 16 insertions(+), 10 deletions(-)

-- 
2.35.3


