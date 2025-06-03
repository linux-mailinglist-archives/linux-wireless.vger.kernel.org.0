Return-Path: <linux-wireless+bounces-23562-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C69ACCA1E
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 17:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4144E167F6F
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 15:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E204522FE17;
	Tue,  3 Jun 2025 15:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="gYNoQp0B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2E370838;
	Tue,  3 Jun 2025 15:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748964415; cv=none; b=W+/FytQap6mvNHVCA8KQhYXO/PWAMbcELf88fljwB6NsX2gZx6H0iH3izMnwk7n0teQxIGRLqjdZU2lmM9fAGJdH+mKePCgsOUsI07UIPu6h3p/DmfVrqiPp79eLoUJzEpZMXA3eoHOd8g4Dk+jy8KjdN7ic/RriEdH8X2c7Zxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748964415; c=relaxed/simple;
	bh=MDupPV1RvGNo0X3N7abEyuXnUBTDSU761IOVzUCi/Jk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rCVQGfYX/CgWmKJpoEKFobrFtC/b2EpY8cNapaz4FOcXwY3LNWWy9gEG4A4S/8OLLub61upKC9uJ6SIxbzh1y0uJ36eUTn9hWa5VU9BEVDJr045ST84f8qIxvQJuWqK3zd0CkCD1tvl5MEVqiTl8TI9cmPH48aUKXux6OQi0Tkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=gYNoQp0B; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fedora.intra.ispras.ru (unknown [10.10.165.12])
	by mail.ispras.ru (Postfix) with ESMTPSA id B1095552F539;
	Tue,  3 Jun 2025 15:26:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru B1095552F539
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1748964410;
	bh=oa456/1h+dLWy8yLcvsTqPo/XFAWDXpUGYhz5+IavkQ=;
	h=From:To:Cc:Subject:Date:From;
	b=gYNoQp0Bl0HFRUwTHlEgyn3W/bjJUnOCe8jihXWAtlAX0KexI5seeprJ5qHt+PvZc
	 iRlL8dLwr4U/+CqBe+u/IlZtsijIM9nIx9TSeGug6vIU8HwIYjsohF0lYOqyRljYWz
	 Qe7P+X1w1uAELrZmaJVXlgRdNMSecB4irML3Pcqk=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Zong-Zhe Yang <kevin_yang@realtek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH rtw-next] wifi: rtw89: sar: drop assertion from rtw89_sar_set_src()
Date: Tue,  3 Jun 2025 18:26:41 +0300
Message-ID: <20250603152642.185672-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rtw89_sar_set_src() may be called at driver early init phase when
applying SAR configuration via ACPI. wiphy lock is not held there.

The only other callsite of the macro triggered by netlink handler
originates from rtw89_ops_set_sar_specs() and does already have the wiphy
lock assertion - and it is actually needed there.

Remove the assertion here in rtw89_sar_set_src() as it may lead to false
alarms now.

Found by Linux Verification Center (linuxtesting.org).

Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---

Urgh, this one wasn't caught as my system doesn't have any SAR available
from ACPI. But it would be falsely triggered, too. If I saw it earlier,
I'd better prepared this as a followup patch in a series though..

 drivers/net/wireless/realtek/rtw89/sar.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/sar.c b/drivers/net/wireless/realtek/rtw89/sar.c
index 33a4b5c23fe7..3f57881b74e6 100644
--- a/drivers/net/wireless/realtek/rtw89/sar.c
+++ b/drivers/net/wireless/realtek/rtw89/sar.c
@@ -199,7 +199,6 @@ struct rtw89_sar_handler rtw89_sar_handlers[RTW89_SAR_SOURCE_NR] = {
 		typeof(_dev) _d = (_dev);				\
 		BUILD_BUG_ON(!rtw89_sar_handlers[_s].descr_sar_source);	\
 		BUILD_BUG_ON(!rtw89_sar_handlers[_s].query_sar_config);	\
-		lockdep_assert_wiphy(_d->hw->wiphy);			\
 		_d->sar._cfg_name = *(_cfg_data);			\
 		_d->sar.src = _s;					\
 	} while (0)
-- 
2.49.0


