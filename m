Return-Path: <linux-wireless+bounces-32602-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KlxCRiWqmmIUAEAu9opvQ
	(envelope-from <linux-wireless+bounces-32602-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 09:53:44 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A4421D76B
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 09:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A3A50305DD5D
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2026 08:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77C137C115;
	Fri,  6 Mar 2026 08:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8Jz2X30"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A53333A02B;
	Fri,  6 Mar 2026 08:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772787136; cv=none; b=eR7YwDKFb5tZARYgAZU5DZCc3GtaYyOAVGNQkI4qXT9Fz8k3ZQVitBYnK20wnyd3a80Vv1sU5p0cvWupc6iR8zQnZ7skE0FbZCC8Z2Irm/3Uyu6ivIOlJeNNDHJBcDmoxYi7woXdz7UefJ708l6wfVqAuGbbb/bpzm4MHj5oX54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772787136; c=relaxed/simple;
	bh=BJvbZkWynHLgBgJjsx12cqTdSqkHD6VpiScwFoXBO2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R2KV1iEHNKWRh9HhV+TfiaZDJ9JacgiBQKW0ubVp/EvJF5FJ6oyE5ij7445hVn5QpVUYMyhhLvQ0+J6Vls3bIw2ITcZaZmX5erGAn5+OgA7YcekukbwiacwfMnvl+BP9hS7o9NniCH/N2KAuKL5HxZ65RY9bfObdRm3aT12g99o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8Jz2X30; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 950EAC2BCB7;
	Fri,  6 Mar 2026 08:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772787135;
	bh=BJvbZkWynHLgBgJjsx12cqTdSqkHD6VpiScwFoXBO2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N8Jz2X30asuT03WkVMnqHDL+Lwb3vmpaUJFnGwGQjfN6hZFSHlvZklAfVlbnVSW8e
	 NkSx/w0DjjxY2q1wDgQC5ansgflJbi6Rc0sMKD0FfbZcRbGw2foLl91jqt2/LFfYCA
	 mW3TB6K5Pqk5NTRkYz4G40eMxY0MNdQ33JsMeYLNwMGMjPGfLvBk/DARIZLEE4Ul+J
	 2SznEp+Q6dCGO9HmToqXgxO3D+xIfHb7icajF3M/YFIDLXXA530wqmE4X7mx5CfqQ7
	 5rjn9/N0j2Ea3zsqlSKuZjnR8TYWkAhK+s0iNYbLVGDepOMy5KwbJTgVfj1hkbyAVh
	 aXS3E6IQGddNQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vyQuq-000000003AN-3ShE;
	Fri, 06 Mar 2026 09:52:12 +0100
From: Johan Hovold <johan@kernel.org>
To: linux-wireless@vger.kernel.org
Cc: Jeff Johnson <jjohnson@kernel.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Stanislaw Gruszka <stf_xl@wp.pl>,
	Hin-Tak Leung <hintak.leung@gmail.com>,
	Jes Sorensen <Jes.Sorensen@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	libertas-dev@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 02/18] wifi: ath6kl: rename disconnect callback
Date: Fri,  6 Mar 2026 09:51:28 +0100
Message-ID: <20260306085144.12064-3-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260306085144.12064-1-johan@kernel.org>
References: <20260306085144.12064-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D8A4421D76B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,toke.dk,chromium.org,dolcini.it,nbd.name,mediatek.com,wp.pl,gmail.com,realtek.com,microchip.com,bootlin.com,tuxon.dev,collabora.com,linuxfoundation.org,lists.infradead.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32602-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Rename the disconnect callback so that it reflects the callback name for
consistency with the rest of the kernel (e.g. makes it easier to grep
for).

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/net/wireless/ath/ath6kl/usb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath6kl/usb.c b/drivers/net/wireless/ath/ath6kl/usb.c
index 814faf96f1ff..79c18f5ee02b 100644
--- a/drivers/net/wireless/ath/ath6kl/usb.c
+++ b/drivers/net/wireless/ath/ath6kl/usb.c
@@ -1175,7 +1175,7 @@ static int ath6kl_usb_probe(struct usb_interface *interface,
 	return ret;
 }
 
-static void ath6kl_usb_remove(struct usb_interface *interface)
+static void ath6kl_usb_disconnect(struct usb_interface *interface)
 {
 	ath6kl_usb_device_detached(interface);
 }
@@ -1227,7 +1227,7 @@ static struct usb_driver ath6kl_usb_driver = {
 	.probe = ath6kl_usb_probe,
 	.suspend = ath6kl_usb_pm_suspend,
 	.resume = ath6kl_usb_pm_resume,
-	.disconnect = ath6kl_usb_remove,
+	.disconnect = ath6kl_usb_disconnect,
 	.id_table = ath6kl_usb_ids,
 	.supports_autosuspend = true,
 	.disable_hub_initiated_lpm = 1,
-- 
2.52.0


