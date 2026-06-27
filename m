Return-Path: <linux-wireless+bounces-38202-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SYvsKHnMP2pXYQkAu9opvQ
	(envelope-from <linux-wireless+bounces-38202-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jun 2026 15:13:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DE36D1F92
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jun 2026 15:13:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Cr3weZJr;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38202-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38202-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 879563020A5D
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jun 2026 13:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E59E3AFCF2;
	Sat, 27 Jun 2026 13:13:22 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784963AD535
	for <linux-wireless@vger.kernel.org>; Sat, 27 Jun 2026 13:13:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782566002; cv=none; b=Ns6sBIjunZX42ODOEJX3t/2M00Ne70JdAB+3Idt62/tm+6VtKTnKLNXwoIkG/FHPASnlxFH6praf31moZ8omeNwZmACf+0ekSm0pXBIcVd38bykgwoAxg/Ywt5RIdmzFg574SHbYFHKAc6Z3PpWp3S6azP7IlHjjtSiXDzvYgW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782566002; c=relaxed/simple;
	bh=f2ywcAbauLIdDjioz7BzOI400RSnqiFwtqHAuTE1ASM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VPnXQGUZ/V3HpoviU5X4XmMUkFnZyZkDRpTeYRqtCzEMx0Gp9Ak6QhO8SAAiVqGAx8j+rW/Fqrk4eYknHrUCv7QDj5Ho+8z/uFtLRQPDK0n9v9UKrCKJI+LMiOLjv7tO5vuXUHMfB0Xh+78ug90UMdoRhuo4eHSg5vhbAxdVbmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cr3weZJr; arc=none smtp.client-ip=209.85.216.53
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-37fc01a7835so148948a91.3
        for <linux-wireless@vger.kernel.org>; Sat, 27 Jun 2026 06:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782565999; x=1783170799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ffzVDWTdghBqGnNg+yPYLtmRZ4dadK7EfCKOcmYolsQ=;
        b=Cr3weZJrMKarV5gFKU/2wS7rVvRN4rBYWtaDggoTVx/0xzmEO7ljZppfS0yM8JwQ+v
         5L3zZmuKC1/T0G/owBlXzek5Q+pm7et33uwibrGc8XwS9jOUoGd5y5Fmt88R9tU9WDrQ
         Zd/ZdX9RM/HI1M05XV73mdupsLJdiSEGP5IErFzd19QaHtFjJidwdOCYWOvHGUUR1PZp
         a63txWNAtZE9BXfTKHlkFaOqJQcpebOWLLKiDBwa6KFxzz4eWoXQ8F8ptyYxS/jeH83d
         e8ITR31eQ5Q9XHjCKVujnuTf6BBXpQqY25hTwsb48ldpv2yFevt6+FmmlJGLF9h5z7Hn
         2FJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782565999; x=1783170799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ffzVDWTdghBqGnNg+yPYLtmRZ4dadK7EfCKOcmYolsQ=;
        b=HGrrLzMLKWgj/OPhv/wc0kb02m0OKpH0jxUITLKiHWzp5/Wg4Oir/Su3i0Md5o8ifD
         P2ZD5UVkhr2mz42yrSKBwUQpFLT3OKt1z5q9sY+SppWARDj3KssjDOwX2n1jxSRVZQJ9
         gQddnbGMF9UxqkW7r9HUKsxrwSU6E4Mtnw+FjGH/c1vSE/aLQuRjLRYLmO7Pt8Fc2I3l
         uP3mCm3kJf7dI3lt/tiBUvSv+NPRQGQ4ysS2P7K4fgTFaLhZs5X4cCj/a8XNtjqokEX2
         eoEHAmV6k9JmNiA/FC45M0AA3BIpQL+J8ifCDg2i3VILHOe3Ppjrq5PH1a7brAsxHB84
         cUcA==
X-Forwarded-Encrypted: i=1; AHgh+RrVHU7klFMckCWOSL1P9OvY4PemtCmePIUIAH6wLs4Pyb4WCtSBBpjNtLySVJ13VJM6vSSIUvd2Q5aB2sJ79w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyX3Fnp+nCtsTL8uvX5WoNPaMxk10/ifpF4WA3PvdNOJJGP+LZ4
	+ALlWz9U95Ypla78UjIiamxzbjwydgqeE0NzeXH4nn29zxqgUBb9m/h2
X-Gm-Gg: AfdE7ckNKizOnnE+Jt/YB/ofeZxXuC/RE/lO91wybyPz5isuWrpcGe508jb0vVDf1es
	YWBRNGPcCO9BXm+ouVp0Mn2cpEs6BtbNBg07uOq6GdH2CVfFAkNPRcGGS+BZAuV/AGJJLTNtW47
	VVFpP+l8taAyh1CbF4oJoVKfCwqOy5b9m3UPQixDvFKYubMa6BbmO5PqoFREjrZt63Md7JAgYOW
	6n7IGhu+we1T6xEhRmcB5bs+L00kuuaTVaNymvLAkOjbAV4L0MrJosK0VW+zGLQGhHHS1HUtnCp
	puZgFWZ/Tja6LoQXLErVpbKMfd2KV56aQVKv220I78SOm2340j6ew6UDqbx5PDpizBsX/rSwpeK
	q8MyZy/H/5KKeBQFycWwx0FOi4WTGvUZusn1026QL/XyK/FnlxMfpG+BY+XqRTRduZD5q1uJs/2
	J+oapUSUX2HOkO0R/ZOnVTSm4Wbsrvz/QV6pgybxEAsz/fMu1w
X-Received: by 2002:a17:90b:2244:b0:37f:df85:272f with SMTP id 98e67ed59e1d1-37fdf853de2mr240302a91.19.1782565998696;
        Sat, 27 Jun 2026 06:13:18 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37e1c93272fsm2598840a91.14.2026.06.27.06.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 06:13:17 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Maoyi Xie <maoyixie.tju@gmail.com>,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	Kaixuan Li <kaixuan.li@ntu.edu.sg>,
	stable@vger.kernel.org
Subject: [PATCH] wifi: brcmfmac: cyw: fix heap overflow on a short auth frame
Date: Sat, 27 Jun 2026 21:13:13 +0800
Message-Id: <20260627131313.3878893-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lists.linux.dev,broadcom.com,ntu.edu.sg];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-38202-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:arend.vanspriel@broadcom.com,m:maoyixie.tju@gmail.com,m:linux-wireless@vger.kernel.org,m:brcm80211@lists.linux.dev,m:brcm80211-dev-list.pdl@broadcom.com,m:linux-kernel@vger.kernel.org,m:kaixuan.li@ntu.edu.sg,m:stable@vger.kernel.org,m:maoyixietju@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[maoyixietju@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ntu.edu.sg:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 34DE36D1F92

brcmf_notify_auth_frame_rx() takes the frame length from the firmware
event and copies the frame body with the management header offset
subtracted:

	u32 mgmt_frame_len = e->datalen - sizeof(struct brcmf_rx_mgmt_data);
	...
	memcpy(&mgmt_frame->u, frame,
	       mgmt_frame_len - offsetof(struct ieee80211_mgmt, u));

The only length check is e->datalen >= sizeof(*rxframe), so mgmt_frame_len
can be anything from 0 up. offsetof(struct ieee80211_mgmt, u) is 24. When
mgmt_frame_len is below that, the subtraction wraps as an unsigned value to
a huge length. The memcpy then runs far past the kzalloc'd buffer. A
malicious or malfunctioning AP can make the frame short during the
external SAE auth exchange, so this is a remotely triggered heap overflow.

Reject frames shorter than the management header offset before the copy.

Fixes: 66f909308a7c ("wifi: brcmfmac: cyw: support external SAE authentication in station mode")
Link: https://lore.kernel.org/r/178214417708.2368577.16740907093694208834@maoyixie.com
Cc: stable@vger.kernel.org
Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
index ce09d44fa73cf..873754be5174b 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
@@ -293,6 +293,12 @@ brcmf_notify_auth_frame_rx(struct brcmf_if *ifp,
 		return -EINVAL;
 	}

+	if (mgmt_frame_len < offsetof(struct ieee80211_mgmt, u)) {
+		bphy_err(drvr, "Event %s (%d) frame too small. Ignore\n",
+			 brcmf_fweh_event_name(e->event_code), e->event_code);
+		return -EINVAL;
+	}
+
 	wdev = &ifp->vif->wdev;
 	WARN_ON(!wdev);


