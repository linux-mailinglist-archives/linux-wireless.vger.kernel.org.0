Return-Path: <linux-wireless+bounces-23756-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 660BDACEE66
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 13:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D49C73AC3F6
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 11:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EE072607;
	Thu,  5 Jun 2025 11:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQI+hPeh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5391829A2
	for <linux-wireless@vger.kernel.org>; Thu,  5 Jun 2025 11:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749122303; cv=none; b=uAuhZ1pK4sIaKBu20fuxbgP8YJrHHNqeQ05A8pBVFJvYEkCx3cfkn0BXrzMzjzOKAYjkomr9j54sxGpGbfhYEPO80a4e+Ir+6SgZWEbGpBBQbY6Stf+UKRQLF5TP7G3vvMhCaTMB8crLA8EHDu5QCW1/ZwI32UpSajBJj/T7D+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749122303; c=relaxed/simple;
	bh=tBOcorhhYIo/YdsKZH86zdXVOJw32seHQjAGm5MOlIE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lqd2ID0n7GDA04JMCC+E636gzbEf2o8cwBhZIk87JfkB9lU6TqS+/Na3ggw0yA6k9f0nuMXLubF4jaYD4EgSM/y0DsM0mqnDjfwIlMO5WYDcFGGAaWj9KHw8QmUErtp+KoUmR+AYNOJDd/hfHuJDRwDr1pGJlxinST2YiFaMva0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQI+hPeh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42AEEC4CEE7;
	Thu,  5 Jun 2025 11:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749122302;
	bh=tBOcorhhYIo/YdsKZH86zdXVOJw32seHQjAGm5MOlIE=;
	h=From:Subject:Date:To:Cc:From;
	b=AQI+hPehRdGmwWk8fAFErEY9JBj/y072b/fr7ZuK+l7AmC8iPzJnYxs8BALnFIKds
	 2K06CRRbT6Rhvq9JmDuPKpma9aBRMNLh2PCY9cEfA0XqKfnwSwUxe4MM6RD7GGsFZ8
	 whqevVpgoYA0tPfZy/G++MUpWtN/eztffUsSlVeC4Y3rusAkn3M0IyZdk7wxWzIQ+J
	 9IdU+isrGHH25VnNz5VHS+dccE0sdrTXQVv1IVD4+S9Yj4StU0IGbHa9AvdzwS/GRb
	 dBb9QiIFheu0YrrR3P9zrebbq+iHjIQe+Dk2Ae5VvYU/754eHw0OBh4bnZlnI8Xw72
	 u+m4dOcRJh7PQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH mt76 0/5] mt76: mt7996: Fix 'sleep while atomic' in
 mt7996_mac_sta_rc_work()
Date: Thu, 05 Jun 2025 13:14:15 +0200
Message-Id: <20250605-mt7996-sleep-while-atomic-v1-0-d46d15f9203c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAd8QWgC/x3MTQqAIBBA4avErBswI62uEi1KxxzoD40KorsnL
 d/iew9ECkwR2uyBQCdH3tYURZ6B8cM6EbJNDVLISihR4nLoplEYZ6IdL88z4XBsCxu0Y1Fr7bS
 sjYXk90CO7//dQWIK+vf9AIHOrNhxAAAA
X-Change-ID: 20250603-mt7996-sleep-while-atomic-db1877f728cd
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Bo Jiao <Bo.Jiao@mediatek.com>, Peter Chiu <chui-hao.chiu@mediatek.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Ben Greear <greearb@candelatech.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Fix a 'sleep while atomic' issue in mt7996_mac_sta_rc_work() since
mt7996_mcu_add_rate_ctrl() and mt7996_mcu_set_fixed_field() can't run in
atomic context.

---
Lorenzo Bianconi (5):
      wifi: mt76: Assume __mt76_connac_mcu_alloc_sta_req runs in atomic context
      wifi: mt76: Move RCU section in mt7996_mcu_set_fixed_field()
      wifi: mt76: Move RCU section in mt7996_mcu_add_rate_ctrl_fixed()
      wifi: mt76: Move RCU section in mt7996_mcu_add_rate_ctrl()
      wifi: mt76: Remove RCU section in mt7996_mac_sta_rc_work()

 .../net/wireless/mediatek/mt76/mt76_connac_mcu.c   |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    |  40 +----
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   |   5 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    | 188 +++++++++++++++------
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |  16 +-
 5 files changed, 152 insertions(+), 99 deletions(-)
---
base-commit: 1b98f357dadd6ea613a435fbaef1a5dd7b35fd21
change-id: 20250603-mt7996-sleep-while-atomic-db1877f728cd

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


