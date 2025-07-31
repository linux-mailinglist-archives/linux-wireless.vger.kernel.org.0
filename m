Return-Path: <linux-wireless+bounces-26062-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D494DB16FB8
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Jul 2025 12:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2578B18921D3
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Jul 2025 10:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E3020AF9C;
	Thu, 31 Jul 2025 10:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BpXjbWFy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB8118D643
	for <linux-wireless@vger.kernel.org>; Thu, 31 Jul 2025 10:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753958505; cv=none; b=bzyLVevzu/eIhrf2K+9e5oDzHR09x/jXrwMAtwj6lZNsXklc0E02XJPz8uEAeis7vWtsP9Qawniy8oRRM781TeKTCfALjE82B58ZrCagtb+W6sNbhl6gUJWrfN48DnAfDeppvV4iTqMwWr0uwCfZXMY4xKnyATQrlvZ07uEgNmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753958505; c=relaxed/simple;
	bh=DAwA9+gaYkoHzADBWAkFXV0TI+WZQncLcPZpV8x7n1I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jxaSIODrciIo6xqhRaiEWzUZ+k4Qqi1Y1bqYV7B3pN7fT0Tom0EZVyNjr/i7RFLwq6NxeNOt6MY7rHGEUdCk8nH3j5LJC7m66mSFM6xqjeFxVDI6Zw8kx+98fWGsNhNjT3eUZ7XAYSh1xAkSmQSU7ncL8k8G53WGoDOSTa77tZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BpXjbWFy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE183C4CEEF;
	Thu, 31 Jul 2025 10:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753958505;
	bh=DAwA9+gaYkoHzADBWAkFXV0TI+WZQncLcPZpV8x7n1I=;
	h=From:Subject:Date:To:Cc:From;
	b=BpXjbWFyNn63BTKtPVovFDxaGKe3iDrl+zVnbu6CQpvXU17N4MBfu7ood+PXwbHzn
	 DNcpisg2MjwclmKYeaG40uRikOWcMmFBILZ13S0jY94lIkSJiqPHktQZpZaieBA2Wo
	 5JXKMvRShSClZNkpUlAtBzFoaMFJvliVkk58X0PuTMkjHbHHVhCrEVBlU01pieyvlw
	 T4ZdrO+0sHSJWNl9pmMdWfGDEeyymvk9IAkqtSrCuvCf0uvnxJM81MRB6KMpdiW2mc
	 OBJ76jz3nmS6LQGqMKyKbuBss2ndWzeeukUDQ7pmur8CV8k2LQnEcfLflzlhj1vrTG
	 H68aqNrshA1ng==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH mt76 0/2] wifi: mt76: mt7996: Fix connection setup for
 MLO-capable clients
Date: Thu, 31 Jul 2025 12:41:22 +0200
Message-Id: <20250731-mt7996-mlo-devel-v1-0-7ff4094285d0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFJIi2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDc2ND3dwSc0tLM93cnHzdlNSy1BxdSzNLsyQDo0SLlLQkJaC2gqLUtMw
 KsJHRsbW1AOOtdERiAAAA
X-Change-ID: 20250731-mt7996-mlo-devel-9696b02a8dfb
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Fix connection setup for WiFi7 capable devices.

---
Lorenzo Bianconi (2):
      wifi: mt76: mt7996: Set def_wcid pointer in mt7996_mac_sta_init_link()
      wifi: mt76: mt7996: Set proper link destination address in mt7996_tx()

 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 35 ++++++++++++++++++++----
 1 file changed, 30 insertions(+), 5 deletions(-)
---
base-commit: ab82ccb7840901200a8a75d32d13cc56f9597966
change-id: 20250731-mt7996-mlo-devel-9696b02a8dfb

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


