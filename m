Return-Path: <linux-wireless+bounces-30614-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3674D0CD04
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Jan 2026 03:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7282C30052FF
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Jan 2026 02:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6BB4A02;
	Sat, 10 Jan 2026 02:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Fyti+ZPB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9569A1FE47B
	for <linux-wireless@vger.kernel.org>; Sat, 10 Jan 2026 02:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768011624; cv=none; b=YQqBwB3dBKdIR4GEJUxcv92LlVFsAHKpUFv6wXan2aP+QYvFbDbgD5Ms66+tBmW289LoS2SQV7ts615TTWjWConeXADjxfXSOlcM7uRc+DKPOPy1PB0okGEdOAXye08SOrJ8KY49cfLdfEPrguj4+4BNroV4jHTQJX4sH159wCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768011624; c=relaxed/simple;
	bh=9vVXoUglmXlqZqI8GEGtngdActA/GHeVFpz++dc9uLg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e6BL95MwaZVD/3haY3VY7YFWyfe/HBGnBjjHDkx6BPC3ixwGZwT0BLqrp/GAsTlee7RLqB8GI/rlq5HxaufPP5OlA91rcxdXaRNFVfFNsUwO6xi3BQe+wC4AOw4L+tedrUHWGutMEN3d7rOen09zD2zSwynKxNqZf/7GqVFtzRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Fyti+ZPB; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60A2KKAw8241710, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1768011620; bh=iQjgIVYRkj8Lj8i2hWO42k3XDBobu2Zto6GstWRv6qI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=Fyti+ZPBKAGtN50EsmpXapU+4wEXO549GsLumGtjRPtijc3GqcxhrXBCwHAtMYzeW
	 KsdBpYAxseUQCvSX/r8EzncFCwp8Gt+RUGkSrGvS+BhxFu4c0T8yvhIEM6BolvWl15
	 b0gOnztnKxtK8h8tVwoxPp88HMzpUK5+J7ZKWfkd3wdqL2OakikHEwHro+sCYSJXKJ
	 d6rMRDsm1xuqopX5McFmDKzy2XVdK8Lgdh+rgF1mLAvQlhcMXoZpbP0EYP5PRacSVO
	 FoqfBFOvOSAQLrI4NtDVHOm0IZwvXE8vQaoKH+QjLvajTGSfOXHw9jOs9UZIdhQ4Dl
	 oMSBLkDMjFvFw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60A2KKAw8241710
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Sat, 10 Jan 2026 10:20:20 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Sat, 10 Jan 2026 10:20:20 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Sat, 10 Jan 2026 10:20:19 +0800
Received: from [127.0.1.1] (172.21.40.76) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Sat, 10 Jan 2026 10:20:19 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <damon.chen@realtek.com>
Subject: [PATCH rtw-next 0/8] wifi: rtw89: fix settings and add MAC/PCI common flow for RTL8922D
Date: Sat, 10 Jan 2026 10:20:11 +0800
Message-ID: <20260110022019.2254969-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

First 6 patches are to fix/refine settings of MAC/PCI/WoWLAN. The last two
patches are hardware settings in MAC/PCI common flow to support RTL8922D.

Chin-Yen Lee (1):
  wifi: rtw89: wow: add reason codes for disassociation in WoWLAN mode

Kuan-Chung Chen (1):
  wifi: rtw89: support EHT GI/LTF setting

Ping-Ke Shih (6):
  wifi: rtw89: pci: validate sequence number of TX release report
  wifi: rtw89: disable EHT protocol by chip capabilities
  wifi: rtw89: align CUSTID defined by firmware
  wifi: rtw89: mac: correct page number for CSI response
  wifi: rtw89: mac: consider RTL8922D in MAC common flow
  wifi: rtw89: pci: consider RTL8922D in PCI common flow

 drivers/net/wireless/realtek/rtw89/core.c   |   2 +-
 drivers/net/wireless/realtek/rtw89/core.h   |  17 +-
 drivers/net/wireless/realtek/rtw89/fw.h     |   4 +
 drivers/net/wireless/realtek/rtw89/mac.c    |   5 +
 drivers/net/wireless/realtek/rtw89/mac_be.c | 182 +++++++++++++--
 drivers/net/wireless/realtek/rtw89/pci.c    |   7 +-
 drivers/net/wireless/realtek/rtw89/pci.h    |  31 +++
 drivers/net/wireless/realtek/rtw89/pci_be.c | 125 +++++++++--
 drivers/net/wireless/realtek/rtw89/phy.c    |  28 ++-
 drivers/net/wireless/realtek/rtw89/reg.h    | 231 ++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/wow.c    |   4 +
 drivers/net/wireless/realtek/rtw89/wow.h    |   1 +
 12 files changed, 577 insertions(+), 60 deletions(-)


base-commit: 5fbc19b0f62b21abfef55c55258146bc014ba3f9
-- 
2.25.1


