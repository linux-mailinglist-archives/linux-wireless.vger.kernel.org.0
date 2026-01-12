Return-Path: <linux-wireless+bounces-30697-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8B7D11F7B
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 11:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D7E630A7C3D
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 10:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6253382F1;
	Mon, 12 Jan 2026 10:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="svlrt9no"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B837320A04;
	Mon, 12 Jan 2026 10:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768214435; cv=none; b=IOUpHkBBp8EVjq6/V00VzUxeRjvJ3y0LPfgH2fPr4sFZsbm8XvXlHOr9Y3mgG2VqZ5jL7Eysmy9PaXVLfKH77XZ7eztJwa60PoNN6UGV2o1FVcJnsNiL5uLJPSjIGZ5v4XCOcyPxXwy5qmiJoNehtRLXLrFlO87CEVdlr9QTU0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768214435; c=relaxed/simple;
	bh=Oj2J0GnH4tj15F9hCJQpu5fTJm93919StEGaEBgNXoI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QbigMJTPt97MJbOwLxbR9NAYhIyx2qU9QRQjxfTu0TX72p5Tnx9tNY+51qWnJ6UbyPUcgqmyFLOHrrYarTMNDuFF1h/hltDBDCZ8ryxd+npiExmnz38lBTdYS9YaUFJK9FL9O7QR+Vuebok6ZeAMhzRmzOScTRqjyjiXYEalpSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=svlrt9no; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Oj2J0GnH4tj15F9hCJQpu5fTJm93919StEGaEBgNXoI=;
	t=1768214434; x=1769424034; b=svlrt9noXBphWXSk/c9hI1Uc4zyrtQ3rMnrLjt1fUz3gMaO
	JxlsggrhD2T/T3y9r4ue2X/fE/V1YjAHJvuEduiMK9YmCjq+BGy0kgLw2Ztpa729fi0Zqo2PMECD9
	80V1ZhdiVcJzCECVL0WrMYIcPgZ5yjXQOB8UmFAx5u3uFWxbeav2MbUggKVSPsCaNoZey5bpLWncA
	veUFM1V1Jd00pgmrG0GqQC9AR66OtfOIHqjOpcosudQ1pWTGUCPYdxJDHfEXsjDyxdxOw876EWN2x
	cQyccc+JY5Brf3FMoUI8u30upPouaG34kYTQPMpL/8/8rKHRJ5grliSu9Zc4LamQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vfFLU-00000009qRk-0am0;
	Mon, 12 Jan 2026 11:40:24 +0100
Message-ID: <e0b3759f761e9ac7b67fe9c41fe38abc4d080ba9.camel@sipsolutions.net>
Subject: Re: rcu: INFO: rcu_preempt self-detected stall on CPU
From: Johannes Berg <johannes@sipsolutions.net>
To: =?UTF-8?Q?=E7=99=BD=E7=83=81=E5=86=89?= <baishuoran@hrbeu.edu.cn>, 
	linux-wireless@vger.kernel.org
Cc: Kun Hu <huk23@m.fudan.edu.cn>, Jiaji Qin <jjtan24@m.fudan.edu.cn>, 
	linux-kernel@vger.kernel.org, syzkaller@googlegroups.com, Felix Fietkau
	 <nbd@openwrt.org>
Date: Mon, 12 Jan 2026 11:40:23 +0100
In-Reply-To: <29c2ec08.a749.19bb1c53f9f.Coremail.baishuoran@hrbeu.edu.cn> (sfid-20260112_113414_298216_15B95490)
References: <29c2ec08.a749.19bb1c53f9f.Coremail.baishuoran@hrbeu.edu.cn>
	 (sfid-20260112_113414_298216_15B95490)
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

Hi,

This is the third such useless report you created within less than 24
hours - please audit them before posting if they're even useful.

Also, pretty sure upstream syzkaller has been reporting the same or very
similar issues in the past, having duplicates isn't really useful.

From my perspective, this gets us nothing at all, so please stop.

johannes

