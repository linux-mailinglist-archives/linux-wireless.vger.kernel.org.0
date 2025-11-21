Return-Path: <linux-wireless+bounces-29242-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E878C7A3B3
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Nov 2025 15:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C3EB44F286F
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Nov 2025 14:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7B034FF4F;
	Fri, 21 Nov 2025 14:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxSqP/7U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3615834CFC7
	for <linux-wireless@vger.kernel.org>; Fri, 21 Nov 2025 14:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763735257; cv=none; b=pLAKRIVBR77pBRy/PI5kMQ8JxQXa4KoXMCzh1dxCZ1gh9lMGaCKFbjzo6thLvei3vUoYMk6WWbjQ6uq5OGSF5kdB296+5ov08b5KXxe3MiBoA3sjzLGzUtvErO69f9O59Tnp909P+kBhtRfxRgc13XhVpAy0y0afhnCLj59B6zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763735257; c=relaxed/simple;
	bh=H2SjHh4uCC4lcNWoe7h+zkB6QMwCNdp94NemZs/zHr8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cc4YSliE2G7enfm7va6tPPxHfRmTRW1x2o8FDbk8lhxFQNQ9lOGvd4z9rmjgd3o9aKgdwqIcJqZCswu229U5KNM2urZudvX9zCnOTC53KvSu8SG1MVzg/6mxN04Efs0qIVX9FMyHd+62NiD1Rpol1rnS4gyY8zMr2dz4C4vISyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CxSqP/7U; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2984dfae043so19301055ad.0
        for <linux-wireless@vger.kernel.org>; Fri, 21 Nov 2025 06:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763735255; x=1764340055; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3Fr83+qeV0p2RShyZjZOruzDcu//lrY1lkC7Y8FE6mQ=;
        b=CxSqP/7UwyYYf03EZuD4AGcP9JbMkVC632Z3HlKBCXeH5CCHb05OURManMcF5ht2Sc
         HQQAkUWVn/zni/uAVUlrpWfdDp2ehx+vSWN1t0BovP8SOVs+oTnUYB9f0fi7Dd0lSxfR
         i/mT1Vok9Xg/WUrEAdNeMjVfkp2337PW9Yx+XUzaMZsf4vcxBYIXyEaRSxzRW8bpMJio
         kokM9t+bqv96Slzuerpd8I+9fY04jGvudJOY/4Kd2UJX+1ys4gsHOqNTD1hAhDH8PTlC
         XfbNHnYY6DCq7YXnm48G8wTCaTW0jApB+N4aP06xkQ/9s4BWBRIXmHwJbPVoJYyR7zpr
         Z7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763735255; x=1764340055;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Fr83+qeV0p2RShyZjZOruzDcu//lrY1lkC7Y8FE6mQ=;
        b=uv/eKobwi53iaLM5AgUKA9CWgRP/3r5cw37eA2YRW/wvZ6JN6eVqm+jsWSBBbHMgha
         /JKkUkCbuxT2vCyRLyqvvLXqMmbGtWHqL+nj65IjOTjjwSE1aR2NmNV7CNXfFrg6s9ik
         egyveU5w8s/o07r3BW7r0cSvV+JsvhIC408di419ivnrxCJ5BwTWYrhzev6iQf7/lIVe
         4G4+CBscDbMiW6boCzbpjYoPWhfDOrigwrK0jiNB6zFhlBSvHYx7NlMglbFAtuQBRcuf
         E0JaNGMkvbyKNmoMkUSX4Y0icSl4JJxzI0lj82pyjdn+YGnknbVMxmjDKq6aDjRqYSa6
         nWhg==
X-Gm-Message-State: AOJu0Yz/1nC+c7argAALsrIO6uFoX6F8oPmMgAgTxE6cVmB4k2h2JDLU
	0gZ+WUaiN7de1Bvtmjuk2dlT02ouUvnm/3drccS2jGDvaoFQHvdNb9PL
