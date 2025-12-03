Return-Path: <linux-wireless+bounces-29476-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C00E0CA126C
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Dec 2025 19:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 424BC307928F
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Dec 2025 18:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE0233C1BC;
	Wed,  3 Dec 2025 17:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAaCfuV/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B093233C1B7
	for <linux-wireless@vger.kernel.org>; Wed,  3 Dec 2025 17:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764784471; cv=none; b=Vc7R8+0wWrZ3OELYUtb3zflV74V7MY+7TCarEKSAHjpMruOdDeNvFQcpf5W9w7ghKJSNa83Mt8kU7jW8UzqOON7NwpLqTssEG+LTnVsHdFNwGxX1We0S8qCqvKLSrBsP7Dq3xTgF9m1a/Di6ueHg9WQcYmiE/oC/xuNaAFbVmvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764784471; c=relaxed/simple;
	bh=b91PGNq6T4tIoUSb/5X5OlWyd9aKsFVmz28tvWrofAc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H3azy4XbStuClgzMsX6LHqUFQoHMO3/RCZXoEOM7zqWubsniQ7OLK61Ly5TupR6Y1pRNSheZsYIREgZhzucuhOZ7LUt32PIKOy1bDkRlHmppvaCQ/Ml09eWdsx26UBjSrB+E+CzLqRu8tBkpIZKrND8Z9ymbFiXwRTAS9AHs/4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dAaCfuV/; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7ab689d3fa0so688103b3a.0
        for <linux-wireless@vger.kernel.org>; Wed, 03 Dec 2025 09:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764784469; x=1765389269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3HLDU+yegVwP+uuF0zgG8lx8TsPWfyKI9wCQhdsW6y0=;
        b=dAaCfuV/1EBi8KPtbj3iDJRunyg0ZXyKcxJc16YMv+5Cqfdpzmw943Wz2BmBp3+TL3
         15sl2D+uhaNf7DbdLTjbOEM2RVAny4Bk3Yo69jo2bLzG9IXYNlAyAOZ58xZYAFzFym8q
         zCbBFXMwq4+Z2cYvefc+87iejR7+WnaKD2xpaAPRxE8QPiKzH/qpEA69HpcLNb1ixs6o
         EIsTmT9NjWf7PHYiuh11f6ONxIRpG5J2XDCDYttzulV58PqgENuG9u8AIDW5gRCEVAHy
         erxIt6Sq3rqxJQMMVcgXC5OpcAyrHgXU5GV4OvwOfq9Y4SGKi9omY3fYxjR0v0xMvCV1
         j6rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764784469; x=1765389269;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3HLDU+yegVwP+uuF0zgG8lx8TsPWfyKI9wCQhdsW6y0=;
        b=NuLORgd7AmFumXwB5ZRJ/5GByduD/w9WWoUX86S5ky1bT1iIsjAR5kMn9cJhE5dEAS
         broO5FihBL6duByatPU04OmqDTG5cm8qrGv8pnu6N0BbWG7r/rMiAb7QwGy6hx6RACmH
         oQ/Qe4dUDXqvrcgbXvME3Y3zgk8g6dNTRKboj1kiS0YoTECNOUET0S9eOvRS2/ZQLVgi
         LCZs8gfvRuM2bQqm7eqa2zAWNCD+Opj3aHv4prJzGKgVB+m5Sqw/DDHEp4PZKXnQCI3h
         n7JcJ2o3mGAj9Z5vcX17JxZRXs1nx/3+BYo4m619eCvHk/c1S8SF0y4mQn3Er4AElEK/
         k+gA==
X-Gm-Message-State: AOJu0YwDR5m2l8iz+UzZ6cP6mtXdBMUMCjC3rBej4ukdE/B07PYp8m69
	mAFjMl3cDttvLy5+nponGkvwtKD82/4D0j4ScJFIEl5coUnW4AUin+Qz
X-Gm-Gg: ASbGncuj40MREKm22gLyI4Cb/iZvpwxZfNnXod1d0QhFnx+IOwZ+dJxRF/GzAUQKUfC
	d5n7CaPHHDhWiPN9WT9X0AcRLeaKcl4wLiIh3MbLGmFcbeSfLRj9zrjpNQewLpivqJ6minLPNte
	u43NyqQWyxNfyymAp2er3WctfG1OkbuyfaGc9N7OxMsEjXFgz/UWSeK6Hvmr1ZF5CLpsvPE4UH/
	9yVrQFFqhYPyjS/n+7dCPEhxV+1e+zw58Q1WDAuQMgOuV6WG59HrBLq1WcBEQJ7jSapdGIp8OjE
	D4qL9xPsR4d4QmT85MA/0TbZWNYK++4PbtbbVbYzPgUNwvd5bULSENpswkctcGpNMhYvZRxutby
	Zb5LK+zTksuYgJAuSEHA2jL3flf8nqDKL5EAo9srnc5ospuedVHnZlOT9Sa9tPSBiaxEGsEuYqn
	cAktk8Itb1lM09KwJ0h7RhrGwKFwLRjiI77Wbu9sNyOV+lRBJDF6uOy+zPdEREAuY=
