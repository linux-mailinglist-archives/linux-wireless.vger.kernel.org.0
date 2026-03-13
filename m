Return-Path: <linux-wireless+bounces-33223-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBJiJMyBtGlTpAAAu9opvQ
	(envelope-from <linux-wireless+bounces-33223-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 22:29:48 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03AAE28A257
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 22:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A67F530BD4B8
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 21:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC4B3845B7;
	Fri, 13 Mar 2026 21:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="q5CFfSRi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB717383C77;
	Fri, 13 Mar 2026 21:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773437317; cv=none; b=P77ySmtwlt+RKBTXXAvx4e0Kn1AxfTO2knCQ+XtjjNE+9DOKPLXffj5zA71OJ0LmWgQxMcFvWogc3kCstQwv7sqDOPE/MlmCIJjQr7SrovkqrHksJhgYb6ClwyKp9j6CVXsfIiVdEo2n2B215SrKuRQ3634yFUbeI9U725ABWi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773437317; c=relaxed/simple;
	bh=BiSayE4X/AHhfUxoL2VF88TJEBL7c6Ay/Ox9DM/4S4A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kXH6TO2EuonyuqpCxdwDikWFiIfdoDOhnnr0lqLH8sMMKcaNUBTTVF/8zfphB1X6DWMwg8Vyo+SPdKJl2e8P51YyqeMEzpyBbHO2K8RgMaYmnYsXN/h3rtpNRZU4Jn8ZeCtu1l7oPoFpBxqZWVO5cU0T8oCcDgYv26HjI/H0fgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=q5CFfSRi; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=aMF023Uvh9HyQgJBywtj4fEU0ZRbBwL78zphGqevtkM=; b=q5CFfSRiuKfYPj2UNV3DDZ0w1z
	IkCwVIUiDdF3AsL7vYB39wBa5Hd+1nutNu0i3ih3UeXVBvEWMY935BXyLQ0eAQfLbqF7SNy95SzXg
	tvevHwV30qbWaEuO2ZP2+V2ku15RDVYAcTBX8Wppb9QFpQt3Oah4rHlYBY+TwG4C/ZVKX1gCeglDI
	K33z9V3PS3BFoDPjmCcyN1FIMYcSxID/WxiiKzJn0j518H40PSRhEvbenvnfG+iZVYry/o238Qt6e
	Dx95KXOraxPhX5WVrhSF+/cjgdM1fu8dQo7hrTBEux9PRoC/8bL9v+7MbC8GM0xfjcdPyDG/5hkyG
	i8R9P3WQ==;
Received: from 189-14-81-93.vmaxnet.com.br ([189.14.81.93] helo=[127.0.1.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1w1A3d-00FRhq-CL; Fri, 13 Mar 2026 22:28:33 +0100
From: Heitor Alves de Siqueira <halves@igalia.com>
Date: Fri, 13 Mar 2026 18:27:57 -0300
Subject: [PATCH 1/2] wifi: libertas: use USB anchors for tracking in-flight
 URBs
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260313-libertas-usb-anchors-v1-1-915afbe988d7@igalia.com>
References: <20260313-libertas-usb-anchors-v1-0-915afbe988d7@igalia.com>
In-Reply-To: <20260313-libertas-usb-anchors-v1-0-915afbe988d7@igalia.com>
To: Johannes Berg <johannes.berg@intel.com>, 
 Szymon Wilczek <swilczek.lx@gmail.com>
Cc: linux-wireless@vger.kernel.org, libertas-dev@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33223-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[intel.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.645];
	FROM_NEQ_ENVFROM(0.00)[halves@igalia.com,linux-wireless@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[igalia.com:-];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,igalia.com:email,igalia.com:mid]
X-Rspamd-Queue-Id: 03AAE28A257
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The libertas driver currently handles URB lifecycles manually, which
makes it non-trivial to check if specific URBs are pending or not. Add
anchors for TX/RX URBs, and use those to track in-flight requests.

Signed-off-by: Heitor Alves de Siqueira <halves@igalia.com>
---
 drivers/net/wireless/marvell/libertas/if_usb.c | 27 ++++++++++++++++----------
 drivers/net/wireless/marvell/libertas/if_usb.h |  3 +++
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/marvell/libertas/if_usb.c b/drivers/net/wireless/marvell/libertas/if_usb.c
index 8a6bf1365cfa..11cd1422f46a 100644
--- a/drivers/net/wireless/marvell/libertas/if_usb.c
+++ b/drivers/net/wireless/marvell/libertas/if_usb.c
@@ -114,8 +114,8 @@ static void if_usb_write_bulk_callback(struct urb *urb)
 static void if_usb_free(struct if_usb_card *cardp)
 {
 	/* Unlink tx & rx urb */
-	usb_kill_urb(cardp->tx_urb);
-	usb_kill_urb(cardp->rx_urb);
+	usb_kill_anchored_urbs(&cardp->tx_submitted);
+	usb_kill_anchored_urbs(&cardp->rx_submitted);
 
 	usb_free_urb(cardp->tx_urb);
 	cardp->tx_urb = NULL;
@@ -221,6 +221,9 @@ static int if_usb_probe(struct usb_interface *intf,
 		     udev->descriptor.bDeviceSubClass,
 		     udev->descriptor.bDeviceProtocol);
 
+	init_usb_anchor(&cardp->rx_submitted);
+	init_usb_anchor(&cardp->tx_submitted);
+
 	for (i = 0; i < iface_desc->desc.bNumEndpoints; ++i) {
 		endpoint = &iface_desc->endpoint[i].desc;
 		if (usb_endpoint_is_bulk_in(endpoint)) {
@@ -426,7 +429,7 @@ static int usb_tx_block(struct if_usb_card *cardp, uint8_t *payload, uint16_t nb
 		goto tx_ret;
 	}
 
-	usb_kill_urb(cardp->tx_urb);
+	usb_kill_anchored_urbs(&cardp->tx_submitted);
 
 	usb_fill_bulk_urb(cardp->tx_urb, cardp->udev,
 			  usb_sndbulkpipe(cardp->udev,
@@ -435,8 +438,10 @@ static int usb_tx_block(struct if_usb_card *cardp, uint8_t *payload, uint16_t nb
 
 	cardp->tx_urb->transfer_flags |= URB_ZERO_PACKET;
 
+	usb_anchor_urb(cardp->tx_urb, &cardp->tx_submitted);
 	if ((ret = usb_submit_urb(cardp->tx_urb, GFP_ATOMIC))) {
 		lbs_deb_usbd(&cardp->udev->dev, "usb_submit_urb failed: %d\n", ret);
+		usb_unanchor_urb(cardp->tx_urb);
 	} else {
 		lbs_deb_usb2(&cardp->udev->dev, "usb_submit_urb success\n");
 		ret = 0;
@@ -467,8 +472,10 @@ static int __if_usb_submit_rx_urb(struct if_usb_card *cardp,
 			  cardp);
 
 	lbs_deb_usb2(&cardp->udev->dev, "Pointer for rx_urb %p\n", cardp->rx_urb);
+	usb_anchor_urb(cardp->rx_urb, &cardp->rx_submitted);
 	if ((ret = usb_submit_urb(cardp->rx_urb, GFP_ATOMIC))) {
 		lbs_deb_usbd(&cardp->udev->dev, "Submit Rx URB failed: %d\n", ret);
+		usb_unanchor_urb(cardp->rx_urb);
 		kfree_skb(skb);
 		cardp->rx_skb = NULL;
 		ret = -1;
@@ -838,8 +845,8 @@ static void if_usb_prog_firmware(struct lbs_private *priv, int ret,
 	}
 
 	/* Cancel any pending usb business */
-	usb_kill_urb(cardp->rx_urb);
-	usb_kill_urb(cardp->tx_urb);
+	usb_kill_anchored_urbs(&cardp->rx_submitted);
+	usb_kill_anchored_urbs(&cardp->tx_submitted);
 
 	cardp->fwlastblksent = 0;
 	cardp->fwdnldover = 0;
@@ -869,8 +876,8 @@ static void if_usb_prog_firmware(struct lbs_private *priv, int ret,
 	if (cardp->bootcmdresp == BOOT_CMD_RESP_NOT_SUPPORTED) {
 		/* Return to normal operation */
 		ret = -EOPNOTSUPP;
-		usb_kill_urb(cardp->rx_urb);
-		usb_kill_urb(cardp->tx_urb);
+		usb_kill_anchored_urbs(&cardp->rx_submitted);
+		usb_kill_anchored_urbs(&cardp->tx_submitted);
 		if (if_usb_submit_rx_urb(cardp) < 0)
 			ret = -EIO;
 		goto done;
@@ -900,7 +907,7 @@ static void if_usb_prog_firmware(struct lbs_private *priv, int ret,
 	wait_event_interruptible(cardp->fw_wq, cardp->surprise_removed || cardp->fwdnldover);
 
 	timer_delete_sync(&cardp->fw_timeout);
-	usb_kill_urb(cardp->rx_urb);
+	usb_kill_anchored_urbs(&cardp->rx_submitted);
 
 	if (!cardp->fwdnldover) {
 		pr_info("failed to load fw, resetting device!\n");
@@ -960,8 +967,8 @@ static int if_usb_suspend(struct usb_interface *intf, pm_message_t message)
 		goto out;
 
 	/* Unlink tx & rx urb */
-	usb_kill_urb(cardp->tx_urb);
-	usb_kill_urb(cardp->rx_urb);
+	usb_kill_anchored_urbs(&cardp->tx_submitted);
+	usb_kill_anchored_urbs(&cardp->rx_submitted);
 
  out:
 	return ret;
diff --git a/drivers/net/wireless/marvell/libertas/if_usb.h b/drivers/net/wireless/marvell/libertas/if_usb.h
index 7d0daeb33c3f..a0cd36197c2b 100644
--- a/drivers/net/wireless/marvell/libertas/if_usb.h
+++ b/drivers/net/wireless/marvell/libertas/if_usb.h
@@ -48,6 +48,9 @@ struct if_usb_card {
 	struct urb *rx_urb, *tx_urb;
 	struct lbs_private *priv;
 
+	struct usb_anchor rx_submitted;
+	struct usb_anchor tx_submitted;
+
 	struct sk_buff *rx_skb;
 
 	uint8_t ep_in;

-- 
2.53.0


