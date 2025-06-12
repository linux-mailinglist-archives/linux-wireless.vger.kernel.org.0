Return-Path: <linux-wireless+bounces-24033-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB02EAD67D4
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 08:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E4C67A2F47
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 06:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20FF1D7999;
	Thu, 12 Jun 2025 06:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="TqpJ+qCH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110A11EB1BF
	for <linux-wireless@vger.kernel.org>; Thu, 12 Jun 2025 06:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749708988; cv=none; b=nxPRE7raSADFpMYfYnA4WB+uQmkUSlYMjZqF95nJcgudA2hlvOWGyt3UyGK729Cl8lFrkH+yLn+mglek+Van+O4IIXCPWbCtO9kyetdoBVjvydTwTf8RcWB8hmrlGVrh5fEdIWesYA7P7yTA8Ejw6G8CE8Io65VyHwNfuS5LJgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749708988; c=relaxed/simple;
	bh=kmYwNOfZYNiauWbtvqa6oli6QU+Z8hXUpPbkLQJ/9v4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CqKY3noIYYQokn5BvSujr+4qqXi5mtrIfYyNYHZ2801f6I4WxYaNc/E5A0MhRRQwNoCbLSlR7wngRg1jtdPRRFnFZZaKK3qCjQRtBqzbYCpmP5Dvisto5yvR7jnMhB2lkUU9vg3LU5xKvE9dfLL7jJ4X0KcgKc8TbfmuJVPqEgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=TqpJ+qCH; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-450cf0120cdso4248145e9.2
        for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 23:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1749708985; x=1750313785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ScgjUpaPfHbqDIMCPtaXg6Ano9ZrKG6mzFmgIhysYwY=;
        b=TqpJ+qCHviRY/tAqZshG/4rp+CJpoRGKhsj3BRsqsVg9lrTcxCBybe6kLmwoVTaNef
         tQ1fNhrl6Jeda6epcjOn4O9bFlQAJZ/f/TNak1QJ7la4ibpiKoUDmCYhbnwXyi2M/8Um
         n5ZazGKmE/7kfZ2EsYOFX+dUQcZAmStc1NPG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749708985; x=1750313785;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ScgjUpaPfHbqDIMCPtaXg6Ano9ZrKG6mzFmgIhysYwY=;
        b=IvSGu+wTbufQtZEUIIx3rlasevOX3whJhFB5yWUKw3WGjtfYg2BRrQH8IfaUE8LYqG
         7MG6q+nPfKTz8VznKXBGMiTTxqJK1/xkr7+eFBvXw7ypfhY8dRNLb2dzFo/Hrmc6gLay
         GywSXr+zhu59tTqWrc3rl21z+zSu5cQH/hmz/qh163gKkyBT+0D3t9c7SxYIaKJZOwf1
         tCH+AW754DjdIwDTcOsJTo/MEJZHfi/kEOoN12lpQKAz3gUM/tEsSrSFTXkRk5raxqXP
         7qStCYvxzOX0C7R+++XW2arA2emHla30zLzfFwez0CwB1OGItOfFp92KP4d5ccN/rT+p
         CQWA==
X-Forwarded-Encrypted: i=1; AJvYcCWSKc91+P+XCB1qedhgEVE+c8QM2Ctw41/+ypNGJMyuRbt9cwlPs2WIvpV4o/wh0gk20F+jgHTEIknbpie7TQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxhM1NM6UVk5EPKm9VpNYGUKXMKUoaWnmG6o7xR7peks0Gy0BCE
	uh/Sioq5scxgWQXlyXAZBrTTZua0tpzKMoHBX7VujhrBN2d+cpma1ihyq1PXCb1pbP4=
X-Gm-Gg: ASbGncsyW6O1GEC6p1CtLyP87lwnoIryi4aH6Ap8EAobm7Ca5KLFX5+RBxbdr0HNikW
	QpJUUIDpL/leLQnPag3Qh9otlSZJT/EAXZdc2be5XesygKzS+T0m1yLi4yN4ByPoDB0kCOwYTaw
	QA2xz3q5UTdnwfGLSTK4knRKCM8Zk3+fSrSUaWj52h1uDJEUVtyxQN6ekyb5+woSRKO7Mw/6DFk
	gcyPjPuiiGKHloYuiUpHQ+4WY4uuCCB34mMfFxiKacUmQ15+X91JteEZEqC6htdgqCvnS8F1L1d
	zinH7fU5bsDVmvVVS6styiZniMH+GFkfQ9xYRZoThrTiUQK2gBlqP9FszDRF8J9K8LDwXZiyAYz
	7BWJx5bLYioynfQ==
