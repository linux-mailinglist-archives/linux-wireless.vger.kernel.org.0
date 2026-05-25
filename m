Return-Path: <linux-wireless+bounces-36855-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOOdA6ToE2p8HQcAu9opvQ
	(envelope-from <linux-wireless+bounces-36855-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 08:13:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7965C63DC
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 08:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 270CC3004423
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 06:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B944F37AA79;
	Mon, 25 May 2026 06:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="PhCn5xUs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2E1379C46
	for <linux-wireless@vger.kernel.org>; Mon, 25 May 2026 06:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779689629; cv=none; b=n/TQl5yChtrtAoRJkqYHhQofbCeuw1Cof8uRhGl48oa6j0sIy13gMbhuk/YpxgAMJWVCRo2CU7ef5TVAHjB1kVjbQBkS0U4uT+j3BeghTHgwbYqR8GXnML5eRhZrKVzdsYwVbhieNg/Qm89U7ZEUJsus0dpKKCPHHgfi8pib3FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779689629; c=relaxed/simple;
	bh=M89zjsTeOiMF6BXUeIkgCZIZoaMi1W1EqtXtZGBNRK8=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=V+im+yLURly5OdyvapPFS9G5h+CoBzwvyBwqh7NaqbT9m0fDOXtcOufy7x0YetGbZBiXFKW+D01wxxzi/Pb5gqeebJPq/azbZZJAmSeXbAh1RTcxcfVuUkV7akN3lKuVYFA4wdIUudPM2TKW/8ZO7XMcNddt0RN4mmbYivtpd9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=PhCn5xUs; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64P6DhAU2827420, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1779689623; bh=Z4lm6HQUExCthPDNhGO6/vrv1uciTZEX0nY1vTJr5Oc=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=PhCn5xUsZ+6jppCqGtGQDgZC3CDaJAj7hHjNpsmD56GYDivD0kX3rCKZF+C+KkfSz
	 5RoWI10a+F1el/5kdKkowUkfs5B8maJPokC+rWxGy5kPvnGYYLmfLYbsJ02fBY2gPk
	 pU+CJp6QpBgAkg+DSboE8iMj756M3Tlv1hbH4H8XKcG/SaHSFNHQJVlRBcepuLZCbl
	 62jedBJPl4yMSxTFxXX3p8UT6mAKEuoBZKFdJo3WSRkQbWWPWBzlFT8U70h9XcVwqv
	 RBo6eLjHQObOH72qef+5lflYm2g9Xa/PpaJSh68F/nCIUp8umG/LdWzys7ZInO3824
	 na/Ih/boZH+1w==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 64P6DhAU2827420
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 25 May 2026 14:13:43 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 25 May 2026 14:13:43 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Mon, 25 May 2026 14:13:43 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <dian_syuan0116@realtek.com>, <phhuang@realtek.com>,
	<kevin_yang@realtek.com>
Subject: Re: [PATCH rtw-next 01/13] wifi: rtw89: debug: Wi-Fi 7 show count of SER L0 simulation
In-Reply-To: <20260515014433.16168-2-pkshih@realtek.com>
References: <20260515014433.16168-1-pkshih@realtek.com> <20260515014433.16168-2-pkshih@realtek.com>
Message-ID: <ec80a7f5-81da-4d16-a8e6-c2dc60b97668@RTKEXHMBS03.realtek.com.tw>
Date: Mon, 25 May 2026 14:13:43 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36855-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,RTKEXHMBS03.realtek.com.tw:mid]
X-Rspamd-Queue-Id: 0D7965C63DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> Wi-Fi 7 has dedicated HW register to count SER L0 simulation, i.e.
> manually triggered by users. Show count of it in dbgfs ser_counters.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

13 patch(es) applied to rtw-next branch of rtw.git, thanks.

e384397796ea wifi: rtw89: debug: Wi-Fi 7 show count of SER L0 simulation
becd1c37efc3 wifi: rtw89: debug: Wi-Fi 7 update simulation of SER L0/L1 by halt H2C command
125fd4514fa8 wifi: rtw89: fw: dump status of H2C command and C2H event for SER
779bbe1902f2 wifi: rtw89: pci: enable LTR based on pcie control register
e0bb1246e307 wifi: rtw89: pci: not disable PCI completion timeout control for a variant of RTL8922DE
8ee752289e1f wifi: rtw89: pci: disable PCI PHY error flag 8
8c9e5fb13434 wifi: rtw89: clear auto K delay value before downloading firmware
dcf5c7262bff wifi: rtw89: wow: send ARP reply packets instead of Null packets to keep alive
63ccdfac8677 wifi: rtw89: correct drop logic for malformed AMPDU frames
f98b4684930f wifi: rtw89: 8922d: change naming number and update values for WDE/PLE quota
d270863883b9 wifi: rtw89: mac: add field of release report size to DLE quota
77be46f2819c wifi: rtw89: mac: consolidate quota into a struct for variant chips
9d69ffa4f8da wifi: rtw89: 8922d: add quota for RTL8922DE variant

---
https://github.com/pkshih/rtw.git


