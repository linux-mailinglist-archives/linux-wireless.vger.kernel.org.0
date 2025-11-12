Return-Path: <linux-wireless+bounces-28861-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6FDC51251
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Nov 2025 09:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 278FC3A6B4C
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Nov 2025 08:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72C02F28FF;
	Wed, 12 Nov 2025 08:38:27 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mxde.zte.com.cn (mxde.zte.com.cn [209.9.37.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DFB2874F1;
	Wed, 12 Nov 2025 08:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.9.37.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762936707; cv=none; b=Uy2MnG5y1tWrQJSAvSSWcEUCNcaBVZTgzYU7pYiEwl68iGCijTFRAFrH/1RUiIr1RQafPXCrFaI8lefcgl2ZLqAoEyp9ZoQDcz5I70SAvK/gNVC2BUcNqTEYMKEcAyU6uh1wABeFOtUf2FfRrore8zfRJL5IfvqVR2DmWoZtJdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762936707; c=relaxed/simple;
	bh=PmFVKdAFXpT//sA84uyvtwBWGBm2dj+YcJxcsrXBlOw=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=AxjA83UFWo8+achXPT8MSjJF3UQzxknmKPgqJy7c7q2EbLyr/msTgo0EiIMSqjahrsywqp9U0k8zwjqLQrr5JxtGjttP8a1xrKmcZn5k+tTfS8HemV3F4esJUZzEJ7XDuTUwNzh2GdvnsDrQyr37bjoZ48Mq9r5FENM6gJe6/Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=209.9.37.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mxhk.zte.com.cn (unknown [192.168.250.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxde.zte.com.cn (FangMail) with ESMTPS id 4d5xcn0VkkzBQkJn;
	Wed, 12 Nov 2025 16:38:17 +0800 (CST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4d5xcb3fVHz6FyC0;
	Wed, 12 Nov 2025 16:38:07 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl2.zte.com.cn with SMTP id 5AC8bmtf069322;
	Wed, 12 Nov 2025 16:37:48 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 12 Nov 2025 16:37:50 +0800 (CST)
Date: Wed, 12 Nov 2025 16:37:50 +0800 (CST)
X-Zmail-TransId: 2afb6914475e04c-94783
X-Mailer: Zmail v1.0
Message-ID: <20251112163750463kAkOIyBxvHkYWh9Cgdypb@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <johannes@sipsolutions.net>
Cc: <kees@kernel.org>, <concord@gentoo.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <qiu.yutan@zte.com.cn>
Subject: =?UTF-8?B?d2lmaTogbWFjODAyMTE6IG1ha2Ugbl9jaGFubmVscyB1cGRhdGVkIGFic29sdXRlbHkgYmVmb3JlIGFjY2Vzc2luZyBjaGFubmVsc1td?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 5AC8bmtf069322
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: xu.xin16@zte.com.cn
X-SPF: None
X-SOURCE-IP: 192.168.250.138 unknown Wed, 12 Nov 2025 16:38:17 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 69144777.000/4d5xcn0VkkzBQkJn

From: xu xin <xu.xin16@zte.com.cn>

The commit 2663d0462eb3 ("wifi: mac80211: Avoid address calculations via out of
bounds array indexing") said that req->n_channels must be set before
req->channels[] can be used. But there&apos;s still the case that req.channels
accessing was prior to n_channels++.

This does not fix any visible bug, just making n_channels updated before
accessing channels[] absolutely, to avoid potential UBSAN out of indexing
warning.

Fixes: 2663d0462eb3 ("wifi: mac80211: Avoid address calculations via out of bounds array indexing")
Signed-off-by: xu xin <xu.xin16@zte.com.cn>
---
net/mac80211/scan.c | 4 +++-
1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index 5ef315ed3b0f..86bd85ac36be 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -406,7 +406,9 @@ static bool ieee80211_prep_hw_scan(struct ieee80211_sub_if_data *sdata)
 				if (req->channels[i]->band !=
 				local->hw_scan_band)
 					continue;
-				local->hw_scan_req->req.channels[(*n_chans)++] =
+				(*n_chans)++;
+				/* Use *n_chans - 1 to access the index that was valid before incrementing */
+				local->hw_scan_req->req.channels[*n_chans - 1] =
 							req->channels[i];

 				bands_used |= BIT(req->channels[i]->band);
--
2.25.1

