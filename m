Return-Path: <linux-wireless+bounces-25425-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C51B04DB0
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 04:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 407A817DC1C
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 02:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5C3288C34;
	Tue, 15 Jul 2025 02:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="O++dux8B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CEF19F135;
	Tue, 15 Jul 2025 02:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752545352; cv=none; b=QhTLDy8LbaQkK/LgLGePoFhdaNDt/JyYLbFBr5C0j+cfSm2qT0SNwlR2vfuvN0Ee/vvRZElq5D+MpM5BhCGAx+CZyt1sjvfB9akIzBn8ALwKoThunihsZaR9KpkuXHIG1CdrqzQyQxrkexBpcTt8nZ7KI2Ep846OXp2j30hUShA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752545352; c=relaxed/simple;
	bh=7GlqZgziuSXK98XHaiAKVh6Kv+HdLyQxM9yppUfInOo=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=FQNOuQMzifTSV9I80JRAhtefxZo0G2bFBy7iSqUwY52ExEFgi5CMrG7xMxfzX7+RFLV2fXh3aEfNcziroyC01rzvMCz5wMT64ijNsa5a4glZYlESXKhNk+MGiQUqSRv+dFH63X4u9k0gZEl9+GnYlwXFRrtw9giR/QAD/gk5IDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=O++dux8B; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56F28qqzE3815638, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1752545333; bh=rwtn8MufQ9lOW6HN+HqaO7NjfFovu6M/R07XpgJwh3Y=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=O++dux8BHcm4Twluq9yjMu8XtOIUvYP56pJS3ZOLDLsNz3LpBuJYf8E/xNtzkwq9v
	 27SumocxsVW3HsjluP2BfRJjHbZ2eijiR/Wn+EtfeyU2tHR1s/SM1+gFXrWtT9aNS2
	 kCURn+xb0nr6l9yViQeMtVlG66CW2jfXowM81nG9GzZbpL/6FG50yFSZUx9AR8neyv
	 7MkiCqm7RlizXjh1AXERvLdq0alrrHwjLnANqecO23ps92psG2RJzeLivJNsuUVlVp
	 LZNEBqMjX64IdHIKwc1RiQyr1ezg88gkczOsiRcsEebldFnpp0rZayIUcAQmpRuyUY
	 yzy+/W+25yjrQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56F28qqzE3815638
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 10:08:53 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 15 Jul 2025 10:08:52 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 15 Jul
 2025 10:08:52 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
        Ping-Ke Shih
	<pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Bitterblue
 Smith" <rtl8821cerfe2@gmail.com>,
        Fiona Klute <fiona.klute@gmx.de>
CC: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Subject: Re: [PATCH v4] wifi: rtw88: enable TX reports for the management queue
In-Reply-To: <20250711084740.3396766-1-andrej.skvortzov@gmail.com>
References: <20250711084740.3396766-1-andrej.skvortzov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <ce9a51d6-aa5c-4fef-9d8b-2d917ab1f4de@RTEXMBS04.realtek.com.tw>
Date: Tue, 15 Jul 2025 10:08:52 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Andrey Skvortsov <andrej.skvortzov@gmail.com> wrote:

> This is needed for AP mode. Otherwise client sees the network, but
> can't connect to it.
> 
> REG_FWHW_TXQ_CTRL+1 is set to WLAN_TXQ_RPT_EN (0x1F) in common mac
> init function (__rtw8723x_mac_init), but the value was overwritten
> from mac table later.
> 
> Tables with register values for phy parameters initialization are
> copied from vendor driver usually. When table will be regenerated,
> manual modifications to it may be lost. To avoid regressions in this
> case new callback mac_postinit is introduced, that is called after
> parameters from table are set.
> 
> Tested on rtl8723cs, that reuses rtw8703b driver.
> 
> Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

5f936768300f wifi: rtw88: enable TX reports for the management queue

---
https://github.com/pkshih/rtw.git


