Return-Path: <linux-wireless+bounces-30850-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6BBD292B5
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 00:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B499C301A4BD
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Jan 2026 23:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169F032ED39;
	Thu, 15 Jan 2026 23:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t32smtp-sign002.email header.i=@t32smtp-sign002.email header.b="MtZOd9W3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail50.out.titan.email (mail50.out.titan.email [44.199.128.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28A22E22B5
	for <linux-wireless@vger.kernel.org>; Thu, 15 Jan 2026 23:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.199.128.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768518324; cv=none; b=ihRODReDXixVQQJ4CCcSKRNdiKWjgPPtO815g9taTt4GxC/hHCyCo8BztY4tiRP1HotQzR+XooSl3/qNqlcPMPdtET6tJVvkYDbtJDku8twPvq9sl5m321kLGEQ2SgdCEWYsndpVGdSEtpvdPOfPyPMZyHMV/uz5gyPosfeBYXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768518324; c=relaxed/simple;
	bh=JBziLzgplW9Rb+OfofbHhCL8fLFANbyWji/QKbNSAJY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y/rK8jKuY0dsYZ/UIuZ8Lc9yllLRIIsn3Sc33Brg5fFLgyKx/g32ls/fxlJAtR/4G2HJXR9kFKo4blzCNktNWlglLoiWZVnKrVPjbTG17l2XK2HMOIyTddQPD+YJUe5AffB7gqRJeggBEJ+CTTRu/kXUye/gemWBvtoxhGY/SKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=justthetip.ca; spf=pass smtp.mailfrom=justthetip.ca; dkim=pass (1024-bit key) header.d=t32smtp-sign002.email header.i=@t32smtp-sign002.email header.b=MtZOd9W3; arc=none smtp.client-ip=44.199.128.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justthetip.ca
Received: from localhost (localhost [127.0.0.1])
	by smtp-out.flockmail.com (Postfix) with ESMTP id 4dsdqj6sypz9rwP;
	Thu, 15 Jan 2026 23:05:21 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=z5bcLjX+z802kNjR4LOdA5wcKMd/zpmlijKc3KlYyeA=;
	c=relaxed/relaxed; d=t32smtp-sign002.email;
	h=from:to:cc:message-id:date:mime-version:subject:from:to:cc:subject:date:message-id:in-reply-to:reply-to:references;
	q=dns/txt; s=titan1; t=1768518321; v=1;
	b=MtZOd9W3COHxmTQjttKe+DOeFr6XbNwIc+ICcyKV61jl67mSY/mdC8qLDO4YTN+RzcclNFnK
	rV69KsKMJiSkxPeDFRScQYDCoGSfbqj//+botktWvcq/vTti5m4I4IwczyXnXkPisMuyo67doNf
	VeQ8tlqwv1bhzW3dG6rUQH+M=
Received: from fedora (unknown [94.156.148.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp-out.flockmail.com (Postfix) with ESMTPSA id 4dsdqh5nfzz9rwC;
	Thu, 15 Jan 2026 23:05:20 +0000 (UTC)
Feedback-ID: :lucid_duck@justthetip.ca:justthetip.ca:flockmailId
From: Lucid Duck <lucid_duck@justthetip.ca>
To: nbd@nbd.name,
	lorenzo.bianconi83@gmail.com
Cc: linux-wireless@vger.kernel.org,
	lucid_duck@justthetip.ca
Subject: [PATCH 0/3] wifi: mt76: kernel 6.18 compatibility and txpower reporting fix
Date: Thu, 15 Jan 2026 15:02:49 -0800
Message-ID: <20260115230252.43391-1-lucid_duck@justthetip.ca>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1768518321817393265.13754.5418007250275994005@prod-use1-smtp-out1003.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=TPG/S0la c=1 sm=1 tr=0 ts=696972b1
	a=rfUqlbiNABtMf1sfwYNRFA==:117 a=rfUqlbiNABtMf1sfwYNRFA==:17
	a=CEWIc4RMnpUA:10 a=W56Fk2ypgr_b93J7ouoA:9

This series addresses kernel 6.18 API changes and fixes TX power
REPORTING accuracy for mt7921 (and related connac devices) when
the interface is unassociated.

IMPORTANT: These patches do NOT change actual RF transmit power.
The firmware power tables and regulatory limits remain unchanged.
This only fixes how the driver REPORTS txpower to userspace via
nl80211 (e.g., `iw dev wlan0 info`).

Background
----------
In kernel 6.18, mac80211's __ieee80211_recalc_txpower() returns early
when chanctx_conf is NULL (unassociated interface), leaving
bss_conf.txpower at INT_MIN. This is intentional mac80211 behavior.

However, BSS_CHANGED_TXPOWER is still fired with txpower_type set
correctly but txpower=INT_MIN. Without driver-side handling, this
results in misleading txpower values (3 dBm) reported to userspace.

Testing
-------
Tested on Alfa AWUS036AXML (MT7921AU):

Kernel 6.18.3 (Kali Linux):
- Unassociated: Uses regulatory max for reporting
- Associated: Exact user-requested values work
- Firmware txpower_sku debugfs unchanged

Kernel 6.18.4 (Fedora 43):
- Unassociated: Uses regulatory max for reporting
- Associated (5GHz 80MHz): User values honored correctly
- Firmware txpower_sku debugfs unchanged

Lucid Duck (3):
  wifi: mt76: update timer APIs for kernel 6.18
  wifi: mt76: mt7921: convert to MLO callbacks and fix txpower reporting
  wifi: mt76: connac: preserve txpower_cur in set_rate_txpower

 mt76.h             |  1 +
 mt7615/main.c      |  6 ++--
 mt7615/pci_mac.c   |  4 +--
 mt7615/usb.c       |  2 +-
 mt76_connac_mcu.c  | 13 ++++++-
 mt76x0/eeprom.c    |  2 +-
 mt76x02_eeprom.c   |  2 +-
 mt76x02_usb_core.c |  4 +--
 mt76x2/eeprom.c    |  2 +-
 mt7921/main.c      | 84 +++++++++++++++++++++++++++++++++++-----------
 mt7925/main.c      |  4 +--
 mt792x_core.c      |  6 ++--
 12 files changed, 93 insertions(+), 37 deletions(-)

--
2.52.0


