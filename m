Return-Path: <linux-wireless+bounces-32045-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0G5+OF7Cl2lx8AIAu9opvQ
	(envelope-from <linux-wireless+bounces-32045-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 03:09:34 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3F6164324
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 03:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B98CE30138B2
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 02:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE77E257ACF;
	Fri, 20 Feb 2026 02:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rj0YV3x2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B7623D28C
	for <linux-wireless@vger.kernel.org>; Fri, 20 Feb 2026 02:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771553368; cv=none; b=En1/v3PjgYBfH9r/exOiM65YL0RdIczu5+MBapr9+0ELgALg5b539SQjXcqF9QcQL5KboU9FWc2Ea2uJuEqaSwlYGAz456IMdTIckuJev+Smw9NHWK1UI7CmWRSiQcB3f6lwfIP4e3uazCTCQg5goa3s54DziczMXfMVuEotGwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771553368; c=relaxed/simple;
	bh=UcnrL9laKasOPs8P9LfHIAXH90c9rzWVMY+Cb6gpx/M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m/bvLrlx9YapM6tAqB0g4yVBmS9CsdIrguXB1QdzcK56a14AxpGvU3olDh2LeibDnLTPMVFGm/MpikEPIsm5yh/xakJ2vZxv9ixaXs3xmUC8fNEE+XzwOIUugSihYXJ211SspJUX8pKeSJmIOScMttGva2Go/Wnee/4OkZvGEhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rj0YV3x2; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8230c2d3128so743102b3a.0
        for <linux-wireless@vger.kernel.org>; Thu, 19 Feb 2026 18:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771553366; x=1772158166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tDV9xPVLh8nR5wsS4K0GgvhRgol9hQj6OE4qa9Kkvrs=;
        b=Rj0YV3x2jC8K3gCPDz5lfYo3NMyT7UclhX10OypyPZ4aP9px9WmQKMnlWVOwqHcJTf
         9qr7pcmxn20yxruno/RWZ54vrx4ORlGt0zWdEjC6FNJtqzak1mX5sMGwAy0/EW+ghbOQ
         uvR8yE+0wnXAb/vTjKrJgmir+K+6yRhPJPU9iWZY6An2MH7N1pl/udlYlACKFW8vMqBz
         mbZ+Dngn267jkZHMjZjYvLT9+IHrJg/REAJxIotrfM8qf310Pnl4dDCD3WoSNUv37BSy
         cXAP+9T26h2zmWKs/irlOXujRv96sdd7aas2ZbnMzIX36bvOzCEg9tdrR0SssokP0yws
         hwNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771553366; x=1772158166;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tDV9xPVLh8nR5wsS4K0GgvhRgol9hQj6OE4qa9Kkvrs=;
        b=h16tgSrQjamV8ybED1nR8+Xj5leP5NmRAg27yNBx6XviiYDOsxV3AlRDXqYKMkDuZm
         Eb8TQ6UpmRJVw7XTAoahX3dAQVjJ8A7OEpj01W+pgd+c1NyIgIfIdgsxXSR1I2PZDT2z
         S0qIhKFIac/Vl0KjzeYGWC5B/4V0c1eMLgXsNBEeRAwKndF50q2WXKchANl2uh2/mWyj
         kQHBTMuOkzHO6lP5/EG1iRivrJbuzL9pckx44Ua1nF3X4bSvtE214Wu5/t+McibAlz2X
         ui4B7i88erkZKuWCc5u2OzxEO0Br+wU4h1Za7UsGnlH1k255wGzHgMqPOkAO5Ox+w+mm
         rCbQ==
X-Gm-Message-State: AOJu0YyRps+sHn2VM74tc/ssspQYpaGmS8V4WMUIBPI6a6eI9C29cSFA
	pk7Auk94l0F4xtMU6LCM02O4jWeDyB/jcZnUV6hJhAsgd3/ZBGzw2gkPxsc535p2ciE=
X-Gm-Gg: AZuq6aLAf6XKbFYJRtJ6gx43glbO06rQEuMFY7BeGFl5rdxwCC0HTMI6p7qBPRP0Lqv
	FnpljoBQ+yr5JntayeG+TZ3Dq/SG3zPGd4Tkbrc+p9we2MrHYEO95GvqA//kgx2RPqT4i4HcJ7n
	/Jjjh3H1bpKAUEBzpRzwyJqAXjRNAONgu+B0Ji+hC6HzSrK8mGPGS7UQTZ0kwUPaqpxU9WU0FUj
	A98WmaQYdQXDkNB7WtwOZnWJILJfliQZeQXvBApNIFYsV0gI3rKhId4Po/byhY/c6V9gv09fWJW
	HdRkS/4BVGAdCI6soYjy/OtrFAOXI5H2n23ugbs0i1tqLXGftqScvuegD93CLC6CvpcOhbDzDF8
	VLrk2ZV7Dv23dEkFyNBwKzI9mWJw4ibhj1AIDpK9KRD5cMfQLWX0oQ6I1qD4zm8yQa1CwcphzKq
	c+lUI=
X-Received: by 2002:a05:6a21:398e:b0:394:5cc8:6230 with SMTP id adf61e73a8af0-394fc3accafmr6684155637.70.1771553366416;
        Thu, 19 Feb 2026 18:09:26 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e52fe2e75sm16505080a12.10.2026.02.19.18.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 18:09:25 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Stanislaw Gruszka <stf_xl@wp.pl>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] wifi: rt2x00: use non of nvmem_cell_get
Date: Thu, 19 Feb 2026 18:09:08 -0800
Message-ID: <20260220020908.40115-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[wp.pl,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32045-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5A3F6164324
X-Rspamd-Action: no action

The library doesn't necessarily depend on OF. This codepath is used by
both soc (OF only) and pci (no such requirement). After this, the only
of specific function is of_get_mac_address, which is needed for nvmem.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index 65d0f805459c..93e4ce604171 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -10965,13 +10965,13 @@ EXPORT_SYMBOL_GPL(rt2800_read_eeprom_efuse);
 
 int rt2800_read_eeprom_nvmem(struct rt2x00_dev *rt2x00dev)
 {
-	struct device_node *np = rt2x00dev->dev->of_node;
+	struct device *dev = rt2x00dev->dev;
 	unsigned int len = rt2x00dev->ops->eeprom_size;
 	struct nvmem_cell *cell;
 	const void *data;
 	size_t retlen;
 
-	cell = of_nvmem_cell_get(np, "eeprom");
+	cell = nvmem_cell_get(dev, "eeprom");
 	if (IS_ERR(cell))
 		return PTR_ERR(cell);
 
-- 
2.53.0