X-Google-Smtp-Source: AGHT+IGm81iQMqozoNbGvUNa7Ii3Oga/QDuCjWZCS5lp+cWSAZ4nkHJS8aNtWeIEjp0Xmo8H09kLdA==
X-Received: by 2002:a05:600c:37c5:b0:442:faa3:fadb with SMTP id 5b1f17b1804b1-4532d2bd72dmr12505585e9.2.1749708985332;
        Wed, 11 Jun 2025 23:16:25 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6467:4426:b34c:fa23:a49e:c18c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4531fe840a3sm53716255e9.0.2025.06.11.23.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 23:16:24 -0700 (PDT)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-amarula@amarulasolutions.com,
	Michael Trimarchi <michael@amarulasolutions.com>,
	ath11k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Subject: [RFC PATCH] wifi: ath11k: Prevent sending WMI commands to firmware during firmware crash
Date: Thu, 12 Jun 2025 08:16:15 +0200
Message-ID: <20250612061619.22094-1-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set the ATH11K_FLAG_CRASH_FLUSH and ATH11K_FLAG_RECOVERY flags when the
host driver receives the firmware crash notification from MHI. This
prevents sending WMI commands to the firmware during recovery.
We want to prevent the laptop from freezing or becoming extremely slow when
its firmware repeatedly crashes while attempting to connect to a known Wi-Fi
network. This often happens with routers that intermittently fail to reconnect
until the access point is reset. While this solution doesn't fix the underlying
router issue, it would allow the laptop to select a different Wi-Fi network and
significant performance degradation during the recovery process.

[75795.712161] ath11k_pci 0000:02:00.0: firmware crashed: MHI_CB_EE_RDDM
[75797.738073] ath11k_pci 0000:02:00.0: wmi command 262145 timeout
[75797.738090] ath11k_pci 0000:02:00.0: Failed to send WMI_PDEV_OBSS_PD_SPATIAL_REUSE_CMDID
[75797.738101] ath11k_pci 0000:02:00.0: failed to set vdev 0 OBSS PD parameters: -11
[75800.746321] ath11k_pci 0000:02:00.0: wmi command 20488 timeout
[75800.746344] ath11k_pci 0000:02:00.0: failed to send WMI_VDEV_SET_PARAM_CMDID
[75800.746358] ath11k_pci 0000:02:00.0: failed to set vdev 0 dtim policy: -11
[75803.754345] ath11k_pci 0000:02:00.0: wmi command 237571 timeout
[75803.754360] ath11k_pci 0000:02:00.0: failed to send WMI_11D_SCAN_STOP_CMDID: -11
[75803.754371] ath11k_pci 0000:02:00.0: failed to stopt 11d scan vdev 0 ret: -11
[75806.762259] ath11k_pci 0000:02:00.0: wmi command 28684 timeout
[75806.762281] ath11k_pci 0000:02:00.0: Failed to send WMI_BSS_COLOR_CHANGE_ENABLE_CMDID
[75806.762294] ath11k_pci 0000:02:00.0: failed to enable bss color change on vdev 0: -11
[75809.770916] ath11k_pci 0000:02:00.0: wmi command 172035 timeout
[75809.770930] ath11k_pci 0000:02:00.0: Failed to send WMI_OBSS_COLOR_COLLISION_DET_CONFIG_CMDID
[75809.770938] ath11k_pci 0000:02:00.0: failed to set bss color collision on vdev 0: -11
[75809.770966] wlp2s0: associated
[75809.771051] wlp2s0: deauthenticating from a0:95:7f:45:e8:47 by local choice (Reason: 3=DEAUTH_LEAVING)
[75809.782908] ieee80211 phy0: Hardware restart was requested
[75809.782932] ath11k_pci 0000:02:00.0: failed to lookup peer a0:95:7f:45:e8:47 on vdev 0
[75812.842136] ath11k_pci 0000:02:00.0: wmi command 20488 timeout
[75812.842153] ath11k_pci 0000:02:00.0: failed to send WMI_VDEV_SET_PARAM_CMDID
[75812.842164] ath11k_pci 0000:02:00.0: Failed to set CTS prot for VDEV: 0
[75815.850227] ath11k_pci 0000:02:00.0: wmi command 20488 timeout

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>

---

 drivers/net/wireless/ath/ath11k/mhi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
index acd76e9392d31..af7ff4fc794de 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.c
+++ b/drivers/net/wireless/ath/ath11k/mhi.c
@@ -286,8 +286,11 @@ static void ath11k_mhi_op_status_cb(struct mhi_controller *mhi_cntrl,
 			break;
 		}
 
-		if (!(test_bit(ATH11K_FLAG_UNREGISTERING, &ab->dev_flags)))
+		if (!(test_bit(ATH11K_FLAG_UNREGISTERING, &ab->dev_flags))) {
+			set_bit(ATH11K_FLAG_CRASH_FLUSH, &ab->dev_flags);
+			set_bit(ATH11K_FLAG_RECOVERY, &ab->dev_flags);
 			queue_work(ab->workqueue_aux, &ab->reset_work);
+		}
 
 		break;
 	default:
-- 
2.43.0

base-commit: 0f70f5b08a47a3bc1a252e5f451a137cde7c98ce

