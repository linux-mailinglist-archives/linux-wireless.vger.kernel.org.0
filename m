Return-Path: <linux-wireless+bounces-34136-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IUEI0bXyWnX2wUAu9opvQ
	(envelope-from <linux-wireless+bounces-34136-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 03:52:06 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C13354A9D
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 03:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4A14B300232A
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 01:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3817A229B38;
	Mon, 30 Mar 2026 01:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="VjhXiwHM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29012DF68
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 01:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774835524; cv=none; b=VN4Lf4B/KoN4bsVJW8aW3b3ivfN14K7sZcOOyAt2kbA3ZTl27H77O7dtNufSnMRiE75BUd46JYGMMg7fbg2c1biXss/Yvpmz5a7aR2mLZyHbTIcldv589kEeqDETWIQZoRkOH5h/HFAx6iHEDwwGslJxlYqZo2JXpZFR1C/ex+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774835524; c=relaxed/simple;
	bh=Sg1q9uyyaT5XaItYSmf+/DMKIM1QnI3CiLnTXdvRQ04=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=lHKOv3a2LCejxfA0dxHv3cpFng1IeX4cyCitCs4ZmPPYq67o52UbRBtq6TGTM4NuvqgV7LLqh76jva5dR1ugLeCRNEu9fzn8PPV+em8sHD7Hhq6d2pNphyLMDc/7wdry6sEfJBeB9av7di+mBKoLkjFoCjtdJqJXHyQ1B+2fiek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=VjhXiwHM; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62U1pxegF075664, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774835519; bh=u0aDtHXJHSEp1adW0BOm29Q9hgcRmKcwJmiCrrHTnB8=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=VjhXiwHM0vBZPhzrSzPQicqrO92Fa+QDFRYAXCpJYWwpqlOuNaE58+JWuxNyopXlR
	 A8zr0IOaBbLEzsI2aICBCzdpAIX7B+Htsk2ffrtt+RKaXaJziwkNHfUFrIo1rkWEtF
	 3h8x0oqzbScnZ/O7yJO2mNUlD4GRaK02jffS10rcRpZdE/bYYNSjOudGkBbtc2ZdQo
	 q9dh9KQ5UPEPcAWZU3b0WH7jBGwuCBuieNxmsu9KPFWwHoqSYyVYmfIGHiWcyDhXZD
	 H3KWOVwWGG/521CHKSFpUe4LuPeGu0/iKp/3g5FLHqAWuIPF/qTZvNGnm9ZtHqfc6z
	 Fcno4G1kbPysg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 62U1pxegF075664
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Mar 2026 09:51:59 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 30 Mar 2026 09:51:52 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 30 Mar 2026 09:51:51 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Mon, 30 Mar 2026 09:51:51 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <goainwo@gmail.com>
Subject: Re: [PATCH v2 rtw-next] wifi: rtw88: validate RX rate to prevent out-of-bound
In-Reply-To: <20260324011001.5742-1-pkshih@realtek.com>
References: <20260324011001.5742-1-pkshih@realtek.com>
Message-ID: <0db3c3ed-10d2-49df-a3f3-676eb04b23e4@RTKEXHMBS04.realtek.com.tw>
Date: Mon, 30 Mar 2026 09:51:51 +0800
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
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34136-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:dkim,realtek.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,RTKEXHMBS04.realtek.com.tw:mid];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 31C13354A9D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Ping-Ke Shih <pkshih@realtek.com> wrote:

> The reported RX rate might be unexpected, causing kernel warns:
> 
>   Rate marked as a VHT rate but data is invalid: MCS: 0, NSS: 0
>   WARNING: net/mac80211/rx.c:5491 at ieee80211_rx_list+0x183/0x1020 [mac80211]
> 
> As the RX rate can be index of an array under certain conditions, validate
> it to prevent accessing array out-of-bound potentially.
> 
> Tested on HP Notebook P3S95EA#ACB (kernel 6.19.9-1-cachyos):
> 
>   - No WARNING: net/mac80211/rx.c:5491 observed after patch.
>   - System remains fully stable through idle, load, Bluetooth A2DP
>     usage, and multiple suspend/resume cycles.
>   - Zero H2C or LPS errors in dmesg.
> 
> Reported-by: Oleksandr Havrylov <goainwo@gmail.com>
> Closes: https://lore.kernel.org/linux-wireless/CALdGYqSMUPnPfW-_q1RgYr0_SjoXUejAaJJr-o+jpwCk1S7ndQ@mail.gmail.com/
> Tested-by: Oleksandr Havrylov <goainwo@gmail.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> Tested-by: Oleksandr Havrylov <goainwo@gmail.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

bf14367719fa wifi: rtw88: validate RX rate to prevent out-of-bound

---
https://github.com/pkshih/rtw.git


