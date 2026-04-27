Return-Path: <linux-wireless+bounces-35334-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDMJLl3x7mmm1QAAu9opvQ
	(envelope-from <linux-wireless+bounces-35334-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 07:17:17 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A40F946D23D
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 07:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6F4533004F20
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 05:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CD035AC28;
	Mon, 27 Apr 2026 05:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhyNLH9/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB852222A9
	for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 05:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777267032; cv=none; b=Kk4wgWPLfQDwND+8WrZeJZIHk5h/hx+vxgci2tFQ+8gZAruQ5h2sIxvzIuPwKla5W9AfHsohc0WMEydJMmRnIM3wmWfnaJHbisk5ApYpe6yeRnXUcL8X41tfZLwgTgbcRDrvBmTKddaFhMSiN20/mxekoOUXxQyAV+HGYfRs4BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777267032; c=relaxed/simple;
	bh=Iw8U2fQwcXEz9bTcg6ahs4tw3DC91bXwCajKgCZqaOU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R1gexfOq15/1mZKPZLjGr2EIdnXy2839ZGxb9Y84oPf4YNlssbIe/gO0PgYQHEb2gIl+iGO4WpEtNatBcAv94rYb2CQX4u/e7ZgiKwdjpsIF+9hkShctvDTnOnrwRjJVDo5ctZYeSJ0DTUMyF6q8kS4YncjxQXxKoCvzO0+GbnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bhyNLH9/; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c76bde70ec9so3813019a12.2
        for <linux-wireless@vger.kernel.org>; Sun, 26 Apr 2026 22:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777267030; x=1777871830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KzqGtYxjboO/NsOIX0ogC3IrKsPmx+IrVHY8Yjl6i7I=;
        b=bhyNLH9/KKhpsmRcbU/B6BaUdLwGzij8UWlMQNbP6ysNfVCoUAJ96fN/7vixkLPXm7
         tiNuEy4fusDq2CDjz4crVzWnUBwALgxX5NSBjtyUSmoyiOxYWIDgCy2FJBMXFppotgxZ
         mpqq0a7Nmx8sSX1Th6bhi0lgQWZfQ5wGdBhM0PRLPe9fyO/loIe7RpZm8Rqcjk2vwX/R
         3JzsLKXZ2tynEn/ZpanjKPSduUwAt5xPKKFIOLStWig11XOkNRUeY/C9EfSPn2klhS0+
         ac58yza6fzfQh/W34vRMF401hqeVrvgPB82IY3hteeuhbdWqAA4/dGQrT+UFDT3IufdR
         MnnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777267030; x=1777871830;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KzqGtYxjboO/NsOIX0ogC3IrKsPmx+IrVHY8Yjl6i7I=;
        b=hnhmtPZYf3gxpjjb8V74NSv0mP0OQta9DYaX56lWDXKXd/APU5spuptACsz58XMp5q
         WAxH15fZiDwkjXLM0jLr32nkKw7xpx6BUhHpnQOyG2hROVOZmY1XFIhvEcUDGErPqn3d
         C98HmuNPeeI3Ar40tUjhJ0AVn0zAEKoKHGBCwuZsBa710k2oYeJgUbq7VdCakAYFJ13H
         qxLP5rL8iYSduk96tlXW9BziVcOyq5MMNz3L+wQI5DbG3yj+9egKSAWL6npPdL3lFDbp
         4wqj0trtwoZt4XoFZKvj9xN+TG+OO0ZsRV4HFqGyu+12yEs7rHBfjY7xgw5yOz+z8F1c
         6RaQ==
X-Gm-Message-State: AOJu0Yx3S8iqwfUN1An1cJ3ui1ANYlajfk9DRS7hn4SFwXNKsNg/LxVl
	eC2kQUfSxcADQN7sKaX3Ic64+mBsNMUsYnLdqYLmi4KgRHPLqPt1KXIrGSHnww==
X-Gm-Gg: AeBDiesdCPysljFa81pYqFr0zc7g5s1nY7DAxhJ8uXof6C3CccOSfqiP1i5tmJMevv0
	SOUvyCiM/oFcG6V01iB8gnAsp5ME84r/X+kV/CNw0iBPiXzk/OxGnlruzKyLoCWX6iUxo09T5Xy
	37ydsivwIZIjktUHA6K9nSKKoBo1C3o2zn1VEqF00qfILqkm2Ep2oPgeQYNrQR6AkdtGEgkWBjx
	yNGQjxCL7XcBEJQf5d0Z4xs0QTum9siSJzjZIbrPdLXjHPxz1sgUwMglwolHrYRq4oqMj1tBk05
	in1alUjjHaz9oAKaBQIkugJ/mErak1X98jqSxCFx+Tiwq77bFZYsE5hzD5pNQzeKsd6iCAl8i54
	GD+ldNy7IL1JH1DPk4b9pDEZYv61mpi2IFHVhNaIoDIT3LXtmCORbZXt4c2+w4piQ/DFDZ98sdm
	eKub/CRc2Hlp6HPtjt6Hw1PJkl2Ldmm4uHd/t2ofhhGNXbwOaHWy44cJWLu7XshotgaDz12FtKa
	vpJB1cFwxZTorld7Lz54MbrPA==
X-Received: by 2002:a05:6a21:6d9c:b0:3a3:17f8:bedd with SMTP id adf61e73a8af0-3a317f8cbb2mr21380763637.17.1777267030274;
        Sun, 26 Apr 2026 22:17:10 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c797702fbfcsm23481238a12.22.2026.04.26.22.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 22:17:09 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Stanislaw Gruszka <stf_xl@wp.pl>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH wireless-next] wifi: rt2x00: check for of_get_mac_address error
Date: Sun, 26 Apr 2026 22:16:52 -0700
Message-ID: <20260427051652.954059-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A40F946D23D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[wp.pl,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35334-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

is_valid_ether_addr is already a check of of_get_mac_address, in which
case it returns an error if false. Just set a random MAC on all errors
except for EPROBE_DEFER.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/wireless/ralink/rt2x00/rt2x00dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
index 2d778ea5f1b5..51b836343f07 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
@@ -991,7 +991,7 @@ int rt2x00lib_set_mac_address(struct rt2x00_dev *rt2x00dev, u8 *eeprom_mac_addr)
 	if (ret == -EPROBE_DEFER)
 		return ret;
 
-	if (!is_valid_ether_addr(eeprom_mac_addr)) {
+	if (ret) {
 		eth_random_addr(eeprom_mac_addr);
 		rt2x00_eeprom_dbg(rt2x00dev, "MAC: %pM\n", eeprom_mac_addr);
 	}
-- 
2.54.0


