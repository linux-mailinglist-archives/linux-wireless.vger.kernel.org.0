Return-Path: <linux-wireless+bounces-35157-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGlmIlyC52k+9gEAu9opvQ
	(envelope-from <linux-wireless+bounces-35157-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 15:57:48 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4317243BA2C
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 15:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B04C130A7D5B
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 13:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D123D88F6;
	Tue, 21 Apr 2026 13:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="El27gZ9O"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096BC3D813C
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 13:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776779397; cv=none; b=nGCxsa70INPxXEWUAQGyoF61rjiihciJlWeVYrGFbSdYqHEgbcP+cK3wSk0K7Fo6Hr5tZMbQvfX5ljJEvMJ85zZ9LxOifiAulqpVjryMlC1agznhfi9Q9i/2tEu7GXy08iZrIAwnQzDmIeLKJtUjlNQ/6n8Ol6AVxVjW0kO13RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776779397; c=relaxed/simple;
	bh=kKZ2eoQ5zExPxPUVDm9+Bjv946REbBveK4BG4RekTwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T1CqWmdtiyAWhF5YAH92vEMjrBV8zQyfJAJLfpkvaL+teYV6Se3xA0vJ9xsveAE3d7uLY0ZV9m34LIkCt6n9tj2ORYqhmgsCsUNTD3QIVWYFOnIEXW86pQElDbE+DNA5RO6GRHmygEoi/WyAEeq1EHogzkjxBO3MRKDneXP3RQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=El27gZ9O; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43d0deb7ad5so3477504f8f.2
        for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 06:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776779394; x=1777384194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2zHXMr6dY7lbD0aEaxS9wFDwdUTKjF7ef2KbAfXUkPE=;
        b=El27gZ9OlwnaitqqZOs+yfShEU0YqlH+Nq72sniySrJjn1Nmp02Nryq6+8KeqPppVF
         tyDv2KXc0J0quwxpy+hQsXU+e86UoQQk9CoCCs64+6a2SGBd+kTfL3DQzX/q7qjHHCrB
         jyjRLvTyAdmVqk0uRpkFcyG/STmNhHbgjMp+aHTFN8knuiiH7HL7eDKke2sv3XHTLU/z
         uy/hMsYFbkf88ost5mr79tGklRf8h103xAyDLe/QEQMPFi3sumN3eXj4uhP4B5LxDtLr
         Xh25+Xqs8VPoYLfEEaRh8XH3TNyl/WsW7i0/57eqD1qay7ouS8PQ+farRHEwj3R9XGYs
         /gjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776779394; x=1777384194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2zHXMr6dY7lbD0aEaxS9wFDwdUTKjF7ef2KbAfXUkPE=;
        b=K7yXbZ1qukURigyfIkuKx09uh0dJiqatsbgxp0T0Xf30VIOE662r0v/mc1EMNGlSKz
         WgAJbVb4ZBjbLLI7MZExZPuyzDFgic6tknb/1fy9r5JD4r1JzqMNMnkwCbD/N//tWs+7
         fVTX8WYGuOwoeQnbleAlKHUXFlZ/dfXH8tvA6jK3kW7rRDfRV0XATtsr1XcW9UKIhR3p
         ztWtE1/JHZQShMmLJWPGEsIUqCz0AFei+A0CP51fj+DyFtIhZNUQeWbqjc6ootIfjJK1
         T+cXyrtu+dho+nVo1X9JzdRnq7im7voM6gUvZG92+/cWhYQkNiwJlCsRFBmm4N19It5I
         hk3g==
X-Gm-Message-State: AOJu0Yzoh7SjmbnNh9IDzqNiiDClP97cGlxYw7s0Urcg+XEnHpDAe1Bj
	bTKSWG+h3riPkFbZipT9S5mK2RdJCiMlKs7PQ51HcfZOkqp5ITdDlEs=
X-Gm-Gg: AeBDiesH2xdg1yR/micZYPaKdDGU+1BKmW25X0jNdzZGaS/RDEl+AwcCqZfex7PsscJ
	XNXzC5UH1N82ZBXMJUXOalM5wGr2w+w/GKLOC04yD5J7d5jwjyP/KgreC6d55prB3scxoEN7VR8
	12l7wd78orlayfF3GRngCzOrlKTveQyjHVLJYDgA9T5sQZ7ibBWWQW37pu6hVk7aDs6ERwa+E0m
	ybTYFY6YmbffWKGGGFi1P4+LS+gpLAHWyXU28zHXAAf6uiJuEvfnDJxU86gOcA1OMukvXASgLk7
	d2nqFiL46xjP1+Z6ECwfxkT5HT+2jXkdmrNzv6sizGZ/8tuGo0TiJ57iEruWEogR/NRjwO50fxT
	qL3G39YLlOpSEJQzYDly5cQQOOupesATShxhM3PWGzCHGNrIhTajYpF3SZEBpAjuM/g0wgXWhun
	D+eSs=
X-Received: by 2002:a05:6000:250e:b0:43d:7ef:552f with SMTP id ffacd0b85a97d-43fe3dfbd9fmr29529388f8f.25.1776779394294;
        Tue, 21 Apr 2026 06:49:54 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb13a0sm37671480f8f.8.2026.04.21.06.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 06:49:53 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v3 1/3] wifi: wl18xx: fix OOB read from firmware rx_ba_link_id in BA event handler
Date: Tue, 21 Apr 2026 13:49:49 +0000
Message-ID: <20260421134952.338301-2-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260421134952.338301-1-tristmd@gmail.com>
References: <20260421134952.338301-1-tristmd@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35157-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,talencesecurity.com:email]
X-Rspamd-Queue-Id: 4317243BA2C
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
Changes in v3:
  - Regenerated from wireless-next with proper git format-patch to
    produce valid index hashes (v2 had post-processed index lines).

Changes in v2:
  - No code changes from v1.

 drivers/net/wireless/ti/wl18xx/event.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/ti/wl18xx/event.c b/drivers/net/wireless/ti/wl18xx/event.c
index a9f090e15cbbe..fac12a8590355 100644
--- a/drivers/net/wireless/ti/wl18xx/event.c
+++ b/drivers/net/wireless/ti/wl18xx/event.c
@@ -212,6 +212,12 @@ int wl18xx_process_mailbox_events(struct wl1271 *wl)
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
 
-- 
2.47.3


