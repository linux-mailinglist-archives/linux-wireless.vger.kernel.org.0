Return-Path: <linux-wireless+bounces-32313-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONN/KdZho2myBQUAu9opvQ
	(envelope-from <linux-wireless+bounces-32313-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Feb 2026 22:44:54 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0356D1C9392
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Feb 2026 22:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B0793016EEE
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Feb 2026 20:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FE9175A64;
	Sat, 28 Feb 2026 20:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHFet7ar"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32F5430B82
	for <linux-wireless@vger.kernel.org>; Sat, 28 Feb 2026 20:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772309430; cv=none; b=MYC1OP4gKKfaZv1GNUVFR6PpiAkxAQGW8CMsmNdXAzsrYaTVsMEWK/ags8wcM4x6fgxgWgUE6IaYTt9AhGob5MXTlVTu0iGIgD6WW++oylhr5r/ykj3gToSsGVjZmKcpKcUpZzRH0A4ivB5H2p8bjn1dnHIqu+vrOhNT07SYrAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772309430; c=relaxed/simple;
	bh=nXivYBE2P+TDXHLYEe8GpDquqKSHDbe3XeTT7viBqbA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qjMhaEsQx7fCRXYMI2yVmgt3D8SJRL48shBsSQpS531mYd+SDNpxQOLK3oMlJIwQToZMESgQjmumaD+5N7kg41bW4UgmaXojSWWf4vdVvjLn6qwVGpiVIP6Uym8AmeL3GB9KjHJiS9ksY+/KQYIUyDzzmlWuDZj/W4dB5niWtRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHFet7ar; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-5ff07cb35efso2128729137.2
        for <linux-wireless@vger.kernel.org>; Sat, 28 Feb 2026 12:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772309427; x=1772914227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UakhJPU9os/s+Hl8WFLkDW7k8DEgnLbqBYDV9vq2Is4=;
        b=aHFet7arCU8f70DHSrfXNkAE/vm1icnOAgoRswTqEeKqnl4CNwUgCTNkBiXhxosmnp
         s4V9MXFMDLUwCsR9sEciLOsQgwdXts8UXWhQB5AmgKUlQyQvFCMoB6w27aTA5UZG3WYl
         gptukUB0BhNPLuwo7tdnP4HRRwGPOWUbIiwoEYv/fGoSTA1FF+agJpGlInKcOR/igUkb
         K3itW5VF0SyBh68tzIYNnIGjRun7AqPMN2n/eGxlWJIrwET5bDsTvfjTIwqlzLi7KmzK
         ofUbSsWqkP7BPKl6xkIXnJlTp1anMif+JjiKqBTW0axcq6xLXxq1mjGMvLH7/Lc7cjlx
         B+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772309427; x=1772914227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UakhJPU9os/s+Hl8WFLkDW7k8DEgnLbqBYDV9vq2Is4=;
        b=A+XvRCcPP/AVgNu9WGrpw0CMvKluxp6IlRpMvRTCjSPBVRv/uwIVa1BILtlqta4jSA
         bMj/2m+M/9J2f4xujNB2bw/1P49ogyxZG9WA3bSh7UM1rlCL7TvhUGcPQTUGtbtsGpmB
         UTWKz/HIhcg8PllcGyGFWfr7QNppISjgIMRnk8SZLH3+Dp53e4YlAgvsohnfiPLyNM+D
         dr6QV6XdnNq5n1hDbHRqq+plxzfjeZQnb7u1dNSowauCE4IJVVWSajo5JZusG1I12rZ9
         9THrA6l7Uxu6L18sYoUpoMjJyP1mDkLvc8f/T/SWR68GzE0+LCV9251Ou5CjK1zCv5ND
         W64A==
X-Gm-Message-State: AOJu0Yy0f27tT4+6dAEh/b++74DLDx2OORslihoEoWLtlLd4Feb1OH1d
	3bO0yHxfXpiqvAVM77Ep6w+NxwbzEIfGC+YHK34HtjSZ09Av2t5UPsGqRLv0P4GdjIBdFA==
X-Gm-Gg: ATEYQzyYcCITuwdcDOdxvfVjucFV+ClQLXmT2B1m2FZGlBunTSRxFTBOkXp3Cc7v8d0
	Bd7gurFXz3w9a6RrNgl26gKxwQb5UwPtj1mFd6q7VJ/Ekm/XfUWqDFgdETFOPQw0KQsqpJXKglC
	Ehhz+ZLf8It419xKCOKwq4IgPbUperuZ/bwBvxo9pUzpFujOUh0o6p6+xTzKLR/276B9QUUfOSn
	CWaRCV3aBXtg6hFGZbcI48rVPW6KggVTo49TRP/fEcwXdhNrmVsyQn99sr69SJVwP7A/qozl//B
	16iHU/l5pi8tGzzCSoyuUZT3s5WiVRH97fOcCOUjBQDo8x3Fk7pamCvXlaOA+F4IPKDEtW0TkQT
	bATb9wwGKxtVp/PS/2lLoCs1jpTJFBmlwY9VjXacChjJ1x43MOWae0+vOmfjkpgQueZCvIFf0BC
	BcGn31Q1djTdXquxlYqDxc2hU0UmznYs8=
X-Received: by 2002:a05:6102:2909:b0:5fd:a537:a775 with SMTP id ada2fe7eead31-5ff325ad924mr4230919137.38.1772309427413;
        Sat, 28 Feb 2026 12:10:27 -0800 (PST)
Received: from cochinote.. ([190.13.119.48])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ff1e7afde2sm9112744137.1.2026.02.28.12.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 12:10:27 -0800 (PST)
From: Luis <lxluxo23@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: jjohnson@kernel.org,
	ath12k@lists.infradead.org,
	Luis <lxluxo23@gmail.com>
Subject: [PATCH] wifi: ath12k: allow user regulatory hints when firmware reports world domain
Date: Sat, 28 Feb 2026 17:10:23 -0300
Message-ID: <20260228201023.116947-1-lxluxo23@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,lists.infradead.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32313-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lxluxo23@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0356D1C9392
X-Rspamd-Action: no action

Some WCN7850 firmware versions (e.g. WLAN.HMT.1.1.c5-00284.1) report
alpha2 "00" (world domain) during initialization instead of a valid
country code. When ath12k applies this via regulatory_set_wiphy_regd(),
cfg80211 marks all 5 GHz channels as no-IR, which prevents active
scanning and makes 5 GHz networks completely invisible to userspace.

Without CONFIG_ATH_REG_DYNAMIC_USER_REG_HINTS, the reg_notifier
unconditionally rejects user hints, leaving no way to recover from
the broken world domain without reverting to an older firmware.

Fix this by allowing user hints when the current regulatory domain is
"00". If the firmware has not provided a valid country code, accepting
a user hint via iw reg set lets the driver send a WMI set-country
command to the firmware. The firmware then responds with a proper
WMI_REG_CHAN_LIST_CC event, restoring 5 GHz channel availability.

Once the firmware acknowledges a valid country code, ath12k_regdom_changes()
returns true for "00" and subsequent user hints are blocked again,
preserving the original security intent of the CONFIG guard.

Tested on WCN7850 hw2.0 (ath12k_pci) with linux-firmware
20240318.git3b128b60-0ubuntu2.25 under Ubuntu 24.04 / kernel 6.17.

Signed-off-by: Luis <lxluxo23@gmail.com>
Assisted-by: Claude:claude-sonnet-4-6
---
 drivers/net/wireless/ath/ath12k/reg.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/reg.c b/drivers/net/wireless/ath/ath12k/reg.c
index 7898f6981..0c52d559d 100644
--- a/drivers/net/wireless/ath/ath12k/reg.c
+++ b/drivers/net/wireless/ath/ath12k/reg.c
@@ -87,9 +87,20 @@ ath12k_reg_notifier(struct wiphy *wiphy, struct regulatory_request *request)
 	}
 
 	if (!IS_ENABLED(CONFIG_ATH_REG_DYNAMIC_USER_REG_HINTS)) {
-		ath12k_dbg(ar->ab, ATH12K_DBG_REG,
-			   "Country Setting is not allowed\n");
-		return;
+		/* Allow user hints when firmware reports world domain ("00").
+		 * Some firmware versions default to alpha2 "00" on init, which
+		 * causes cfg80211 to mark all 5 GHz channels as no-IR, blocking
+		 * active scanning and making 5 GHz networks invisible. When the
+		 * firmware has not provided a valid country code, accept a user
+		 * hint so the correct regulatory domain can be applied.
+		 * Once the firmware responds with a valid country, subsequent
+		 * user hints are blocked again as usual.
+		 */
+		if (ath12k_regdom_changes(hw, "00")) {
+			ath12k_dbg(ar->ab, ATH12K_DBG_REG,
+				   "Country Setting is not allowed\n");
+			return;
+		}
 	}
 
 	if (!ath12k_regdom_changes(hw, request->alpha2)) {
-- 
2.43.0


