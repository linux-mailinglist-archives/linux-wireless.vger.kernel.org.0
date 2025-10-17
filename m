Return-Path: <linux-wireless+bounces-28036-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6BEBEAFB3
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 19:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6FC81AE2DFD
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 17:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456EB2FA0C4;
	Fri, 17 Oct 2025 17:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="KLDHxjp0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-24427.protonmail.ch (mail-24427.protonmail.ch [109.224.244.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9512FC02E
	for <linux-wireless@vger.kernel.org>; Fri, 17 Oct 2025 17:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760720803; cv=none; b=aCbj1Nw6uI+VUzdsOlvIc1pZVT+5UyvGuPa7GnOwoTEquAHljqB93JrYjjlUpVxNsDyIZpsCGmcUTm3GEzpQlxaGerINVEmfp4r0/9pCDmSlf+P4n5MiR5I9Wv4U32jJ2C40mPdFTTPCZ0mjL0pznCK/M2bfm2kybCZAkM+QLHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760720803; c=relaxed/simple;
	bh=MxSVmKZzDySkwRw1WJ2bjPwT4C8AIKQkobGqcRl+Iug=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kJOT/qM3F5SXQn+sFUdIrLDwQQ5fnpmY+07XNCRcnXW/njb4wYbX8nDENLacdPxn5WDVXdljSRr/gjys8qai2lOrN/GQ6cvTqL6W5TY8ZpDG/XwjWvXao22vS2q/PVG8HXOo/2/vX7GR/H6WOshJTi3cJbRfvuRKSB0F15zZvXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=KLDHxjp0; arc=none smtp.client-ip=109.224.244.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1760720791; x=1760979991;
	bh=MxSVmKZzDySkwRw1WJ2bjPwT4C8AIKQkobGqcRl+Iug=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=KLDHxjp0k0DLmUwDEwe8T2Yt6hTJneMg9lJMo9JjLlXypc2jrfhaB0NJwjuyzyZVO
	 3916XkbsfJQNGGwFPijO2aeNq3bMdOyPyBNXBr2nRj/ngDoprEOlDcsq+WEJ4xuSsN
	 iSZLpP5YDdE2Aoa2J6MBanrhzU9DcgMELBxpRzElheTNS03DvRQJApO4x7wLPy8imG
	 wgd+CYG2oNy/o1OJEL5pd2EkBjrXtym71Kn77MujeoxxdmXMVVQBXgeWTtQuFziwBJ
	 URmEfB3CYO9Zvs/3AbXu4KVF71aKqxVkOLY/mbamwTXwc50CP1tLANSH0ObuoUuyZb
	 YwiyPJ5YU54xg==
Date: Fri, 17 Oct 2025 17:06:27 +0000
To: Ping-Ke Shih <pkshih@realtek.com>
From: Samuil <samuilsgames@protonmail.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: RTW88 USB Wi-Fi Adapter (8822BU) Disconnects and Fails with USB Write Errors - Status -71 & -110
Message-ID: <NzJSxrT9jRashfF-xriJRKi4gvwRM0ZFHviT-VoqEtdlyEg350QA26ROzn-mLe0TYhZNewXS7dYGf4aVHWAW3TlOSnRCJPsOXJA9bUiw1iA=@protonmail.com>
In-Reply-To: <9d4086b0e8134084a8bb7800db56db2b@realtek.com>
References: <zjR8G0R1ZUFe9h8_ibO-LWc9OOJyMThA9jp9ftYbETLG3IN0cHPvhCAaC9ypGKPbapsbzTH5VqnDhFcX93GkwnG1BEyETplFQmRiGGshBz8=@protonmail.com> <9d4086b0e8134084a8bb7800db56db2b@realtek.com>
Feedback-ID: 26992803:user:proton
X-Pm-Message-ID: 14e3ab1e7c7b90a920198eaac66533acaac851a4
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Friday, October 17th, 2025 at 12:48 AM, Ping-Ke Shih <pkshih@realtek.com=
> wrote:
> Is it possible to bisect culprit? Since there are 100+ commits since v6.1=
1.

Hey,

With "most recent bugless version" I meant that the bug occurred when I swi=
tched to v6.12 from v6.11 and that the issue hasn't been patched since. How=
ever, I've now found a workaround though it's not optimal: Setting `rtw88_u=
sb.switch_usb_mode=3Dn` to prevent the switch to USB 3 mode fixed all issue=
s. No more disconnects or error messages. I think this was the default beha=
vior before that version.

Thanks for the help!

