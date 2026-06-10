Return-Path: <linux-wireless+bounces-37627-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id p6f5CnRKKWqSTwMAu9opvQ
	(envelope-from <linux-wireless+bounces-37627-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 13:28:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE30A668CC7
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 13:28:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=eZtJ7UV5;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37627-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37627-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 91FCE300681D
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 11:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3693DEFF1;
	Wed, 10 Jun 2026 11:22:21 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EA23932F7
	for <linux-wireless@vger.kernel.org>; Wed, 10 Jun 2026 11:22:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781090541; cv=none; b=OshyI1D4cXkLIh1NgxC5GvtjkOrRg62H6BivHcKiknGY29Mf0Liv0/Sw4N6XAsHZJJJjfV38dHTv6qSFANSzWE4pbiysZakIbvSv3soH8T03Ywkabj4CyGiMfHX3KicXqThwpFgPQzsy/BdNGkkQNSe3U6V6qti8EnR5h7CEcw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781090541; c=relaxed/simple;
	bh=81fi74Es7hbpBwXb46QB/gNhccsSO4KpUAi5dNGAa60=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E1VUCLGaEBeUuNH8nicfUO6FfApbSgaZjbAo0RP6xx5DgdlqqBw9huvOWRj4sx9MjzNsL6Sr71y1zkCVdCZ2ZJhj9JFnGf0J2HOBP+HPG/cAlKl5Ac4jnGum0x9T0DBv39Ej5h/THk/FB49RAW9X29qT7xeyKlbKJCo9EvwGBHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZtJ7UV5; arc=none smtp.client-ip=209.85.216.43
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-36dac5d5d05so3570941a91.2
        for <linux-wireless@vger.kernel.org>; Wed, 10 Jun 2026 04:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781090538; x=1781695338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=opZ6v4Kl/mF5kQfriluZVsUk4+PmzqHRLQXTUfRfqXw=;
        b=eZtJ7UV5z49yBBxMZ8N4qszQSTtpcI2B5w+N+BXQzI67dtDo7IWOIM7kssYApCZJLd
         wst1CrfK1FNZ3NRlfIeF0MMxLosivHh+p1k8i/Ky8ikYICpkHGHw/Y3Zj/tBgC3+PCXc
         /11jZv3OG1wAhsUJXOLqwJ2jNwJ04bsoxXD3IUa1vzf7qRkgGCx2AvJEDhJr6HyONqvv
         hIXfs/WqTZuOLSFAnd6DoWz/LzTePq/iksEp80w+gOaAS02ZfwJG/bzFEOA39XEO/G8O
         8MN2zNccr9VqqT1qUPokIf8saT+2ig44hwNisHwW+W2YKuxiKUFfCg73ZIvrLWBuvP4R
         NHuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781090538; x=1781695338;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=opZ6v4Kl/mF5kQfriluZVsUk4+PmzqHRLQXTUfRfqXw=;
        b=ZnQUeaonISkOkxwvQTOsNw5/KvdORsYcZPU95DXuH0uK7NSx87wztm61FsSxCtdlnO
         nb+TsNB53WQWM4acv78zUvVjLZ+A5QKoru+v//wqmqYfmHLooryXgLIIpFPCn9ceQE6j
         aUHWw694dTFo9nKzKWORhtY77YcySM8GawV0QWOe9yKVkvCuO5FSdPHGETjN13hpqhGN
         zW66QjogxqT0NzVMzNbp2tiySZFQySJf02bhSXYmxDiSVLWBYWtY7Bon0Pf8BuyFOt9i
         MEFsPX6O4OBVH2UpeJhcpFSa0SRsjGp3WAxP+iDpqAwjimcHVmXxXV0LMnAd1sY6EFQI
         1VmQ==
X-Forwarded-Encrypted: i=1; AFNElJ/t5jZBngOfnDppuReI8bm3BBh+z/wV0VSEQ5bGMvweyVSvR5cleEjEwyPxltXhzJDmyMwAbXabREzCchwaTw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwvjXPf/+ugmBc0O3YOehA+6Q9sydtj2sq+3B7FZXRmo7uaFqg9
	A9q0O8Ak0PAmp7ea241P6NeAMVnXOQxtaYpD7kpRmKhMBZsJo3YrHMvg8V7TobksOVyxDQ==
X-Gm-Gg: Acq92OEgnubmZDvmU5Ej6m2w5Y5d9mxFTRHENeFS1mBkwvJRPhAZM74E8KCtXTJfzaW
	FpYXhLxtHhKiTJn0YMiti97lZ9IkDDF8JKI303P7xbppmzFagdFIXtzZEWM6w2u34KCLLFoRXHh
	KzA7nz/xnHOoq3o+L2RxyH5G1ZT0ItOwkqSGesexopCp+/skSyVOz/LnjHnxe+fuIc/GFcyf7o7
	DWFzGbkB2xP/TF3pZSk32+fzDUBeY/Bmv3XUWupy3IH9Fbjj0BNWyH2f8fPxd8XMZA3r5kOBcDZ
	zgoqkN46wm5dEFtcL4Sfr+IbUGspUeGem39r7IIpxKOdjhTGYOurPPMn2IZz4eTj7jT96C0umHE
	8ZQmuFDgHimq+Os1BbuAl6fa+6nv98sw2QWFd5PbKu2McwtmqRT8LycM8IUra0bBXwq+XB4v87i
	9ZTDuAn+PAfSSYpbm7dF/0NZk5XTFqYCDF5HTh1gLbePXXvaxWUe6gqPVfmzWGQa32H13cqWvbo
	A==
X-Received: by 2002:a05:6a21:4c16:b0:3a2:f14a:4287 with SMTP id adf61e73a8af0-3b4ccd3a3ffmr31763679637.6.1781090538069;
        Wed, 10 Jun 2026 04:22:18 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([139.177.225.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df033887sm21390403a12.2.2026.06.10.04.22.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 10 Jun 2026 04:22:17 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Aloka Dixit <quic_alokad@quicinc.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: nl80211: free RNR data on MBSSID mismatch
Date: Wed, 10 Jun 2026 19:22:09 +0800
Message-ID: <20260610112208.1308-2-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37627-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[enderaoelyther@gmail.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:quic_alokad@quicinc.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enderaoelyther@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BE30A668CC7

nl80211_parse_beacon() rejects EMA RNR data when there are fewer RNR
entries than MBSSID entries.

The rejected RNR allocation has not been attached to the beacon data yet,
so free it before returning the error.

Fixes: dbbb27e183b1 ("cfg80211: support RNR for EMA AP")
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
 net/wireless/nl80211.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 76c537a6e8b52..1b4c4440d2abf 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6519,8 +6519,10 @@ static int nl80211_parse_beacon(struct cfg80211_registered_device *rdev,
 			if (IS_ERR(rnr))
 				return PTR_ERR(rnr);
 
-			if (rnr && rnr->cnt < bcn->mbssid_ies->cnt)
+			if (rnr && rnr->cnt < bcn->mbssid_ies->cnt) {
+				kfree(rnr);
 				return -EINVAL;
+			}
 
 			bcn->rnr_ies = rnr;
 		}
-- 
2.50.1 (Apple Git-155)


