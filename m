Return-Path: <linux-wireless+bounces-29105-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DA4C6A332
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 16:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D0948348FA7
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 15:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AC831064E;
	Tue, 18 Nov 2025 15:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5IlITRH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781602FF64A
	for <linux-wireless@vger.kernel.org>; Tue, 18 Nov 2025 15:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763478339; cv=none; b=SpAQWXWVEzRyaAEIjVRXPuM+ieWzXzi3r0dyl8m5XCAzPhPuTva1XCyeNO9oYB4mwJPp9VSrr03qk1QNLoNz5/8AiCT4JajtnIfyyUuvDD/eibm6h8eg0Y/mkDhGex7O+Axq9Od0fjEq/ieffZ8a4Zh1DirzDPR9lLMKFz7Lsdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763478339; c=relaxed/simple;
	bh=5JOsnWWQuvsyVMYIYp1NHcoGzOeXw2DkggiJvUv9HVM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K5vBi3uVDQwM/LXINEeFC56ZpaEYyLG5GuXpcRmHTcmWEqPyKfyXirqfS+qCtM4N2zFkdL9LhgxA5O1/7b6nfJ3nD660ARNDdaGiBWLi0XBuzCPDZuvmZnzfkgTd/jrp59Uc0Vn3MKGcstyPI4rCQ/imtC/gdWFYjTDvLCYGAEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O5IlITRH; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-295395ceda3so7006035ad.2
        for <linux-wireless@vger.kernel.org>; Tue, 18 Nov 2025 07:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763478338; x=1764083138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=krvx9iMaxQ5G7caufLAI1QL4/vfOL4iJbw0Bt3cLPco=;
        b=O5IlITRHuGy0RbaEMUnDWgn5MXUlu1s5tWfyAvO5Jp39fRPq95k7vKfNlgDy9IOGW1
         pMZOgmnT3GiipbOYXsCJzhSC0HM1E3jgkhYKpg6GZ19SVUdSZKbrnsj/SdV29b0FQakq
         kvVOlfXgdmuMPRgnh6R0OMNAsOPg/unQ1SkfSbPpfL+oI/iSUEhP0SXJKJZ0MlUx0CPD
         FUtsdPhSMB5FKN0pwH4NkBmBoAQ9OtQ/08ciTYtysAMOmZOdJPJvZKwkwXDtLeGmyY/M
         5TpnxCIFkNRF1P0uYtljC/x1q0aNouTDozHAjOb+nCf1VHLEpE16vvYnF+3Y+m5ZCk0k
         pzMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763478338; x=1764083138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=krvx9iMaxQ5G7caufLAI1QL4/vfOL4iJbw0Bt3cLPco=;
        b=jNlwtqY65cS0pVrk8eMTvUJWHVtwSOmCvmNKec0dH4rxRlwbO0MMugGt+EepvD6MRg
         KOvs/pLpNvOo0VOfP1y4FKKBHxOfL5ZrW9dqGmOku6dQfcv/w6GsX1xxFQeeyuvz6JRx
         Fcp0Ef9Z8hubpse0amS6ZdFFK00xcG6Q/oSIKaFL5Ui8ZiR6OGHb4IzoDN4ZiQ0c3uiY
         7S7E5ZPCVcLTu4O3+MMVUxQLBxqi/m4MBart844zWwBML6S79RhLn5FUzF7h8j4ccAyI
         yVQAlhoHdT/0IUGEqooa1C+XXWA/zTYUNkp2bYC+xFG3PCJlzCdTl8O8dmOw8NTgxbMU
         kDlQ==
X-Gm-Message-State: AOJu0YyN1/yquRh91vM10PQonByqWMU6PrPBMJQnBTDR6KWikVKTn6vS
	9tP2WgceXIB9/PBYFwZus7kyI2ijh2MFNU8abn7Gh6MYJ+Z2IdBZ2IC+
X-Gm-Gg: ASbGncsUjNl8XZM7DO1tV2ETVwYu+1LMKX5hs9/WNdUEaqLtxYnrHx0a7fkcc4GIeXz
	A6+H2B0Dys/hZZDVufipSwi09iN5SKpNMGjITYHE1KR7s+UR5diMHhHXGfMMfZjDUpOEJnh8/Bd
	waCh2SWJktsVtND/uGEV36zjIqCxPinlb7qhfY3B0UYxwzns1JOKUDyoasgtNbk0ajbTtRwB27a
	33ce4C1ac0lE1i8t/HDuVXtqLO9as4l6XTvj5fjtSq778dKsMHG9oAkdu9slRv4s4AxeKrwMlNb
	saJUPUkmoyleR3ULica8TWB+eE1nSmOv/Enk3nxZMbS+27kzSQpkrfWTKuQbSyskJixPqrGDzjd
	kSURSFQiQ+AGrnoBD+8hUNnXBY8sdvLAii9WNkE9n5zGsk2H4Zz+UA4eRWlch42RlQfWaMRdEd3
	3rYJlVU1OKZj8PW0zjVUrlQSg1LQjn2gVmQfe9nHjK6u6kzmKpM7vW
X-Google-Smtp-Source: AGHT+IEMuGD101lyS+SaNmSnHdTEBmMKbQ1S6BZ+VBGNRmCkOSSB9VbplurCIK5Cfp/TjeGmqi8YJA==
X-Received: by 2002:a17:902:ce90:b0:295:f926:c030 with SMTP id d9443c01a7336-299f6546befmr23941315ad.2.1763478336930;
        Tue, 18 Nov 2025 07:05:36 -0800 (PST)
Received: from ranganath.. ([2406:7400:10c:8926:7d63:4fa7:baf4:c76c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c245f8asm177700835ad.37.2025.11.18.07.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 07:05:36 -0800 (PST)
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
Subject: [PATCH v3] wifi: cfg80211: Fix uninitialized header access in cfg80211_classify8021d
Date: Tue, 18 Nov 2025 20:35:24 +0530
Message-ID: <20251118150524.7973-1-vnranganath.20@gmail.com>
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

Changes in v3:
- Corrected the code by using the correct offset  past the header.
  similar to the existing MPLs handling logic.
- Link to v2:https://lore.kernel.org/all/20251108-fifth-v2-1-405da01c6684@gmail.com

Changes in v2:
- Corrected the commit subject and Fixes tag.
- Link to v1: https://lore.kernel.org/r/20251103-fifth-v1-1-4a221737ddfe@gmail.com
---
 net/wireless/util.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/wireless/util.c b/net/wireless/util.c
index 56724b33af04..f2a6644d854e 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -963,9 +963,23 @@ unsigned int cfg80211_classify8021d(struct sk_buff *skb,
 
 	switch (skb->protocol) {
 	case htons(ETH_P_IP):
+		struct iphdr iph, *ip;
+
+		ip = skb_header_pointer(skb, sizeof(struct ethhdr),
+					sizeof(*ip), &iph);
+		if (!ip)
+			return 0;
+
 		dscp = ipv4_get_dsfield(ip_hdr(skb)) & 0xfc;
 		break;
 	case htons(ETH_P_IPV6):
+		struct ipv6hdr ip6h, *ip6;
+
+		ip6 = skb_header_pointer(skb, sizeof(struct ethhdr),
+					 sizeof(*ip6), &ip6h);
+		if (!ip6)
+			return 0;
+
 		dscp = ipv6_get_dsfield(ipv6_hdr(skb)) & 0xfc;
 		break;
 	case htons(ETH_P_MPLS_UC):
-- 
2.43.0


