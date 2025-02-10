Return-Path: <linux-wireless+bounces-18698-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 532A0A2E8E6
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 11:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E21FF162CD8
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 10:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE621CAA65;
	Mon, 10 Feb 2025 10:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gK4IzSh7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1951C5F26;
	Mon, 10 Feb 2025 10:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739182704; cv=none; b=F2gSdwFvNgvAU29lE5m4lPuCV2c1GT6XDxDqghylAyjvTDzSi/KrJEuUWl53rl7MAiEhrltNNcgK2lK9UZ9+oIU2pgM6EWP75P4Vu+pSNgUzeP1b4Rj+8h3QkRXYmLfTXj5Ay4/ICh+2Czk/urL46xAGF0TH1H2By6XtKjY2ZD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739182704; c=relaxed/simple;
	bh=hdD/lkpi+9/YArLnX7wjSWSXiDV5h4tehxtqm9TMWBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O/oej/mr+GixexbPVGXyFhr+S4Mcb86TLnDB+/JkfDGut3mMlJLMfS9fcqlMWmaAJ03XG7QVzSL/JsBbEiqKLpmlzhF0CNMaiE+wVT+MChZS3khvY/aTy90X8yMw3ozf7g5uRfp9wi8hkNZ+D1gMTGoTxsYVtj768pdVDXWbgOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gK4IzSh7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F4AC4CEE8;
	Mon, 10 Feb 2025 10:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739182703;
	bh=hdD/lkpi+9/YArLnX7wjSWSXiDV5h4tehxtqm9TMWBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gK4IzSh74oV/PMAN1TbaccYqTPFi0h7UTglCsSjtFjav+ORarQK5IRT46evSWva6X
	 07YtQDeu5hNh5+LuXZdxzhxqUUf7hPym0CUnuozXL+jyGKdXh2xUmq2ORwSiav4IT/
	 0O6N+IWb2GebzH6YXE9aMoZLamQSZgGy9911O83PB1J8q0h1u+330BIQcFezeBuHZi
	 5Jiehf+kgxw4ln6Ze+buR8B8MIST3xzDTrT5uyHH5iwnf7SuTHI4LEP/DExaZypRi8
	 xsMrti9j4f7prV6w/bHTjKccBfsgwfe2YvwohgqCYFN/kyHLiDo7GZupseF4HqNdke
	 xJ6Q3mH0tkwPw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1thQrt-00000006CiO-43NZ;
	Mon, 10 Feb 2025 11:18:21 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Jonathan Corbet" <corbet@lwn.net>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH 04/27] ABI: sysfs-class-rfkill: fix kernelversion tags
Date: Mon, 10 Feb 2025 11:17:53 +0100
Message-ID: <b2e38f7857e8fddad03401a2ae6c5af5ca8db507.1739182025.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739182025.git.mchehab+huawei@kernel.org>
References: <cover.1739182025.git.mchehab+huawei@kernel.org>
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


