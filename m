Return-Path: <linux-wireless+bounces-11557-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DE7954925
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 14:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5826D1F24873
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 12:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40A71741D2;
	Fri, 16 Aug 2024 12:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0f7K4hh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909B4156F34
	for <linux-wireless@vger.kernel.org>; Fri, 16 Aug 2024 12:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723812663; cv=none; b=ZjTtclqFcuzMxj/QZg3YfOUSkj88S4gbVga/xoxzk7MwYjf8u7Jt0NiRJLCISkX8XJyp3wKuFg97E3LroGcjbjO2uux5s5k8UnRT+1UWjZh6/50FqVFjTeAQtxDrbnPu6j2CPjoLbxtSXgv7eN5BL0SqjkT82NwKDqgFhnfyZD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723812663; c=relaxed/simple;
	bh=MiOdLaJrIHX/U0klBs4LeuRqSpQio/Q7tX2UQHZcKdA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=J3mRF8sCeISXS47uDYKYfb4F2kTcmQj1pIkVPFLBu7nyuRa+FM1mcPzIjXYYjxZNBea6y/ZB8bwA9louOKfSFNhvMbyCWNfolUbHN384/XXquRzFTmr8A/WF3RxvSNiTooqVX6dgw4OA36sAABw+yKH/wdL8flxiS1ztEBMFAMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0f7K4hh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C632C32782;
	Fri, 16 Aug 2024 12:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723812663;
	bh=MiOdLaJrIHX/U0klBs4LeuRqSpQio/Q7tX2UQHZcKdA=;
	h=From:Date:Subject:To:Cc:From;
	b=I0f7K4hheRSJEObgmWRc9S0fLZYo7tomaB801tmQAK9OAJB7jszIHf7NcKqRMlaBq
	 kAMurQRYz2GVqtCgdfp0CdRqF1ER4K4RP8WKfHunk4yUW3Gi45mw05I4Mao+OC/Yiw
	 d3vtRglIzbQ4JjKs/GXkq/i0S/+2v5R+5vQiVJrjI+MzjF3IHv25N990Y52tisMRHe
	 uWDfVbQG60cFVrlP87C/ZDFa02FpsbLRDWjwRtmMvydlSxEbH9sAeOnYS2cmH7sHQf
	 mgXVPbVJeQhqfGgsGjbZzcdYyNczkm3ZyWE4sUJWgLD9rmi0XnP3R5q1KdOjRP1Cyq
	 s2HGfgP09j1bA==
From: Simon Horman <horms@kernel.org>
Date: Fri, 16 Aug 2024 13:50:58 +0100
Subject: [PATCH] MAINTAINERS: Add net-cw1200.h to NETWORKING DRIVERS
 (WIRELESS) section
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-wifi-mnt-v1-1-3fb3bf5d44aa@kernel.org>
X-B4-Tracking: v=1; b=H4sIADFLv2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDC0Mz3fLMtEzd3LwSXbO0NCOjVKNEyxTTNCWg8oKi1LTMCrBR0bG1tQB
 sU9O5WgAAAA==
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org
X-Mailer: b4 0.14.0

This is part of an effort [1] to assign a section in MAINTAINERS to header
files that relate to Networking. In this case the files with "net" in
their name.

[1] https://lore.kernel.org/netdev/20240816-net-mnt-v1-0-ef946b47ced4@kernel.org/

It seems that net-cw1200.h is included by CW1200 Wireless drivers, and
thus that NETWORKING DRIVERS (WIRELESS) is the most relevant section for
this file.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8766f3e5e87e..028884a31640 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15896,6 +15896,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git
 F:	Documentation/devicetree/bindings/net/wireless/
 F:	drivers/net/wireless/
+F:	include/linux/platform_data/net-cw1200.h
 
 NETWORKING [DSA]
 M:	Andrew Lunn <andrew@lunn.ch>


