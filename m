Return-Path: <linux-wireless+bounces-33756-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMCxN1Euwml5ZwQAu9opvQ
	(envelope-from <linux-wireless+bounces-33756-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 07:25:21 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E985C302D71
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 07:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6E32F30367B3
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 06:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3ED2BD5B4;
	Tue, 24 Mar 2026 06:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="DQGZdb5i"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2B161FFE
	for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 06:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774333271; cv=none; b=kxDv+CT28MTMTC4iUQMCw6ySnxw6uwz/ikYmTJB+HHYnKbtHJXYO1+i4aQv5UFYOQwB3hcfEqtPSu8FAV3tdmJ2TPyRZxUFAf6T67e9H+YYjIpPbLnHJ83C+PGIxsydGm0u4U1Bt6cBeO2QhXRzYOhUx1LAEiDKkFCMzHEuwrDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774333271; c=relaxed/simple;
	bh=u114S0MnCiVi7q7lbF1zFXTxyhKmOE8XeCINYp7AdkQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OJtmGHebE3BfpfnAl6b35wuChxxXDgQq/TY1tN/3PHVnJFhJiJDewWOMLlBMYu8KiKyhPnMoVyrFp82SyZCH7sbDgGv/QPkjncG8ib9rhhUlSDeKkJd6Xw8AOwAbyWcBsACc1KjgfEz7Kb+r1RGqOQ9/iqnDA6C1w+SdKe/Fhdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=DQGZdb5i; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62O6L7CZ0557160, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774333267; bh=cDOeUlZtz8e0ZhbXgAxE060HOqd6I26F7SmXICc9QcI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=DQGZdb5i8jRtaK4D9NzRla6kGQ5+fQQd7x1mtwcSfWvWQayNRbtoEQ5RhWnH5moH5
	 9eVJVYzemW9SihffpmVd0qU/sFXRltkJBESf6Myu66Z6+bkznagy+PKYCB/bJ9umeb
	 hniBh+d/EYUBa0CpTUoAoV8LfsvsFLybKjPXH6w3Qibmt10zoDPG7vGd7YPNyvr0kL
	 6hKanaz/DfethBOjZjDreLA2cN30evT6iG9mcFdr5dO4mlOIXKAbo+DSY/VSX3y/RZ
	 oherx8FPCCyxUtXA3TaJtdrIjks8gkGUq0gydMAoMvRyye6gNr4miSSsFur+kFxSz6
	 H2XXPTOsXD+WA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62O6L7CZ0557160
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 14:21:07 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 24 Mar 2026 14:21:07 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Tue, 24 Mar 2026 14:21:07 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 rtw-next 0/7] wifi: rtw89: 8922d: add RTL8922D common routine part 1
Date: Tue, 24 Mar 2026 14:20:42 +0800
Message-ID: <20260324062049.52266-1-pkshih@realtek.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33756-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,realtek.com:dkim,realtek.com:mid]
X-Rspamd-Queue-Id: E985C302D71
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patchset is to add RTL8922D common routines. As the code is not small,
I split it into two parts, and this is the first part.

At this first part, add memory arrangement called quota, power on/off
functions, functions related to calibration data in efuse, and the
main set channel function.

v2:
 - correct NBI register in patch 6/7

Ping-Ke Shih (7):
  wifi: rtw89: 8922d: add definition of quota, registers and efuse block
  wifi: rtw89: 8922d: add power on/off functions
  wifi: rtw89: 8922d: define efuse map and read necessary fields
  wifi: rtw89: 8922d: read and configure RF by calibration data from
    efuse physical map
  wifi: rtw89: 8922d: add set channel of MAC part
  wifi: rtw89: 8922d: add set channel of BB part
  wifi: rtw89: 8922d: add set channel of RF part

 drivers/net/wireless/realtek/rtw89/core.h     |    7 +
 drivers/net/wireless/realtek/rtw89/reg.h      |  160 +-
 drivers/net/wireless/realtek/rtw89/rtw8922d.c | 1755 +++++++++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8922d.h |   80 +
 .../net/wireless/realtek/rtw89/rtw8922d_rfk.c |   33 +
 .../net/wireless/realtek/rtw89/rtw8922d_rfk.h |   14 +
 6 files changed, 2048 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8922d.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8922d.h
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8922d_rfk.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8922d_rfk.h


base-commit: eef6d4449e8a540fde792968a26d8aa514af8089
-- 
2.25.1


