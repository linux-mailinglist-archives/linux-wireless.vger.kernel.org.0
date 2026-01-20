Return-Path: <linux-wireless+bounces-31008-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF17D3C10C
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 08:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F136F4418C1
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 07:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742733B5312;
	Tue, 20 Jan 2026 07:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="CfjYE4D5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EE83ACF0E;
	Tue, 20 Jan 2026 07:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768895700; cv=none; b=f00Z3aX+/3RTgx8T+heC92jUcuMc6cHZj3Rx6B4KxbKUp2z5lwsllbhchBmeFjFWAkbAKf2iJoghJBjn9SF/i3UbAgTkkyii/6DGFtlBZksLpn0fPb2xyb0cS0tmZVqm9aR/KqKizS1yCLsI0/qwkDWSQZDhMv6O1Sk2YbrWJKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768895700; c=relaxed/simple;
	bh=XP3cJ02IZQ5T9U/pP+pd4SKtTbvd4q1XkL1MDVvVAFQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ii6IOxbfJAJ2lBosH4PvxxoELzbsvnxErCzr5lZoNxO/um5UMUUwfz2WtVv7FGNk4bS3WTc4hl5lAhd+iGrnxeQfcMX9hd8ccIIVEf0zSgJCgSgvIi75wDoNNXDNUX3SSAqyjnjMXin/wxmxCM6zQSBz2ZdBEe3FtQuQyAJDVuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=CfjYE4D5; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=XP3cJ02IZQ5T9U/pP+pd4SKtTbvd4q1XkL1MDVvVAFQ=;
	t=1768895698; x=1770105298; b=CfjYE4D5vdYsk+HpMXAkYhyF2sj7zgkg16xjUR2MXVPlBpD
	MvdHtXl8NnyZH1EQVEqywWDx6gcLBplqsG5JEWX548oKlWx3zgtagDc7z4SP4GP60cfiOGb9MQWtJ
	N4UdFAR7fROw4N3gnrVSxBPnmECgX1MBhmKJsnonUhPMVH9DjWGolWArA9bZx1wW7J19jFV6Kegvf
	6iCeH81qh9zcvuZhH6RMWuzmYnUP728QJ3EUDNEePLONDZ0qzJ3p4gi1DgdCrfdlltpRP/iMM19Pt
	h6bp/slJdJiEQxidJlX6RJ5ZfMLRQkA12TCl2hb91R0FaiuNKtPaN7jabf7SFWkw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vi6Zj-0000000GhDX-1ijY;
	Tue, 20 Jan 2026 08:54:55 +0100
Message-ID: <eece33b4580bb35d28be8ffba7957bde509f59cf.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: Fix and improve debugfs TSF access protection
From: Johannes Berg <johannes@sipsolutions.net>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+15f88dfa580000@syzkaller.appspotmail.com, Arnav Rawat
	 <arnavrawat2000@gmail.com>
Date: Tue, 20 Jan 2026 08:54:54 +0100
In-Reply-To: <20260119194057.53339-1-kapoorarnav43@gmail.com> (sfid-20260119_204306_054164_7A51E36C)
References: <20260119194057.53339-1-kapoorarnav43@gmail.com>
	 (sfid-20260119_204306_054164_7A51E36C)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2026-01-20 at 01:10 +0530, Arnav Kapoor wrote:
> This patch comprehensively addresses reviewer feedback on the debugfs TSF
> access protection:

Please go away until you understood how that contributing to the kernel
isn't dumping reviewer feedback into an LLM.

johannes

