Return-Path: <linux-wireless+bounces-29084-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D852BC688E7
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 10:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1F3E53810F6
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 09:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00DE31985F;
	Tue, 18 Nov 2025 09:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dqu85j1k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B14531771F
	for <linux-wireless@vger.kernel.org>; Tue, 18 Nov 2025 09:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763458239; cv=none; b=WblrxYiGsphtlpvw++Wnv0qnWObJS6ENg2nI4cAP3VJZnSNS1QKSRRLAJIDS4KIBmAXQrW1AvSoaAvsVcmRGp0gtcjIpK8+xaUM6SjyVqbpgy7IOcoZ296fpt/MviVSgqNlCMStAjh+Jf4QVc5N618FgSYVBhQy4N1ksWFVtI7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763458239; c=relaxed/simple;
	bh=tOu+3QhGuuDUjW3b2MoMTda+xPJWsWqfa+W+4ERtsYo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LU5g9pYPG5F6RoGfzXK7Y5auzMcTCtkXdle+P45nGb0z7iZ1evQwmHg3GCTwE1wgOmJZNO5xesL8dWJwSYGFtDvAw3dzehxCmJnOK9sE8Y5rQ06VWLNVtTL7m/GnygXQ/Tj970EtYFBMaBpffM2zHIbtE1vhY2drTGxx4ZM7QRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dqu85j1k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D2CEC2BCB7;
	Tue, 18 Nov 2025 09:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763458238;
	bh=tOu+3QhGuuDUjW3b2MoMTda+xPJWsWqfa+W+4ERtsYo=;
	h=From:Date:Subject:To:Cc:From;
	b=Dqu85j1kAi1yXDgIocm6rrIfGa/E8aUG68YauY1J+/qeqeozh+BQ+22MOVE6xIwk8
	 lMPYTxYUNktodSqZ2RsfqQ0JMVumXgkMGCHeY8H1ZjHJWx3IlzHd+nvgT+SSyVaICr
	 +VQSaigDUJY3sO079M7GgWzaLG1UYA3hHcno123UucUXh69la8k89ofEWmDYYNO5lf
	 Tb/U+2qCsW5ESS6TpSZfXP9hRa/988QxBx+zh5tQgkETBQey94Z9picqO1ZDN7fI61
	 kmQlwxvQ5RiIEXl/w/Zyh9hY/wgd2UEicpUDLJy1suko1lMw1/Dtm4ZwR0/F9Hx/io
	 KheBrdgYJZsuA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 18 Nov 2025 10:30:26 +0100
Subject: [PATCH mt76] wifi: mt76: mt7996: Add missing mutex_{lock,unlock}
 in mt7996_mac_sta_rc_work()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-mt7996-rc-work-missing-mtx-v1-1-0739c493a6cb@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqDMBBA0avIrDtgxGjSqxQXMZ3YoRjLjKgg3
 t3Q5fuLf4KSMCk8qxOENlZecoF5VBA/IU+E/C6Gpm6sMcbhvPbedygR90W+OLMq56nkA8NI0bo
 22S4kKIOfUOLjP38N13UDm8pZb2wAAAA=
X-Change-ID: 20251118-mt7996-rc-work-missing-mtx-abec584f56af
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Grab the mt76 mutex running mt7996_mac_sta_rc_work() since it is
required by mt7996_mcu_add_rate_ctrl routine.

Fixes: 28d519d0d493a ("wifi: mt76: Move RCU section in mt7996_mcu_add_rate_ctrl_fixed()")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 8ddb6d69f0da2c49b72bd516dd380fad959eb063..2560e2f46e89a4bc46e21d796fca80b7decefa5c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -2890,6 +2890,8 @@ void mt7996_mac_sta_rc_work(struct work_struct *work)
 	LIST_HEAD(list);
 	u32 changed;
 
+	mutex_lock(&dev->mt76.mutex);
+
 	spin_lock_bh(&dev->mt76.sta_poll_lock);
 	list_splice_init(&dev->sta_rc_list, &list);
 
@@ -2922,6 +2924,8 @@ void mt7996_mac_sta_rc_work(struct work_struct *work)
 	}
 
 	spin_unlock_bh(&dev->mt76.sta_poll_lock);
+
+	mutex_unlock(&dev->mt76.mutex);
 }
 
 void mt7996_mac_work(struct work_struct *work)

---
base-commit: 09600421ffe2acc1a00ec466b25485f11b6bb957
change-id: 20251118-mt7996-rc-work-missing-mtx-abec584f56af

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


