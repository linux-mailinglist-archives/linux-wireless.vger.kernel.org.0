Return-Path: <linux-wireless+bounces-28324-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D18C0FDC3
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Oct 2025 19:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD3D43A3D20
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Oct 2025 18:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEC531AF2D;
	Mon, 27 Oct 2025 18:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbNT1tbW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1197A314D24
	for <linux-wireless@vger.kernel.org>; Mon, 27 Oct 2025 18:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761588422; cv=none; b=aXZHZAJpHTAWeVnqs0o7Q472Mwk+igM3PjwYqkML5n9rGoZ76cZyVFe875Ot7l35CLpdGvUsn6JCxB8qDQ0z198k84bnQdsQbd1VRMD7YtaHM0si3RxM1XAi88iER8/f8aRpOZe1q8AXpCjdEgSIr7nxI7mutb1RHkEMTPX3N6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761588422; c=relaxed/simple;
	bh=S5EJ9XcCqpHYV/G/pMTycm1y6FReoUK/jP8Ub0QdsKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ueJF7ETtVTxBVMrGSZhjqczcfhun8IB6h7uWtWJFpLiM73kIPOXX2VYNTk/gdm9bre1bS6RPYzir2GrO1/JXTymyU/o7IwiU2v3PTGBXTsFBEYWvUI0CYN12f90rbKNY1wq9C4JEWNXO79j6m57uoK36cx7VWaYJdKxaws7hyvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JbNT1tbW; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-7ea50f94045so60292446d6.1
        for <linux-wireless@vger.kernel.org>; Mon, 27 Oct 2025 11:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761588420; x=1762193220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5tB+vgwG5bHZ8tPheIQQmyuiY0H1S/f7NnZas1yCE8=;
        b=JbNT1tbWx5SDhJF2vPZ8GVYO+ZUKNMq14e8BD3gPZWNn2D1GnNq4KKGWi0iYlQpDqq
         036PYCOwKj1e8h9cp77b2TYa1ev/3F2f8KpzX1AeiyvsR7hkEt2vXGlTTWo0q+tIM/ld
         uuyEljbtGY+ZH/qmja3hlWpt+dRqkpZOIK/wJioJ73EaK1GCbiXgFpGABnv9dRyuiCoN
         9lz9Wg/QM+ST33aLk2MFHl0UDUAGP61ovm/a3M+vA9bcoyNVd07zakGGu9yFMGLRLsZn
         L45SCt0wsuZXnw4XW0cE3bOwTJrlVi3ULf/ilE/7GfqTrty5JUWPvsFvbVETJjaS4wwc
         ccnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761588420; x=1762193220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K5tB+vgwG5bHZ8tPheIQQmyuiY0H1S/f7NnZas1yCE8=;
        b=dXCJeD/mQtkDtJ1lwI0tRBm8sBgdYd2ywCqdA1AdBSt99ouGJZmw/MEOfzZ/TRPh+F
         ueQw39259ihdBrnsWoKXIxCOuwmU5ilXHMMKxvO0bQ0Qx7AlvcnceqGQYJKRaFEf/eoh
         HAF1DviOz8ETvyU4XAJelDJ3At5y8y2PeNr//EzV77WhFSfzAni077telytWXsgjuvWK
         /Rnbedh6D+WXnfTQHOHSQ0NtYfLiezjl5ML2JJ3b1tqoO5PIEihxGAv0L3KC054bKw9E
         yyOiSZN2/MuL173CoiUnYU9yysH3fsCMGJ0ZrbZ8UZelm9/JJvMPOl1fcB+XXyKbDK0f
         15Tg==
X-Gm-Message-State: AOJu0YwhNqSN4Tq+fyut5qNQGhso5hlZItDLgR43q83M1DcNqfqvYcMi
	tjfJwuEYlIbTDixYU//lXcR1Ya8aQsL3OWSIKcJNcmyvJN+kx0B9QK2EJR0zbg==
X-Gm-Gg: ASbGnct8m3iP3qTmFjrPaOTPBsquT6HUomCowRMRDRinJCUjdhSC49FH/G4nsnsml1f
	sJUpV9TRyR/jB0yqRh2m/OB391ooNWI13HiiJZSN9RlmyKOkVwTFlfjLw6TcwzW9DuklvZsVIId
	9jKUDpANq/MK7juct2SfCQQ5fNdh1oZYaJrfSbJfFqqCgFppoP6n4C+oR0cpND/JCOJGwXdaoH5
	9Wsrfj0dpfQTqVcVX3MqaE1qGqauWPZT9hBSMtE02rcLLfYAI8dqdIF000M1vrlwc4msIgVEfC9
	9Qh9DDvppFa2+IkRQRE4HulXl0289a3A0yfJOE7lyAzFyCpPFWSe5CKVA+86zC7Yw5on4iMCh+d
	7fR17p8KZyHxQsIxPX+YyeZ0lE4S7wJv2qdAn5J/g4dmtTv9XE/XA9/rwQg==
