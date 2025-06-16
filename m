Return-Path: <linux-wireless+bounces-24120-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC53AADA6F7
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 05:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 836273A7B8E
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 03:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F348C19D071;
	Mon, 16 Jun 2025 03:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="YxyBd+Mm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFC072607;
	Mon, 16 Jun 2025 03:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750045883; cv=none; b=AB0Oy3QsXN7Sc1A9a/CMWhYWRFzc9kKb3crHDaY6sXdp2vq21rfTw6UFksm+0IgyAOR+q0fuKtUwD5/cGr3VKj0IZVrrJU+ck9HQhqUpz/FZZ5/vsG11C3Pqf4NdbNsNVnH2cp12pz770zZZKM8apoXXI3/Tuu6PvRgSBGhBsU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750045883; c=relaxed/simple;
	bh=hOxU99TpSpKXGu48+grXG6EUZeXaVP3xOwmaLj163g8=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=ahLWGwNZJMGZt7h2i2nhdCBsXZtNOvn1Vt08hnVcI7REx04YsbLYFWd5UMSa6bzeqPdzCxD/gZa8bq+uEdOjDfUmte+mlAaUJgLFjqFO//KBufm7kMXfhHazwcOvLljMfS6i9HiXFch15YX3Fh6UX4fT4taSGxjDH+bh22hDI5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=YxyBd+Mm; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55G3ofHsB4014230, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1750045841; bh=Xx6iKyuFlURJA1nKkrAmHDoDTEntui4zYETf3CUpBbo=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=YxyBd+Mm6TcO/CcwXpo01gfKUnHg66SAv5tpGKpRrCFyg7fTBP4PHfrK9MzIxUJCP
	 G9D9JzDLvoI6AXrVnKei9jq9UBNgYEPcTjbnKREx9X1Bsv5w69igriS2XEqsREV9Yh
	 Wi0RebTJjt4C8cTw0zEsxtDTE4pLVets1dJQhJs3eFTK6m7Ul1L5epRNUwwiwbFq/H
	 HOuJelgfuMN3E4rA61Tx2JnKKxGS6RNV8AqUCZo576vsgnBtd4oOQfBSM3jWLDfXVA
	 cLN8/wZuNztJT/ogA/GUCo6xFdeyIqiyE4EA178lnl9fHat08PYwotC9VsJ2Pr2BeE
	 SuKVtZytS4QxA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55G3ofHsB4014230
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 11:50:41 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Jun 2025 11:50:23 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 16 Jun
 2025 11:50:20 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Arnd Bergmann <arnd@kernel.org>, Ping-Ke Shih <pkshih@realtek.com>,
        "Nathan Chancellor" <nathan@kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers
	<nick.desaulniers+lkml@gmail.com>,
        Bill Wendling <morbo@google.com>,
        "Justin
 Stitt" <justinstitt@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ingo
 Molnar" <mingo@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <llvm@lists.linux.dev>
Subject: Re: [PATCH] wifi: rtlwifi: avoid stack size warning for _read_eeprom_info
In-Reply-To: <20250610092240.2639751-1-arnd@kernel.org>
References: <20250610092240.2639751-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <61e3292b-c98d-4ac9-9ddc-165835b4583d@RTEXMBS04.realtek.com.tw>
Date: Mon, 16 Jun 2025 11:50:20 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> txpower_info_{2g,5g} are too big to fit on the stack, but in most of the
> rtlwifi variants this stays below the warning limit for stack frames.
> In rtl8192ee and a few others, I see a case where clang decides to fully
> inline this into rtl92ee_read_eeprom_info, triggering this warning:
> 
> drivers/net/wireless/realtek/rtlwifi/rtl8192ee/hw.c:2178:6: error: stack frame size (1312) exceeds limit (1280) in 'rtl92ee_read_eeprom_info' [-Werror,-Wframe-larger-than]
> 
> Mark _rtl92ee_read_txpower_info_from_hwpg() as noinline_for_stack to
> and mark _rtl92ee_get_chnl_group() as __always_inline to make clang
> behave the same way as gcc. Inlining _rtl92ee_get_chnl_group helps
> let the compiler see that the index is always in range. The same
> change appears to be necessary in all rtlwifi variants.
> 
> A more thorough approach would be to avoid the use of the two structures
> on the stack entirely and combine them with the struct rtl_efuse
> data that is dynamically allocated and holds the same information.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

2baacfe83346 wifi: rtlwifi: avoid stack size warning for _read_eeprom_info

---
https://github.com/pkshih/rtw.git


