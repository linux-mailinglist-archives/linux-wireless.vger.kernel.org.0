Return-Path: <linux-wireless+bounces-36356-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KC9tLEb3A2ppBQIAu9opvQ
	(envelope-from <linux-wireless+bounces-36356-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 06:00:06 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0400F52D145
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 06:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3ADA3300F119
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 04:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72433955CF;
	Wed, 13 May 2026 04:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="ZYveWh0z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F8B395240;
	Wed, 13 May 2026 04:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778644803; cv=none; b=ZfqBlhVPrSqMTFqZXw/Udmt5gqtpeBAuIGIi2vryJs7xT/Svru2doyrvF5/u95CvY/kfY7FUAadDtQjIq0omlexaNeUhQ5Sn7gofappsU6L7W34h4Qz3KlCdyb9zfVXMakCyKMBwIjtAmRFBW0Hw9W2IBsaO1udiKriSCnYiwO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778644803; c=relaxed/simple;
	bh=QtJjE+CbmiE+OpG576qgFslS6Ex7K3H3jgtnZrcS5fQ=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=QZTfv2KuJr7bblIcc+7GdzAptB2iCRUNr9wRTpR6HFMZaL9hCPqM2mVX1DyIAqd+rvYKyLW2TI0PvEvhilFMNbLECui1HqbGWqBSPxM3oQnDMVH9NPtWsqFMCiXX9qdQofiUibY0w7LRnNuIysPCGNcHFeTxJyZcdOUiPQIvQNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ZYveWh0z; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64D3xlnW7489190, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1778644787; bh=UVbJ9kUDDMSfMp4LwhYTXHQ4kK7xEPdFRSuI8X7367g=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=ZYveWh0z9NX13Me0kAdXSULCkhAwzXSYhc8hAFFSRljMx16vn+qMfTs1fL4jTmWks
	 DvkSyI4T1moKiaRaV6niML7Okzie+qMgaXSab/km/tdLDPx7jxmqCMWjrgejzp6JHI
	 8vRd113GXG3uiYVlOew7H3ZasxelkzKGcyQDCC5j8sg9WOnVOHEgnYqgG1Ux7Zq4nV
	 59NoHG3yPUJWyWv7Tf+Xaey7jNK9Voh/GQqOxuHWOIdrNpK9jHhsvSQLs8Z5Ld7sHk
	 fquGp4sz+U5CjXzqqgJG3sGWHjlEYOcpJ8Gda7W4lXBEy4Z3ovZXh8l/pXR3I77XZc
	 NtgFT5l007nNg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 64D3xlnW7489190
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 May 2026 11:59:47 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 13 May 2026 11:59:48 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 13 May 2026 11:59:42 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Martin Kaiser <martin@kaiser.cx>, Ping-Ke Shih <pkshih@realtek.com>
CC: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Martin
 Kaiser <martin@kaiser.cx>
Subject: Re: [PATCH v2] wifi: rtw88: remove rtw_txq_dequeue
In-Reply-To: <20260507082238.889656-1-martin@kaiser.cx>
References: <20260507082238.889656-1-martin@kaiser.cx>
Message-ID: <6a7f8077-3c62-4340-93a7-624aba24f355@RTKEXHMBS06.realtek.com.tw>
Date: Wed, 13 May 2026 11:59:42 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 0400F52D145
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kaiser.cx];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36356-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:email,realtek.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Martin Kaiser <martin@kaiser.cx> wrote:

> Remove the rtw_txq_dequeue helper. It's a wrapper around
> ieee80211_tx_dequeue with just one caller.
> 
> Call ieee80211_tx_dequeue directly in rtw_txq_push. There's no need to
> fetch txq for every frame, we can do this once outside of the rcu lock.
> 
> Make the loop variable i unsigned long, it should have the same type as
> frames.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

4c13e00cc679 wifi: rtw88: remove rtw_txq_dequeue

---
https://github.com/pkshih/rtw.git


