Return-Path: <linux-wireless+bounces-34572-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SH1RBzCv2GnfgwgAu9opvQ
	(envelope-from <linux-wireless+bounces-34572-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 10:05:04 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F063D3BE5
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 10:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0070F305F7EE
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 08:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BC83AB287;
	Fri, 10 Apr 2026 08:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UpRSBnY7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB233AB285
	for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 08:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775808041; cv=none; b=aW0mTM1tW+w/doFi37okarrMSgp14m/ZDDJ30s/teMli3kr7nwalXANNiqFi8tDkA8Rz2oyqLhxeTUPRxZw7N5rO6Y5ajXRZWxfS9QNv9lLhhqghNzFUXGNte8BfDf9pqpxi3M025rvxMKiUOeG6vt9z9tq3EvTiHvou+FxtIGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775808041; c=relaxed/simple;
	bh=sJLUcEB5Ds5h7s1KzusNR0Xi7cPwLi/aMbVipBLZNf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eKetgJWQADpYWYNWlR63f8S8Q1kzVDcRghbJ/fYqbBIS0tbvWzIt3jySJ0/SX2IymMpblWyEeUryrHrML5h8EHFPRlGXGjrLaXO55Bxs21RNVuuI7hggRe6xhya6AIIrSH5SAHZeiqUxf3lYzGqNUpNabIBU2zVKWVp+9lO8FZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UpRSBnY7; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so22221605e9.2
        for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 01:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775808035; x=1776412835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VbUT3h/LfG7smkTPhwuysdt9HcT3k1c4we51p644zaU=;
        b=UpRSBnY7EcZLH3DBjTOKWBU7CYY9RsXATYFTLOVx/xbY8jFBobjLsLMm8eM/s2sewb
         9AaI2YrFLKmfrIheQKt7BaO6G2iCgZME3ppgQntdwewkwMoFFDul9qfwM3NBFf5CVyEK
         +zI1ymU3IaGQGiaC9cPxkhmaM7zXVdqpA/PFIqCeZXUtmhqn0r4nAXP/h12UcBM9jMOj
         pMyYPg5p5GYDEfyL/46sttJ5dbO9EN10drhGqZod3cPrL2MmzoxfyzcRAD4PbeaK+qOp
         8zpoPoxFOLGLlMDH3ZwpgvWi8wdpVGV29TLKsbUs2fEP/3xLhs3b6IiWrhDEuBRWHPXy
         gmLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775808035; x=1776412835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VbUT3h/LfG7smkTPhwuysdt9HcT3k1c4we51p644zaU=;
        b=hOQlx6Y1JEeB7aP88fkOIzW15irOepK8rsXuipyMLqJAmLqUN11/4wyh3GS4npAZHf
         ROChFs7deTHnpN1AwEsVJ1iMPtDI+hF1u7BPOBjVxPboKTrQ5jFiLYu6Z7hxJCO56ZHO
         nlFD8Y2D30QjC1fPdaK3Fd85pLsYc7qdjw1AAim3VWyWtBKKsOhL/O7/fN+as9pC3oJu
         AWFZ6YF/n1lXPHKyjeKkFKyyAm6/sc21UmD3dPIb3CmsrChqa4PC12pAQcka3OlhpzEn
         pQsJycRpdPa1UVQCrN9Zyu9sWR4hCfKkiHnVWJUvPY3cXJTyHqSH6ojsYFamlalUqhCp
         2DUA==
X-Gm-Message-State: AOJu0YwgmHfUh21ZuvO8EoqVEkUCMwkSD4jkFASeu1ea1pvw0IW4HZkA
	Bjzs/gouwvzRyF5KmeGY3zJ2BFL/dAMNct21EVyeWxhpUk1cuWoR1nBi5g8v/pq5aXI=
X-Gm-Gg: AeBDievtBQ51Kw1pjwYh3riLMSzZwEJyNwuFqjCbSpgbZkfhChyjGTDkTdwGGGt6vP6
	BuEqd3ovZJm10RaFrAJpAQUzaWTH/jviRJDHGZI6RvCJzoIQ+UsU2sWKNBMkbA+C15ijXpcvNF3
	IZd3mFrmTGnr9E+hSw5Vs24e1haUb90oTBkO4apm3/h18wACyi4aEXYCwtKOxVf8OQ8NzQi5BRC
	AFbrsNMpYdynaYQm422sRfiWSuXIaTgoW1s8Okoq4WwETNaPTiY7IL5Zp/mYpCIq0KvwKJJRQ0s
	zrAZ7NLlWHA3RUtKXyJ1U+7aHFPHM8UmSeL4Q296QrPd8dVU/TElBHPTDmrVJeu4W/pX7g2mG2d
	qEo3G05mU/NanbsMMjhxm7j0ArF6BdoRXA3hv532FNgADvqci/n7a8Lg2RqHBVLCgd8EFjwh6Ex
	8B
X-Received: by 2002:a05:6000:26c2:b0:439:ddf9:a205 with SMTP id ffacd0b85a97d-43d6427b793mr2975801f8f.10.1775808034579;
        Fri, 10 Apr 2026 01:00:34 -0700 (PDT)
Received: from bazzite ([102.128.175.252])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e5c98fsm5891151f8f.35.2026.04.10.01.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 01:00:33 -0700 (PDT)
From: Louis Kotze <loukot@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: pkshih@realtek.com,
	rtl8821cerfe2@gmail.com,
	linux-kernel@vger.kernel.org,
	Louis Kotze <loukot@gmail.com>
Subject: [PATCH 1/2] wifi: rtw89: phy: increase RF calibration timeouts for USB transport
Date: Fri, 10 Apr 2026 10:00:16 +0200
Message-ID: <20260410080017.82946-2-loukot@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410080017.82946-1-loukot@gmail.com>
References: <795a8567fdbe48babc5cf0f2b5e10c0a@realtek.com>
 <20260410080017.82946-1-loukot@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[realtek.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-34572-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loukot@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B1F063D3BE5
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

Signed-off-by: Louis Kotze <loukot@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/phy.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index e70d0e283..4d809df8b 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -3956,6 +3956,13 @@ int rtw89_phy_rfk_report_wait(struct rtw89_dev *rtwdev, const char *rfk_name,
 	struct rtw89_rfk_wait_info *wait = &rtwdev->rfk_wait;
 	unsigned long time_left;
 
+	/* USB transport adds latency to H2C/C2H round-trips, so RF
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


