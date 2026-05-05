Return-Path: <linux-wireless+bounces-35909-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBhOCUv4+WmNFgMAu9opvQ
	(envelope-from <linux-wireless+bounces-35909-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 16:01:47 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0785C4CEFBA
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 16:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6EBA93054B91
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2026 14:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E7647F2D1;
	Tue,  5 May 2026 14:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.in header.i=linuxuser509@zohomail.in header.b="wb5ObDH/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender-pp-o92.zoho.in (sender-pp-o92.zoho.in [103.117.158.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A5531E82F;
	Tue,  5 May 2026 14:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=103.117.158.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777989632; cv=pass; b=pAqT/hnHGxWx3aS/0hgvTCScIFE2e9XLttQwMq78oCVHkYRhjTZHFUhWeFiNNk7yNGlBtdizjIscQ/P8HrcnRcnl0FwA/UPAC/ZncQZAmylCq4S0f+7EhmIZneA64oymtTbwLWSUdlay3g+/jgsC1FYDm/fNxGvzzkotwpEPmgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777989632; c=relaxed/simple;
	bh=hZDd/B8MVKr3KXbKnFlNe8mq6LCQ46OaDhXyOjyCZv0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=JhykBcYCX80yJ/QYNbOYKuXnjkiP076RLxGw+5wy+W4AVb39ULXEc8E5n7VD9i3NauWEe3heNSzSbQshY8AhoAkV3guCz5Fz3mrRQ5Yi4eYp9DV66ev6DlL3GZnW1Qw7j5x6E3aPSsIEEzO1ozn4iGit3xZk0AASotsXNawnWg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in; spf=pass smtp.mailfrom=zohomail.in; dkim=pass (1024-bit key) header.d=zohomail.in header.i=linuxuser509@zohomail.in header.b=wb5ObDH/; arc=pass smtp.client-ip=103.117.158.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.in
ARC-Seal: i=1; a=rsa-sha256; t=1777989610; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=Xq4CEeErgnjqRxY9xL6yv7IEAGmFSH0w2bVWkjixA1wdmpicXplWKIUePI3x2e29GWltgwTNG276N+UaRfN4vOITLApMKOJljo6GHkA2NYDjZ7+AlkOvd+4KOV6tsPz5yeQ390Q03e4/8uTSlETzni6HSqsELWn/TdvFRq/9hmk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1777989610; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=vBWmDE9lnw/EJ7pZHpUuApAxQJ/OiGKqeCkoLQzTpjg=; 
	b=ZgXNqcmBgOb0FotKBa0RvubHC1mDVQuKFpxqU0HDszMSB47Lh+Ul650ot6WBWRaNjMZRjBlN0AhsogOjpRWH+mwk59nufcPFs9Qjp8QbTiPHZSYucl9FfiB5yBAJgFORXL4Um2JTJI8bNUYOWQ7loJUF8YuZqwC8jGFIwpG2rYk=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=zohomail.in;
	spf=pass  smtp.mailfrom=linuxuser509@zohomail.in;
	dmarc=pass header.from=<linuxuser509@zohomail.in>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1777989610;
	s=zoho; d=zohomail.in; i=linuxuser509@zohomail.in;
	h=Message-ID:Date:Date:MIME-Version:To:To:Cc:Cc:From:From:Subject:Subject:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=vBWmDE9lnw/EJ7pZHpUuApAxQJ/OiGKqeCkoLQzTpjg=;
	b=wb5ObDH/kvef4BMSbI7pa2mX8SJ/oS0pSnhEm1be5mcK+t13GxuQ1TWoXToCs6uK
	CCf4q8GYxzbYZvnC0+0Emi/BMytHJxGBnJKfibtbz8wdEg1+zs5cHgzpsBq826VVU3p
	DMid7dtxELjlN0akdV4v77RtvEfV2fS2Ee4hBwIY=
Received: by mx.zoho.in with SMTPS id 1777989603442122.78760196500764;
	Tue, 5 May 2026 19:30:03 +0530 (IST)
Message-ID: <bbce7585-aa31-475f-98be-4151e7b18bcf@zohomail.in>
Date: Tue, 5 May 2026 19:29:54 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: miriam.rachel.korenblit@intel.com, johannes.berg@intel.com
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
From: Ashwin Gundarapu <linuxuser509@zohomail.in>
Subject: [PATCH] wifi: iwlwifi: add retry loop for firmware reload on resume
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Rspamd-Queue-Id: 0785C4CEFBA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[zohomail.in,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[zohomail.in:s=zoho];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[zohomail.in:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35909-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linuxuser509@zohomail.in,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zohomail.in:email,zohomail.in:dkim,zohomail.in:mid]

 From 48670d4341d2a9187e8368a2a929d155c4ffd003 Mon Sep 17 00:00:00 2001
From: Ashwin Gundarapu <linuxuser509@zohomail.in>
Date: Tue, 5 May 2026 19:12:48 +0530
Subject: [PATCH] wifi: iwlwifi: add retry loop for firmware reload on resume

After suspend, the PCIe link may not be fully ready when the driver
attempts to reload firmware. This causes iwlwifi to fail silently,
leaving users with no WiFi until reboot.

Add a retry loop that attempts firmware reload up to 3 times with
a 100ms delay between attempts, replacing the previous single attempt
that the code itself described as 'hope for the best here.'
---
  drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 16 +++++++++++-----
  1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c 
b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index dc99e7ac4726..2208b06d7e63 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1257,14 +1257,20 @@ static int _iwl_pci_resume(struct device 
*device, bool restore)

         if (restore || device_was_powered_off) {
                 trans->state = IWL_TRANS_NO_FW;
-               /* Hope for the best here ... If one of those steps fails we
-                * won't really know how to recover.
+               /* Retry firmware reload up to 3 times.
+                * The PCIe link may not be fully ready on the first attempt
+                * after resume, causing iwlwifi to fail silently.
                  */
-               iwl_pcie_prepare_card_hw(trans);
-               iwl_trans_activate_nic(trans);
+               int retry;
+               for (retry = 0; retry < 3; retry++) {
+                       iwl_pcie_prepare_card_hw(trans);
+                       iwl_trans_activate_nic(trans);
+                       if (trans->state != IWL_TRANS_NO_FW)
+                               break;
+                       msleep(100);
+               }
                 iwl_op_mode_device_powered_off(trans->op_mode);
         }
-
         /* In WOWLAN, let iwl_trans_pcie_d3_resume do the rest of the 
work */
         if (test_bit(STATUS_DEVICE_ENABLED, &trans->status))
                 return 0;

base-commit: 26fd6bff2c050196005312d1d306889220952a99
prerequisite-patch-id: 039ce4200f5ab50b86e8ef1fea9d93294ae43517
-- 
2.43.0


