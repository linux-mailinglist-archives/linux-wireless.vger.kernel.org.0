Return-Path: <linux-wireless+bounces-28687-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA65C414BF
	for <lists+linux-wireless@lfdr.de>; Fri, 07 Nov 2025 19:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A1A294E9A99
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Nov 2025 18:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DF033B6CA;
	Fri,  7 Nov 2025 18:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sc7IUGvk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79B83358A7
	for <linux-wireless@vger.kernel.org>; Fri,  7 Nov 2025 18:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762540394; cv=none; b=MEK6TETatHlEhyBs8RtSlg0lFCBkJR98osy2Wp/9Q4Z5ox2rt2KlpMtkuCYzIpqEZc7pUScdlLF7w5PTmeN2q853BNGodoQcgFK9qrckwQ9FqeqQlKe1pmFpp2rFQptXqksvEdAUDmX8sX+a1BoXM0DCHVClmpwDHturs1yzqiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762540394; c=relaxed/simple;
	bh=LEGAtv06Hrn9QV9+NCYV7AJGqINssJ0BskTW4tl1wKg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=raJDrgQvfKsWNVg/6AXjf1ZPMgPx3X/5lpA7gmClhIfDAIcgXOjx7SqYzhIWSSCFMMQHqGorkNglu5KVd8cH5ztCodaKnFQ1kwyhH4fsihJWADCz41Kuk/mqihB1R4rxHklY4eF08gRNzS0L3G5RxloI42ifH/wUzjRtk+RYCCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sc7IUGvk; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3409c8626easo152185a91.3
        for <linux-wireless@vger.kernel.org>; Fri, 07 Nov 2025 10:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762540390; x=1763145190; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QYXcwqST2s0E31dZAINQA8t4CykBZFIXj3bpdmbnoi8=;
        b=Sc7IUGvkc8ldAkDjYTt0PAILIiRW5dU4wQVKtWbDPZwxLe34Mq0W65NFpUkIWoaPBd
         pFzIXo3AEpW2KF5IedN42UcSlfJtRnZqi+QvDvjgqi79BMKp+puekYFnJehhHqpGhQxf
         mkhp/eJuKzdta8FkFfb+cx8F8KAQdatB93D2f9rghBFD1WOkM5z8Ud1y4d/570gonmub
         ompIEak9D3TuB19jQ9mO4OcRNojnUquvfJyziEEi2LDLIttkBNwbok8Gn3J4y/IPshWo
         F6/Vzxp0ehunjEuGabtv7lr4VhZvpU/seD1omU/6PT9Lfwh0+ceNTKS8VFVPvglTox0k
         QquQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762540390; x=1763145190;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYXcwqST2s0E31dZAINQA8t4CykBZFIXj3bpdmbnoi8=;
        b=KEb0reepxfQ36Y4y1tin1HZ8vb093SovaN7HEPjuo/Jw8dHusay20V6Y60w6EfGhT0
         h1vUWijUdGL/iECRDdsCr2sh2Q/Uk1zA5knF1RWGgEX9mzz4BX0T0bjDUTo0VpC8uad+
         GTxV48Gxn1SyRJo/HyQeh8dG1p6/c23i5x6IW4NREG4Ve2qxgAOkw+Py33HO8C6usAet
         HiG2QVrYaEmF6BcKlvZR40itqpvRX33z7S9DHIRjK1oIIpyNKRIWIm1rjxPenw7WUIXO
         IipyTTglj6LHygSrGHeBXYKQ4M9daUx+n4+a0hgh1uKNks1B+/G8C89utcONWTYx0VTF
         TFjA==
X-Gm-Message-State: AOJu0Ywkko4OBqnTVitCK1Nr0WbA1gzRT6sxIeVdWH2gycjbB3v1FK8m
	jSJfNoupP0vuncUorvVLJ5uIWqM5Oz0FXQy2VMGzxvs04JDJCp3zse2xSUuXhSpf
X-Gm-Gg: ASbGncv6OTzHm1sqIzFo3I0Nv1ypnP4nNo0ePaBAW/QMfPThupyhmYo3UBT2WGqgy+K
	N7BICIw4eZKlxBTVnSvOuTSf866oSySj8JfueiL3ncir8CuY/Sn5kd+ATYHGpoJ5mUklGUY75ZA
	T/hSOejmqP9/qAU05ytuUOq38i0l3nXJjrll0JVdS/9U08xLCtsPU+JajlghEILolZl1pdXTZ3u
	hbNF+nB+X2mOWpu8zkiF0W2T0icYrjAYPp9qoYW7WuqO0RCrS+gVDWBAvOlg+GWdOStwYSWJWli
	GCB/RYvh97fciS00LzBxc5TvJWKA7BtKkyaWhyRsBUfjUHz6z84CGRHfJIkV3m79UGubA7d0oCi
	jjL4YkXdIR3RUL8/p3TEGED+MKZXTMFpgHnDsdjApKvYs1gUUbYdL9LfNnKUxZD1gwXUygRO9aa
	UwXc78CaB+pY99579nsnjFwGgh9cBCVsirL6sPYPc9Gg==
