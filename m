Return-Path: <linux-wireless+bounces-39131-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YO58NmguV2pQHAEAu9opvQ
	(envelope-from <linux-wireless+bounces-39131-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 08:53:28 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0F575B413
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 08:53:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=irDgPZr2;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39131-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39131-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6AEA1302A066
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 06:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6C43242CA;
	Wed, 15 Jul 2026 06:52:59 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D59323416
	for <linux-wireless@vger.kernel.org>; Wed, 15 Jul 2026 06:52:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784098379; cv=none; b=m4fNKGknotuDHblpflTob2ksoMJ6gGsOwX8ndCdsKHoAPKCur390T3Vn6OAl9KF1PtC3+GaGUaXmIV8zuUaLr0NcTKxAYDormfQxbFWUO1W61jyzGT49QKFJFjUIjE6hkK7d67sUGqW/MVNcSJ+Hf1d5KZJw7nm3iXGuows2BX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784098379; c=relaxed/simple;
	bh=SxwN5EAMtz4EX8ED/S0k3wDKKuiZW1T0Fi7nPAms64A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VrcaQNW92WpVb6xfNtf3BHiGYVsJ4ncyYxOTmg/2Xona6D3MoYi4YOAgvf7dKH2h4873JABtr44vBUG6vlftwldr8Mp9gt9IxaKudRRqb/Aitc4Ru/+jXL/O1RiFd+BKeauKT/BkhK1Rqhz5TzsKOxBSDB+vRP2H0/JJixnxqWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=irDgPZr2; arc=none smtp.client-ip=74.125.227.132
Received: by mail-pj2-f4.google.com with SMTP id d9443c01a7336-2cc6207127aso25480695ad.1
        for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 23:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784098378; x=1784703178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wMdRzItSC5FsbcQti/ZgrTQLV3qM2lI+vSFATQHLH68=;
        b=irDgPZr2M4TRVNz/sge39ijTx8+JRm+huR7nsrAKJg/AlQCKmlDARhyBmxWNZ0rldp
         fVJRh7p0Gcn+jzAQ9fUkomx0V7aw8VUyjW+lMzJJPEH5yMuq6Seu90wvj/HG+hfGfVPx
         kSmjlAxEc8nLmLH8LopFliYjbjFJy3gMrNtTNc9teWBX9eiGoSZcZu5tlNNwD6h6lsw5
         3yzQUkj++7WDMca8OjWtFqfRJ2RYPy1i1aHrmActqcTV2SoNkjs6+6cMhboRkMkkMr4l
         u+zG1CYXbCrYIdREfR7pSZ1RJYEKQasFWyKcVH4/WvN6S8SkCxotimjHhz7dC4zaQB8t
         x3jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784098378; x=1784703178;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wMdRzItSC5FsbcQti/ZgrTQLV3qM2lI+vSFATQHLH68=;
        b=GVGqpG7cqGMF59hcOGeDAPqdrGZzLmqAwE1n95yx/jp3R1nDyFxiHH/neoigUaVWUe
         GoakWOCNa18OwvRmJtkyWUz7flxtso0pfr393pWNe3jNKgb5eVc4+lpHl89eS/bSZVjL
         spvagnvmKdb8WxCmtAlnvsZkOMrKTlAT/lZPLjj7udSHhVtLBhpadMJ4M5juON/ravRc
         eBqaTSRozc5TH3CinMi/LFsMyvZrhQznKLXCAUE28XJmcTYvtdkLOgZhV4rwTAL2jGH0
         frjyQVb/HqbpzkSoI4yzLrRI+nb8cHoq1CndEwkOX78KRnojTf7hFlkKZi/RHPt5dnWz
         Xxdg==
X-Forwarded-Encrypted: i=1; AHgh+Rq1f1sAbn/RTcNcNCCS7FdmFlDG3a3xGwqtc8WYHVc8oEE1PO762t6V7B9B6UMzWU2ENG+xgaaK8QLjxA1JOg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyARGhrYY7FBlW4lksJ6OrWK52LL84x5EjdPA5fMgPlSCtyOber
	lwACPskL5wRl5lnoiDH72JHMhPWNZcxC38chi33pNaG670ZohoZXcDm/
X-Gm-Gg: AfdE7cn/h8MkrU+E8U1GNq1xll6pDVbWrsvoRlvc9Bwsoc5540t25VlHpQrFBl6Dfyp
	APIuaaM1kPQmZq4kfHe1zJaerVRszVJc0FcBh/TJCAkS5GZrRDO3iG87PcBYkuTTYH5dmSXqLuH
	sRFlrOf1zhn7Qg8a0BsYMFCNPCI3YThgdvWFgxjVcYa+8b/uT2agjFLLBRvxFRmwQxuxayvZS72
	eQTxj5ZpyJL0BMVe6QpfIqLff+VmNNYK1FKVO5ZTnIoPbQsyFHn2znkBXRTckeSYeOQAWu7zs+M
	xzPbu+p6h5wx/u+KTZ5C/xdFrNcu8sjtVozUUPW7msR6Z35D/WRoqKB7EgZ80Y9jOfj7/5D0JIO
	mQPzTptmAECXn7Gk9nqwwQIA3zAA8eHmrBAGsRWNISmXXiBdJizM35VFRumJvpm7BbbGPWqrFrj
	9YyG03ibq43rBURQYL4Q==
X-Received: by 2002:a05:6a20:7344:b0:3c0:9c19:65a5 with SMTP id adf61e73a8af0-3c36c443a82mr1875421637.61.1784098377572;
        Tue, 14 Jul 2026 23:52:57 -0700 (PDT)
Received: from archlinux-desktop ([69.63.205.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313b4cbafa1sm88090786eec.6.2026.07.14.23.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 23:52:57 -0700 (PDT)
From: Shenghan Gao <gsh20040816@gmail.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
	Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH ath-current] wifi: ath12k: fix frequency range for single-pdev devices
Date: Wed, 15 Jul 2026 14:52:17 +0800
Message-ID: <20260715065218.41232-1-gsh20040816@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-39131-lists,linux-wireless=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:aditya.kumar.singh@oss.qualcomm.com,m:vasanthakumar.thiagarajan@oss.qualcomm.com,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[gsh20040816@gmail.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gsh20040816@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7F0F575B413

Commit 0d777aa2ca77 ("wifi: ath12k: fix mac pdev frequency range update")
made ath12k_regd_update() handle each supported band independently.
However, it uses WMI band capability values as indices into
pdev->cap.band[]. Those values are bit flags, while cap.band[] is indexed
by enum nl80211_band. As a result, the 2.4 GHz lookup reads the
5 GHz entry, while the 5 GHz lookup reads the 60 GHz entry.

Also, the 5 GHz range is skipped whenever the radio supports 6 GHz. This
is valid when 5 and 6 GHz belong to separate pdevs, but not for single-pdev
devices such as WCN7850, where the same pdev covers both bands. After a
regulatory update, 5 GHz is therefore omitted from ar->freq_range and later
filtered out of the channel list sent to firmware.

On the tested WCN7850, the 11d regulatory update left the frequency range
at 2402-2482 MHz and sent 13 channels to firmware. A subsequent 5 GHz scan
failed with WMI_SCAN_REASON_INTERNAL_FAILURE. With both ranges combined,
the range is 2402-5835 MHz and 26 channels are sent to firmware.

Index cap.band[] with NL80211_BAND_* and update 5 GHz for single-pdev
devices even when 6 GHz is supported.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c7-00108-QCAHMTSWPL_V1.0_V2.0_SILICONZ_UPSTREAM-3

Fixes: 0d777aa2ca77 ("wifi: ath12k: fix mac pdev frequency range update")
Cc: stable@vger.kernel.org
Assisted-by: Codex:GPT-5.6 Sol
Signed-off-by: Shenghan Gao <gsh20040816@gmail.com>
---
Testing notes:

- Runtime testing was performed on WCN7850 under the CN regulatory domain.
- 2.4 and 5 GHz scanning and 5 GHz association were verified.
- 6 GHz operation was not tested because it is unavailable under the CN
  regulatory domain.
- QCC2072 was not tested because the hardware was not available.

 drivers/net/wireless/ath/ath12k/reg.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/reg.c b/drivers/net/wireless/ath/ath12k/reg.c
index 89abf2e87ad1..c3bb1df2b1e2 100644
--- a/drivers/net/wireless/ath/ath12k/reg.c
+++ b/drivers/net/wireless/ath/ath12k/reg.c
@@ -300,7 +300,7 @@ int ath12k_regd_update(struct ath12k *ar, bool init)
 
 	if (supported_bands & WMI_HOST_WLAN_2GHZ_CAP) {
 		if (ab->hw_params->single_pdev_only) {
-			phy_id = ar->pdev->cap.band[WMI_HOST_WLAN_2GHZ_CAP].phy_id;
+			phy_id = ar->pdev->cap.band[NL80211_BAND_2GHZ].phy_id;
 			reg_cap = &ab->hal_reg_cap[phy_id];
 		}
 
@@ -310,9 +310,10 @@ int ath12k_regd_update(struct ath12k *ar, bool init)
 		ath12k_mac_update_freq_range(ar, freq_low, freq_high);
 	}
 
-	if (supported_bands & WMI_HOST_WLAN_5GHZ_CAP && !ar->supports_6ghz) {
+	if (supported_bands & WMI_HOST_WLAN_5GHZ_CAP &&
+	    (!ar->supports_6ghz || ab->hw_params->single_pdev_only)) {
 		if (ab->hw_params->single_pdev_only) {
-			phy_id = ar->pdev->cap.band[WMI_HOST_WLAN_5GHZ_CAP].phy_id;
+			phy_id = ar->pdev->cap.band[NL80211_BAND_5GHZ].phy_id;
 			reg_cap = &ab->hal_reg_cap[phy_id];
 		}
 

base-commit: a1a21995c2e1cc2ca6b2226cfe4f5f018370182a
-- 
2.55.0

