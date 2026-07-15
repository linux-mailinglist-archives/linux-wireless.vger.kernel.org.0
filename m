Return-Path: <linux-wireless+bounces-39150-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4qR1D86TV2p2XQAAu9opvQ
	(envelope-from <linux-wireless+bounces-39150-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 16:06:06 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E2B75F246
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 16:06:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=OBcCryxL;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39150-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39150-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 368DB305BCC0
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 13:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F5E331230;
	Wed, 15 Jul 2026 13:57:26 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BA837BE72
	for <linux-wireless@vger.kernel.org>; Wed, 15 Jul 2026 13:57:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784123846; cv=none; b=KWcuDylC211dBurVFy3SNV/Pl6Qm88UgElT9P4Ai0yp1di1G9W322cXVi4fhCd/0NMHdO40YaVvu5MtXww+FV5z55mihNaxRQX2xMjIW6AMU3pkDm87gLWDNHWLWSvuiBrIHOVB41aeXl0QXJ/OUUWSe0kQ0+ee2sltMMTVdOzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784123846; c=relaxed/simple;
	bh=Kg5pQpuMzJ9sk/GlC7mPts5jsxjfpe/GLhONcI3X9co=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ihTYlffmD4fWV2kB00czztamcYQSv+ZV+AIKGxz3fs/RTJPI1Wjdn8nMXiNs0UoUt9d+XEoeKFQBcdoH5+2yP0bVC/3I4ymdv+hOjQDD332goSwHPv82utRPlNg4JXy4tRlBc8UGK41TAB7DreiN6uWoX5doKAeWApnJDArxAfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OBcCryxL; arc=none smtp.client-ip=209.85.216.49
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38e3617ba36so135339a91.3
        for <linux-wireless@vger.kernel.org>; Wed, 15 Jul 2026 06:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784123844; x=1784728644; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J1GlOyoJIFNgjl08SobaOhXV338mc62hPFF+7xVBCrM=;
        b=OBcCryxLWw0UXvtoiNBKlcIr2XK512YQ6QTr1PxT8plYNIG4Im9raHe80jhJdgud9+
         DRv2sUMPQArzfkhevQc9Q+OgJOo+W+P0dEPhYrQMvxM7BLvoMkT6gZ0/KXe2Hka/9DXL
         1VuIPeqpCWDEwE6o9aHwZLGsKFEbXf0FIJh9Rh0Yws5eugk9VA4t58eb4czdeFOPp4YA
         /p8MZfXiXrr+7VJFQJ+dsIs09BDEe7TsbzEZMIVHtSy0/AN0PW4QmQPTT6pOnNX82+ap
         4eKV/ErUcpQ/BlkUt+4mQlyJWQyicVz33kbDNGdFNegXGPt8dQTbhJAHR/d7X7rvkaJF
         MepQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784123844; x=1784728644;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J1GlOyoJIFNgjl08SobaOhXV338mc62hPFF+7xVBCrM=;
        b=HskNlbjSO34gV31Z+eou0cbCrsDt2FZ3Zlu+AsvKIKQbH5aJWI26YvCam5GQ3EvCL7
         RusDbg9hNuFQmIKpfyvBX3A6WaXtvnEeiq19bXdadhZdCIOXJLgSzk3RP4SoelQxdSFz
         Rj/nf2CaKam2SQHkDR4C0zcRscFIe9i2T/FwNMkroYY5YI090/Ha3KLxV4que+gRA3FE
         HwbXfxm2Vi+0ELyzfYn/Ldnzm+GChXN8caUetBcjT0P5zjuLYlZ2FNOl89745bGwLXkC
         kDckE58ajMj1xAne2O00LooHV/5yZx+CRYQVxNBnyNcatNCkylUPesW0vDGMf7FXZd1a
         kZmQ==
X-Forwarded-Encrypted: i=1; AHgh+RoqL+vkAZ9R1/ZXYIJr5inf5CEGHl2d4jxaWdnYrHtZkzM53e5yZ7/+9AoWVJ9RCRpoQX/SiuTiER/b3EBL0A==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywncd6wMQ+IISmoLontJ3f3uWdNQzI3mTxAM26VdSEikEHcSRP8
	7sHOHF8QYc6NmcsvyDgqL5oDrShClF3mIixAk0LumUJrHCG1VNX/7eEd
X-Gm-Gg: AfdE7cmQiY3tfvYqTR40jfvfOghF/vvWPnnANnu7lwmnfla+DV21BDSHipNZ/N1Gwo6
	oPCfeLw76zankD2XF9rCHg/3c1hXhX/okbxGfkrBdofm6L4zrAH+7OAp73hbrTi0vAIv03utP7w
	BueuVf/BsaTxM0W9hZ/qfLL7uSUzXNgao8BgZWMqzdiAZQS5VszZoKv5FvOejwn/vciRr9ky0xq
	fK77znXqeXEFjkKAzkzj+whEuDR7UGzgUJ/vwN932UXHlWxgw9cLWqU7PFp0PRZitpV4AK7cZ9r
	ZquwIlQB6B3A0sjz+mp7uqRTS9i8KxC45WDCWiuoVPhZuvHN2q+G0MV5Xsf1omK9k9utLDCtUft
	kg4oEvaQh3uq+JApaiZW/TXrH6KFKkgMmwEk4yQ/dlWE4jFW1fF7yEdw8zNLeMq21ddF8eWqnkJ
	SP/0n8Z2YKtKWSMFuAtbwUQfrKJ7FvZXjNKQMiMadv
X-Received: by 2002:a17:90b:180d:b0:37f:9ce1:736a with SMTP id 98e67ed59e1d1-38e1af3481amr6527165a91.32.1784123843763;
        Wed, 15 Jul 2026 06:57:23 -0700 (PDT)
Received: from localhost.localdomain ([192.197.201.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3140e6c08eesm2234881eec.21.2026.07.15.06.57.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 15 Jul 2026 06:57:23 -0700 (PDT)
From: =?UTF-8?q?HE=20WEI=20=28=E3=82=AE=E3=82=AB=E3=82=AF=29?= <skyexpoc@gmail.com>
To: Brian Norris <briannorris@chromium.org>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Kees Cook <kees@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?HE=20WEI=20=28=E3=82=AE=E3=82=AB=E3=82=AF=29?= <skyexpoc@gmail.com>
Subject: [PATCH v2] wifi: mwifiex: bound uAP association event IEs to the event buffer
Date: Wed, 15 Jul 2026 22:57:11 +0900
Message-ID: <20260715135711.34688-1-skyexpoc@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[dolcini.it,intel.com,kernel.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-39150-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:briannorris@chromium.org,m:francesco@dolcini.it,m:miriam.rachel.korenblit@intel.com,m:johannes.berg@intel.com,m:kees@kernel.org,m:kvalo@kernel.org,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:skyexpoc@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[skyexpoc@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skyexpoc@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C2E2B75F246
X-Rspamd-Action: no action

mwifiex_process_uap_event() handles EVENT_UAP_STA_ASSOC by exposing the
(re)association request IEs that the firmware copies into the event:

	sinfo->assoc_req_ies = &event->data[len];
	len = (u8 *)sinfo->assoc_req_ies - (u8 *)&event->frame_control;
	sinfo->assoc_req_ies_len = le16_to_cpu(event->len) - (u16)len;

event->len is supplied by the device firmware and is never validated,
and the subtraction is unchecked.  assoc_req_ies points into
adapter->event_body[MAX_EVENT_SIZE], a fixed-size array embedded in the
kmalloc()'d struct mwifiex_adapter.

On the ap_11n_enabled path mwifiex_set_sta_ht_cap() walks these IEs with
cfg80211_find_ie(), whose for_each_element() loop dereferences each
element header.  A firmware-reported event->len larger than the bytes
actually received makes assoc_req_ies_len describe IEs that extend past
event_body, so the walk reads out of the adapter slab object, a
slab-out-of-bounds read (KASAN: slab-out-of-bounds in cfg80211_find_ie).
An event->len smaller than the header instead makes the int subtraction
negative, which wraps to a huge size_t when stored in assoc_req_ies_len.
The same length is handed to cfg80211_new_sta(), so a more modest
over-claim can also copy stale event_body bytes into the
NL80211_CMD_NEW_STATION notification.

A malicious or malfunctioning mwifiex device (USB/SDIO/PCIe) can deliver
such an event while the interface is in AP/uAP mode.

Validate event->len before use: reject a length that underflows the
header or that would place the IEs outside the event_body[] buffer the
event was copied into.  event->len here is struct mwifiex_assoc_event.len,
a payload field internal to this event, not the transport frame length,
so it is validated in this handler rather than at the generic
MWIFIEX_TYPE_EVENT receive path, which only sees the event cause and the
transport frame length.  The bound is against event_body[MAX_EVENT_SIZE]
rather than the actually-received length because the transports store the
event differently (USB and SDIO leave the 4-byte event header in
event_skb, PCIe strips it via skb_pull), whereas event_body is the single
fixed buffer all of them copy the event into.  This is the event-path
analogue of the receive-path bounds checks added in commit 119585281617
("wifi: mwifiex: Fix OOB and integer underflow when rx packets").

Fixes: e568634ae7ac ("mwifiex: add AP event handling framework")
Signed-off-by: HE WEI (ギカク) <skyexpoc@gmail.com>
---
v2: fold le16_to_cpu(event->len) into a local evt_len as requested, which
    also shortens the bounds check.  No functional change.

 .../net/wireless/marvell/mwifiex/uap_event.c  | 24 +++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/uap_event.c b/drivers/net/wireless/marvell/mwifiex/uap_event.c
index 679fdae0f001..ba1bdbbff687 100644
--- a/drivers/net/wireless/marvell/mwifiex/uap_event.c
+++ b/drivers/net/wireless/marvell/mwifiex/uap_event.c
@@ -123,11 +123,31 @@ int mwifiex_process_uap_event(struct mwifiex_private *priv)
 				len = ETH_ALEN;
 
 			if (len != -1) {
+				u16 evt_len = le16_to_cpu(event->len);
+
 				sinfo->assoc_req_ies = &event->data[len];
 				len = (u8 *)sinfo->assoc_req_ies -
 				      (u8 *)&event->frame_control;
-				sinfo->assoc_req_ies_len =
-					le16_to_cpu(event->len) - (u16)len;
+
+				/*
+				 * event->len is reported by the device firmware
+				 * and is not otherwise validated.  Reject a
+				 * length that underflows the header, or that
+				 * would place the association request IEs
+				 * outside the fixed-size event_body[] buffer the
+				 * event was copied into; otherwise the IE walk
+				 * in mwifiex_set_sta_ht_cap() reads past
+				 * event_body and out of the adapter slab object.
+				 */
+				if (evt_len < len ||
+				    (u8 *)&event->frame_control + evt_len >
+				    adapter->event_body + MAX_EVENT_SIZE) {
+					mwifiex_dbg(adapter, ERROR,
+						    "invalid STA assoc event length\n");
+					kfree(sinfo);
+					return -1;
+				}
+				sinfo->assoc_req_ies_len = evt_len - (u16)len;
 			}
 		}
 		cfg80211_new_sta(priv->netdev->ieee80211_ptr, event->sta_addr,
-- 
2.54.0


