Return-Path: <linux-wireless+bounces-36741-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LUvHUiiDmpCAwYAu9opvQ
	(envelope-from <linux-wireless+bounces-36741-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 08:12:24 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4E059F510
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 08:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 68108302236F
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 06:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFAE384CF6;
	Thu, 21 May 2026 06:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UBSv34Si"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1CD367B82
	for <linux-wireless@vger.kernel.org>; Thu, 21 May 2026 06:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779343942; cv=none; b=KlNG73oa5RCHO9yxRQ1stD4DnLC4bwUE3UqkGmc3srvKIqdWVOwJmap2wcBTr3631TQBsKdCEwFE5oFr7joTZiiG+lloXOPeDPcoZ5o/BA0+po6pSrBlzHlKxbATgOZErANBUj0+ufyDmES97VW5932rXFBcC9ElFijOv6Orzx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779343942; c=relaxed/simple;
	bh=k+fh7HBozKaLy+IwtXw65yFUdB1JormeXVzChOQGoWE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZBjEs3Rl9cb3ro+TWKHQ9xL+7ucV2ob4zI7gEbVjijj4CgMs6C/e0rVKDIYd0KpBFGA3uv5FbKMbK0z/NBzgY/t/tKshhaoXiz6hlzT0He3zFQs/1X0QMoCu0hdr5OgII8fHIInazMGxdaiwdO7ex7F+mZjTd0L7QOHYJpy1HX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UBSv34Si; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779343939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YYlzrjgrXqgXprjxQSH48QuvqMlaIMvGEKvu1s8m/Iw=;
	b=UBSv34Sido5QsgJ1cY0aArxXYFtsureqWXJwj2JsGZxfZa+VSm5uSo19WXoa8MPyNnLWzE
	xdY/kM4+zUQPLSImmKcoUDHdiwcqIsi82XsA+KfHrEwy8YLa/sX9DX9qeDLnFFvY4XcgsT
	Zbi6FF493QKO8bh4Dzg525lsVeZM7kw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-298-yPR-C3jzOVGi9TGQdH4ryg-1; Thu,
 21 May 2026 02:12:16 -0400
X-MC-Unique: yPR-C3jzOVGi9TGQdH4ryg-1
X-Mimecast-MFC-AGG-ID: yPR-C3jzOVGi9TGQdH4ryg_1779343935
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9AE21195609D;
	Thu, 21 May 2026 06:12:14 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.82])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ECD2130001A2;
	Thu, 21 May 2026 06:12:10 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: bhelgaas@google.com,
	alex@shazbot.org
Cc: nbd@nbd.name,
	lorenzo@kernel.org,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	linux-pci@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Subject: [PATCH v3] PCI: Disable broken FLR on MediaTek MT7925
Date: Thu, 21 May 2026 08:12:05 +0200
Message-ID: <20260521061205.12727-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36741-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jtornosm@redhat.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1C4E059F510
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The MediaTek MT7925 WiFi device (14c3:7925) advertises FLR capability
but the implementation is broken - reset always fails, leaving the device
in an undefined state.

This manifests in VFIO passthrough scenarios: Normal VM operation works
fine, including clean shutdown/reboot. However, when the VM terminates
uncleanly (crash, force-off), VFIO attempts to reset the device before
it can be assigned to another VM. Because FLR is broken, the reset fails
and the device remains in an undefined state, preventing reuse.

Disable FLR for this device so the PCI core falls back to working reset
methods (PM reset or bus reset).

This follows the existing pattern used for the MediaTek MT7922 WiFi
(14c3:0616), which is the predecessor device and already uses this quirk.

Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
v3: Resend with MediaTek wireless maintainers CC'd
v2: https://lore.kernel.org/all/20260508145153.717641-1-jtornosm@redhat.com/

 drivers/pci/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 000000000000..111111111111 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5607,6 +5607,7 @@
  * Intel 82579LM Gigabit Ethernet Controller 0x1502
  * Intel 82579V Gigabit Ethernet Controller 0x1503
  * Mediatek MT7922 802.11ax PCI Express Wireless Network Adapter
+ * Mediatek MT7925 802.11be PCI Express Wireless Network Adapter
  */
 static void quirk_no_flr(struct pci_dev *dev)
 {
@@ -5617,6 +5618,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x7901, quirk_no_flr);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1502, quirk_no_flr);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1503, quirk_no_flr);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_MEDIATEK, 0x0616, quirk_no_flr);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_MEDIATEK, 0x7925, quirk_no_flr);

 /* FLR may cause the SolidRun SNET DPU (rev 0x1) to hang */
 static void quirk_no_flr_snet(struct pci_dev *dev)
--
2.53.0


