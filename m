Return-Path: <linux-wireless+bounces-36624-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOoxG9XkC2r+QAUAu9opvQ
	(envelope-from <linux-wireless+bounces-36624-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 06:19:33 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CCE577317
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 06:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8C9E73012D55
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 04:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD5D2C11C6;
	Tue, 19 May 2026 04:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="vrrpa919"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5C81B4156
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 04:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779164371; cv=none; b=C4vH4huLwwDPnP4iSr0GdV2pJU+clS2rTS7aWTSpCWj3QCWfs7d2iEs0sUeAFZNGBWrU54NDawe2ExzVCieUlkfF6wKmZPs7sLEfIgoFSImVyIquDbqFcjzqVQWum3eL398VXNSoB/jtf6V0kbhS3bsTeQjfiSnzSQEapyY9uhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779164371; c=relaxed/simple;
	bh=hYwHOt4H02cRorFzHXk3wC93Iu2K4U4Xr2z69YGsCLE=;
	h=From:To:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=Rp8eGf2Q3uK6QVmQKioJtiCkvDOCQVrAUlfrDCTIaYqg2fD7+NH5lLhJln2u6qpf3ItceklDumNgMUZH5vOZWEoxyqZJFwTCEnrnb5X5hm8GmP96daowyfMDWH9lMdtublB2YM0l8G0B3jH5iZODBlfJHI5COj2Sq8DStsqtciA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=vrrpa919; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64J4JRsqC2633699, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1779164367; bh=1AC3nm9J5Y6exdzwrWl51FmdYFTY8j+oaoEYD2INKOI=;
	h=From:To:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=vrrpa919FmIMYY315C/aepuioVzuG2s36Q4dZxiBwJbSWqZV2T0SrK+JXILshJ7ZW
	 4nRcTed9wqYFCD8FRa0fwSQQGIZKjBycLUp6npqH3SOjkWLAlpQZ1wf4MABU6DVF3g
	 U26asVMERjLSSucaDhk6hPbB4KgQgeL7m4+Hf1myf2/qBvdVhoZEfh3sjrdG4pLuvT
	 lQ2bcMrssqnfB7yycwUgflBYASoICyxDnMDrPlq1pjolKB+FEjaDdTVV1Sp7pYJg+n
	 /ZobqGgiSKfBBihcOxg41cLxJMw73WZn+XYUjKG3csRWAmRIHL325my9PmNpBWzhVe
	 kISeeLzpCcwpw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 64J4JRsqC2633699
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 12:19:27 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 19 May 2026 12:19:27 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 19 May 2026 12:19:26 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Tue, 19 May 2026 12:19:26 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH rtw-next 01/11] wifi: rtw89: phy: define BB wrap data for RTL8922D variants
In-Reply-To: <20260511070148.25257-2-pkshih@realtek.com>
References: <20260511070148.25257-1-pkshih@realtek.com> <20260511070148.25257-2-pkshih@realtek.com>
Message-ID: <d0284c31-a914-4c9b-9f80-de6416210df5@RTKEXHMBS06.realtek.com.tw>
Date: Tue, 19 May 2026 12:19:26 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36624-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 25CCE577317
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Ping-Ke Shih <pkshih@realtek.com> wrote:

> The BB wrap is a hardware block to control TX power. Since RTL8922D has
> many variants with different CID and RFE types, prepare flow and dummy
> struct adopt to configuration functions for coming patches.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

11 patch(es) applied to rtw-next branch of rtw.git, thanks.

695e7f2e7901 wifi: rtw89: phy: define BB wrap data for RTL8922D variants
99237c755c27 wifi: rtw89: phy: set BB wrap of out-of-band DPD
9adb75af3f5a wifi: rtw89: phy: set BB wrap of DPD by bandwidth
f791fe306078 wifi: rtw89: phy: set BB wrap of control options
7924c027474c wifi: rtw89: phy: set BB wrap of QAM threshold
7c4ef01bb3c3 wifi: rtw89: phy: set BB wrap of QAM options
ce23c529c722 wifi: rtw89: phy: set BB wrap of trigger-base partial band
89ff0338727f wifi: rtw89: phy: set BB wrap of CIM3K
a395d7eed2f8 wifi: rtw89: phy: change order to align register order
4f2b5c83657e wifi: rtw89: phy: configure control options of BB wrapper by RFSI band
7076af642955 wifi: rtw89: phy: add BB wrapper generation 3 for RTL8922D variant

---
https://github.com/pkshih/rtw.git


