Return-Path: <linux-wireless+bounces-26919-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF700B3F36E
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Sep 2025 06:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FEDC1883373
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Sep 2025 04:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7590271448;
	Tue,  2 Sep 2025 04:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTiOXP7A"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E34D33991;
	Tue,  2 Sep 2025 04:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756786213; cv=none; b=BeOkGrWWxQyDMNFA/Zx1X1noYOtOqY16G3Y7iJG9pkRSbjmcpUbLJD9DTmrDVUU6uGhL1dYRGxzZP0MDE93GdQiNSFwkskvlRx3nqS7/pLn2Y6G7q0DDZfVBDv2MP4qg4aJNAoMcMgfHUqb+S61/e+lKjCXHdUvD0ZsaQPd3DIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756786213; c=relaxed/simple;
	bh=vpfYScOjakMNy+nGuXLIrD0EA6DhL55xUbZ8RW8gSgI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g8MbUoXWhUmx7X2uJT8hRUDkZce5bKFw40RdCnxFMG7MEWyseTikX5YyBzvnb0LvDWo/UCYnbslc2fc13Qwd9j42YkNTg35byMDGnLMPy6BDOLk71dqir2ZCH/sd3Ez025ZDmcZsEBQnLaQF1oU0HYalm6Su6G8Cwvf2OIH5XsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CTiOXP7A; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-24b13313b1bso2795705ad.2;
        Mon, 01 Sep 2025 21:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756786212; x=1757391012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=19JVbPSSMfi36C+z91aIsE+9NN7e/Je8JVocDDvdxI8=;
        b=CTiOXP7A4gDhvWCJ++L/CCx2fT6sPbN7zuHm1pylic6CIKgKwTgQV6P49TeT424q6d
         tIsWoy9CaB5oLZWFCdBdLZAWDClcX2VUC11fbph7HE7CIbfSBklMeRIm1Qg9jV4YoVAJ
         96g87IvhoRLvdodPWZ/HWip050/68apOpOR3gwSNdSsy3uR/fpRx9ZF+TW1pmx62vEul
         0ItoM40QlfGCs66CVJRSSKpu8HpZBsqoR2tzB8FSbr90jWTP28msTSUF3lr4RV5jYz9P
         OKIb+sziRWnAFI1Sv55iDI/1n1rJiY/zGdPtSzbyD3Q7sImPQ90nervno26L3VAnu5y0
         2wGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756786212; x=1757391012;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=19JVbPSSMfi36C+z91aIsE+9NN7e/Je8JVocDDvdxI8=;
        b=KRZedel0oof2n4y52MciTQ5o8qJ9q+Oe5KsdZX9f9czY63W2QYldiPl400V3dI/zgK
         OzokEmIVf4siwDDtMvQA0Vx518fNn2M7KRM8wnB9+1D9et6bYo+wYe195V1fDF0PI/EQ
         PQZjIr1SsjQo4pyHn8wb4hPzbqpGO5yuGDn6KpCZER9d82+YXA9HRSgK4qDmLwTC6WPt
         DrTqwDPZYn+Ec6stbgs8O14yeF//f/6Y+JovKi/I7UAB6Tqkhv/v2E7H1TOCAiiilyRY
         vuEwECA+ctGW0GrMrb/pkiKRWYk5fbmytjoGEr2gS2YE964ZspqNMPpgn7XUAozZ/UaR
         g6sA==
X-Forwarded-Encrypted: i=1; AJvYcCULVNztYoUvsqRqeK3nbZJYQ++ZK1NKF0WA1L6PxiRbm1whTn+ME4WaRdqz8whJzHHITWFyoTKeCtwVnfh25hE=@vger.kernel.org, AJvYcCW7ES5MpvAasPNbR1EkODpMEB7y7MNfXXwjQ0na8wk8nKGjrsehxg7eid5KBuz9yy59P8lSgCms@vger.kernel.org, AJvYcCWNqOeOAOgHam9OawGYZ3BP4dvxyHdPgcaVopnIwRuzrGEOSiIKopdHY+EGf2oRarvl2NgUUk8cLPVOFc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCNuoflz8DqeN7phNjbLhNEjb9HxbUBByk7Cy/vYe9UAChDMcY
	9vrif80ad78SGaWXQ28ywcENqNiPT8fYF6p2KdV6bqC1S7vIGW/Gn5m9
X-Gm-Gg: ASbGncsL9GBXi3l/2/gOfy3PZaxsfXwIOkv+gRBrVVx0urw+/QoXCxfR86KTWhcNm0e
	4ICyCIkZO/PLY7lRmFFmxealEtxwr/YfSBnNrTTnLEiWzP3a5q9ncM+ni6LHBDF8Ai9DgxD4Z8D
	i6choaN6VQE3XWzyUoKDVdVOXRXUbgEWRP07K0nquFiGinR8YDcqN7jnVFm/LkY4+pnRlQQya01
	jOxBuEyjdfFWI/NNJQVpBEfdoOdoir5fz62PjrADTCNSW2FyF1Q1/V7PDUjFc46CvZ2OzYp6Ytg
	1C9N+KH7gjVgLGnkrFwppTWZg1N/ZWEdQIp6fqdazWc7P6PubHNzfg5yRyhZuzrDjrZBoAj4kII
	4soFAM7E5J90J7H4dwfWYzT4Jd0MHdXFvxSf1QpbisJr/IotUAtOdpo6gelZIyA1bb2DJ8Qnalb
	JC2kkF1SrTXhWPAPZm1uW2eYwdI/b+4kkgo1uPk49RuGZt1YvSMtbNa1M=
X-Google-Smtp-Source: AGHT+IHqWZSv9fVE2o9FpNUE/zchbO0kWXsmmJcbNEZcGV9RobrVJC1W6rztHbdML4czeSNJPdZUSQ==
X-Received: by 2002:a17:902:e745:b0:246:e1f3:77b2 with SMTP id d9443c01a7336-24944b65071mr121741105ad.53.1756786211765;
        Mon, 01 Sep 2025 21:10:11 -0700 (PDT)
Received: from vickymqlin-1vvu545oca.codev-2.svc.cluster.local ([14.22.11.165])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-24af84de7a4sm21250635ad.7.2025.09.01.21.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 21:10:11 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Avraham Stern <avraham.stern@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Rotem Kerem <rotem.kerem@intel.com>,
	Daniel Gabay <daniel.gabay@intel.com>,
	Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] wifi: iwlwifi: Fix dentry reference leak in iwl_mld_add_link_debugfs
Date: Tue,  2 Sep 2025 12:09:49 +0800
Message-Id: <20250902040955.2362472-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The debugfs_lookup() function increases the dentry reference count.
Add missing dput() call to release the reference when the "iwlmld"
directory already exists.

Fixes: d1e879ec600f ("wifi: iwlwifi: add iwlmld sub-driver")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/debugfs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
index cc052b0aa53f..372204bf8452 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
@@ -1001,8 +1001,12 @@ void iwl_mld_add_link_debugfs(struct ieee80211_hw *hw,
 	 * If not, this is a per-link dir of a MLO vif, add in it the iwlmld
 	 * dir.
 	 */
-	if (!mld_link_dir)
+	if (!mld_link_dir) {
 		mld_link_dir = debugfs_create_dir("iwlmld", dir);
+	} else {
+		/* Release the reference from debugfs_lookup */
+		dput(mld_link_dir);
+	}
 }
 
 static ssize_t _iwl_dbgfs_fixed_rate_write(struct iwl_mld *mld, char *buf,
-- 
2.35.1

