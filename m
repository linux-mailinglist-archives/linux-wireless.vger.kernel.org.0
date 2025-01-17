Return-Path: <linux-wireless+bounces-17658-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8F3A1561E
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 18:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FE23168A47
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 17:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E8F1A2846;
	Fri, 17 Jan 2025 17:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r6urYEaR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B19188A18;
	Fri, 17 Jan 2025 17:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737136795; cv=none; b=um3PeEYxOprNB8YoVD+y+U+6hopCdDm564PHtQjLg1EyTHcvUWGEvkxIzprHWKYih2atyZFsHEmrZ4ajxsKm1RNAOxqupjI4baT9d70ZdKQlOR5ISyPiuoXUOWFlxoAYse8ld3TlFtg38+ujKGAbyIfe152OGAygrFTcndrFdy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737136795; c=relaxed/simple;
	bh=DpwGZSjL1fDJ0MaoW/bdtyNx3vjLki1I5aLnRAqCHUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ev3Vd0i0zyyyP7gz5FUeu35nhbUUY0G2uXAnU8pyipBTcE+Nr+7m/skkLizUCRz0lguahtEIiwq3lxR296BFP0snYdBCqxKWztrctrO256TctbcqfgCBe2Vpye/gNRiARP3+nHvteOaATQzvN+2YL2Pm/Um5GuKBI0UPhwdl6rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r6urYEaR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBDEBC4CEE4;
	Fri, 17 Jan 2025 17:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737136795;
	bh=DpwGZSjL1fDJ0MaoW/bdtyNx3vjLki1I5aLnRAqCHUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r6urYEaR4nDHxapeT6xlt4vzEuRlTwL+Q1lnfNEoU1H+qB7mmdQs79LroUYX2DVw4
	 tdF2mw11KXFl62VieEzoTkLRy09LpdyjVs/ZuAzhjRdhgYhliy/lJmJ9w+2kwowukU
	 SYOS7fYNlgGqEB/ZQuxrBTpFF4UkUNCLDf56YLRNHWug6yMduuG1vYLs6onQhsyjLI
	 0l2mfudVNXpz/oknYrUfNsogOq0K/Kl02ITJNxjeDhhf4+zxGr96ZddVUAi0pNbiPi
	 8oYOwgsTmdcsNjOgQ0IxUOczExKxjMqh55SneZTAmzPvT858n0Gu/20nmvU7BVPzZO
	 urmTc9RJV22mw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tYqdM-00000006Ajb-1fTL;
	Fri, 17 Jan 2025 18:59:52 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH RFC 02/10] ABI: sysfs-class-rfkill: fix kernelversion tags
Date: Fri, 17 Jan 2025 18:59:31 +0100
Message-ID: <07d4e82750f20b92a18b526a900ffd8c89180aed.1737135484.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1737135484.git.mchehab+huawei@kernel.org>
References: <cover.1737135484.git.mchehab+huawei@kernel.org>
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
2.47.1


