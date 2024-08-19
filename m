Return-Path: <linux-wireless+bounces-11638-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 756AD9576C2
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 23:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30167284C04
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 21:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C66E1DC48E;
	Mon, 19 Aug 2024 21:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxZlKOCY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E98F1DC468;
	Mon, 19 Aug 2024 21:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724103928; cv=none; b=V34+HBJQ/RYjcOfFDDySZjb6ooGXP5WGVUer5PerOXzGNLHa/BiCYYGRE7pYFx5Q/dbqnqrUxbNaDC4EXSYl85F5YZd/iXHs1ptoVnV5eBTaPLI1dqHRgp5OZSHuD6gyWUO1ezXbV7smEJVgj5R5LalkGFCIDkzR7de2HwP7WIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724103928; c=relaxed/simple;
	bh=1ZIX8HLw9Lylu+1ABelTVuQD5aYVhZQF6TKBZqYICOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pmDjvil7OVbnVDLSrTjQ2XTRu76PfPMhJYzcnh24Tf9rD/Unin4U+iD2kTWAAWIQU+/5O5bbNHxeZ0/gYVgjckCduNWGbB/Y2f+wn1V7R0aBkWsU8kqPlxAVLMPskXdMXfkLQ7msJJhDn5YZSwbA2vDbQF/dWrOR+fjNcEdXY4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KxZlKOCY; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4f6b612fad4so1634326e0c.0;
        Mon, 19 Aug 2024 14:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724103926; x=1724708726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJvsvZ9AilC7U7j8ILfRWsNQMKDz18Ta5023IDmqwaA=;
        b=KxZlKOCYcc1VTrwRtufmN65Y4o7cocZwR37gCkXKOa2BE/n10wcv6yietzkeCdsr8r
         fxJAGDUItsMwqq2Wb63qKZbSp2YFDuTNGNkYOlRzqXJgqGad97fA/Bv4LDqFSbeG3hj9
         me81UR1ERTK3hFuv0sDNjtQrMsEZJ3KEhXzq5xvlPjbaERJvshy0ERkbxfRJ3zcOhKEu
         FTeSmNtfDgqdUiu8Jmtauoe3UWUB15mYkr+pALFsvQzxba+HaWJD8k4CVMtYe3aYUCSg
         xuvkPzZg3X7phLnrmSAvmwYWbAHT6M0uZO3tY/rBFVs476/WPdaIvJ0rJmrhGCuoIHa4
         X7Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724103926; x=1724708726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hJvsvZ9AilC7U7j8ILfRWsNQMKDz18Ta5023IDmqwaA=;
        b=F3NowLkX7aTXhnr8HIOddPOrrck98/eonkyxHyMV7QoqFMc1ScpzgOleZosWAuX7ih
         2HplqzsIvqSRr5BGqTmXvfRQwjNVK8ssuD0fnk3xjEkKiKsBuRd94GzFnJwPRYgU7+wm
         vlv4D3LLLrIjr7Asxf3hoC2xV5BBilAq+5zXJb66XaOZuJZEHfOZEqg4lqeWSZosVZM8
         ibpNIwDE8NhFeRFhPgZHRl8yLfVtOKO3ez56pfrn5P6TI/w0VmGFYRL37sUknmdPfhbI
         54E+3uvoKZ1pUG1zdVPvwCH5jlync1JzRkTRGN25wE2MEp+euWEHgtmUrIvwiS//MDWR
         ldWw==
X-Forwarded-Encrypted: i=1; AJvYcCW2iLJxr0P7m7xt4G0WIEqeEt8bdamICJ5ezF7kRnP9Gq7j9lZA5v1gl9BRPohDV3bnnJ0O7ORAl60TlqbjE9wsEOkPwxOXHsvclKTF
X-Gm-Message-State: AOJu0YztpEU+Wk9XQWOo3hxpGx2eeL7MwgQFgR1fBsrftk0+vdRribA3
	P5aX6OudhTPkhBvfxGIgZlYjV5Qhc85Cny7+QC4+gZHsNPORxcQW9sy0hSBh
X-Google-Smtp-Source: AGHT+IEh2E2MZwX5ERJAt3jMC+7WO8f8ibbeyg7radwZNkVzufSrJv1c2KbQOAdQ1ylKqmQYv0x4gA==
X-Received: by 2002:a05:6122:1d51:b0:4f2:a974:29e5 with SMTP id 71dfb90a1353d-4fc6c580866mr15202937e0c.1.1724103925708;
        Mon, 19 Aug 2024 14:45:25 -0700 (PDT)
Received: from fedora.. ([2800:e6:4001:fca7:b7e8:4418:a953:72f2])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4fc5b9c872fsm1230429e0c.46.2024.08.19.14.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 14:45:25 -0700 (PDT)
From: =?UTF-8?q?Juan=20Jos=C3=A9=20Arboleda?= <soyjuanarbol@gmail.com>
To: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: miriam.rachel.korenblit@intel.com,
	kvalo@kernel.org,
	=?UTF-8?q?Juan=20Jos=C3=A9=20Arboleda?= <soyjuanarbol@gmail.com>
Subject: [PATCH v2 1/3] iwlwifi: mvm: Improve code style in pointer declarations
Date: Mon, 19 Aug 2024 16:45:18 -0500
Message-ID: <10b6d4945675cada713e819f7bd6782a66a1c0d2.1724103043.git.soyjuanarbol@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1724103043.git.soyjuanarbol@gmail.com>
References: <cover.1724103043.git.soyjuanarbol@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The changes ensure that there is a space between the `u8` type and the
`*` character as preferred by the guidelines.

This change is purely stylistic and do not affect the functionality
of the code.

Signed-off-by: Juan José Arboleda <soyjuanarbol@gmail.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/power.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/power.c b/drivers/net/wireless/intel/iwlwifi/mvm/power.c
index bc363e8427e4..a386b315e52f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/power.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/power.c
@@ -567,7 +567,7 @@ struct iwl_power_vifs {
 	bool monitor_active;
 };
 
-static void iwl_mvm_power_disable_pm_iterator(void *_data, u8* mac,
+static void iwl_mvm_power_disable_pm_iterator(void *_data, u8 *mac,
 					      struct ieee80211_vif *vif)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
@@ -575,7 +575,7 @@ static void iwl_mvm_power_disable_pm_iterator(void *_data, u8* mac,
 	mvmvif->pm_enabled = false;
 }
 
-static void iwl_mvm_power_ps_disabled_iterator(void *_data, u8* mac,
+static void iwl_mvm_power_ps_disabled_iterator(void *_data, u8 *mac,
 					       struct ieee80211_vif *vif)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-- 
2.46.0


