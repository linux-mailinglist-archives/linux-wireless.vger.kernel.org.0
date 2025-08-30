Return-Path: <linux-wireless+bounces-26879-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFAD5B3CDF2
	for <lists+linux-wireless@lfdr.de>; Sat, 30 Aug 2025 19:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BA073AB51B
	for <lists+linux-wireless@lfdr.de>; Sat, 30 Aug 2025 17:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BB4264A9E;
	Sat, 30 Aug 2025 17:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qF3Lim3C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD45221D596
	for <linux-wireless@vger.kernel.org>; Sat, 30 Aug 2025 17:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756573991; cv=none; b=r/Rn+EnpeMm3qWaRJO1N29yF1MXwmLdYEHlVJXTHekBUpQK5OcXmuM2T/tfz8wBzldZVqGLjZtsPhuEfn8eAi2RSxIqb52cm1lvB7QtSaHmPBG/dxLlwA3QFYxfTdvWk8aELIWLocFfHyjMxeLk9FsFPY24S+5nGxkbQkhSpSg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756573991; c=relaxed/simple;
	bh=nRpClAVmKhPM4s+plqvugvMv46C4EG57OiMmEMzwUH8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ILNAT+0wrKi+iU/uKvKHuO85iegbiECYdLdKFi7Hf8PzqKp6Pk/jqG7FVWjSQ/iufXLJgOGfAFXHqhu6fT+woUDBuTPwYPN0Zre1N6qy0xnjOTQUQJ/L2MoD0IL9HnCk2l8wAew5GUw3Q09GjmVGgkx4r+bV2BRNmE7cMwMpGgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qF3Lim3C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECAC8C4CEEB;
	Sat, 30 Aug 2025 17:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756573991;
	bh=nRpClAVmKhPM4s+plqvugvMv46C4EG57OiMmEMzwUH8=;
	h=From:Date:Subject:To:Cc:From;
	b=qF3Lim3CWUypANIPoraJu0T/iGf+K/Iqp9/M9juuCaZ1DVaomWRLAvPeL+VMJt/HQ
	 kmqW8ZLN0bIBdA6lxqgP1RlYo1qJ9EeIQxT/LCZoiEssa8MEM/ofUTlQWXfsuWdNuM
	 4xyFf1Isv6+n3SP6iZSLuaE0OYrM+BDTtdQc4C9tBx7sYBf1Tzwmafjmn76lNNUCez
	 LWGc2RyZLmzzYJ1+sahL1/bi0PLuDXXa1U2+c3k/I/5aWp0RlvqE7NVjBJgOF9BMse
	 o2TozfvGWvaeODIjiO+rEimjItEpFZmf4WJfILOl8RpQ9cN3o09qk8RwalSyQ4ZgDO
	 8pjsXati3lPpQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sat, 30 Aug 2025 19:12:50 +0200
Subject: [PATCH mt76] wifi: mt76: mt7996: Set EML capabilities for AP
 interface
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250830-mt7996_ap_eml_capa-v1-1-ef69c97c6adc@kernel.org>
X-B4-Tracking: v=1; b=H4sIABExs2gC/x3MTQqAIBBA4avErBNMsbKrRMhUUw30IxoRRHdPW
 n6L9x6IFJgiNNkDgS6OfOwJRZ7BsOA+k+AxGZRURtZaiu2srC0dekfb6gb0KLTCWlvq0U4GUug
 DTXz/07Z73w9ddaq3ZAAAAA==
X-Change-ID: 20250830-mt7996_ap_eml_capa-32a839eba9f5
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Report EML capabilities to hostapd for AP interface.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index 29e0cf966bcac5ab805b927fd73b7a23d15877ec..5af78760dbeaf3aa3d123e6438ff27c52d00ed51 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -75,6 +75,7 @@ static const struct wiphy_iftype_ext_capab iftypes_ext_capa[] = {
 		.extended_capabilities = if_types_ext_capa_ap,
 		.extended_capabilities_mask = if_types_ext_capa_ap,
 		.extended_capabilities_len = sizeof(if_types_ext_capa_ap),
+		.eml_capabilities = IEEE80211_EML_CAP_EMLSR_SUPP,
 		.mld_capa_and_ops =
 			FIELD_PREP_CONST(IEEE80211_MLD_CAP_OP_MAX_SIMUL_LINKS,
 					 MT7996_MAX_RADIOS - 1),

---
base-commit: 035ba65d13516fa2afa78203ba3ef54fd70584af
change-id: 20250830-mt7996_ap_eml_capa-32a839eba9f5

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


