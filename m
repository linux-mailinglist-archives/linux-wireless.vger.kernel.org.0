Return-Path: <linux-wireless+bounces-35160-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 5+NjDmyC52mR9gEAu9opvQ
	(envelope-from <linux-wireless+bounces-35160-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 15:58:04 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F022D43BA44
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 15:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 19A08305BDFB
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 13:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8D73DBD5A;
	Tue, 21 Apr 2026 13:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVH/AngT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B521F3DB63F
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 13:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776779399; cv=none; b=u3LJfWDSdaS0wkuPdwWtHjDJq9OIZcez4HV+UiQi9Jtj9b0owoA0aoAseIb/6YJbddTvWYhqvRUUx3sRS8LTvKqqvgWLKrzt3O6TnNvuvs1vgUNc8qYCGRvY1cj/Wg3+bLkGPK/OChld825xUL3OuFg2r/l4i3BDxuHZs4zRdYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776779399; c=relaxed/simple;
	bh=suTBYE1gP/R4ATTroFoL/2430iJXnOm52ISvcEoM5Ys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PFVj25vXxH+vJLCDDCvKsW+p5j9+prWiCZbiaXCjVa/Fb3h/4+F/S+w1s9oO1pQje/D4shdV7aPXSp9bci7hHpz1Og38Z59qHm5uWPe0fdcdGU18/hr1BLjwb3UNMZZbhbhKYh6igCAz/bWAwT3oy/DmioOxxkJ29ap78ZrxUbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nVH/AngT; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488ad135063so35994935e9.0
        for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 06:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776779396; x=1777384196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AKGjiE71pcy1j0gjcQ9BLUrLYWLwxIOwPknCBw0OO9w=;
        b=nVH/AngTe1OASNbRMp0o1OkkDIpAIakHRONiCnkW4j518SdULB83geuAO0+xWjl3XJ
         Vvw0nXcM06jdsANDgqv3HrXYodgnRKWN5DN6sr1c8+NUdGUuRn3C45GYJusj9GPPvSvy
         JH0l9okLmj2Fyl/DGYTKFbIUmx/G2u18yRS9Igl/cas/5ML3hJmK8UeaqgdIzsqbkvpU
         TiOyG/yBLsBJACOgEft+7b3KFujrGUdqOwLJP50pQf9gVIGhCmnBXGGzby6NA9syhh5S
         Qc18RGKR2oQTjXSnbRmBUETQsynmXDUBYkZ/IQEUSvYmSgLKXWDTKTa9b24r118BIkt2
         l5LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776779396; x=1777384196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AKGjiE71pcy1j0gjcQ9BLUrLYWLwxIOwPknCBw0OO9w=;
        b=Vfv2tOEj9bX00gL/wpbiTuj/9puRER1aBomQh5CMcoI+gP9lvYg3pAH+QppMTTDYhM
         VfPPWjxQ0JejnS1dPJDqeesSYlqo0eKnQM0w9gLEthm3ogxK4EtJQ2x7jdl5hLc6e7oL
         da4FsOvS3K5wckj1Ho18/1enmb+lTbmdUhqvN06UF61smhBWTXeoSPNC6HZSGZBZfGLB
         ShyewsemlujvXLIcOfgUn656MY7rwbhh0Th16dyt6/VBPfLCP96glw0CcjhbKUbNAGQp
         usfpTcagupE7gh+dgJKKtECzRALiKLgLZvITfU0NS8OXwwYyuo0Qu/Q0jHVv9EukM/FG
         dOgQ==
X-Gm-Message-State: AOJu0YwAG+b4gr3u3fcoIMI9EGcbUCKcUSThvuTyJ7Vnqh/8rhj6Cgrz
	gxfH08UmTxa1pnEEJ3QpuS+OrNmAhK9nI11/i+5iS608mbPxjursONA=
X-Gm-Gg: AeBDieu37LM9YPURZUgRZWoIQdmxA24Wsi84D7bWP/lF5f23ypWzbV64hNkOiOg660P
	60JiR9vnMnTkgKB6W0uhk8OYtQh5zhAJyXlUMHVPmCv1+5CmMUi6cm3dldfC0ntZYBWJJ/tC8SB
	h7gzTHThKmhXlNwJFT8w4vBLq8f4yP9gNbcvZbLREy8JKaXkPLqwKsuS7s7mDZm+ZQcXVOXA5ay
	yVK+fZVVNmp7VYMQWnHwWp1t4BG75Vl3y7q+BTWs5w6dpOnlGgLbMmr9msM6vmagmYJMmq0oEqD
	A6j4vj68ouRbM6UgZOylAFdf124RJ1dcGk1dfIvpASngPGa+VI+sQBWreYFOoRZs5nQYZPgOUS6
	Ni/rcIWN7S8hL3qqFxhkY9rW7tvN6eCT4lvXyYnREq8bWEw5FCpLKqknf4Eh/10cYcbkN5qM0EQ
	6lKSEzrIggt3+8KQ==
X-Received: by 2002:a05:600c:3483:b0:488:af7f:775f with SMTP id 5b1f17b1804b1-488fb77d343mr244770145e9.18.1776779396003;
        Tue, 21 Apr 2026 06:49:56 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb13a0sm37671480f8f.8.2026.04.21.06.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 06:49:55 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v3 3/3] wifi: wl18xx: fix OOB read from firmware SSID/password lengths in smart config event
Date: Tue, 21 Apr 2026 13:49:51 +0000
Message-ID: <20260421134952.338301-4-tristmd@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35160-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[talencesecurity.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F022D43BA44
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

The firmware-controlled sc_ssid_len and sc_pwd_len values are used as
nla_put sizes from fixed-size mailbox buffers (32 and 64 bytes) without
bounds checking. Values exceeding the buffer sizes cause out-of-bounds
reads delivered to userspace via nl80211 vendor events.

Clamp the lengths to the mailbox buffer sizes before use.

Fixes: e93e15fb47e5 ("wlcore/wl18xx: handle smart config events")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Changes in v3:
  - Regenerated from wireless-next with proper git format-patch to
    produce valid index hashes (v2 had post-processed index lines).

Changes in v2:
  - No code changes from v1.

 drivers/net/wireless/ti/wl18xx/event.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ti/wl18xx/event.c b/drivers/net/wireless/ti/wl18xx/event.c
index fac12a8590355..19c7f5bdada5e 100644
--- a/drivers/net/wireless/ti/wl18xx/event.c
+++ b/drivers/net/wireless/ti/wl18xx/event.c
@@ -82,6 +82,9 @@ static int wlcore_smart_config_decode_event(struct wl1271 *wl,
 {
 	struct sk_buff *skb;
 
+	ssid_len = min_t(u8, ssid_len, 32);
+	pwd_len = min_t(u8, pwd_len, 64);
+
 	wl1271_debug(DEBUG_EVENT, "SMART_CONFIG_DECODE_EVENT_ID");
 	wl1271_dump_ascii(DEBUG_EVENT, "SSID:", ssid, ssid_len);
 
-- 
2.47.3


