Return-Path: <linux-wireless+bounces-34437-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLAtNpiY1GmkvgcAu9opvQ
	(envelope-from <linux-wireless+bounces-34437-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 07:39:36 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 917FB3AA018
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 07:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6E4D8302C32B
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 05:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CD823C4F3;
	Tue,  7 Apr 2026 05:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqL4CH2p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322F172617
	for <linux-wireless@vger.kernel.org>; Tue,  7 Apr 2026 05:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775540368; cv=none; b=AmuSR4b+fUZC+kRvdcxPfV32ZJHwMV+xmhJIo59yE03EpI1HYaFhrskKs6WoRpXmKvjpZpZlNZcCRgI22DKwPl98HZpx6Zi13gvdSEIUjYOH9Kk3X95vne8d7AQ/81Zkn0ipC8tNvQ6QlrImz37ilHD1kHF+Bb/VEKjaqWiF2KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775540368; c=relaxed/simple;
	bh=nLB2b5wL4mUgyVxryiliny0HR6ogqociCTBoN0V010U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rdr1+Vs+ySv5aq+lpEntR6eAmAOM7VKb1NAm3LBIID5HlPXUN9TZ+XQIitxOjJi3mO1Hpk85HqFz257/ikT5cQEa1QcT6Hkrh3kIhwhTmWP3iH7X4ggvHi3A1qXJwauCWDckNt4tBibniy4D2Y/GlK5Gz2P6ZrS/TMKb53+IrhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hqL4CH2p; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-65075c2ba66so798581d50.1
        for <linux-wireless@vger.kernel.org>; Mon, 06 Apr 2026 22:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775540366; x=1776145166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6LWa++mcPY3R4bD8/yjfZwPnWZrMl/x1vqxM1wZ12zs=;
        b=hqL4CH2pqnCj/wA7RD2V/y4nSQgxlnZZBfokaxVr7FFmEYcIEn+4k34tMQDTMmj9LY
         m3msBbvp5wjZjmyv23+fUWC/kAUCaYvLfF/jQpZxQj84tz+oKV48eWly6e8oPWK/afZn
         CReBGBZmCppaquHkOR/lOB3z3VY659zMb+uqhTv7klHGOWpR+ffv7J/wti1uwWJKo6cW
         3GKtneTFpuMDLNTpCEg89wDPk9EayHIuEW24CMKHt8QgwiP9GmOa/XVD56vjobpTBRz/
         FqLBmFhgvfDItJ+31rx5kat1RiqIZv28yDXHdiYmKTTZ3c6Ujx/YBTVhFBRvxknAIucs
         OSpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775540366; x=1776145166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6LWa++mcPY3R4bD8/yjfZwPnWZrMl/x1vqxM1wZ12zs=;
        b=koV4bOVdJLR2j+SSpwaGgsudUmexmwys30tbMKIpxfOIVJv49BSx0FrGa/drI2p3Vx
         D5BcFlAQ7PxOQeZJWs3snkraEQCHm/Usi7+i7ooPye0/oPXofjgt1FeuFxsoBOtgVUsU
         xR3/juo8KjAcu9Dwkt19rvRdk85Syg66YHVa4L8xw1QT6NCTzaa73gbVCHA0zaS8ba2T
         YzgaeW5GC47c7sDtRSoBVZWkmANpRaiZCQiz7Af9VUXslLI0PG8eikuRVuY3NpZ3/tzR
         bPvArvzjw70RQRAPRmsds8cfD2T3pcwdjuTzjXc7SuVHKh45V4/S2ooVeiiGfL7ezIgl
         3iuQ==
X-Gm-Message-State: AOJu0Yz6gicnCMmH7H8ljzFh9Kspb5osovSF20YQcAGOz24dS77n4z1b
	z9/a1OW+9Icj9rNGiNkX5jYFAoSTDSLOkmuiSr09w/A7Qh9RSICm6lNIe7yyVbi5
X-Gm-Gg: AeBDieu079n1DvtDeLKDTNG2HPahARk10zkvUV+AnEhbX4SweynR06+n3WisAcil2In
	tG4gg+MUCDL8wg++QlPEKq7akJ36KGXP56fnAKBXAwcAShjECbqpYXbrarR7hJZbSR6dwqX4cgW
	JzpBCMbInXHMr/lJvAfYXAs7X845VXRkscBVfQAkL92c3T8BHUpsO8UWFr4kcgZNOsrMzVbc3Yg
	rAuFJ8XojkKf4AoIxOnsmOruu6oJ4qK53JleS8orAlnNKxybNPbefTQUM75hftZX9EVgE52XxEL
	A3LpLPQONt0zuf6k77iWzu1k4Be3HPnVn7TOgQpABBLeOv5ofU1EpeTjx52dUZs/aberY2/R4dA
	38Tl7c6qfxZUEnDOxr6duT3PiLI2W0Fop8VwRekKHkYW30CaifmKLGxnBeI6wZEccyMGRtwazF/
	IhJW0QCQ8NGtoVBs+NcH/lflCLij+V+wkzQ4D6anKAT74y0F7W6Qu2YRthJuKk
X-Received: by 2002:a05:690e:43c2:b0:650:311d:55cf with SMTP id 956f58d0204a3-650486c0668mr12455032d50.15.1775540365813;
        Mon, 06 Apr 2026 22:39:25 -0700 (PDT)
Received: from DEV.lan (c-75-74-152-49.hsd1.fl.comcast.net. [75.74.152.49])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a978b7csm7217468d50.11.2026.04.06.22.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 22:39:25 -0700 (PDT)
From: Joshua Klinesmith <joshuaklinesmith@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	Joshua Klinesmith <joshuaklinesmith@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH wireless v3 3/3] wifi: mt76: mt7996: clear cipher state on key removal for WED offload
Date: Tue,  7 Apr 2026 01:39:17 -0400
Message-ID: <20260407053917.75898-4-joshuaklinesmith@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260407053917.75898-1-joshuaklinesmith@gmail.com>
References: <20260407053917.75898-1-joshuaklinesmith@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,mediatek.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-34437-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuaklinesmith@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 917FB3AA018
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Same issue as mt7915: link->mt76.cipher is set on key installation
but never cleared on removal. The WA firmware retains the stale
cipher in BSS_INFO, sets the protection bit on WED-offloaded
frames, and drops all plaintext traffic when encryption is
switched to open/none.

