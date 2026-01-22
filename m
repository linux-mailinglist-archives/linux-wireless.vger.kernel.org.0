Return-Path: <linux-wireless+bounces-31052-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFjWNkaEcWk1IAAAu9opvQ
	(envelope-from <linux-wireless+bounces-31052-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 02:58:30 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F666609B8
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 02:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EF473445B61
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 01:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154222638BC;
	Thu, 22 Jan 2026 01:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="VWivy2tV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8E4366DD3
	for <linux-wireless@vger.kernel.org>; Thu, 22 Jan 2026 01:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769046853; cv=none; b=R5yGTFIGx69WD+uNp8e+gKyUgvNN1I8FKi62SL8HS7f2QUJVqd1qAx4zkDB4LD2Xw8dfti9ifqkNfeBgchmU43tjxK2eAA67E9dvr/3+kLdgt4dFc8PMRqCNDmJULr7awToQr0rIFC+P5ng+p0rAeFcwAgze/H8D2nIi0TLyTPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769046853; c=relaxed/simple;
	bh=iuMEKJACm7JJgjjE4d+HeEOeb6TNi/SgN0AGrB5d18A=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=bOA5e+nlOJDBU5oOlA8b+NX5GjqNYavxRmHZP1LZKztaPBcy2js3Ii/joFn4DC017SdxxUkl33VR1N/cWvPpAsLF4fgmsmvwS/KtfD5RLF2Q6DUk4ON5B6kovnoB9X9ez0MxYj7t09guU17tdr4rzTLKU6PH4ee8NfO/y1VALPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=VWivy2tV; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60M1s7W01095522, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1769046847; bh=DjhEskoRltR2rjR0HbksImADD1rB17V7blUKWMb0/u0=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=VWivy2tVdET4RE4+xKxFBuIzXPKdIzn56/18gIBNuhXcvwexxieJMltGlAkJX3pZC
	 vN/YY7Y2CrOn+0XIs3uWgDY1FFWj3LI86O5JDYJc8GUKOpbkefzUHw/F71Ntsw2oFi
	 S94uZpTtzo3ELDsD25yZLyef/hU1098ntTk5l1E/QEg892ECksCtVL1LefBAfS9Crw
	 toZOBQGnHqTFN6wQyFqdQqUddsBmOmwlgVhqEerJuEvYVbemLtt09wP6GNlXDrqi6I
	 cu7bcM++GOiW4rCjJ6ZFpH+VC5D/77l0d50PM4mv+Y6UH8h7JHeblcLR3nBI4pjWhL
	 sEIkQ0Hk/J9uQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60M1s7W01095522
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 22 Jan 2026 09:54:07 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 22 Jan 2026 09:54:06 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 22 Jan 2026 09:54:06 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Thu, 22 Jan 2026 09:54:06 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <echuang@realtek.com>, <phhuang@realtek.com>
Subject: Re: [PATCH rtw-next 01/12] wifi: rtw89: mac: clear global interrupt right after power-on
In-Reply-To: <20260114013950.19704-2-pkshih@realtek.com>
References: <20260114013950.19704-1-pkshih@realtek.com> <20260114013950.19704-2-pkshih@realtek.com>
Message-ID: <785b2016-376d-450f-bb94-cd3a033993b0@RTKEXHMBS03.realtek.com.tw>
Date: Thu, 22 Jan 2026 09:54:06 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-31052-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[realtek.com,none];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:email,realtek.com:dkim,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9F666609B8
X-Rspamd-Action: no action

Ping-Ke Shih <pkshih@realtek.com> wrote:

> The global interrupt indicator is always persistent, and firmware will
> handle it right after boot. To prevent this unnecessary handling, clear
> the indicator before downloading firmware.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

12 patch(es) applied to rtw-next branch of rtw.git, thanks.

e497fc05e9f5 wifi: rtw89: mac: clear global interrupt right after power-on
1e3c50e0b491 wifi: rtw89: phy: add {read,write}_rf_v3 for RTL8922D
3b99dac7bf91 wifi: rtw89: phy: add ops rtw89_phy_gen_be_v1 for RTL8922D
fc31826cbc24 wifi: rtw89: phy: abstract start address and EHT of PHY status bitmap
0e8818a309f7 wifi: rtw89: phy: extend register to read history 2 of PHY env_monitor
ace51dc80334 wifi: rtw89: phy: abstract BB wrap registers to share initial flow
d6cc6e12c15b wifi: rtw89: phy: update bb wrapper TPU init
51cc8220f8ce wifi: rtw89: phy: update BB wrapper RFSI
ee866bb4aa78 wifi: rtw89: phy: write BB wrapper registers with flush
a0343cdc7767 wifi: rtw89: phy: refine initial flow of BB wrapper
76bada91a41a wifi: rtw89: phy: fix incorrect power limit by mac_id
6f6d7a325fbd wifi: rtw89: fix unable to receive probe responses under MLO connection

---
https://github.com/pkshih/rtw.git


