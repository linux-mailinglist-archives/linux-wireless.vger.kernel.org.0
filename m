Return-Path: <linux-wireless+bounces-9526-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5F391655E
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 12:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC52C28113E
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 10:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE9B14A0BC;
	Tue, 25 Jun 2024 10:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mCBmk0z8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43A5132126;
	Tue, 25 Jun 2024 10:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719311973; cv=none; b=ZDhrzsAz+Pnh/UnF+EtrIejTz0YcCAF3/7Q5tligmkZAjZNosTU0FSdYLCY2Mg3XrztSlMrghOOgT8E32SLPnSAv3eX8Diw4jk7vWeJbzc5E28I47UIoh7ltYp1n/M8gSzvwS0e4JOI3h/2XJQLXriF39tpzqbmayjVhZqQGkoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719311973; c=relaxed/simple;
	bh=MWi10bchGaB3p+CYjNt+OuuVHKqqAoA2TCw67+dnpHs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=uHJFhKXEzBj3Nr6oiVhfyN2rC4Ec4VPED4FV9TfLWvGKdsFfVrSqzG/bPagMV6wA0GkFfll1b/U7T6zacyihlViR2C7haLqfRhy/19ARFMOId2DdNRmsaD+dv6cQE9XK2ez0bp8vqy1qT5t5YQ12ERYlgR/ZpHkb0fBMUmuSCSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mCBmk0z8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E04C32781;
	Tue, 25 Jun 2024 10:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719311972;
	bh=MWi10bchGaB3p+CYjNt+OuuVHKqqAoA2TCw67+dnpHs=;
	h=From:To:Cc:Subject:Date:From;
	b=mCBmk0z8MrCpCx0/FY9rlasLXLRoEeI/hiNxJolhH8EGMpWrdnaTFwvZucHIT0wbk
	 w4YRyeHXmckpdY+b9tMgI68WjrC6c0vFgwnzlUkp0RsLXybj/Fb3or0KhNYc+OvWcA
	 /AWXGOyiM/J+XQFs2mK5hrcKtMC8oNLC8UXIYl5nrZlP1tofEtPgCGsQGdGMGtn4xi
	 VafkJGe1oxdy0MwLcJ7bbVeB9jxgdzdqUTQTym+G4eqa3b+735SYONpyDvdlgK0th0
	 H+5RKbo+ZSA6HqO+4/b2PBS1pYigp9MK8D7TLVr6eO9SMSO7WPIFcFhT4/I4yLjJ9T
	 v+tPgO95w3diA==
From: Kalle Valo <kvalo@kernel.org>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	florian.c.schilhabel@googlemail.com
Subject: [PATCH wireless] MAINTAINERS: Remembering Larry Finger
Date: Tue, 25 Jun 2024 13:39:29 +0300
Message-Id: <20240625103929.1332926-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We got sad news that Larry is not with us anymore. He was a long time
Linux developer, his first commit was back in 2005 and he has
maintained several wireless drivers over the years. He was known for
patiently supporting Linux users with all sorts of problems they had.
Larry's work helped so many people around the world and I always
enjoyed working with him, even though I sadly never met him.

Rest in Peace, Larry. You will be missed.

Link: https://lore.kernel.org/all/77997185-86a6-41c5-af7a-74e4e9064437@lwfinger.net/
Link: https://arstechnica.com/gadgets/2024/06/larry-finger-linux-wireless-hero-was-a-persistent-patient-coder-and-mentor/
Signed-off-by: Kalle Valo <kvalo@kernel.org>
---
 CREDITS     | 4 ++++
 MAINTAINERS | 5 +----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/CREDITS b/CREDITS
index 0107047f807b..1a1a54555e11 100644
--- a/CREDITS
+++ b/CREDITS
@@ -1214,6 +1214,10 @@ D: UDF filesystem
 S: (ask for current address)
 S: USA
 
+N: Larry Finger
+E: Larry.Finger@lwfinger.net
+D: Maintainer of wireless drivers, too many to list here
+
 N: Jürgen Fischer
 E: fischer@norbit.de
 D: Author of Adaptec AHA-152x SCSI driver
diff --git a/MAINTAINERS b/MAINTAINERS
index d6c90161c7bf..250c4c3aee22 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3602,10 +3602,9 @@ W:	https://wireless.wiki.kernel.org/en/users/Drivers/b43
 F:	drivers/net/wireless/broadcom/b43/
 
 B43LEGACY WIRELESS DRIVER
-M:	Larry Finger <Larry.Finger@lwfinger.net>
 L:	linux-wireless@vger.kernel.org
 L:	b43-dev@lists.infradead.org
-S:	Maintained
+S:	Orphan
 W:	https://wireless.wiki.kernel.org/en/users/Drivers/b43
 F:	drivers/net/wireless/broadcom/b43legacy/
 
@@ -19511,7 +19510,6 @@ F:	drivers/net/wireless/realtek/rtl818x/rtl8180/
 
 RTL8187 WIRELESS DRIVER
 M:	Hin-Tak Leung <hintak.leung@gmail.com>
-M:	Larry Finger <Larry.Finger@lwfinger.net>
 L:	linux-wireless@vger.kernel.org
 S:	Maintained
 T:	git https://github.com/pkshih/rtw.git
@@ -21249,7 +21247,6 @@ W:	http://wiki.laptop.org/go/DCON
 F:	drivers/staging/olpc_dcon/
 
 STAGING - REALTEK RTL8712U DRIVERS
-M:	Larry Finger <Larry.Finger@lwfinger.net>
 M:	Florian Schilhabel <florian.c.schilhabel@googlemail.com>.
 S:	Odd Fixes
 F:	drivers/staging/rtl8712/

base-commit: 14f89946b6b383e617657a1e81fe6bf520ce86d5
-- 
2.39.2


