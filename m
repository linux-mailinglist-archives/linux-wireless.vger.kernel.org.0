Return-Path: <linux-wireless+bounces-12525-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 570CB96CFE9
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 09:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9F0EB219C7
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 07:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F81179647;
	Thu,  5 Sep 2024 07:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=email.cz header.i=@email.cz header.b="oRiRy1fm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mxc.seznam.cz (mxc.seznam.cz [77.75.79.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CAA14EC4B
	for <linux-wireless@vger.kernel.org>; Thu,  5 Sep 2024 07:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.75.79.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725519710; cv=none; b=CDd6Tla1J9NxSbKMj7RLpeiz/BFQKhcMMP8hAEV+v4zRYdabvDk+HFAivSuuamLSZTcu1c5eqeYkpbNJP1f09Ro3jNyhSYH4YMSrKEw97cXaoNDUcJAxvj3i1Fu3+5r2vNFHA2+LNvvnJ4BPeM/0zYXuz7xtKeAajIWrCCplcwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725519710; c=relaxed/simple;
	bh=W1+MwjoVoluw7QfmKw1jVOX80+0+njswzZcAg5w7SGY=;
	h=From:To:Cc:Subject:Date:Message-Id:Mime-Version:Content-Type; b=D9NbZqA3el0Z97u+ED17RI/gtHkZMuo30Nko3KHC0LDXrLxP1BYnBWIq/CxaZHygPkkBbZf1yyW0bB+bXlLgmDLbpJ9txJBXx3UG4zNv+Fyy56lIYf85EA6y+hPHqPDeA0+IuJnuj7etCtI112Vr0leOEMAwWkIOJrJyvpj90/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.cz; spf=pass smtp.mailfrom=email.cz; dkim=pass (2048-bit key) header.d=email.cz header.i=@email.cz header.b=oRiRy1fm; arc=none smtp.client-ip=77.75.79.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=email.cz
Received: from email.seznam.cz
	by smtpc-mxc-5574d8dd45-2x2p7
	(smtpc-mxc-5574d8dd45-2x2p7 [2a02:598:64:8a00::1000:42b])
	id 471497d7b9e0257d479a19cf;
	Thu, 05 Sep 2024 09:01:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cz;
	s=szn20221014; t=1725519699;
	bh=SZaUZJvsdIWhS1K/dgwL2jdjDotmUTvANn02yFr4oHI=;
	h=Received:From:To:Cc:Subject:Date:Message-Id:Mime-Version:X-Mailer:
	 Content-Type:Content-Transfer-Encoding;
	b=oRiRy1fmyxQ5OF7DrSNBB/VgKDqCCH+WcdITga2Wma1bjjIteXJXshwTqRRRvGOlF
	 2TlkaUtT690MId+WKUjuy0QANFeAupocY4C5fylSV9V66EJlgoREfVv+9PQUhNj3Iy
	 DDcZaFZ2qvu6FMIPggTDBVGO1+if7qiVHCA0VM5Wn3Yk6i6TfettYN0r5xAzmgPGkv
	 mBrbSKNNUbdugu6GgnhXb8vrLToNdEf3gOj815zRUMW37pIPqPNY+CnPcKe4xgzE4J
	 0uk1WfMp6IxeP6Z92fkuN56oKoZk8BwXHKuMy0fBBSuqft7tn+UhZStucZnV2fYkwI
	 UjaDueVAPdGYA==
Received: from 215-143.ktuo.cz (215-143.ktuo.cz [82.144.143.215])
	by email.seznam.cz (szn-UNKNOWN-unknown) with HTTP;
	Thu, 05 Sep 2024 08:59:45 +0200 (CEST)
From: "Tomas Paukrt" <tomaspaukrt@email.cz>
To: <ath10k@lists.infradead.org>
Cc: <linux-wireless@vger.kernel.org>
Subject: [PATCH v2] wifi: ath10k: add USB device ID for Atheros QCA9377-7 
Date: Thu, 05 Sep 2024 08:59:45 +0200 (CEST)
Message-Id: <5Jj.Zbdh.4ausKfY}jbL.1csLRX@seznam.cz>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (szn-mime-2.1.61)
X-Mailer: szn-UNKNOWN-unknown
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

Add USB device ID for modules based of Atheros QCA9377-7 chipset like
8devices BLUE bean or SparkLAN WUBQ-159ACN.

Tested-on: QCA9377 hw1.1 USB 0.0.0.111

Signed-off-by: Tomas Paukrt <tomaspaukrt@email.cz>
---
 drivers/net/wireless/ath/ath10k/usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath10k/usb.c b/drivers/net/wireless/=
ath/ath10k/usb.c
index 3b51b7f..60441ff 100644
--- a/drivers/net/wireless/ath/ath10k/usb.c
+++ b/drivers/net/wireless/ath/ath10k/usb.c
@@ -1106,6 +1106,7 @@ static int ath10k_usb_pm_resume(struct usb_interface=
 *interface)
 
 /* table of devices that work with this driver */
 static struct usb_device_id ath10k_usb_ids[] =3D {
+	{USB_DEVICE(0x0cf3, 0x9378)}, /* Atheros QCA9377-7 */
 	{USB_DEVICE(0x13b1, 0x0042)}, /* Linksys WUSB6100M */
 	{ /* Terminating entry */ },
 };
-- 
2.7.4
 

