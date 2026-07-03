Return-Path: <linux-wireless+bounces-38540-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id h/GiMQwfR2rvTQAAu9opvQ
	(envelope-from <linux-wireless+bounces-38540-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 04:31:40 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E90F6FDEF0
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 04:31:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=sGf9qnLZ;
	dmarc=pass (policy=none) header.from=realtek.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38540-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38540-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 27E5C3030F43
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2026 02:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5773C238C36;
	Fri,  3 Jul 2026 02:31:26 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFF8224B1E;
	Fri,  3 Jul 2026 02:31:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783045886; cv=none; b=TwsPFF6LVY4CpHTtYIGGhxMKTd1M0BlEWXVvTcBuBkZzRaDDApKMXWIwGfjr1R4e8jSwMIF3fzQJQZcErgEu1tv10x4tJScKhvBVP5SGb66Sel1Ysc8mKZ90GxoKKMfsse9gwNdjh0tSZf3WjcOak1KpEvMn3wYjHk42b/E9Ais=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783045886; c=relaxed/simple;
	bh=L1aA52b/oZcW2O2VyLz45MCPdltr3CtVi8wlHT8xlAc=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=YO8RFrH4eV03VMNj/+oTvfnmSuXcDdnB2KpCp10GhnJDzcxPFZ2r6gQWGUKBgGeEqLNOTln9E7XZ/yqVE3szl6hk0oOeQye35Y6MOoo7k6XteH0ki5m6XdW/BksuIb2GO+ybTrcLp8R65JfXoBx6loxqxR9EG/y0hTUvZNgnYy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=sGf9qnLZ; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6632VHrlC2389609, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1783045877; bh=V6Tv7PeywfmhjuUVg0oJGOTP3O9yBKDIPNvEP+BT3w0=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=sGf9qnLZ4vtuDm3qTbXBzMI0WIuMEKg2YRCnYUMR1JFXs9u26fSx8z+xxkVBhQN8n
	 nlVsVHa4v/AkBID/hGBdWEh3fWnUBK1F1bI3Jg9eo6mMuxure5qkXfkXAM8tgHiGND
	 5g/5qYkBGmUuH92Gf79huHfQjaOJ89GsET8q8xvbpv5DNCsi+fGvjY3l6+XeE73oYK
	 RSvJ9jj8v/eAxXR2EJsRMMK2BylAvJzR7eSk2lBmNTnyYBNZl5+8anf4GcoLnYtYZO
	 gjBu6fguOkdIHtfYWjcmbFvcAP788y6eoS/qgHlTUk7uf0KztCOd1SOzcN8piVZds0
	 lDuDJ0k/ntZtQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6632VHrlC2389609
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 3 Jul 2026 10:31:17 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 3 Jul 2026 10:31:17 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 3 Jul 2026 10:31:17 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Fri, 3 Jul 2026 10:31:12 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Wentao Guan <guanwentao@uniontech.com>, <pkshih@realtek.com>
CC: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<dian_syuan0116@realtek.com>, <zhanjun@uniontech.com>,
	<niecheng1@uniontech.com>, Wentao Guan <guanwentao@uniontech.com>
Subject: Re: [PATCH] wifi: rtw89: fw: correct rtw89_fw_h2c_default_cmac_tbl_be()
In-Reply-To: <20260611082021.46650-1-guanwentao@uniontech.com>
References: <20260611082021.46650-1-guanwentao@uniontech.com>
Message-ID: <65c281f4-b66b-462e-8c68-879b6bf6e250@RTKEXHMBS03.realtek.com.tw>
Date: Fri, 3 Jul 2026 10:31:12 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-38540-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:guanwentao@uniontech.com,m:pkshih@realtek.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dian_syuan0116@realtek.com,m:zhanjun@uniontech.com,m:niecheng1@uniontech.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[realtek.com:+];
	MISSING_XM_UA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,realtek.com:from_mime,realtek.com:email,realtek.com:dkim,uniontech.com:email,RTKEXHMBS03.realtek.com.tw:mid];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2E90F6FDEF0

Wentao Guan <guanwentao@uniontech.com> wrote:

> BE_CCTL_INFO_W2_PRELOAD_ENABLE is for h2c->w2, not h2c->w1.
> These will cause h2c->w1 wrong overlap by w2 and w2 not initialized.
> 
> Fixes: c73607b3a8ef ("wifi: rtw89: fw: add CMAC H2C command to initialize default value for RTL8922D")
> Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

e13cd023a4cd wifi: rtw89: fw: correct preload field of w2 in rtw89_fw_h2c_default_cmac_tbl_be()

---
https://github.com/pkshih/rtw.git


