Return-Path: <linux-wireless+bounces-29234-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBC2C78AEB
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Nov 2025 12:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C38E636416B
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Nov 2025 11:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD4527B358;
	Fri, 21 Nov 2025 11:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="whnOvMwU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06A630DEA9
	for <linux-wireless@vger.kernel.org>; Fri, 21 Nov 2025 11:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763723214; cv=none; b=TJfR5J3iPI2b5HmBA231hn5uQOQ497ImRNWAhxfvV5V3sf1rZRuKeT6oVgMJWS1HbT9++kU6rnvaz+9dANtIuUsB+nGVD+hyYt32O0v6iu9qh3fyzzVHi4p3pCMsJowOSophBQz/Bdo1oUAEwlOaTDknNHuH0tVrwSwqXMkWH3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763723214; c=relaxed/simple;
	bh=YIJgjKtLKUO5I/S9Z7krKEvsdOTsAwNxGrlXE7Mbk4k=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ti9dsd0gL6tY7FZ8mC5nLrVmxO0b8v4D5u5EfZ7lDEhG2BgkFUXF56BlKczz/0fyQdPETqIlupnJaT33k0uDjdP2mA2kbni8h3Y9oQ93ukvCtr4SzlBcQgfk67qG98cjmSSIWYiex4Dykf0frXeD9/Cf5tEbZBN/DODZaDHfSYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=whnOvMwU; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5ALB6kFpA3456705, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763723206; bh=YIJgjKtLKUO5I/S9Z7krKEvsdOTsAwNxGrlXE7Mbk4k=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=whnOvMwUBEQimkEctOcZgdLLtZREv/V5cEGI8ebr+de6hExxznHcmecXr9LYNfbtJ
	 9OblUZQGY5RLYT4FjN8Gtt6XY6n7DA6nrBxT5XOZYSDOpZ7bP+aU2ghQY4g4eJgTuk
	 4fNzNyGIR5Ixsz6oTdyPLalaTi+lcW1zKS1jwq/Ox/5nfw8A08TobzdwY/hrqeCrtc
	 +TMcoiHLxAeqqkQH+QjuXUxuzjw8H5rs6E3/B+LC3J3KQAbIz0ZVE0900j1bwCo8gA
	 tYKj+1Ywj8e5OSCn4nVFSnoNwMpSRq0EGZ4JL2gYZXp3atVnQ5UH+hJwp3diwh//Qp
	 5cpmf0eMCCLSw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5ALB6kFpA3456705
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 21 Nov 2025 19:06:46 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 21 Nov 2025 19:06:46 +0800
Received: from RTKEXHMBS03.realtek.com.tw ([::1]) by
 RTKEXHMBS03.realtek.com.tw ([fe80::2514:51f7:92e3:7d6a%9]) with mapi id
 15.02.1544.027; Fri, 21 Nov 2025 19:06:46 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: pull-request: rtw-next-2025-11-21
Thread-Topic: pull-request: rtw-next-2025-11-21
Thread-Index: AQHcWrB/d+j905TewEqsG7bEMcIPsbT895kL
Date: Fri, 21 Nov 2025 11:06:46 +0000
Message-ID: <dcb94486b8c7475d89bce0051e39c335@realtek.com>
References: <f3669a13-41b7-452e-90c7-317c9c2ada0d@RTKEXHMBS03.realtek.com.tw>
In-Reply-To: <f3669a13-41b7-452e-90c7-317c9c2ada0d@RTKEXHMBS03.realtek.com.tw>
Accept-Language: en-US, zh-TW
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


Ping-Ke Shih <pkshih@realtek.com> wrote:
>=A0=A0
> Hi,
>=A0
> A pull-request of rtw-next to wireless-next tree, more info below. Please
> let me know if any problems.
>=A0

Please drop this pull-request (I also drop this in patchwork), because of r=
tl8xxxu freezes=A0[1].

[1]=A0https://lore.kernel.org/linux-wireless/ff184c0e-17f2-445f-9339-f4db99=
43db86@embeddedor.com/T/#m76dbf946db6268478a39821db28c94eef60d0166


