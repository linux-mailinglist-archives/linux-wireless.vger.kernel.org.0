Return-Path: <linux-wireless+bounces-28832-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9E3C4C678
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Nov 2025 09:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3391A4206D2
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Nov 2025 08:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4787729C326;
	Tue, 11 Nov 2025 08:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPMjQh24"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE96623E33D
	for <linux-wireless@vger.kernel.org>; Tue, 11 Nov 2025 08:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762849445; cv=none; b=bWD8A4RZL6MKDHVT3fJ7yyxOyV5p0Lre7DrtCWSh9TKY4mI/S0RevpsJvliQpKUsgkbQbxbVAc0zWsf4s7JK6CHx5TAO++Fdw4hpQTFdfTFYJD2MUKCPe0dMgrRYlA6QMVoiLiOVqe82ivSb2l7cQQZOyGEiR7qXOUWDrRojNOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762849445; c=relaxed/simple;
	bh=7WOHY6Tm97xi/2igTJFMDZsoJ3MtW8Vq3e7nbJKy+9U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QEAypX1M/wAgg07uZC14PEHpnAQ8GvuedRi/HIhbvOlAx1rvI33pKU2UY+IusV1UyG/dPQodXN6VsYgwk79Xe2mrtOyNsNYFF5BAtlnKFRNyiHhDkt4J3qdwkIsxMLrYKs999KswiOuD0/5xcK1zcoLpLg0Se18J+6p3WbRwB6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPMjQh24; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-297f35be2ffso32866435ad.2
        for <linux-wireless@vger.kernel.org>; Tue, 11 Nov 2025 00:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762849442; x=1763454242; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ma9rIXQwGFXqsO0TkfjLnvKeht33Ts48WkEjqYw9Mio=;
        b=GPMjQh24107jh6qWVeuIRdqBAvKORqW5fhFqN/JLUMuMdBBJvVk4pVH1Xrqsfj74HK
         lXXLi0hy0pKetzCBZcuPe8cQgD7xTCdsBJx3hwsFdYRlPlLnIF9kHSYvEGsPfK0izTAs
         7MyJs9t8DmH0qhAHlDl8vLYuHXqAc0hCYtClEwQSAt/kOemErLHT4Woq6/tzpqmRjzCd
         iOkWack+59abPff56GvbdTXQww5conUdrniWB8P3MA3zV2QIPkRS09sdeKA9HAVCX3Lt
         x8IooZdjDsNuAmVx28hg+X4Y7vOTQkltkzBqbntfoE9wBkMnyFJStO1mvoIfIHGMBo+3
         i1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762849442; x=1763454242;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ma9rIXQwGFXqsO0TkfjLnvKeht33Ts48WkEjqYw9Mio=;
        b=Z3vTNbs13F++N9ZIeS3grXYft68E8nlsoeIbFuYOkvN6h3FL/s7eD/7mvPVY5naluF
         U5c5nhripDHb6ur0z7bfFZm6Y5M88GTm3ov4QuaOxCPZ25nHBqfjDKLv7j3s1hPnGPOZ
         zu8dWxlNw1WXkoE0kJ3sE8GgB0ma+j701tb7eORb5rkKCtdi8Alfd0yvzI5UDc9LQ6GW
         GlSx89TEZBmEHt3vvSTyjEmSREHfyHyxEyG0VYlvSlnvOhXx0C92fOb00q+0PsI7g5Hl
         4BL01PRLgRP5u3jNkFQI5lLOarV02em7V42Ntg22tG3GB0whFHIlebGsjUw+ACOX+LPS
         VRAg==
X-Gm-Message-State: AOJu0Yz7M7/tIPyxpDP6sRLM/LaozLNjpX7UGCiDmfiG1UHtNWVQ9+L6
	GDcYGsN+uu0J7XfFh1J6/G8AUgiOxLhdwHcxemr7W5+8WsbpsCCyRUdo
X-Gm-Gg: ASbGnct5OrG1SSMyn2zW+vCqGOu6bMvlfXc5NLKpM2MiEb+OIftJkzN+VqZ89Lp5NKA
	pN2IjypgiNA7AdNIVM1etRi4B+GXvM2ohS/oUlvJPlcUjjoFOc3D/mqLl1CZqLBb9Rd5FKG/BSo
	LiIRAGwb3Msx0MX7Y+W5vmx7Ate+O24Go7ZDeQtMAzq8sUrIar/NXu78gtrQ0/nnZxI12T19SWW
	MrVmjCeEOTSP++QC51MJDyqGIqXfWXEwVd4zbxh9h4F3EmHH6+Wdb+dt4Xcq+VWf2TeVZ+n167R
	twfhjtabR5H1f5KLb/S6vjyOg/1c6XHXLgAKpYjuo2Wna2p1cIkDC9+7WogTHbj/zQ56JGy6Yba
	ajCqkFL6rzanCKIwO9cBMbwMT6KnsDVyGydzmnmKkWkI/Hrm6FhF8cPDgT8ua6RJ86SGtTiM2s8
	s=
X-Google-Smtp-Source: AGHT+IEeZ7bYdlt5cfuvraVmJHUc9e5eydPeAgrttdf5m2Leo/giPrvnaMzhna3eyxbGbeA3p+aSyg==
X-Received: by 2002:a17:903:388e:b0:297:f8d9:aae7 with SMTP id d9443c01a7336-297f8d9affemr132401255ad.46.1762849442096;
        Tue, 11 Nov 2025 00:24:02 -0800 (PST)
Received: from aheev.home ([2401:4900:8fcc:9f81:b4f9:45ad:465b:1f4a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b62cd94f6bsm2000428b3a.23.2025.11.11.00.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 00:24:01 -0800 (PST)
From: Ally Heev <allyheev@gmail.com>
Date: Tue, 11 Nov 2025 13:53:51 +0530
Subject: [PATCH iwlwifi-next] wifi: iwlwifi: mld: remove unused variable in
 d3.c
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-aheev-remove-unused-var-old-keys-v1-1-988de3a91b1c@gmail.com>
X-B4-Tracking: v=1; b=H4sIAJbyEmkC/x2NwQ6CMBAFf4Xs2U1oIyb6K8ZDpa+yEVvThQIh/
 LuNc5vLzE6KLFC6NTtlFFFJsYo5NdQPLr7A4quTbW1nKuwGoHDGJxXwHGeF5+Iyp9HzG5uyac8
 h9O76DBdLNfPNCLL+F3eSZVwkCEesEz2O4wfiJgrDgAAAAA==
X-Change-ID: 20251111-aheev-remove-unused-var-old-keys-104ffca9bf62
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ally Heev <allyheev@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1019; i=allyheev@gmail.com;
 h=from:subject:message-id; bh=7WOHY6Tm97xi/2igTJFMDZsoJ3MtW8Vq3e7nbJKy+9U=;
 b=owGbwMvMwCU2zXbRFfvr1TKMp9WSGDKFPs299mH31g2auUU5uecN7yycyZ50Y3VTtcqk6pcCX
 59w/psl0VHKwiDGxSArpsjCKCrlp7dJakLc4aRvMHNYmUCGMHBxCsBE0vcxMvwTrsiT/bzx3JGr
 Blwc63MO3b8S/DH9uX7OhS3t2Rvsjy9g+B/j3n+A/VbntDVvDm54rC3ycc29Q6zqvyct+tBklpJ
 Wfp4FAA==
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
-- 
Ally Heev <allyheev@gmail.com>


