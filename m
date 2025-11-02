Return-Path: <linux-wireless+bounces-28472-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D43B8C29512
	for <lists+linux-wireless@lfdr.de>; Sun, 02 Nov 2025 19:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61A0C3ABF92
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Nov 2025 18:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4280F1A9F87;
	Sun,  2 Nov 2025 18:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SseFiSB+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AAF322A
	for <linux-wireless@vger.kernel.org>; Sun,  2 Nov 2025 18:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762108369; cv=none; b=i5Kyomhfo0MS7oXCYZLj6gvujQ3k567LcgqG0BHTmdgfJefiipOG/L+OgNfGBOWdUhF3cgF/5m8NxU85EPaiquSZwwNH9ZO+zEL//d1hjDOtwfy/Kaq5my449in6zHyOiNcJs5uxi7u2xJ/oX0O//6H+K7uPk342fV0jX+Fp9Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762108369; c=relaxed/simple;
	bh=nc2++xXfXSNSf2spqDOarMEVxJj2fA11fvBUYumIbvI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QfI4Qpzqmb/eNYYHBytXTggkUcDOjwgenr8zKsfYkLGFCXTuoJ8OvDWI3vKDag2owchALbhqDSmZcgfj9uwrKJu4wbJmfBYfE2HTda33DdG4m+j3GtyTzIht9y4zFgsJlPWXx+CjBIWb3aWjBO/42h4ALz7uYM8hkKYTU7Zi3JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SseFiSB+; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-33bb66c96a1so1163547a91.1
        for <linux-wireless@vger.kernel.org>; Sun, 02 Nov 2025 10:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762108367; x=1762713167; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tah9ug5YH2dA1hXGYNiPSkVqoLrBjvr01zemW2oIgBU=;
        b=SseFiSB+RktYHwBR7BfGEi39i7tPKFoAbwXv+sOSMXjPSx21Ge2zECjDp2iSHvsZRw
         Xxv5qj/SAGpZCfsK8IfLLyY1uCU4yFsy3AfeqX/+y7LwmzDFN+U9IcDE9mZ/JV3hgYLp
         61SsHZxArIjOHeN7E9oOLE1v2qrGrJCf+NJai+JW5oEcxOPAThoY4SwQQhsqidqCm1Dj
         mQAwH4YwC8wrs710pu9fVwT+XphQfarM6BVVsasd7/PHlM8DM4hVkRrlM04MtGAX5A2k
         j//Ax2G3+JkMI/2xwggHQg8BLmC7J9iH97qVXZ6R/uWuGnT/bmzfLzxhJ5KJcEax6ZO8
         zaQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762108367; x=1762713167;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tah9ug5YH2dA1hXGYNiPSkVqoLrBjvr01zemW2oIgBU=;
        b=XyYUkPKKiDqoh+2hjMZNnVQhOVadv5L5gj2KIStcts1Gg8tr5QbMzTLJnUvL719J//
         zh5ft4l9Zckmtl3oopvP6azfSmxGWFwKT/VhAfWiPswzrI7ULt0LBI8mFzt/JhEuId34
         YBLQIgiUWkKU6yVxs/ypDIc1gvUpMtbWK9DJCOe+O/aqKjJr1G9cFtaXxZm5d1+T+mtf
         RyFcrEFvBDzXdeaggEcFTN4S0QVC4j2e4aZEhUqs+7wYHrqonXt2GixXnIUQCAbEshFn
         UG/KQRKHG6swLbuGd5PJPdmuKD+jpwMcn/GocKAecbqtSt4Z500QqG5OW5luyWN+qJ9P
         cdVA==
X-Gm-Message-State: AOJu0YxMe5kiqhT7hCejBnbxTj76qvqOFZqlKfrGgtlFfsqex23nKUlp
	DVeHc3FM0pkBxSdNbR7c8KhFCc38YM9vdNJCNt2FbrpUu+IXb1bDJOkc
X-Gm-Gg: ASbGnctW7fC2OHvD4p/OFdE81vdR1r/20HhyWWjikDhybDSl88N7tO1QdfFQKeWHtaz
	Zu4acB9qVf1gNkvvpXcKS+5EBXTZnmVoqMG8VgkD6D4r+RX4b/qHlULJEKy3g6vVLTEqEeNIheg
	cduMAkAjoMsL9chdGdHr/RX5RW6D6z3FT87oeTO9858LKRjDCIHaSE6JjM5K8XUAOd8TUPzbOF1
	U2kGdRfiLQhTBJC6Dk6XZ6YrRU4Iwwc8/SVe+yxruVT3CscXhp9RKYusqWeN6GTRbyeAZ7gPGl8
	FZOxd8xVyI63rejVGsT7Jgj+7pTLS77ii9U6BNVaP79Aki9F2Ep10LuniTUoo6tqdXjipoE6mdJ
	RmHa0ye5y3NriDtSQq1FGv0xBHwBe0kC17W7s4/wc81CX/d+936m711RUKduxdJyh+Xzkw3K0Ao
	MpzUXjDBgKPT0ZLltp5GS3K07sUyeWnU7CkJH+N/LHqiSIB6imoubv
X-Google-Smtp-Source: AGHT+IFc+aKzDeWFK07Ta0xgexELL2T5DExEWac5veVvAY0bVCmw7+fr2CTwMx1DbeSSkLy2g8ghBw==
X-Received: by 2002:a17:90b:38c7:b0:340:b501:3ae4 with SMTP id 98e67ed59e1d1-340b5013ce7mr4678749a91.8.1762108366910;
        Sun, 02 Nov 2025 10:32:46 -0800 (PST)
Received: from [127.0.1.1] ([2406:7400:10c:9fcf:ccb6:5cf2:6acd:f65e])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b93b8aa3ff1sm7874079a12.14.2025.11.02.10.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 10:32:46 -0800 (PST)
From: Ranganath V N <vnranganath.20@gmail.com>
Date: Mon, 03 Nov 2025 00:02:36 +0530
Subject: [PATCH] net: wireless: util: Fix uninitialized header access in
 cfg80211_classify8021d
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-fifth-v1-1-4a221737ddfe@gmail.com>
X-B4-Tracking: v=1; b=H4sIAMOjB2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDQwND3bTMtJIMXQuTZFNLy9SUNFNLEyWg2oKi1LTMCrA50bG1tQBD+PF
 dVwAAAA==
To: Johannes Berg <johannes@sipsolutions.net>, 
 =?utf-8?q?Dave_T=C3=A4ht?= <dave.taht@bufferbloat.net>, 
 "John W. Linville" <linville@tuxdriver.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com, khalid@kernel.org, 
 syzbot+878ddc3962f792e9af59@syzkaller.appspotmail.com, 
 Ranganath V N <vnranganath.20@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762108363; l=2187;
 i=vnranganath.20@gmail.com; s=20250816; h=from:subject:message-id;
 bh=nc2++xXfXSNSf2spqDOarMEVxJj2fA11fvBUYumIbvI=;
 b=mKMLKbUTq87I1QT0cHj4HyZmAtc+FkU3sNM9lExLaQ6r8MB1TpvSn8YVXZI8ENGtTboCYL06s
 bbXL11fijWlAfrnAiWmMFMZMuHsWCFO893fnDVOcOU5lz/W5hup2v9J
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
Fixes: b156579b1404 ("Treat IPv6 diffserv the same as IPv4 for 802.11e")
Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
---
validate header before DSCP read in cfg80211_classify8021d().
pskb_may_pull() checks before accessing header structures to ensure
safe and fully initialized data access.
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


