Return-Path: <linux-wireless+bounces-34839-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QH1yGy4R4Gk4cQAAu9opvQ
	(envelope-from <linux-wireless+bounces-34839-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:29:02 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4F2408A29
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 704A8312969F
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 22:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA1A39656B;
	Wed, 15 Apr 2026 22:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Donyjz8X"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7217395269
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 22:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776291835; cv=none; b=O9UXJI7Fi0l46PayGJPWqqkBm3UWbx/N9kRALk9QiXPS9PS/NTOHJm+w1ef8LrijIQCQF3NdDAeVQ2wzrtxt+TVC+R5IEvHfyMM2nIhn45EeD0Y+DXZGiUV31EpE5rYHwOA+EXgIrYma4ifL2ebOwTkteRPHxpRXyT84Vw7VZqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776291835; c=relaxed/simple;
	bh=ODNDMY2kmd5aJtNUY5MrdRY6aBcP3eV0zx1G4cuVvd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iob0mmhheGZE6CY7gcG0q4GHLCA9JvFUkDQLSFcgME+5qhzsj8b6ua9zDs9ODK9rGHB6QC42/t5JyOYdFgOedxSUn43Un57x+AmNuHIF+ovQLSoct8G3uT++SN8ie1ZkVnpWHlZQnaBdMrap0KpMM7iMmPvQiShW0uK0krK6D7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Donyjz8X; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488a041eae5so54469255e9.1
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 15:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776291832; x=1776896632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3u1BcD9KneeuZ1i2dYUu5QWWTz8ru2YjlrKdP990rg4=;
        b=Donyjz8XP0hxbwGciyBSefVJ4mYNfkHUJkg9OlRCuT1sf53XhS7JbUMvcxJMU2hj5i
         8ZfQW58r+oKA4wnuEdj+zW6bEypzEX+7Bo7DmIdh1bXaI00xo4aKz7NtnBWUe+d4BQ19
         Jnd2a5I67b9dlST5xwPUQiXGRXVFEKW53xId5R6453XI9wR8Or7AkENfSJm2JNwh7K2d
         9a7Y0x1lufF9rlD6eKDSgHfrZsV52hRU4MCWY/weVrZzOKFMgyCulfVuQUOq2JXziz2s
         vfPZSEhlOI2+ybV1nJst8Z7s9awEJzMKXlnCZwS6yt5DITnSBvCGxDexuKsol7/MGCJL
         nMIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776291832; x=1776896632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3u1BcD9KneeuZ1i2dYUu5QWWTz8ru2YjlrKdP990rg4=;
        b=W0W+3/zbgqZVmKPbkQLdGLW3rMPwRjvf5cxsTTd/XjrW3UWPkKaBOnFU3FZbuSYN7n
         JAJh+w4fQqwhUUvjei0v39BSo536BtoR2Qi9RFJCfoWdrf2LfqCqUDP5xDZC0BVKr/6P
         V8UWmJBiW0TrsDUTLsNwljmh1BHWAn+myxF5jaZORwE8dNXDJOBhNvnrXLZQwfCMLO7K
         ybv0FsHmzNSGD/Pob3DK2+XkHvs1WN6PX/DNTngG35K+njT5/881u+e73+jNFxfGS60l
         PAc8Nnu1aKPkzUsGkMKc6xum9K70s3ihrGAk6l93illQHNZ0TrUz5a4WQvUxXp0uWxwL
         7cHA==
X-Gm-Message-State: AOJu0YxrEBopa7Y7qU9c9fjrp66PPdi7J6nA7kiF70lK9uv8uUDJa9LE
	OTsDpkI9zktezOZZcFL+Sh12XGx3LPZSH/zMNV/pTzkGkaK25kCd7FU=
X-Gm-Gg: AeBDieufsXxwTw/peTZzmvnsmx8nxejmUdevVXG8T4hQto64gU1/Ye5bwYrcgewxK9X
	qhLB8SszCjctqyGBPPET3se7j0QOhMFXd7rvhdiGdkMFPgHoYW+CVw7PZ/do7gATVNaFXxL1EuR
	2IlRINCywIK75fulKZhPLPVvVWAn6gzwKJikz6EljUVL+dQzexbOzZQk1c/+ZqEzHmOI0y5+4PD
	y21a6OdJJLzi/gVJZ57ZrVviliiz8Pgx+pCsQx7gc9PAbG0SfiX9xDfDZN/XDMZsF3/RXGrhKRl
	cbleApEM6xzaDGfakzm/HRgcE6GeQY9Jj7h0zr5NOlRL2amAhvl3ttLSvWFBryRp4KxFzqGOk16
	D0WeekQVZAhiAy3Zy77MRRuLsuRAxB4mmPxv78MAnhcrsJYtOxkcv/R6WwvMp6rBsZ42K1VB7vE
	+8WcHASXS6ELw6UA==
X-Received: by 2002:a05:600c:5487:b0:488:ae26:435e with SMTP id 5b1f17b1804b1-488d683d4f0mr323460145e9.16.1776291832202;
        Wed, 15 Apr 2026 15:23:52 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead402ee8sm8339591f8f.37.2026.04.15.15.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 15:23:51 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] wifi: ath6kl: fix OOB read from firmware IE lengths in connect event
Date: Wed, 15 Apr 2026 22:23:48 +0000
Message-ID: <20260415222349.1541181-3-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260415222349.1541181-1-tristmd@gmail.com>
References: <20260415222349.1541181-1-tristmd@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34839-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[talencesecurity.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DD4F2408A29
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

The firmware-controlled beacon_ie_len, assoc_req_len, and assoc_resp_len
fields in ath6kl_wmi_connect_event_rx() are not validated against the
buffer length. Their sum (up to 765) can exceed the actual WMI event
data, causing out-of-bounds reads during IE parsing and state corruption
of wmi->is_wmm_enabled.

Add a check that the total IE length fits within the buffer.

Fixes: bdcd81707973 ("Add ath6kl cleaned up driver")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
drivers/net/wireless/ath/ath6kl/wmi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/ath/ath6kl/wmi.c b/drivers/net/wireless/ath/ath6kl/wmi.c
index XXXXXXX..XXXXXXX 100644
--- a/drivers/net/wireless/ath/ath6kl/wmi.c
+++ b/drivers/net/wireless/ath/ath6kl/wmi.c
@@ -860,6 +860,13 @@ static int ath6kl_wmi_connect_event_rx(struct wmi *wmi, u8 *datap, int len,

 	ev = (struct wmi_connect_event *) datap;

+	if (len < sizeof(*ev) + ev->beacon_ie_len +
+	    ev->assoc_req_len + ev->assoc_resp_len) {
+		ath6kl_dbg(ATH6KL_DBG_WMI,
+			   "connect event: IE lengths %u+%u+%u exceed buffer %d\n",
+			   ev->beacon_ie_len, ev->assoc_req_len,
+			   ev->assoc_resp_len, len);
+		return -EINVAL;
+	}
 	if (vif->nw_type == AP_NETWORK) {
 		/* AP mode start/STA connected event */
 		struct net_device *dev = vif->ndev;


