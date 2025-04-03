Return-Path: <linux-wireless+bounces-21128-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E33DA7A4C2
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Apr 2025 16:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07FE01897FAB
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Apr 2025 14:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B1A24EF6B;
	Thu,  3 Apr 2025 14:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZh2tGRX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAE724EA88;
	Thu,  3 Apr 2025 14:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743689276; cv=none; b=qFCQnpuMNhWaTzGBTOtxpDGhU2PP+WK5FHlrQhGwJ/bZgf6rMhMDwZEJ3+ia61gLapI12Uj/lmlRL2sfXMl2GbneuONDYS7pV9w2rX4HbBFpGVj2f9VVCY/vt5IdtOZRJnXeq4n/JK/33pOnC7FErdIK1mKJGAsB2L7RRAZEZ6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743689276; c=relaxed/simple;
	bh=39VMYhU+74mMPI9DI3V/VxZjDFcE/1tMwt7m4qa+2nU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RLR6ToEwsW844Alx5zmQo6S85LPpp4bnAx8LCTZ70evTzIZ2PpFBRDXePaWYh9xQ9LMz4t0fDs01u/w8XdQNXf/Kn2F5mTcj+e07jqFYuj9HK4aaGU95MUgyxux/2NP6YVduxqT4Nu6YubUOOfT3EK5cuuO7uyZPkHHc66syZas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZh2tGRX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 78660C4CEE3;
	Thu,  3 Apr 2025 14:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743689275;
	bh=39VMYhU+74mMPI9DI3V/VxZjDFcE/1tMwt7m4qa+2nU=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=lZh2tGRXFrMH7vxDqCnyXt8z75iA2JMWeOKYtV+SV8WFAR5Jeof8bCbDWLXAs97OQ
	 xdFz4nV4UUufzWKLJ7ZS54+e05h51S2x5EbLuSGYixNAddc0053ZQnykPCwk+Pp6vW
	 pbfxyqwaDs7OoAdjp7maTuqO3CZEXJgDyoPMadyIy/mhKs0psXkgfaq85VjwF2y+iC
	 5y4I/uqjl9DBC5mUQW8iGgc4owmlDHX02xtIWxwM8Y0w+vmvOor7MrzAWsAEf7/gZY
	 7GcaIvxmErcA+hS4aRngkTm49MMG0lIyIOWlbbtX7j+27HWA14AGZlkDxT/E/9RCd7
	 JKIbTHiPleHGA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648BDC3600C;
	Thu,  3 Apr 2025 14:07:55 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Subject: [PATCH 0/2] Onboard USB device support for RTL8188 2.4GHz USB WiFi
 module
Date: Thu, 03 Apr 2025 16:07:47 +0200
Message-Id: <20250403-rtl-onboard-v1-0-10ca9a6a4ee0@posteo.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADOW7mcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDEwNj3aKSHN38vKT8xKIU3TRjC2NTkzSDJEOTJCWgjoKi1LTMCrBp0bG
 1tQB8OGQZXQAAAA==
X-Change-ID: 20250403-rtl-onboard-f38354f0b14b
To: Johannes Berg <johannes@sipsolutions.net>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, 
 Matthias Kaehlcke <mka@chromium.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jes Sorensen <Jes.Sorensen@gmail.com>, linux-wireless@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-usb@vger.kernel.org, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743689273; l=886;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=39VMYhU+74mMPI9DI3V/VxZjDFcE/1tMwt7m4qa+2nU=;
 b=GBtBg4J3jFJRTewN2BJhs+xjZvDIbF3WaNoVycTobq+8M+1FCplFQjhzYoe7LKvp7cOnCZZQn
 J1i+FWjzMRFAP9zWIkQuT5OMKg/oKA3Iw3DhlMNPK2EfO2MHeNGPhRr
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

This patchset adds rtl8188 (usbbda,179) to the onboard_usb_dev driver.
It is found in a set-top box called "Fernsehfee 3.0".

As a side note, this device is currently marked untested in the RTL8XXXU
driver. In my experience it works (tested with a WPA2 home network).

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---
J. Neuschäfer (2):
      dt-bindings: net: wireless: Add Realtek RTL8188 USB WiFi
      usb: misc: onboard_dev: Add Realtek RTL8188 WiFi (0bda:0179)

 .../bindings/net/wireless/realtek,rtl8188.yaml     | 51 ++++++++++++++++++++++
 drivers/usb/misc/onboard_usb_dev.c                 |  1 +
 drivers/usb/misc/onboard_usb_dev.h                 |  8 ++++
 3 files changed, 60 insertions(+)
---
base-commit: 38fec10eb60d687e30c8c6b5420d86e8149f7557
change-id: 20250403-rtl-onboard-f38354f0b14b

Best regards,
-- 
J. Neuschäfer <j.ne@posteo.net>



