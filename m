Return-Path: <linux-wireless+bounces-35879-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDXvOY/z+GkD3gIAu9opvQ
	(envelope-from <linux-wireless+bounces-35879-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 21:29:19 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 516F64C33EA
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 21:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C962305116E
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2026 19:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747A43EFD03;
	Mon,  4 May 2026 19:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tGh5aL94"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDAB3E6DD3
	for <linux-wireless@vger.kernel.org>; Mon,  4 May 2026 19:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777922098; cv=none; b=ZBn5yEmHVbhDD3OSMhnxMI6RXGcTviBtZkfG12BSWrqRmrs8tYSO2+w+nAuqAvnfa5s6oDWcRTgzFMsByGkDGajoLQsqeBTsaSLXulg/Kx27/vhDa+11OjHXDzEB98Qs7Ifkbm9Lho0kT8mXC8knKFnRvVP3pxmpJm3VrleBBPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777922098; c=relaxed/simple;
	bh=XZj1cYMT/zbS9qnfbhvpEi1WV/yWnWc3iVHjB0Esjro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HoXoZ2WEgFCvXKEitwAU1ejIegg2eMUB+q/cu+oq5oIm6bCYp3AZk47UGVZJRzhITVkm5tjSfi4b6zqhtq6QMJ3AIgzgh2+u7wupEc0l0l5fNhZaOCUv9I0R6CiaTnRfV3wXUchWP8LKm8VZN9qR9leXyvW1at1lfNlVjmfAdJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tGh5aL94; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso35391325e9.3
        for <linux-wireless@vger.kernel.org>; Mon, 04 May 2026 12:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777922095; x=1778526895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uR6jnaQsF5aEXCsWH61cE2ueX8vtoQ4x8FrOBogd8II=;
        b=tGh5aL94RS3bdty+piLJ73YiGO7ppAb16CGIYWCkD+qP7ZGS8acKBpEqlr6pJye/jp
         LKcFVisXqIcJsrN9TL/MtL4qUOOAIhEj86rBXPoGlgDcB7QlT2DpYQNEXorDoxw2NeGE
         LYWhDHcycTol0TcpVv2n1oFvAFWhewKSWAyftc4ZaR0fnMPkEl03fMewxpQTfCaRW5t8
         aC7zlNv57Qw3oqiVUBvfSlHH1fLrGu1j8OxxdhqUmfJ/j8ynp5hpG2JJ8BjO7zTimB9N
         nWCvKuSqxPKXqmdW/6syj1H8Q8IzGQrEdie4RGl5c8ym/IbJlQaRJL00MZ613thJC51f
         KwOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777922095; x=1778526895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uR6jnaQsF5aEXCsWH61cE2ueX8vtoQ4x8FrOBogd8II=;
        b=gZ1AnIe/gC94hJOHiZeGN7sHfAFd+dOeaMDOjOEEcDeJxj3g9dZomt2MjIuaWYwPnx
         zHaITpoXcpdbaRKyTWal7k9MvA/lhz6o8TNrO30SxQM7N5xqcPoWs9+nNnNIRD80VNNh
         UCLS2Ikx72vpjOyxiE1n4GujGWK6lJE80YrvUe1omNn5XwsIxOFzVdbtxsLG3DekRPk0
         YXOd4MI4Q/mXILeOmQOT2hSU8XzeSoefgOMkVrsNDOrhHKTqTeuSDAZMD+cVAYCcKQxB
         B0cMbQjIaa5g++vvk9aSRWtUUPaPAnODh1zQSqpVVG8/FbzvnqwHOiNYfHheLxmaFmrE
         DAnQ==
X-Gm-Message-State: AOJu0YzeU+OsVbJ8qn2775mmhlfneckl1mSTxrhlWdUh86rpB9LgzpS1
	gKoJhnqD6Srt5dt3BUAshmMhKwMcOZw3MvnGvT79Tf1fA9GweJA215v0Rowr
X-Gm-Gg: AeBDievCpiDXNXIN4Wo94THpSnAZ0UhI0f0lxSZryJTfDoc3Ci1m0RGBoxOHc+BTCXy
	2d2BwVsue0sFy/1RuXkTOLlgN8SO7jeeuC1AK431kql06f1MWos0+uCwKxrE5ZIksjBuuZU7WFs
	NHieIFFNjgshtCcE8sQUErrDZ64nZcthgc17DcgpbFITdlOCpqP12jsejjEWUrvxCg+vX2ktKD+
	HQbLOCxm1Va7/qOYcSwVgtpnXdImnnioqFCZwFDLSHA9nIhGvHOax8xU3zrXASn5DobpoDqVXiP
	57c84PvBjRNNZA19yQvI2li0ew6hGggvRtaAETWlxAwR7LQMtDd8MB31cmd411DppuiCkMl5r2V
	mi6f8CWRaEO8OqltXLWGDrk8TN7FqkWMfJpsfiV595/Ey9GcAKXXKC7OdRCfRqHYJ7cM2jWPFPO
	bwSvFM/0yaAb9aGE/l
X-Received: by 2002:a05:600c:c0c2:b0:48a:76a3:2b9b with SMTP id 5b1f17b1804b1-48a9865ea56mr132197625e9.17.1777922094544;
        Mon, 04 May 2026 12:14:54 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4500d73510csm105445f8f.14.2026.05.04.12.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 12:14:54 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: linux-wireless@vger.kernel.org
Cc: error27@gmail.com,
	kuba@kernel.org,
	johannes.berg@intel.com,
	dcbw@redhat.com,
	linville@tuxdriver.com,
	lkp@intel.com
Subject: [PATCH v4 1/2] wifi: libertas: fix OOB read from firmware pkt_ptr offset in RX path
Date: Mon,  4 May 2026 19:14:51 +0000
Message-ID: <20260504191452.3408257-2-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260504191452.3408257-1-tristan@talencesecurity.com>
References: <20260504191452.3408257-1-tristan@talencesecurity.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 516F64C33EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35879-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,intel.com,redhat.com,tuxdriver.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.995];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,talencesecurity.com:mid,talencesecurity.com:email]

