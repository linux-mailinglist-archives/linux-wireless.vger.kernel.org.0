Return-Path: <linux-wireless+bounces-23611-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9673FACD258
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 03:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F8DA16A946
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 01:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D116F1E1A05;
	Wed,  4 Jun 2025 00:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2dN6TdD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D261A3029;
	Wed,  4 Jun 2025 00:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748998641; cv=none; b=THMyRxGgGVq4g5kVjr+zWiSiVbnPSzgzlYiBFAkQUbQwBZeFc8aVE98Q5PIQbkXTr+Bh4T95ECkBwMjcbWumI+ZnA+5zDYKzIlJvS1hDHI4TY9YZqw+aFBWxjtSTWk+4AQXCogAY8/btzAUU+L+9pkRiL/EtAg+wcgcwi09x+EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748998641; c=relaxed/simple;
	bh=aeXbskdEN6FTZKMfgECBMayTttfp/K77bjuf5/4uUTA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OcKlKJ8wUZeEpYJgBcIO63r0a1R7Aa4ADJAUND8HoF8J9IVYYUUuOJ/wEB3kc4YbzJhfWRhK1inNejl7mp2fivj6s89aJJAe9mA28LKHEPzI1FxW+I9Z+NTVMv9Yv9yFKpiKhVWfe6Gqrc+5dKV4SEHPJZ9o95sUx78LzXTqy/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2dN6TdD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD1D2C4CEEF;
	Wed,  4 Jun 2025 00:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748998641;
	bh=aeXbskdEN6FTZKMfgECBMayTttfp/K77bjuf5/4uUTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J2dN6TdDlr8kVRYbusCGRlPe7wGpW8XBrwgymwwS32SGKabR7n2khmMa0txpc7nzt
	 RXloF3+HXXn91tSugWG43BU+ghWQnxqi7nBCmdmswAhEgg3WuUSd/y3bZysC9idowq
	 KrRmfiml0wIDnbCAC+Tn93A7qTkonPMGB5/V3m/EwOw/vjUeOMIIwYc8gYjNDjbf0P
	 zGFjiDa8/6HempQDBoYGCgGpyKTNPm2QLijzjXaaoMKvzrOqHI08GM1FsgZyLa4/ic
	 rh777CvP6stLSgrnQHnvDo7DKLsOxc50kSzmJ+ZJDnPD5rYXKW86Bu5oqAfn7ycZDQ
	 0Qtd2eE/u1MIQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Yuuki NAGAO <wf.yn386@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 052/108] wifi: rtw88: rtw8822bu VID/PID for BUFFALO WI-U2-866DM
Date: Tue,  3 Jun 2025 20:54:35 -0400
Message-Id: <20250604005531.4178547-52-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250604005531.4178547-1-sashal@kernel.org>
References: <20250604005531.4178547-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Yuuki NAGAO <wf.yn386@gmail.com>

[ Upstream commit b7f0cc647e52296a3d4dd727b6479dcd6d7e364e ]

Add VID/PID 0411/03d1 for recently released
BUFFALO WI-U2-866DM USB WiFi adapter.

Signed-off-by: Yuuki NAGAO <wf.yn386@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20250503003227.6673-1-wf.yn386@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

Based on my analysis of the commit and comparison with the similar
commits provided, here is my assessment: **YES** This commit should be
backported to stable kernel trees for the following reasons: ## Analysis
**1. Hardware Support Addition**: This commit adds VID/PID 0411/03d1 for
the Buffalo WI-U2-866DM USB WiFi adapter to the rtw8822bu driver. This
is a straightforward device identification addition that enables
hardware support for users who have this specific device. **2. Code
Changes Analysis**: The change is minimal and extremely low-risk: -
**Single line addition**: Only adds one USB device table entry at line
80-81 in `/drivers/net/wireless/realtek/rtw88/rtw8822bu.c` - **No
functional code changes**: No modifications to driver logic, algorithms,
or behavior - **Standard pattern**: Uses the exact same pattern as all
other device entries in the table - **Reuses existing hardware
specification**: Points to the same `rtw8822b_hw_spec` used by other
8822bu devices **3. Comparison with Similar Commits**: - **Similar
Commit #1** (Status: YES): Removing incorrect VID/PID had `Cc:
stable@vger.kernel.org` and was backported - **Similar Commit #3**
(Status: YES): Adding missing VID/PIDs for 8811CU and 8821CU had `Cc:
stable@vger.kernel.org` and was backported - **Similar Commit #5**
(Status: YES): Adding Buffalo WLI-UC-G450 device had `Cc:
stable@vger.kernel.org` and was backported **4. Buffalo Device
Pattern**: The git history shows Buffalo devices with vendor ID 0x0411
are commonly supported across multiple rtw88 drivers (rtw8812au.c,
rtw8821au.c, and now rtw8822bu.c), indicating this is a legitimate and
expected device addition. **5. User Impact**: Users with this specific
Buffalo USB WiFi adapter will have working WiFi support instead of non-
functional hardware. This fixes a user-visible issue where the device is
not recognized. **6. Stable Tree Criteria Met**: - ✅ **Important
bugfix**: Enables hardware support for affected users - ✅ **Small and
contained**: Single line addition, no behavior changes - ✅ **Minimal
regression risk**: Cannot break existing functionality - ✅ **Confined to
subsystem**: Only affects USB device identification in rtw88 - ✅ **Clear
benefit**: Enables WiFi functionality for specific hardware **7. Missing
Stable Tag**: While the original commit lacks an explicit `Cc:
stable@vger.kernel.org` tag, this appears to be an oversight given that
similar commits in the same subsystem (commits 0af8cd2822f3 and
b8a62478f3b1) included stable tags for nearly identical device addition
changes. The change is essentially risk-free as it only extends hardware
compatibility without affecting any existing code paths or device
support.

 drivers/net/wireless/realtek/rtw88/rtw8822bu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822bu.c b/drivers/net/wireless/realtek/rtw88/rtw8822bu.c
index 572d1f31832ee..ab50b3c405626 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822bu.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822bu.c
@@ -77,6 +77,8 @@ static const struct usb_device_id rtw_8822bu_id_table[] = {
 	  .driver_info = (kernel_ulong_t)&(rtw8822b_hw_spec) }, /* Mercusys MA30N */
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x3322, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&(rtw8822b_hw_spec) }, /* D-Link DWA-T185 rev. A1 */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0411, 0x03d1, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8822b_hw_spec) }, /* BUFFALO WI-U2-866DM */
 	{},
 };
 MODULE_DEVICE_TABLE(usb, rtw_8822bu_id_table);
-- 
2.39.5


