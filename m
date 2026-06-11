Return-Path: <linux-wireless+bounces-37660-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cKiUAG11KmqTpgMAu9opvQ
	(envelope-from <linux-wireless+bounces-37660-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 10:44:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 910B266FF9F
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 10:44:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=HLn01jRK;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37660-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37660-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0C1673003821
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 08:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D368D38F258;
	Thu, 11 Jun 2026 08:44:26 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D964351C06
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jun 2026 08:44:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781167466; cv=none; b=F8TL3v0Tj9Zp6kwJysorN8StDJcB2mByAjH8TqyDd1YHVN4/Zah29u/WAhY2kXmdrf54h/JVHM0ujILDsfzgPe9IvfpmjrokVb9nnqJJo23DhdW858qRkH+1yPqffyNdf6/R0or4p0Aus01Fv38RVZFWGV0Um7pgGWCCL3oOEhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781167466; c=relaxed/simple;
	bh=h/UsCBSxuu4j10jZt10F3GMVvVXLjsnDmwFr+0PA33Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DtIKphR97dKIRx//WxxlTlbP0RBXwdy8LPHCMYmhM2ehxjmnWS/eT6hg+C1q6y+0WSPVuG8GYVWYGmTykSLamKDcOuBZvnOB8u2wvyzo3fVbVwpWqwmKhGtI2ree78aBu4SN3HM17ju1tSZwHrN9wn8AWAJGdqUiPt2iX/wDbp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HLn01jRK; arc=none smtp.client-ip=209.85.221.54
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-45f3cf907ceso4012093f8f.2
        for <linux-wireless@vger.kernel.org>; Thu, 11 Jun 2026 01:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781167464; x=1781772264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KfjdmvbLZ2ajcdt58jAGget3u2obgXtGYDr0JfRuXz8=;
        b=HLn01jRKCKH6xdot5BkvWxFh1aQWtw+WeFSRHy7NbwtU4XJri5rcHZKRAYTQ+Fg5LM
         G6/zlo643V1CF6/vplyQZBE5DfKp4guxap3y9kieSpeUzxPyN3VQBilZSPJrrufKTvZo
         SGt5uKPmWt9uDZt8rghUh5Ex//PsdexJewbyktmXaXV6Opszh7ItiT/P0FoOarue+QoA
         F2iK2QGaqcdoh6mPEaPL0mlccXRxjCqqnU2aoabvyAjDKP418WK0su7XjBOwrADQEApo
         74Yxp9dl04JwOkPdiC5X0W8Xe5rSEstKVydqn+Wc3/64vuOfpyUB3/gzf2RNtAxrxR6R
         iiUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781167464; x=1781772264;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KfjdmvbLZ2ajcdt58jAGget3u2obgXtGYDr0JfRuXz8=;
        b=kdo107UXLriAf8BPdVQE99/x0DcgY6xLe9HTfgEOTbZ24VhdlWd2HMIi9mCd1sgxsi
         A/X3CfV/1Z0O0Ubc5nZCHluKe4bEoKmDlOVVKZPbXz5frkE1wqF90hY5BNdaQi2GUjYV
         sXLwQGUKtTjhEUIyMEv1KB7uKGDFpt2L3FT7OyTmeQCjD3ciqEkINGk446mT269ltQcX
         v2ccer9TiOWvJlwQuKIM7AXkoZSHOc9QULx6aQUa7VmwVFdZyrypYK34DWe2v1GDEraR
         Qr3K6pBCrwOA9CpTufkaj4ddfVEdWOMTj9PklIV4grVvmGkRzlDq6Fm/rycqfL1xN/0s
         FSSA==
X-Gm-Message-State: AOJu0YzDBiObql2CKiMGCp+iyt2oq41tAuEQSmugeJZMEDdFNZKUbjXX
	iu820+kpyPUrng5nxFkWAqymJTngF6iMAa7iqVfj08G2cJ9SzDnBBvTGnpPRfA==
X-Gm-Gg: Acq92OFq6phiADXU90DdjoSBTx8pGxqG86bv0zbj40JM1mRC8+oq8d8QghR5mRUrUPo
	Xx5PFk5fnOpUKgp/uvjma8ZCS6asUs68CjZVzDNk2ry9MwYF+TlsXq2buS/3UojTLXTCTxIIPdl
	e81b8Cd8DWslzT7XX5/9o7qf5nJsYXL6Z0vwij2/orSd880IsOWj1XC1XBEw7fatCABBgNaSeXn
	ASKQLh/ki69rRvBCMgwz13WkLKkSE+MyCTnu6oarxumnL1s1s/E2bmjkyFoKI0Y5PDILwwGU9ib
	k4fFAWrnyRKA0KNcpsdppSEP/MujPVVMlH7Pd/4DyPB7Yag6Bd2BM7SPr98xA7jfLzCsJsI1oGz
	tswcHho9KpC7ZKGThMdQf9tAZzzI5NNVam+EXgKyp3V3hCHkzwX0AIn4w2gjmVeN9isgea77eZc
	vBnswqZxBl3Isy6FAQpmrEo98tOirv01kTeQ26qcgk4NkE9ctnGU0oqJCa5f4ycCy1tVM=
X-Received: by 2002:a05:600c:5250:b0:490:c2a2:b1d4 with SMTP id 5b1f17b1804b1-490e5620658mr18944445e9.35.1781167463459;
        Thu, 11 Jun 2026 01:44:23 -0700 (PDT)
Received: from syracuse.iliad.local (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcde3sm81024394f8f.1.2026.06.11.01.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 01:44:23 -0700 (PDT)
From: Nicolas Escande <nico.escande@gmail.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH ath-next v2] wifi: ath12k: avoid setting 320MHZ support on non 6GHz band
Date: Thu, 11 Jun 2026 10:44:22 +0200
Message-ID: <20260611084422.1511513-1-nico.escande@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS(0.00)[m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-37660-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER(0.00)[nicoescande@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicoescande@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 910B266FF9F

On a split phy qcn9274 (2.4GHz + 5GHz low), "iw phy" reports 320MHz
realated features on the 5GHz band while it should not:

    Wiphy phy1
    [...]
        Band 2:
    [...]
            EHT Iftypes: managed
    [...]
                EHT PHY Capabilities: (0xe2ffdbe018778000):
                    320MHz in 6GHz Supported
    [...]
                    Beamformee SS (320MHz): 7
    [...]
                    Number Of Sounding Dimensions (320MHz): 3
    [...]
                EHT MCS/NSS: (0x22222222222222222200000000):

This is also reflected in the beacons sent by a mesh interface started on
that band. They erroneously advertise 320MHZ support too.

This should not happen as the spec at section 9.4.2.323.3 says we should
not set the 320MHz related fields when not operating on a 6GHz band.
For example it says about Bit 0 "Support For 320 MHz In 6 GHz"

  "Reserved if the EHT Capabilities element is indicating capabilities for
   the 2.4 GHz or 5 GHz bands."

Fix this by clearing the related bits when converting from WMI eht phy
capabilities to mac80211 phy capabilities, for bands other than 6GHz.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00218-QCAHKSWPL_SILICONZ-1

Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
---
Changes from v1:
  - rebased on ath-next
  - clear all 6GHz / 320MHz related phy capabilities fields from the firmware
---
 drivers/net/wireless/ath/ath12k/wmi.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 84a31b953db8..a8a4654c4f34 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -5154,6 +5154,7 @@ static void ath12k_wmi_eht_caps_parse(struct ath12k_pdev *pdev, u32 band,
 				       __le32 cap_info_internal)
 {
 	struct ath12k_band_cap *cap_band = &pdev->cap.band[band];
+	u8 *phy_cap = (u8 *)&cap_band->eht_cap_phy_info[0];
 	u32 support_320mhz;
 	u8 i;
 
@@ -5167,8 +5168,22 @@ static void ath12k_wmi_eht_caps_parse(struct ath12k_pdev *pdev, u32 band,
 	for (i = 0; i < WMI_MAX_EHTCAP_PHY_SIZE; i++)
 		cap_band->eht_cap_phy_info[i] = le32_to_cpu(cap_phy_info[i]);
 
-	if (band == NL80211_BAND_6GHZ)
+	if (band == NL80211_BAND_6GHZ) {	
 		cap_band->eht_cap_phy_info[0] |= support_320mhz;
+	} else {
+		/*
+		 * It seems the firmware can report capabilities specific to
+		 * 6GHz also for 5GHz, so lets explicitely clear them out.
+		 */
+		phy_cap[0] &= ~IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ;
+		phy_cap[1] &= ~IEEE80211_EHT_PHY_CAP1_BEAMFORMEE_SS_320MHZ_MASK;
+		phy_cap[2] &= ~IEEE80211_EHT_PHY_CAP2_SOUNDING_DIM_320MHZ_MASK;
+		phy_cap[3] &= ~IEEE80211_EHT_PHY_CAP3_SOUNDING_DIM_320MHZ_MASK;
+		phy_cap[6] &= ~IEEE80211_EHT_PHY_CAP6_MCS15_SUPP_320MHZ;
+		phy_cap[6] &= ~IEEE80211_EHT_PHY_CAP6_EHT_DUP_6GHZ_SUPP;
+		phy_cap[7] &= ~IEEE80211_EHT_PHY_CAP7_NON_OFDMA_UL_MU_MIMO_320MHZ;
+		phy_cap[7] &= ~IEEE80211_EHT_PHY_CAP7_MU_BEAMFORMER_320MHZ;	;
+	}
 
 	cap_band->eht_mcs_20_only = le32_to_cpu(supp_mcs[0]);
 	cap_band->eht_mcs_80 = le32_to_cpu(supp_mcs[1]);
-- 
2.54.0


