Return-Path: <linux-wireless+bounces-16396-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6A29F2390
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Dec 2024 13:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8443D1884C76
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Dec 2024 12:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2602414D6E1;
	Sun, 15 Dec 2024 12:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="M4UipNo9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F23314A617
	for <linux-wireless@vger.kernel.org>; Sun, 15 Dec 2024 12:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734264262; cv=none; b=trCevCsWu9g9xT5JcUuroazUuqxuO9oEog6PoLs/Uh5AYSaq2QxIWPDgf4hxW7jnpZwIC/4K8KOXtjv4VoO6y5D3axZhTTHl0D8rYxb5r+roCGFijNf3Xz6N4LlrDwoEBV+tOdEVdm+gPmw4u6WvytCrDY8x/x8X+Rq23+zUkg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734264262; c=relaxed/simple;
	bh=+b6iKvlLuqWtfywn7QvZzgRUU22rSBSFV2jgP5NtGrs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DSo3cJ7pLxFMasHLZmmLnWrwStjubDn4tyK4QQBZg/rtBbQVrz1ja34D/2SFmmmLj7Oj8lyholHtJrH2tLoC9mbsJwkLP7c+VktmHtwZShKjAQAUepWEQVhnQuGkhoMgwkKHzZ2ujXK4wDtWAzfDt4Y3MoEmY0BwLv1rrHMobpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=M4UipNo9; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2166651f752so33641975ad.3
        for <linux-wireless@vger.kernel.org>; Sun, 15 Dec 2024 04:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1734264258; x=1734869058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NAwed1M2/1NaIoNDU19W3YXa72LDxlMeTobwsuQvXIs=;
        b=M4UipNo9zBZpzrfeSmJ2wqYq897hvxEojuuTvxG3Su2tr5yH6Y9G68n9Xv/oN0ei3M
         5AFTGmDp1xGe4Xe3ERga6fzg2u5GDUaaHiOvxDHVWBzgJuHhmYnm7Ez0P+YYxnDLkRUo
         mbjxOtkDFjNBX90z5iuNCXHRqoYhqKsZ6Mfwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734264258; x=1734869058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NAwed1M2/1NaIoNDU19W3YXa72LDxlMeTobwsuQvXIs=;
        b=V7v3eTHDgH5VlLkS9To38Pk20Rdni8OOxbz1UaXp19EwwT7OxuBfX+SbeOd9Fhd1uZ
         Ux8k+DdUcSukty2Gs+tIjb8JlCF5+y3efI0IhVp2i/12rtoCHBRiZqYMv1lPdSwXeh00
         BvelXBqOXKwIvlpMH9SkbmjywVYP78D31wouOqgn4aoA1ew0QBG42egh6C/I518Dx28X
         zx5inYExMhYexY8XNL1I/6IY66wbN6mQbFlv8e6wKMLVeyOrEtQulN+ng+ps8q/OQOsI
         1RPXFvB6Ncshd5OOLGn4lvDFrUtxN0k3F8/eR/kxjh/swYpU5CzJOYJfgC/EN3L6+Lul
         dWnQ==
X-Gm-Message-State: AOJu0YzKweJYzp3Slym/VmYLY5Qgof3Jk5YMqIl+9yTL0YLAifsNccoU
	1xtu4sKmMTFrX3Cl3OrNRw44AMVhiOmFJAYCwWlnBnVHAjaJ/HCCckoz0otAiA==
X-Gm-Gg: ASbGncvO6Zyx6CLg3M20jkt97eRlJ+n7Ndv7o2p1SQ84M3V4gMuTuJ3vi3wT5v1obG6
	hiDcBDd+NRQ9YyHKY8zjc9cWColGvzRdSj1WNgVHKtXxT4PsDVXH5jn84pCOwLO3c56mbk4CNZW
	qYKK7g0tvqTYXLeT//6aiidivZ+QsQNv4Jb9qNqa9U4ZPxgWT31yIOds+R8rb47BC+iAKBLiecN
	AhEyiVUDJxBJ5mssA3maiOC48g8w7m7b493L70fkzFlKuUuXwNLG+IsZdgZV8veIUdlUIFa6IGr
	KKeRyup/6cLACO9HlT3FFMpa7hhVefPBWIWz
X-Google-Smtp-Source: AGHT+IHGFAXGUOth+H0w/0Z1s8mmAldX66+A6ykESzk8pWlRaq0eI7XNVRSVNGgjg9ykCHjuvQ4HUA==
X-Received: by 2002:a17:902:e5d0:b0:216:7d7e:c010 with SMTP id d9443c01a7336-21892a5d708mr120392675ad.37.1734264258667;
        Sun, 15 Dec 2024 04:04:18 -0800 (PST)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e720fbsm25257095ad.269.2024.12.15.04.04.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Dec 2024 04:04:18 -0800 (PST)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: KeithG <ys3al35l@gmail.com>
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	Ting-Ying Li <tingying.li@cypress.com>,
	Ting-Ying Li <tingying.li@infineon.com>,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [RFT] brcmfmac: Fix structure size for WPA3 external SAE
Date: Sun, 15 Dec 2024 13:04:01 +0100
Message-Id: <20241215120401.238320-1-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <CAG17S_NqbLogvTWyoYobZ6kOpfXHnScfm4-dB1EqsmpB+q+zxA@mail.gmail.com>
References: <CAG17S_NqbLogvTWyoYobZ6kOpfXHnScfm4-dB1EqsmpB+q+zxA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ting-Ying Li <tingying.li@cypress.com>

Add pmkid parameter in "brcmf_auth_req_status_le" structure to
align the buffer size defined in firmware "wl_auth_req_status"
structure.

Signed-off-by: Ting-Ying Li <tingying.li@infineon.com>
[arend: adapted path to apply to per-vendor variant]
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 .../net/wireless/broadcom/brcm80211/brcmfmac/cyw/fwil_types.h    | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/fwil_types.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/fwil_types.h
index 18129adb5dc2..1cbe66526d82 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/fwil_types.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/fwil_types.h
@@ -54,6 +54,7 @@ struct brcmf_auth_req_status_le {
 	u8 peer_mac[ETH_ALEN];
 	__le32 ssid_len;
 	u8 ssid[IEEE80211_MAX_SSID_LEN];
+	u8 pmkid[WLAN_PMKID_LEN];
 };
 
 /**

base-commit: 1cac3bd863bef434d43e6b0554ac5d7f7f6350fe
prerequisite-patch-id: d5b3eb93d54bd6a0508a91f4627ec3e59a810928
prerequisite-patch-id: 653281e1349a038c7f48b3513243f3211fffab9e
prerequisite-patch-id: 0e47ab711ef159237e20c860834d3ac269b05eb2
-- 
2.32.0


