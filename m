Return-Path: <linux-wireless+bounces-27343-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B7BB58D91
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Sep 2025 06:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9D5A1BC4714
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Sep 2025 04:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CAF2F0661;
	Tue, 16 Sep 2025 04:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRPVEEEM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6040B2ECD1A
	for <linux-wireless@vger.kernel.org>; Tue, 16 Sep 2025 04:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998183; cv=none; b=Sim3dM6Ochd7h2XPIanVrLxR+KrqA2pxScy+89t7CAqrPo0UwYYxHqRiKe22t96VT1a+JGVc26cTWHI0sYLSV7503ayWR2O2fEoA7Sk6FWdOi5cEby1DFmGdWMq4EJy0zozfnlyRv5h1b3eTs70908WVmz4SGVoh8HmRYVryA3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998183; c=relaxed/simple;
	bh=xZie7XPvdT38eYIBnvXACDOKlp4uDfFQ6p8xkwCAypA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PHuMJjxWK9ny695BvM9PdEtj+Hsp6uOiGsH9NS8IZxcgBOr0UhsO4H2xqHhwnO+DwvuLr/d5lefIlO0t3wzfHg4MnTm8Kz/i1dFrePqkFZsCnn4BiTVii+afYa6YJgWJtmOosMnkrN/tPLg8jaWjeJHZO2PDCmxn011oBSk6OBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VRPVEEEM; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b49c1c130c9so3351131a12.0
        for <linux-wireless@vger.kernel.org>; Mon, 15 Sep 2025 21:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757998181; x=1758602981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Tcedso9pzLAwLQitmBj+2+6wC4HZyTUiqHFeMdiOi8=;
        b=VRPVEEEMyPFp1/apdgsdGcdVZa8RyIEDb4oi+MRkYBM99QFUqx8qesncXE5xPiXr4k
         5EmQzzVM6ROAy9MD5JQWOsyeqzNpcJOOfhDFpvyiLSBzgAVmSV4PpvkG7J3oLLXh3T2t
         aSGMxXUkZ/sTwLMVvwCxtrd/98Mzai0cB56bcT2QDXO9wehrl8U9zH9CWY9ycecU5qrW
         lgZghkMXBNPhiPB0dDJ7sUurWKQUnVaHBn61VqMU8sFvJRgf6DYXbUA1UPvggaPVkZ2/
         wEyAhf8NXX+w9nILAVNf9HZ/dItwjE6ImKe5EZYWjDrUvt9j68hAE0JwgxYdvG9auYLy
         KGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757998181; x=1758602981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Tcedso9pzLAwLQitmBj+2+6wC4HZyTUiqHFeMdiOi8=;
        b=prVqQFpVwTku0peK7wbJcledc+AvTKht0f8AjUyxR7xdS+0ycmDTjJPl9sPj9WPxMS
         YEClTjIbd0iYw67z8npuKC5dw/mqnq/nwp2GDSxFGk9zlrIy+LktEvuYbJE8CIjbw0wR
         4B9+RxY3s6jwCnLRGFKE9BODd/k1RAYHxH3qne8KmIe1D+ovR+01WWXeZxsYmVu/QnfO
         PTFQ/yHtV6Rq+5Iu07LozAodj7MkHhp80JvnfTACXWJ0S/zeJAn5zaSB8jyB4FsQxtRK
         H/NPkZUjt+kOXKArFjrje73GSV/6LtrxTTYRcUUOuCi9R5+lULLj2ns7iPaYXn7xIRv5
         4HjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHQdl4CHt6FopfdOIXSU5Ef6Z7+fsiyGuYL0RP7HA8ciUsiR/dljZpA1co/dn5noR2uW5/LzILNujmOyaC5Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyB54WyoIXNZdjIZ8t7frs1T3j2uFBsx5qQUnDOTSBpunaNxAvT
	mRfEZQyvvwKWvVecC4TIwBtcCeeh2+i2Bs2McP9UMo1QNiPb0/UXnsg/
