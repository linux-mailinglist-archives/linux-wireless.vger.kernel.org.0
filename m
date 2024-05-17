Return-Path: <linux-wireless+bounces-7788-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF028C8965
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 17:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD05E282D50
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 15:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F37212D212;
	Fri, 17 May 2024 15:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="XAr7cU37"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net [178.154.239.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF38654673;
	Fri, 17 May 2024 15:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715960032; cv=none; b=XfOMUYTEz453ZX8GQgS6tDZT5h1RfCHzTl1qxwXWUq/npViWF5oeVqQZ2nRvYQpBPF+hKgBZqwx2HqVhBNrbCo2MnqBbG/rznRSuLj2B3CAPXfxdDuJXB6FXewxJ2sHb4m4c5zq83B/Xigsr63gYQUwXFMvLc+k6TeLkKW6H8QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715960032; c=relaxed/simple;
	bh=DO0jPXx3Xa5gYc9xzYitx5U9CfWOMS2FByDGkugToec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TA5P1FBdXL+xWmq3MipXp9hJPTw+1KrkJsaSP5KEQNkUFU+7inalDU+gIAcffWk1lMAgXIgmT9+gWZYR7oXGbd0K7kIxIPCFcV30wVPtKglLW3ii7izcSvrQoUvBhZeNRJ1E5oy0UZzU0R4LSphSxFW9Yh5yJKT+yKjTVp2jukU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=XAr7cU37; arc=none smtp.client-ip=178.154.239.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-31.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-31.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:de2c:0:640:e39b:0])
	by forward100b.mail.yandex.net (Yandex) with ESMTPS id 93DFF60ACA;
	Fri, 17 May 2024 18:33:38 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-31.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id aXHWQ33Zu8c0-tBlIXqJa;
	Fri, 17 May 2024 18:33:38 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1715960018; bh=IoGGzC4UPODFkDplsAMcg9yw1a+vUefTbBgLr2uPevo=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=XAr7cU37My2NdN5w4fnEPt1+Df9seakgQ8AK7BXM+RSee2PkVYjplqZ1rW5FQ3UVo
	 da4LuibSFGR59lFzMHBhVCf/+K6wD1QuFmxihgX3DYzlf0J22biQ/QeqO4kKAbwTgJ
	 tECdd7lLGBm5RWZJ9v/bY2qVW4cGUaNh+3CwzrF0=
Authentication-Results: mail-nwsmtp-smtp-production-main-31.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Johannes Berg <johannes@sipsolutions.net>,
	Kees Cook <keescook@chromium.org>,
	linux-wireless@vger.kernel.org,
	linux-hardening@vger.kernel.org
Cc: Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 2/2] wifi: mac80211: fix UBSAN noise in ieee80211_prep_hw_scan()
Date: Fri, 17 May 2024 18:33:32 +0300
Message-ID: <20240517153332.18271-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240517153332.18271-1-dmantipov@yandex.ru>
References: <20240517153332.18271-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When testing the previous patch with CONFIG_UBSAN_BOUNDS, I've
noticed the following:

UBSAN: array-index-out-of-bounds in net/mac80211/scan.c:372:4
index 0 is out of range for type 'struct ieee80211_channel *[]'
CPU: 0 PID: 1435 Comm: wpa_supplicant Not tainted 6.9.0+ #1
Hardware name: LENOVO 20UN005QRT/20UN005QRT <...BIOS details...>
Call Trace:
 <TASK>
 dump_stack_lvl+0x2d/0x90
 __ubsan_handle_out_of_bounds+0xe7/0x140
 ? timerqueue_add+0x98/0xb0
 ieee80211_prep_hw_scan+0x2db/0x480 [mac80211]
 ? __kmalloc+0xe1/0x470
 __ieee80211_start_scan+0x541/0x760 [mac80211]
 rdev_scan+0x1f/0xe0 [cfg80211]
 nl80211_trigger_scan+0x9b6/0xae0 [cfg80211]
 ...<the rest is not too useful...>

Since '__ieee80211_start_scan()' leaves 'hw_scan_req->req.n_channels'
uninitialized, actual boundaries of 'hw_scan_req->req.channels' can't
be checked in 'ieee80211_prep_hw_scan()'. Although an initialization
of 'hw_scan_req->req.n_channels' introduces some confusion around
allocated vs. used VLA members, this shouldn't be a problem since
everything is correctly adjusted soon in 'ieee80211_prep_hw_scan()'.

Cleanup 'kmalloc()' math in '__ieee80211_start_scan()' by using the
convenient 'struct_size()' as well.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 net/mac80211/scan.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index 3da1c5c45035..ab2a11a02673 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -745,14 +745,19 @@ static int __ieee80211_start_scan(struct ieee80211_sub_if_data *sdata,
 		}
 
 		local->hw_scan_req = kmalloc(
-				sizeof(*local->hw_scan_req) +
-				req->n_channels * sizeof(req->channels[0]) +
-				local->hw_scan_ies_bufsize, GFP_KERNEL);
+			(struct_size(local->hw_scan_req,
+				     req.channels, req->n_channels)
+			 + local->hw_scan_ies_bufsize), GFP_KERNEL);
 		if (!local->hw_scan_req)
 			return -ENOMEM;
 
 		local->hw_scan_req->req.ssids = req->ssids;
 		local->hw_scan_req->req.n_ssids = req->n_ssids;
+		/* None of the channels are actually set
+		 * up but let UBSAN know the boundaries.
+		 */
+		local->hw_scan_req->req.n_channels = req->n_channels;
+
 		ies = (u8 *)local->hw_scan_req +
 			sizeof(*local->hw_scan_req) +
 			req->n_channels * sizeof(req->channels[0]);
-- 
2.45.1


