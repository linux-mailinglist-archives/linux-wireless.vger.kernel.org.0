Return-Path: <linux-wireless+bounces-35736-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOZRETjk82nN8QEAu9opvQ
	(envelope-from <linux-wireless+bounces-35736-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 01 May 2026 01:22:32 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D664A4A8C7F
	for <lists+linux-wireless@lfdr.de>; Fri, 01 May 2026 01:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E954E302C76F
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 23:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6103C552B;
	Thu, 30 Apr 2026 23:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rI9DV59p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508F43B0AEA
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 23:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777591346; cv=none; b=TKjbBNxi79jSFC8y6FcaAKw2X3CFTA1+cwfEzypHa9jT06LRkgwXho1deYcoDGsJduuLCOOvvwjrkpqcdz4iO2Z/NAavcU2DtNphxmqpk+6f+JKGwQFKW72IwyKElcmcWzd+Xi3XJpuZpbhXScUyf62iLL4q4Dpx4yFAjSz8/3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777591346; c=relaxed/simple;
	bh=iAfFpNn1PteBTwetjRDPBnMCgEViBehE4mItXAAwVw8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AMtyqln2GOCdrSs1RGdDhwFnjAR1+wCFjHr3nD9oppJ182J5uDSeXSj3FdrAQcL4Uv4KCDOs7mPUxDHtDYVnRQg/4hPh0EF4sJXJyLQjj/PI7767YaAdtgcH+aKF2NIY2VA7u2n2Hy1OpXWV8oxd1CGyhklfh3ohVl36B+b9Lhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rI9DV59p; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-362bb3260f1so1046564a91.2
        for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 16:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777591344; x=1778196144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UCNwfv/CWoUh44fVlWm5Z3GZ6UWmCvKJ0xUKRf+l1Pw=;
        b=rI9DV59poqeooXunwSxK0XGOnXFqeDKpS93zw8Eqzg7jYIvUx31Atm+onZ/1jd1RKM
         aKlC9/lRIrGU6+PfXLJZajCrG/6A0yGbuOclBhB7ru5jtKctqfjesrYaBCMR6VOIRQgS
         WPFkbQ0TX3EoVXjiIqBmfnS9IcfwGcxOZ+RaSVZiXHz62OTqPepFAqV7WNmMTweO5VzY
         LBY4mZBlUd+LaaPUGexNxAwBK8TtAYq+880rmF6FCNA9Mt16jPgBez8+EBCN2KI2NXhV
         HVxpq3HdR4C1dOERI/MM6pmXorsfwStSO0QP4i4iK/sN0X8aDQURct7SmESlRcBXiFhR
         Ua5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777591344; x=1778196144;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UCNwfv/CWoUh44fVlWm5Z3GZ6UWmCvKJ0xUKRf+l1Pw=;
        b=UGfOCRsmZF4p6r69sLbGiXKVoM07Urz7YqqYrscIcUJaojTi/jzrtFwdiwV8ndUizi
         9iBZydo/jn0ZB1iJLUhGhC1ggOacUgPeRpRJ5a9+tvgOjXCBK6avXmQ6up6J006acStP
         bR0V6a8rFTwCprbd+CCY3iOgoxoRmp2X8BZaZ0CAlyqXnYKGjjdLP1vo35l8pvsJu+NU
         8l5ImOruEEA7yQ4SKgawDcUCcOlOtTFOvUmQYqIuALbMDz81VbeyZNhlvkxFsZsaUToe
         p3NHhwda6MF9q1DVpardnWMfV24FZHhY6jtgMNn82hQKcwRNN13EC9vL3/6f1svW771C
         +rQg==
X-Gm-Message-State: AOJu0YwaX3lkoWb2s/w+ye8dHhHts1/SAKlN2vG9PNlmlV2ozcRi/zsH
	Z2yLmtS7kmLftLc9a2nqxB1Uct0MggYTkRkinwBLJDvKMCs+FFO0DUAuGlljU5rN
X-Gm-Gg: AeBDietL31VYgiVIEQHWcnifu1Ef3AcyOxtBvYL0S/JklZt+1PzwwugcMqwbT65JrYT
	SfwkjYnniWZabPM0CCKg4o8fMVnPbSyrQ+qDTS6Fq4CErF77sKNTbni6kc4PIE6CjmQuY8ykFg0
	BtFAGCZNCKGswFJbTzRJbIejKLdF0ZUukXTtpmjeL8S60Q0togwSfuzzbpHZEsyUOkDC65T6Wcl
	2r1AuLEldhE5KDq5nBCn10MbQPILQCbJln991jd2coIaKFD3qNc/cWHbu2dxrKvJexw8khs2QLn
	BrW9PE8td0bnqdQH5LNb2BVOtQZrmtiE3p5fMntuTx3+hPjfJBYssE4h8tWvThOYRTLHkDJR3gH
	7MleIlhkHK9ps+SZ4es+rQUPSMDsx39p0OUF6GpQEwqEHx7rhIWCg0tcKmSDKkuPFcYOrnicxEP
	1IhEAQEoeY7g/7n2DIuwotQWecEcUZYQuxVIXl1iE3KG0QOh2QV7D5tvrKj1H0EjUGoE3bIXv/0
	AF6yhge06EXpUq/IciKPr4mxUaf7hCdYfzA8HxLpcxkhAd5XDzZobca
X-Received: by 2002:a17:90b:2752:b0:35b:9ab6:1d4a with SMTP id 98e67ed59e1d1-364c30cbf38mr5089787a91.18.1777591344125;
        Thu, 30 Apr 2026 16:22:24 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364ebec737fsm536967a91.4.2026.04.30.16.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 16:22:23 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Stanislaw Gruszka <stf_xl@wp.pl>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH wireless-next] wifi: rt2x00: allocate anchor with rt2x00dev
