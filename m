Return-Path: <linux-wireless+bounces-34764-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJ4QMrxz32mFTAAAu9opvQ
	(envelope-from <linux-wireless+bounces-34764-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 13:17:16 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0784A403A8A
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 13:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 851CB3006B41
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 11:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD30034575A;
	Wed, 15 Apr 2026 11:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIRmn9GP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331D334C989
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 11:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776251635; cv=none; b=uFNV8rIkQimAvoy//9jkVKu/EVatHQGEKxQTFZEIt8+0qOf1WvrFEMp8otOOhyTX5X7C8nKWS+mBlhvJFy/0xlvA0nZW/Jwhw+Kn7/1uHGrBtlh0Yw9gdYQaVQtRaTYCxLNFUljyGE7UtlVTEgGkxwprkBb4KLl18fL6YN3BGY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776251635; c=relaxed/simple;
	bh=+WmQBag2xKG2Gx7djYJ7iyEhZicjNmTbO6K5EBS12tQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JJpxQ2QRN20vOjQrpmxZGPuCh2MKBUDZeDNXdzOlr7NXZEiH2n/iUg8AOi0pB9hpg0tYtCpA6Fl53WHMoEyN2MdFS2b0WCXOcj9hnBeHClmCOvge4+b+2bEQvbyHwFzIew3L01zHXLNdoNnmGS9kTfW3NgR1aLO3ZOeOwP+i7KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RIRmn9GP; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488ba6366a7so81510155e9.0
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 04:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776251632; x=1776856432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bpedEU7mGkTRSv5C/AyW29lZoy8mTTrAXlbvsWFWNaY=;
        b=RIRmn9GP6ZsBXx/co/Ukt+5TAZq2hOCDMGJuiaSF/xBE0POK8l+ifh0gSqB3SCi4RN
         YBk4Wf0PbZoL7PO6c4Dvwm5lZb0g4zO0SNpY/+2jLgC6Uovt6IbKXNHw6xm9KuH3GVeH
         WBr0tFDMYz1jT4aNunmLuVHf5X8uKJmwtFz9Z35kXh8rymHDsoEmaHEzvIz/do1imqCd
         sHplOl7FDzpNlA5iImNkI2JQq9t9yYNrORib4CYHBSYsxwEQU0O/j7WJclOKa0zlAriQ
         +YNQgUIThJsVmWia+tb00vqDPghcdTc9HYpSWev20wmh/Ol/ExLE4ZrcnFsxjhZd8+bq
         0EuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776251632; x=1776856432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bpedEU7mGkTRSv5C/AyW29lZoy8mTTrAXlbvsWFWNaY=;
        b=JYZPG9O4/7vFEF9S89sc2bTV36tV5MJqOohRV4Vg3Qkp4LdiudwY6+qQWm3uQssGNz
         778suxZFhwLAo+2JO0k/+/FKZcKepvNgcIkHmL8tpJvXIRlYoSjpPh/LYa7/yiWVoSs9
         W5yFjII7em4xd2lNJd/mskuKeXcRUghILj3BSOaO0FZQNlQqn+kVJiciFieN8Azw0GzS
         CfY6XAGI5spR3eIakqX7uWOfxRP4SVxBFYdWXM5MRfrjJ5FqUsF0pmimGwtCjQvp/j80
         wKyh7NnYteHzpuLktS9xCtfcxzWFZ3gT6PGAnTPgZb7hGYIZGqrPcoUMZFl7ra/TGMBN
         Dk0w==
X-Gm-Message-State: AOJu0YxLQshLav+IerA6GLwqoBHJBnWXFkp0pNuOt7KzHgOe8qsbxnl0
	1Pd8rm5r2d+WIuKRMD4pEzXtOPXis5/d8zbCgZx+Z1d52ckF/ato3qmXvwXUFNoTS3U=
X-Gm-Gg: AeBDieuNm6bBGuXo0bE2o/IU/0PWAmiWmEftdKxhoxRpLPSNhAiqz4Wz6BcG2iAP66H
	n4P8SK9YAbjne+6LU3Y5hv0qheajA+j0isnyVOpZoKGg3PulNdFG2mgu1Oe+HUSSGZdynfxncw6
	Rdl3H8vT8hv96nWgQurE87o3fF20ZKkbJVyHe3ZZuxnV+ojLhLfHay8vsFVq3xA6hGLY/5Hhoux
	Bh606hFNqUaAGfP8aDS2jwyNVi+FTX+mKL4BaAk7nNDHuoPgRZ6R4ih8cNUrClgKwPAcq02kYsi
	TiKtYkd0FFA8xqmp+GdZhdBZVS0zcCCKo5NRscfTxQfMlc6ddwy+gj+oHUEU9PfkoDPATtkmBWv
	5ffrX3uvYPM5xabt04Usb7AUyPFFT2oFRWmvJGbEEBSjomzheWt7v9nP44+Y39TeUAHcAtmm5UJ
	TVG0MMox0XV20jHHR7h/SLt+z/EuoqJUE1hcwZRBEqLrPHUCuElQWhfKfpTg==
X-Received: by 2002:a05:600c:8883:b0:488:a82f:bb95 with SMTP id 5b1f17b1804b1-488d689c18fmr221931445e9.29.1776251632200;
        Wed, 15 Apr 2026 04:13:52 -0700 (PDT)
Received: from bazzite ([102.128.175.252])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f0ebd0e1sm17995625e9.28.2026.04.15.04.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 04:13:51 -0700 (PDT)
From: Louis Kotze <loukot@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rtl8821cerfe2@gmail.com,
	Louis Kotze <loukot@gmail.com>
Subject: [PATCH v2] wifi: rtw89: phy: increase RF calibration timeouts for USB transport
Date: Wed, 15 Apr 2026 13:13:37 +0200
Message-ID: <20260415111339.453602-1-loukot@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410080017.82946-1-loukot@gmail.com>
References: <20260410080017.82946-1-loukot@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34764-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loukot@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0784A403A8A
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

In response to review feedback on v1, the 4x multiplier was also
re-verified under adverse host conditions on 5GHz. 5 cycles per
scenario, stress-ng as the load generator, max observed time per
calibration:

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
   needed. This is the specific bug the patch fixes.

2. Calibration times are I/O bound (USB H2C/C2H round-trip
   latency), not CPU or memory bound. DACK stays at 71ms across
   all four scenarios. Host-side stress has essentially zero
   effect on observed calibration duration. Bumping the
   multiplier above 4x would not address a failure mode that
   this stress matrix produces.

Signed-off-by: Louis Kotze <loukot@gmail.com>
---
Changes since v1:
- Fix comment style per Ping-Ke Shih review (first line '/*' on its
  own line, kernel-standard format).
- Add stress-test verification table to the commit message. The 4x
  multiplier was re-measured on 5GHz under CPU stress, memory stress,
  and combined stress using stress-ng. DACK max is 71ms in all four
  scenarios, confirming calibration times are I/O bound (USB H2C/C2H
  round-trip) and not affected by host-side load.
- Drop v1 patch 2/2 ("make RF calibration timeouts non-fatal on USB").
  As Ping-Ke noted, the return code from rtw89_phy_rfk_*_and_wait() is
  discarded by all 8922a callers, making the non-fatal change a no-op
  for 8922a. Worse, the one 8922d caller that does check the return
  (rtw8922d_rfk_tssi) uses it to fall back to non-TSSI mode on
  calibration failure — patch 2/2 would have silently broken that
  fallback. With patch 1/2's multiplier alone, 25 connect/disconnect
  cycles complete with zero failures, and the new stress matrix above
  confirms the margin.

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
-- 
2.53.0


