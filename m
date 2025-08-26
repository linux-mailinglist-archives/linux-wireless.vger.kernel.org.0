Return-Path: <linux-wireless+bounces-26624-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF02B357B7
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 10:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 969661B245E9
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 08:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9322FE054;
	Tue, 26 Aug 2025 08:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="pH0MB6EV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5152FD7AD
	for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 08:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756198514; cv=none; b=DDIpWj2c98NJcmBIVbbDV0X6ljfYQN10ZkMpGLLwsDrihdjFGmeF5VXVazsKhA4K9Yo7FpBDUi1v/LZsXDCCeXr6iiOijGnDQ4RYZsHqCpRwE/NrGPmkRIRCT0UMrqE1umcRwnA82Ltpzg4yJEKIcdhLreMkqo4Ccxp/JUbJ7/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756198514; c=relaxed/simple;
	bh=sc595x+KtFvGk9YlBS9LWyg+0OJ5im06kYQTJjPAztA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OJQXuVACAOJ8HJ4onUALn94MPr2UaEByhkgi6bMUBa9MqLZePLKhOC+6yhDwzla1DPkAJzu8ckQMQbVH+JDffMzvOcJlwGB8/f/jPBbVBjQX5ZGCTquF4rEAHJT84E+Ihpk0QTQozhftyYQ1l/vIbVq4SV1NDGS4QSKZ6yKcKKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=pH0MB6EV; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so4800882b3a.0
        for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 01:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1756198512; x=1756803312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mXl4IFqxe5m0wPFaUIkM3rluTFeqSx2cm1kXGo2k5x8=;
        b=pH0MB6EVfPdtpb7PNIsCOiBW0VsSmLVVWq1mLkI/CdTz3rjFz70WsUpSNudVq8IOu9
         8fB5A0rNgp9DEyJXfNJcGQ+Si65u3Ur/1QnTQZ0LCsT2f1uJ9gQnBb+Bn5NKKLyLA8Dr
         TfbIN97uzAnMUzoUejqa4iMWfQHch5tsARcnFTPZPnOps0rV/p8uU1feHgNvS3n0L5Hs
         y3UFYFxe6i1XDd29y8Smz4JSxxATPvvEMy3+wHsIQ8gG8ZcWQLYy/0gLSmsT9p9ay1/R
         Xurb1cpxb8u7vxUl/tkLO8JjKQ9kc9hYvzZdiE4ZCLwbbGLrtD6e+D65gdfmhjxl7ojV
         /7JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756198512; x=1756803312;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mXl4IFqxe5m0wPFaUIkM3rluTFeqSx2cm1kXGo2k5x8=;
        b=DXpXOiDTCNZu4qHbLjU3V4OPFjOOM+sgcXR0iFWVbYb4jrXOXhKQvm376yO5gJ4ulB
         zNkZtpXwAHeF0ilGuz+GUGCLcdLmvrTNnB2S8awhSZf6/mwLGcpudGGoMJi5OBqzwU+/
         VcuAuLJtQsw/jOpAKdwqTHUS9S0tHdFI9zYhvzoo+lj5Ijq8B3SEHS+jNtyTfmP8+Yn9
         vYLPA5tW9irLpu3fh+C/6uwEzBK2AgC4Jf+mS/JRfHsFjdT5slhqNVwvY+qfmFkej1ny
         yr5sLbuGfEbTLv4f+0QquVT9zvymNvYBYzhV/mNNfCxyrGQzLr0mNDIVayo+3rMjJ2XD
         5Z4Q==
X-Gm-Message-State: AOJu0Yzhq9osxhCSZpXGxo7bXqOlXxK5NJJ+G+Jn0x7fE3ynybdJgfCa
	Qcd29ANZOthh6M/e4LDlItpQuauz1L5XopHNBqdHx45nfuu+FAPkdziiDbL9szGp4SI=
