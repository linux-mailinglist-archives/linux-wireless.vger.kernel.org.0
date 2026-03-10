Return-Path: <linux-wireless+bounces-32886-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NPCJCMbsGlAfwIAu9opvQ
	(envelope-from <linux-wireless+bounces-32886-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 14:22:43 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E077250138
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 14:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AE92332B58E6
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 12:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E873F7863;
	Tue, 10 Mar 2026 11:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="iZgR9Qp/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.119])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C3E472796;
	Tue, 10 Mar 2026 11:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773143749; cv=none; b=UrcDOlD+7zWLmEFj9bXEL/pRtdtRHFK142I7dk99eA4nuc0pAVrhJTJi+I6u1MiMYIeOAM0LWYPzTqE8pfWuFV3CQ0pQv8kJG6fUfUtJXcyRqqgYiDpj7V4C5PwiJUPIlOCgjEhApqao9hQUCq7Tq6d11UtDvKvGi9iGdYrn0AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773143749; c=relaxed/simple;
	bh=U4MQ2UyTEtTm9FfUFN8u0E2v86RR/vLyOkwrg7Rl0HM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IZIFSgxMnvDcw20+31r9qX+AgN0X0tyVBWDHquxdZV+vVzDiNrNkknnSPEiDnGZGkN0Y/iy5NGFDdefm2S4L/I5w1WWJvrQiCqktnTDBr3cyFG6AigcvqrQ4Bt0Duh668BTTljVSJlR+ozp1WCQxvlsdQp/my2Y4GqgDaV+k6k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=iZgR9Qp/; arc=none smtp.client-ip=212.42.244.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1773143726; bh=U4MQ2UyTEtTm9FfUFN8u0E2v86RR/vLyOkwrg7Rl0HM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iZgR9Qp/lpX/OmreeYrgDIq0nKrn+2xXsmJ+ujKKHWj38gCjeIaXC0HXbLenxcKHn
	 eZNL4G3CPb7QgYlqv4ksyr0oQNQgvUXSGiVD/dqs5vJU27jmBKVg8iLhZmsc9hNUgC
	 53HbVKeoFbQObql2T4QVWLDcbSGiyf68GGOL/0jI=
Received: from [2001:bf0:244:244::71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.55.2)
	(envelope-from <phahn-oss@avm.de>)
	id 69b006ad-2367-7f0000032729-7f0000019d92-1
	for <multiple-recipients>; Tue, 10 Mar 2026 12:55:25 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [IPv6:2001:bf0:244:244::71])
	by mail.avm.de (Postfix) with ESMTPS;
	Tue, 10 Mar 2026 12:55:25 +0100 (CET)
From: Philipp Hahn <phahn-oss@avm.de>
Date: Tue, 10 Mar 2026 12:48:51 +0100
Subject: [PATCH 25/61] net/bluetooth: Prefer IS_ERR_OR_NULL over manual
 NULL check
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-b4-is_err_or_null-v1-25-bd63b656022d@avm.de>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
To: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com, 
 bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr, 
 dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
 intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, 
 kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-leds@vger.kernel.org, linux-media@vger.kernel.org, 
 linux-mips@vger.kernel.org, linux-mm@kvack.org, 
 linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
 linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
 linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
 linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
 ntfs3@lists.linux.dev, samba-technical@lists.samba.org, 
 sched-ext@lists.linux.dev, target-devel@vger.kernel.org, 
 tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev, 
 Philipp Hahn <phahn-oss@avm.de>
Cc: Marcel Holtmann <marcel@holtmann.org>, 
 Johan Hedberg <johan.hedberg@gmail.com>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1522; i=phahn-oss@avm.de;
 h=from:subject:message-id; bh=U4MQ2UyTEtTm9FfUFN8u0E2v86RR/vLyOkwrg7Rl0HM=;
 b=owEBbQGS/pANAwAKATQtBlPRrKzbAcsmYgBpsAYq6Vp4tN82O3UqmYAB2rCpxamSEi8qzxQbQ
 a7J5ECg00uJATMEAAEKAB0WIQQ5bPBtrWDUcDQCppg0LQZT0ays2wUCabAGKgAKCRA0LQZT0ays
 2zTjB/4mjCTr3iXgM6OBkpfxhcEN7EQQZ1y9EXzSAaaFnPJ4J6dbscyHQ/vrwihzqSCkid2ehYX
 PXWgLr3enkVF+dbM8V9NRPpLg6F53eMyK7CDWQG9AEEJdJq5IDVkThiVxeIs2iOyPBRVnnYWh+Q
 FhA5NtTEwVLOnsWfWahJLqDe7jVY+yfeXhrX4z5N5WnqSQs4m5vScZRnTkdBPMBPzYgMtNL5igV
 SF/croNsrnotNJXtafaXYhWm05HCgfm5TNLHJLZIRe+0bC9Er8RwnfgRXEDKBgK6ljnqVy3QgCk
 bdr+gnx+ukbOMXU8jf2GxeDozNZ6NjdS7QCYNHlx/c+fJCr+
X-Developer-Key: i=phahn-oss@avm.de; a=openpgp;
 fpr=58AF7C2E007CDBE62C59E078F50EFDCF8AD04B1A
X-purgate-ID: 149429::1773143725-82488E1F-09EB3E40/0/0
X-purgate-type: clean
X-purgate-size: 1524
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-Rspamd-Queue-Id: 3E077250138
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[avm.de,quarantine];
	R_DKIM_ALLOW(-0.20)[avm.de:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[holtmann.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[avm.de:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32886-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phahn-oss@avm.de,linux-wireless@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_GT_50(0.00)[57];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[avm.de:dkim,avm.de:email,avm.de:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,holtmann.org:email]
X-Rspamd-Action: no action

Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
check.

Change generated with coccinelle.

To: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
 net/bluetooth/mgmt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index a7238fd3b03bb54f39af1afee74dc1acd931c324..06d2da67bbe14e17ee478aa939de26526c333d91 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4169,7 +4169,7 @@ static void set_default_phy_complete(struct hci_dev *hdev, void *data, int err)
 		mgmt_phy_configuration_changed(hdev, cmd->sk);
 	}
 
-	if (skb && !IS_ERR(skb))
+	if (!IS_ERR_OR_NULL(skb))
 		kfree_skb(skb);
 
 	mgmt_pending_free(cmd);
@@ -5730,7 +5730,7 @@ static void read_local_oob_data_complete(struct hci_dev *hdev, void *data,
 			  MGMT_STATUS_SUCCESS, &mgmt_rp, rp_size);
 
 remove:
-	if (skb && !IS_ERR(skb))
+	if (!IS_ERR_OR_NULL(skb))
 		kfree_skb(skb);
 
 	mgmt_pending_free(cmd);
@@ -8277,7 +8277,7 @@ static void read_local_oob_ext_data_complete(struct hci_dev *hdev, void *data,
 				 mgmt_rp, sizeof(*mgmt_rp) + eir_len,
 				 HCI_MGMT_OOB_DATA_EVENTS, cmd->sk);
 done:
-	if (skb && !IS_ERR(skb))
+	if (!IS_ERR_OR_NULL(skb))
 		kfree_skb(skb);
 
 	kfree(mgmt_rp);

-- 
2.43.0


