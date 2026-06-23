Return-Path: <linux-wireless+bounces-38018-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xa36NUOjOmpsCQgAu9opvQ
	(envelope-from <linux-wireless+bounces-38018-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 17:16:19 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6BE6B83D9
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 17:16:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=S77c8yFO;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38018-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38018-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 024E0300B1FC
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 15:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB9F3D6491;
	Tue, 23 Jun 2026 15:16:17 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830B137EFFF
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2026 15:16:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782227777; cv=none; b=IYpHr4cRWzVFiQNJ541r2g5+SlHB3MDxaO0zzEELaj/RcX4NIHzAYadS0VY5ahly/9N5KNvjX69vjxkn82TNLwvdX894dL5PV8ptChMUVUsqa+c5prJBhtgBzaQUV+b+rxobPfKH4WNcCJVUT3zlBMvrHMu3D58eXnYmDNHasO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782227777; c=relaxed/simple;
	bh=2XJvqAU9oYahTcC+SXLZXYvCIJQM8cGyszkv/qsM+vg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q6XGdR8Go5XmONUyuFZ/I9i0tWB45YIqqtjDjthNwaziarE5KbQJs3RvIEIoIVnFtSLi0WYWEeXPQEXLchKi9S/HhOEZKivvuDM5mBLM4LXBDv1nWRnp83WfNEwMj+VtGpwJMh3oCsg/j7ve60Af4iwwbnviohTHOV51R+weNlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S77c8yFO; arc=none smtp.client-ip=209.85.128.46
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49249707788so25503505e9.2
        for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2026 08:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782227775; x=1782832575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AT1h44Zm9oh1x5aEKYj5yka+DdDxBM20kc8wgw2F+yA=;
        b=S77c8yFOSm7zjb0QdXwq4S1tcDv6c/Sed4hb75GIqePA3hFjtZTRjMZNDtYeLbiUl7
         7JKK+1pKJiAey5juXKzcYgnSwNZI0eoeydQiQ//WKJ9YBJ+dNbNoodWVcH4RqpFcfkNf
         fgp6nnczZAuVtU2lk79peraYgkSSOHaksF/4Bz5iBVY/EQyfTkwQZFn0ySYpqu7v/T2e
         Im6pb1W+vZAuFugiTBQyN5Wol02XdrIVvpN1nCWiCCNBlf0iAYJ8HpwTAQEtozPRpGax
         SuVo16E1+nmRuTZlHHmmSWeh0qYGGvMOTmR6Mzi5kUc8ZhjsGJtODmp/qtzFRwUKewJN
         ZWSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782227775; x=1782832575;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AT1h44Zm9oh1x5aEKYj5yka+DdDxBM20kc8wgw2F+yA=;
        b=bLS517oFxpQc0K7NRjjem6PRUWWEUaihkqJ2Tv6dmo8sl+KkzV5qsNOA+POQyGj4Kq
         BhRXASrwIPHVMANsShUs2neFJdVpzP4uOvE7eDq6b6oh2WwTpTYRzZ9a0/YZTPGGflXx
         KR16+ioZLRS45Urel3oesG8AEPHpS3Nm5bxTiB62yk1Q/qku7E4a1rvSsG5wUOj68nAN
         8wSix7ZaVUsBfp5zwzgnaG/VcyubUKI7StgmPw6zg7dp1cuDAcIlc6wSFu6Pnd+N8A4z
         rvZFuqR/RVWv4IY4cb+fCzlmJGV5dHJBPNa7AKDSng0gI9ReRotQezoK33MvLwqdtE+m
         699Q==
X-Gm-Message-State: AOJu0YyZRe9guDEroM7yuMDRNoAhWiT1cDz2R0UKkZesDcMsO9UezrpU
	D4HFapgUPYaG8GEFtPNwdTMhaNksU1VB/h+0oM0m4FcrvPykddaB/WGKM/PYJA==
X-Gm-Gg: AfdE7cnX/WBfOsCDiIBq3QojFdWg7k/mmdU7NEFBwmoshJys30xLKqkiBvS3Bqjkw5J
	ldxM9jjulmboMJuyfCGx4Hs0HjAA+9ye7nwOZ/i9Tygy20FJEAbxicIB+eUorlWrZmnEUEVX1kh
	mIXkU/Y8iWBYx/KiAvmLEtLPfqLs7zWQvU87MUoJ9hbJSHnAZjT/unY2CYuzqiku5KARqagmzec
	BRYJG25cMoJVJNB3P3AWeMG8pv4oHYOB3Kg2P51hOdM+DViyrYHxF5zGWiToI1izxXq0T61+f1j
	p82S3vCiIqFGxLMQT9LnxhJFfRmrzOKd1gxRPspzAbXol2TG3IlfPx2EW4/Z2NziIAmt+gYxCE5
	Om77D06tFy+pFhPOWlmaZJerCN6SdFrx5Thq+079J1vVSsLRNiTn2Bjyj6smK4TgOUDdxnUpddp
	R8ogXSNdFnaLgFxnZl63ZBixOh0eiBgv1R89Fh32Ep90XiLQ==
X-Received: by 2002:a05:600c:3e8f:b0:490:e5c1:b8b9 with SMTP id 5b1f17b1804b1-49249046b94mr230072095e9.0.1782227774587;
        Tue, 23 Jun 2026 08:16:14 -0700 (PDT)
Received: from syracuse.iliad.local (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492494497ffsm312950005e9.11.2026.06.23.08.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 08:16:14 -0700 (PDT)
From: Nicolas Escande <nico.escande@gmail.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH ath-next v3] wifi: ath12k: avoid setting 320MHz support on non 6GHz band
Date: Tue, 23 Jun 2026 17:16:13 +0200
Message-ID: <20260623151613.72113-1-nico.escande@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS(0.00)[m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38018-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 8B6BE6B83D9

On a split phy qcn9274 (2.4GHz + 5GHz low), "iw phy" reports 320MHz
related features on the 5GHz band while it should not:

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
that band. They erroneously advertise 320MHz support too.

This should not happen as IEEE Std 802.11-2024, subclause 9.4.2.323.3 says
we should not set the 320MHz related fields when not operating on a 6GHz
band. For example it says about Bit 0 "Support For 320 MHz In 6 GHz"

  "Reserved if the EHT Capabilities element is indicating capabilities for
   the 2.4 GHz or 5 GHz bands."

Fix this by clearing the related bits when converting from WMI eht phy
capabilities to mac80211 phy capabilities, for bands other than 6GHz.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00218-QCAHKSWPL_SILICONZ-1

Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
---
Changes from v2:
  - rebased on ath-next
  - fixed all typos
  - changed wording in commit message & code comment
  - also clear all other 6GHz related phy capabs

Changes from v1:
  - rebased on ath-next
  - clear all 6GHz / 320MHz related phy capabilities fields from the firmware
---
 drivers/net/wireless/ath/ath12k/wmi.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 84a31b953db8..e7689ee3e701 100644
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
+		 * Firmware may report 6 GHz/320 MHz specific capabilities for
+		 * non-6 GHz bands, so explicitly clear them.
+		 */
+		phy_cap[0] &= ~IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ;
+		phy_cap[1] &= ~IEEE80211_EHT_PHY_CAP1_BEAMFORMEE_SS_320MHZ_MASK;
+		phy_cap[2] &= ~IEEE80211_EHT_PHY_CAP2_SOUNDING_DIM_320MHZ_MASK;
+		phy_cap[3] &= ~IEEE80211_EHT_PHY_CAP3_SOUNDING_DIM_320MHZ_MASK;
+		phy_cap[6] &= ~IEEE80211_EHT_PHY_CAP6_MCS15_SUPP_320MHZ;
+		phy_cap[6] &= ~IEEE80211_EHT_PHY_CAP6_EHT_DUP_6GHZ_SUPP;
+		phy_cap[7] &= ~IEEE80211_EHT_PHY_CAP7_NON_OFDMA_UL_MU_MIMO_320MHZ;
+		phy_cap[7] &= ~IEEE80211_EHT_PHY_CAP7_MU_BEAMFORMER_320MHZ;
+	}
 
 	cap_band->eht_mcs_20_only = le32_to_cpu(supp_mcs[0]);
 	cap_band->eht_mcs_80 = le32_to_cpu(supp_mcs[1]);
-- 
2.54.0


