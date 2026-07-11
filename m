Return-Path: <linux-wireless+bounces-38873-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vuUUNQ5cUmoAOwMAu9opvQ
	(envelope-from <linux-wireless+bounces-38873-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jul 2026 17:06:54 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51699741DF0
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jul 2026 17:06:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=fCoUiTr8;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38873-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38873-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4CC1A302DE03
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jul 2026 15:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCEE3612F4;
	Sat, 11 Jul 2026 15:06:17 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824D82DEA7B
	for <linux-wireless@vger.kernel.org>; Sat, 11 Jul 2026 15:06:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783782377; cv=none; b=m/jFUC35c8y3teSmhSDvY5skVpX8tOtA14377oeePgreEMgarR+6e5D4T7RQbCrbTo+mz0bzz4tjpQGvB8PmzzDI+/3zaL59NfUjBieW3Q2XfuDpXcPNtumTjBQvUAO84yZECuCMr2dvUizVwIQqFniaKrFrwzQyzdiA9vav4Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783782377; c=relaxed/simple;
	bh=8UpyJxckMHUMLlbtyRgGGg26hezMZtk8A8xmtE1pZOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pGaMLZAc+8F17zRRtThqINLrMn81036P4Ewtir2pF6AjyAoHIzvRs3ROop5MGzQHAv/oHOXnvojdJuWB4qvTORrcz87T4rz7E+yjNp+7tpEcTsJRYZB7d1mufwYfrc5tr0TZPY9Z1th/aRYNEsRVZD33zs7gx9YmB+MSWjUnVIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCoUiTr8; arc=none smtp.client-ip=209.85.222.175
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-92e67555e24so95074985a.3
        for <linux-wireless@vger.kernel.org>; Sat, 11 Jul 2026 08:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783782374; x=1784387174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qPPgg5HFLluz6FRieBbyWJGx0FqM2rMhvYorHbuk6xc=;
        b=fCoUiTr86kQgSOzvsiKKYan57Tzz96PAu1bQQFWsiLD42jy+sf5z5Q3L2+J0aeiwdn
         spHXZekJZSooLr+afeoljgnaca6KOzJErLXDNK7YtgLE3ncbupR3DZ8bbroJkBypCdXZ
         0oLIP3r9DOQeG5iFU//9EzXaLMGu7HFWkZnUbgNLz4/IexjiW02dCmnnU2uetLZYLgr9
         pvg4SsibPrwnEN2nVdJLm6NA8TOW7zF21ZTiTcPpZJY20UZjvbzD9UPLZpXVPg4MLTWY
         CpWAvIbC7ePdk/a/7qfcpiRLro7sdW4bit3PAIiFdERbH4ZbpmFN5KSxrt0uCoiRWdUT
         /y7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783782374; x=1784387174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qPPgg5HFLluz6FRieBbyWJGx0FqM2rMhvYorHbuk6xc=;
        b=S0k21lmyIRJPbp5PA3TEaWS45IsCnyn3TutNb0KOfUxcnLbYJQVWhVw8ApuBiJHAQf
         tYAhtAyQSuoXn4/vE3iw6P4au293K3fIt7lNZDO+cq/7E2Dzc8gHVttcdM76rOzujrTu
         JBls/n71K7X5+w+0vuquDIS1vOFDAgyDRbxY0X6XQicyM8Hqf3R1NH/5jEBx20k1tRQR
         s7DrfNNBH173LtofI9ZkZP4g3rtTI+VL8d7sAS85ps8QZoscOiVVb5wuhgmFihLv3lBh
         1HXBc0F4U29hThJ8PCqGut+PC23c3/8eBcY791MLXbNx2kP4Sro6b0OZ6xAHfbV8xdvj
         99qg==
X-Forwarded-Encrypted: i=1; AHgh+RpdeV9qBY8LeJUEfnGhC8B/syPi+JC2Up4gEYS3WnAfPBnE6liJGtZjEdnJVz09lKlcEcU86m5/K/2r1Lsc9g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxogVkNxolBUF2VkwQHLIqb85nbZc3fnQKJz/Q87Dfvbt7S658h
	lvr9y6DTobTFpmmfwF3mzFjoJdqs1/RJIE2JRSlf+ES0VOXRkLeXPEWz
X-Gm-Gg: AfdE7cmfVLpEf5kBRS0vMVSejsa6aJlfoFkDlsIrBZHbWUW2Bp3DqXoT1ZGe9FMF+7k
	lH6RIMzlsX/AUm7svr/FYTQ08YVeywI5EswBBIIq/0ktxXnHF1HPIVhoWu4MWyq6mknt+4Fzzji
	pANHxBz3nPAr++IMNz8bDoKVH5jNT1D63AeSox/7Xn2EC8IxtiYtyLZNJQHom4t4GIKit4p08/j
	4M46sCbRqoFad8N9t0gU/LCUnj7G+VgBtuh4siv7w6LVtn0yM7I0LxukGDDyAlvo6E3J4XGRAPw
	fF1P+xpToAddrkuLej7X9vzZHFdpOB+sSRreFHCLTxM2r0MLnmG+hXH0Bnp1I1WR8O/l9zPzdk+
	KIdv/CwUlQPvKeJBHcxZkb+qv0e0NoONWW985u/kGLQFP+F7amTAkHcWCULL/2q2sUugiTkXORA
	Brq3VRv3Ja2/uPpF9sEVyzoITEo1k2iAUffZid9atjlZKQ306Ugf3Pj0MSwOzGvxf5iq+oirT62
	pY9boTrYA==
X-Received: by 2002:a05:620a:298b:b0:92e:72a4:f282 with SMTP id af79cd13be357-92ef2c1fc21mr314510985a.46.1783782374433;
        Sat, 11 Jul 2026 08:06:14 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5d68e5fsm464578285a.43.2026.07.11.08.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 08:06:13 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] wifi: iwlwifi: mvm: check BA-window station ID before lookup
