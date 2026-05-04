Return-Path: <linux-wireless+bounces-35804-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4G0tFqsl+GmnqwIAu9opvQ
	(envelope-from <linux-wireless+bounces-35804-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 06:50:51 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EB14B8624
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 06:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48B173029762
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2026 04:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2171122E3F0;
	Mon,  4 May 2026 04:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTjJR0y6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7C6242D70
	for <linux-wireless@vger.kernel.org>; Mon,  4 May 2026 04:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777870120; cv=none; b=MIUK4jrjqXOWXDlXSZN52kZ+GOMjRtJPIP1GMkNEBJ1RH3rMK1xvSPgO9lsE5bhyMkvepgYnkGA6AxYVQMTMl7JCYbP1pK/ltp0KYl2RNAKngrjK8YB9fkypFAnsS8j6zavD1DbR1+uUpreX6aCWpz1LntOuF2qkdLsErY8RQt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777870120; c=relaxed/simple;
	bh=cC2G2WadoKLftM63rSUYpIgTYV8Cc4jika7rEDy+zvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mP++XQCzC2AT0G0jUnEFGgjLWaYffLRl/fusWst4RJpqjDaXniPxPkjGsXn9aq2R+9QNvUkRyB0OGprHJHhlFSrtfAVn/TkiK1KVc897BmLRoOKepVxPmUPBGkAOEKMtqv88ysKGlk5dKHMLZoR0bwe4pM22kD0cbhJZHw9Mt50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OTjJR0y6; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-44e1860558fso314568f8f.0
        for <linux-wireless@vger.kernel.org>; Sun, 03 May 2026 21:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777870117; x=1778474917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6xb3HRjw8A8WP7QvkL+DeiXvsiLNa7Kyc0uvy70a/7k=;
        b=OTjJR0y6KTrFB5Ji07WP2MZjEhHeodkg99eZKd6SxKlY9mr2N4sXU1kJyNRX8hbhDD
         SXgdcKZNqVMJO1SYbmk0jmDg9BI12wo7LdZKyx+qZslQC9IdLt4AiYDpb44RWkyRg6wN
         xJ7pZwZChCMXOeE7rdvBh057TGtGQ054QP0E+sK/VaVPSg+6Si7UI9G+tVvUE5iNOQ47
         hJZYayB6IyS3f8sNhj7rlJtJqClNpg+D4vtgVZjCrXESeGkOsiXjm/r0LO1m2G0V1zTc
         uAOwb26PL0xtm+tg3zLyIgF9HPNnqFxmV2IHh4hLeVTqcq2I+cs4DZHT639byf/mr1FR
         NgeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777870117; x=1778474917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6xb3HRjw8A8WP7QvkL+DeiXvsiLNa7Kyc0uvy70a/7k=;
        b=o5mszNlM+GQoHVmi6Tfn4lyy4eWQcv+TXQsscFmkVT66EtzDGZP8H0GoyEijM+K6Si
         b1j4BiGTNHSZhumQC83nSHwv63iKmjYlULhFhspMEtKoqynsoRHU5FlyP/mINxHL/wtg
         rmVOE9Tw1YC0RGQVOJyQNdC+bD1Im/d87oBIuPgj8Ubby6KG98mUu8GzKaMF/f60xRwf
         +mWdM1Bh29bcqxXQJCARLMkMBuKiFG9rlsCOAig/4lpLlyAMzzOgVeCTY/ZvOCJFSenJ
         cQgTE39gFfBkjLRyx8XwMuK+YS5mEcy0BVVF9TkoQEE34wnVVrkuUwFZNc5/FEnowOXV
         KiuQ==
X-Gm-Message-State: AOJu0Yx0LkTFgvGmqKsanBb+xncb9miPl5285GuTsjVI4gRgRr7XFUPY
	cOwVM7W7JqLXc3OG6nCah62dKHaxVuOyxOfhRAjvo9LgamOb1B7p6Wwm
X-Gm-Gg: AeBDiesZjD7ye0rsBggskap4fAAoa2AHyFcR1dIvrkPa0o/vtBnJ28Y+tI6jffpBDXK
	HJHVaVQw+b90HUfH/ehtemPXXwgF7UBy9ty03IbtElmz972Wts+jWqzyGWqAqEKJ+szvHESAwvm
	rVEaLG754bjnNLfC1AppnJ+gYH7AFWOirz5eAfLVYtMvyR8v/kyLrLhUPPaocKfiPuG8xVBoC+q
	rMCdwxKrd0qn+HcSL7owOuYE+bGCIMa78F6dgKcRqLDqVdHtSRIDpyuqHSkXff03PuqVAFM+i0J
	Sf44qUnRwi++Ce/nXckQSoGBqtNSZpdD8Z694/hlgIa9ZpfVwctZSPhURBkONDwcGTfBjTVf4gv
	SSax5adskKNd3IhQ1Ttba1xPF+Cropz54115wrES0m3vFK1ZAUh39UHIhsNvSJVaffUVnOwSi+2
	/TdsfIuf/orNz5c6YV0GL6i0LWX4FQS9FKu6lxDVfGOv/KIhDfg3kVNQKEeg==
X-Received: by 2002:a5d:5f55:0:b0:44a:1d55:1e20 with SMTP id ffacd0b85a97d-44bb2d37c7cmr13762699f8f.5.1777870116895;
        Sun, 03 May 2026 21:48:36 -0700 (PDT)
Received: from localhost ([102.128.173.0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a8bf18c9bsm22650809f8f.0.2026.05.03.21.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 21:48:36 -0700 (PDT)
From: Louis Kotze <loukot@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Louis Kotze <loukot@gmail.com>
Subject: [PATCH 4/4] wifi: rtw89: advertise EHT OM Control for 8922a per WFA cert
Date: Mon,  4 May 2026 06:48:17 +0200
Message-ID: <e280556159e254463092c82cba5035534624f171.1777832019.git.loukot@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1777832019.git.loukot@gmail.com>
References: <cover.1777832019.git.loukot@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B4EB14B8624
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-35804-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loukot@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.993];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,wi-fi.org:url]

Wi-Fi Alliance Certificate WFA129313 (RTL8922AE, 2024-05-23, firmware
6102.24.109.0) certifies "Operating mode indication" as a Wi-Fi 7
feature for this chip. The driver currently sets only MAX_MPDU_LEN +
RESTRICTED_TWT in mac_cap_info[0], leaving EHT OM Control unset.

Set IEEE80211_EHT_MAC_CAP0_OM_CONTROL in mac_cap_info[0]. EHT OM
Control extends the HE OMI control mechanism (already advertised at
the HE layer) to EHT-specific operating-mode notifications. mt76
(mt7996, mt7925) and iwlwifi mvm + mld already set this single bit
for their Wi-Fi 7 STAs; hwsim sets it in test code.

Tested on RTL8922AU against TP-Link Deco BE63; assoc + EMLSR multi-
link state remain stable.

Link: https://api.cert.wi-fi.org/api/certificate/download/public?variantId=129706 [WFA cert WFA129313]
Signed-off-by: Louis Kotze <loukot@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index aedb2a284cd4..229c9f8ea65e 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -5564,7 +5564,8 @@ static void rtw89_init_eht_cap(struct rtw89_dev *rtwdev,
 	eht_cap_elem->mac_cap_info[0] =
 		u8_encode_bits(chip->max_eht_mpdu_cap,
 			       IEEE80211_EHT_MAC_CAP0_MAX_MPDU_LEN_MASK) |
-		IEEE80211_EHT_MAC_CAP0_RESTRICTED_TWT;
+		IEEE80211_EHT_MAC_CAP0_RESTRICTED_TWT |
+		IEEE80211_EHT_MAC_CAP0_OM_CONTROL;
 	eht_cap_elem->mac_cap_info[1] = 0;
 
 	eht_cap_elem->phy_cap_info[0] =
-- 
2.54.0