X-Google-Smtp-Source: AGHT+IEHn9rjC5GIZfbJaC/Wtg4QIixDKg5Hpt/C2qQW9ZsqfAuXCErSqKYeOZ7HcP2rIQpvBj+Z5Q==
X-Received: by 2002:a05:622a:1b20:b0:4ec:f017:9e26 with SMTP id d75a77b69052e-4ed089db331mr4530611cf.26.1761588419829;
        Mon, 27 Oct 2025 11:06:59 -0700 (PDT)
Received: from ryzen ([2601:644:8000:8e26::ea0])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eba37fa7b9sm55446871cf.17.2025.10.27.11.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 11:06:59 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Stanislaw Gruszka <stf_xl@wp.pl>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 wireless-next] wifi: rt2x00: check retval for of_get_mac_address
Date: Mon, 27 Oct 2025 11:06:39 -0700
Message-ID: <20251027180639.3797-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251027180639.3797-1-rosenp@gmail.com>
References: <20251027180639.3797-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_get_mac_address can return -EPROBE_DEFER when nvmem is not probed yet
for whatever reason. In this case, nvmem mac assignments will not work.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
---
 v2: add wireless-next tag. delete misleading function path comment.
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c |  4 +++-
 drivers/net/wireless/ralink/rt2x00/rt2x00.h    |  2 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00dev.c | 10 ++++++++--
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index b264ed0af923..f07152fa3725 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -11011,7 +11011,9 @@ static int rt2800_validate_eeprom(struct rt2x00_dev *rt2x00dev)
 	 * Start validation of the data that has been read.
 	 */
 	mac = rt2800_eeprom_addr(rt2x00dev, EEPROM_MAC_ADDR_0);
-	rt2x00lib_set_mac_address(rt2x00dev, mac);
+	retval = rt2x00lib_set_mac_address(rt2x00dev, mac);
+	if (retval)
+		return retval;

 	word = rt2800_eeprom_read(rt2x00dev, EEPROM_NIC_CONF0);
 	if (word == 0xffff) {
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00.h b/drivers/net/wireless/ralink/rt2x00/rt2x00.h
index 09b9d1f9f793..665887e9b118 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00.h
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00.h
@@ -1427,7 +1427,7 @@ static inline void rt2x00debug_dump_frame(struct rt2x00_dev *rt2x00dev,
  */
 u32 rt2x00lib_get_bssidx(struct rt2x00_dev *rt2x00dev,
 			 struct ieee80211_vif *vif);
-void rt2x00lib_set_mac_address(struct rt2x00_dev *rt2x00dev, u8 *eeprom_mac_addr);
+int rt2x00lib_set_mac_address(struct rt2x00_dev *rt2x00dev, u8 *eeprom_mac_addr);

 /*
  * Interrupt context handlers.
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
index f8a6f9c968a1..778a478ab53a 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
@@ -988,14 +988,20 @@ static void rt2x00lib_rate(struct ieee80211_rate *entry,
 		entry->flags |= IEEE80211_RATE_SHORT_PREAMBLE;
 }

-void rt2x00lib_set_mac_address(struct rt2x00_dev *rt2x00dev, u8 *eeprom_mac_addr)
+int rt2x00lib_set_mac_address(struct rt2x00_dev *rt2x00dev, u8 *eeprom_mac_addr)
 {
-	of_get_mac_address(rt2x00dev->dev->of_node, eeprom_mac_addr);
+	int ret;
+
+	ret = of_get_mac_address(rt2x00dev->dev->of_node, eeprom_mac_addr);
+	if (ret == -EPROBE_DEFER)
+		return ret;

 	if (!is_valid_ether_addr(eeprom_mac_addr)) {
 		eth_random_addr(eeprom_mac_addr);
 		rt2x00_eeprom_dbg(rt2x00dev, "MAC: %pM\n", eeprom_mac_addr);
 	}
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(rt2x00lib_set_mac_address);

--
2.51.1


