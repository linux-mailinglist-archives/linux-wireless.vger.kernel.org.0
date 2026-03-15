Return-Path: <linux-wireless+bounces-33245-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIhQBvDptmlRKQEAu9opvQ
	(envelope-from <linux-wireless+bounces-33245-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 18:18:40 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFC9291B06
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 18:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46F3C304DEA9
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 17:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9C8375F7D;
	Sun, 15 Mar 2026 17:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bkP3s57m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BBA375AA2
	for <linux-wireless@vger.kernel.org>; Sun, 15 Mar 2026 17:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773595022; cv=none; b=fHF7Nw4i5e73/iFmH0q+6lq9nL/qV/ApW/u4am2OKDdEMgiOkM1Tb0RzmdDu3uMM0jq9B9LwDQ934ZlWnZrlPQ9qbS9+HHxdsWHjSvNgFoOoQbqUa3/nNddXxPfFa2t+tnn4DJqPnzh8WlLyatJm/rYSbBO0njbT28YspmZrbA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773595022; c=relaxed/simple;
	bh=X32PXM6CIYzypQR5TwfD7Jn/cbq77OlrCWR99DHxUpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VcbDVsngojzJm/2byi+Gz7u/6K7ZKsTLrWFMDi0+r+NdC6s4jJd3imB+Srs6LVDwY6s4Qdlp5nyJCVpuBQu6V2huXqAp5YRD5Eyw9TqFgb2OptsSV8BgHvhDVff4chbW7umjzsIYsZaO+AiIoGG7tJwoCnYabNjh+LLNu/9O2Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bkP3s57m; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-439c9bdc1eeso3943293f8f.3
        for <linux-wireless@vger.kernel.org>; Sun, 15 Mar 2026 10:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773595019; x=1774199819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ubQ1v6PBsq99cAcF2yrnS1WsB85d1f/acmJVUU/lg1s=;
        b=bkP3s57mdv06Q8pGVWI4sO1FcTTW0j4zh+8kzK4R0Kpp+g8bHG1yntDaZr+QWoE5BZ
         +CtFml9JkkNytDIZEJqKa4MeJ3m4zFKaZt0klCzfeZaEo1KCiakxbgaV2NoKjnXU7otn
         rr+SYvK4ssEnc1oxI0xCByyWzzsTFU41my6/fvn0ZdD5hhoQe1sSv1jsT58Bf0ByHtj+
         WvL2wSTQ27qYrzk1BjsVr9PCQvp0NF/1ESdZsOUxwR0KjvVwLsvfIGDUdPgSiOVVkEzn
         MupnbYA45bC946+Fh0djNXW66NMPP/1gYgk+JFKeCz4keggXKP0N9sdY99ByzigsffOF
         Rx+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773595019; x=1774199819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ubQ1v6PBsq99cAcF2yrnS1WsB85d1f/acmJVUU/lg1s=;
        b=ZAR4ax2XZSS4cb64jmYxgqCgmvAW+AVdjymdPh+6jy1i9PnyO9Snzi7P3ifgRmFo53
         LDC73Q2uV1dZVxFBKN73Dh3tdDPQF1pG2QoKXwz+9Ubeuua8Mql9TcYY+8VwRq3OkhMv
         eHRg0G+cJ/vri8Loh4RruiCMDqdpn44ERwm8/FVJPLL1kgDOYHcUBqc36U9DF9qbG5C2
         pP/IqKp3AxzCEQT2pcebRlCsR8IMGlTdGXPcJhtj3R9KY05DUTrnTgZAvAiL525lZF1y
         m/MIsWjyrW7AAxDrVKr95aYa3E4EDRnEqfWGwNzaxc8nEnB6LZkeH5lWNja6A05ZeYuq
         WApA==
X-Forwarded-Encrypted: i=1; AJvYcCUNCtrjrrjCTS5xY6oaTPRvVz0ZVngEiD9/tIyJ4iQHLunjplysMMM28JuVZhNOB5sq5jcCpzR6AMJ2wE+kZg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwuR9SQrIRqiEivLJOWzEwMhxJ6qO0wa5p9IukfLOu9CcMOHi5W
	y3BKluppyW+pJNEsUQTwxsghCzwkPa+z23zwWa7GSoCEpkr0TTxJmy/k
X-Gm-Gg: ATEYQzxYy6UmSW7cs0YavuIJG8bjLnVzuOcSJSaMX4eNPCLEoPvU87a0+PN647ULjwX
	4JTmadV4EgeQamF7PC9Y4sAJAXWaITZ+yljbAvvv8g6LsZPsJrJP6R2cvmtMoJB1MlEXUaWrvm5
	5axPa4MgduTSoeZ4P5Q2QshuKTmzU77YkdORQJwiT2TqmuFQuGTcobkthkW8fKssD6nqTweiTiT
	IO8fY2fgz4jseMNzWdBfKSu6bUvMhhsO5X1Cz3lD566qafqqUZJRIJCHCz/msZbkRguMNGUnrTm
	OTpCiu9+UmV/4Zl78Nm9lEgsU5jO8qNa8PbD1X/ati4nmAL+vkrdJ/A6SeZkIQ+0X7t2vqM/B59
	X6DNQizIJpRLXI5RnORwib9y7JIcug9X9EODbCA/BaqraPHjWAz/WgvGWD6BPmr08HbaoBNGLzN
	n2iiIolBuW+ZccEzc5LSBUFEMXZ3TTckskCw==
X-Received: by 2002:a05:6000:200f:b0:439:b59e:5e65 with SMTP id ffacd0b85a97d-43a04d79252mr18547646f8f.6.1773595018822;
        Sun, 15 Mar 2026 10:16:58 -0700 (PDT)
Received: from debian.lan ([171.22.84.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe21b631sm40536429f8f.27.2026.03.15.10.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 10:16:58 -0700 (PDT)
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
Subject: [PATCH v2 1/3] mmc: sdhci-esdhc-imx: consolidate imx25/35 data and add Kingston CID
Date: Sun, 15 Mar 2026 18:16:50 +0100
Message-ID: <20260315171652.269020-2-adriangarciacicuelo@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260315171652.269020-1-adriangarciacicuelo@gmail.com>
References: <20260315171652.269020-1-adriangarciacicuelo@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[gmail.com,nxp.com,pengutronix.de,kernel.org,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33245-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adriangarciacasado42@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6DFC9291B06
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Consolidate esdhc_imx25 and esdhc_imx35 soc data into a single shared
struct since they share the same flags. This reduces redundancy. Also
add the CID_MANFID_KINGSTON definition to quirks.h for centralized
management.

Signed-off-by: Adrian Garcia Cicuelo <adriangarciacicuelo@gmail.com>
---
 drivers/mmc/core/quirks.h          |  4 ++++
 drivers/mmc/host/sdhci-esdhc-imx.c | 12 ++++--------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
index c417ed34c..d736bb4be 100644
--- a/drivers/mmc/core/quirks.h
+++ b/drivers/mmc/core/quirks.h
@@ -15,6 +15,10 @@
 
 #include "card.h"
 
+#ifndef CID_MANFID_KINGSTON
+#define CID_MANFID_KINGSTON	0x70
+#endif
+
 static const struct mmc_fixup __maybe_unused mmc_sd_fixups[] = {
 	/*
 	 * Kingston Canvas Go! Plus microSD cards never finish SD cache flush.
diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index a7a5df673..9cfa26722 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -256,11 +256,7 @@ struct esdhc_soc_data {
 	u32 quirks;
 };
 
-static const struct esdhc_soc_data esdhc_imx25_data = {
-	.flags = ESDHC_FLAG_ERR004536,
-};
-
-static const struct esdhc_soc_data esdhc_imx35_data = {
+static const struct esdhc_soc_data esdhc_imx25_35_data = {
 	.flags = ESDHC_FLAG_ERR004536,
 };
 
@@ -391,8 +387,8 @@ struct pltfm_imx_data {
 };
 
 static const struct of_device_id imx_esdhc_dt_ids[] = {
-	{ .compatible = "fsl,imx25-esdhc", .data = &esdhc_imx25_data, },
-	{ .compatible = "fsl,imx35-esdhc", .data = &esdhc_imx35_data, },
+	{ .compatible = "fsl,imx25-esdhc", .data = &esdhc_imx25_35_data, },
+	{ .compatible = "fsl,imx35-esdhc", .data = &esdhc_imx25_35_data, },
 	{ .compatible = "fsl,imx51-esdhc", .data = &esdhc_imx51_data, },
 	{ .compatible = "fsl,imx53-esdhc", .data = &esdhc_imx53_data, },
 	{ .compatible = "fsl,imx6sx-usdhc", .data = &usdhc_imx6sx_data, },
@@ -414,7 +410,7 @@ MODULE_DEVICE_TABLE(of, imx_esdhc_dt_ids);
 
 static inline int is_imx25_esdhc(struct pltfm_imx_data *data)
 {
-	return data->socdata == &esdhc_imx25_data;
+	return data->socdata == &esdhc_imx25_35_data;
 }
 
 static inline int is_imx53_esdhc(struct pltfm_imx_data *data)
-- 
2.47.3


