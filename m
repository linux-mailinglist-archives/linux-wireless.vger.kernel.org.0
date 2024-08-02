Return-Path: <linux-wireless+bounces-10844-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8DA945600
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Aug 2024 03:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7C341F23404
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Aug 2024 01:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E750E23BE;
	Fri,  2 Aug 2024 01:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="DsqRo0iz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255D24C9D
	for <linux-wireless@vger.kernel.org>; Fri,  2 Aug 2024 01:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722562339; cv=none; b=QfMgmIww5Zfjg1XzSubtO5iOU9Nsqdraz45HKcnFsDCZjkJ5tcaqg9e4emY8oYAvKgU0q49kHC9HK5zaW0LHjVgsawDqemHSiEhqWbmP8/h2IRtFh3MgjEwixdQnks97b4ntksI4YOm6bJOcgVdzxKl8wSYIIMNS5qrKqULzKsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722562339; c=relaxed/simple;
	bh=RRjjcBhV05C3UWqAc5DJzWrHZv4iOvypy2RvRUWCrUk=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=fxtbfLVgHZWkd90mUcaQTQ6JU6G4Kg48eqMHXscN2t6H/DZKxMx96DPhx6NI/cVA+/bVw1mydge2HsqYjN26tmQa56J/FsklyBuI7Q1j98QteXRultXnFtvWW6VAboDyv0RPqyTrL+haKOq8+J3Jh1NVo3TtkSb+iVg2uNGbpxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=DsqRo0iz; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4721Vt2O2074662, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1722562315; bh=RRjjcBhV05C3UWqAc5DJzWrHZv4iOvypy2RvRUWCrUk=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=DsqRo0izIy9h89kO3OTZFXWZ8e7i0WSQMOrs4zgTEgsM7fY9wbTZ6X+PPjBusMs2R
	 nX9oaKb8TeOdmrnN8uNtJg+jC1QDeqT0VZVMRh2eGZlyynsKtmJpNRszL57DKbkWPE
	 NbLPPsqG6zWK/bNsoIOo/Od412FmxupbQtCAV0rZU03pPZcUiB3Na+HpKPSS16J+4d
	 eYcAzSiOS+szWi3ENp77YyF2edBrx3ou11YB/dMhyG4yTp53kbXCqpMyTYxJ0iTGgX
	 RKgzH5g9LczBITIT0kdFg1/bJCVP7kSVxTOIlZgi7Vp+4jU2nvpWG4LTTwTte2YB1X
	 kO4ROKa2O8o7Q==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 4721Vt2O2074662
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Aug 2024 09:31:55 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 2 Aug 2024 09:31:56 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 2 Aug
 2024 09:31:55 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Dmitry Antipov <dmantipov@yandex.ru>, Ping-Ke Shih <pkshih@realtek.com>
CC: Chin-Yen Lee <timlee@realtek.com>, <linux-wireless@vger.kernel.org>,
        <lvc-project@linuxtesting.org>, Dmitry Antipov <dmantipov@yandex.ru>,
        <syzbot+6c6c08700f9480c41fe3@syzkaller.appspotmail.com>
Subject: Re: [PATCH] wifi: rtw88: always wait for both firmware loading attempts
In-Reply-To: <20240726114657.25396-1-dmantipov@yandex.ru>
References: <20240726114657.25396-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <94df0f20-5249-49cb-aeeb-557fbaa27dc8@RTEXMBS04.realtek.com.tw>
Date: Fri, 2 Aug 2024 09:31:55 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Dmitry Antipov <dmantipov@yandex.ru> wrote:

> In 'rtw_wait_firmware_completion()', always wait for both (regular and
> wowlan) firmware loading attempts. Otherwise if 'rtw_usb_intf_init()'
> has failed in 'rtw_usb_probe()', 'rtw_usb_disconnect()' may issue
> 'ieee80211_free_hw()' when one of 'rtw_load_firmware_cb()' (usually
> the wowlan one) is still in progress, causing UAF detected by KASAN.
> 
> Fixes: c8e5695eae99 ("rtw88: load wowlan firmware if wowlan is supported")
> Reported-by: syzbot+6c6c08700f9480c41fe3@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=6c6c08700f9480c41fe3
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

0e735a4c6137 wifi: rtw88: always wait for both firmware loading attempts

---
https://github.com/pkshih/rtw.git


