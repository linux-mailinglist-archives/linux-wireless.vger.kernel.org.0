Return-Path: <linux-wireless+bounces-22196-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09571AA0BAA
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 14:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE3897A2CAD
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 12:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599CC2C2AB0;
	Tue, 29 Apr 2025 12:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="GddofSk+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E70A2C178F;
	Tue, 29 Apr 2025 12:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745929770; cv=none; b=JA/zSFo+1CtfaxZaiEzVdl02rQFUSt7qCFsXSu4Gju0pR1pLaxlTPzuWgKxJvwFd9Im1lTmjGSS+P+H+Cabcgb/7WM7WGnWRjIQABKC/MAY2efn/cE+BEfEFDK0G5O7CX3iSRBr3Lh4zBQwiKa94ZqurAff1Ye2QbsgdoR3MorU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745929770; c=relaxed/simple;
	bh=l9WVZpUe07GworAoOUBdHThkKV12yLAUYvfdH4Ce0+A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p5NJ5KciWSQQJPkzJl0nIfQhrwoBtq/iO0S8npN74SNH1ygxaHCd6+1KzE0nN/BUXQkVrT6kLo80N7dnAQmNrC/wLqUf8hc5sgjZtxazN//7iXL62tytTB0NlvXM4f25tmecsEY9TtqibRfE6me87sculuxRutBZbQT3hDY6imQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=GddofSk+; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1745929764; bh=l9WVZpUe07GworAoOUBdHThkKV12yLAUYvfdH4Ce0+A=;
	h=From:To:Cc:Subject:Date:From;
	b=GddofSk+1YPDb7h8Ohb0gqjdYe6K6yP9JIHC1W1RG/OOBY3OSysTz2IMQxqn1dB42
	 MamLSNnmK1EFLAAO/OFgMAHb4exKOAO9PIhhw5uJNVY7xB1b/AJuHbdM7ZwFVmePEc
	 +kwJstet4m8klO3BPbrP4oyhdtLuKPj6YmsXOf4o=
From: =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Ondrej Jirman <megi@xff.cz>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rtw-next v3 0/2] Fix inadverent sharing of struct ieee80211_supported_band data
Date: Tue, 29 Apr 2025 14:29:09 +0200
Message-ID: <20250429122916.1734879-1-megi@xff.cz>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ondrej Jirman <megi@xff.cz>

This is a series of patches requested by Ping-Ke Shih in response to
https://lore.kernel.org/lkml/20250427002414.410791-1-megi@xff.cz/

Please take a look.

(hw->wiphy->bands[*] are no longer being NULLed when probe fails and on
remove(), but I guess that should not be an issue? I tried unbinding the
device and it worked fine without any crash)

thank you and regards,
	Ondrej Jirman

Changes since v2:
- requested sizeof argument changes
Changes since v1:
- added patch to convert some memory allocations to be devm_* managed
- check for NULL from kmemdup()
- rename rtw89_copy_sband
- drop some kfree due to them not being needed because failed
  rtw89_core_set_supported_band() results in abandoned probe()
  and devm_* will take care of that
- add error return to rtw89_init_he_eht_cap and check for it

Ondrej Jirman (2):
  wifi: rtw89: Convert rtw89_core_set_supported_band to use devm_*
  wifi: rtw89: Fix inadverent sharing of struct ieee80211_supported_band
    data

 drivers/net/wireless/realtek/rtw89/core.c | 124 +++++++++++-----------
 1 file changed, 60 insertions(+), 64 deletions(-)

-- 
2.49.0


