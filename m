Return-Path: <linux-wireless+bounces-6430-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4296A8A7FB7
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Apr 2024 11:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0067B283E8F
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Apr 2024 09:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404C5130482;
	Wed, 17 Apr 2024 09:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QRFBuSeQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bFVMEgX7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB0D12F59A
	for <linux-wireless@vger.kernel.org>; Wed, 17 Apr 2024 09:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713346449; cv=none; b=fDXJ3hi6F/HLJFeUTT5X6PwFLksxOrMK+1dyblyFWt7aQ2dYUjGX4fRaX1729slGDil4LibnWwQfHMS+Tg0oFg4anRWcponzMaMQ6BT6o4haZ0cBtFI3rdwnnN/ccdaqz+YDxmTQ/w4IjaCJbhxCRI1YtutEneopZVZ7QePup+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713346449; c=relaxed/simple;
	bh=fo3O80t7FzhxlckXKx8SFuEEjYelxI1xaPtVHGSyxTw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lbxjXr6GSombTM8ACR3zLjfUQXPAGU3X86AbidiGz/c+SEzhCzCPY2X/EEYPsBERu9sSz9ago98Tv4sVBend/rUgBprk479+3bwyyOt6MwYsE+BV5JNyOXrllId3aJVwgVpKY6R0A4B5NPESB5Q/S5QzpgRCrG7Uhli3vlAjnFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QRFBuSeQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bFVMEgX7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713346446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XPc4/z3TTkt+0V8zuUS+V5Q4uGmxbl3sXcnzTTjUGRs=;
	b=QRFBuSeQnqP+aKPLVVlrAHfX7NnP9fHLcs+sB5q3DxkJZK8fc6fxS/Vt8PeoJgSY360OEt
	XvIQtKUTJCr5o6cIgF80ZmQLL15cCOm2+1RJxG2tGFIQZIz/p7zQ4RF15lOB7CnnszA/Qp
	VcH4wl9p5JeUe0b/5P2qZYPtwENe+7vZdJKjpiyclt+Q49KWNYXF3v4ejk4inxW0q1nPMT
	yeWZP3/jvEA/szlUcyqcXW666tPQ9nAACazoe+ilna6FFWr5DnAKbsydMlVkX/Nftj/FW2
	owLJbhuMLA2aQuAp9sirmZU1NDpQ8H5yOmwaXBNVBlZre/sUVBTJT1lOY/CBIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713346446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XPc4/z3TTkt+0V8zuUS+V5Q4uGmxbl3sXcnzTTjUGRs=;
	b=bFVMEgX7rGMbV55a4BYYEzQZAQ//uefdJFv1ZjG24nzfdPRkmMI5LENm0cNAcxgllYl6m7
	aZZPih1weOeMYRDQ==
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 0/2] wifi: rtl8xxxu: WPA3 support
Date: Wed, 17 Apr 2024 11:33:50 +0200
Message-Id: <20240417093352.1840632-1-martin.kaistra@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As discussed in [1], here are the new patches for supporting WPA3 SAE in
the rtl8xxxu driver. Tested with 8188fu.

[1] https://lore.kernel.org/linux-wireless/eefdf5e598eb4e758130d416793ad9d7@realtek.com/

Martin Kaistra (2):
  Revert "wifi: rtl8xxxu: enable MFP support"
  wifi: rtl8xxxu: enable MFP support

 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h      | 9 +++++++++
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 6 ++----
 2 files changed, 11 insertions(+), 4 deletions(-)

-- 
2.39.2


