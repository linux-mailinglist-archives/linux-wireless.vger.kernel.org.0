Return-Path: <linux-wireless+bounces-33408-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2G15Dj7FumkNbwIAu9opvQ
	(envelope-from <linux-wireless+bounces-33408-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 16:31:10 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCFB2BE40F
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 16:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C65031629BE
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 15:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83EDC3E9F60;
	Wed, 18 Mar 2026 15:03:30 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3371F3EB81B
	for <linux-wireless@vger.kernel.org>; Wed, 18 Mar 2026 15:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773846209; cv=none; b=OYJg1a6MrRHXc+Z1XdJPkO1STWlTLL51SXt/FHp8Ul4/g/J4M/q9/t0wvDlFrIxm6YVCtPLxdgiBXkG9bLz7ykwLk/Iwrptoqo7zU/ww0gjTj/YguadrZ4PVvxshacbYou1gGNwMJmbrulphaD6x34Bbf54M0EAFU+/zYKopZ7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773846209; c=relaxed/simple;
	bh=5NcsxaHVIQ2NmCj9OLQh+nSLlXz0JVUjSv0mBYVb1MM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m+YJosUXXQ2WMnT7UCEE2dWBGKe/AcmaRJtKJG8eybydD5JPJiSxdSO14HgZo/2J3cd12RrYosGJLQv07QN+MVHS/Q0IzPXSxYHpfJ+aKjY72p5gRoyLPx5LORDR/4KoNoDDhQhPHLL4tBHkwUJCvQpXE8/7i8Jbrt15lH/YZHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-128ebee22caso5018972c88.0
        for <linux-wireless@vger.kernel.org>; Wed, 18 Mar 2026 08:03:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773846206; x=1774451006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HbyBRqP1dM0VO6fEJ4blZH7JfwL0DV5fAiX12aFZ5no=;
        b=XDog63ihzkgyGjm9lj1OaNur8o9T8sTo5IELROFYDhTVbdhRuWjgDd+a2yNnTEHwt5
         PPaFweleyJoGIOYoZ01nNrjiGTyaGujqORZ/BUFXW2JPx/+C8u1gbkKA2e08CAfxmvNP
         X0cnhdwm2Xq6BTElTMxpftK++qXCHRkqsG7mg1gjyBcrggATX4UwpH0qUYJaImdA1PWW
         yMLjPAzFElVjSBlixeRdFqPqLUhMGhGXHH/s/Tz0xf0HaBmkkS1GZaP9gUHsQ58jI/Yx
         gvk8txGNUzf+tIUpLSUADyy8yD/8ZScydpsKA/d+3HICrAawtBWpUXLQHC2TOaFkqq4U
         A35w==
X-Forwarded-Encrypted: i=1; AJvYcCUPwXkPLjG2iM00kMkTHhNSJRM6tgvWv09zkwn2BHbiutMYzV2eJJ6XtuCSJVp4o2RG2UVM7suO9Jaydjwomg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv0gS/N711paL4BPxqvbgRmybnqpESqcQm3m51wa+riQp6LY0m
	H0sPuS6uVLI0xiVQ6Wh32TxyNF6yVxG9ZjG4+mYlbYhBv4tuIRBDhxk=
X-Gm-Gg: ATEYQzzljQGjs8ZYFfErtyGhRmSlplzVm9NFJMflRohizrv2/LgJ9BnC2bqfbDRLGuS
	Vmo9vg4UlPJJ2rbvOp56g4uAGl3ZbD9AVVp7L/rcLcU5RmZ6tWb5yCpOwLYARojYxO7UrMnmLEO
	hLSfXyugYSV5UlQifv/Pq+VvBzcUBaSpw01i8Kwblei+8k1UXdd/xTEYnZTqTrpjMSjnvUE34HI
	kR6VISQTE/O6TPbSdHKEFeUPy9fdUyuVcbDYfISdfehkX50N7sdDz3uUP3lwV63czXA+fYvPCLv
	1FdnNfgJ9IGOzyr0PZmNS+SRrQFf7oqfjuVkEGJ2IdFjl7ZnZIKaM8cXXD55OvP7e9jfz62ACoD
	7OaYNz3Zz0JGFrIw80KYz4N4bmyYQx+wDcKp2UIkHjGNPGT77GykQuh0GmwJuUiAGqyAhxlqRco
	BCMvg2rBDWvKWR/0A0sfHnp66BFBTCBZxWaWbewnT6zWjF4ltIn1gRSN2qyQgkzZ5wrw2pcMGXW
	C6qV3Vo3L2BVT0e/A==
X-Received: by 2002:a05:7022:b9f:b0:128:d51a:5161 with SMTP id a92af1059eb24-129a715e828mr2027441c88.27.1773846205882;
        Wed, 18 Mar 2026 08:03:25 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-129b41271aasm3384562c88.11.2026.03.18.08.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 08:03:25 -0700 (PDT)
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
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	leon@kernel.org
Subject: [PATCH net-next v2 11/13] dummy: convert to ndo_set_rx_mode_async
Date: Wed, 18 Mar 2026 08:03:03 -0700
Message-ID: <20260318150305.123900-12-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318150305.123900-1-sdf@fomichev.me>
References: <20260318150305.123900-1-sdf@fomichev.me>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33408-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[fomichev.me];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,lunn.ch,broadcom.com,intel.com,nvidia.com,fb.com,meta.com,sipsolutions.net,queasysnail.net,fomichev.me,gmail.com,vger.kernel.org,lists.osuosl.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sdf@fomichev.me,linux-wireless@vger.kernel.org];
	NEURAL_SPAM(0.00)[0.027];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	RCPT_COUNT_TWELVE(0.00)[35];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fomichev.me:email,fomichev.me:mid]
X-Rspamd-Queue-Id: CDCFB2BE40F
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


