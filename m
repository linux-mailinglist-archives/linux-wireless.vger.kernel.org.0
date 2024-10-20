Return-Path: <linux-wireless+bounces-14236-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB1F9A5200
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Oct 2024 04:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB7A028340C
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Oct 2024 02:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B527376;
	Sun, 20 Oct 2024 02:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="RR2cM7SQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFC41FC8
	for <linux-wireless@vger.kernel.org>; Sun, 20 Oct 2024 02:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729391653; cv=none; b=SLieUVYaakm0zFbc8yg3N+8fs8xU+K7QhdUnf+Mo4dSHMHCsyKv4xw5Mg0G+YLXOwh+j4NyhxhB4CyIxTedaHzWvRIBAmBtRaLbw6eXOnxqkLEn7/h86orj6u05nyUhAtlNYdK5bczhRfd3XAIW2w44ejtMc2GXTwqwoRBZ+oPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729391653; c=relaxed/simple;
	bh=zITdGFYiqhVQS2rwnR4XK4kuP/1QMiXRosIaxr9ImO0=;
	h=From:To:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Message-ID:Date; b=OW6FRTnxxlOGY9Dflm5sqgdnoZq8TxXRfhA5+OSg9a9DKubv+HR+tbIWB342J+25JVXo0Ayz11WsKlBJwadq6xp3yHXOYtt7LGU4TV4Gdf5tx8pGhlUItwMyq/LuZ7y9N96sZPP0fkU+RLLVW4Z8aFzSgF6jJFCrhZx3Bu70eeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=RR2cM7SQ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49K2Y0Iq8269493, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1729391640; bh=zITdGFYiqhVQS2rwnR4XK4kuP/1QMiXRosIaxr9ImO0=;
	h=From:To:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Message-ID:Date;
	b=RR2cM7SQwv6+f3m2SIZxOCffsta5S0t4mA2eyIpDmCx6Cmv7thk1zpzYxX4GsMd3G
	 DNQdoZEInITYWrGSgEvXpCIA+GGy5XRWTxNP5Eo3wAlgdUXiH7BkaQ7WkScexjS5U8
	 RMtZ5bI9li+9J5eH9YV2Bmq14gWbe9EYEj+uGLIgUfybG5CmLuIqZZzyoouxs7icjY
	 9ZoM3gxKY6eLHIPny7zCMrcrQkJrtJ4n+O8iuKfjmbm3b/IGirClBgs4EB2oMY4Sgr
	 AUpJkv41vwUHiAa36FJ3bJFZtW+fRozKwqClYKVinzm4caQq6+v36bGjv43U84VKxO
	 kZ6YXU4dfAPNA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49K2Y0Iq8269493
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Sun, 20 Oct 2024 10:34:00 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 20 Oct 2024 10:34:00 +0800
Received: from [127.0.1.1] (172.16.22.200) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sun, 20 Oct
 2024 10:34:00 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 1/6] wifi: rtw89: wow: cast nd_config->delay to u64 in tsf arithmetic
In-Reply-To: <20241009004300.8144-2-pkshih@realtek.com>
References: <20241009004300.8144-1-pkshih@realtek.com> <20241009004300.8144-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <12e12ba9-2b44-4691-a8df-f8cd125bcf85@RTEXMBS04.realtek.com.tw>
Date: Sun, 20 Oct 2024 10:34:00 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> The type of tsf arithmetic is
>    u64 += u16 * int;
> 
> When (u16 * int) is larger than 0x7FFFFFFF, the value casting to u64 with
> sign-extension will become all 1 in upper 32 bits part.
> 
> To meet the case, u16 value should be larger than 20491
> (0x7FFFFFFF / 104800). Fortunately the meaning of 20491 is delay time of
> WoWLAN net detection in unit of second, so 20491 seconds (5.7 hours)
> might not a real case we can meet.
> 
> Addresses-Coverity-ID: 1620910 ("Unintended sign extension")
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

6 patch(es) applied to rtw-next branch of rtw.git, thanks.

5af57c4f9937 wifi: rtw89: wow: cast nd_config->delay to u64 in tsf arithmetic
778e2478d195 wifi: rtw89: pci: use 'int' as return type of error code in poll_{tx,rx}dma_ch_idle()
66595e319886 wifi: rtw89: 8851b: use 'int' as return type of error code pwr_{on,off}_func()
50e9febff35f wifi: rtw89: 8852b: use 'int' as return type of error code pwr_{on,off}_func()
c72c54fd96d0 wifi: rtw89: 8852bt: use 'int' as return type of error code pwr_{on,off}_func()
74432751ff63 wifi: rtw89: 8852c: use 'int' as return type of error code pwr_{on,off}_func()

---
https://github.com/pkshih/rtw.git


