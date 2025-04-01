Return-Path: <linux-wireless+bounces-21016-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D38A772EF
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Apr 2025 05:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26E663A948D
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Apr 2025 03:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9EAA6A33B;
	Tue,  1 Apr 2025 03:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hf1HA0NS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A383B673;
	Tue,  1 Apr 2025 03:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743477719; cv=none; b=Tyn56S114ZHqy8Xvo9qr0CCM62j9LyaW4/Gdtq11Be3zWFwtrAgiYZuOzZ+K1cb0Th3pElRiuTHoqvPwUlxSQznuJ+EP044GhO2T3mq0KnKWVqJV5ZUBTe65CTAMdW3Bt7h8FTOrqIy9Dv7D9vTYl+N08VpGgktXdFxPD+dbEjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743477719; c=relaxed/simple;
	bh=+gwKMPJps5DpIekGmbPk0xDMYavisjDBStAFLyDSkFs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O9E+i+XGN5onwrFVQS/+Wm0yokwvfWR+4FxSbcV7iCcOyAOp3/IqtK+CWA48UxwSMelwru8N73YEXVlDQ7J5ngkv6r9l0tEKjh4Koki3cYRlEZ7veKRd+ysyNQWzveqn6yvkBR0lxm15XeAzmZCUPW8u5ZCsA/E+cjvXMrCMOdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hf1HA0NS; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-224341bbc1dso86468465ad.3;
        Mon, 31 Mar 2025 20:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743477717; x=1744082517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=rBNDRxJpdNfAaoBULUFIoplDqDZ0d3rCl6nASZbW4Hc=;
        b=Hf1HA0NS7bpGEUqdK+QQh5FvxLTEAwBQP9LPaANXf78kWC9PXSZgrwSLjEXe5DcV71
         wyVnGnsMMpgd7PuWMvezzbGlgWOnvxsiL7Hl9EtwoNlW6YAKh4h7tqKqX5rtzUO2EumH
         Nb8Z9W812c8d48DtU2F1FUUSB6HchOhqpytvl24RwODwL3B2HVYtUV3VDqAVz61wow3F
         kldKRq4YZVxoWMn63B/S2mGxc0Jjm7rCcLV/XHT5FsXNuMEVlkPVBDFZr3kRDsZp/uFJ
         VzguZ1G5umCMg7j3Q642+AhU8NQ7fJi+13GmcpGdpxZ4ZVqS+j1KrGvbRlqFRIymXN/b
         ZOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743477717; x=1744082517;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rBNDRxJpdNfAaoBULUFIoplDqDZ0d3rCl6nASZbW4Hc=;
        b=Id/zJbNatmrdyGPRZI0rsU4Mereld7s03rLZwPSvQ0k/1ltdSTpc2m4/qqja32iSF8
         i2ZDoQwInPRIn/XDZJoAOZrAA2Qcq8HqjQHDbNKc7GRvCpgXlFMqlTDxIhuGX2hS2ZAM
         jVxduso+2zekUuOFxzb2oDwrOqUZKWiOADlxK7sgvLzWnrpJ8a0cuCGRNzR9uzmRSiS4
         p74kpCpf8tlGNYzW1NgSTuXP2p96xiJnkgDU/tm6OUgsoU8hRPHBJbdOE0NJDx9WYjhg
         XzmV9JMXny/o42vcoHHUyTL0Xj1fbJfxyZ59HJ/bvwmwU8aHHoJYH4Gsp4Ao2XkKSPCk
         0uow==
X-Forwarded-Encrypted: i=1; AJvYcCVghkLx1EGCBpjIeb8SgiTv/fM+5UUYier+x6fg0e7fAdT2u1llXkroexopX2ixRXSgcABevVPBsd9gpPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YymXuyLIxAZ+AE4c8Z46lgTJhchOuwSoNcYzVzHaLHDB79iBPKh
	L+9aLiyTTh6qvJrkvfFlLh2g4AnDRQd3gcB7K3ALatnHygMAFlrK
X-Gm-Gg: ASbGncspi3rYoqTXRaiOQ/cw11Ca9a9zqyLNd13NOxvFaWxB43b3TX88/XC+2NWUCDD
	Gb3lP3JyBJ/esg+WFsDQ2zQxZoAxXeUmh5oUM95ZoH+YJVtDXQwKP+faZ94U3UfYPJ5VkC9QA3s
	MRfQx3FkZNR487IwOBg8XL1iUkrTkCkv4LFFyxOxCHWhzqbfkEweapcJIkYd4G1DPRrH04xDkFH
	W2Bhq7P9JGs06OyPU9fqJd4bM1AF2wEcMwOoqd36sFASuZ0qVaoq3wwn3Q20hwMdjUI3jtEsqIs
	UX7+GKY11Fm4OPlO/PKxn1w/ARRuBWQKCigjq6eMK8VwGvky+98lWPYEww==
X-Google-Smtp-Source: AGHT+IHqryERmUniKJ6IdPCSTNAV/fFTqs4RC2vnzjOBEfzVozkSrV/z7rsplwxpNIvAgd/VAgfCrQ==
X-Received: by 2002:a05:6a00:1a89:b0:739:4a93:a5df with SMTP id d2e1a72fcca58-739803ac1f9mr19141112b3a.12.1743477716585;
        Mon, 31 Mar 2025 20:21:56 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7397106b01asm8027166b3a.102.2025.03.31.20.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 20:21:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Johannes Berg <johannes.berg@intel.com>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] wifi: iwlwifi: mld: Fix build with CONFIG_PM disabled
Date: Mon, 31 Mar 2025 20:21:53 -0700
Message-ID: <20250401032153.2896424-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If CONFIG_PM is disabled, the CONFIG_PM symbol is not defined.
This results in

drivers/net/wireless/intel/iwlwifi/mld/iface.h:169:5: error:
	"CONFIG_PM_SLEEP" is not defined, evaluates to 0

because the conditional uses #if instead of #ifdef. Using #ifdef
fixes the problem.

Fixes: d1e879ec600f9 ("wifi: iwlwifi: add iwlmld sub-driver")
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Maybe this has already been addressed. If so, sorry, I did not find it.
I did not see thos fixed in Arnd's patch addressing the other PM_SLEEP
related issues in the driver.

 drivers/net/wireless/intel/iwlwifi/mld/iface.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/iface.h b/drivers/net/wireless/intel/iwlwifi/mld/iface.h
index d1d56b081bf6..ec14d0736cee 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/iface.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/iface.h
@@ -166,7 +166,7 @@ struct iwl_mld_vif {
 
 	struct iwl_mld_emlsr emlsr;
 
-#if CONFIG_PM_SLEEP
+#ifdef CONFIG_PM_SLEEP
 	struct iwl_mld_wowlan_data wowlan_data;
 #endif
 #ifdef CONFIG_IWLWIFI_DEBUGFS
-- 
2.45.2


