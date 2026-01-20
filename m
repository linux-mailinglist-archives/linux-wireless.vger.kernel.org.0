Return-Path: <linux-wireless+bounces-31032-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFhVBM3ub2m+UQAAu9opvQ
	(envelope-from <linux-wireless+bounces-31032-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 22:08:29 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE6C4BFAD
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 22:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A639C4ADB83
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 20:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F08F3ACA5C;
	Tue, 20 Jan 2026 20:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVr/EIx2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f67.google.com (mail-dl1-f67.google.com [74.125.82.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECA93A7DF0
	for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 20:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768939872; cv=none; b=eSnIc0kfel6c/ExndIGhu5/EKojjBBZ45MNtriS60+tqFAy2S9Fsq0ps4/sbi/dfvbfFgfgQ+72I4JLspNoieF8ISVFSXJwvK768rJj0lIzed4IXya2Lf2ryuXuy8ChY7644/zjpbOT0yMEK8BMN+cry7cnIMLWYbdy7y7oQQp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768939872; c=relaxed/simple;
	bh=cJcXyjEZSUQDGUOvvl04ViXnS4Gd51j6mnYPp5zBgFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fyz50P1suOjlxDCt9HnUV57BJRLLQvvnGWK0RIAyubKoONpiIx3DEtMUmCJWaEe711M+oku/eQ/ipjExxtAI+rXKNky/HFAitiz8ArFbBrvBwEqM0zdZXgNmdTgGwUB1MBoszLW5MbNhjb/ClO1ey3Xp/PpANY+9CrdNQn4Yu64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NVr/EIx2; arc=none smtp.client-ip=74.125.82.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f67.google.com with SMTP id a92af1059eb24-12336f33098so4746736c88.0
        for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 12:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768939868; x=1769544668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yt1mPPXw8aFoKYpC5Tia09ZY3lzzrV+SydYHdLpjRKk=;
        b=NVr/EIx2FKq/ZMv0F9t1uLX6L4SXttia7t1/nBEPrD7HdG/xHxdq4HhS9h8SoMhjWi
         RW7fVBRkuVhVtOkIm3potvXJOCnQuVo8r6wU6ddwI3dF8LRExk7YuyMy3m55AOXm/zcF
         J+jWgY2c+dxEtklWMSUmLDIQEa/OSI+MsmVR3upUJEr/tAHfDCde5+9rCFohCrGV3hpG
         k2CPUceBGO1ta/2fAQJlKijGqc2dBcqz3schVZFNp2ajQyFD4pchLKLUMtufvDvnbIaS
         4CXEAirIY6gxCdBLwaGKjMDZJvbvCEu2fh2gG0AGguRcMMtfYPvyZ28erZo4SZZptDbx
         nsWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768939868; x=1769544668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yt1mPPXw8aFoKYpC5Tia09ZY3lzzrV+SydYHdLpjRKk=;
        b=kHfWDNqmiyRsbjQ01FNyEAZBHM0jn3XrjAUkd1bds1uHoPlYqouuveo3WumoqNh6nW
         2L4tYDBpHoYlTd9dwHZay3aCxo8Ek3Gr+EQQ5TeJzlQrS2+hmgGjsfwqwmCEmDsVKpNN
         ZcoYq3FAVnbS9aa2nf1klADPZCDBBE3wW7GMFbXRChGyyQBSb14ks/Ix4jGdYwh+hU/i
         CPiCc1HP4BUowHT8eSWYBdBf1q72AKrKEEUEMe6Iu6unroLU6MDM8saqbzGBFDlacg5e
         dEgJBFATddJrWwTnxrt8snSfOnQDsLcABk/sfXaUUS9xIyow3KwliXyLizKhjxzoF8ex
         NiOw==
X-Forwarded-Encrypted: i=1; AJvYcCXdRFQDfHG+eN9Efrn6CpkpQxzDOufrifQAQZJjolpRTg5RDwNxzC4zK0GttUSvdCuB4M9O7JpVCbTfzo5MnA==@vger.kernel.org
X-Gm-Message-State: AOJu0YylsVbo7sWR9f0FsDW5alsMQ29cRUZAuEzdfR5QCO863aC2qlrB
	e3do95tuEuyU4PVmL+rQbi7GmZDThJWhGXgLraJQBMof8XcOo2GUDz2v
X-Gm-Gg: AY/fxX4katrdjFqsT/Tts1W0VazqLZFw4GxYhylarhp11Gkahh58MIGw8BR/PuLEQMP
	mq//1cw1iVP5AgfOAzJoti3FjAZuW3R0NRml1dy7wGaaGY8F0TMcExvLXA37umZ7uBflL2K5ovW
	MmGGQgnty0I8DQfd8J5AJ910Tc2wXgMc0Wh91MplF9HvF/TyxtSVOHUbnbrH4zFlDkezeDvzec+
	E/cP575bkmiwuTNC87qaKIYVfQY43by6T/AC55/BzqnI/itYCzz5pb6FGk8RzJUkYqvSo8TuQhZ
	wQG6FOytoLKY0IR/pyBYiv+ito6BOAViVdAyKR4XYwir0kBcNRNUOaatSN175yi6ydsw01bQARz
	BSpJMEu6z4ka69IokmFlcDYQFEi5AoLAEhjSYSqCl+wlfD3/2ttf1YEHDR1NS65H9kHx6gOruCK
	JVX4pzsZf1Mh6lrbP56TqGKB6VmsBEzKj9J9f+mO7BwvodUDW/7za6IJ+Nase+fw==
X-Received: by 2002:a05:7022:608a:b0:11e:3e9:3ea1 with SMTP id a92af1059eb24-1244b37fc20mr10744650c88.50.1768939868222;
        Tue, 20 Jan 2026 12:11:08 -0800 (PST)
Received: from zcache.home.zacbowling.com ([2001:5a8:60d:bc9:4a3c:9f7c:8037:90c1])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244ad7201fsm21982990c88.7.2026.01.20.12.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 12:11:06 -0800 (PST)
Sender: Zac Bowling <zbowling@gmail.com>
From: Zac <zac@zacbowling.com>
To: sean.wang@kernel.org
Cc: deren.wu@mediatek.com,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linux@frame.work,
	lorenzo@kernel.org,
	nbd@nbd.name,
	ryder.lee@mediatek.com,
	sean.wang@mediatek.com,
	zac@zacbowling.com,
	zbowling@gmail.com
Subject: [PATCH 09/13] wifi: mt76: mt7925: add lockdep assertions for mutex verification
Date: Tue, 20 Jan 2026 12:10:39 -0800
Message-ID: <20260120201043.38225-10-zac@zacbowling.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120201043.38225-1-zac@zacbowling.com>
References: <CAGp9LzrcvW18xKFL-oF3wxRmb73G6PN59Y2NSA2E5idva1wtKg@mail.gmail.com>
 <20260120201043.38225-1-zac@zacbowling.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[mediatek.com,kernel.org,vger.kernel.org,lists.infradead.org,frame.work,nbd.name,zacbowling.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-31032-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[zacbowling.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_NEQ_ENVFROM(0.00)[zac@zacbowling.com,linux-wireless@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zacbowling.com:email,zacbowling.com:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: AEE6C4BFAD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Zac Bowling <zac@zacbowling.com>

Add lockdep_assert_held() calls to critical MCU functions to help catch
mutex violations during development and debugging. This follows the
pattern used in other mt76 drivers (mt7996, mt7915, mt7615).

Functions with new assertions:
- mt7925_mcu_add_bss_info(): Core BSS configuration MCU command
- mt7925_mcu_sta_update(): Station record update MCU command
- mt7925_mcu_uni_bss_ps(): Power save state MCU command

These functions modify firmware state and must be called with the
device mutex held to prevent race conditions. The lockdep assertions
will trigger warnings at runtime if code paths exist that call these
functions without proper mutex protection.

This aids in detecting the class of bugs fixed by patches in this series.

Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 94ec62a4538a..1c58b0be2be4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1532,6 +1532,8 @@ int mt7925_mcu_uni_bss_ps(struct mt792x_dev *dev,
 		},
 	};
 
+	lockdep_assert_held(&dev->mt76.mutex);
+
 	if (link_conf->vif->type != NL80211_IFTYPE_STATION)
 		return -EOPNOTSUPP;
 
@@ -2047,6 +2049,8 @@ int mt7925_mcu_sta_update(struct mt792x_dev *dev,
 	struct mt792x_sta *msta;
 	struct mt792x_link_sta *mlink = NULL;
 
+	lockdep_assert_held(&dev->mt76.mutex);
+
 	if (link_sta) {
 		msta = (struct mt792x_sta *)link_sta->sta->drv_priv;
 		mlink = mt792x_sta_to_link(msta, link_sta->link_id);
@@ -2853,6 +2857,8 @@ int mt7925_mcu_add_bss_info(struct mt792x_phy *phy,
 	struct mt792x_link_sta *mlink_bc;
 	struct sk_buff *skb;
 
+	lockdep_assert_held(&dev->mt76.mutex);
+
 	skb = __mt7925_mcu_alloc_bss_req(&dev->mt76, &mconf->mt76,
 					 MT7925_BSS_UPDATE_MAX_SIZE);
 	if (IS_ERR(skb))
-- 
2.52.0