Reset link->mt76.cipher to zero and call mt7996_mcu_add_bss_info()
when the last group key is removed. The clearing is guarded by
checking that both hw_key_idx and hw_key_idx2 are unset (-1) so
that GTK rotation and BIGTK removal while another group key is
active do not trigger a premature zero-cipher BSS update.

Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Cc: stable@vger.kernel.org
Signed-off-by: Joshua Klinesmith <joshuaklinesmith@gmail.com>
---
 .../net/wireless/mediatek/mt76/mt7996/main.c  | 23 ++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index f16135f0b7f9..8b1bc3237527 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -244,10 +244,27 @@ mt7996_set_hw_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 					&link->mt76, msta_link, true);
 	}
 
-	if (cmd == SET_KEY)
+	if (cmd == SET_KEY) {
 		*wcid_keyidx = idx;
-	else if (idx == *wcid_keyidx)
-		*wcid_keyidx = -1;
+	} else {
+		if (idx == *wcid_keyidx)
+			*wcid_keyidx = -1;
+
+		/* Clear BSS cipher only when the last group key is removed;
+		 * during GTK rotation the new key is installed before the old
+		 * one is removed, so hw_key_idx still points at the new key
+		 * and this condition stays false.
+		 */
+		if (!sta && link->mt76.cipher &&
+		    msta_link->wcid.hw_key_idx == (u8)-1 &&
+		    msta_link->wcid.hw_key_idx2 == (u8)-1) {
+			link->mt76.cipher = 0;
+			if (link->phy)
+				mt7996_mcu_add_bss_info(link->phy, vif,
+							link_conf, &link->mt76,
+							msta_link, true);
+		}
+	}
 
 	/* only do remove key for BIGTK */
 	if (cmd != SET_KEY && !is_bigtk)
-- 
2.43.0


