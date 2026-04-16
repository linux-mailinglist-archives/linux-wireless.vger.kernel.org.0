Return-Path: <linux-wireless+bounces-34868-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHtcE+Vr4GllggAAu9opvQ
	(envelope-from <linux-wireless+bounces-34868-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 06:56:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 568F240A3C2
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 06:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5972E30A5365
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 04:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A94133C51D;
	Thu, 16 Apr 2026 04:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o567LVTu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DB0199E89
	for <linux-wireless@vger.kernel.org>; Thu, 16 Apr 2026 04:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776315353; cv=none; b=Dp9afDfgBSFq1lc4JY9ZqstomSvHG1cRFP/gi9eEqLm2Or3YIDKDHtttnAkywCBvzdhCwtzs+QlTcXgXk18WMDz3dNVN7kBAiQn2m5gnvUyu6T3GvKN3hxXInRI2Trb8MrTju7KKIs/Dx4j9ieFs8bOpC/vg6Vv1a+RubZijDFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776315353; c=relaxed/simple;
	bh=jauk6e9BJvBYX00zsKakv1BPdImGP5ebGlP113D2KLk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OgR+kG9TAY1Mn6I0ZfMpToQnMBvaLULFFlo/M+ZyaXnOyPKc4KYRdjmm3TMrCmbalSYFM54psJdGQyKGNKxu5mZgpB0/+KL+vOifoWwMxLdwwbU8v8Z7J33jZnR7slIZEWiPV90JRiMhbkJa0N/mCE/blEs1OXrkYdyinUjXbDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o567LVTu; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488ad135063so73332995e9.0
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 21:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776315350; x=1776920150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ikmjS0XG21cXkTZVtL70gUUBd8u+W9ZnDJv3a6pHenw=;
        b=o567LVTut+o+JpCr8pNxpFl6D2CDATJA1lJxvFsgZeE8qrx5ssmNOVNmCWw9XaRFRz
         J/pW4qTusxXZsAWzz7cxw4CCWK7/8RKMnXB1dw7EocDNxoAMesnzQb9oLDRvX8UgDPLB
         wQZF0Dy98fjHnc7YonDMjUGCbiE7Ep3xKvjB+SFjvZvG+BXJjg82h2j1fKERx3TBbiex
         WpxOCoZqENHy6M1httz5FrDujuxRpPuPwMLVIShvK+IOTGeSPiTeAzjlXNHl3B/WcWR4
         XOQ5ITQwEh+ELuxz0cC8D6R1rK7cVaj3bfDgea/OXymQodxGnyG5PLCCIHF3xQ2VVIEK
         tqZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776315350; x=1776920150;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ikmjS0XG21cXkTZVtL70gUUBd8u+W9ZnDJv3a6pHenw=;
        b=DSAbCcegFXyBHdwvVt2mUkRrZkUSTOGZfTzbAlUXCCXyAr33Hs9D6rpRS6cd1a6hMF
         7kX/DxmkH5/DS2+jyDAWHAzqt1YdyKdZDASN4H6tC/vGBFD79kq5eSXO3+wWWFsECkqq
         /rJPFHFgzYDpPW2+HFUAuK9I/hajgOgzo4gg61Kzgzz05q1F0Q/f2a0H91jwiq+Jgq2+
         YFqbkZDPqm9TFAUBRKf//yp9CNwZCLnJLlnslgvpjpWowbg8LrqmsF3Tk2KoyhPRVqvw
         oqSwJJqdHQ8Pd5vykO6MkZZ8YGRgWJeUUxla2XHTj7Cw0OZXJliqarYN7vy/dznnMHdx
         IqJg==
X-Gm-Message-State: AOJu0Yzswitjg5faZAlc1QNwZrdQYJfAssiaZs1kZBs16luWUuSkT/9C
	l2zC36MpoUKUNfD4Mmy2NBZtIqZKo5re6t8fDU0yiJr9YI+pMUvueoyJ
X-Gm-Gg: AeBDietjXPWMnsVJpn8e83XlYKKwUdGZLjzhttueYNjS8p+rchAugG0thhVYnlYShhV
	On2X5iiwdgHgdHmai1Fy9ZcDeLeWbNJDwy6V9R3DWQUtgrGmGkoCbuOfo0URtcuv5KXYdqFcI3I
	FBYPgOkkm3ogOXuURXsAJ0sOR6PjZ1gxoxZ1JDaqkssQWDy5kSt2yxhvLMZi8p9gtzR+OzT5NrZ
	5T4Sa9NyyKrKPrbIu5s+z7hwsnAlE/jKRt4Vs4EKHBJcbMGEj2O6CcvkLF4AVRjWGS7JXuOhhol
	fsTwNJp9onDwLXrfCuQ+0LByQlaCIKLR2QG3hthDN0S0l7/gtTQizxf6a8Ya/tHlSN5l9qGE2oa
	+Hg5lgzPdPQ5TcRoMg4YWh1CiCLhtWJTKxdjKjwYKXumeXUU36OQxAWWZkaCzhRnjEvY+M83lVH
	BQXzwdUHOY1HU6/+zPU3NmmKT63fSb2HVDhsc3bjZlstfNjFFI8FtIZRb7qs96+ohDOy7H
X-Received: by 2002:a05:600c:c0dc:b0:47e:e076:c7a5 with SMTP id 5b1f17b1804b1-488d68105d2mr233254355e9.11.1776315349678;
        Wed, 15 Apr 2026 21:55:49 -0700 (PDT)
Received: from bazzite ([102.128.175.252])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f58236bcsm21046875e9.12.2026.04.15.21.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 21:55:49 -0700 (PDT)
From: Louis Kotze <loukot@gmail.com>
To: pkshih@realtek.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rtl8821cerfe2@gmail.com,
	lucid_duck@justthetip.ca,
	Louis Kotze <loukot@gmail.com>
Subject: [PATCH v3] wifi: rtw89: phy: increase RF calibration timeouts for USB transport
Date: Thu, 16 Apr 2026 06:55:36 +0200
Message-ID: <20260416045536.817930-1-loukot@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34868-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,justthetip.ca];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN_FAIL(0.00)[10.253.234.172.asn.rspamd.com:server fail];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[loukot@gmail.com,linux-wireless@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 568F240A3C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

USB transport adds significant latency to H2C/C2H round-trips used
by RF calibration. The existing timeout values were designed for PCIe
and are too tight for USB, causing "failed to wait RF DACK",
"failed to wait RF TSSI" and similar errors on USB adapters.

Apply a 4x timeout multiplier when the device uses USB transport.
The multiplier is applied in rtw89_phy_rfk_report_wait() so all
calibrations benefit without changing any call sites or PCIe
timeout values.

The 4x multiplier was chosen based on measured data from two
independent testers (RTL8922AU, 6GHz MLO and 2.4/5GHz):

  Calibration   PCIe timeout   Max measured (USB)   4x timeout
  PRE_NTFY           5ms              1ms              20ms
  DACK              58ms             72ms             232ms
  RX_DCK           128ms            374ms             512ms
  TSSI normal       20ms             24ms              80ms
  TSSI scan          6ms             14ms              24ms
  TXGAPK            54ms             18ms             216ms
  IQK               84ms             53ms             336ms
  DPK               34ms             30ms             136ms

Tested with RTL8922AU on 6GHz MLO (5GHz + 6GHz simultaneous):
25 connect/disconnect cycles with zero failures.

The 4x multiplier was also verified under adverse host conditions
on 5GHz. 5 cycles per scenario, stress-ng as the load generator,
max observed time per calibration:

  Calibration  PCIe  4x   Baseline  CPU stress  Mem stress  Combined
  PRE_NTFY       5   20     0         0           0           1
  DACK          58  232    71 (!)    71 (!)      71 (!)      71 (!)
  RX_DCK       128  512    23        22          22          23
  IQK           84  336    53        53          53          53
  DPK           34  136    23        23          26          23
  TSSI          20   80     6         9          14           9
  TXGAPK        54  216    16        16          16          16

Legend: (!) = exceeds PCIe budget but within 4x budget.

Two observations from that matrix:

1. DACK exceeds the stock PCIe budget (58ms) in baseline on 5GHz
   on this hardware. Without the 4x multiplier, DACK fails
   -ETIMEDOUT deterministically on every connect, no stress
   needed. This is the condition the patch addresses.

2. Calibration times appear dominated by USB transport round-trip
   latency rather than host load, though hardware and external
   component factors may also contribute. DACK stays at 71ms
   across all four scenarios. Host-side stress has essentially
   zero effect on observed calibration duration. Bumping the
   multiplier above 4x would not address a failure mode that
   this stress matrix produces.

Reported-by: Devin Wittmayer <lucid_duck@justthetip.ca>
Link: https://github.com/Lucid-Duck/rtw89-usb3-gap/tree/main/evidence/crash-2026-04-11
Signed-off-by: Louis Kotze <loukot@gmail.com>
Tested-by: Devin Wittmayer <lucid_duck@justthetip.ca> # RTL8922AU (BrosTrend BE6500)
Tested-by: Devin Wittmayer <lucid_duck@justthetip.ca> # RTL8852AU (D-Link DWA-X1850 A1)
Tested-by: Devin Wittmayer <lucid_duck@justthetip.ca> # RTL8852AU (D-Link DWA-X1850 B1)
Tested-by: Devin Wittmayer <lucid_duck@justthetip.ca> # RTL8852BU (BrosTrend AX4L)
Tested-by: Devin Wittmayer <lucid_duck@justthetip.ca> # RTL8852CU (EDUP AX5400)
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
Changes since v2:
  - Reword commit message per Ping-Ke review: remove v1 reference
    from permanent changelog, use "condition" instead of "bug",
    acknowledge hardware factors in calibration timing rather than
    asserting I/O bound.
  - Add Tested-by tags from Devin Wittmayer across 4 chipsets
    (RTL8922AU, RTL8852AU, RTL8852BU, RTL8852CU) on Framework 13 +
    Fedora 43 (6.19.11) and Raspberry Pi 5 + Pi OS (6.12.47).
  - Add Reported-by for independent confirmation including xHCI hard
    lockup evidence (CPU5 deadlock in usb_unanchor_urb after DACK
    timeout triggered driver recovery).

v2: https://lore.kernel.org/linux-wireless/20260415111339.453602-1-loukot@gmail.com/
v1: https://lore.kernel.org/linux-wireless/20260410080017.82946-1-loukot@gmail.com/

 drivers/net/wireless/realtek/rtw89/phy.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index e70d0e283..1f249c297 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -3956,6 +3956,14 @@ int rtw89_phy_rfk_report_wait(struct rtw89_dev *rtwdev, const char *rfk_name,
 	struct rtw89_rfk_wait_info *wait = &rtwdev->rfk_wait;
 	unsigned long time_left;
 
+	/*
+	 * USB transport adds latency to H2C/C2H round-trips, so RF
+	 * calibrations take longer than on PCIe. Apply a 4x multiplier
+	 * to avoid spurious timeouts.
+	 */
+	if (rtwdev->hci.type == RTW89_HCI_TYPE_USB)
+		ms *= 4;
+
 	/* Since we can't receive C2H event during SER, use a fixed delay. */
 	if (test_bit(RTW89_FLAG_SER_HANDLING, rtwdev->flags)) {
 		fsleep(1000 * ms / 2);

base-commit: 1e33ef7657531b2361d53cca25f375b5626e76a9
-- 
2.53.0


