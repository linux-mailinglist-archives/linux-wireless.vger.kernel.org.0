Return-Path: <linux-wireless+bounces-38552-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1hSOIm8zR2rGUAAAu9opvQ
	(envelope-from <linux-wireless+bounces-38552-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 05:58:39 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E87776FE471
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 05:58:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=oRfOIBkY;
	dmarc=pass (policy=none) header.from=realtek.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38552-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38552-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3915C30409D6
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2026 03:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D610030DEA6;
	Fri,  3 Jul 2026 03:58:33 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7A631A556;
	Fri,  3 Jul 2026 03:58:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783051113; cv=none; b=jRZPWcStrBlkp+0HeF4DtLeXdbtHbXBjARnta6vkkPV1uOn29np0a4EhzUaFgihHBWsS263wMNDJJWfFBVuqPzJbjf9Fh9g6S4C85dv35VvPVzY/URrjQ9ns519SHsL5Nfd2BlC0aiSllhbjC4QQwkz36AtzVdRuC277Gkr9tKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783051113; c=relaxed/simple;
	bh=ASKA3tWVNh2jnOV0bO91afzO5D8p43/MYns+/PhC7Wg=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=o/vrR14Dx4467Pg8+AJJZN+9oaGAHIb90AAa8ZWI7kCXCUyPFQI2gCCKnGZUie6XtskaQYgH5Dw0GMp+eMiAyP5r86BSHBm3bdxayVHK3aI5tW8uQ4zK32SQPXc3kAGM9JJc++5ohai9ZGE2RiznWL9sf82vL/f6r8sYDdh9+Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=oRfOIBkY; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6633wKGM12428659, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1783051100; bh=Y3mHjlYEsmOHjpXoqTmjgxtBShvQT/atYMp4RaG1ULg=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=oRfOIBkY9N2UuzRVA3zO44gqqlGbZVkFRQRn3EzphQ0FxgGJ1W2tHDbrKQTftf7mk
	 rtiiQFfgGh/QUJnvHxtCJVmuDvmTE8OKNKwIQiD0xOY/KG1yh3aIUW/F18bvLh5a4B
	 GptpeADGs4C3fpGsa4VOU9VngeprMGx1yOZtq8cuC6b9D6iaUauKE2PTScEuiVHsAM
	 wltKYLvrkfjk8gKVoEVByAWw5NyY42974J1GGIAKbislFWygY4pgF/Z5SWPpWitg/P
	 UPbegU3adlaVLzNKEaNxcgfxvk3r1lh7ubGCdrO5RednbUNz/EPZ1/7j3rGs2fmb/g
	 qyed9uC1rbdiw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6633wKGM12428659
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 3 Jul 2026 11:58:20 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 3 Jul 2026 11:58:20 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Fri, 3 Jul 2026 11:58:15 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>, Ping-Ke Shih <pkshih@realtek.com>
CC: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Pengpeng
 Hou <pengpeng@iscas.ac.cn>
Subject: Re: [PATCH] wifi: rtw89: fix HE extended capability length check
In-Reply-To: <2026063009025530.2-ccfa108-0024-wifi-rtw89-fix-HE-extended--pengpeng@iscas.ac.cn>
References: <2026063009025530.2-ccfa108-0024-wifi-rtw89-fix-HE-extended--pengpeng@iscas.ac.cn>
Message-ID: <fd1b78b9-93cb-48ea-84c7-03c7e59f605b@RTKEXHMBS03.realtek.com.tw>
Date: Fri, 3 Jul 2026 11:58:15 +0800
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-38552-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:pengpeng@iscas.ac.cn,m:pkshih@realtek.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E87776FE471

Pengpeng Hou <pengpeng@iscas.ac.cn> wrote:

> rtw89_mac_check_he_obss_narrow_bw_ru_iter() reads extended capability
> byte 10, but rejects only datalen values below 10.  Byte 10 requires at
> least 11 bytes.
> 
> Require datalen >= 11 before reading data[10].
> 
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

2aba608a86e9 wifi: rtw89: fix HE extended capability length check

---
https://github.com/pkshih/rtw.git