Date: Thu, 30 Apr 2026 16:22:06 -0700
Message-ID: <20260430232206.141461-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D664A4A8C7F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[wp.pl,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-35736-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Instead of being creative with devm, allocate with rt2x00dev by using a
flexible array member. Simplifies code slightly.

It's worth noting that in 25369b22223d1c56e42a0cd4ac9137349d5a898e , the
proper device was set to the devm call as it seems there was confusion
there.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/wireless/ralink/rt2x00/rt2x00.h    |  3 ++-
 drivers/net/wireless/ralink/rt2x00/rt2x00usb.c | 11 +----------
 2 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00.h b/drivers/net/wireless/ralink/rt2x00/rt2x00.h
index 665887e9b118..7d313e86d3f2 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00.h
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00.h
@@ -1009,11 +1009,12 @@ struct rt2x00_dev {
 	/* Extra TX headroom required for alignment purposes. */
 	unsigned int extra_tx_headroom;

-	struct usb_anchor *anchor;
 	unsigned int num_proto_errs;

 	/* Clock for System On Chip devices. */
 	struct clk *clk;
+
+	struct usb_anchor anchor[];
 };

 struct rt2x00_bar_list_entry {
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c b/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
index 174d89b0b1d7..47e427ea8622 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
@@ -804,7 +804,7 @@ int rt2x00usb_probe(struct usb_interface *usb_intf,

 	usb_reset_device(usb_dev);

-	hw = ieee80211_alloc_hw(sizeof(struct rt2x00_dev), ops->hw);
+	hw = ieee80211_alloc_hw(struct_size(rt2x00dev, anchor, 1), ops->hw);
 	if (!hw) {
 		rt2x00_probe_err("Failed to allocate hardware\n");
 		return -ENOMEM;
@@ -826,13 +826,6 @@ int rt2x00usb_probe(struct usb_interface *usb_intf,
 	if (retval)
 		goto exit_free_device;

-	rt2x00dev->anchor = devm_kmalloc(&usb_intf->dev,
-					sizeof(struct usb_anchor),
-					GFP_KERNEL);
-	if (!rt2x00dev->anchor) {
-		retval = -ENOMEM;
-		goto exit_free_reg;
-	}
 	init_usb_anchor(rt2x00dev->anchor);

 	retval = rt2x00lib_probe_dev(rt2x00dev);
@@ -843,8 +836,6 @@ int rt2x00usb_probe(struct usb_interface *usb_intf,

 exit_free_anchor:
 	usb_kill_anchored_urbs(rt2x00dev->anchor);
-
-exit_free_reg:
 	rt2x00usb_free_reg(rt2x00dev);

 exit_free_device:
--
2.54.0


