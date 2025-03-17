Return-Path: <linux-wireless+bounces-20431-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FD6A649D5
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Mar 2025 11:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C914A3B8447
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Mar 2025 10:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746192356B9;
	Mon, 17 Mar 2025 10:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="NA1NfbBf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8982D22F17B;
	Mon, 17 Mar 2025 10:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742206985; cv=pass; b=ZdsDs9F9GBDE3STs/BblVJuV2c1Ca6H0oF1KWbjGuVpFSYL+af353m5+aYyzSzid22Mkh2Urkx2C0cFg2jOYziZ53cOdyUoHIG4Ac2c4FDk0ni5JYf4JQ9U8jizK0lOknPWIC9R+eFgzZJVOR9VmcOD7fFkR0Ort268/ExPI5sY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742206985; c=relaxed/simple;
	bh=XolH65F1l7szuKiPhO962yVmzBfWf5QJ0pfKBmLw/hY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S6iofESSk1WYkMeu9K5ENe2hH/Af25gJbgyxWBJF3ZTu3HVlAVufOvlHmlymZOQwyvP+n2q3dhW0FW40yQFRGjmy9UjhBGKB/TLzRAhoZPrugLgQ+vYHXl4DNechfUF3nDPP/w7daszm71+tlYIiDgqV0suR+mObY+sXZwtLXl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=NA1NfbBf; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1742206973; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Wn8oedazNRVaMAx3l9vI9ODkCDq2sKU2A3F0BqMZLOZoVn09qOtIkpwtGohxxKEk3BKXXKbKRHI6ZvjXivhPFEZbE5ADGQr22F7121u9iupBuhJyZW/uIwgbUvbX+c6udeG7jtxX0V72ZzccYAEx56PUflWl39ZNLyy66bbLvAk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742206973; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=MOZCjnFEPRZ+mZWx5sBcTALXGbiHOgYvrRPV11YeXzk=; 
	b=cAxCSvW0iRMwqp7QQNfSbYHF3qGhHLazXx9QCUUC6MCLPcqiP9iutQRyCssk600v66BJ2pzJRVp8qcgbNrDqcYQzzRjW8aN4QuMULLoKTpT5TLs+UgfReQM7VN0dsgQAHmCzBHgboTcWu6nfUfyZnL0Is2La4v23Whl/vHX+ypk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742206973;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=MOZCjnFEPRZ+mZWx5sBcTALXGbiHOgYvrRPV11YeXzk=;
	b=NA1NfbBfMHYEZYPTuoI19PnRaJRprm/0ESgWpXqfFAr/39phtTloJCcG4Jn8a3Ul
	h9cKpy2PNOUxzTro/2mX5nAoMho8o8j1RwpMaoBJLUHIhYEGhpCBEMwMg129YaWrO1O
	c70fyKawbN0SmPJSgvRJdUUP2BPHJP9P5KxE82AG77Yh0LKcDRC00IJh1nlPRDzsXyE
	O5rFJ7wdHyr+eVHqFiUTrXGVC7EvhY0P95BvnS0pGe05S/g8nJ2pkpNVs8XoO8wjB2t
	x7zTd59YauIuh0XOBIcv4t1jrMGWRKEKL7lOJGBxykQWeeQUW/kZGe5OGSsOa5qLcHB
	b9Z5NtKVXg==
Received: by mx.zohomail.com with SMTPS id 1742206970523335.4972672946949;
	Mon, 17 Mar 2025 03:22:50 -0700 (PDT)
From: Icenowy Zheng <uwu@icenowy.me>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH] wifi: mt76: mt76x2u: add TP-Link TL-WDN6200 ID to device table
Date: Mon, 17 Mar 2025 18:22:35 +0800
Message-ID: <20250317102235.1421726-1-uwu@icenowy.me>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The TP-Link TL-WDN6200 "Driverless" version cards use a MT7612U chipset.

Add the USB ID to mt76x2u driver.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
 drivers/net/wireless/mediatek/mt76/mt76x2/usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
index e832ad53e2393..a4f4d12f904e7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
@@ -22,6 +22,7 @@ static const struct usb_device_id mt76x2u_device_table[] = {
 	{ USB_DEVICE(0x0846, 0x9053) },	/* Netgear A6210 */
 	{ USB_DEVICE(0x045e, 0x02e6) },	/* XBox One Wireless Adapter */
 	{ USB_DEVICE(0x045e, 0x02fe) },	/* XBox One Wireless Adapter */
+	{ USB_DEVICE(0x2357, 0x0137) },	/* TP-Link TL-WDN6200 */
 	{ },
 };
 
-- 
2.48.1


