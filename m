Return-Path: <linux-wireless+bounces-32050-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id /hzoHdQtmGkNCQMAu9opvQ
	(envelope-from <linux-wireless+bounces-32050-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 10:48:04 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F146166673
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 10:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EF52130074CC
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 09:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E897314B91;
	Fri, 20 Feb 2026 09:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="khMD/SJz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CAF2BD030;
	Fri, 20 Feb 2026 09:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771580879; cv=none; b=pMg6VBXPq+MzIJxRRCjnCIQbw47hSTPws93knMYLY8ZOfCGL1c+ZptnI97NufIoX4Dm0edu8sfSaybhca0hGIkof07lQuv9cgQIuYx81c/5yzkFHVxy9ImdEGUvTySQ0Xi5JTyAsVEC2f4XuE2tN8yIwT8erYruotIxDG+BCG7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771580879; c=relaxed/simple;
	bh=LDXix9PN0IinDABVv8UkHXsICzMk77zfNM7DbdoMYVA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qKfaDRhoW3GkB4hAvK++LBIZC4LwPUFg81F2+LwtOKQt0PeN7GKcNTZnF79AmOWhrcsAvwPUMOnKmJALDkpB+CvCx1PFqAS9VXp0SMgypNclhfh8JG5bKNdJXA5cA0foXDxI1+nx73h+kgye0tF8/2ppyCr+g3eMMp/yR3bGops=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=khMD/SJz; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian.lan (unknown [79.139.245.7])
	by mail.ispras.ru (Postfix) with ESMTPSA id 746B440ACE0A;
	Fri, 20 Feb 2026 09:47:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 746B440ACE0A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1771580867;
	bh=uv2nVANfS7S6tqJoCX4h4dxXBtr6Gdnxmxsiz6IGxtc=;
	h=From:To:Cc:Subject:Date:From;
	b=khMD/SJz+Y3W9A/u4yhh7yzz9jtxXADq4YgWLZxModnOdqATzkUfjev/6O61BdveO
	 MNIEwvSDKyUCCJSFVAovu9GAwxbWqDr8huV/SzUELfPY5J8nbPSsiDaqkRwm5tmpB2
	 kcb/SZNT1hxyECrplJI0qjy8w506FZ2LIo4582jE=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Jian-Hong Pan <jhp@endlessos.org>,
	Kalle Valo <kvalo@kernel.org>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH rtw-next] wifi: rtw88: check for PCI upstream bridge existence
Date: Fri, 20 Feb 2026 12:47:30 +0300
Message-ID: <20260220094730.49791-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ispras.ru,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[ispras.ru:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[ispras.ru,endlessos.org,kernel.org,canonical.com,vger.kernel.org,gmail.com,yandex.ru,linuxtesting.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32050-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[ispras.ru:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pchelkin@ispras.ru,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8F146166673
X-Rspamd-Action: no action

pci_upstream_bridge() returns NULL if the device is on a root bus.  If
8821CE is installed in the system with such a PCI topology, the probing
routine will crash.  This has probably been unnoticed as 8821CE is mostly
supplied in laptops where there is a PCI-to-PCI bridge located upstream
from the device.  However the card might be installed on a system with
different configuration.

Check if the bridge does exist for the specific workaround to be applied.

Found by Linux Verification Center (linuxtesting.org) with Svace static
analysis tool.

Fixes: 24f5e38a13b5 ("rtw88: Disable PCIe ASPM while doing NAPI poll on 8821CE")
Cc: stable@vger.kernel.org
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---

I don't have 8821CE but 8822CE instead and I've been able to reproduce the
NULL bridge pointer dereference with rtwdev->chip->id manually adjusted in
the workaround.  Wifi devices happen to be located on a root bus in most
of the systems I have access to.

 drivers/net/wireless/realtek/rtw88/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index 56b16186d3aa..ec0a45bfb670 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -1804,7 +1804,8 @@ int rtw_pci_probe(struct pci_dev *pdev,
 	}
 
 	/* Disable PCIe ASPM L1 while doing NAPI poll for 8821CE */
-	if (rtwdev->chip->id == RTW_CHIP_TYPE_8821C && bridge->vendor == PCI_VENDOR_ID_INTEL)
+	if (rtwdev->chip->id == RTW_CHIP_TYPE_8821C &&
+	    bridge && bridge->vendor == PCI_VENDOR_ID_INTEL)
 		rtwpci->rx_no_aspm = true;
 
 	rtw_pci_phy_cfg(rtwdev);
-- 
2.51.0