X-Gm-Gg: ASbGncuNgR7nx8qmuXdVz22MzzG/aiz/2YeIjzcd3qmI/YGOTRurFj3/lPwukJ52KiK
	cIG66lWLOb3O9zHnd2e99ZSXwDisrwsymbzAdAL3tUwp6PtoTgIcJvcdn6exA+3pDzrMBV2g4m4
	/MR8+IwILu7ZBO1yX8+pa+a/x8fOA9mSCzE1c6IhrGTUhMcjlOkFluuWewRXh0/ZTQKkSZy+7zE
	/gAGZE71zq8KcGDWDiH9xad16/hM61bkCW0ifcnleodV122p/AjpeditF8yx5hwnPdsaK5LF2i5
	6SKLRqTzk8JYIF4Xmt8A9P5PMvEy0u5FdjVPEDoYlhSVXZTeFW5zCzWerCOZXZ9XSYTiEcGsmep
	G8iZC+RUNe7ozQ0DTqsn+Uak5RC0CPZ7+lZp/EwJhJ2f9dZn5sfofmBIPmTrdkon32WMNhFFCGL
	ztHqXbDvRnzA==
X-Google-Smtp-Source: AGHT+IE+5gjDYp4bAbVjfX2yOEB3iRw4f+oTMFDykESLJPBIjLicbBnzgGI0rRAUz199kND2yw8dlA==
X-Received: by 2002:a17:903:19e5:b0:290:c0d7:237e with SMTP id d9443c01a7336-29b6c68be27mr34910815ad.39.1763735255300;
        Fri, 21 Nov 2025 06:27:35 -0800 (PST)
Received: from aheev.home ([2401:4900:8fcd:4575:1ad3:3d1a:3314:cdd0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b25e56esm59472955ad.57.2025.11.21.06.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 06:27:34 -0800 (PST)
From: Ally Heev <allyheev@gmail.com>
Date: Fri, 21 Nov 2025 19:57:29 +0530
Subject: [PATCH RESEND iwlwifi-next] wifi: iwlwifi: mld: remove unused
 variable in d3.c
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-aheev-remove-unused-var-old-keys-v1-1-6c2565c77ef7@gmail.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ally Heev <allyheev@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1254; i=allyheev@gmail.com;
 h=from:subject:message-id; bh=H2SjHh4uCC4lcNWoe7h+zkB6QMwCNdp94NemZs/zHr8=;
 b=owGbwMvMwCU2zXbRFfvr1TKMp9WSGDIVyi4dXhNgVdzEM08i+Phyw8qyt2eVM3SKzWvCA3p79
 /Hez8jqKGVhEONikBVTZGEUlfLT2yQ1Ie5w0jeYOaxMIEMYuDgFYCIi6YwMF388EnxzvWzyzI4O
 mTulz/dHS3P4Ciz/NIPpT8zE6boOjxj+118+t77J8/4rUT23/9tf1s1ljNnGz3Y38FTFi5DIE79
 v8QIA
X-Developer-Key: i=allyheev@gmail.com; a=openpgp;
 fpr=01151A4E2EB21A905EC362F6963DA2D43FD77B1C

remove unused variable `old_keys`

Signed-off-by: Ally Heev <allyheev@gmail.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/d3.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/d3.c b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
index 1d4282a21f09e0f90a52dc02c8287ecc0e0fafe1..fefb4f532a1f9fbb1a4a5cbd2ade817d5c1adb58 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
@@ -996,8 +996,6 @@ static void iwl_mld_mlo_rekey(struct iwl_mld *mld,
 			      struct iwl_mld_wowlan_status *wowlan_status,
 			      struct ieee80211_vif *vif)
 {
-	struct iwl_mld_old_mlo_keys *old_keys __free(kfree) = NULL;
-
 	IWL_DEBUG_WOWLAN(mld, "Num of MLO Keys: %d\n", wowlan_status->num_mlo_keys);
 
 	if (!wowlan_status->num_mlo_keys)

---
base-commit: 4427259cc7f7571a157fbc9b5011e1ef6fe0a4a8
change-id: 20251111-aheev-remove-unused-var-old-keys-104ffca9bf62

Best regards,
-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQBFRpOLrIakF7DYvaWPaLUP9d7HAUCaRLyowAKCRCWPaLUP9d7
HLG9AQDZmggT93tMLv32pq5myG3e83t12KWON9efOBg//lH4vgD+Ppw3KoTpdYtJ
20VDaWuqUVj9KLqjx9hblfEiB7s9gQw=
=A6F+
-----END PGP SIGNATURE-----
-- 
Ally Heev <allyheev@gmail.com>


