Return-Path: <linux-wireless+bounces-33299-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEj5ODHtt2mzWwEAu9opvQ
	(envelope-from <linux-wireless+bounces-33299-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 12:44:49 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 585C1298DA7
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 12:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5036E30062EE
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 11:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B56391829;
	Mon, 16 Mar 2026 11:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pBoxM5mn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6145639150A
	for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 11:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773661485; cv=none; b=XTNjwsNy5hk68A9A206JewpaVQOrClyrwEUxMuIVU8ZOfzNyJqanOi36ePPy7vSSXxJP5TUtAvMgP8mrKS340qZAZ6DoycQOmuRTlFwAQEuoAxefsYUmP9zSrLzn8aOLHX0GSVvOJ6ljNq2GBhCn6sSu1jJBKfxS50OR4cVmRnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773661485; c=relaxed/simple;
	bh=inHV9Ped4ZMhwGK3rfrUQhkpL5mQU4uwMhKJpzqlqNQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XFka9gjONpGOqvt7oICismIM1B5ih6Y7PuJjYePxWVMMv2JjGEj5caI3rYr1y8vXCLicLjC44JDANa0ZjgxzxrBH2/Uo50QKqRpVP9F5AZIl2zEp8mIRDMHkfUNQSHCVWikRPeH6sRGtU4d6d4Ej2cVl3QGiYZI3EUGfM+VmyjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pBoxM5mn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAB61C19424;
	Mon, 16 Mar 2026 11:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773661485;
	bh=inHV9Ped4ZMhwGK3rfrUQhkpL5mQU4uwMhKJpzqlqNQ=;
	h=From:Date:Subject:To:Cc:From;
	b=pBoxM5mnt3SKQXoXnj1AUM3wwwa4VZhnSSvPQ4ilJDVxPPl1Lbr/3I7mX4sgVVYpB
	 d4FfZ1sj+dYucs83o6kUYjQ8gtQJL+A3Za9AhJZaypiHijl8R4yTwIe/S/J3KUGP7P
	 mE1lm5TGSp5W6JazCR19NsjDWqOQ1Bwh2giS2q7LsbFdaFg4UoUjVSDCX2AjslnsMe
	 84w3C56kWv6FG9xv75PVK2/5PuZZtAbfo2QEKViYCrznx+VEjq8vvsrfPXw7hc7Q1J
	 1iAEhnURDZOFWth+nz4dbEg9oCWMV7m8flWcgR9ekoIGVws63HRGQw5SlT4DhamGgV
	 6qe1isiqgzQBw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 16 Mar 2026 12:44:27 +0100
Subject: [PATCH mt76] wifi: mt76: mt7996: fix frequency separation for
 station STR mode
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-mt7996-sta-str-v1-1-666814e6ab2d@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAIBBFrxKzTtAUy64SLaymmkUWKhFId29o8
 RYP3v8FEkbCBH1VIOJNic7AouoK5t2HDQUt7NDIxkqtrDhy65wVKXsmCt2t7WS8cVpp4NEVcaX
 nPxyAWwvj+35Nw0zRZgAAAA==
X-Change-ID: 20260316-mt7996-sta-str-38f7b4a49313
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Peter Chiu <chui-hao.chiu@mediatek.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33299-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[nbd.name,mediatek.com,gmail.com,collabora.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mediatek.com:email]
X-Rspamd-Queue-Id: 585C1298DA7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Peter Chiu <chui-hao.chiu@mediatek.com>

Fix frequency separation field for STR in MLD capabilities
to allow prpl get correct chip capability.

Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index 8dfb81eabc9aef9b54fd3b34e13114a1d5214541..d6f9aa1ab52d1258e3923783c8eac2ad5daf2b90 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -99,6 +99,7 @@ static const struct wiphy_iftype_ext_capab iftypes_ext_capa[] = {
 		.extended_capabilities_mask = if_types_ext_capa_ap,
 		.extended_capabilities_len = sizeof(if_types_ext_capa_ap),
 		.mld_capa_and_ops =
+			FIELD_PREP_CONST(IEEE80211_MLD_CAP_OP_FREQ_SEP_TYPE_IND, 1) |
 			FIELD_PREP_CONST(IEEE80211_MLD_CAP_OP_MAX_SIMUL_LINKS,
 					 MT7996_MAX_RADIOS - 1),
 	},

---
base-commit: dab5edc5546c90674cfff033abc2b797b3ad4bf4
change-id: 20260316-mt7996-sta-str-38f7b4a49313

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


