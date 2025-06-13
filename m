Return-Path: <linux-wireless+bounces-24098-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D23EAD9868
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Jun 2025 01:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EB714A09D2
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Jun 2025 23:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7F515278E;
	Fri, 13 Jun 2025 23:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="ltDYV80J"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F84F2AE6D
	for <linux-wireless@vger.kernel.org>; Fri, 13 Jun 2025 23:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749855648; cv=none; b=FS04G5lfOIbcMM9Ce+frvZHJh7jMCQsqwdGQqOGqC3lwNgb8knFJmUo5jIGgR+avcsMYEB/AK9LXI5wE7+W5dECzVHrH0EOedvisO+wQw3k8p7Y6zJnyB9OEVieAv3mO6q4tkkoLb0NppUUApoGVRMQMTw/sAXmvEYcgL3OGVaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749855648; c=relaxed/simple;
	bh=Tbe/HmfNxSXQuLXTBqdOLukEE7tdXXBXi0hsoKdpLkA=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=DWrCS0xTQvagTZxwj9DcpVPIbd60fuPWgxBuPOSUqtbYgbEakDMo0DNGvb8ocl9pHxZGfIuuQDNg183vUz0SjDCSf2jBi0GdjgnagWsqeJtYYWDhePuVyAt8nvNl43sN1jWNYvY/ua8eokc4xtR7RGRRaBeJoUVmT3QMfGzY200=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=ltDYV80J; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1749855643; x=1750114843;
	bh=lxEv/IjdjTjVExq/cJjijGF3rCVzSRPQwfIQD0ERLOY=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=ltDYV80JSZfNNySGU97NI6afCVl2BPmLoRWKeAV1yeOJ6Ac8iL2fcUpAss24wc+tT
	 cs2HfjufhPIQol5goH9LhjlmUqc2rWYKybSym3jVydlwYS95voVJ+OZql7mnkCLd5I
	 0oi8p3sCKR4e6PPNrFPJqBqgAHngiyWVyrgPQVqeRsNJ4vp+LddbB9WnXtzp5UOWOq
	 vyIt5VDBJVUKd6X0YfbOX1FqINUsryUILq5r50XwWtUjN15muTJ+b47xPN/njo0CWC
	 hNezkRSwsWeNKBMMzGgaE+F/9xUHPg0ZwAJ54lHVdSqTK8YNwO62u0LvViXZVomOuL
	 wA3qw7YH/cKGQ==
Date: Fri, 13 Jun 2025 23:00:38 +0000
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From: Noel <ncniles@pm.me>
Subject: [FIPS][iwlwifi] AX211 not working on Ubuntu 22.04 with FIPS kernel
Message-ID: <fkI_Avg3J0a2I4RUHbToL_jANN_JCZNE_5ewsXqzltTRlHZ4gjxoYbKfdDpw1ecNApjjhjqDPtHW0fegPyx3lwIirG_swt6YxkXT3yz_OEY=@pm.me>
Feedback-ID: 140167733:user:proton
X-Pm-Message-ID: 95e7fa4612b755638e115946163ba547ddb825c5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi all,

I'm running Ubuntu 22.04.5 LTS on a Dell Precision 5490 with an Intel AX211=
 wireless card:

  PCI ID: 8086:272b (rev 1a)
  Subsystem: 8086:40f0

The device works fine under the standard Ubuntu kernel (6.8.0-60-generic), =
but fails to initialize under the FIPS kernel (5.15.0-141-fips). Under the =
FIPS kernel, no wireless interfaces appear (`iwconfig` shows none), and the=
 `iwlwifi` driver does not load.

From what I can tell, either the `iwlwifi` module or the required firmware =
(e.g., iwlwifi-ty-a0-gf-a0-73.ucode) is blocked or not loaded in FIPS mode.=
 The firmware is present in `/lib/firmware`, and works when using the gener=
ic 6.8 kernel. Secure Boot is disabled.

Is there an effort underway to support AX211 / iwlwifi under FIPS-compliant=
 kernels? Is the issue related to missing signing or certification for the =
driver/firmware?

I=E2=80=99m happy to help test or provide logs (`dmesg`, `lsmod`, etc.). Pl=
ease let me know if additional info would be helpful.

Thanks, =20
Noel Niles


