Return-Path: <linux-wireless+bounces-22055-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBC9A9C280
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 10:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07CA9179A97
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 08:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F06021D5A6;
	Fri, 25 Apr 2025 08:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Zcnpnv6i"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29CD23AE60
	for <linux-wireless@vger.kernel.org>; Fri, 25 Apr 2025 08:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745571334; cv=none; b=U5VoiL3A8aF0cYBfBsQ3V4Uy+Ksan3wfaNzGbxbmzIU8re+6ogGdDv48Udt1LtpE66cuUEJQh3eDVfyrOH7aSvrkdJ6RZfBiyBPDqmWBCIaYoq4CyhCVjwyDIovDmcqtr0KxnVEXmIymCwpXoZcqEJK247QCaUzs34kovs7J8d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745571334; c=relaxed/simple;
	bh=e0XX8DohJ6VA0/cNyZXvWggjah+MHvEtyETKVHlxyO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jkGj4po0DgR9SlJY+uSigxX8soW91hg4+qlmcEAXyzqu5HDD7aWnIrYSC0V5kKvzXZmBdr2m6xkKe2UWAIiKJ/VE0CKe4pfKgO5kV2XuSzASIf4Kd1myGLPqzpw9TObtT5EcCO1fc12D0OtGhJ1SPAZ92B9deTKlMxWh5qYN8J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Zcnpnv6i; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22438c356c8so22725505ad.1
        for <linux-wireless@vger.kernel.org>; Fri, 25 Apr 2025 01:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1745571332; x=1746176132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2UZxtW3kPc6nJSgpcHu4czu11dbH1HDpqjV9mIbR79E=;
        b=Zcnpnv6iMkjOi+JMYams3Ca2UpZGvWjeYw1k1EDJZ5SjS6stsY4yokZZ9kVWeb23X9
         qCTEqVSHUd/yVrC5/2uRf0EWbLaYUtMSNyn4RLXe+AXdoT4FPiYAQJJA4yV56iap6L10
         QH1+R1FFqCstntEBYKB3wRIlgvbldgLWCu1yc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745571332; x=1746176132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2UZxtW3kPc6nJSgpcHu4czu11dbH1HDpqjV9mIbR79E=;
        b=OmzXZu+YH+CYd0X321KcybZuZVQatHEWnkCGb6bFbvQKaQKH/vaR4NC5VNdU5FTMOx
         8oKEOnTCCmx8nte8iJ4eotGJNP1e187KnzJiOTATU8sCHxPJdCyeHMQ+lN68cmeIXwWV
         Ay+0cRJL7iOFBGB+cqmezF4MsWJHX2AVSC+BTu1KuFYNDgq82g5n5pgPlv6YV01c2MJ8
         3ThjXFiS3d4SXYnGPBmquDD4PXMnSrXEeTW0oXSPmP5G7fbHYgVUf2nWM6NMuU53Pe+b
         LmFclR1i1nIyH1PNZIqG/H4Dy2PjpkSSU2ao3x3ansjk4+lgxtM8AUufhfknawbEhFo2
         IJWg==
X-Gm-Message-State: AOJu0YzEg6ItSecMIRHz6K37ukDo/DhQ/EHHOPDhvOAeN4cklma1u8ph
	ggrdOTk4BgZ73GIOUqMlttDVDsIEGVIrWCKkB8z+s36aIs/HQZw46BhK7g+wnw==
X-Gm-Gg: ASbGncuyOBhlWNpBabgIrFS/2jvK6h7xjBMwJcn8b806kDHqeK+8Yfxt4z1Yz1miNC1
	Y/QNoNDUEJ2uNrTfLlbKyjrY9D++5jvY1d0u7kB3ie7t3VW5Lx3xJBpS/U3UttSpatN4cfO8ZTU
	OfKuueIaLLz1mOPW6lP5BEeOgeC3cZ+Gy+yEVinozvB0F7AWlmWHELg3D7/aQrE3y8KOFxzWdny
	G+BHU/34w+gXLngn8Ec8rmtBQXCWRQTL6jkpkICL9Pet8hxJepwiKvswZtg9QYmPffOvxuzSj7a
	JogoZz95CYrOd9RRFrybOOPiN7cx0p56X0/TOFA3AIiWee7k8QW2PHVXJgggAl9m/tXtIWYg96I
	HtUwLSK17Lzfi4Pn7t3xn
X-Google-Smtp-Source: AGHT+IFJWWA7uxV6gGnFl29pDwXs7U2A6lCoWVMelhPlCxhZLOYa1o1oceQsOv8ZEACJfUmg11faNw==
X-Received: by 2002:a17:902:f550:b0:224:10a2:cae1 with SMTP id d9443c01a7336-22dbf62bba7mr20366085ad.37.1745571331862;
        Fri, 25 Apr 2025 01:55:31 -0700 (PDT)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db5221943sm26988875ad.249.2025.04.25.01.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 01:55:31 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	James Prestwood <prestwoj@gmail.com>
Subject: [PATCH wireless-next v3 2/4] wifi: brcmfmac: make per-vendor event map const
Date: Fri, 25 Apr 2025 10:55:17 +0200
Message-ID: <20250425085519.492267-3-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20250425085519.492267-1-arend.vanspriel@broadcom.com>
References: <20250425085519.492267-1-arend.vanspriel@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The event map is not intended to change so make it const.

Tested-by: James Prestwood <prestwoj@gmail.com>
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.h
index eed439b84010..38a9138f1fd3 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.h
@@ -337,7 +337,7 @@ struct brcmf_fweh_info {
 	struct list_head event_q;
 	uint event_mask_len;
 	u8 *event_mask;
-	struct brcmf_fweh_event_map *event_map;
+	const struct brcmf_fweh_event_map *event_map;
 	uint num_event_codes;
 	brcmf_fweh_handler_t evt_handler[] __counted_by(num_event_codes);
 };
-- 
2.43.5


