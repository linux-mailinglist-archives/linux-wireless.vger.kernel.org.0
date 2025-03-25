Return-Path: <linux-wireless+bounces-20805-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5497CA7065B
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Mar 2025 17:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88AE11895FE0
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Mar 2025 16:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E648A256C79;
	Tue, 25 Mar 2025 16:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bP2Lq0rm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB3225B67C
	for <linux-wireless@vger.kernel.org>; Tue, 25 Mar 2025 16:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742919143; cv=none; b=WMyERaqmT79iFabvGA7CjrexTFqQKoadwllzne8PyfHsFGJx3QGDDWIHlhYK9G9xe/v4kQcilNRw3kfhF+pyncdbqDbQJ1ieIO0eUHSVs0hZMLnJz8/WMgcqVWklFQ6YZr0JbFyvYp49/LZFPLNOKWfP2mnKVdYE6pcimEFezIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742919143; c=relaxed/simple;
	bh=x10G0rQd2+3aO6XNnYYfLJ4MTWFAc+fz/p3Z0HiRCLY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UfgNFyvWZsMYSrc4jebiy+CGUhHy2xAZlBrCpOahlAcxNuwqlUOiTnfOErpT1ZHdbvP9vPQ8Qkypj6DEySZK8IchMMhqG3XWTeilbmSmvg6q4/xwk2aANejMCO+jG1cgQ9Sdvk0KGyqovZ3BCFZP8MAWrzV2tt1npWwQYvcmceI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bP2Lq0rm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3AF0C4CEF5;
	Tue, 25 Mar 2025 16:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742919143;
	bh=x10G0rQd2+3aO6XNnYYfLJ4MTWFAc+fz/p3Z0HiRCLY=;
	h=From:Date:Subject:To:Cc:From;
	b=bP2Lq0rmbWZ5q4sl4PMBiIkfx8AY6iW23ip85N3j8L+5zzpZeit0OcbqW9W2Qx8Jp
	 ApkRCmjCqO4CRXEdDrjejDarVu6Qux+GFIrPmCdwsrIiBczcEsQ3GpNPbaIz0/gCjD
	 jL5oTM9DpiTIAnZpmOizCxIaLmAcM0vYNrtjDMKrG62oDb/ZX9+VS2yAeJcKYQeFGp
	 xehHMgejWT+WY3/htuiU0CQP65MfMcFt/1lNtjOxZpTqIyvynAr6RAjXH0P2OlKG6+
	 7t4Y2x+A/s64FihgPjeJqnzmIyH21WKB/GEhogXiq1qnmHhzSMGsiKSlt3fmu9iK+P
	 tGFk7q99iRdzw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 25 Mar 2025 17:12:05 +0100
Subject: [PATCH mt76] Revert "wifi: mt76: Check link_conf pointer in
 mt76_connac_mcu_sta_basic_tlv()"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250325-mt76_connac_mcu_sta_basic_tlv-link_conf-revert-v1-1-b84efefb74ee@kernel.org>
X-B4-Tracking: v=1; b=H4sIANTV4mcC/x3N0QrCMAyF4VcZuTYw69qBryISYpdqcOukrUMYe
 /d1Xv4c+M4KWZJKhmuzQpJFs86xxvnUgH9xfArqUBtMa2x7MRan0jvyc4zsafJfyoXpwVk9lXH
 BUeP7WANWTFLB0Lmeg+vYsIWKfpIE/f0Pb3BYcN+2HYAevSCGAAAA
X-Change-ID: 20250325-mt76_connac_mcu_sta_basic_tlv-link_conf-revert-f467af64a2a5
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
X-Mailer: b4 0.14.2

In mt76_connac_mcu_sta_basic_tlv() link_conf is always not NULL.
Revert the commit '9890624c1b39 ("wifi: mt76: Check link_conf pointer in
mt76_connac_mcu_sta_basic_tlv()")' in order to fix the following
warning:

drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c:394 mt76_connac_mcu_sta_basic_tlv()
warn: variable dereferenced before check 'link_conf'

This reverts commit 9890624c1b3948c1c7f1d0e19ef0bb7680b8c80d.

---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index bafcf5a279e23ff007d9052301cd2f6b899c491e..d0e49d68c5dbf0ed4eab084d9c6f1cad230bed93 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -391,7 +391,7 @@ void mt76_connac_mcu_sta_basic_tlv(struct mt76_dev *dev, struct sk_buff *skb,
 		basic->conn_type = cpu_to_le32(CONNECTION_INFRA_BC);
 
 		if (vif->type == NL80211_IFTYPE_STATION &&
-		    link_conf && !is_zero_ether_addr(link_conf->bssid)) {
+		    !is_zero_ether_addr(link_conf->bssid)) {
 			memcpy(basic->peer_addr, link_conf->bssid, ETH_ALEN);
 			basic->aid = cpu_to_le16(vif->cfg.aid);
 		} else {

---
base-commit: 1794d7ab34d2221ac7eb921b171e75b856e10561
change-id: 20250325-mt76_connac_mcu_sta_basic_tlv-link_conf-revert-f467af64a2a5

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


