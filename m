Return-Path: <linux-wireless+bounces-8109-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2048D0439
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 16:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCD5E380665
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 14:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA3F16D9D7;
	Mon, 27 May 2024 14:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAvlreb0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F7F205E3E
	for <linux-wireless@vger.kernel.org>; Mon, 27 May 2024 14:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819484; cv=none; b=T7hvcFXSfNLUKGKqmoJ8gciUOBYdcXKRO/c1n10QiIucayJ8XRg7HjKsryi4soSTTO3xodHVw7Ut7Ci/DzOhS+8DS4rnuIj7eP5MxxhMkpMx4HKMhfJBc9l18QdW12LJbpGrp3tyi9Hpd+VI5UGmEUr2loc6mZ1pzon0zFpuZcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819484; c=relaxed/simple;
	bh=CcrFiLCwFDVWQy3cY1VDBy5ULZOjAoU15qjtKGDkBKE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hkBj0fIGCLJmr8Y6aJOHbMIJQK24eMwmZTI0S/OpzmBNePR13CyuszYLKcLfS/Qzi9GRIcl6sR1HegtjybO1VTlkhxJEiRyIWIH1k2TqhZCFZ0teKJ6y1v2fZfypOo39M3wZpzbXJgAZ6hsQTF0cRxBQvNL6wWucxfh4yH5aEcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EAvlreb0; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-354de3c5c61so4472469f8f.0
        for <linux-wireless@vger.kernel.org>; Mon, 27 May 2024 07:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716819481; x=1717424281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y6uuFjRehewDn4IIMWMNJX34YKG8TQM5OJnsN6xxLMw=;
        b=EAvlreb0JDdVTpM9ONA02A9QMFwDdmoa5mIRo1PSWwUhKUT/Ouz5GBBwKyDVQQ9+QY
         RAtqZPb0Hy1t4Q2TqzAqsHl6ZqQf4y4Q/xjvp3JHOOzkkAvK0vui31zLHbG/Wa7ZxRGd
         b5EEmVObrybgROyewALvwh+LsNoE4GGwB9z9i+DTzSzJ/tb7xVD2qx9Yx3A5S2MCOl/N
         uHN6eGtXvXd2M7PkGqQ35AhwI1gfEWoj7mdZRdBu+rd5xJwmnHSx6cFV7uUTYBe/dD+r
         4UQQVEwKPy8UU14tddfgw4uwWIOZawzSBaUfw1o2jBY1tfDiniRsTAktJlbP4r6dbbqK
         lbEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716819481; x=1717424281;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y6uuFjRehewDn4IIMWMNJX34YKG8TQM5OJnsN6xxLMw=;
        b=X3yMBhQWCU63eE3Y29k6c3xeXqm4G07pH3OSWfyOaX+23O4nAoz0girFwHJ93MbNR0
         Cuq4zL1sJYfiriIL8KguY33QiJoJdFvvQbE56mJIhFC743BUAevtvFK9P76XN2x2EBpS
         FNMTC/Nu3MYESDUoHnlzdgKa5XTdWAIRNQOb41oOy1pnruSBPHc2ZCB53sEB/2hjZlgI
         LdeKZdahd2+RIhyMloknQoSHnSllMHfVsVHUxxxQd2fuRbjgpFM6nbi/hoQ2fZhOblWw
         YRSCRV3p/VKnc/vVddGKk9ETG9yff/HbkGnte74j0eEziLZPJp1UT0Acs6HrzdO6HTPR
         YhGA==
X-Gm-Message-State: AOJu0YwetQ1AewjJ+tK2xm27dZtIecVEAW6NEmHbn2RR9hvxwjChcCAb
	ZrMx7dgmLdOWHZ+vI94JxJ6IY96e5vXQhNLEvgxu0MhytjfKEJ1x
X-Google-Smtp-Source: AGHT+IEhHcNNttkVzg/yTfF7aMgmFq+lvHt1K4ulGdRuFJbn4EMBcoAWXnIiyS1gsRwCIhgJ2fEClA==
X-Received: by 2002:a5d:6506:0:b0:355:1ad:90d3 with SMTP id ffacd0b85a97d-3552fde1914mr6132280f8f.55.1716819480544;
        Mon, 27 May 2024 07:18:00 -0700 (PDT)
Received: from syracuse.iliad.local (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35579d7db97sm9133056f8f.24.2024.05.27.07.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 07:18:00 -0700 (PDT)
From: Nicolas Escande <nico.escande@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: mac80211: mesh: init nonpeer_pm to active by default in mesh sdata
Date: Mon, 27 May 2024 16:17:59 +0200
Message-ID: <20240527141759.299411-1-nico.escande@gmail.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With a ath9k device I can see that:
	iw phy phy0 interface add mesh0 type mp
	ip link set mesh0 up
	iw dev mesh0 scan

Will start a scan with the Power Management bit set in the Frame Control Field.
This is because we set this bit depending on the nonpeer_pm variable of the mesh
iface sdata and when there are no active links on the interface it remains to
NL80211_MESH_POWER_UNKNOWN.

As soon as links starts to be established, it wil switch to
NL80211_MESH_POWER_ACTIVE as it is the value set by befault on the per sta
nonpeer_pm field.
As we want no power save by default, (as expressed with the per sta ini values),
lets init it to the expected default value of NL80211_MESH_POWER_ACTIVE.

Also please note that we cannot change the default value from userspace prior to
establishing a link as using NL80211_CMD_SET_MESH_CONFIG will not work before
NL80211_CMD_JOIN_MESH has been issued. So too late for our initial scan.

Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
---
 net/mac80211/mesh.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index 3d4806b7ff6c..1d8aebd0eff7 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -1792,6 +1792,7 @@ void ieee80211_mesh_init_sdata(struct ieee80211_sub_if_data *sdata)
 	ifmsh->last_preq = jiffies;
 	ifmsh->next_perr = jiffies;
 	ifmsh->csa_role = IEEE80211_MESH_CSA_ROLE_NONE;
+	ifmsh->nonpeer_pm = NL80211_MESH_POWER_ACTIVE;
 	/* Allocate all mesh structures when creating the first mesh interface. */
 	if (!mesh_allocated)
 		ieee80211s_init();
-- 
2.45.0


