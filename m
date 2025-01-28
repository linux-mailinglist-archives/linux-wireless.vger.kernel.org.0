Return-Path: <linux-wireless+bounces-18048-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8159EA20210
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 01:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97DF01884369
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 00:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0C3BE40;
	Tue, 28 Jan 2025 00:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPcaNiVu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE514A1A;
	Tue, 28 Jan 2025 00:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738022796; cv=none; b=P/V/SxzjfcqBkqndGS3yZe65lHb7fTA4NfyRX+DvV7o5TxZHUArarD1Kk5s3Ghb1ZH8AP34zajJk1zviRy0/0ibHzYQGGVJcA+9PjSrPH8DCA/wr+VmsnW7BS3F1IYOxrd25HBOPdF8OA4XsQCkfSoZxPdG+OI+6g0weiFtblj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738022796; c=relaxed/simple;
	bh=hdD/lkpi+9/YArLnX7wjSWSXiDV5h4tehxtqm9TMWBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kan5lc2QVJyMEwePFGGV9FqIqiuCNZd4L64XvOVlv1GyZWasucSrxyFVvxOxqk3+2+F88b5QJO044+TadYVKGmSC0g5BG0x8gApm7qcllzPE2FX6PS+hCHaWsCbPYhHOoBpXPPmhaKONu/qYTUPXToDKOehKtVZ0fxemm9OR+gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPcaNiVu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9065C4AF09;
	Tue, 28 Jan 2025 00:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738022795;
	bh=hdD/lkpi+9/YArLnX7wjSWSXiDV5h4tehxtqm9TMWBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lPcaNiVudyKvkajoNLTbetl2NxriGbZ2iRUKGs44UrJeVO6SZ3LpwQxS09VqVZ37P
	 PLZFUiiYjzVHts5nrQXw6PjdhSDKIrr5MtoZssbBCDBTax7K5CS295vwV2UwNw/8Xc
	 CrQgpG2td/P7F6/jUqr/ZLybtnfWfyQlUAIuIBBJOSxfvUU7HrnuPqZhdQ3hRTiIho
	 vH77g31jW7ZjebRJvaqaOTMX+Is4p2afS92NfOzTxL+cNCsoMyoCKMsN3Fp8e8xVR1
	 uwRYypRb/lbN+/0Axwehly9LTxEjqY1eiW9DnQQTGUqr0Yi+z6PqKZQvO30iYzM39y
	 MIOq57D99Bvug==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tcZ7h-0000000DRKp-3AM8;
	Tue, 28 Jan 2025 01:06:33 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Subject: [RFC v2 07/38] ABI: sysfs-class-rfkill: fix kernelversion tags
Date: Tue, 28 Jan 2025 01:05:56 +0100
Message-ID: <dd5fff5fe459b1e4d8eee422dd7e506084c93310.1738020236.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1738020236.git.mchehab+huawei@kernel.org>
References: <cover.1738020236.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Some kernelversion tags are missing colons. Add them to comply with
ABI description and produce right results when converted to html/pdf.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/ABI/removed/sysfs-class-rfkill |  2 +-
 Documentation/ABI/stable/sysfs-class-rfkill  | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/ABI/removed/sysfs-class-rfkill b/Documentation/ABI/removed/sysfs-class-rfkill
index f25174eafd55..20cb688af173 100644
--- a/Documentation/ABI/removed/sysfs-class-rfkill
+++ b/Documentation/ABI/removed/sysfs-class-rfkill
@@ -4,7 +4,7 @@ For details to this subsystem look at Documentation/driver-api/rfkill.rst.
 
 What:		/sys/class/rfkill/rfkill[0-9]+/claim
 Date:		09-Jul-2007
-KernelVersion	v2.6.22
+KernelVersion:	v2.6.22
 Contact:	linux-wireless@vger.kernel.org
 Description:	This file was deprecated because there no longer was a way to
 		claim just control over a single rfkill instance.
diff --git a/Documentation/ABI/stable/sysfs-class-rfkill b/Documentation/ABI/stable/sysfs-class-rfkill
index 037979f7dc4b..67b605e3dd16 100644
--- a/Documentation/ABI/stable/sysfs-class-rfkill
+++ b/Documentation/ABI/stable/sysfs-class-rfkill
@@ -16,7 +16,7 @@ Description: 	The rfkill class subsystem folder.
 
 What:		/sys/class/rfkill/rfkill[0-9]+/name
 Date:		09-Jul-2007
-KernelVersion	v2.6.22
+KernelVersion:	v2.6.22
 Contact:	linux-wireless@vger.kernel.org
 Description: 	Name assigned by driver to this key (interface or driver name).
 Values: 	arbitrary string.
@@ -24,7 +24,7 @@ Values: 	arbitrary string.
 
 What: 		/sys/class/rfkill/rfkill[0-9]+/type
 Date:		09-Jul-2007
-KernelVersion	v2.6.22
+KernelVersion:	v2.6.22
 Contact:	linux-wireless@vger.kernel.org
 Description: 	Driver type string ("wlan", "bluetooth", etc).
 Values: 	See include/linux/rfkill.h.
@@ -32,7 +32,7 @@ Values: 	See include/linux/rfkill.h.
 
 What:		/sys/class/rfkill/rfkill[0-9]+/persistent
 Date:		09-Jul-2007
-KernelVersion	v2.6.22
+KernelVersion:	v2.6.22
 Contact:	linux-wireless@vger.kernel.org
 Description: 	Whether the soft blocked state is initialised from non-volatile
 		storage at startup.
@@ -44,7 +44,7 @@ Values: 	A numeric value:
 
 What:		/sys/class/rfkill/rfkill[0-9]+/state
 Date:		09-Jul-2007
-KernelVersion	v2.6.22
+KernelVersion:	v2.6.22
 Contact:	linux-wireless@vger.kernel.org
 Description: 	Current state of the transmitter.
 		This file was scheduled to be removed in 2014, but due to its
@@ -67,7 +67,7 @@ Values: 	A numeric value.
 
 What:		/sys/class/rfkill/rfkill[0-9]+/hard
 Date:		12-March-2010
-KernelVersion	v2.6.34
+KernelVersion:	v2.6.34
 Contact:	linux-wireless@vger.kernel.org
 Description: 	Current hardblock state. This file is read only.
 Values: 	A numeric value.
@@ -81,7 +81,7 @@ Values: 	A numeric value.
 
 What:		/sys/class/rfkill/rfkill[0-9]+/soft
 Date:		12-March-2010
-KernelVersion	v2.6.34
+KernelVersion:	v2.6.34
 Contact:	linux-wireless@vger.kernel.org
 Description:	Current softblock state. This file is read and write.
 Values: 	A numeric value.
-- 
2.48.1


