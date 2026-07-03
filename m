Return-Path: <linux-wireless+bounces-38594-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /fp8E8fCR2qFewAAu9opvQ
	(envelope-from <linux-wireless+bounces-38594-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 16:10:15 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A014703461
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 16:10:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=baylibre.com header.s=google header.b=go5yV2l9;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38594-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38594-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC430320724E
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2026 13:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD903DC4A4;
	Fri,  3 Jul 2026 13:49:42 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287303DB960
	for <linux-wireless@vger.kernel.org>; Fri,  3 Jul 2026 13:49:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783086582; cv=none; b=YP2tkd7aOEGjvC4SEK3+VZrCeGelxZoHY8x3L7ICsBI6H5o8WgBTMumcYa5Fy+8v/eUR2O0KWN/0fHxyMGGFoV/LC/i2D8W0w1pLNXe50QBw+4s0RLe8PFvtnPPqZglvZTo8t68T1+L7zscx18T49aqNvUMjEytNkGiThf3e1+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783086582; c=relaxed/simple;
	bh=rLGd2Pd8MmLShYa3ZvB0OTV7Hv5Fpc+zJQhI22xOYss=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VM7WAYJL+QyLic0o1vgIvxsSty7FjpcQeuOuZdMXIzHrTcfo/h3EkdSz1QEA0XrJG+sdGA80ZQ0i7YGncbtWvTSA2fMzwLL20pBxgHwD54JTS/SyMEm4HSGD6F1CpQGH0VOQrkLtGtid01VnDT69jUJFAQ0ybUqvMxQMCJXXWNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=go5yV2l9; arc=none smtp.client-ip=209.85.128.53
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-493ae59eca6so4228475e9.1
        for <linux-wireless@vger.kernel.org>; Fri, 03 Jul 2026 06:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783086578; x=1783691378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cXlZR2C8x2jsfosr+k37xh2mZlyUqZwpGckjky5le04=;
        b=go5yV2l9GiuEig86fxuPbJaeOK559UOQbN4OiriPfZ3rKyyTk9MNgMAWoFnWZrj+0R
         Z3jYbYm42PIoHmAiJ9NctZSXx6VgPKsnfda550oQvqsuXqVtK2gffD0CarKvu224pde2
         uA1VD7n5huLwRD/NHd+O4cSKHS01SiRgojNcAnD4/+gEHBQoOU2peyHCLmmz7f7+1W6e
         ac2knD8LHvy4iL95YQou2uDbnlFQfECIk9KJUBYXFn//+qeOmWtwQQ8fbeGpZSfM+g7M
         FWwqWZ03O032+OkZvsjFPFoq6scDNxdVqMIo1cltN4P14jmL2JGVQc/0AusgcPwoXx4D
         EXxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783086578; x=1783691378;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cXlZR2C8x2jsfosr+k37xh2mZlyUqZwpGckjky5le04=;
        b=aW8HsoxAIf4SR9wh4pzFneqgsgshBAaERBssm4yhUxXOyzqyy950MO0j26I39l4IqJ
         6kjVZAQA/A/8+au7hMHqBWqu9IuDzTKt/b18wmTKosdvAhhOl5ygW4t5HyMdFkuFc/f4
         GvPDc5ql1/2ghKC1Myn/NiX3ITx/9TxN34bEcQRH9CxDMclwP5R4fznulI/KkflQKrRt
         nWPw0vw7pQzAYJJ/NPgM/VZxeoX4YWqhtA7eSnPub0WE7vQ6L5Kx8b8UcvDk4wt1yOIC
         FyY7gy0N54OFeE6fmNbjE+pgU1FGwWr9qEkKtJe8H2bqcOo1LYKRvlArpvnb5Y9Idd20
         PKJQ==
X-Forwarded-Encrypted: i=1; AFNElJ/pZ2vzw9zIl6r/pFU825NWcCh0RZZy7Qfh/Xv9IvyzGhiDSioyEe1TQF2PvRl/SWHyAACf6TSv3A0Fq5oZwQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyP8l6LBxtEyCE25/q0PB2CFhuKIW9GIRa2jR/j/6YQ32HMaKXM
	is9PRZpqwPVt5h/RQhr1tyr6WY4ghRTnfhcapxxkxQmEtrb/CLFZFS9MCbP7d0OshW4=
X-Gm-Gg: AfdE7cn4kxhjelbFYKPU2bbllcaKn/eageDJR9vs1D4IDOGJE5pNlGEhb5Gyaljo98H
	PJn14+Rtb5XuYgft3umsOuJIaS4D4DVKdZlvPLi3U99a+OliPnKLE/mkQmVMn/kf621pMUhLvGe
	7c7/O5X3a5Xsey/PIuVzgFk58qObrWWj8oE1Z/z8O0mpkh22pDO2be5mrpeqxZaXSbISCF+hJUE
	8zAA0gK8RQFohRc72Z2DsLaiRU6sliyazWWfiNxd63I8QJMniv8/AqJLT3e8IuH1ZLQQT5Mjvmo
	ZCThU+tT82OFHsY8TBnaD0wNYafEjUBbVw5yhrZZsOIewgN8iZ7rE0CeQO2DjWq91DLABEE+ygK
	q0iUp+gcUTqwlDNocF4DTEszQngA+SO49xVRGhcE2IKCK4HIYJoOEkc2ya1qpKP4Vc9ZYGqEzNE
	kbpdE13CtEQxl6AWAZbC3jS8fdcvspjTmlaQSXmi6CHma8oQ==
X-Received: by 2002:a05:600c:19c7:b0:493:b750:bd20 with SMTP id 5b1f17b1804b1-493c3cdd21emr127140605e9.15.1783086577715;
        Fri, 03 Jul 2026 06:49:37 -0700 (PDT)
Received: from arnold.baylibre (88-127-129-70.subs.proxad.net. [88.127.129.70])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-493bef23feasm169768685e9.2.2026.07.03.06.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 06:49:35 -0700 (PDT)
From: Corentin Labbe <clabbe@baylibre.com>
To: stf_xl@wp.pl
Cc: linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] net: wireless: ralink: RT2X00: init EEPROM properly
Date: Fri,  3 Jul 2026 13:49:32 +0000
Message-Id: <20260703134932.3786771-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-38594-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stf_xl@wp.pl,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:clabbe@baylibre.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[clabbe@baylibre.com,linux-wireless@vger.kernel.org];
	FREEMAIL_TO(0.00)[wp.pl];
	DMARC_NA(0.00)[baylibre.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clabbe@baylibre.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[baylibre.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,baylibre.com:from_mime,baylibre.com:email,baylibre.com:mid,baylibre.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9A014703461

I have an hostapd setup with a
01:00.0 Network controller: Ralink corp. RT2790 Wireless 802.11n 1T/2R PCIe

The setup work fine on 6.18.26-gentoo
It breaks on 6.18.33-gentoo (and still broken on 6.18.37)

I found an hint in dmesg:
On 6.18.26-gentoo I see:
May 31 15:48:45 trash01 kernel: ieee80211 phy0: rt2x00_set_rf: Info - RF chipset 0003 detected
On 6.18.33-gentoo I see:
May 31 15:22:57 trash01 kernel: ieee80211 phy0: rt2x00_set_rf: Info - RF chipset 0006 detected

The RF chipset seems badly detected.

The problem was the EEPROM which was badly initialized.
Probably the origin was in some PCI change but unfortunately I couldn't play
to bisect/reboot often the board with this card to do it.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/net/wireless/ralink/rt2x00/rt2400pci.c | 2 +-
 drivers/net/wireless/ralink/rt2x00/rt2500pci.c | 2 +-
 drivers/net/wireless/ralink/rt2x00/rt2800pci.c | 2 +-
 drivers/net/wireless/ralink/rt2x00/rt61pci.c   | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2400pci.c b/drivers/net/wireless/ralink/rt2x00/rt2400pci.c
index 42e21e9f303b..15073b856adf 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2400pci.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2400pci.c
@@ -1429,7 +1429,7 @@ static irqreturn_t rt2400pci_interrupt(int irq, void *dev_instance)
  */
 static int rt2400pci_validate_eeprom(struct rt2x00_dev *rt2x00dev)
 {
-	struct eeprom_93cx6 eeprom;
+	struct eeprom_93cx6 eeprom = {};
 	u32 reg;
 	u16 word;
 	u8 *mac;
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2500pci.c b/drivers/net/wireless/ralink/rt2x00/rt2500pci.c
index 36ddc5a69fa4..3536a0f31117 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2500pci.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2500pci.c
@@ -1555,7 +1555,7 @@ static irqreturn_t rt2500pci_interrupt(int irq, void *dev_instance)
  */
 static int rt2500pci_validate_eeprom(struct rt2x00_dev *rt2x00dev)
 {
-	struct eeprom_93cx6 eeprom;
+	struct eeprom_93cx6 eeprom = {};
 	u32 reg;
 	u16 word;
 	u8 *mac;
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800pci.c b/drivers/net/wireless/ralink/rt2x00/rt2800pci.c
index 14c45aba836f..853fd31d1362 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800pci.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800pci.c
@@ -108,7 +108,7 @@ static void rt2800pci_eepromregister_write(struct eeprom_93cx6 *eeprom)
 
 static int rt2800pci_read_eeprom_pci(struct rt2x00_dev *rt2x00dev)
 {
-	struct eeprom_93cx6 eeprom;
+	struct eeprom_93cx6 eeprom = {};
 	u32 reg;
 
 	reg = rt2x00mmio_register_read(rt2x00dev, E2PROM_CSR);
diff --git a/drivers/net/wireless/ralink/rt2x00/rt61pci.c b/drivers/net/wireless/ralink/rt2x00/rt61pci.c
index d1cd5694e3c7..5dca2afb4b96 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt61pci.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt61pci.c
@@ -2298,7 +2298,7 @@ static irqreturn_t rt61pci_interrupt(int irq, void *dev_instance)
  */
 static int rt61pci_validate_eeprom(struct rt2x00_dev *rt2x00dev)
 {
-	struct eeprom_93cx6 eeprom;
+	struct eeprom_93cx6 eeprom = {};
 	u32 reg;
 	u16 word;
 	u8 *mac;
-- 
2.53.0


