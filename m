Return-Path: <linux-wireless+bounces-27836-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A5387BC00AE
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Oct 2025 04:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3B90D4E4C2D
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Oct 2025 02:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F2B2AE68;
	Tue,  7 Oct 2025 02:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="NgDVVX2k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8431134BA3A;
	Tue,  7 Oct 2025 02:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759805220; cv=none; b=ev2sXhjGE+jziuE4eXTssYXx2/K8hp9vzGsP5+D5etIL88wUuBLfDk8oZH0IK1k9cvgYuzMSWmp4oYvugysCLR8C3bUj/tHmwEcLHliIZqpWy1rwSDLbYatXFlqgULRWoFuidsQ46QE3/X7poa6Mi9sNEzP1Ei7r/00NmK0X3Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759805220; c=relaxed/simple;
	bh=LZjDjUUf034uruFNdYRiq6i6rK7A8lXjvrBQAw/aNTc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HtX6Fx9x9FRUCRbOQW658MFvPKABo4dmHygtJ5RGNf0SZHRBFLBZR7hP1Z3rWIT/sJp75fuioOkaN0EcRprsyocDRhmGyp2BENOMMCncfV0aeE3S/ERn9EVb6js5ZotqwR4IfCIudyk9jTXrIeDK2qthYR8LHjav0PKaUh42vtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=NgDVVX2k; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5972kU8T13401975, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1759805190; bh=LZjDjUUf034uruFNdYRiq6i6rK7A8lXjvrBQAw/aNTc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=NgDVVX2k9QmtqYQ8tAAkEgUjiRZ7xkGPCZJKJbx87tR36EemNMGp/IzUr9t3tATK4
	 SNy62DH8EOQq5FePjfmQZvTtdRyMGo0o0wqa3hXXw0OVh5cUTOGibMr+UCxT2s+r3Y
	 hizUG0p/eEqYXeKAM6wwgSij/6SM51EZu2TS36HY74QoJ0/DBhS4UqW02N6mnAF+Sl
	 ML57An8+iyvEbNFdYM8eKbQRfdgDvwSyS53BM9Hn1GUUr30rlMYnYP43PGQ7S6poG7
	 1m2H9N+uBxHwikjQzxrYtaUUDhmzVbnfn+LTJ0p6gEwwSgWQjs8jGsovLxeMzvB6Kl
	 yaPZ0DFj5ZtEg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5972kU8T13401975
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Oct 2025 10:46:30 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 7 Oct 2025 10:46:30 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090%10]) with mapi id
 15.02.1544.027; Tue, 7 Oct 2025 10:46:30 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Fedor Pchelkin <pchelkin@ispras.ru>,
        Bitterblue Smith
	<rtl8821cerfe2@gmail.com>
CC: Zong-Zhe Yang <kevin_yang@realtek.com>,
        Bernie Huang
	<phhuang@realtek.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>
Subject: RE: [PATCH rtw-next v2 1/7] wifi: rtw89: usb: use common error path for skbs in rtw89_usb_rx_handler()
Thread-Topic: [PATCH rtw-next v2 1/7] wifi: rtw89: usb: use common error path
 for skbs in rtw89_usb_rx_handler()
Thread-Index: AQHcM9h8B6afnv3FwUSDvxPgmvNcsbS2AVxw
Date: Tue, 7 Oct 2025 02:46:30 +0000
Message-ID: <3efeddd273a34309b6f8365a7d327b14@realtek.com>
References: <20251002200857.657747-1-pchelkin@ispras.ru>
 <20251002200857.657747-2-pchelkin@ispras.ru>
In-Reply-To: <20251002200857.657747-2-pchelkin@ispras.ru>
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

Fedor Pchelkin <pchelkin@ispras.ru> wrote:
> Allow adding rx_skb to rx_free_queue for later reuse on the common error
> handling path, otherwise free it.
>=20
> Found by Linux Verification Center (linuxtesting.org).
>=20
> Fixes: 2135c28be6a8 ("wifi: rtw89: Add usb.{c,h}")
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>



