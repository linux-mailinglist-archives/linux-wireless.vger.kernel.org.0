Return-Path: <linux-wireless+bounces-35559-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0N7kFmSd8WlfiwEAu9opvQ
	(envelope-from <linux-wireless+bounces-35559-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 07:55:48 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDF648F958
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 07:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 193853007E23
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 05:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8A3330D22;
	Wed, 29 Apr 2026 05:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="uR3UGpKx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401A333A6E2
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 05:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777442129; cv=none; b=cVwrpbqgcIlLQtBBekKMq7p59MGxa7qFB910CllqSqE7rXwJaMln7FfnRIeh4MLGCLrJBLWFXgDXU3/Pw2Nyj5XLllfs4qhNGDmd5z+TTHR+KmYx+l716pdj21YKqIL2WLToLlaLPh0J1sw9Doeo6QDMqzJzaPd4egSV9vvIqhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777442129; c=relaxed/simple;
	bh=7GzMOgtKi4y4yGS7e0yLWg62shq2Tt0tnGgLi4r/1ZQ=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=DHJjOK6FTSkSnIb/5gQTpFH8MpnhXdDzv+9qoiCo3wOy8iwAbsg5PL9JR/rBGHLj8iomgHAzP7fqYaKCiV/+5/JrVnbprfkdMJCtbxAe0q1Xeie3vRCsJ94SesT3UpPn/3zFlE+L9AuR6D4IaRN4Y1y76RppVAkly5uiP53aAaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=uR3UGpKx; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63T5tOZ111041625, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1777442124; bh=vfGoMDPChMJhuSebavHAyg///0AJlZotCAMbIUDaFYw=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=uR3UGpKxVz6UCatvGhRCAQaqB9UkoSyMSJ9vTrxPV/4mu7mTrx8NozJZJaHZ5ZznZ
	 sAvNv6fntDdPdFOQk1hSQXU4UNuePqtG8lGifr9SCccIMoQYiy7h/QHvZmRVUUMtSV
	 7y0cGdsf7VIYCwLcxfBwnyh4M6S9W/OebnJBE0+U7ejg+zrs4n0162PCxWEPVtc8Kd
	 F3ilNXiduGwpM+VhKmICW5t8IaIU0y2BFunGqGFLwfQ9/lbu3b0MH4U/OxlL8GqQJ7
	 /HzpXul4q9cB/X2Kd97PiSGj0Bnu9tUPFAYMY4bQqV3cql0SKqCmPUM1r7wB2oryJE
	 bpiIAItRij4Dg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 63T5tOZ111041625
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Apr 2026 13:55:24 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 29 Apr 2026 13:55:24 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Wed, 29 Apr 2026 13:55:24 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH rtw-next] wifi: rtlwifi: rtl8821ae: Fix C2H bit location in RX descriptor
In-Reply-To: <04da7398-cedb-425a-a810-5772ab10139d@gmail.com>
References: <04da7398-cedb-425a-a810-5772ab10139d@gmail.com>
Message-ID: <9fbc522a-c2b8-41e5-a4d3-4bffde0049a3@RTKEXHMBS03.realtek.com.tw>
Date: Wed, 29 Apr 2026 13:55:24 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: AFDF648F958
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
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35559-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[realtek.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,RTKEXHMBS03.realtek.com.tw:mid,realtek.com:dkim,realtek.com:email]

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> Bit 28 of double word 2 in the RX descriptor indicates if the packet is
> a normal 802.11 frame, or a message from the wifi firmware to the
> driver (Card 2 Host).
> 
> Commit f5678bfe1cdc ("rtlwifi: rtl8821ae: Replace local bit manipulation
> macros") mistakenly made the driver look for this bit in double word 1,
> causing packet loss and Bluetooth coexistence problems.
> 
> Fixes: f5678bfe1cdc ("rtlwifi: rtl8821ae: Replace local bit manipulation macros")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

83d38df69291 wifi: rtlwifi: rtl8821ae: Fix C2H bit location in RX descriptor

---
https://github.com/pkshih/rtw.git


