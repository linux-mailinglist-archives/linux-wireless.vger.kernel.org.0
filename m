Return-Path: <linux-wireless+bounces-18704-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3205FA2ECEF
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 13:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDD9D3A7614
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 12:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D09222577;
	Mon, 10 Feb 2025 12:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="ItRTgfZ8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2ED223309
	for <linux-wireless@vger.kernel.org>; Mon, 10 Feb 2025 12:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739191993; cv=none; b=gvuiUcOtzdaLpxXZT00ZN3vS5LzSeG636crMwxGCkjW/PjzX4zhP28jfy1bnO0nYhDDCC8JzpiLX5TWSDLdU43lq/WQf2mu2qK0M93bwm6vzhOlESBwr5N/UGJoG8jtteo34ck0h1lASwH3eSrrDGAhV9qEzCPZkGdsMa7zILKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739191993; c=relaxed/simple;
	bh=K5o3RQ0hMM5DRbgt2eXYXSdhNiAgsyrOTi04XG3Mv5A=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JncpXyc8xu7FHSd23jJuRQkrT6MvJSzQ46ENL/OfEGM+5lyX2mTHo2vn9jRoWgUC0Ux+6vXSlh2X3a9dW/IV2Fmg8oQnQu4gqp98RAzpacwTM5UrXdxnFmj7sgj213Y97XNhlFGGJa95TnvXfwDOYUskRQZSBqYypNZdxFLgZVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=ItRTgfZ8; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51ACr8x352239013, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1739191988; bh=K5o3RQ0hMM5DRbgt2eXYXSdhNiAgsyrOTi04XG3Mv5A=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=ItRTgfZ8xuNscq9lo7nIxBa6TVv/cd5SgWXJIReLjz802uznpPhPR0d1obxIpS0Pn
	 POwr3oM98WxmUSDI3GeoRxYEfHnCGusMbtBaFnaslYR9UxDxGkSDHhP/xl8Cxj6pUL
	 Nv5Ls+32D17KkMuYUaGQ6az5TFBlCFbcyMT77QGcxiYu0/KlqWpiw6fMWWc9n3kBQh
	 Pz7Hu6+3WOun01nqWGsLSMcwDnseYaYB1r+Uw+STBJEgcNAEEYQLA97CjPkxwkCaTv
	 HP26Kv3IS8w0EFEtDm9R5K/4bLFCmVU9tngdjvstg13kcGgStPm5zrIjMCvjJQmopg
	 ECgBKw+/8jbfA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51ACr8x352239013
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 10 Feb 2025 20:53:08 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 10 Feb 2025 20:53:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 10 Feb 2025 20:53:08 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553]) by
 RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553%5]) with mapi id
 15.01.2507.035; Mon, 10 Feb 2025 20:53:08 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: pull-request: rtw-next-2025-02-10
Thread-Topic: pull-request: rtw-next-2025-02-10
Thread-Index: AQHbe32nZ7pVvFmBQkmowW3rDMHe7rNAfbPv
Date: Mon, 10 Feb 2025 12:53:08 +0000
Message-ID: <8a208a29890746ab879f7aec05d5d763@realtek.com>
References: <42afd66d-f60c-47fc-9d8a-0b113dcb9cbb@RTEXMBS04.realtek.com.tw>
In-Reply-To: <42afd66d-f60c-47fc-9d8a-0b113dcb9cbb@RTEXMBS04.realtek.com.tw>
Accept-Language: en-US, zh-TW
Content-Language: en-US
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

Ping-Ke Shih <pkshih@realtek.com> wrote:
> Hi,
>=20
> A pull-request of rtw-next to wireless-next tree, more info below. Please
> let me know if any problems.
>=20
> Thanks
> Ping-Ke
>=20
> ---
>=20
> The following changes since commit 59372af69d4d71e6487614f1b35712cf241ead=
b4:
>=20
>   Merge tag 'batadv-next-pullrequest-20250117' of git://git.open-mesh.org=
/linux-merge (2025-01-18 17:57:31 -0800)
>=20
> are available in the Git repository at:
>=20
>   https://github.com/pkshih/rtw.git tags/rtw-next-2025-02-10
>=20
> for you to fetch changes up to 6b39cc01af66a32c4d03952e0b3aae19cdf4b66e:
>=20
>   wifi: rtlwifi: rtl8192de: Fix typos of debug message of phy setting (20=
25-02-10 11:45:39 +0800)

Please ignore this pull-request, because kernel test robot found a
problem [1]. I will fix it and send a new pull-request.

[1] https://lore.kernel.org/oe-kbuild-all/202502101810.3CUpUL7p-lkp@intel.c=
om/


