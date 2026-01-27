Return-Path: <linux-wireless+bounces-31205-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EP3uA+d8eGkFqQEAu9opvQ
	(envelope-from <linux-wireless+bounces-31205-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 09:52:55 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C7B914E9
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 09:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2993D304FC20
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 08:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46FB2FD691;
	Tue, 27 Jan 2026 08:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="O4qewdDA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEB2149C6F
	for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 08:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769503881; cv=none; b=HBtw+oGcO9K9kEZfFm1A5GTCeLTCUmF/F/GWX0Ki8f60MIn5Vxyr4EgMsa+sUX2aAJRj5k9BaAme/bqTRz6hiG0eDLLL/OJLMyMAylIMxSivzICnA0vnpfX8l42vMKTgpqJT30DjkqN7rwLkgmbrA5zOEuuNd/rdQAB+Mhq2EFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769503881; c=relaxed/simple;
	bh=4TjYWCXej9nlg+k5GSM9cKYzP3mxZhe5JORjb5l1ayk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PqREsXglepYwg/3KdwvXoRGr60t6PuMDl1JkdstioU08cvrDbfCygcqqczMPMszwF3KX0JujhycOB57xhMFoXJ4iGQSvr1d7jIGlX0D8FcEqhGwpKgH8KopWXQteDimfwWwYiiS4jOw0f/nUNHgR7A9ZfQ06Vy+CtKOq0Q7sSS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=O4qewdDA; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60R8pHR412655454, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1769503877; bh=mVB49HjsfAteSsZnoj9YD1laZoL2K5wNXDuWWg/0NE4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=O4qewdDAST/Flix3NKNe12d9U5JgluCtCFqNpnlkyo69MijcRyswEVtst6K9xpkK4
	 okU4oTf4G13++WWfysek+Vx1FzJoFPlbZenh0fa7P22mZojlCu/f80nzAv8mloPXHf
	 bej3oWHCEnCe+JRDk+E6WJ6HIyLDTXJlpEnKH7nWwTp8LGeCuGDySPA3osQuAXvutk
	 XX5WNslFfs/UaEkXS9CgBfYTJS/Xd+/gvxQ91yQSf/nobNrFyvLkId3/am4QsT5IbI
	 ESmgr4I9aIJkKeWqiQmP7IyQpkBf+ZUG2om075UfKQfYkJgi7u7MaPU0oVtjpDy24J
	 VvRzbSu2AaeJQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60R8pHR412655454
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 16:51:17 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 27 Jan 2026 16:51:16 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Tue, 27 Jan 2026 16:51:16 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <dian_syuan0116@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 0/6] wifi: rtw89: update fw crash simulation and settings of MAC and PCI
Date: Tue, 27 Jan 2026 16:50:30 +0800
Message-ID: <20260127085036.44060-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31205-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[realtek.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realtek.com:mid,realtek.com:dkim]
X-Rspamd-Queue-Id: 65C7B914E9
X-Rspamd-Action: no action

Update to simulate firmware crash via debugfs to ensure we can recovery
connection in field by first two patches. The later four patches are
to set proper settings to MAC and PCI.

Chih-Kang Chang (1):
  wifi: rtw89: wow: disable interrupt before swapping FW for 8922D

Dian-Syuan Yang (1):
  wifi: rtw89: pci: restore LDO setting after device resume

Ping-Ke Shih (2):
  wifi: rtw89: mac: set MU group membership and position to registers
  wifi: rtw89: pci: warn if SPS OCP happens for RTL8922DE

Zong-Zhe Yang (2):
  wifi: rtw89: debug: rename mac/ctrl error to L0/L1 error
  wifi: rtw89: debug: tweak Wi-Fi 7 SER L0/L1 simulation methods

 drivers/net/wireless/realtek/rtw89/debug.c  | 89 ++++++++++++++++-----
 drivers/net/wireless/realtek/rtw89/mac.c    | 21 +++--
 drivers/net/wireless/realtek/rtw89/mac.h    |  6 ++
 drivers/net/wireless/realtek/rtw89/mac_be.c |  7 ++
 drivers/net/wireless/realtek/rtw89/pci.c    | 11 ++-
 drivers/net/wireless/realtek/rtw89/pci.h    |  1 +
 drivers/net/wireless/realtek/rtw89/pci_be.c |  2 +
 drivers/net/wireless/realtek/rtw89/reg.h    | 17 ++++
 drivers/net/wireless/realtek/rtw89/wow.c    |  6 +-
 9 files changed, 128 insertions(+), 32 deletions(-)


base-commit: 8da7e88682d58a7c2e2c2101e49d3c9c9ac481b0
-- 
2.25.1


