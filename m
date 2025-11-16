Return-Path: <linux-wireless+bounces-29004-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4157BC61C41
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Nov 2025 21:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 659623AB981
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Nov 2025 20:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A4023E23C;
	Sun, 16 Nov 2025 20:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BgoTZmFP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2204D531
	for <linux-wireless@vger.kernel.org>; Sun, 16 Nov 2025 20:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763324834; cv=none; b=VvoBrmBUjEch2kZuDwtjBztNAk3Rq3evB4RYzEcQW2SZo3GNOXCrqicyzNe9TTU/iDtPPdJoPujpcdRzFFTS3BjCcelVU8Uciwvlpakd5vy9j9dSELD3pEMZE3fAUUHGHrMHN1Nh+BgymHgUSKUQV82NW3EcwL8Zcr6lJ1FEaDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763324834; c=relaxed/simple;
	bh=URHG+A1JafYKi2rGJn6tI2VlKYrZhLalBoWgAO1j6HQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=e3wG9pj23VOxBF+n8jZRM/QBtFIGDQxlMu9T+23jaSX3dw7zpDHkNsifpNgh/RIIW0V+GwsXXW48kLTAZTUZFx0uIiGaDlc41fxIyZF5f8P2MczoceYitDogm1Fy3ffyL1ijRKzesFfkukAoGZ5t8UtTZ7GqwRFDYTJR2f7L+g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BgoTZmFP; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-477632d9326so25084295e9.1
        for <linux-wireless@vger.kernel.org>; Sun, 16 Nov 2025 12:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763324830; x=1763929630; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f5PKERu7mBZL8fFOGer99+wZ0xmF9Y+9JGs3sIQmhrA=;
        b=BgoTZmFPFK+Ag1ssIxt8TpoR+++ik2+CybOL9Rk5CoKU9OZQL7x8hMZqoAh04BJODU
         6TfAW9p0v15sn4Rdngo/VjpnjmZOGASnOxGXvUJjIcfeCg3NIUzcLZJ/TJAI2PeELD4O
         ji1rAE8q5VrukcLbVLmIfquM6zI/wuy8fMAhsIjIcJoyQVziiRCfx1lmTNgKElWNShyC
         kJgUZsP210RctmL/d+hLh3W43wSNI3way52Dxn3ZgIoDDjOi4dvTMfVkz2ZKV683yTfD
         GtfWHVC7DMrLIJf9lunhqCk/9PKtp4MLhuK5bVarPVPDm7oRncY7W6PQP1hiUI2A2dKx
         0pvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763324830; x=1763929630;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f5PKERu7mBZL8fFOGer99+wZ0xmF9Y+9JGs3sIQmhrA=;
        b=qymZw1HPqxJsSlr9X7+YgezMngM4WTOJZLBKXKBmxx5ckDHqzT3QZNCJzSKKEOuwtj
         96bNZVYktqNrc/hqj3sBzk4O8FzpYl5F+fJsTCqSBI10vkICAtRzPZLMOo5+eiJ15MH4
         OI2yG05Vu2t+2szvEiHvxDkC/hdRcuUK1srTEed1EE7bLoiCZyOZNuSzIfj0J9Xqcia+
         /3+ieEmx8WEZlIVQ29HrYkoms+XS/6MpEcM5wVvpq8jjkDx2OkHaWcieqri4Gt/PN45s
         qddk8sHO0jy7GFzs/JFA1OPX8gAiidPk9SzcaCOtP6wBq0fWJ9TDhHhPM+qd5fOUeUQJ
         3Mjw==
X-Gm-Message-State: AOJu0Yzp3hDETRv/c73xXsO9QEa7w19NtR58tO9Jrg/rrB0EnQB4DXOZ
	k0kROBBE8QAJ/PzVOh19QT2xlTyIM4TBjwI8Imy3ZXrgFiDoFbs7qJeN7da2CQ==
