Return-Path: <linux-wireless+bounces-15118-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FC59C13C3
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2024 02:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE1C41F22E27
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2024 01:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0974114286;
	Fri,  8 Nov 2024 01:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="YvcQdfZA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52A114012
	for <linux-wireless@vger.kernel.org>; Fri,  8 Nov 2024 01:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731030139; cv=none; b=Db3l0h1QCpSVRjFHPxIW/SqkImgnaWLCVQlUqpT0Q+ep4IQJp3uRCvvnNLWlgHgCviDLqy6CkuxVYsS784A6F/YPeQ5oXiPYU+9LcFAY2oH8bApwMu8m3vvSB9Huyksh6w+jpWC9/Y4xe5IgrhNOXJ2SGDIahtWkKsgBC+0UHIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731030139; c=relaxed/simple;
	bh=Q+ULbE3YMQHHwvuHSwTrhcENvnRPS+ywwBnp7wbdnsA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M8qQ6v/tfGoOH1kzjK8eUnQFviB0H6whus3Vjs/HRAUbp2P0J/YVKVXtIw2kgQpMVsMpWAodKVPNGxJ9p0dYgozSxOIzZaSn38LKBOAMeZ2p7pDiGgnRUPHUzEdWsftkcq9dd/gl2A0k82SgCV8gbUoZo8t7o1GwDz01xeC40fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=YvcQdfZA; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4A81fjlY71168320, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1731030106; bh=Q+ULbE3YMQHHwvuHSwTrhcENvnRPS+ywwBnp7wbdnsA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=YvcQdfZASxXc4Wzk3amYlYBfG8P5rrvjV50wVxcz3zGUm7rZJr/XhIS14SuGA2rsr
	 s8UPIxkLqQ4XG3r/4ucnPTo1kFl8udo/gywSNAmt95Q6SdivGKkzFKG4Po9mE0obrG
	 ys88RMn+4PbcqM7DxAULHLOFVKAW2s70iaRhxZIApDmby2n9WbniU+rNp7YGGR55cC
	 2f6C9CCOYOjn2Xo3bv6ZyPkdB+v30YElb01h6sHj5yt+lfLVCUPM0R9It7CiKcX2U0
	 ch7/gFKxkTvDC7MTbpZ/PzERjMsh60wJCcHLX8m0HvBBFJvIFkYK3EN3R2wo2tp5mz
	 BhvTCfysS/3aA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4A81fjlY71168320
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Nov 2024 09:41:46 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 8 Nov 2024 09:41:45 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 8 Nov 2024 09:41:45 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Fri, 8 Nov 2024 09:41:45 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Kalle Valo <kvalo@kernel.org>,
        "kernel-dev@igalia.com"
	<kernel-dev@igalia.com>
Subject: RE: [PATCH net 0/5] wifi: rtlwifi: usb probe error path fixes
Thread-Topic: [PATCH net 0/5] wifi: rtlwifi: usb probe error path fixes
Thread-Index: AQHbMRmqQ9O6iAG3kEOA9UfJBD4foLKskHCg
Date: Fri, 8 Nov 2024 01:41:45 +0000
Message-ID: <7f14133bbf0c4f2b8d7889e65c3ccf2a@realtek.com>
References: <20241107133322.855112-1-cascardo@igalia.com>
In-Reply-To: <20241107133322.855112-1-cascardo@igalia.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thadeu Lima de Souza Cascardo <cascardo@igalia.com> wrote:
> These are fixes that affect mostly the usb probe error path. It fixes UAF
> due to firmware loading touching freed memory by waiting for the load
> completion before releasing that memory. It also fixes a couple of
> identified memory leaks.

This goes via wireless tree, not net. Just send to linux-wireless (you have=
 done).
No need "net" in patch subject.=20

I would quickly check if you did really encounter problems and
have tested this patchset with real hardware?