X-Gm-Gg: ASbGncv1QPh+x4USvop0oXM7/aEmBXI99fZkSlAVk8sCTqPYLOCaiYFCYuwj8OfniaK
	+0qJ8/x87IEKNgVH1dsx8mamVNRoXVx4F+gQo3Zl5IfopA4kR8K+5DJ+oKThfPnXdlWQP040KlI
	eRVnxh2iyfchAvXRmCRM+Aw/UX0891nAkiOWUD4nQG3wbbX91ikCDsz/Zw/cWPX6cABgo4HC1WF
	36g5zHiMdwjCQjZG9IANRLkQtU5Xybi4t7w2uDA5hvKBSeUOVIPVarPLuUipTpjy96gTUkSJYyq
	F3P+OhFbbKRcPX2skfm2hpllR3OUXnnvkhJ9vNFdu8RBv1+T0iG021hYXWoqGyQ4kPCW8S4p4kY
	qs5XN9mTGTcWVhJ4+mzF2aRUsvKj61MLO010QpcKEdcss7HkPDdDgQV6wPb8o4ao8hPTRFMogqZ
	68e7rh0Pc0XXOPxi2CmHfIO/A5ag==
X-Google-Smtp-Source: AGHT+IGiCq5661jX9TFbM5C4rfplQwWVHi+AWQUnioD8R+ffZZBQysh5HrtZq/LgGncGx8F5iJUJoA==
X-Received: by 2002:a05:6a20:1585:b0:232:7c7b:1c7b with SMTP id adf61e73a8af0-24340c429e2mr24666358637.14.1756198511827;
        Tue, 26 Aug 2025 01:55:11 -0700 (PDT)
Received: from localhost.localdomain ([60.227.224.187])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-771e814cbccsm4285416b3a.35.2025.08.26.01.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 01:55:11 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: [PATCH wireless v3] wifi: mac80211: increase scan_ies_len for S1G
Date: Tue, 26 Aug 2025 18:54:37 +1000
Message-ID: <20250826085437.3493-1-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the S1G capability element is not taken into account
for the scan_ies_len, which leads to a buffer length validation
failure in ieee80211_prep_hw_scan() and subsequent WARN in
__ieee80211_start_scan(). This prevents hw scanning from functioning.
To fix ensure we accommodate for the S1G capability length.

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
v2 -> v3: don't include kernel test robot for a new patch...

Again, targetted wireless.. but not really sure if this qualifies
as a "bug"... I gave my reasoning in the reply to the first patch:

https://lore.kernel.org/linux-wireless/3j7kkqznavkxt23iopacl626xkppzcitiactxz43axqorucrvu@6gaixffy7zaj/
---
 net/mac80211/main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 9c8f18b258a6..3ae6104e5cb2 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -1111,7 +1111,7 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 	int result, i;
 	enum nl80211_band band;
 	int channels, max_bitrates;
-	bool supp_ht, supp_vht, supp_he, supp_eht;
+	bool supp_ht, supp_vht, supp_he, supp_eht, supp_s1g;
 	struct cfg80211_chan_def dflt_chandef = {};
 
 	if (ieee80211_hw_check(hw, QUEUE_CONTROL) &&
@@ -1227,6 +1227,7 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 	supp_vht = false;
 	supp_he = false;
 	supp_eht = false;
+	supp_s1g = false;
 	for (band = 0; band < NUM_NL80211_BANDS; band++) {
 		const struct ieee80211_sband_iftype_data *iftd;
 		struct ieee80211_supported_band *sband;
@@ -1274,6 +1275,7 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 			max_bitrates = sband->n_bitrates;
 		supp_ht = supp_ht || sband->ht_cap.ht_supported;
 		supp_vht = supp_vht || sband->vht_cap.vht_supported;
+		supp_s1g = supp_s1g || sband->s1g_cap.s1g;
 
 		for_each_sband_iftype_data(sband, i, iftd) {
 			u8 he_40_mhz_cap;
@@ -1406,6 +1408,9 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 		local->scan_ies_len +=
 			2 + sizeof(struct ieee80211_vht_cap);
 
+	if (supp_s1g)
+		local->scan_ies_len += 2 + sizeof(struct ieee80211_s1g_cap);
+
 	/*
 	 * HE cap element is variable in size - set len to allow max size */
 	if (supp_he) {
-- 
2.43.0