lbs_process_rxed_packet() uses the firmware-supplied pkt_ptr as an
offset into the skb data without validating that it falls within the
skb buffer bounds. A malicious pkt_ptr value causes out-of-bounds
memory access when the function subsequently reads ethernet header
fields from p_rx_pkt.

Add a bounds check using size_add() to ensure pkt_ptr plus the minimum
packet header size does not exceed skb->len, without risking integer
overflow on 32-bit platforms.

Fixes: e45d8e534b67 ("libertas: add support for Marvell SD8688 chip")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/202605030019.lL8x0ZPx-lkp@intel.com/
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/net/wireless/marvell/libertas/rx.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/wireless/marvell/libertas/rx.c b/drivers/net/wireless/marvell/libertas/rx.c
index c34d30f7cbe03..e6378be4266e1 100644
--- a/drivers/net/wireless/marvell/libertas/rx.c
+++ b/drivers/net/wireless/marvell/libertas/rx.c
@@ -9,6 +9,7 @@
 #include <linux/hardirq.h>
 #include <linux/slab.h>
 #include <linux/types.h>
+#include <linux/overflow.h>
 #include <linux/export.h>
 #include <net/cfg80211.h>
 
@@ -73,6 +74,15 @@ int lbs_process_rxed_packet(struct lbs_private *priv, struct sk_buff *skb)
 	}
 
 	p_rx_pd = (struct rxpd *) skb->data;
+
+	if (size_add(le32_to_cpu(p_rx_pd->pkt_ptr), sizeof(struct rxpackethdr)) >
+	    skb->len) {
+		lbs_deb_rx("rx err: pkt_ptr %u beyond skb len %u\n",
+			   le32_to_cpu(p_rx_pd->pkt_ptr), skb->len);
+		ret = -EINVAL;
+		dev_kfree_skb(skb);
+		goto done;
+	}
 	p_rx_pkt = (struct rxpackethdr *) ((u8 *)p_rx_pd +
 		le32_to_cpu(p_rx_pd->pkt_ptr));
 
-- 
2.47.3


