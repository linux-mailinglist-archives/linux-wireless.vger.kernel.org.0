Return-Path: <linux-wireless+bounces-17056-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFC1A00CE6
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 18:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7724C3A4110
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 17:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EB61FC105;
	Fri,  3 Jan 2025 17:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="a8igNg/z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2431FBCB6;
	Fri,  3 Jan 2025 17:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735925905; cv=none; b=NWFjUhmVJsFSKOtN6ig3JN8MaHtDNtrdMZCpADlJLIlB79RTHLk3Wvthhyj81DiWy3IsX8FaJ373eORTJkrtoaH/lRxGubKKFMzuVGHaDkghfmxOxHSsWlyUTJ7ZMvJ+GfmSsVqpgA3ld4qlVmC+w0G29wTm1QGYbg8IwhPpXnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735925905; c=relaxed/simple;
	bh=h274+P1d0fdf4m5XYw8D7v8J9GD1uiA4j8+b4CDKDQs=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Qs6t3EqK1q5eUQAJhttlYAmaYwguVLZFXqmORWZNlm6UjQMfOG0ogMufr5m7P3mtX6ztylHmPEqkMXxhkqJ3P8YW8YCxrHBZpJgY2+66LgylgU/9NNyx3pScRQ4jE+N2iACRThyjIJk4CzZphjPN5MCOX1gfZcUaU9iVVGMlhkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=a8igNg/z; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1735925891; bh=h274+P1d0fdf4m5XYw8D7v8J9GD1uiA4j8+b4CDKDQs=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=a8igNg/zJINRHkE0ScwuLpWKQwUWTmifuo3p37cQknv5cy4an9VStJifxQxZTmOCX
	 O5LkB6fgbVXI6Z0oJUteC56ys74z7ws21C6fW1pK20eBVWjFVw2EOQ9Rm+9sSRUUgC
	 HDykpf4PShTxP+2ZVU0Pzc2vskA0rXdWizVjV7xF0+aLPApBCdCgDwBUpvTC1/pfMy
	 y4+8Ljuh4LETz8cDfiChNJFprNjaQmhZn51FG0QWuP9US3FCfaP2A4ATeN1E/21olJ
	 w5IYT+PEtZDST7GBZTZmT8TBcWBb+U9nK4H3hcR1C1yLGwxpJM0BWvF1IoLDL/R/tu
	 hJ0XN1rv+k7Cg==
To: syzbot <syzbot+e9b1ff41aa6a7ebf9640@syzkaller.appspotmail.com>,
 kvalo@kernel.org, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org, nbd@nbd.name, netdev@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [wireless?] INFO: task hung in
 ath9k_hif_usb_firmware_cb (3)
In-Reply-To: <676092c8.050a0220.37aaf.013e.GAE@google.com>
References: <676092c8.050a0220.37aaf.013e.GAE@google.com>
Date: Fri, 03 Jan 2025 18:38:10 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87ttaf7q7x.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

#syz test

diff --git a/drivers/net/wireless/ath/ath9k/hif_usb.c b/drivers/net/wireless/ath/ath9k/hif_usb.c
index fe9abe8cd268..8d18043ebdbe 100644
--- a/drivers/net/wireless/ath/ath9k/hif_usb.c
+++ b/drivers/net/wireless/ath/ath9k/hif_usb.c
@@ -1152,18 +1152,7 @@ static void ath9k_hif_usb_dev_deinit(struct hif_device_usb *hif_dev)
  */
 static void ath9k_hif_usb_firmware_fail(struct hif_device_usb *hif_dev)
 {
-	struct device *dev = &hif_dev->udev->dev;
-	struct device *parent = dev->parent;
-
 	complete_all(&hif_dev->fw_done);
-
-	if (parent)
-		device_lock(parent);
-
-	device_release_driver(dev);
-
-	if (parent)
-		device_unlock(parent);
 }
 
 static void ath9k_hif_usb_firmware_cb(const struct firmware *fw, void *context);

