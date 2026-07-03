Return-Path: <linux-wireless+bounces-38546-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TIO3MwojR2qKTgAAu9opvQ
	(envelope-from <linux-wireless+bounces-38546-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 04:48:42 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 335D26FE00E
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 04:48:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b="GfIM4/M5";
	dmarc=pass (policy=none) header.from=realtek.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38546-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38546-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E8678301DEED
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2026 02:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08B8247291;
	Fri,  3 Jul 2026 02:48:29 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C52A3A1B5
	for <linux-wireless@vger.kernel.org>; Fri,  3 Jul 2026 02:48:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783046909; cv=none; b=biMz+VBCbX2HkHQlqFvuNLglHeIS6xgoGFLP6M2EFskxNja3tw5ikNBjvFvMDR+Ed5vxJpgxurYGG7clghxuL+GxM3hoJ5zHlpotQ3h9wHqNmmAJiEeWKwmMGbffoAlnSy8I0EjtwfZFUe4LrCSZ6eM832vVtPTgZN073vj/AkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783046909; c=relaxed/simple;
	bh=IP8kWRmsCE/zcsUbcwxfE1Mz+AnuzhPu1ErlL8NzCAI=;
	h=From:To:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=CoTobF66N0PoTkdzc1Lx8EKdMnVhYhTcPG8fYQopS79Dmr0oieLRIpXhd5WAQCs1Q4Z6hrKQT/6b+uP6rSCFVf817AqZDPAMb6UZGOYL3nJBv8oddn2uLGUWTI3Na5XrfBNjTgLLo839sT9+LDgDS4WU+IQZLUSLXaCl3gR7ols=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=GfIM4/M5; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6632mNZ212398933, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1783046904; bh=5bT5QwuL4NksKVVIDx4TMaiWuqyc+GrraxRsi/LY2D0=;
	h=From:To:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=GfIM4/M5VMR7AmHjBDU5smUHbasTPoMBUWhwhGnnQjSRsbIy6C+FkpQc8Sk29wc+f
	 x7qa6LZjraTIENFZ3Q7FN4Jct2CVeTSW3XYcBDGAWt/IFe7VAlaWb5U4BxEO2yklH4
	 2VZW1i9TbrnCSOzISGygCXsgM28hfi37Ef2eBQGYktmF73Q10WM0tImKDgibyJ9LCb
	 KSoBaOs8eZIP1xsA+Xp9PxrFMU9ask1Jt2OFRzD+1gY9ynQbRSYhEeh+oZiag7F7JY
	 FiNgPLFQfpXnktGVRe3ODIWP80mz2aO8YgwB/mwgsxMNzcZL12oXeOxcrvUWLHiICE
	 ylClBYnFbn37Q==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6632mNZ212398933
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 3 Jul 2026 10:48:24 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 3 Jul 2026 10:48:23 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Fri, 3 Jul 2026 10:48:22 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>,
	<Jes.Sorensen@gmail.com>
Subject: Re: [PATCH rtw-next] wifi: rtl8xxxu: 8723bu: remove reference of non-existing firmware rtl8723bu_bt.bin
In-Reply-To: <20260622015439.9621-1-pkshih@realtek.com>
References: <20260622015439.9621-1-pkshih@realtek.com>
Message-ID: <0be1cd4d-758d-4b5c-8e0e-268799538393@RTKEXHMBS03.realtek.com.tw>
Date: Fri, 3 Jul 2026 10:48:22 +0800
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38546-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pkshih@realtek.com,m:linux-wireless@vger.kernel.org,m:Jes.Sorensen@gmail.com,m:JesSorensen@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[realtek.com,vger.kernel.org,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[RTKEXHMBS03.realtek.com.tw:mid,realtek.com:from_mime,realtek.com:email,realtek.com:dkim,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 335D26FE00E

Ping-Ke Shih <pkshih@realtek.com> wrote:

> A report from [1] that firmware is missing in linux-firmware repository.
> However, there is no specific firmware for RTL8723BU for Bluetooth enabled.
> Remove the unnecessary reference of firmware file.
> 
> [1] https://github.com/rtlwifi-linux/rtlwifi-next/issues/20
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

1349ed8f104a wifi: rtl8xxxu: 8723bu: remove reference of non-existing firmware rtl8723bu_bt.bin

---
https://github.com/pkshih/rtw.git


