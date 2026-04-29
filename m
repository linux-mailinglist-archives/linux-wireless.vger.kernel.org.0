Return-Path: <linux-wireless+bounces-35556-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABf+F3+a8WkliwEAu9opvQ
	(envelope-from <linux-wireless+bounces-35556-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 07:43:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B67B348F742
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 07:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1020301D33B
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 05:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAB933B97A;
	Wed, 29 Apr 2026 05:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="C28nTMfw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB418154425
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 05:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777441404; cv=none; b=lgFS6vlj4AC/fbxH99JaYVS46cju2aCYrQydIHcB6hK0/Wo3ohtfZf2UWUIgrDEYu2JurN6IXy93CT88T/GA53EiJ/mnJISxjHtEHVd8Qub6xETXPl8JVJXCKdaA8+k1LU8Mkd4eoskyOsOG9bIGzrqQehWM6VvnBcrs/RYUxw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777441404; c=relaxed/simple;
	bh=X2m8AtVHw+6LwIZXeXliVetGhTXsdgrE8KolQq6e2E4=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=F6U/XNLJnS63jeW1uRU9qBHDnbQNu8X5W1hQyKe0LHGYF262VBFesXMAc+rgPVJUdT9s2I98b+ZA/b13EJt3Bqwz1F3Nv7oSNA2JWtg255K7MnPKRKC+Z/YtqO4JM4KwB6bEXFRpMsJkSy0nHFzWj7WEZeXu5Dm6KHpThgDJ/JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=C28nTMfw; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63T5h2mN51018709, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1777441382; bh=QbSIAmLZ1TGbIJc/MrOG7ALlnpR8yPv2nEFlj/k4V5E=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=C28nTMfwbSXMedZLZUVQ1cyeuMkDjkc04pJzl6YPlK+4vNk2VC7b4GrHFbzXA/Fl7
	 R4Mpys41ptw/sBPWOUCGXMcQMxFPYCSGJAtYC8X0PAm8P9hQGJ78f9U+TxxtNOArcP
	 GPgD6MSUBQAsHgB0JW+LrcNL8lx9f9ef+jL8AM0aKEg92YYsg8jmW31PAhbQfmYvaj
	 UWQ0N1chTBGj5DlQ1At83Nlhrc3m3K9ewYDv6sA+81WU3btYSdpqz+eyJamCeBBEtv
	 Omf7ZMAy9RYK9+pt/8hVfdJhvvK9d7x29aabWz/jdEt0MUyqjHCqjjYRQXz0Wz7Io6
	 FiscygRuqqZ5Q==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 63T5h2mN51018709
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Apr 2026 13:43:02 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 29 Apr 2026 13:43:03 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Wed, 29 Apr 2026 13:43:03 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Tristan Madani <tristmd@gmail.com>, Ping-Ke Shih <pkshih@realtek.com>
CC: Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>,
        Tristan Madani
	<tristan@talencesecurity.com>
Subject: Re: [PATCH v3] wifi: rtw89: add bounds check on firmware mac_id in link lookup
In-Reply-To: <20260421111442.3395411-1-tristmd@gmail.com>
References: <20260421111442.3395411-1-tristmd@gmail.com>
Message-ID: <d2637877-5967-49ca-a945-4738c2a75516@RTKEXHMBS03.realtek.com.tw>
Date: Wed, 29 Apr 2026 13:43:03 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: B67B348F742
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-35556-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com];
	DKIM_TRACE(0.00)[realtek.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realtek.com:dkim,RTKEXHMBS03.realtek.com.tw:mid,talencesecurity.com:email]

Tristan Madani <tristmd@gmail.com> wrote:

> From: Tristan Madani <tristan@talencesecurity.com>
> 
> The mac_id field in RX descriptors is 8 bits wide (0-255), but
> assoc_link_on_macid[] has only RTW89_MAX_MAC_ID_NUM (128) entries.
> While the driver currently assigns mac_id values below 128, the
> descriptor value comes from firmware and is not validated before use
> as an array index. Add a defensive bounds check in
> rtw89_assoc_link_rcu_dereference() to guard against out-of-range
> firmware values.
> 
> Fixes: 144c6cd24b35 ("wifi: rtw89: 8922a: configure AP_LINK_PS if FW supports")
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

6d88244bb129 wifi: rtw89: add bounds check on firmware mac_id in link lookup

---
https://github.com/pkshih/rtw.git


