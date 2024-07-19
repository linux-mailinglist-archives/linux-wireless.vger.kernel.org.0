Return-Path: <linux-wireless+bounces-10370-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2B09372BA
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2024 05:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4034B2826DD
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2024 03:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2C1182C5;
	Fri, 19 Jul 2024 03:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnx3ZgmH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6083BA39
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jul 2024 03:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721359441; cv=none; b=XA1rBtnrRdsw9qRsOOC34swjsT6lGOh/+Mofz7/rcEITeJJDBTH87vBE/smGTxYPyzVY6RkGw+alZ0F92+6XZKPeDQw9WWEIvD17v5qz3knX4Ga/79CdY+gE0ol3gtm7cwC0TZF5bZJLnAPwI6pSiLu6/fvk7gX3aHBWyfVJR9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721359441; c=relaxed/simple;
	bh=VklYZoXqgMfBxBpZEtm4ST/Iow2HUDBJBm/23lH76XM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RhXzbZ1SnBkZDenZdSUW66IVZlu8JyIoOS1/irtEpnbfFV+QntxNcbEHvpXu4dbHTw8dDlDoriTWc4jwE/e8cO9nbDZWVEU5ixwNbj5HAWbvAofqMqX7mBoPNe3LLj/98fbrsCt9ezngnaM8+7Q7Iea49be5fM2otC+9zn4H9Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fnx3ZgmH; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70b5117ae06so361996b3a.2
        for <linux-wireless@vger.kernel.org>; Thu, 18 Jul 2024 20:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721359439; x=1721964239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hw9MxDYjCDZPKe0pPKGa20/2reQTiIpQlhrmRrwXuGY=;
        b=fnx3ZgmHTd7dRITNLNMV2q+D+uKnK7uvjcLeMbNfLG7s8o+MhYk/5AxKHl8AoGgRJ1
         BUhausMo5MePN6S9de+fqwlYwUCnvQDnVtT72jHBv4MdpJorU/l8VKF52AhWfJJTK3K9
         vvIphgYWF1d5QY2KN8u4K9y9IJeyQ63ixwJzlT4MIALMy8BXSEz4f+fwsfWWFGKI6guc
         5DA8ZiSw1evc09+r/cIsTlL4FvN5QxACwn3l6qUk102c0VXdGB8N5lN/WtdN12D7mJ0d
         NG/Y/YOrMrh9dNCuMluASM3WiA7p9TFdaa8iy+rYEth12opSrpbDpa3mqh9Csi3QIcBL
         vzHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721359439; x=1721964239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hw9MxDYjCDZPKe0pPKGa20/2reQTiIpQlhrmRrwXuGY=;
        b=Vm8mrH5VMqgBHxYoRojyl7oHIAufSfOdaKxJ8Kp7AYEWZk6faSDtJ/v8hPdyvPnZYl
         ubWZp/Go439xbhMbCPMDHjtreqokgR6rINv2bg96/HRyfVLRcohuqPssAhKWV1+Vz4ID
         zS+nMsiirNN4fz634cwt3zDjPq7soqqIBuDrgMF9OVKVrbKeuI9YjMTT/jMcFoMqB7nX
         QhVj1sThnnKVTpqYrZauAzAxy3zW/gAa/M2Kz9vNwY614iy6m0vCeLDnmpmpJ/yTEFCV
         WsatApc9Fh9IPj6gnqqrbKCAZ/IT3YHMqp6qBtM50SYmulh+pLoACGvltzWayIPIKaTT
         LzRg==
X-Gm-Message-State: AOJu0Yz3fBueWv6s/gy94W/s+AWk5Oomlbc2s5jgIiLB4DrA7NLSvcyj
	Uct6qvq+HH1CKpmvuC/FfRa+aY39yZ7NbtDp60C28CcMFX6UMrhzpVhPRNgC
X-Google-Smtp-Source: AGHT+IH3QDE73aAhx7uVbuP5X1jQyZQZTQlKAU8dt8Owuy+t+9KZh+fRw0cGEJOdioXFi4LV0cdwnQ==
X-Received: by 2002:a05:6a00:4b4d:b0:70b:29bf:bbde with SMTP id d2e1a72fcca58-70cfc8f8d6cmr1977912b3a.12.1721359438917;
        Thu, 18 Jul 2024 20:23:58 -0700 (PDT)
Received: from localhost.localdomain (59-124-166-19.hinet-ip.hinet.net. [59.124.166.19])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-70cff59fd9csm279160b3a.173.2024.07.18.20.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 20:23:58 -0700 (PDT)
From: Ping-Ke Shih <pkshih@gmail.com>
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org,
	wireless-regdb@lists.infradead.org
Subject: [PATCH v2 2/5] wireless-regdb: Update regulatory info for Peru (PE) on 6GHz
Date: Fri, 19 Jul 2024 11:23:23 +0800
Message-Id: <20240719032326.7353-2-pkshih@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240719032326.7353-1-pkshih@gmail.com>
References: <20240719032326.7353-1-pkshih@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

Ministerial Resolution -2021-MTC/01 decided

For the band 5925-7125 MHz, low power indoor case of use.
 - access point
   maximum EIRP: 30 dBm
   Limited power spectral density: 5 dBm / MHz
 - user devices
   maximum EIRP: 24 dBm
   Limited power spectral density: -1 dBm / MHz

With minimum bandwidth 20MHz and PSD -1 dBm/MHz, 12 dBm is adopted.

[1] https://cdn.www.gob.pe/uploads/document/file/1861732/Resoluci%C3%B3n%20Ministerial%20nro%20373-2021-MTC/01.pdf

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
  - explain how induce how we induce 12 dBm from PSD -1 dBm/MHz in commit
    message
---
 db.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/db.txt b/db.txt
index 5cada55b51eb..1e0a14b8670f 100644
--- a/db.txt
+++ b/db.txt
@@ -1443,12 +1443,15 @@ country PA: DFS-FCC
 	(5725 - 5850 @ 80), (36)
 	(57000 - 64000 @ 2160), (43)
 
+# Source:
+# https://cdn.www.gob.pe/uploads/document/file/1861732/Resoluci%C3%B3n%20Ministerial%20nro%20373-2021-MTC/01.pdf
 country PE: DFS-FCC
 	(2402 - 2482 @ 40), (20)
 	(5170 - 5250 @ 80), (17), AUTO-BW
 	(5250 - 5330 @ 80), (24), DFS, AUTO-BW
 	(5490 - 5730 @ 160), (24), DFS
 	(5735 - 5835 @ 80), (30)
+	(5925 - 7125 @ 320), (12), NO-OUTDOOR
 
 country PF: DFS-ETSI
 	(2402 - 2482 @ 40), (20)
-- 
2.25.1


