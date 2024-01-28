Return-Path: <linux-wireless+bounces-2625-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A39F83F94A
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jan 2024 20:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 963A51C214CA
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jan 2024 19:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771CE31A6B;
	Sun, 28 Jan 2024 19:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=swsnr.de header.i=@swsnr.de header.b="RJGlLmWP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3324426AE8
	for <linux-wireless@vger.kernel.org>; Sun, 28 Jan 2024 19:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706469555; cv=none; b=rATQe1LEFRPLaeHfdqw5akKmagM2izKWgNzFZP1qlQXeMf1KMbhpXBSuwN0E56iov9k/3Matse+gVCs5eRgh45ZYUw1jP3B+b7K8Ky91P9l//qpnsALFYdfm48zWFws3+zWSQOzDZTTVMdrJ6l+Z2jWMWyG+mH4aI8ylOPUqQ28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706469555; c=relaxed/simple;
	bh=ExDQIZZlKvg5fSE+pSjje3Z+6mDPpumn6NFwqkAAu8g=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=Uf6vcmW3hjLab46ezHtwReD3XtpOeN1PsBJnwua3i8W2u5MSnTE1/fKtIpXPpNlyvVa1FTDsQhGmRoZwA1xLcJTrBAZxJXOzs5ChnYRFLycL62ni2yNaPHeFonQtpA/fi5LVgSuYGlDY69RnOgPym+X9pqW6j6pU6Ny7jO6mx9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=swsnr.de; spf=pass smtp.mailfrom=swsnr.de; dkim=pass (2048-bit key) header.d=swsnr.de header.i=@swsnr.de header.b=RJGlLmWP; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=swsnr.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swsnr.de
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4TNLb60hpHz9sRf;
	Sun, 28 Jan 2024 20:09:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swsnr.de; s=MBO0001;
	t=1706468978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
	bh=Kg9PZtH911coTjQfk6yKUtfKbwW13qcKcAPkD2ur8WU=;
	b=RJGlLmWPTgPtl44Civf3sPu4Y2OGWE27IMgNvN1jWM3I7RePR6NSRZwe7TAz4eIoXxx0cU
	zvVKesPgzihqCzvwnz9FIX4G5PdlHirPU0JtaUuvKgwYlCjWMbR7oIEW8b872AF1yPQMB9
	Hh3w2yXkQ1nhUQSjA/P9voM1u6EEeGnAjLBg26oxsSRTXRTP33GHeejelPB+JTFIO2K7Gl
	WJsXvPgRYzOp9YiN47dfwFaO39Wwv5ufXetx5Gu65WdHN/t0+zubXqWEi4Bk4DKMUutvdj
	3yMhrJyofdROkEOthcu0QhgD0mDWcXyyC2JyoUjNjBaBx4sth843UBY6ZvQNIw==
Message-ID: <3146ecbcfffeb1ca05c05f7d1f141711c15651a2.camel@swsnr.de>
Subject: Missing firmware dependencies in iwlwifi module?
From: Sebastian Wiesner <sebastian@swsnr.de>
To: linux-wireless@vger.kernel.org
Cc: daan.j.demeyer@gmail.com
Date: Sun, 28 Jan 2024 20:09:35 +0100
Autocrypt: addr=sebastian@swsnr.de; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello,

the iwlwifi module seems to be missing firmware dependencies on some
"pnvm" files.  At least, the module crashes at boot of the pnvm file
corresponding to the ucode file isn't present, but "modinfo -F firmware
iwlwifi" does not list the pnvm files:

$ uname -r
6.7.1-arch1-1
$ ls /usr/lib/firmware/iwlwifi-*.pnvm.zst
/usr/lib/firmware/iwlwifi-gl-c0-fm-c0.pnvm.zst =20
/usr/lib/firmware/iwlwifi-so-a0-gf4-a0.pnvm.zst
/usr/lib/firmware/iwlwifi-ma-b0-gf4-a0.pnvm.zst=20
/usr/lib/firmware/iwlwifi-so-a0-gf-a0.pnvm.zst
/usr/lib/firmware/iwlwifi-ma-b0-gf-a0.pnvm.zst =20
/usr/lib/firmware/iwlwifi-ty-a0-gf-a0.pnvm.zst
$ modinfo -F firmware iwlwifi | rg pnvm

I stumbled over this while building a system image with mkosi.  To
minimze image size I was removing unneeded modules from the image, and
mkosi automatically removed firmware files no longer needed according
to "modinfo". =20

The image failed to boot, with iwlwifi complaining about a missing pnvm
file (I'm sorry but I don't have the actual error message at hand
anymore).  After manually adding the pnvm file to the image, it booted
successfully.

See https://github.com/systemd/mkosi/issues/2334 for the mkosi bug
report.

This is my first mail to this list, and to any kernel mailing list
really, so I'm sorry if it's missing information or is somehow
inappropriate.

I'm not subscribed to this list, so please keep me CC'ed if you need
further information.

Cheers,
Sebastian Wiesner

