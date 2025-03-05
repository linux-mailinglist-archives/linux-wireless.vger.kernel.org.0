Return-Path: <linux-wireless+bounces-19799-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0DFA4FE0E
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Mar 2025 12:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E0ED7A610D
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Mar 2025 11:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7900205AD0;
	Wed,  5 Mar 2025 11:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="N2pu3ztf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D26F1F5413
	for <linux-wireless@vger.kernel.org>; Wed,  5 Mar 2025 11:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741175662; cv=none; b=Ex6pKfi2ZCtMKrYh8bLZIKlMsHE5EqZyDLM2hkEyZdtoU5Wzk+H+N+4v+DkRPLMImDzdxElGAyAdqN+OAFeCmekfEiuUyvFnTL4Oz04l5QP/wIl0jovDcMXkvsMSfEwKkNxGG4Ik3HlyJaihcw4njD92tyFTMvcaQaSXn/uTAa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741175662; c=relaxed/simple;
	bh=FGufKsyA5bWxqL2I4jxHCCOCJ2h4Gt6rxQ1farZSDFI=;
	h=From:To:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Message-ID:Date; b=LywejV/q0fw6bYZBCHrc3DEofluNyhRXcwqM+33mk5fNGLXES4r2vFbLgVzfEiDPNqPZ68kwDitzEtS864KxEA7L9TL8JVMsIzWi2ir2wIGO+2RnyXoYCrsyL+7RpUIicNnlnja3U/tMhhnjyeLcjWX917Oqvbb5Wr8oeDmgJzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=N2pu3ztf; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 525BsHqX51416583, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1741175657; bh=FGufKsyA5bWxqL2I4jxHCCOCJ2h4Gt6rxQ1farZSDFI=;
	h=From:To:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Message-ID:Date;
	b=N2pu3ztfdQGOf5eUFLzmsmiqR4NdTd17qsFjdArJpyluj4y5+BFKvCY9F9WOzZM3k
	 XNBvXAsJzzUC3WMJfihNae+sdjb1YX0g+jjpDQZ00t1zlxqOVBQCS7FuLfVAZJRXUL
	 PuP8tMuCh3Q/ZZ7DFlBhkCtng09DUMG1+OZXQjJSCYAH2tV0tCoulMUuJ7fliZPfS6
	 DMJ1C5SbkCe3bdm9fAEtGUzgIHOPZByLHF3KDgXiUNuj0Ebgjr5AmX41OXFHiilYpP
	 FDdElKBJYzaxmFcsD79OheuW2h83Pw49nBgD4z8wzzP9yVNYNl65/18hRpK6MDW4ZJ
	 V1wMpVLL+4TTQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 525BsHqX51416583
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 5 Mar 2025 19:54:17 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Mar 2025 19:54:17 +0800
Received: from [127.0.1.1] (172.16.23.73) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 5 Mar
 2025 19:54:17 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH rtw-next] wifi: rtw89: pci: correct ISR RDU bit for 8922AE
In-Reply-To: <20250227131907.9864-1-pkshih@realtek.com>
References: <20250227131907.9864-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <48938a2e-f9ad-48d4-b7d1-c7c6c5d0fa65@RTEXMBS04.realtek.com.tw>
Date: Wed, 5 Mar 2025 19:54:17 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> The interrupt status (ISR) bits of RX desc unavailable (RDU) for 8922AE
> are B_BE_RDU_CH1_INT_V1 and B_BE_RDU_CH0_INT_V1. With wrong bits, if it
> happens, driver can't recognize the situation and prompt a message.
> Fix the definition accordingly.
> 
> Fixes: aa70f76120ee ("wifi: rtw89: pci: generalize interrupt status bits of interrupt handlers")
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

3218f5bd8e2e wifi: rtw89: pci: correct ISR RDU bit for 8922AE

---
https://github.com/pkshih/rtw.git


