Return-Path: <linux-wireless+bounces-20891-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA49A73407
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Mar 2025 15:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7B0B7A7F21
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Mar 2025 14:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC8D217F30;
	Thu, 27 Mar 2025 14:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxV4cvmR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D17217F32;
	Thu, 27 Mar 2025 14:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743084676; cv=none; b=LX1vsjo5MM4N3kW/QRDhn+PDTBEP05e6PZx4uOSwAiNkEn1b6tG55i6aSEo9Ufkb+pvfiCls+41TbSOpz2P4aIjkH0ZjDHtdXppQGhW4FQXe7lZrOZheZYhzW1wp44qj8A2SdqzuMhE4SCYMQrGgTOwrW+w9BRFDlTeGgSPIJPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743084676; c=relaxed/simple;
	bh=roxiBP8n2/WO6llbiXIIzqlvjmVUw//7N2vSH80w7Bo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=clUASfskYPhQ81P9uxwqS6oyZ1V89Lc8OA5t+FUXf3r/VLfdMStBZVtl36cHdVjeVlGYl/zisjjeQ0NSQi5Rd4u5NNfNFJvQnIBy6Valj67tGKQIazlsyp3mHW55USxINsad0hsh+TqFg7DNMUvhfX+wri9Skk8UMkaoIrg5JMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UxV4cvmR; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2243803b776so32983385ad.0;
        Thu, 27 Mar 2025 07:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743084674; x=1743689474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sjV04iFamzWhfZ36V6Y00gozFOhQNp9Rj1xFfvHl2/4=;
        b=UxV4cvmRV5UON5sTiX8MgXf03o7hIJABB5j7nl/xPxnCfaxcI6Sn7IkqlwtvfRQkax
         lh2OFJk2JyM+0qT8FFyxen6CTX2DpIWbAuU7G7q5cAXOgBwfCtumQunYSpagqGGE7kQA
         vsEXYPIQFdyc/iEBfd86twZRvVveuw07kOEuIDuw7TlKc84Y/Ys/sbTy/wqGOPEu6h0z
         +XWujc8XhYKFkKNlbbAv0k8HuC7LF4+kauFIAdXfHaHNyuxCYZSND//OFLZIM6qTG6Pt
         o7J/LDmAa5qcykFY6qCPKTN6Wif6xQyMseA3zH7gefD/Klm8V3y3wPgdN3eUUy/OTjzM
         cbpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743084674; x=1743689474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sjV04iFamzWhfZ36V6Y00gozFOhQNp9Rj1xFfvHl2/4=;
        b=qiWatMSVniIOU3tDYYRIH/kbNRBV+F4VGBs1geqQsvHWLps9MwKfb7E0ZuV659kL8t
         q0A6dKcEQ6bLA3VGlHm1P80CJNDNu/hw51XrRPJ/HGIXUJAS89gfR1MrNHoI/hNx483P
         3kBtOXtCJmBHtiqpS7Jfd8jbvZXVXhyrGMRK/QBxqEOFrEJ9UErpRRdhxfrTTF/cNgAN
         qXfkyBr6tw4MfJF2rNGrFeI/eIpVyz7em9OmxALmoR7gi3PySZi0aBQj4QH0j7g/QGtS
         ZrHtenA3VfgsXrc7hKOX4T6ayVzaHodZQFLpjvS8phPSRknnC2NmsWJ53ql9rNccUqWd
         FL6A==
X-Forwarded-Encrypted: i=1; AJvYcCVRNSj5Wx0MhYW0Y7BTW50gHfhDEK9Wms0gQ/mC8vzlBZtbZ554dHHvbwP93HheUoOk/iW5rixMqmDX2+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPeqHhEG/bh8Dve4em/t9q2iG/nCGamKqwd69kJ1AMeuEbcaS1
	Msj5S1XgXlboXyQ4f8XQn/uK9ltsjP40FN9AFUSi/BUSsJHfwjdRPUpEIwSY
X-Gm-Gg: ASbGncuSaA6SI/YveGVMGnMXF6u8OxF068fx2F4+r0yfplwUTcV3QZZxDuioEVub4iU
	d/ITPGp2+BlRGamRgnLLFuYVgQQihL2eiay27ynmmx0YvusXt0xYYTR3B/kbZZQyInGs58TKLjD
	7lbtaaGPBfO9IG65ImyqFG+U9s4k6uf5S1m9B5A0doNUUFpuvDG4S+g/Y3naJ2al9ScFFFer0tP
	jeZ1Rt62Ha81zGffvpjMiVE5HERlEIzSxlXjDJeJxuZSPLnWIxrO3U4e4SJB/9w1N5OrgVgrX0D
	rfc2TR3eds7X3Ms6E7VnlCoq1CAMP2m91gp0Wr4LqcO/U6cikOuurVRQnSPFq+fIKCnjOFjOazB
	hX65UHNSiaw==
X-Google-Smtp-Source: AGHT+IFOKGF56hs0/+rGpUCOdXMQzOCaiE/4zuMaKMjgEcg6lDy3KkcqM+Jl1YXYV2iA+AQZgdbR8g==
X-Received: by 2002:a17:902:e550:b0:220:d078:eb33 with SMTP id d9443c01a7336-2280495a074mr55475655ad.36.1743084673787;
        Thu, 27 Mar 2025 07:11:13 -0700 (PDT)
Received: from vaxr-ASUSPRO-D840MB-M840MB.. ([2001:288:7001:2703:ba38:f81c:733b:4bd9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811b2bf0sm129040755ad.145.2025.03.27.07.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 07:11:13 -0700 (PDT)
From: I Hsin Cheng <richard120310@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	I Hsin Cheng <richard120310@gmail.com>
Subject: [RFC PATCH] wifi: mac80211: Replace strncpy() with strscpy()
Date: Thu, 27 Mar 2025 22:11:08 +0800
Message-ID: <20250327141108.182585-1-richard120310@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The name of vif which is "vif_name" should be NULL-terminated to be a
valid string, however "strncpy()" doesn't guarantee that. Replace it
with "strscpy()" to make sure the content within "vif_name" is
NULL-terminated.

Link: https://github.com/KSPP/linux/issues/90
Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
---
 net/mac80211/trace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index 72fad8ea8bb9..37f5b1c87709 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -1725,7 +1725,7 @@ TRACE_EVENT(drv_switch_vif_chanctx,
 				SWITCH_ENTRY_ASSIGN(vif.vif_type, vif->type);
 				SWITCH_ENTRY_ASSIGN(vif.p2p, vif->p2p);
 				SWITCH_ENTRY_ASSIGN(link_id, link_conf->link_id);
-				strncpy(local_vifs[i].vif.vif_name,
+				strscpy(local_vifs[i].vif.vif_name,
 					sdata->name,
 					sizeof(local_vifs[i].vif.vif_name));
 				SWITCH_ENTRY_ASSIGN(old_chandef.control_freq,
-- 
2.43.0


