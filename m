Return-Path: <linux-wireless+bounces-34727-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yP+9AVbd3WlwkQkAu9opvQ
	(envelope-from <linux-wireless+bounces-34727-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 08:23:18 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4213F5E9E
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 08:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69DC43030133
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 06:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2478634B1A7;
	Tue, 14 Apr 2026 06:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="XWvxEvkc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDDE33AD9A
	for <linux-wireless@vger.kernel.org>; Tue, 14 Apr 2026 06:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776147770; cv=none; b=FZBCBVeMgHRrOL9UXfnNnEjULigReLelc07FRXeXd6RhtizjAisJsPAET9EaXs/ZpDEyK219VyKxBr7GQN7JTAtrTqjeFJJ7rNMsBP5JRniSqcXx4gsoshzoFgR9Lu0J7NFl55YOGpndkFWFDkbRZEY3raYgMWbjHt+9IGYQnxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776147770; c=relaxed/simple;
	bh=sggiDGSxZLqniiVbUvw0g8ARFTDB+hTXjY63jFp5Sas=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kB5GL2nr2sm1vnLrnDp3ihPw3m4pPDHp3CArniv/CA3C0trKULsDht6NddAC+Ip0Nr5WPfXP880Pd/hb92Givhpk+d4WgqYrU8l3+XGlg+6j6MVcvhjXE5F1DBPTNVTSolAtbcLDEIejFIgHJfGHH3koAe3Mg0OkTZAYGjCjVUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=XWvxEvkc; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63E6MhpoE1508631, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1776147763; bh=FYbgT9bewEC4dCVjX973PjMtrVsBXJL9/e+ZHGLQ6t4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=XWvxEvkcNOl0rc8RwBs2kAsQ6SyBpdp+S3r+dZAS6hH/z5MUgR9/zZ0eDtkIUaNkG
	 p0h8WO83McLYXcs3Bf9BNE5oGB7jIi0uf5ecqPMD03cwqwaOapgifaXp/+4bl0etIw
	 dqePNTs5nTOpN2ds6Jdf6WQb9dpebw0gXhQYVGs2E9XbDyWC0pUiMzUge8Le0p3S7r
	 vQOkJ8ISpq4sTNTqvNx3a8XqAwhoBM+aAxWlqCUjehK+DOR/kx2T7/CBHXccvEB61q
	 eh+iVVERR9BYkK3PKMcedct0XyoIcLCFVpeNoOtZy/8G8qA5Wc7kHBi4JtsqV3iWWQ
	 OQfVGmi7RUyfg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 63E6MhpoE1508631
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Apr 2026 14:22:43 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 14 Apr 2026 14:22:43 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 14 Apr 2026 14:22:43 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Tue, 14 Apr 2026 14:22:43 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <Jes.Sorensen@gmail.com>
Subject: [PATCH rtw-next 0/3] wifi: rtl8xxxu/rtlwifi: validate action frame size
Date: Tue, 14 Apr 2026 14:22:26 +0800
Message-ID: <20260414062229.21047-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34727-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.987];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8F4213F5E9E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

As mentioned by Johannes [1], some where of rtl8xxxu and rtlwifi check
fields of action frame without checking size. Refine the code to check
size by IEEE80211_MIN_ACTION_SIZE() before using.

[1] https://lore.kernel.org/linux-wireless/d4e7f2ec4a7def5820eb41e84ed0815e159cf39b.camel@sipsolutions.net/

Ping-Ke Shih (3):
  wifi: rtl8xxxu: validate action frame size before using in
    rtl8xxxu_dump_action()
  wifi: rtlwifi: validate action frame size in rtl_action_proc()
  wifi: rtlwifi: validate action frame size before using in
    _rtl_pci_tx_isr()

 drivers/net/wireless/realtek/rtl8xxxu/core.c | 13 +++++++++++--
 drivers/net/wireless/realtek/rtlwifi/base.c  | 17 ++++++++++-------
 drivers/net/wireless/realtek/rtlwifi/pci.c   |  7 ++++---
 3 files changed, 25 insertions(+), 12 deletions(-)


base-commit: fa489a77e3267e05df95db96ba98e141ec07cbd9
-- 
2.25.1


