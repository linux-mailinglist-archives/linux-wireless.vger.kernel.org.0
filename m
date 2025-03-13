Return-Path: <linux-wireless+bounces-20287-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F09A5E96C
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 02:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C88771727BF
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 01:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78E722092;
	Thu, 13 Mar 2025 01:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="h3YwrrfD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FCB847C;
	Thu, 13 Mar 2025 01:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741829351; cv=none; b=J5D0rBrzmWESIyv7NTpffTSqsJXsEi5tlWx5uYnFaccLLmjNjeRPlwOFAGeksZSr3ulWClVpbbshuAPGPoiIwCzn8TIsopstWGvjzyholQnEhrQOIP2Swey0RoCogKY/6tiYvcsfiVc2zvMYLixMQgoQ+Xi8bpoDSkYnWkibKyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741829351; c=relaxed/simple;
	bh=DmFGl3cW63z36zoSLZ+e3qENuPfpCm1i9LEkpTNMFqY=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=plZnigwOr0FaO13h1JFIcP4d4nyttEx05Vj9E0ZA3GnRzDV7mqlvrl4othQkg2tgt+girALdxD+6tqjITMUWj1h6qxvi5lMvhzL2TEMJf3YBBUxjvslmXQhFrtlbc41CIgEI/sD0izxTdc4bcE/X9TXJKY66MtYIzVaR7n8Riy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=h3YwrrfD; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52D1SukkE268791, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1741829336; bh=DmFGl3cW63z36zoSLZ+e3qENuPfpCm1i9LEkpTNMFqY=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=h3YwrrfDRlsv0fz8lxhEuG+0TY6ZVa+BhvVwINftd9Z05D69wFcbOj/55Cgud7hqH
	 Ca9c6LX5jMQYIfkpubAo6qFLfZgyLx1b3hNcz4+8mx9GlEt69mICt3H8AWpxZ22wMc
	 Xy6LYNruBRNjOVBZrsjbJ8lt6M0oMA/ShaOy/i8gdUo2ONFFx4LOcbxZk9VL0pGbT2
	 vaSPcwi1j1/kFkSO/ycjl49FaD58HA2IFFY5RjxDDYl2kkyJwakH55CbcVcHoXO1tH
	 XO3ogRQjBghaiao8KotZdHNxGTcWOlptbi+IuyaBiIpjh175Ecf6dc0kkTW/MoTmWG
	 wGGsqQ/ulsRWQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52D1SukkE268791
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 09:28:56 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Mar 2025 09:28:55 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 13 Mar
 2025 09:28:54 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Kees Cook <kees@kernel.org>, Ping-Ke Shih <pkshih@realtek.com>
CC: Kees Cook <kees@kernel.org>, Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] wifi: rtw88: Add __nonstring annotations for unterminated strings
In-Reply-To: <20250310222257.work.866-kees@kernel.org>
References: <20250310222257.work.866-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <c5003d73-b135-4c3a-a4da-3d036ff3c2d2@RTEXMBS04.realtek.com.tw>
Date: Thu, 13 Mar 2025 09:28:54 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Kees Cook <kees@kernel.org> wrote:

> When a character array without a terminating NUL character has a static
> initializer, GCC 15's -Wunterminated-string-initialization will only
> warn if the array lacks the "nonstring" attribute[1]. Mark the arrays
> with __nonstring to and correctly identify the char array as "not a C
> string" and thereby eliminate the warning.
> 
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=117178 [1]
> Cc: Ping-Ke Shih <pkshih@realtek.com>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: linux-wireless@vger.kernel.org
> Signed-off-by: Kees Cook <kees@kernel.org>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

d58ad77d5cc2 wifi: rtw88: Add __nonstring annotations for unterminated strings

---
https://github.com/pkshih/rtw.git


