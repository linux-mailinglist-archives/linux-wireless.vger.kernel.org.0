Return-Path: <linux-wireless+bounces-11585-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AE0955B99
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Aug 2024 08:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5216281E90
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Aug 2024 06:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975471759F;
	Sun, 18 Aug 2024 06:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvTEUfc5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C3117548;
	Sun, 18 Aug 2024 06:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723963744; cv=none; b=pldO75nplvUB9s72oy5U6rLtPoT0XLkKLHoxReJ6ZqLpyxHLuaHDD9gBO2ct/q+oC+d8kp/aYU91UwCXBLERcwB7O2Ity9rKwkfu4L3bok5a7i37Wyk9VYSXX9NIrDFkZVPCSVxIop1evZUnHRapJ19NaSfdc8gB9M3ooctYyVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723963744; c=relaxed/simple;
	bh=1ZIX8HLw9Lylu+1ABelTVuQD5aYVhZQF6TKBZqYICOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cAqT4cUlx5grfw/lutXFYAuZaZBWlyoOn4VErNQrn0f0QMT+j8dBggRCgu3FMwHr9G7znvLQbkxKrYZf2JLkX+bDwbaQJxkmH9H2Ii328/8zS+KsvNBRILj04FA9xXGsLiwhGz27Su+6HnUtFAc+r7zniPcEQbq/cHmBSf74FoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EvTEUfc5; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4f51af903a7so2183664e0c.1;
        Sat, 17 Aug 2024 23:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723963742; x=1724568542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJvsvZ9AilC7U7j8ILfRWsNQMKDz18Ta5023IDmqwaA=;
        b=EvTEUfc5kvkft/zU3oSTrIDMVXkK6+rkfARPs/rR6nOOT4Cn5WbGeN0+1r2hPq9kgN
         OYcY1lJQnPRyel4ZLxIL2CvE3rRHrKrEmbUIa+thS3HTeOis/7dGPr2Pmb+I3p9lKWED
         TcCyQtf1VNCy9KVnEjkYdkWn1+q+cdScFiwyn4kd5bXAHFP5bJjzMEiPdvC6hFydAmLv
         twJiH33oPcRBCqB/6uzQorqAM+yX7p6gO83UdX6ePg6lY9KjTMhdpgInHgPAMoITr6i5
         gv2g1HxpZ9vOJM0UTiejJMohUNHEoB83NFnddHl5Vc5PRFVJDDFCG0vefHPAKbBmV31R
         1vdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723963742; x=1724568542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hJvsvZ9AilC7U7j8ILfRWsNQMKDz18Ta5023IDmqwaA=;
        b=Q1DzwqpmAXhOGrUB6aFx0AF5B6d4tzO3dAzfdKowpgtaseXmw5s59ONY0EXi+edkg/
         9to0k/2kFDwE8/yHMlI0oRNlm5VqqheUerQSxJH2xDqvCd/eIA8PwEmhd96Ed4AMP3Q7
         Obuo0d+YU6mx7LgzUanj9KMu5gsubsaDlJidPTIWC+9IT3o2XoKiNBuUeLwrEiGHCXDL
         c45FlzcTjWdzDU4V6A0SVzZNrbrPHNCGaNZCzJXGXMASSsSv3hH89J9J09Z6RuhYJ3A4
         TDD/CEMcTWHm5WCC3CDxbojgleh9t653hlhpXZDE2r/Nb9PLe+mUv74jmau/TCPOVvPD
         P/1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUh1FICgdYW9k01RVZgj0sz+hxnAlJn5PWU2JdfcvBjDGV2NnaDNpqlbKBXBv3a68VeDMmuXwRkhMqj7osKwp/X+NxwOVoR7Z1iGKDr
X-Gm-Message-State: AOJu0YwK3prUxc+kRGYyFV6we92cw/aia/DSaJmmldCr+CLnanKQwNGn
	IUNNxxsXKulP3ydZip5flOaFfpIYiqpf5JOGbbJfDxZtNVBT07ZhGJgOlKKj
X-Google-Smtp-Source: AGHT+IHJYsdPvRpaqZI3/EaZydYS3kY/EjcMMbLnd8ywyL/aQIyvzal5jAWi7V65TxZkBSIBGeuDAg==
X-Received: by 2002:a05:6122:1806:b0:4f5:197a:d679 with SMTP id 71dfb90a1353d-4fc6f5f9f2fmr3769486e0c.1.1723963741883;
        Sat, 17 Aug 2024 23:49:01 -0700 (PDT)
Received: from fedora.. ([2800:e6:4001:fca7:b7e8:4418:a953:72f2])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4fc5b8e30cfsm811032e0c.18.2024.08.17.23.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 23:49:01 -0700 (PDT)
From: =?UTF-8?q?Juan=20Jos=C3=A9=20Arboleda?= <soyjuanarbol@gmail.com>
To: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: miriam.rachel.korenblit@intel.com,
	kvalo@kernel.org,
	=?UTF-8?q?Juan=20Jos=C3=A9=20Arboleda?= <soyjuanarbol@gmail.com>
Subject: [PATCH 1/3] iwlwifi: mvm: Improve code style in pointer declarations
Date: Sun, 18 Aug 2024 01:48:57 -0500
Message-ID: <10b6d4945675cada713e819f7bd6782a66a1c0d2.1723963126.git.soyjuanarbol@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1723963126.git.soyjuanarbol@gmail.com>
References: <cover.1723963126.git.soyjuanarbol@gmail.com>
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


