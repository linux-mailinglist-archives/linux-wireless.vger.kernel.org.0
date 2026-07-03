Return-Path: <linux-wireless+bounces-38547-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id snZCHqAkR2qxTgAAu9opvQ
	(envelope-from <linux-wireless+bounces-38547-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 04:55:28 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DBE6FE036
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 04:55:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=ByDCE7O9;
	dmarc=pass (policy=none) header.from=realtek.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38547-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38547-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 79C3B3002D39
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2026 02:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F17247291;
	Fri,  3 Jul 2026 02:55:22 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95013A1B5
	for <linux-wireless@vger.kernel.org>; Fri,  3 Jul 2026 02:55:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783047322; cv=none; b=jaizSJY7WMokmZCccIrlxUaQFZZuA83lWanCEJ7WhRmP1PngUf9rjd4ygm357qxgGRcMcTZXuaderov8fOACLZO5ygDuOYb65BdBALAkf+aMbqRds3O/B8asgz/XlkzlcIUVLQ2JijeN496Pt4wcBZHSbVlO9f+ueWG8S0cvKiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783047322; c=relaxed/simple;
	bh=DASLVWcwXx86+bpXJZBj39BT0GGeN+Hw8Uradrb1Wrs=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=l19UwhrhPfTPTu0PiEjVaA6UTrwsHHuxhWHdPu3+y5Sz8HeUjcay+DAuzcNDJwlGAWLnG+3Fj1ji2P6H/jQJfJZs69mhuc/AI5aBr/jDrW6evNC+4z3VbklKo4TuGLqAqBbP9No8V8usckBX7DF2LtzpNYi0MQ9W+a7pSB0IhIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ByDCE7O9; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6632tA1312402834, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1783047310; bh=ueypNIeZJ1L5Xq7KGzlN11Are+yyW8Zox1yJVo3XBg0=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=ByDCE7O9HXBzuDv8Z4XOG10yEKFRgeuDKpr88nQ2Xvnf5Wu4GeQA3v//a30JzSWtU
	 Sn/I5OJWStCKhh1eYCQd+uPdhPMYma7IqT2hEVTro3GPzNipg3t29XDWoPp0zunzah
	 0oTX4SJDq1vnR9HdcJNvsIMP9ctSX+Fhb8jvp29XeSdzC3j8RuqkohalOUgMwVIj0D
	 K5OfaRA0668JkWVXB60CN+dV01LYOY7vM158lLUjZ3g/bzb46Q8Zz4KBpi63qBj+8g
	 5UDIleYhZgZVID9h9S5IvXsEjzbVfPIlVp3BR183DYraQGaXe09BxzdgPMdNDz1iXL
	 xebugeItyOPBA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6632tA1312402834
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 3 Jul 2026 10:55:10 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 3 Jul 2026 10:55:10 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Fri, 3 Jul 2026 10:55:10 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Ping-Ke Shih <pkshih@realtek.com>, =?utf-8?q?Georg_Bi=C3=9Feling?=
	<georg.bisseling@sea-gmbh.com>
Subject: Re: [PATCH rtw-next] wifi: rtw88: Enable receiving control frames in monitor mode
In-Reply-To: <2a52d718-9e46-47f2-84a1-d8e7b1ed89a8@gmail.com>
References: <2a52d718-9e46-47f2-84a1-d8e7b1ed89a8@gmail.com>
Message-ID: <00fbcdc2-4d26-4cb8-9448-f62e6ec42063@RTKEXHMBS03.realtek.com.tw>
Date: Fri, 3 Jul 2026 10:55:10 +0800
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-38547-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rtl8821cerfe2@gmail.com,m:linux-wireless@vger.kernel.org,m:pkshih@realtek.com,m:georg.bisseling@sea-gmbh.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:from_mime,realtek.com:email,realtek.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 62DBE6FE036

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> From: Bitterblue Smith (S.E.A. Datentechnik GmbH) <rtl8821cerfe2@gmail.com>
> 
> By default RTL8723D, RTL8703B, RTL8812A, RTL8821A, and RTL8814A are
> configured to filter out all control frames except PS-Poll, even in
> monitor mode.
> 
> Handle FIF_CONTROL in rtw_ops_configure_filter(). When it's set,
> configure REG_RXFLTMAP1 to let all control frames through. When it's
> unset, restore the original value. Because some drivers configure
> REG_RXFLTMAP1 differently, keep track of its value in a new member of
> struct rtw_hal.
> 
> Signed-off-by: Bitterblue Smith (S.E.A. Datentechnik GmbH) <rtl8821cerfe2@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

ed51a86b787f wifi: rtw88: Enable receiving control frames in monitor mode

---
https://github.com/pkshih/rtw.git


