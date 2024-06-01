Return-Path: <linux-wireless+bounces-8376-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D8A8D71F1
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Jun 2024 23:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A35CF1C20A44
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Jun 2024 21:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4724B22612;
	Sat,  1 Jun 2024 21:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="SNMnPzBJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-43167.protonmail.ch (mail-43167.protonmail.ch [185.70.43.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8803122611
	for <linux-wireless@vger.kernel.org>; Sat,  1 Jun 2024 21:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717275975; cv=none; b=aHPwl28zvXVX8kLZNwu5RDMP+gbKqA1vP7JLSfKiMAM6NWNYk+9OhTiWAlPAKpRM8h5K3KqlFbbeD6djB17rvEqkDYE9BLQSsna6M6A7uy8CxaVuUxxNNQx8dM+Fqf4LFTU0z4Kb6Y57M9eWhI+7123uccR2VmwPuQt5CKA73bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717275975; c=relaxed/simple;
	bh=C4uHj9N25w0EJd+TGJgW9N+/WkmJUq4W9KV82HpZZhc=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=esOSQSu0Moad2LlD9mes5ppGIOGTResFFV8jKW5XmQqzhe7lK32Re5JOWv96FlOVKkUToJGVImILqQcVb+uxVCYjrq5Ft2POYpI3PNio5cyzpTnffC3rj4Lg0khap1Oy7/LT6I7FR71ecdzZOniTtDvAKlLOBP5JmDM1f3a9TPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=SNMnPzBJ; arc=none smtp.client-ip=185.70.43.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1717275971; x=1717535171;
	bh=BY9lj7u28vxwqsD+t2r48gimoSS/QM25n2L2IVeP9lY=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=SNMnPzBJkMkpV9DIsA8Kz4w78d7OrFbm1I93b8zc92akMBAgtwEx60d2nHplp7M9I
	 moxCobWuwnQn2Bun/DlLebKRJ/7BiXhD+J+ApxuTsAiTWkdul++PFbY+ASaiZsfJAk
	 9BOcXAQTHaxLqZU8QkSUUroBBXnu1r6yZST+bMcdT5MOrB4hXjjQFEIPcqcFmwpwYW
	 51ffy5tfzUHLge32HFwCt/JBp1GXcTbh6IdGQNaENX0n/V8I9oOMrjxrz8XD+BLRIe
	 vF1iatP5FmjUfh/OHmzD2rZc0i82Hnb2d9RAY3ju+3bEFLBw7bsTR7xzo5Q/cWQTZj
	 1WbOot7IgEThA==
Date: Sat, 01 Jun 2024 21:06:06 +0000
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From: Liam <mothsarecool524@proton.me>
Subject: Add Realtek RTL8812AU chipset to project rtw88
Message-ID: <j4XA74KT9pFZBalRpR2dCG07ohOgN6kwhU-Y8LPDUU53D7Kuk6vWQKbu635doolHWOQ96fL4fs7mNWP_zThhLfNvfpeGxQYATdPwfhSuWbc=@proton.me>
Feedback-ID: 108409140:user:proton
X-Pm-Message-ID: 15f765afb364745bda2fbe23d3f650d55ceb1648
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This email is directed to the Realtek engineers working on the project rtw8=
8.

Good afternoon Realtek engineers,

In the list of supported chipsets, there seems to be one missing:

RTL8812AU

This chipset is used in quite a number of smaller USB Wi-Fi adapters, such =
as the NETGEAR A6100, UGREEN A1300, so on and so forth. It may also be used=
 in PCIe cards as well, but I'm not quite sure on that front.

Here's hoping the efforts of the project go smoothly and pay off, so that m=
ore of us can enjoy not having to be tethered via an Ethernet cable.

Best regards,

    Liam