X-Google-Smtp-Source: AGHT+IHw8VdPPDLj9+iy/A58qr6HpfyuHNLvSW4h3LRgbid0GpF3mArdhHwkoIDjnnxwFs4to3nraw==
X-Received: by 2002:a05:6a00:a46b:b0:7e1:898e:4851 with SMTP id d2e1a72fcca58-7e1898e4b17mr664591b3a.0.1764784468610;
        Wed, 03 Dec 2025 09:54:28 -0800 (PST)
Received: from ranganath.. ([2406:7400:10c:791c:e184:5a58:9ede:99f7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d1516f6c47sm20914247b3a.18.2025.12.03.09.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 09:54:28 -0800 (PST)
From: Ranganath V N <vnranganath.20@gmail.com>
To: johannes@sipsolutions.net,
	dave.taht@bufferbloat.net,
	linville@tuxdriver.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	Ranganath V N <vnranganath.20@gmail.com>,
	syzbot+878ddc3962f792e9af59@syzkaller.appspotmail.com
Subject: [PATCH v4] wifi: cfg80211: Fix uninitialized header access in cfg80211_classify8021d
Date: Wed,  3 Dec 2025 23:24:18 +0530
Message-ID: <20251203175418.6623-1-vnranganath.20@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix an issue detected by  syzbot with KMSAN
BUG: KMSAN: uninit-value in cfg80211_classify8021d+0x99d/0x12b0
net/wireless/util.c:1027

The function accessed DSCP fields from IP and IPv6 headers without first
verifying that sufficient header data was present in the skb. When a
packet reaches this path, the header dereference could access
uninitialized memory, as reported by KMSAN under fuzzing with syzkaller.

Add explicit skb_header_pointer() checks for both IPv4 and IPv6 headers to
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
skb_header_pointer() checks before accessing header structures to ensure
safe and fully initialized data access.

Changes in v4:
- Corrected the code by using the pulled data to read the dscp.
- Link to v3: https://lore.kernel.org/all/20251118150524.7973-1-vnranganath.20@gmail.com/

Changes in v3:
- Corrected the code by using the correct offset  past the header.
  similar to the existing MPLs handling logic.
- Link to v2:https://lore.kernel.org/all/20251108-fifth-v2-1-405da01c6684@gmail.com

Changes in v2:
- Corrected the commit subject and Fixes tag.
- Link to v1: https://lore.kernel.org/r/20251103-fifth-v1-1-4a221737ddfe@gmail.com
---
 net/wireless/util.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/net/wireless/util.c b/net/wireless/util.c
index 56724b33af04..c403e2be18e9 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -962,12 +962,28 @@ unsigned int cfg80211_classify8021d(struct sk_buff *skb,
 	}
 
 	switch (skb->protocol) {
-	case htons(ETH_P_IP):
-		dscp = ipv4_get_dsfield(ip_hdr(skb)) & 0xfc;
+	case htons(ETH_P_IP): {
+		struct iphdr iph, *ip;
+
+		ip = skb_header_pointer(skb, sizeof(struct ethhdr),
+					sizeof(*ip), &iph);
+		if (!ip)
+			return 0;
+
+		dscp = ipv4_get_dsfield(ip) & 0xfc;
 		break;
-	case htons(ETH_P_IPV6):
-		dscp = ipv6_get_dsfield(ipv6_hdr(skb)) & 0xfc;
+	}
+	case htons(ETH_P_IPV6): {
+		struct ipv6hdr ip6h, *ip6;
+
+		ip6 = skb_header_pointer(skb, sizeof(struct ethhdr),
+					 sizeof(*ip6), &ip6h);
+		if (!ip6)
+			return 0;
+
+		dscp = ipv6_get_dsfield(ip6) & 0xfc;
 		break;
+	}
 	case htons(ETH_P_MPLS_UC):
 	case htons(ETH_P_MPLS_MC): {
 		struct mpls_label mpls_tmp, *mpls;
-- 
2.43.0