X-Gm-Gg: ASbGncsmyZyzXzxBz/B83F/1McD0bLdnqSGTIll/gfOdABtPTTgjzms1hSrKLxKal+D
	ZGGZtrm7LJMLag3QTsw/twmeEm1pR+SD+7sO+hRCYSLRSkAJr5KDUjCg6PjHfWCH/AsNUBMVzXB
	tukK9+R4altI7fX6byqPkdfR84c7ZdWWjDDPflthuOVkdnyZruf2lBkyrdZQQtnsVYidCeBf5Eu
	UQZU/F8yEiWvbsiJbPAOY/wBkSKKFrgg4qQKTEdPDYjSGUGJ8fVungtQTipBaSvygZGf2A4pvy2
	1i/3wmy230rndhNPk1Qr5VXKotiAfz86G9/ztLSfVciQTsCfBX5yUgHvOLIOD3ipiDyO+E9DJry
	Hc6BSw9n5+m9ZolEWGxtrd2PwgN7IIQ1BUekv3pmZt2eqFyTc2eFU+fsB7YjPj7MuddGDuOTdNw
	hP8wqcXshdAUHdO1s3Z18=
X-Google-Smtp-Source: AGHT+IHS1K6et0tOi7HXDJMuGbgVUg4ghASIy/vO9+Xr442y3IInbMRlusSnLi5Pn8ulHFiR+7wEhQ==
X-Received: by 2002:a05:600c:4f93:b0:46e:7247:cbc0 with SMTP id 5b1f17b1804b1-4778fe6654dmr93521115e9.18.1763324829992;
        Sun, 16 Nov 2025 12:27:09 -0800 (PST)
Received: from [192.168.1.50] ([81.196.40.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47799768409sm99821295e9.3.2025.11.16.12.27.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Nov 2025 12:27:09 -0800 (PST)
Message-ID: <8bad19ac-f649-4949-a407-b727e043c6b6@gmail.com>
Date: Sun, 16 Nov 2025 22:27:08 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next 1/5] wifi: rtl8xxxu: Fix HT40 channel config for
 RTL8192CU, RTL8723AU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Jes Sorensen <Jes.Sorensen@gmail.com>
References: <b735b9c6-f17f-405a-8972-a7c98f3c89e2@gmail.com>
Content-Language: en-US
In-Reply-To: <b735b9c6-f17f-405a-8972-a7c98f3c89e2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Flip the response rate subchannel. It was backwards, causing low
speeds when using 40 MHz channel width. "iw dev ... station dump"
showed a low RX rate, 11M or less.

Also fix the channel width field of RF6052_REG_MODE_AG.

Tested only with RTL8192CU, but these settings are identical for
RTL8723AU.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c b/drivers/net/wireless/realtek/rtl8xxxu/core.c
index d82cb7714314..be8ee6c30034 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
@@ -1252,7 +1252,7 @@ void rtl8xxxu_gen1_config_channel(struct ieee80211_hw *hw)
 		opmode &= ~BW_OPMODE_20MHZ;
 		rtl8xxxu_write8(priv, REG_BW_OPMODE, opmode);
 		rsr &= ~RSR_RSC_BANDWIDTH_40M;
-		if (sec_ch_above)
+		if (!sec_ch_above)
 			rsr |= RSR_RSC_UPPER_SUB_CHANNEL;
 		else
 			rsr |= RSR_RSC_LOWER_SUB_CHANNEL;
@@ -1321,9 +1321,8 @@ void rtl8xxxu_gen1_config_channel(struct ieee80211_hw *hw)
 
 	for (i = RF_A; i < priv->rf_paths; i++) {
 		val32 = rtl8xxxu_read_rfreg(priv, i, RF6052_REG_MODE_AG);
-		if (hw->conf.chandef.width == NL80211_CHAN_WIDTH_40)
-			val32 &= ~MODE_AG_CHANNEL_20MHZ;
-		else
+		val32 &= ~MODE_AG_BW_MASK;
+		if (hw->conf.chandef.width != NL80211_CHAN_WIDTH_40)
 			val32 |= MODE_AG_CHANNEL_20MHZ;
 		rtl8xxxu_write_rfreg(priv, i, RF6052_REG_MODE_AG, val32);
 	}
-- 
2.51.1


