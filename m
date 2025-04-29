Return-Path: <linux-wireless+bounces-22162-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 219EBA9FFB5
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 04:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 516151B621C8
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 02:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E35F29B23E;
	Tue, 29 Apr 2025 02:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="HByKmZYl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D880C29B791;
	Tue, 29 Apr 2025 02:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745893272; cv=none; b=gojuJGjLh8CMZRHxsa241IYkvwbuWQHtOtbcZAe/hHrK06ipJ5D3ElsmjD0wsb7UqH444mAiBHSrcY5d3TjZvlOPFd7c/w+f5Gv3xvqfjbM5CQ7yslbJFC/Zc2DOFg+4b8TKh3LEiBxQ6H95tsZbQM9eYeA6MYzXWZt2qhQFagk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745893272; c=relaxed/simple;
	bh=KeWSn+nQTjlCDaX0IpDaFD8GncdzQMCkU2eOhAFPE2M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GyMh+VHj/Pt8XvGCpCTx/Yc8v6gc+51xSjR7aj+5SN70U+bLqWfmRDznSfQBvP3pQcom0rLcKOprkz1B0z+k2CVj6dpfVDbBeKnojNWL/C51AzUffmjkf1Vm+a3oHx1XmPe2H5Y5Zq7xYJROUe/YiLTedxKXmoXFk5AKhaHFipM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=HByKmZYl; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1745893266; bh=KeWSn+nQTjlCDaX0IpDaFD8GncdzQMCkU2eOhAFPE2M=;
	h=From:To:Cc:Subject:Date:From;
	b=HByKmZYl4HMWAUzrcMjjkv98gVQnyhJZrBfVqcQe0H9kCoJPir9kiCTfR39FxmttV
	 7ONuqNY3VNNPON0gv0aeJ56y1d5bi8JkgDuTJtl0RPA11eoE5ant+ezQ4QCM32ScEP
	 ot1Qq2sJmBPuigIPXYIoidpciK5nx90Ss8rm9150=
From: =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Ondrej Jirman <megi@xff.cz>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Fix inadverent sharing of struct ieee80211_supported_band data
Date: Tue, 29 Apr 2025 04:20:31 +0200
Message-ID: <20250429022046.1656056-1-megi@xff.cz>
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


