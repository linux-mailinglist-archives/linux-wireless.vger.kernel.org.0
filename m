Return-Path: <linux-wireless+bounces-29364-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE701C8C76F
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Nov 2025 01:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A664A3AF300
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Nov 2025 00:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025E124EF8C;
	Thu, 27 Nov 2025 00:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="sBjaMvP3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0DB2309B2;
	Thu, 27 Nov 2025 00:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764204425; cv=none; b=lY2vF1t9SZYAilGq5CqXyVlvujXTBVB6mNqAbn1S+OG8UQvHbHu0Jdul2C1Sx8ewP2R80j/JJUh+BHJxY1+78ocFBb98S6qx3uJ6GbAiFcaID6O3kWA9xlcg+ZRPiSBM22SRNg7yjYpKLwS77KTPLo+3RLllppcI8jN6eclccZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764204425; c=relaxed/simple;
	bh=xJMOnn2c56A0OGZ4J5jUZnmhWmizBVEBESCLuNwhAX4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bCAuZ+Io/kEJeFNZnpIhyZZMBVQ7ejktu4wVJwJi6Ig8VvkCJa3UDzf1sCfMnatPk7pLKIrQpOP7uP7Eky4w3p6E5VV6lPavrPgi4QahVVnYvhRqKu/uY1q4oswsG5rAqdcl8t0SALqZXO398N77qjab0ZwhxYQGJs7K73lCEBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=sBjaMvP3; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AR0krgxF1864353, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1764204413; bh=xJMOnn2c56A0OGZ4J5jUZnmhWmizBVEBESCLuNwhAX4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=sBjaMvP3zhnjYyNXh6ruTAFomtEe19isDpjPtPGLqfQ1ek2qwkDIUPGXX40H5p5Pi
	 6l07qBX7ZSHusPUMYmp526ieZzvtIuA/EvKheUi89VCo/81tpIyfWDjyh+IM8Ah0O+
	 n6oBzFs+WrcOQg+HdDvLcfo6mXMuXDy32mv1REbVmXwf6Hpe5wYS4rmKxHv6P41FJQ
	 QqZU+ijaFm/pZcpl/M8PY+1xz8zgmyRPIuMgwFjnqoQIvRzGO2uO+Q4vydhleTrQch
	 Oq+kU8YDsbBbRsCejyWIR6L2bNTR0JmEYmMvYWW3lqB8MTX2Q8R+xc8TaBQskx/3TN
	 8lke/xp9wEMqQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AR0krgxF1864353
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Nov 2025 08:46:53 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 27 Nov 2025 08:46:54 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 27 Nov 2025 08:46:54 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Thu, 27 Nov 2025 08:46:54 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] wifi: rtw89: 8922a: set random mac if efuse contains
 zeroes
Thread-Topic: [PATCH v2] wifi: rtw89: 8922a: set random mac if efuse contains
 zeroes
Thread-Index: AQHcXrW+seogSvPfC0SufQQkf4a2z7UFsRpA
Date: Thu, 27 Nov 2025 00:46:54 +0000
Message-ID: <cc682f4f654346a9a098c48f4a6b4f92@realtek.com>
References: <20251126091905.217951-1-jtornosm@redhat.com>
In-Reply-To: <20251126091905.217951-1-jtornosm@redhat.com>
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

Jose Ignacio Tornos Martinez <jtornosm@redhat.com> wrote:
> I have some rtl8922ae devices with no permanent mac stored in efuse.
>=20
> It could be properly saved and/or configured from user tools like
> NetworkManager, but it would be desirable to be able to initialize it
> somehow to get the device working by default.
>=20
> So, in the same way as with other devices, if the mac address read from
> efuse contains zeros, a random mac address is assigned to at least allow
> operation, and the user is warned about this in case any action needs to
> be considered.
>=20
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>



