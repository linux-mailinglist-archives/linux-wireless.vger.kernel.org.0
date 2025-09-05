Return-Path: <linux-wireless+bounces-27039-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FD1B4538B
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Sep 2025 11:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2FAF1C26F03
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Sep 2025 09:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037C128137C;
	Fri,  5 Sep 2025 09:40:20 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC83C2820AC
	for <linux-wireless@vger.kernel.org>; Fri,  5 Sep 2025 09:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.236.254.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757065219; cv=none; b=idY5JbMU9JDG37WDf0jTR1qhbeChxvmiZHwWFJ5m1Qb/+OyT16DSm7Gt1RSfiMZA5JzaAhIe3HhUPucTjR8kxrPkYD6qSSGAXaoaQQU5wI2Epsfr7GaYZnBJ6DoSqO3Ha4DbpH/0HX/Ol0sFMEebDzWhSyVzlUTIeWNNB3r5CjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757065219; c=relaxed/simple;
	bh=iCXa73faeee9Uy2t7rJNzTiz/VDGUGJgCufGigdHCSs=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=bMdi8DHN4/cOyyMMIH6oO0Luoynce0UDRbGTwX4mn1TgxdobrQm98/hRA2r/vg+EHEeFeL70aQ25jM3n/FQcOZmFVZoZTc1ynDhbMPag25347WSUb29Zgoi6wYtI71fBmrLYdjtca2LG3bv1COL670ng2fv5loffjNnHS9jopWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se; spf=pass smtp.mailfrom=lysator.liu.se; arc=none smtp.client-ip=130.236.254.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lysator.liu.se
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 877B3D860
	for <linux-wireless@vger.kernel.org>; Fri,  5 Sep 2025 11:34:00 +0200 (CEST)
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
	id 7ACFFD77B; Fri,  5 Sep 2025 11:34:00 +0200 (CEST)
X-Spam-Level: 
X-Spam-Score: -1.0
Received: from sara (h-81-170-152-149.A163.priv.bahnhof.se [81.170.152.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTPSA id 51036D7E7
	for <linux-wireless@vger.kernel.org>; Fri,  5 Sep 2025 11:33:58 +0200 (CEST)
Date: Fri, 5 Sep 2025 11:33:57 +0200 (CEST)
From: =?UTF-8?Q?Peter_=C3=85strand?= <astrand@lysator.liu.se>
To: linux-wireless@vger.kernel.org
Subject: wl18xx firmware Rev 8.9.1.0.2 regressions
Message-ID: <8182838a-c7f4-02e1-adb9-beda31c46e88@lysator.liu.se>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Virus-Scanned: ClamAV using ClamSMTP


(As described on 
https://e2e.ti.com/support/wireless-connectivity/wi-fi-group/wifi/f/wi-fi-forum/1520164/wl1807mod-wl1807-firmware-rev-8-9-1-0-2-regressions)

For us, firmware 8.9.1.0.0 works fairly good, but 8.9.1.0.2 does not: We 
are seeing slow connections, warnings about corrupt packages etc. We are 
using Mesh and AP roles. Anybody using this latest firmware with good 
or bad results?

Br,
Peter Astrand

