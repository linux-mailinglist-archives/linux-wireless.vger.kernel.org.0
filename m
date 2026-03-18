Return-Path: <linux-wireless+bounces-33399-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGvPLHHAumkGbgIAu9opvQ
	(envelope-from <linux-wireless+bounces-33399-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 16:10:41 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 356CD2BDE56
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 16:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2023C31F3F6E
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 15:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405723DFC91;
	Wed, 18 Mar 2026 15:03:13 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3F43DDDC3
	for <linux-wireless@vger.kernel.org>; Wed, 18 Mar 2026 15:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773846193; cv=none; b=VlL/53g38FOntvW5xEdayOhu6aZnvocZM8fonRzq7y/2k2V9HtbD2Vl84fQMvN6MMPiXJLw8uqO29IbdZlIgnGHO8iprtJYXlvGG4oiB5OO7PH949QFZdm0HC5PwmnkUS3m67fniQBhSqrvFgusZekd5djxXSJmAxRL09LplHW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773846193; c=relaxed/simple;
	bh=h0p10z8eZpClUXYtUVukCJgrHGYSRkh1nSA6pgFkCig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZxIfpjsrZokGbnZC+cgUntjSohZzc1Ah5GbflyroSAJ65sbFAXqYkUPzcG4zA1NZvV14+V3iIi8PbwcnJrD1y0lf1cMvklyzYYMZbItCV1h5zkP7qPT+A8oUjFURQ9Uh4Y+gLeqy3otlcPa8Hx/Ia+dk4ffSMmvO/lxl9hhyKVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-127380532eeso191860c88.1
        for <linux-wireless@vger.kernel.org>; Wed, 18 Mar 2026 08:03:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773846190; x=1774450990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bCbPYXsJyjrslfVQf+TqWui1no/uksX6ojvJaHIhI9s=;
        b=ZAVnvkk2Kl9SVPK4DNLgclf7jWmup+DJWeB8viq+wikPqaeQhIkFXGkiGzD9YVOuUi
         o8g4LlnwwZ6AvuE9tRN+QCLGgmuhrZ7H9SfqZAJ08sakoCfLuEycUk7XjkXDKEM9J2lZ
         +JgiSweGNWYEySnGywsQWoLi+NXSUS9nmw304rGPDdgjG5VQ+2Q67F5qWuf6gsrMAdRH
         XLFx0n808uu8Yti6CEJlofnzDQaDtCNoDNJMvT5YU9+Frq9tbjAXgK1D27auflBZSUr0
         Ulse1zCxYmJe3N2a3dYyoqog3734lPHy4rhujM8CchuRhh89Vh+mf1tRJAnP8YlWmFaa
         U3wQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBhxIm1FUomhuv2Dn/QfGEwtmBAessc+7X6BPosOpmWlcM5BPSMmq2CWg/D2Sp1H32cGu+CJ4Ew+kl05Xzlw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwmssxHo1Z5NkEsp/dX4gFXu4DzUv2J0N6y2GjKD8kYLWRJbTkV
	d67wcY5FFxI+zZU8SrwhR8Yh5QBt74mp1qgXMhrDeLTaBLVi4NGNps8=
X-Gm-Gg: ATEYQzyxwrztuewobAnDL6o7+eyoUpceRbZXqJreThONNdNo90cozrk3fxlVmHZn2Fn
	naUzh1K0Vlt3hCUISm8iIIT8Kin4Z7D30SWlp7DjqZbdwHj58tgoZg/G4Lj20KZwaYYsScKDku+
	2brUjAqDurslBV+A116CRjxrTRRoZVYx/fvaY4a9SZgf4HtghcZKI1ZZDjq/mLvDuVqahEi/Fn5
	fr37S22I4cI1X0ChqHQa97GguN2jjcim97XAbxQuP7+aRPb67g4yh+Lr9V2UJQovGOn6utuT5dP
	PgY2nJ/LycOkmRH2QBzGsfVpIBXokttYUh/h9w7IOhADRH5MVqMtjyT5Sa/igoJiN3FFAbpERjY
	NMisDwaE1e97qZCfxkB6giiyVnUqEDkS/rSw/EXuIBRaFE3kBiudz2Xqy5SwjYowPGFR2HQIKgh
	2k5aX5PuiMpmd3pGD+iRJQvk92vv4f4WBtBWpCqFhdNjXXZb7fZaAWCShC3QH4J7D3gk2dIQYwK
	q7AcmL//wForahcyg==
X-Received: by 2002:a05:7022:6a5:b0:122:153:d161 with SMTP id a92af1059eb24-1299ba3e35fmr1920293c88.17.1773846189957;
        Wed, 18 Mar 2026 08:03:09 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-129b413930esm3529158c88.13.2026.03.18.08.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 08:03:09 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	andrew+netdev@lunn.ch,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	alexanderduyck@fb.com,
	kernel-team@meta.com,
	johannes@sipsolutions.net,
	sd@queasysnail.net,
	jianbol@nvidia.com,
	dtatulea@nvidia.com,
	sdf@fomichev.me,
	mohsin.bashr@gmail.com,
	jacob.e.keller@intel.com,
	willemb@google.com,
	skhawaja@google.com,
	bestswngs@gmail.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	leon@kernel.org
Subject: [PATCH net-next v2 02/13] wifi: cfg80211: use __rtnl_unlock in nl80211_pre_doit
Date: Wed, 18 Mar 2026 08:02:54 -0700
Message-ID: <20260318150305.123900-3-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318150305.123900-1-sdf@fomichev.me>
References: <20260318150305.123900-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33399-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[fomichev.me];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,lunn.ch,broadcom.com,intel.com,nvidia.com,fb.com,meta.com,sipsolutions.net,queasysnail.net,fomichev.me,gmail.com,vger.kernel.org,lists.osuosl.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sdf@fomichev.me,linux-wireless@vger.kernel.org];
	NEURAL_SPAM(0.00)[0.394];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	RCPT_COUNT_TWELVE(0.00)[35];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fomichev.me:email,fomichev.me:mid]
X-Rspamd-Queue-Id: 356CD2BDE56
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

nl80211_pre_doit acquires rtnl_lock and then wiphy_lock, releasing
rtnl while keeping wiphy_lock held until post_doit. With the
introduction of rx_mode_wq and its flush in netdev_run_todo, calling
rtnl_unlock here creates a circular lock dependency:

  Chain exists of:
    (wq_completion)rx_mode_wq --> rtnl_mutex --> &rdev->wiphy.mtx

   Possible unsafe locking scenario:

         CPU0                    CPU1
         ----                    ----
    lock(&rdev->wiphy.mtx);
                                 lock(rtnl_mutex);
                                 lock(&rdev->wiphy.mtx);
    lock((wq_completion)rx_mode_wq);

Switch to __rtnl_unlock to skip netdev_run_todo in nl80211_pre_doit.
This seems safe because we run before the op.

Link: http://lore.kernel.org/netdev/69b5ad67.a00a0220.3b25d1.001a.GAE@google.com
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 net/wireless/nl80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 2225f5d0b124..ce5f25d4c87e 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -18192,7 +18192,7 @@ static int nl80211_pre_doit(const struct genl_split_ops *ops,
 		__release(&rdev->wiphy.mtx);
 	}
 	if (!(internal_flags & NL80211_FLAG_NEED_RTNL))
-		rtnl_unlock();
+		__rtnl_unlock();
 
 	return 0;
 out_unlock:
-- 
2.53.0


