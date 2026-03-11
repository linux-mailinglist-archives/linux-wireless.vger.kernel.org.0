Return-Path: <linux-wireless+bounces-32953-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKMxGzMJsWnhpwIAu9opvQ
	(envelope-from <linux-wireless+bounces-32953-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 07:18:27 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D0925CBFC
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 07:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F8313033398
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 06:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D095D2C11F3;
	Wed, 11 Mar 2026 06:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="towVjvFY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61ADE1A6805
	for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 06:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773209896; cv=none; b=Yf82jhmcy5CsLHcf+7KtbrYHlq5nedJqeizX6Ex6BuyAm8DQbKVx2TD3MQ8lK31YZLlCwpH64eq9+GcQOKhDzlALI6MaUeqFtw/PGJPZ1J+v9ILjg9VFr5Snvhk1/6V2L+efR7St4WkoxM1c5tcTPcpPmIsHhjh8vOrLpwyjfTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773209896; c=relaxed/simple;
	bh=1M4nPsxxQWTDxhu/M7dXuvma+G0sU9p6kepXXWiNkeU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nfg6O+W++MjUtd0lovaap9NMv+XdhdW30KeZzl4WLjOGtwg6OA/qrMQj9XrI9xAT6RkmnF3eha38Ung7yNG1hRMRhdxvKe07NPsf5hbk/2fD85ubRWv5ubSaghHpJemWu1t+xJp1QNgknvrbvEBEeMkP1p9jw95x3YSrLKRFzSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=towVjvFY; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3567e2b4159so7726010a91.0
        for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 23:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1773209895; x=1773814695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NRhhJySw+WLX9B9eI/5eW8K/Z0X0jSyLKlNHbs14R2k=;
        b=towVjvFYz/dNkRQLaRlt2S3sRoch3g4bJCl/TbdCCNFhOkd8mBPXTfLmVKpQuiikZP
         rvjnRcJ+ACExim11Qzfn5bi63RH5CJ/pxiISGNuQUWnU0DMLQ4CQY6aDPya97OJ3tO2/
         jNTOi9uxzbNP1DEH032b/s+vlGfbz/mvRrooYes2H0ZTw9uMZirLDO6jfbBnJkjsHW62
         o6IXaKJxitQ0LJCRh4FJ/h3mNCwISNHix4bW/lUWXTHhxFmarpmTAbA00bWipNQ1MIWN
         w1AbWmh1UyWt/wzl32KuPttGEzYZEYJXK6dhT1Osr64ByXWul+Zu4IoTTVDuHFSeVOgp
         MbIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773209895; x=1773814695;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NRhhJySw+WLX9B9eI/5eW8K/Z0X0jSyLKlNHbs14R2k=;
        b=kko8anNTpwj7CNlOaN6rKcVUygqUZkCy+8i963BdbrqYm0KhvLcew0Bj5BevWBIgEs
         Q8zJFzd30a2JxqqfsHbzXhgQPJsl8m7GeMVZzJfiwdrzzAgjMyPejujgqbPTf9RyGBfA
         aRu4DoqBCIXAII74ltI0A172hoHBLkXGnFaXu90580eCnMgDvrEZ1APFNEJXYgLX2oYR
         Gftwythqqnonft7NO8RmadU+bESGH83n4loi/xG1A4snPWf5/vZCCLXtE8lHS8n4u4rF
         6SluS2UaMwyhUK0h10xTK64OS4iQNCYsYe/4xurmaIwSE3w9/WAr1HkPQD8S6UQ0Xw5w
         pyTw==
X-Gm-Message-State: AOJu0YxfkCdHRN3jhWQUWyaDdzdnfe1hjml1aXuYYMaNJeTPavf7nzXZ
	Ei/CETS3xg1XuSnosMlVwG+bXqrIFN8QbdFpY1zEhE8pkWdP/36VSNT26QPep9oLGXw=
X-Gm-Gg: ATEYQzw/dbak6hqltxzvU/BDpyyQe+ncbhz1Un2MnGEWA8FZVSyXrurrUoCG9Hmi5K8
	mC+odKj5byj7/zXi9e3o/VK7aYwBW74TXa5azFdA/MqqE9n6p5K0lplixbxO0ZnITbqtzinOVk7
	wdLVcWlDpSMXZMx1DBqn8Cslsvx4GpCbBksJv8SS6F34eq8QOrP/rkz+BQ5fktsL/Ag1AHYm1eY
	+T0aQaykQ05FzcHlFLKFyB3k0XF9B4v1BlsmRxjcFxkyaC2kZ0ci3jfMCtR4HD2IK5Bn+mb3s3Z
	ZJAzQFRzBKejzpLolji8sTkY6gWzLHATOfW1Oe1v0NVprCg/N3U1P/UoTS+28e5xunX9GgirHb7
	yNot9etEu6AZD0/wOI6Rjje6F1QDkChglxM97+lpa80CaopsceL2uuUEt6AgmvZQmzOHicYsd+t
	qvzo5kGXDRioHq2YAFIws3TBHOoef0XP1VOYTeASWPpMrYlY5G03ddS17CVK0vA2dmTHew0df5/
	7Sn0Z0denZk4j0VguWidoJQYWhr4Vk=
X-Received: by 2002:a17:90a:d88d:b0:359:fd50:e733 with SMTP id 98e67ed59e1d1-35a01357ed8mr1509873a91.31.1773209894660;
        Tue, 10 Mar 2026 23:18:14 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359fc97356dsm1993097a91.8.2026.03.10.23.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 23:18:14 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: [PATCH wireless-next] wifi: cfg80211: init S1G properly when creating chandef
Date: Wed, 11 Mar 2026 17:18:00 +1100
Message-ID: <20260311061800.517849-1-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D2D0925CBFC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32953-lists,linux-wireless=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[morsemicro-com.20230601.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,morsemicro-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Action: no action

When emulating channel contexts, the first chandef passed to the
driver when starting an interface is the local->dflt_chandef
via ieee80211_calc_hw_conf_chan(). This means that currently an
S1G driver will be given a chandef with a width of 20MHz. This will
lead to either the driver or firmware rejecting this configuration
and a non-zero ret code - leading to a WARN within
ieee80211_hw_conf_init().

In the case of emulation, ensure we initialise with a width of
1MHz for S1G channels such that the default chandef is valid.

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 net/wireless/chan.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index 68221b1ab45e..c0c0151fe55f 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -32,6 +32,12 @@ void cfg80211_chandef_create(struct cfg80211_chan_def *chandef,
 		.freq1_offset = chan->freq_offset,
 	};
 
+	if (cfg80211_chandef_is_s1g(chandef)) {
+		chandef->width = NL80211_CHAN_WIDTH_1;
+		chandef->center_freq1 = chan->center_freq;
+		return;
+	}
+
 	switch (chan_type) {
 	case NL80211_CHAN_NO_HT:
 		chandef->width = NL80211_CHAN_WIDTH_20_NOHT;
-- 
2.43.0