X-Google-Smtp-Source: AGHT+IFydgreo8L69m8Lj3Wz5N9g6puBAf7AeTzOPaImHV+/mEDckn77WmWr595qhcl05UceLjJUEQ==
X-Received: by 2002:a17:90b:164a:b0:33d:55b1:e336 with SMTP id 98e67ed59e1d1-3436cbf092emr56119a91.6.1762540390342;
        Fri, 07 Nov 2025 10:33:10 -0800 (PST)
Received: from [127.0.1.1] ([2406:7400:10c:53a0:ba5d:ce6a:b1bc:5685])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341d08afb02sm3619943a91.0.2025.11.07.10.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 10:33:09 -0800 (PST)
From: Ranganath V N <vnranganath.20@gmail.com>
Date: Sat, 08 Nov 2025 00:03:00 +0530
Subject: [PATCH v2] wifi: cfg80211: Fix uninitialized header access in
 cfg80211_classify8021d
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-fifth-v2-1-405da01c6684@gmail.com>
X-B4-Tracking: v=1; b=H4sIAFs7DmkC/zXMQQrCMBCF4auUWRvppAk1rryHdFGSSTtgG0lKU
 Erubiy6/B+Pb4dEkSnBtdkhUubEYa0hTw3YeVwnEuxqg2ylRmxRePbbLC7KamPIeW0U1O8zkuf
 X4dyH2jOnLcT3wWb8rn+h+wkZBQo1Sol91zvn6TYtIz/ONiwwlFI+EUbyAJoAAAA=
To: Johannes Berg <johannes@sipsolutions.net>, 
 =?utf-8?q?Dave_T=C3=A4ht?= <dave.taht@bufferbloat.net>, 
 "John W. Linville" <linville@tuxdriver.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com, khalid@kernel.org, 
 syzbot+878ddc3962f792e9af59@syzkaller.appspotmail.com, 
 Ranganath V N <vnranganath.20@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762540387; l=2349;
 i=vnranganath.20@gmail.com; s=20250816; h=from:subject:message-id;
 bh=LEGAtv06Hrn9QV9+NCYV7AJGqINssJ0BskTW4tl1wKg=;
 b=pZfo+VA9Xy1E3Mep907lbRLADH/mPjwkdXOA2gD8ol6J183CoZIi0z9jtxZR0W+3cYRAjDP/O
 NHcOcC1cqbvBEW5x+tYt4L3Ux5FdUepnXB6MTOVSAzOAuxIUnIBA+Rl
X-Developer-Key: i=vnranganath.20@gmail.com; a=ed25519;
 pk=7mxHFYWOcIJ5Ls8etzgLkcB0M8/hxmOh8pH6Mce5Z1A=

Fix an issue detected by  syzbot with KMSAN
BUG: KMSAN: uninit-value in cfg80211_classify8021d+0x99d/0x12b0
net/wireless/util.c:1027

The function accessed DSCP fields from IP and IPv6 headers without first
verifying that sufficient header data was present in the skb. When a
packet reaches this path, the header dereference could access
uninitialized memory, as reported by KMSAN under fuzzing with syzkaller.

Add explicit pskb_may_pull() checks for both IPv4 and IPv6 headers to
ensure that the required header data is available before extracting the
DSCP field. This prevents uninitialized memory reads while preserving
existing behavior for valid packets

This fix has been tested and validated by syzbot. This patch closes the
bug reported at the following syzkaller link.Fixes the uninitialized
header access.

Reported-by: syzbot+878ddc3962f792e9af59@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com./bug?extid=878ddc3962f792e9af59
Tested-by: syzbot+878ddc3962f792e9af59@syzkaller.appspotmail.com
Fixes: b156579b1404 ("wireless: Treat IPv6 diffserv the same as IPv4 for 802.11e")
Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
---
validate header before DSCP read in cfg80211_classify8021d().
pskb_may_pull() checks before accessing header structures to ensure
safe and fully initialized data access.
---
Changes in v2:
- Corrected the commit subject and Fixes tag.
- Link to v1: https://lore.kernel.org/r/20251103-fifth-v1-1-4a221737ddfe@gmail.com
---
 net/wireless/util.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/wireless/util.c b/net/wireless/util.c
index 56724b33af04..23bca5e687c1 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -963,9 +963,13 @@ unsigned int cfg80211_classify8021d(struct sk_buff *skb,
 
 	switch (skb->protocol) {
 	case htons(ETH_P_IP):
+		if (!pskb_may_pull(skb, sizeof(struct iphdr)))
+			return 0;
 		dscp = ipv4_get_dsfield(ip_hdr(skb)) & 0xfc;
 		break;
 	case htons(ETH_P_IPV6):
+		if (!pskb_may_pull(skb, sizeof(struct ipv6hdr)))
+			return 0;
 		dscp = ipv6_get_dsfield(ipv6_hdr(skb)) & 0xfc;
 		break;
 	case htons(ETH_P_MPLS_UC):

---
base-commit: ba36dd5ee6fd4643ebbf6ee6eefcecf0b07e35c7
change-id: 20251101-fifth-84c599edf594

Best regards,
-- 
Ranganath V N <vnranganath.20@gmail.com>


