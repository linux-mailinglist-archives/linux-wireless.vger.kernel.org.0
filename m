Return-Path: <linux-wireless+bounces-30070-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAFFCD7F98
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Dec 2025 04:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB7BB3007689
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Dec 2025 03:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F0533E7;
	Tue, 23 Dec 2025 03:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="E9YUogzN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522A420FAB2
	for <linux-wireless@vger.kernel.org>; Tue, 23 Dec 2025 03:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766460702; cv=none; b=j5DxG4RlVbilLzCNCR0RD0Ef+hgZYSkttxm1ALApA7xY5kWmjx9YUAV9cn584ySNa1jNtXDtq1gt4BWqQ04Z0CdoduzstBOAGi0WkBHDd6UXw0ocXnS3+bsmEo5bYo3iMl1vdQZ/zYALLY+d+PugqKo9ItV7cxg5DDJfUzptS60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766460702; c=relaxed/simple;
	bh=/8P7Te0BvBAlMHCpwn2L9zJZ2pOrs5y5OU+V2YYqly4=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=u3aLT6praBhFd9uZEcUcYMXyb+N7w3fE3ZM4Rw2W3IoBdYNRJDIEEnv7FU7qQRP57gLMk2RHL9IRqNXTklGVU/vLoPM4UmGlFJBmC1hg3cHEmP4Imzi5sHZAjuy+jfrVdduT/UqnooskvVyhzaH5oIzABchy2EaSb0D619UsVnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=E9YUogzN; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BN3VbMC2598410, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1766460697; bh=6zOBsDiTzemBmC+ET+qEo5i9uk6RRfXGyFO92Y7EpXU=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=E9YUogzNqW33X2SuxUknxUmqUq+RHZePEbp0hdA1r14gtAZqmaUs4UD/Eun4khq7c
	 7pGfDL1bP0hdPF2uui8gpeajzWRF6d0GLvNC4fpdmCEWShAdWccXpfQdHvi8qUSg4S
	 jvoOCaDwgc9jU61PNy89t9hsY5TQrr03PcerLngthCBneGO9TWLoWUiPGaIZ1s6rSY
	 X0peYY7uZtilNcVdjSykP241DOsYqBhjMNnDqAk9ux3rqeuaO9BuJmoj0ZNE44DhE9
	 tQAf8UG0Rqd4x/masJ7mQCyZcvb4QM7rKaas7G9aPbpJQ3LYWjByqcuyNl14OGApUq
	 wwkwqvP0fgwkA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BN3VbMC2598410
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Dec 2025 11:31:37 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 23 Dec 2025 11:31:36 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Tue, 23 Dec 2025 11:31:36 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Roman Peshkichev <roman.peshkichev@gmail.com>,
        <linux-wireless@vger.kernel.org>
CC: <pkshih@realtek.com>
Subject: Re: [PATCH] wifi: rtw88: fix DTIM period handling when conf->dtim_period is zero
In-Reply-To: <20251125180937.22977-1-roman.peshkichev@gmail.com>
References: <20251125180937.22977-1-roman.peshkichev@gmail.com>
Message-ID: <d64ca035-b458-41ef-9908-d19a22674ef6@RTKEXHMBS03.realtek.com.tw>
Date: Tue, 23 Dec 2025 11:31:36 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Roman Peshkichev <roman.peshkichev@gmail.com> wrote:

> The function rtw_set_dtim_period() accepted an 'int' dtim_period parameter,
> while mac80211 provides dtim_period as 'u8' in struct ieee80211_bss_conf.
> In IBSS (ad-hoc) mode mac80211 may set dtim_period to 0.
> 
> The driver unconditionally wrote (dtim_period - 1) to REG_DTIM_COUNTER_ROOT,
> which resulted in 0xFF when dtim_period was 0. This caused delays in
> broadcast/multicast traffic processing and issues with ad-hoc operation.
> 
> Convert the function parameter to u8 to match ieee80211_bss_conf and avoid
> the underflow by writing 0 when dtim_period is 0.
> 
> Link: https://github.com/lwfinger/rtw88/issues/406
> Signed-off-by: Roman Peshkichev <roman.peshkichev@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

9f68fdcdc9db wifi: rtw88: fix DTIM period handling when conf->dtim_period is zero

---
https://github.com/pkshih/rtw.git


