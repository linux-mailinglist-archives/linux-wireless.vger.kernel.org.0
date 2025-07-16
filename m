Return-Path: <linux-wireless+bounces-25555-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2442CB07EB7
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 22:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91BA91C268AB
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 20:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A001EE032;
	Wed, 16 Jul 2025 20:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="fFlGxKCl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A04C2D1
	for <linux-wireless@vger.kernel.org>; Wed, 16 Jul 2025 20:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752697181; cv=none; b=NVrsSQTDy3uODLFwktjrCdOasctJewkejfEZNYSJzEsUGDdmKDq8zbwlm4pLt+BGtyU6Fv+GST5BQMX7anKHA78OV4vDDGCTfwnoLH1reN8OhwLdiQZFrZ50NI1TZ2+sXQfEQuW6u4mBkbrIhjhznDhGJBE48cSFkOmLsGCHPOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752697181; c=relaxed/simple;
	bh=9iV+UHBhbN3U7UFpGTAv6gDKH65RiXDrp6TMftAk/mA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y/+IqpgTeLyfuWwtorfChXZ8mwKOYBTdvmS3tN4ZlquD6TzpGLo8ReWwmD0w6UJF1de7tVaKihn+QWUv4TRGlo/m//Ch4HSShErXIn/BV8OONl48KlK/JD6AzQP/YQ3TlkpBkqBw7zIbVGYAdqJdQ/L3XCwDjy3DU+fDzzTJe4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=fFlGxKCl; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a4fd1ba177so191913f8f.0
        for <linux-wireless@vger.kernel.org>; Wed, 16 Jul 2025 13:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mandelbit.com; s=google; t=1752697176; x=1753301976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h7ot+7Tc9QR3gV2axXkjDkCS1MRhJ97jbw7cnQjMbAI=;
        b=fFlGxKClWyauz783Cu4oQ4uiGo0Po7evDtcX852QTgNbz2zagBbHKPH9nxnqATkhXB
         lYRcpLmyXIc/FJHKOhMMAkOfshp9bK6+Li54i4/64G9nhmIcpfdooz0GrA/wI+hYCVZC
         gFEDMS9fM+dCBtQ71GyPBgAABcA6JU3OJ96X+vePiTbJrb/vVoiMV7WOUauzWMaSGvH8
         YLqPFt0y5VrEu5SvlABI4zP77lxlks4tXZil5VbXnDfZctpz0Gvab56Cv4oPQ6Fk/2LJ
         Q/Djdmg8wghHmUYVx3cY+Z7VDEdxQEVgcXRM2Dz21uZiz8GM43J02f2DzNj3nBrAHiM5
         k3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752697176; x=1753301976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h7ot+7Tc9QR3gV2axXkjDkCS1MRhJ97jbw7cnQjMbAI=;
        b=wc4QToNhAcxh8FN9loWDTbMXF730mJ5MnILQ1zRaCqWtN6y7XH+R4Nj5Tc4yYXnEsg
         /Ug5JXt6QXWLIqWH68eFavbPSIqe6lHoDAy9l5l3D7RLepGHBjP2lwezCeP2cyjPGm6S
         o0FJSeEq4BGDvkJnCC6XNevQTvWsMgSPGbGaSRM37aTDe1XInPCjZI7tYWYmrOnF9H/p
         WO1d2ZEr8pbl7HqL1MeTDRdrhYYgecwz2NWj8KcBV+kU81Tq0MTdIQd2oM7LKquE4mqN
         DYidgYaIR2mpBg3di+uQGli4TxOMgIiJmlNP+5daev8HobF1oSJ+WiMXo6QXUGW7W/hs
         WtnQ==
X-Gm-Message-State: AOJu0Yw3mTKE1TJTqzEWPjKDi2Y/hHjEfwdgrIUaHnsi1uDUbIL9owYr
	d/78BIxiyfIcvYB0UkzbM+Ud2UeSI7R6eZ8sxiJLahYp5QIhYkRZVppFiXdBLLxSg3+MdR8jdCJ
	WB6hx8SM2dw==
X-Gm-Gg: ASbGncsmx7ZiBZQZBRup6UbTB0mhfsUwOEkSRkWZ1gj16v27ap3fN00te5gr7/ojZis
	YqwDuZKHbVH+we9K/Jd8M0pgU51Bp4D4QHNq1tbd071Dt51d1IWGiBQ4Xj32xCie2mMEopl9OO8
	hLlMaRM4KndwlANys57DepShe+QkyGCk9on2kTsgN1+EGrWcfc0LCZXA47mUWKlq2LjGP9isuYk
	B9sc5pI1TRy4u+EMKbnvp3MV2r/9tJeqnzHV7Hp1nLThc8zC/wtvxYJjFD9sl297/wVEfsAvk5W
	pz3keYT9WwfW/QYTkwBlbB3Ia7OkjqMf/3eZkYz5Jy7WMx4QREBRl0dYXLazpDbiMv6qUcorInX
	OZLeZNnizJdXIFtKUe71n6LEct/My6tJ0LJN8carfdcuHsybP
X-Google-Smtp-Source: AGHT+IEvvUQbfoz2T691ApVRZoAeqkAdd5Ka6iqYVzNsYjD22qiWKKzBTKomD1VqiIt0iNMgMtngjg==
X-Received: by 2002:a05:6000:2087:b0:3a5:1241:afde with SMTP id ffacd0b85a97d-3b613ab2ca0mr561977f8f.9.1752697176127;
        Wed, 16 Jul 2025 13:19:36 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:a864:eb02:add4:d64a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e1e3bdsm18557826f8f.81.2025.07.16.13.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 13:19:35 -0700 (PDT)
From: Antonio Quartulli <antonio@mandelbit.com>
To: linux-wireless@vger.kernel.org
Cc: Antonio Quartulli <antonio@mandelbit.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH] wifi: iwlwifi: fix cmd length when sending WOWLAN_TSC_RSC_PARAM
Date: Wed, 16 Jul 2025 22:19:11 +0200
Message-ID: <20250716201911.700-1-antonio@mandelbit.com>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In iwl_mvm_wowlan_config_rsc_tsc() when calling iwl_mvm_send_cmd_pdu()
we are accidentally passing the size of a pointer rather than the size
of the object pointed by it.

Fix the expression in order to pass the approriate object length.

Fixes: 631ee5120285 ("iwlwifi: mvm: d3: refactor TSC/RSC configuration")
Address-Coverity-ID: 1647627 ("Incorrect expression  (SIZEOF_MISMATCH)")
Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index ef9bab042902..b8754d7e51c5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -494,7 +494,7 @@ static int iwl_mvm_wowlan_config_rsc_tsc(struct iwl_mvm *mvm,
 		if (data.have_rsc_tsc)
 			ret = iwl_mvm_send_cmd_pdu(mvm, WOWLAN_TSC_RSC_PARAM,
 						   CMD_ASYNC,
-						   sizeof(data.rsc_tsc),
+						   sizeof(*data.rsc_tsc),
 						   data.rsc_tsc);
 		else
 			ret = 0;
-- 
2.49.1