X-Gm-Gg: ASbGncvqLZBmpGq7+89hDCyqTK1KC2etWDWO5lWqN5zJJyrLwjjeZ62af/4Q1M0CW/0
	kaE4GYisI9XRm3NyiBln0BEV/p30tByofx1D4WBHUiExqjSYIZHUApdjeAY67UTh3HRgMVE6gzQ
	EmCTE6tfm2qao9cTxZx6vDdJx7X0OCawf/yhlQ6WjzNGomUCcUdXgTziVHqScZmvJMig4IPvdNH
	v2gHsk5kN19kxXm1SDeig6ur3n2LdnTOu7qxDlUT7eXx8U1eJErNW7kvJIr97VIx/wBYjBWByYE
	5cQcuckekhmNCeLV6+uI2c22ShVbWxhmiOkoZzJbdas4fFbJAP536GlSYqYW/CkkYhKgzMGuS7S
	meViHGa5kM+fvaNTxY4v8xaJQabKV9Sl+2R7XI24=
X-Google-Smtp-Source: AGHT+IEk/DXYOCMhugqpymqTGh+KMlTQeAIuikssxOXlHLYZS5SBPJrXDrKkOxyomJ+DECodEM8EoQ==
X-Received: by 2002:a17:902:c40d:b0:251:a3b3:1580 with SMTP id d9443c01a7336-25d24cac4eemr191581215ad.6.1757998180587;
        Mon, 15 Sep 2025 21:49:40 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25ef09c77f8sm104600605ad.15.2025.09.15.21.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 21:49:40 -0700 (PDT)
From: pengdonglin <dolinux.peng@gmail.com>
To: tj@kernel.org,
	tony.luck@intel.com,
	jani.nikula@linux.intel.com,
	ap420073@gmail.com,
	jv@jvosburgh.net,
	freude@linux.ibm.com,
	bcrl@kvack.org,
	trondmy@kernel.org,
	longman@redhat.com,
	kees@kernel.org
Cc: bigeasy@linutronix.de,
	hdanton@sina.com,
	paulmck@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	linux-wireless@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-s390@vger.kernel.org,
	cgroups@vger.kernel.org,
	pengdonglin <dolinux.peng@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [PATCH v3 13/14] net: bonding: Remove redundant rcu_read_lock/unlock() in spin_lock
Date: Tue, 16 Sep 2025 12:47:34 +0800
Message-Id: <20250916044735.2316171-14-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250916044735.2316171-1-dolinux.peng@gmail.com>
References: <20250916044735.2316171-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: pengdonglin <pengdonglin@xiaomi.com>

Since commit a8bb74acd8efe ("rcu: Consolidate RCU-sched update-side function definitions")
there is no difference between rcu_read_lock(), rcu_read_lock_bh() and
rcu_read_lock_sched() in terms of RCU read section and the relevant grace
period. That means that spin_lock(), which implies rcu_read_lock_sched(),
also implies rcu_read_lock().

There is no need no explicitly start a RCU read section if one has already
been started implicitly by spin_lock().

Simplify the code and remove the inner rcu_read_lock() invocation.

Cc: Jay Vosburgh <jv@jvosburgh.net>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Signed-off-by: pengdonglin <dolinux.peng@gmail.com>
---
 drivers/net/bonding/bond_3ad.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index 4edc8e6b6b64..c53ea73f103a 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -2485,7 +2485,6 @@ void bond_3ad_state_machine_handler(struct work_struct *work)
 	 * concurrently due to incoming LACPDU as well.
 	 */
 	spin_lock_bh(&bond->mode_lock);
-	rcu_read_lock();
 
 	/* check if there are any slaves */
 	if (!bond_has_slaves(bond))
@@ -2537,7 +2536,6 @@ void bond_3ad_state_machine_handler(struct work_struct *work)
 			break;
 		}
 	}
-	rcu_read_unlock();
 	spin_unlock_bh(&bond->mode_lock);
 
 	if (update_slave_arr)
-- 
2.34.1


