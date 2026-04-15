Return-Path: <linux-wireless+bounces-34847-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGOYHK8R4Gk4cQAAu9opvQ
	(envelope-from <linux-wireless+bounces-34847-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:31:11 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE2E408AB5
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56CB731C0DED
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 22:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511BC39C65F;
	Wed, 15 Apr 2026 22:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBkh5rUU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7AE393DE8
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 22:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776291855; cv=none; b=t47G8LNrXcLts9lkIaYTUFFjoZlGQp5WNboBGFuNRmbqkdiJdrdG7Rq2/7xkZl3cxN4LSLm0p4bPZdz/B3G8KaQTerkN677xgMkp2di5voXCMJytiLidpFv3MCgKHCC+1/5LVtVeENiUbX0EsPEJy2mztEpbeB32V56W9x/zwUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776291855; c=relaxed/simple;
	bh=x7DJEKRPkvno2qyGO3A3yODK+J7oodJwny7atGhOcS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LlO4c5Hs7I9t1HXV12X3XWcGuH0yGM7qdaAaj9HfqxpqtCEnkaVFsqz51ujdNVDeSQVDSb7CvfjdrEE+wWhddLQmy41g/90uicioOAKPG1vGlFn6ebBuGv5Z7+y/CimV0NDmxZU4mlA/nAuOvTxbmSgVRDb1iPnaBkpkKryGw8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FBkh5rUU; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488a29e6110so77763475e9.3
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 15:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776291851; x=1776896651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v8fkw0tJYXQBqzi8PNd+3IupG6ZyEyB99KznRWlHdP4=;
        b=FBkh5rUUCE5g2zJCRnzxW0scoCYlWisuGHT10QRsfv2P/XifSUhL4wBUbYHLrOPDbj
         BveTl6tKudRoyOXj1Of3HTjPElqSD1KbGpUEFB9ohF6IZWUJFIoR8mgt2LgCdKRS9PEc
         8y0rW5p6EYhrXJG2P881mgb9EkLZ000Xdq7gwxqeUi8GB9PRRsPXLP8OwUEQFnHx68Fg
         kTq/K4h4iHoLwgwO85wqwaiZ/MHkELSaxLg8psYwTSPhdN+529J/63BW8gY16FOohUMD
         WhW8w4ZFdHojEabgNsgbJ5nVsFYmK1CxAwt9GRsjFiUGWKHCelVIwnyCuMO7Lo3YRlO3
         Jqrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776291851; x=1776896651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v8fkw0tJYXQBqzi8PNd+3IupG6ZyEyB99KznRWlHdP4=;
        b=Rpz0r8IsQ897loYmY1E2x8Tr/L4ddATsjzF5ZgYgiEO71ZBXVkFz3HO1S1MAaBZIUf
         RMyxe2EbN4rdQ77henNCSCGU630RVnX+ynJUrgon+joEOzY3Bpw5C43X5nLMvBX3XTiO
         vEd+rLYW3wVVopq6al7OlvBZTjGyq7dTJxVl1qN57gAPSkzamgbNnL9TBlXA3aumCrgU
         Xa6M4Kzb0iQh5xfHnh/4k3K4BeqaMeiEiB/b2K6MoRFaq65Z3cBrT8nblHeGI3dh5uiL
         GnJBPpPAv5eZz0eh5Sdlp+NDUfaJJztrZvF6DTv4ET7Cohiws2/E1RQSYW9h05930oAB
         DkqQ==
X-Gm-Message-State: AOJu0YzQyLuL8xeOReSc4MtiQS8rHSfmidvxuxAnHWImfsN70eOPpZgP
	ZRO5awweTMg4Ey4aKsARqPMS3MY1uZrqHxdv/cYjPBrtDLeNIVecuFs=
X-Gm-Gg: AeBDietvg/NLoLrTt2Z0qjIJR1ia+QSEGxpFdaF2t55DKAruJiyMXw0HaWqmA+p3A+8
	RYbhRfmuFa+rZJf5whZaXg+kz+4gZEQ6WxCJNxT5bnv8HV24koXe01DDl0hyJ7EG5Wh1hnHW/Uq
	x6Cy+kEBnjTlxt/qvHgTiJgrm3tEk3WJ5ycRdbGHsc1LgWl37E8Teq4swlUjnhIepZogRXFy2+b
	+3tWsHB9ZSNdy1ipo08gPeSlgvoehPRnfmQWWfW+G/ROlW/oVlMrNbMkxMFfe4deGLhkcUE0xQN
	1o/0kj1Pmo/3roJordfHfQcTGjPDPnzt5yYdsokgJTBNcEE/2sMzQGqbckn0xo9CdM8nEvDfAdy
	edNZ2udwHUatwXrPb14dFiNMQPhId5fudNPfN0H1QQ2cJznr2c+15uLOworNulNEEMRRbKjam4o
	rbK98=
X-Received: by 2002:a05:600c:8b27:b0:486:f634:ef1 with SMTP id 5b1f17b1804b1-488d687664emr304397125e9.17.1776291851255;
        Wed, 15 Apr 2026 15:24:11 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f5818da1sm1932785e9.6.2026.04.15.15.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 15:24:10 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] wifi: wl18xx: fix OOB read from firmware rx_ba_link_id in BA event handler
Date: Wed, 15 Apr 2026 22:24:07 +0000
Message-ID: <20260415222409.1542989-2-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260415222409.1542989-1-tristmd@gmail.com>
References: <20260415222409.1542989-1-tristmd@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34847-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[talencesecurity.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1CE2E408AB5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

The firmware-controlled rx_ba_link_id (u8) is used to index the 16-entry
wl->links[] array without bounds checking in the BA window size change
event handler. An out-of-range value causes OOB reads and an immediate
pointer dereference of the OOB wlvif field.

Add bounds validation consistent with all other HLID consumers in the
driver.

Fixes: d4392269f7ce ("wlcore: Add RX_BA_WIN_SIZE_CHANGE_EVENT event")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
drivers/net/wireless/ti/wl18xx/event.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/ti/wl18xx/event.c b/drivers/net/wireless/ti/wl18xx/event.c
index XXXXXXX..XXXXXXX 100644
--- a/drivers/net/wireless/ti/wl18xx/event.c
+++ b/drivers/net/wireless/ti/wl18xx/event.c
@@ -211,6 +211,12 @@ int wl18xx_process_mailbox_events(struct wl1271 *wl)
 		u8 win_size = mbox->rx_ba_win_size;
 		const u8 *addr;

+		if (link_id >= WLCORE_MAX_LINKS) {
+			wl1271_error("BA event: invalid link_id %u\n",
+				     link_id);
+			goto out;
+		}
+
 		wlvif = wl->links[link_id].wlvif;
 		vif = wl12xx_wlvif_to_vif(wlvif);


