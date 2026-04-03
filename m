Return-Path: <linux-wireless+bounces-34339-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHy7DlEX0GmV3AYAu9opvQ
	(envelope-from <linux-wireless+bounces-34339-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Apr 2026 21:38:57 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C974397BC7
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Apr 2026 21:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E06530071F1
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Apr 2026 19:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF8E3D5677;
	Fri,  3 Apr 2026 19:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RnFiOnXC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC92363C58
	for <linux-wireless@vger.kernel.org>; Fri,  3 Apr 2026 19:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775244819; cv=none; b=KXWj1rApEIVgncYK1S88WpiqqWamT4SwE70EKsVGGIpEeBrgjT/SAudxBu6Kw2pdu/sqg7QYJN2kBID972znHkW1MFRbyI+ErAUt8P6H2IpjlW+2eb1BvWoSK3yvwZ5JQviPNMa2Lhbf3YT8maN+3bgOVxlh0+lA05JeFqw3cN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775244819; c=relaxed/simple;
	bh=42PyYXbbrCXrnlLrkcAJSkhIJKA1qYoiOfjYEveJ0/c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dtr/jPiXn55HkTPTV7S8UJLdF9X+YNsfS6nzAVn6SNCIVYGSy13LqdxRmxyX6+BUqqor7uEyecvTDLFfX2nQk0Sj6vPgTExujFGO2WuHLia2u7VrXszTx3FUVz26ERW+oUTnEldw0Slc6AjtoaIEnCOeVl9lcdergueMdITM8+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RnFiOnXC; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-463a0e14abfso1295973b6e.2
        for <linux-wireless@vger.kernel.org>; Fri, 03 Apr 2026 12:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775244817; x=1775849617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OQH7/NI1jwBIKC/CRnXuSNLGKjUStOMp1+ygXfJhwDU=;
        b=RnFiOnXCG1AvLf6/HlNZhrtX8xmCU7JPbh0vioaMBfCCSU97MnY+vUDNeH4T+PhBX9
         /L0uVsDNnzNKUlnQxeoOVgVBF8Upehu9m+sJYzQCKZe/vOFtxjt3XKdKCStRaFtlsGGS
         bkn1d4qhkbgUPOv8y9NF21UAhLfPCwYv+6cstU6CS52QSEkIETAW2q5kEi+p7hLBPYv2
         8uqbvYbdBj5FrOdyls7pYXzqSXEZQHCGDWVNWK0q7VW7eWd7018Gv2LHdOLDjQhvt0+3
         3StkzJLqDv33whtp5gJZM10PBkQgiQ97KKZL7SDYalWWZHTKTzv55VzeXDfwbzxCssPq
         1nbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775244817; x=1775849617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQH7/NI1jwBIKC/CRnXuSNLGKjUStOMp1+ygXfJhwDU=;
        b=qTVadqZb2B1PLwGvGwhIE3AX2DdxjSMvMiVcC9u2uARqrOFGZXrhpaJ1vKiAqP0ynT
         pU/cyCqlII4wuv5qeYA7BOK6YJciB10JpcH01VeeQOH6T3AZ01BV+Jt+foPjGeKUzIad
         xwav+T/x4JSBtcgO2w6IcipzOZqxWj1a/rvu40ZbZbq4fLaJZjj041fA9GJE2NqmCzpv
         rE230NjyZW+Hrp4oMtxxahMit8jbJ/bOMlf0q9an5XKEz5MGS17tCbqahLgxnJ4bpiAz
         wC5NweRfvt6N4+H8XUuaA/uGdIVc8WcN0wXVpvU8gZVSqYzGuxZCCG/GeDTcscIBIK4V
         uegA==
X-Gm-Message-State: AOJu0YzmZ56702WdQerKr+eVAB/Z4HZdM6zgxE6MyB3eRICTRyMeiLlX
	0yDRtPzVlMnRVv8RRl4jhfNKj7aGmR0UgzakELR5sXcUdDuXKNqF40/X
X-Gm-Gg: ATEYQzwPJdkXTVxosGOggsOm20E1RAapwu0+4h9vAhnuFypTnVbrsKSUn9l16e7yK/V
	7NtnFxvUVoD/R8FBpyMvEUzVGCWfmL4TYlquceunXlS2WPUJvkv5t1dO0+syw5fJF2Mi6GXDER2
	TQIEHD86M0l1c4GGj7IfgZMWBuJzGVtNMGs3Z1X5v9zy1AIawpc16br35ltwBVNLrnSJW83nuhK
	+EWqT5qi2rkk6hkuIqnnKF+GZ5Rh3k6uOA/uqL+r6+qDEPS6SuYCTRUQr9Ok0ayNk2lEd6T06zU
	+thJyqEFNjRf+nOUV+ShtkYVa1yJ0FKOz9WL/Xb6TyEKpixi8ujA3v4E5MIe8GJl33cxXo3T3sn
	YewsB93svR4c6mVzzFPB2wuPdIL1Eh7Urj1CFym7ua2b1epEdKZ5NMFmbhJ/ewzaL5sP9xMs3eu
	4pj/PJGBSsrtVJdwXSOX5QIPrgKEN+C2yg3WnaJTkcfAG6V9bwwBs=
X-Received: by 2002:a05:6808:4fe9:b0:45e:84e7:c20b with SMTP id 5614622812f47-46ef791a149mr2203314b6e.25.1775244817319;
        Fri, 03 Apr 2026 12:33:37 -0700 (PDT)
Received: from Linux-Ub241.fyre.ibm.com ([170.225.223.17])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46d93271094sm3942276b6e.15.2026.04.03.12.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 12:33:36 -0700 (PDT)
From: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
To: arend.vanspriel@broadcom.com
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
Subject: [PATCH] wifi: brcmsmac: phy_lcn: Remove dead code in wlc_lcnphy_radio_2064_channel_tune_4313()
Date: Fri,  3 Apr 2026 12:33:24 -0700
Message-ID: <20260403193324.141753-1-chelsyratnawat2001@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,broadcom.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-34339-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chelsyratnawat2001@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8C974397BC7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The variable rfpll_doubler is initialized to 0 and then unconditionally
set to 1 on the very next line, making the subsequent check for
!rfpll_doubler always evaluate to false. This results in logically
dead code that has never been executed.

Remove the unused variable, the unreachable conditional branch, and
simplify the fpfd calculation to directly use the PLL doubler values.

Signed-off-by: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
---
 .../broadcom/brcm80211/brcmsmac/phy/phy_lcn.c       | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c
index 8cec5ad79fda..d65a68045ca8 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c
@@ -1607,7 +1607,6 @@ wlc_lcnphy_radio_2064_channel_tune_4313(struct brcms_phy *pi, u8 channel)
 {
 	uint i;
 	const struct chan_info_2064_lcnphy *ci;
-	u8 rfpll_doubler = 0;
 	u8 pll_pwrup, pll_pwrup_ovr;
 	s32 qFcal;
 	u8 d15, d16, f16, e44, e45;
@@ -1618,18 +1617,12 @@ wlc_lcnphy_radio_2064_channel_tune_4313(struct brcms_phy *pi, u8 channel)
 	u16 g30, d28;
 
 	ci = &chan_info_2064_lcnphy[0];
-	rfpll_doubler = 1;
 
 	mod_radio_reg(pi, RADIO_2064_REG09D, 0x4, 0x1 << 2);
 
 	write_radio_reg(pi, RADIO_2064_REG09E, 0xf);
-	if (!rfpll_doubler) {
-		loop_bw = PLL_2064_LOOP_BW;
-		d30 = PLL_2064_D30;
-	} else {
-		loop_bw = PLL_2064_LOOP_BW_DOUBLER;
-		d30 = PLL_2064_D30_DOUBLER;
-	}
+	loop_bw = PLL_2064_LOOP_BW_DOUBLER;
+	d30 = PLL_2064_D30_DOUBLER;
 
 	if (CHSPEC_IS2G(pi->radio_chanspec)) {
 		for (i = 0; i < ARRAY_SIZE(chan_info_2064_lcnphy); i++)
@@ -1669,7 +1662,7 @@ wlc_lcnphy_radio_2064_channel_tune_4313(struct brcms_phy *pi, u8 channel)
 	e44 = 0;
 	e45 = 0;
 
-	fpfd = rfpll_doubler ? (pi->xtalfreq << 1) : (pi->xtalfreq);
+	fpfd = pi->xtalfreq << 1;
 	if (pi->xtalfreq > 26000000)
 		e44 = 1;
 	if (pi->xtalfreq > 52000000)
-- 
2.43.0