Date: Sat, 11 Jul 2026 11:06:10 -0400
Message-ID: <20260711150611.2913332-2-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260711150611.2913332-1-michael.bommarito@gmail.com>
References: <20260711150611.2913332-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38873-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:miriam.rachel.korenblit@intel.com,m:johannes.berg@intel.com,m:emmanuel.grumbach@intel.com,m:benjamin.berg@intel.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[michaelbommarito@gmail.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 51699741DF0

iwl_mvm_window_status_notif() extracts a station ID from the BA-window
status notification's ra_tid field. The firmware API allocates five bits
for that field, so it can encode values up to 31.

The station map is bounded by the firmware's station capacity and
physically sized to IWL_STATION_COUNT_MAX entries. Validate the extracted
station ID before indexing fw_id_to_mac_id[]. This matches the existing
MVM station lookup helpers, which reject IDs outside
mvm->fw->ucode_capa.num_stations before reading the station map.

Fixes: 3af512d6aac7 ("iwlwifi: mvm: support filtered frames notification")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
index 269c4b45de807..d373f0723e13d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
@@ -7,6 +7,7 @@
 #include <linux/unaligned.h>
 #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
+#include "iwl-drv.h"
 #include "iwl-trans.h"
 #include "mvm.h"
 #include "fw-api.h"
@@ -1227,6 +1228,8 @@ void iwl_mvm_window_status_notif(struct iwl_mvm *mvm,
 		/* get the station */
 		sta_id = (ratid & BA_WINDOW_STATUS_STA_ID_MSK)
 			 >> BA_WINDOW_STATUS_STA_ID_POS;
+		if (sta_id >= mvm->fw->ucode_capa.num_stations)
+			continue;
 		sta = rcu_dereference(mvm->fw_id_to_mac_id[sta_id]);
 		if (IS_ERR_OR_NULL(sta))
 			continue;
@@ -1239,3 +1242,4 @@ void iwl_mvm_window_status_notif(struct iwl_mvm *mvm,
 	}
 	rcu_read_unlock();
 }
+EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_mvm_window_status_notif);
-- 
2.53.0


