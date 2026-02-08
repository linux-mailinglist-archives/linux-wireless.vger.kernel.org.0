Return-Path: <linux-wireless+bounces-31642-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4M7lBtL+iGkY0QQAu9opvQ
	(envelope-from <linux-wireless+bounces-31642-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 08 Feb 2026 22:23:30 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7601610A329
	for <lists+linux-wireless@lfdr.de>; Sun, 08 Feb 2026 22:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F0B830071F4
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Feb 2026 21:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A5030100E;
	Sun,  8 Feb 2026 21:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="uCh9W9m0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-24428.protonmail.ch (mail-24428.protonmail.ch [109.224.244.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB64248F5A
	for <linux-wireless@vger.kernel.org>; Sun,  8 Feb 2026 21:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770585807; cv=none; b=bMF62ofWjvrod3SY4ECq1sfhP743pkmqMIZ+8NKyUNKE7J14Cd4Bwgar+Grx39t5NhqDY4M49ze+fzmzaKyQzzwT56hd1la9bM6EP4jmjokzUkjlAMk8jV6LRWFUPP4V/0bdyDDRKacUi/JvnGRIEFGZt5YQmZFcNLhQ7jwTnkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770585807; c=relaxed/simple;
	bh=fTDGNJC/qeFTy9eMy8OPY3JW7QCHiaUSOwe/lDAQSGY=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=jI5l++CPE4IynkzRYu5joEignxWkaAP32QtoiR2KVboBooZIE6lfhXZeS2OJ/hZc0c5BzlPGRuvwTLxoEO6qDIcMVpqnZVh7btVJZWbMW7r+/6uvtpw1ZOVGz3/+/kFmUd7coqfBuR6pe+gqjytA3vKKJNDzZH1yzEpFObq4x7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=uCh9W9m0; arc=none smtp.client-ip=109.224.244.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1770585798; x=1770844998;
	bh=fTDGNJC/qeFTy9eMy8OPY3JW7QCHiaUSOwe/lDAQSGY=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=uCh9W9m0yW4G47DFEhFeATc5Pg6TCzGqEDI20ucaXfi+QOEo6aUlXgxHVTs75diiH
	 gr+3wOtSNV/pFmzwnOKpt1vxf6uQOD/tVxMxbbtS+gctq+MQXGoaglIBXf3gIe/A8q
	 zSqiVpdFcra71fQR6R7Vlaj3MGaBf0o2Cm4sFjn1SWH8KpXL7FmTH+gbn3U+btCCHg
	 6XNHZhi4i7q1m39a7lTJn6sjnmFKfS3vDLopyJ6Jk1klYr/QMMFq4UXvk3+/l5C/xg
	 Q9lQKNY3vqBtOUaI+Sb6iYyBhEQtr1wtcD54hMc9ME+EZ37z/10+sSiUyPBKJLuQWn
	 eQT2sURWFz/QQ==
Date: Sun, 08 Feb 2026 21:23:15 +0000
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From: Maxim Schoening <maxim.schoening@protonmail.com>
Cc: "miriam.rachel.korenblit@intel.com" <miriam.rachel.korenblit@intel.com>
Subject: =?utf-8?Q?iwlwifi:_missing_bz-b0-hr-b0_firmware_=E2=89=A599;_driver_minimum_bumped_in_6.18_but_no_firmware_released?=
Message-ID: <onUUPN2LYpllIkeDRaxKp86WJ_-QFt90qepYZbFtnQrV5VSPuRQIr514C-D3vJDsZDVagyWR9FdtgzWxGFDN2SUWOHfmRAeR3_gi8gLNBEs=@protonmail.com>
Feedback-ID: 28367373:user:proton
X-Pm-Message-ID: 8241daddeb0359725566aae854000777b7f40650
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[protonmail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[protonmail.com:s=protonmail3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31642-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxim.schoening@protonmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[protonmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[protonmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,protonmail.com:mid,protonmail.com:dkim]
X-Rspamd-Queue-Id: 7601610A329
X-Rspamd-Action: no action

Hi,

The iwlwifi-bz-b0-hr-b0 firmware has not been updated past version 98 (core=
98-161, October 2025), but the 6.18 kernel's iwlwifi driver has raised ucod=
e_api_min above 98 for this device class, resulting in complete Wi-Fi failu=
re.

On 6.17.9, the driver falls back to 98 successfully:
iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-bz-b0-hr-b0-100.ucod=
e failed with error -2
iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-bz-b0-hr-b0-99.ucode=
 failed with error -2
iwlwifi 0000:00:14.3: loaded firmware version 98.d661c37c.0 bz-b0-hr-b0-98.=
ucode op_mode iwlmvm

On 6.18.7, the fallback no longer works and Wi-Fi is completely broken.
Neither iwlwifi-bz-b0-hr-b0-99.ucode nor -100.ucode exist in mainline linux=
-firmware or the iwlwifi for-upstream branch.

Other Bz variants have been actively updated during this period: bz-b0-gf-a=
0: updated to 100 bz-b0-fm-c0: updated to c102 bz-b0-hr-b0: stuck at 98 sin=
ce October 2025 The most recent for-upstream commit (9a9285ce, 2026-01-15, =
"iwlwifi: add Bz/Sc FW for core102-56 release") adds firmware for Bz/Fm and=
 gl but not Bz/Hr.

This looks like a coordination gap: ucode_api_min was bumped without matchi=
ng firmware being released for all affected sub-variants.

Affected hardware: [17.350374] iwlwifi 0000:00:14.3: Detected Intel(R) Wi-F=
i 6 AX203
Device: Xiaomi Redmi Book Pro 2025 PCI ID: 8086:7740
PCI path: 0000:00:14.3
Variant: bz-b0-hr-b0 (Blazer CNVi + Harrison Peak radio)
Working: 6.17.9-76061709-generic
Broken: 6.18.7-76061807-generic

This is the same device class previously affected by LP #2102029, which was=
 resolved when bz-b0-hr-b0-96.ucode was added in the core93-123 release.

Could the Bz/Hr firmware be brought up to match the other Bz variants, or a=
lternatively, could the ucode_api_min for bz-b0-hr-b0 be reverted to 98 unt=
il the firmware is available?

Thanks a lot!
Best,
Maxim

