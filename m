Return-Path: <linux-wireless+bounces-10542-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E7B93CCE3
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jul 2024 05:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2031D1F2119A
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jul 2024 03:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83129FC19;
	Fri, 26 Jul 2024 03:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="aA+/kD+N"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510CB1C69C
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jul 2024 03:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721963742; cv=none; b=HqA0Ilt8Jv7y6FrDzfGN5uza2k9gPNtWCp95s3W3kNK9iO4gnozdz1gIxKpjt9UlRy0SoFHOGcNdENjw8WzTEAXfjAAGmZnHqpX7HQcLtZjFxJSkNpg6t7OTrJJZHQfvGAP/WGAGMOILdoNdbbj34xdznAxN4DofM2r/b8nqrjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721963742; c=relaxed/simple;
	bh=7mAt2sWmDgFj7qqrhY47r1PRD0xlll0wFv8TKxL6YlA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CNE9AfgaoTuJcg00bxVyjGyQIjl4eF/UcK7Lt8vBcIS8fCgMJTDJcaAY/+nXHX7G/7TI1HO+KYtvUhYN34GuAjxwBDN5xJmqj2zweMcBARPx0QZjeIuNJge5qGuffpkWYUOwGW9gAp3zyru4iqRykqAbToqNBFOc5IFPCOqjm/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=aA+/kD+N; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46Q3FQsvC011071, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1721963726; bh=7mAt2sWmDgFj7qqrhY47r1PRD0xlll0wFv8TKxL6YlA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=aA+/kD+NdyAlEq5X5W82XuCypV9Y1C7GmQ3IR6BLc74wp4yIO1vSuFQLlTO46G3Vl
	 2bo2eVZKb3hBgLJzdgGSD0jhL6hcvJqXlQifWsDNfubtzhWrM0LAGDjYSP0m3f3L6x
	 tdlPBdEjZwdZpMwpJszxC4JkEnpOtqckmyMdxMw8SXd8zMicOg+erOe/6TbDxMRbj9
	 f/SIzZmF1koR6gPeqzT+7B+UsFcmVrWB2gQ9I+egWtdeYlQdjk/Nlr3kbTU7gdOKG3
	 l2AnBym/BiXPN1pT/oT+eX0ORUB+N7EmUd4wCAOzFj65Tei8HwVdbgK73p38qtMMq0
	 0UKuFdarrgHRQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46Q3FQsvC011071
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jul 2024 11:15:26 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 26 Jul 2024 11:15:27 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 26 Jul
 2024 11:15:26 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: mac80211: avoid warning of no supported legacy rate if empty rate mask for rate control
Date: Fri, 26 Jul 2024 11:15:20 +0800
Message-ID: <20240726031520.7616-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

The commit 9df66d5b9f45 ("cfg80211: fix default HE tx bitrate mask in 2G
band") correct bitmask of HE MCS, and settings of empty legacy rate plus
HE MCS rate are correctly recognized instead of returning -EINVAL,
so empty legacy rate propagates to __rate_control_send_low() and warn
no supported rate.

Since the rate_mask is intentionally set to empty via nl80211, change logic
to avoid warning no supported rate if rate_mask is empty.

Reported-by: syzbot+8dd98a9e98ee28dc484a@syzkaller.appspotmail.com
Fixes: 9df66d5b9f45 ("cfg80211: fix default HE tx bitrate mask in 2G band")
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 net/mac80211/rate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/rate.c b/net/mac80211/rate.c
index 4dc1def69548..5787cb20de42 100644
--- a/net/mac80211/rate.c
+++ b/net/mac80211/rate.c
@@ -377,7 +377,7 @@ static void __rate_control_send_low(struct ieee80211_hw *hw,
 		info->control.rates[0].idx = i;
 		break;
 	}
-	WARN_ONCE(i == sband->n_bitrates,
+	WARN_ONCE(i == sband->n_bitrates && rate_mask,
 		  "no supported rates for sta %pM (0x%x, band %d) in rate_mask 0x%x with flags 0x%x\n",
 		  sta ? sta->addr : NULL,
 		  sta ? sta->deflink.supp_rates[sband->band] : -1,
-- 
2.25.1


