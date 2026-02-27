Return-Path: <linux-wireless+bounces-32279-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDKnFYFooWkUsgQAu9opvQ
	(envelope-from <linux-wireless+bounces-32279-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 10:48:49 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECB91B58BE
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 10:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 070AB301DDBF
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 09:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569EF301465;
	Fri, 27 Feb 2026 09:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GhrFhYf6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E991D2D5926
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 09:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772185727; cv=pass; b=Iuqf1W8iIWobpAQcR4kn3UH24JY2QdmbRnmuRScm3yodHMXcGMy84ZoTErffJTl/38WwLHsfJ6B0hxCzF8DA4J5iZBbPCpOZ+uf4bykFDdlKhTXzFqTFVS6NPvPpndeUIRVHsyknpIxkAbmUJ5zCQRxOaMM1P2Ph8b/AXScv7z4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772185727; c=relaxed/simple;
	bh=M9FGWUTxTB3RtKlC4iw29L/vEYTJdEuxtz9CPFLRPB8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=pJj3L3h05dx2cEQY5McKJDoGi/TTrFOq5IbdVEFqDsiWd4BYa0zciPp7tb58Ts4yHdTUpOVVAvxkHRAl/3fKBetaVmrQYdIvFSj/W/ktgiTzMrwRdABFiFzTzTg/wZQj/5gkU0+gmqxvVf8/7yqmGfJSrVmN47j6SzOQM6MiaeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GhrFhYf6; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-65c4152313fso2633179a12.1
        for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 01:48:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772185724; cv=none;
        d=google.com; s=arc-20240605;
        b=B9eCL0k6lzuYsdpiM1i240mMxnblI+CMfZvxvjtOFlF+feCJIgV6mifrePvfTqZQM8
         Ba1dRzNo5Wn60kna21h03C43cWgOEUHwNz8iJZw2ETjpu/ikUdBl3Z7jPj2PvK3xHaa0
         cr1Sj/vhfoHopR37X+iyZ5XVahuMwgvubJNvwfRymmv/Jkl6kyswNJZBRqm8/fq+KdUv
         zNU+JU7+/2i1qqObHXgy/Sfn8rFET9y1VEbV1xYEnf3fVRWhCw+q+7wCZNx6cP1KZew3
         7sgrDTHUz50M5R8mn9vaxmVpMrwcrS5euuG94yYWgPV9Dd9HoalZVolvz1l6qwAQIBOf
         OTNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=mvWhmGNlsrDoO+Uint3bMB+SDsbnG6YLcbgOdFUPFns=;
        fh=ru6fWO4GBlegjsSZkL+At6gjWpeY460Z+ACiiSEQTtA=;
        b=ZggECwDh3rKOrkOXh5GZAc3uM4Vk9lahfuF3Rrh8mspSqWRDBA8h1mIohOnaFd0RcL
         CuPtxgC2E0tdaBpZSLdMfOfE/aCD0iUOI4aTglfmncnzXVeQZtwobowPN2RLv5F4AneT
         ag5lEWcSRYFa+JH+Z8JI+VsBHkHLimFuikNmJyYmmhgin+ASiqW/vIOxgd5vuceKLS69
         rHt5yLOwQvD+l4LeRO+i+1QTYcvYrfWmjxcoUuDYTT7vgIIgQsIfcoir8DlaZh8lpg0a
         9SmGhJ5Nq8grwbndFOxWsNset0/Srf2LXlJv5mO5Xkol0mrc40OXYH096whTs8Hq3RxG
         upaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772185724; x=1772790524; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mvWhmGNlsrDoO+Uint3bMB+SDsbnG6YLcbgOdFUPFns=;
        b=GhrFhYf6dcYIQh/x2gPZ5jCCc4RYa528Dfl9DdXOaDtFT3FF1yc479Ez5DJUVDo9tg
         vL/zU730ksFF5ZcnqQ4pHfBn9RCI611nVhRFZmGsSaPeB0kEq6dhUM6Uj1cOea1TEc2P
         z+ZP9wufVmsIkDR8noliG1oOMYRTJxV5BCwFQo5b9+SrABDNaA0TCpf69qXTfhnQmp5A
         4GeyZNOVoBQ8nzMp/gy0rxL5B9rJ+S0D0d6eb2mUX1nqAUztFpmP+D4kGYEywZynP+0T
         DRNRYtRrMTTz04Oz54SFjZulWisPHxVnXi3jdwAvdNOWvuwvN9046ZT/wA4QxMs1ouLp
         iGuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772185724; x=1772790524;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mvWhmGNlsrDoO+Uint3bMB+SDsbnG6YLcbgOdFUPFns=;
        b=DyOIzOTke5ik++JsiIZAD/VMWIHZNmL2NsOh8bdIjG3y5wDbVm1K8En2qXerIoP9iD
         kygv1yUxmG3uHTV9l0VLaGwvQg9yUYH7m42oxBJjcPo+sByDM8X5ivbkxsUak7DtzJ9L
         MQPUqgoZq4wOsD90WGRV8zf9gxjtj334lMapA4W756BZhhf7JvjL0PME55BnMYH6G+tv
         bO3GptmltcuPA2bckw85svTjPUCRFwIBZp9W6VhZBrqD6WdPpi9eO41izK3LS+kZFVEG
         DA4ZkPI3HsUBezbp/m//j4zlzUXi2nUCL3Ymoy0nmTJGI7SZHdtJVIiEWTsd25EYy6lv
         yYBw==
X-Gm-Message-State: AOJu0YwEAQp4ZFB/z5KH3HwcJrdUjEXmm2w/o4cduww08rPqNBQ/RsSb
	WsI6MKYKE5SQC3lFMCtTs5dzifLpUQwyX0COHwTnnzbfP1WdmFgC8l0rV47Ry8wg1Jt5QIb2/1b
	2xRr4oHD/RDeTdHSAO+qwU84VFT5xJ0UTeGv4
X-Gm-Gg: ATEYQzyIe+LTjVC22UhaYJUP31OobuwkQnVFMYXIvMrc3YESIQj80xvtHSy8Q6VvF4b
	O/JjzAxbWQCXNWChNQ5veNRC3g/5ANwSfIGnzvAKDohjKcahsnImevU0oCmCZE2yNISoMH1X7ol
	oLgspT571159QX9i1sAIPbCVqET8zz4tFFQSDZkyciFpuW66WU14fb7GwBcgKP1rIilWi+Lj/5N
	aW6K7R4Lkq1spdajWSOiXX5D3RWNFZlbn+s3EWRReT2rVrK6f3Rcfuv6UQFZMmR1hwJy3j7EO8C
	oWUNoA==
X-Received: by 2002:a17:906:f59a:b0:b8f:abff:9ce7 with SMTP id
 a640c23a62f3a-b93764f4640mr122528366b.32.1772185723668; Fri, 27 Feb 2026
 01:48:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bryam vargas <bryamestebanvargas@gmail.com>
Date: Fri, 27 Feb 2026 04:48:31 -0500
X-Gm-Features: AaiRm53tAgTqkxmKKpLNle3F7R-sONgTatX2CRPGut2kGlZmwhFkAUDbI2WOvBs
Message-ID: <CANAPQzi3BkfnRS4CEXAA560O5cO8e6MEYxeVVx1u+xUeXS-gmA@mail.gmail.com>
Subject: [PATCH 1/2] mt76: connac: fix txpower_cur not updated in mt76_connac_mcu_set_rate_txpower()
To: linux-wireless@vger.kernel.org
Cc: nbd@nbd.name, lorenzo@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32279-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bryamestebanvargas@gmail.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 0ECB91B58BE
X-Rspamd-Action: no action

From 0a29ccaeb2211451b88ad71c4c0cdbc418b7d64d Mon Sep 17 00:00:00 2001
From: bryam <bryamestebanvargas@gmail.com>
Date: Fri, 27 Feb 2026 04:30:01 -0500
Subject: [PATCH 1/2] mt76: connac: fix txpower_cur not updated in
 mt76_connac_mcu_set_rate_txpower()

mt76_connac_mcu_set_rate_txpower() sends the TX power SKU table to the
firmware but never updates mphy->txpower_cur. This causes mt76_get_txpower()
to always report 3 dBm regardless of the actual configured power level,
since txpower_cur remains at its zero-initialized value and only the
path delta for 2 chains (6 units of 0.5 dBm) gets applied.

Fix this by calculating the effective TX power using the same approach
as mt7915: mt76_get_power_bound() applies SAR constraints and chain
delta, then mt76_get_rate_power_limits() applies the per-rate EEPROM
limits, yielding the actual value the firmware will use.

Fixes: 3b4a3bdba808 ("mt76: mt7921: add support for reporting tx power")
Signed-off-by: Bryam Vargas <bryamestebanvargas@gmail.com>
---
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.c   | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index fc3e672..4ed31ff 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -2272,6 +2272,20 @@ int mt76_connac_mcu_set_rate_txpower(struct
mt76_phy *phy)
             return err;
     }

+    /* Update txpower_cur so mt76_get_txpower() reports the actual
+     * configured TX power instead of always returning 3 dBm due to
+     * txpower_cur being left at its zero-initialized value.
+     * The value is stored in 0.5 dBm units as used by the SKU table.
+     */
+    if (phy->chandef.chan) {
+        struct mt76_power_limits limits;
+        s8 tx_power;
+
+        tx_power = mt76_get_power_bound(phy, phy->chandef.chan->max_power);
+        tx_power = mt76_get_rate_power_limits(phy, phy->chandef.chan,
+                          &limits, tx_power);
+        phy->txpower_cur = tx_power;
+    }
     return 0;
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_set_rate_txpower);
--
2.43.0

