Return-Path: <linux-wireless+bounces-27710-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59697BAA193
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Sep 2025 19:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0AB41921C6F
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Sep 2025 17:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440AD1F151C;
	Mon, 29 Sep 2025 17:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="ShgSmjb1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F95204C36
	for <linux-wireless@vger.kernel.org>; Mon, 29 Sep 2025 17:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759165594; cv=none; b=UMP8AntR+UnB3fEYJvPD+8hA2IoiACV29jPYle3yotUEDqtTrOdocD+tMKRCHZItmGEViH4vgMSqjbRyctVfCzgaL7Es+GPW/xnARHfZtlLn8XeFcYPo4LMaqIxDPtfoUClCBv0/l3Z9J/ny20oh2qYZX1Mk/dqo7cE1CWma3A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759165594; c=relaxed/simple;
	bh=57b0b4rGJsW0hRj1oeLo8zKxlxVF9n5nmLSaxX/Py+g=;
	h=Message-ID:Date:MIME-Version:In-Reply-To:To:Cc:From:Subject:
	 Content-Type; b=TDlNzy0iUPGXFSy4soippwIKINFYpXFmJuiCz5eh8aK42EosvcA7GFoswtXP0OaDxOZ4LvnraSK95oHxqD8ZpHYhDMNEUC7YWSKk64UpA8DLKXrRrxAqlN+wFL70u7Dz+rTd2ojoL/60HwNyqTsFcT8ywJty4t8VHgwsx5lDh5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=ShgSmjb1; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1759165589; x=1759770389; i=wahrenst@gmx.net;
	bh=57b0b4rGJsW0hRj1oeLo8zKxlxVF9n5nmLSaxX/Py+g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:In-Reply-To:To:Cc:
	 From:Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ShgSmjb1WPKxBVeAWrzFkXP9OK5hmVstY1qb4n+PXLtDkF7D/jkCY1n8AA+sITCG
	 iic3Gk0RD/UWbFwluSOx5LpKZ0MsclHbnjs7jABUO1UgpEga8H5rHnKYAVTp6VU5+
	 tIU2ziHuWaIyzwWPxjuBgWs4ZvsqQ/q1skA4qgefHDrWA8YpMMFySKxzMG2YksKtV
	 kpTinM87h0GL17mcZUnj+bkTY+4Hv83v6LrszEYlOXftqHfzhHyh+XavuUCkMSibO
	 pJ80Bs63HNiN3zCH6g9IMhS1Rptxf6CPJ5Izjv3am+kHL5QFlqA2K00gz2VdnP1e2
	 hNZAm4TfhPiZZptqEA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.156] ([79.235.128.112]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYeR1-1uppDi2XfH-00KJm8; Mon, 29
 Sep 2025 19:06:29 +0200
Message-ID: <fd88175f-497b-4fec-9094-58709ddfd1bf@gmx.net>
Date: Mon, 29 Sep 2025 19:06:28 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
In-Reply-To: <1a187bdb-abd6-4e2c-bc29-94f9ab944023@broadcom.com>
To: Hsien Chou <s311332@gmail.com>,
 Arend van Spriel <arend.vanspriel@broadcom.com>,
 Chris Spargo <chris@streetlogic.pro>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "brcm80211-dev-list.pdl@broadcom.com" <brcm80211-dev-list.pdl@broadcom.com>,
 "brcm80211@lists.linux.dev" <brcm80211@lists.linux.dev>
From: Stefan Wahren <wahrenst@gmx.net>
Subject: Re: brcmfmac: driver crash with iOS 18.6.1, potential DoS
Autocrypt: addr=wahrenst@gmx.net; keydata=
 xjMEZ1dOJBYJKwYBBAHaRw8BAQdA7H2MMG3q8FV7kAPko5vOAeaa4UA1I0hMgga1j5iYTTvN
 IFN0ZWZhbiBXYWhyZW4gPHdhaHJlbnN0QGdteC5uZXQ+wo8EExYIADcWIQT3FXg+ApsOhPDN
 NNFuwvLLwiAwigUCZ1dOJAUJB4TOAAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEG7C8svCIDCK
 JQ4BAP4Y9uuHAxbAhHSQf6UZ+hl5BDznsZVBJvH8cZe2dSZ6AQCNgoc1Lxw1tvPscuC1Jd1C
 TZomrGfQI47OiiJ3vGktBc44BGdXTiQSCisGAQQBl1UBBQEBB0B5M0B2E2XxySUQhU6emMYx
 f5QR/BrEK0hs3bLT6Hb9WgMBCAfCfgQYFggAJhYhBPcVeD4Cmw6E8M000W7C8svCIDCKBQJn
 V04kBQkHhM4AAhsMAAoJEG7C8svCIDCKJxoA/i+kqD5bphZEucrJHw77ujnOQbiKY2rLb0pE
 aHMQoiECAQDVbj827W1Yai/0XEABIr8Ci6a+/qZ8Vz6MZzL5GJosAA==
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ilFWEq6Iewzh+NUBlNKdzHjgAbF9h6qROgvbaRDoV7m69TgVkgQ
 +KzQQNB3CaB0EYG+8D096jn0QPdXFGXotcPczk8tQzmj4fNAyTo8gT20jnQpAoSY/v4klAd
 OoP7UW1S+zNfSX8IAqnCU5jME9GOuUzwgVr3xI7cqYfF3or7IgUBD9Wm/oGRES6SjY3AonK
 RYNyBtAfLDxlBfGNwEJNg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wjQaqr1aKNU=;Ars2PO+RY5tNvcHqolNCjxMZ/UJ
 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

Hi,
regarding reproducibility, I would assume Arend is using the mainline=20
kernel and Hsien just tested the Raspberry Pi vendor kernel. The=20
brcmfmac driver has some modifications downstream.

@Hsien or @Chris,
are you able to reproduce it with a mainline/torvalds kernel?
You only need to replace Kernel, Modules and Device tree.

Best regards

