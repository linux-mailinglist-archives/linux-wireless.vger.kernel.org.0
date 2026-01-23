Return-Path: <linux-wireless+bounces-31091-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cA2UNBTScmnKpgAAu9opvQ
	(envelope-from <linux-wireless+bounces-31091-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 02:42:44 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCAB6F3A0
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 02:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9EB11301C8A7
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 01:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5661E37D11A;
	Fri, 23 Jan 2026 01:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="K67Eoll/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6719932FA34
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 01:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769132455; cv=none; b=jHOeBWOR6+JbcELPer9FbhfhWQwA3gRtcKpz5aDd17Ah9uEBZWvA7cynGe8S4/m81hIm+YLuFU5RxXWEkf6FxvzC22Jzj5CUF7jzb1y/QyXyPn9Y0yrK7hmU/34ui1i6p34thxVGZ8rTWy9ZrGlzMtKGGkmQyWJELAIlcoJ2YBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769132455; c=relaxed/simple;
	bh=QtSH6rKk4lZXS3PszAeqmPY9T3Fy5dWs5t5Pa0mmPc4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q+Ai7vwNjqmcK8yWxyNAlneNk//gYMscct+k8L9Xv8erqZFEaANCoa63Ag1Or1YY6K3nOkAxBBakRTyJNP25zWLdqLL1t4qocTV+aR0vTLdKXSanS/NqV8PMarK+W+pInOhHRE57/61Bo9PD7tkg6Fn9cwX4nO7gEzFTlaFqnCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=K67Eoll/; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60N1eYndD2206382, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1769132434; bh=/rB1pPDIQMW5E8CZsZK3eDz2Z8csH+2NFCz5JZEek1Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=K67Eoll/vgp1FSu9H5/V5PigMhKFHtGgyNkIXrPt8KC7OwJQWi6nyfCX/ujzYEfuR
	 BNGs8Wni8iiRXCcLpGc3dewr2IMT8TaUqTBGKjbjW3yNGZ3r7miHg0fg5sDe7TklWk
	 bfAEHT+HL0MoDAqwGn3eUfKHuVfvlcF5f4wWAt68JDtFampzYRF5D2pOE6N7uhIKUI
	 kB4B9J8r8aSxYLSf+AU0rqc6spSkfYYMlu1pICHTAmnrQh5TcVREHPRLGO3kj4+zq1
	 hBYWQfIQqsreKSsYeHWaKXJ0PVbRn8RV3Ivfd/qAk04H07t3XBui2IrEeNuEsBb1AU
	 ljOryFoLTCgsA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60N1eYndD2206382
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 09:40:34 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 23 Jan 2026 09:40:34 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Fri, 23 Jan 2026 09:40:34 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 00/11] wifi: rtw89: update RFK command/report and REGD R73-R54
Date: Fri, 23 Jan 2026 09:39:46 +0800
Message-ID: <20260123013957.16418-1-pkshih@realtek.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31091-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:mid,realtek.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0BCAB6F3A0
X-Rspamd-Action: no action

The first 6 patches are related to RFK (RF calibration) in firmware,
including H2C command to trigger certain RFK and print the report.

The last one is to update the latest REGD along internal update.

Others are random patches to this driver.

Ping-Ke Shih (8):
  wifi: rtw89: rfk: add firmware command to do TX IQK
  wifi: rtw89: rfk: add to print debug log of TX IQK
  wifi: rtw89: rfk: add firmware command to do CIM3K
  wifi: rtw89: rfk: add to print debug log of CIM3K
  wifi: rtw89: rfk: update RFK report format of IQK, DACK and TXGAPK
  wifi: rtw89: fw: correct content of DACK H2C command
  wifi: rtw89: phy: add PHY C2H event dummy handler for func 1-7 and
    2-10
  wifi: rtw89: pci: validate release report content before using for
    RTL8922DE

Zong-Zhe Yang (3):
  wifi: rtw89: 8922a: configure FW version for SIM_SER_L0L1_BY_HALT_H2C
  wifi: rtw89: get designated link to replace link instance 0
  wifi: rtw89: regd: update regulatory map to R73-R54

 drivers/net/wireless/realtek/rtw89/chan.c     |   8 +-
 drivers/net/wireless/realtek/rtw89/fw.c       | 109 ++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/fw.h       | 102 ++++++++++++++--
 drivers/net/wireless/realtek/rtw89/mac80211.c |   4 +-
 drivers/net/wireless/realtek/rtw89/pci.c      |   6 +-
 drivers/net/wireless/realtek/rtw89/phy.c      |  96 +++++++++++++--
 drivers/net/wireless/realtek/rtw89/phy.h      |  15 ++-
 drivers/net/wireless/realtek/rtw89/regd.c     |  20 ++--
 8 files changed, 317 insertions(+), 43 deletions(-)


base-commit: 8da7e88682d58a7c2e2c2101e49d3c9c9ac481b0
-- 
2.25.1


