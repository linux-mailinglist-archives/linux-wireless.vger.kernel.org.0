Return-Path: <linux-wireless+bounces-33244-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGRxNo7ptmlRKQEAu9opvQ
	(envelope-from <linux-wireless+bounces-33244-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 18:17:02 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 549EB291A8B
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 18:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A6A5F3013DFF
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 17:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBE3374E56;
	Sun, 15 Mar 2026 17:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hbt4Z7J/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CB2370D57
	for <linux-wireless@vger.kernel.org>; Sun, 15 Mar 2026 17:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773595020; cv=none; b=U4i2O2desVF23A95wf8hI9OPQvL27XMbk49w7ZmntdbiFFVnH6Z7IewFr7X1Hllql6H3eyf9Nf0229/auQ6hkGibu89bsY+k3cM2EBcLbW6QdZgmBCVpQjOorwmlP6uMFnbPhHSR4XhFVrN9QQTpcmU/XBgvKz0LaNbu7mgo98k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773595020; c=relaxed/simple;
	bh=Da/cK6OQrHU3pcAlgLxrLXJu8wvJOC9tkJMNybOwlek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NIJLPkGWtxXFE6l0UFvCouq7L48LDDMZ4pxXLNQBl504uQYjd6G7X+p0W4WV1BEhhPZiJTPnJOTt0dQdudJ/WLcMKlq3/dqSsihVd0VvSKkksb3g0C8Aaf/pCCTeuK7GTytBZN9eH3PLRhCr2XShI189g9qjA4jawQFDXcpzez0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hbt4Z7J/; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48538c5956bso35228655e9.0
        for <linux-wireless@vger.kernel.org>; Sun, 15 Mar 2026 10:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773595017; x=1774199817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MVyBXQRSzr9/lSeks120us8HXOhp+dnwI23FH9hEtAQ=;
        b=Hbt4Z7J/pTX/JBJKLFLkJhcHX8Te9jRBHsvSWNnUlQiuRHV3hP7fQZrm7OkUBSD1Gb
         J3QJhFaH4HXXRowOLMg71+jZcION16MfaioBo6ogIdcHvkjDQ3UsgTsi2eGVxWEWqQmS
         HLZxSm6wwatviSEX2YQHF3Hb7wgoWzj11ZNwc4H8W5wME2A0YrI+z8jIkeXLrt0vkP2+
         NeStjmEDeM1kzfwwi6sloXfvOc7UfLjjF9P1HQCyV0QkD+FSnsi35hKLwDg39V1JL6NL
         aQpf01uSQxxmO3PfSiCOLHBPAP+VTzxAYeaGBWNCgq2O287yZG9fg3Sj0v2phZcaEPdZ
         QCzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773595017; x=1774199817;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MVyBXQRSzr9/lSeks120us8HXOhp+dnwI23FH9hEtAQ=;
        b=mVLH2BIZ84Q1XQo4F5EWn7AJj+JVCcX0qIk9EOLReM3IOlMA5lV7a2oIgUaotpPfn4
         2PqMjyPj5vrjgQAfv0ayeIA906LNxtaGNNWFFHIsp1UNVQ/sm32kti1zPnvHcYALOIMs
         FwmWW90ulUcJxVtBErBoE64ysq/ZDbR6rSj1n2yThmwxjNplfGqB1kwF/8vMLIjEVPqc
         yg4bpk36xsmENhnxHVJ40wMgQgpeZPITmeqLlHFezvq59cbj+QxyUJ8/KUcGd6ErVn/Y
         wQd+cfZ80dnbAEID8vbzUxtKFitsDXihp6FRA3fHEscuDy8PVWQAQRIhD9Yfwg1R+X7w
         D2bg==
X-Forwarded-Encrypted: i=1; AJvYcCWh07U+Ej1KvCGhf8R+WA726E8eyMDDdyJeoIn/b0xux7LVhA55rnlnvcpcCcWYkB9Adc/EpUhvxRyykk07Xw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyBGFOcU2rNPfiTDc8eT9Ylm2y9USQpto8hzYhA5YxPnw6rU/AW
	vdLkwbPasQgb69Ppny8QT6hzloPn7L5EpwDHoHGthED/gXimtHY60jE/
X-Gm-Gg: ATEYQzyuV+VFxiO9Gy+cH49L0WJXKOcbpiS8vYDZguVbK8/rhZAycc1r/O4lhHo5hQT
	kjT174JacjuIWtbVh2mOvDiK8A24Vd7WLn3KIyEBPz8vlfNgWs+9Js5OsLz5ZYza38ihx2md7OG
	WnNv1foSwbEFLCQZM93BDeK9dWU65gGB4SBsfpM2OG8+pAqU7FPr+dMYdr17UAxovktdGLYtQXW
	o6AYqCQkYFT+797DCQaGD8CjcOrHOW0MCxVsC1v7ybAn4js1rnTnolMm6pxGM9mjsF0aCQx38lO
	euREKdN+ozQ/5WflDYGmKT8GQc3kpA1A9Uv3FyPv4Fcmqu54HTsfCKWwywhdf9j+DdgyCX+rG/Z
	8e6WErcPGd8/ZtYL2KdELBR5nQff73MmaLmB26BJ6Hacow+F2At0Z8/Kzvo//NUxotPGNl8n1ys
	Wt3pZRSoDcz5sZvVAt1xLiKOz2p4SkycBs7A==
X-Received: by 2002:a05:600c:230c:b0:485:3a4f:8bfb with SMTP id 5b1f17b1804b1-4854f56bf7bmr178045195e9.6.1773595016983;
        Sun, 15 Mar 2026 10:16:56 -0700 (PDT)
Received: from debian.lan ([171.22.84.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe21b631sm40536429f8f.27.2026.03.15.10.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 10:16:56 -0700 (PDT)
From: Adrian Garcia Cicuelo <adriangarciacasado42@gmail.com>
X-Google-Original-From: Adrian Garcia Cicuelo <adriangarciacicuelo@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Boqun Feng <boqun@kernel.org>,
	linux-mmc@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Adrian Garcia Cicuelo <adriangarciacicuelo@gmail.com>
Subject: [PATCH v2 0/3] Optimization and alignment for MMC, Rust and iwlwifi
Date: Sun, 15 Mar 2026 18:16:49 +0100
Message-ID: <20260315171652.269020-1-adriangarciacicuelo@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[gmail.com,nxp.com,pengutronix.de,kernel.org,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33244-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adriangarciacasado42@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 549EB291A8B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch series provides functional optimizations and alignments for 
multiple kernel components, specifically targeting MMC quirks, 
Rust block driver abstractions, and iwlwifi interrupt affinity.

These changes were previously submitted as a single monolithic patch 
but have now been split into logical, atomic commits as requested. 
The code style has been verified against checkpatch.pl.

Summary of changes:
1. MMC: Consolidate imx25/35 quirk data and add Kingston CID support.
2. Rust: Update rnull driver to use Pin<KBox<QueueData>> for alignment
   with kernel 7.0 zero-copy initialization.
3. iwlwifi: Optimize MSI-X interrupt affinity mapping by skipping 
   the boot core (CPU0) for high-rate RSS queues.

v1 -> v2:
- Split monolithic patch into logical commits.
- Removed accidental addition of nested kernel repository.
- Fixed Rust code style (line wrapping).
- Fixed iwlwifi white space issue.
- Wrapped commit descriptions to 75 characters.

Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Haibo Chen <haibo.chen@nxp.com>
Cc: Frank Li <Frank.Li@nxp.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Boqun Feng <boqun@kernel.org>
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: linux-mmc@vger.kernel.org
Cc: imx@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-block@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Adrian Garcia Cicuelo (3):
  mmc: sdhci-esdhc-imx: consolidate imx25/35 data and add Kingston CID
  rust: block: rnull: update to Pin<KBox<QueueData>> for PinInit
  wifi: iwlwifi: pcie: optimize MSI-X interrupt affinity

 drivers/block/rnull/rnull.rs                         | 13 +++++++++----
 drivers/mmc/core/quirks.h                            |  4 ++++
 drivers/mmc/host/sdhci-esdhc-imx.c                   | 12 ++++--------
 drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c | 10 ++++++++++
 4 files changed, 27 insertions(+), 12 deletions(-)

-- 
2.34.1

