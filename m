Return-Path: <linux-wireless+bounces-21282-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2FEA8159F
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 21:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD35A18976E8
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 19:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07871245024;
	Tue,  8 Apr 2025 19:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMwNhvyD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBA41DA60F;
	Tue,  8 Apr 2025 19:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744139639; cv=none; b=USDRfvTpqVcGH6KZrIE4H8c+ra1xlq9zTVPhq97yLOXBJT7ULGJ/wJGZ79Yk9fw66HCOfscfTbic+LOkJ9yAlUTkyPJvhBZG4ksMWqZCYFjOH+S9YVdL2kaTEDMyCRaGdUfvpjRWD54vWI6RflmnxjxxtSRO4hatV0RenNtI8Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744139639; c=relaxed/simple;
	bh=CKwo4CEyVgAnPR0XP4Ca6WTn2rjHiPkVkvAQlXqXWe0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BM16VhJ6s0+cwRI8BPUtqZzwqeX/0+hUeOVOQlWfnI6vxcwnPfsSBg1j7058nry6eLr1oOAAgs5kaMSdepJUeU7/iS6Lsvefs6ZUtZeUcw+zgOJLrBNgYhI31VVly9q12AjI61YyYpIgtWx1kLsiaxylc6ybSqnVtfP1jRp/upw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GMwNhvyD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 437FDC4CEE9;
	Tue,  8 Apr 2025 19:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744139639;
	bh=CKwo4CEyVgAnPR0XP4Ca6WTn2rjHiPkVkvAQlXqXWe0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=GMwNhvyDOpDoWFGo26E3SW0ae/kkNc24Lq4Cv5E/mo4j8nTScU7q+COs2fQWXJcRl
	 ED+srwVtGI8EQBQlY42K5JrZnSLF5h5EGmevNL19C690piaXbdkuTl99+cnpz84Cfq
	 2uIvmWeQTwo9r4sDihrK8Pi1rLGagGlxlSHIDbGygHAzWFcl78EtQ9cKbE/W6UAQuh
	 Dqvjb/Z9ONzGie1TVxipTwGE7sHUam8Tj1puuWyOiRY6nbmW8Y6yIA2FCDA8EZ3o5y
	 2XxzTSWsgE2fxDKKvUh/XswSRDYvwmZsLQvnybUICNi3RExisLGM3/0zSnyuoBIm/U
	 NoU/066S23cww==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318EEC369A1;
	Tue,  8 Apr 2025 19:13:59 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Subject: [PATCH v2 0/2] Onboard USB device support for RTL8188ETV 2.4GHz
 USB WiFi module
Date: Tue, 08 Apr 2025 21:13:11 +0200
Message-Id: <20250408-rtl-onboard-v2-0-0b6730b90e31@posteo.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEd19WcC/23MywrCMBCF4VcpszYyuVTUVd9DukjaqQ1IpiQhK
 CXvbuza5X/gfDskip4S3LsdIhWfPIcW6tTBtNrwJOHn1qBQ9WhQi5hfgoNjG2ex6KvuzYJOGgf
 tsUVa/PvQHmPr1afM8XPgRf7W/06RAoXEyd7sxRoiHDZOmfgcKMNYa/0C8hFdd6cAAAA=
X-Change-ID: 20250403-rtl-onboard-f38354f0b14b
To: Johannes Berg <johannes@sipsolutions.net>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Matthias Kaehlcke <mka@chromium.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jes Sorensen <Jes.Sorensen@gmail.com>, linux-wireless@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-usb@vger.kernel.org, Bitterblue Smith <rtl8821cerfe2@gmail.com>, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744139638; l=1198;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=CKwo4CEyVgAnPR0XP4Ca6WTn2rjHiPkVkvAQlXqXWe0=;
 b=uUhCgcSt/puX3o3dWNQZSDas53VdL2UfuHpeEbhOQOvmlroP9iHibEpRQjLg2ojIeIgbRcZ+a
 0KTiyVQ+UswBYmyG95EETp/oya+UIrjBca2XXS3o0ODLyw+0pcTHz6E
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

This patchset adds rtl8188etv (usbbda,179) to the onboard_usb_dev driver.
It is found in a set-top box called "Fernsehfee 3.0".

As a side note, this device is currently marked untested in the RTL8XXXU
driver. In my experience it works (tested with a WPA2 home network).

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---
Changes in v2:
- Fix editing errors (email address and TODO comment) in binding
- Refer to more specific RTL8188ETV instead of RTL8188
- Use unambiguous SPDX identifier GPL-2.0-only instead of GPL-2.0
- Link to v1: https://lore.kernel.org/r/20250403-rtl-onboard-v1-0-10ca9a6a4ee0@posteo.net

---
J. Neuschäfer (2):
      dt-bindings: net: wireless: Add Realtek RTL8188ETV USB WiFi
      usb: misc: onboard_dev: Add Realtek RTL8188ETV WiFi (0bda:0179)

 .../bindings/net/wireless/realtek,rtl8188e.yaml    | 50 ++++++++++++++++++++++
 drivers/usb/misc/onboard_usb_dev.c                 |  1 +
 drivers/usb/misc/onboard_usb_dev.h                 |  8 ++++
 3 files changed, 59 insertions(+)
---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20250403-rtl-onboard-f38354f0b14b

Best regards,
-- 
J. Neuschäfer <j.ne@posteo.net>



