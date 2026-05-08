Return-Path: <linux-wireless+bounces-36100-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id vRP8M8M0/WlbYwAAu9opvQ
	(envelope-from <linux-wireless+bounces-36100-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 08 May 2026 02:56:35 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DD14F087B
	for <lists+linux-wireless@lfdr.de>; Fri, 08 May 2026 02:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B525E3008D56
	for <lists+linux-wireless@lfdr.de>; Fri,  8 May 2026 00:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E93417DFE7;
	Fri,  8 May 2026 00:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="r7mq3POy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7E72F8EA7;
	Fri,  8 May 2026 00:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778201792; cv=none; b=WUyAE63EWl5hM4NoULbwOrgD+yJnDIzxyZ9ZwWZQpTb8SPIy59FaXi3AIlR1m65oWmJzQjpgPgOqb93OqmjS1AdZ7rop8iv9aSn6xK+DpGC7cIR7Mw0rctQnZTGBB/a2PdhnQMUY7Kxa84agy8LmF3P2lLyVSovozK8WHXA4jL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778201792; c=relaxed/simple;
	bh=kfcddbiBHljFJGl81bsZVDeg17Fzxf5jdtq9eajJFt8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G0U2FI02Yw5HR91FHQzdkjJ23f/s+ZbKv9kq+3Db3PlqwW0dLSjewkul5vh6dK9IbhTNMxag6PrdXb+Px4PmmEOhbne94qizzko2k2/ywbGyVT58wctyO55c6p0hnKWx6Nr5XwR6vj8ZKGFV0GOS3Oe3/XewRcEcrWd5lsljmDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=r7mq3POy; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6480uHjvD3196775, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1778201777; bh=kfcddbiBHljFJGl81bsZVDeg17Fzxf5jdtq9eajJFt8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=r7mq3POykbShY7JQg3AW6G+Pn4CISNKsuX5nF+I8UP1vsbwiGc6CtbJE5EBQk4O3N
	 o+NzgMv8iVfkNX9D2TRkiTfh1WH1ZEGGzifJP8fzXkx/eX9izVVIuEUuBNF0JMjpWP
	 dmagqF6zyxeewF1Jbot01HMZhQGuU1ZAPjcEf4VR1/hp0wx7Bk0/ulRsbA1S2M7bjc
	 KWMG6jJd5ovyMicjW3yM6ulY1iuL4/bXLOuOHMRTrcNLKAb6wI7Ps+R8Cs3TArcfcG
	 RNA620syJLN9P5kQhQlCxM/ODZ98fFP9CSYMeLi9FHd7LUv9ilrAZPTXYYjTe0Fs+M
	 rSnFAx9tDomJQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 6480uHjvD3196775
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 May 2026 08:56:17 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 8 May 2026 08:56:17 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 8 May 2026 08:56:17 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Fri, 8 May 2026 08:56:17 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Martin Kaiser <martin@kaiser.cx>
CC: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] wifi: rtw88: remove rtw_txq_dequeue
Thread-Topic: [PATCH v2] wifi: rtw88: remove rtw_txq_dequeue
Thread-Index: AQHc3fqyI0h/C4w0tkGgSCHe/UMSx7YDTuRQ
Date: Fri, 8 May 2026 00:56:17 +0000
Message-ID: <307196cb41074e40a1201130dbfaf1b2@realtek.com>
References: <20260507082238.889656-1-martin@kaiser.cx>
In-Reply-To: <20260507082238.889656-1-martin@kaiser.cx>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 62DD14F087B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36100-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,realtek.com:email,realtek.com:mid,realtek.com:dkim,kaiser.cx:email];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[realtek.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Martin Kaiser <martin@kaiser.cx> wrote:
> Remove the rtw_txq_dequeue helper. It's a wrapper around
> ieee80211_tx_dequeue with just one caller.
>=20
> Call ieee80211_tx_dequeue directly in rtw_txq_push. There's no need to
> fetch txq for every frame, we can do this once outside of the rcu lock.
>=20
> Make the loop variable i unsigned long, it should have the same type as
> frames.
>=20
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>



