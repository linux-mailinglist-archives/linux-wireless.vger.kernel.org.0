Return-Path: <linux-wireless+bounces-33547-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPkiJTeivGns1gIAu9opvQ
	(envelope-from <linux-wireless+bounces-33547-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 02:26:15 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 732C92D4B0F
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 02:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9F9853024EFE
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 01:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83EEA315D39;
	Fri, 20 Mar 2026 01:25:20 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB20302163
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 01:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773969920; cv=none; b=VW1tacvscL1lgvDOzGSJ3OMom/PFfwAKDPSe3cel3JHTYhHbMHCWRRrObFnLDTba8vATBNaOdJl8EU8DoMw8oOYfl5ov59lGUbgl3UP/mBLOBmmdycBv6St2+yht2ithS9HxdoxAEiwWN9Vu8KfiNH4THMAsg3ccDFHkw3o0xeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773969920; c=relaxed/simple;
	bh=5NcsxaHVIQ2NmCj9OLQh+nSLlXz0JVUjSv0mBYVb1MM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bcC7xkPubcYfRFnzqpCInGQoXsPy/YET1bO+XVWyrCBAfM9q9qH+ZQY/GBfZe0aeIU6qF3mGfdfbtI5efKdusmHAzXx9MzWQDpChGtiK3htFa0Uwwsa2ei+At2yLME8huavH/J01JGx3CtjrQTFhB2aVf5kxra46BD12cIng8nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2ba895adfeaso1786596eec.0
        for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 18:25:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773969917; x=1774574717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HbyBRqP1dM0VO6fEJ4blZH7JfwL0DV5fAiX12aFZ5no=;
        b=I+tmnutxI8JKX36DGzTY3b4l4OumtmLc9Bx8Dop2XT+trre1+Dm956aLY0XMIIi1c9
         FyAcD1IVvLwisL5NcKBm62T7kFEBjuod+tQMy0Di0vS71ypX11IfsFwMCYXgZN1nos1l
         qyeY3teNFFGvI4mOJo3rSF+BKMfFFyP4I4x6l6ujtKAUSy3uFn7Zz83eemiRMDjaWKu1
         VQsONyWIDJnOW0JzX0R4jBuvn6awB8J5999e5+8TiCZdn+FaZHGhR76uQJHi+YIaXKju
         8zz1Aj6vCgyR1AfhHkz1G9kH0gfuN3y/5s0EJpZisPitm5PwXV1bbY91ZcDSm8O0cdOc
         a+5g==
X-Forwarded-Encrypted: i=1; AJvYcCUUfzmDdCr7EAisgX6RlIaoMmglso1ItySXHNk07eLEgS6Fue1KAJfgaxq6oBoq/R8KnEEgGhd99+hZPiDreQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwPu3kXVIf3PBPL474eblwV/gpPfyVGEobVBlzccuCC1e+fa/P6
	+9wdWXTB6ruC1sHF9p6mDTh1XQj+lSA2jr6bkmj8mtanLhifAcFpSbc=
X-Gm-Gg: ATEYQzzzxM4TEmy5lRSTDVmBXp5XaW2YK3RoKpyozXM8Q8VnDQRAesyxu1giJoVUEIb
	KiRDL9roLhjnaMPgWAb6eDu7mTAnDp+/GkMGMEAJHsujZvfiz/FL91aeC5t0hE/0+RXrusqPcmJ
	ypMhNJOI2rA1PhPKUzk2aOsg0js0lvrtNmjcnJ3ZzO7iLNdKEShZGSfBK8DmewTsu3/mmCddEqn
	dgMsel5JGIWiA91/K+wXccNI0Vn9KxBiu2/XbrzB4fdRQwmOIayAvdAVBDhCQkt3U/elihgJml6
	xb+MFJkhXUDN9b10IAnqdIm8sEdbOyed/mRE7EiiOXvDXFjwnrcq610budLNCgJLV8UTF0/QOBa
	6GmeEsD61aN6C7wyawAR/epPUZwO5UxRONUYtM4MxVJ7rRj5GTxUYHc8fDzmlTeukrD1F5GwX2m
	8dNMKxKfyugzig7mP+6aiR+p8SybkoXNRX9HorfZOQclJEqWt0AW8tPYepD5NLgOv6UcnlXcali
	PWfxNPpBFqdOvFQVA==
X-Received: by 2002:a05:7300:6da5:b0:2c0:eec6:279e with SMTP id 5a478bee46e88-2c10974fb69mr728307eec.22.1773969916878;
        Thu, 19 Mar 2026 18:25:16 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b29c74bsm1146865eec.17.2026.03.19.18.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 18:25:16 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	andrew+netdev@lunn.ch,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	alexanderduyck@fb.com,
	kernel-team@meta.com,
	johannes@sipsolutions.net,
	sd@queasysnail.net,
	jianbol@nvidia.com,
	dtatulea@nvidia.com,
	sdf@fomichev.me,
	mohsin.bashr@gmail.com,
	jacob.e.keller@intel.com,
	willemb@google.com,
	skhawaja@google.com,
	bestswngs@gmail.com,
	aleksandr.loktionov@intel.com,
	kees@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	leon@kernel.org
Subject: [PATCH net-next v3 11/13] dummy: convert to ndo_set_rx_mode_async
Date: Thu, 19 Mar 2026 18:24:59 -0700
Message-ID: <20260320012501.2033548-12-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320012501.2033548-1-sdf@fomichev.me>
References: <20260320012501.2033548-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33547-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[fomichev.me];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,lunn.ch,broadcom.com,intel.com,nvidia.com,fb.com,meta.com,sipsolutions.net,queasysnail.net,fomichev.me,gmail.com,vger.kernel.org,lists.osuosl.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sdf@fomichev.me,linux-wireless@vger.kernel.org];
	NEURAL_SPAM(0.00)[0.049];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	RCPT_COUNT_TWELVE(0.00)[37];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,fomichev.me:email,fomichev.me:mid]
X-Rspamd-Queue-Id: 732C92D4B0F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Convert dummy driver from ndo_set_rx_mode to ndo_set_rx_mode_async.
The dummy driver's set_multicast_list is a no-op, so the conversion
is straightforward: update the signature and the ops assignment.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/dummy.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dummy.c b/drivers/net/dummy.c
index d6bdad4baadd..f8a4eb365c3d 100644
--- a/drivers/net/dummy.c
+++ b/drivers/net/dummy.c
@@ -47,7 +47,9 @@
 static int numdummies = 1;
 
 /* fake multicast ability */
-static void set_multicast_list(struct net_device *dev)
+static void set_multicast_list(struct net_device *dev,
+			       struct netdev_hw_addr_list *uc,
+			       struct netdev_hw_addr_list *mc)
 {
 }
 
@@ -87,7 +89,7 @@ static const struct net_device_ops dummy_netdev_ops = {
 	.ndo_init		= dummy_dev_init,
 	.ndo_start_xmit		= dummy_xmit,
 	.ndo_validate_addr	= eth_validate_addr,
-	.ndo_set_rx_mode	= set_multicast_list,
+	.ndo_set_rx_mode_async	= set_multicast_list,
 	.ndo_set_mac_address	= eth_mac_addr,
 	.ndo_get_stats64	= dummy_get_stats64,
 	.ndo_change_carrier	= dummy_change_carrier,
-- 
2.53.0


