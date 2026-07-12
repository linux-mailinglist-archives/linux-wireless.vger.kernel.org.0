Return-Path: <linux-wireless+bounces-38917-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EW3TDP0SVGrZhgMAu9opvQ
	(envelope-from <linux-wireless+bounces-38917-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 00:19:41 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D684746217
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 00:19:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=JA3yXLJ6;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38917-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38917-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 58790300186A
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 22:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2454F36B07C;
	Sun, 12 Jul 2026 22:19:36 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F97F37A4B9
	for <linux-wireless@vger.kernel.org>; Sun, 12 Jul 2026 22:19:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783894776; cv=none; b=YdykzNX00duwHk2Ecx6o4dzTCJganFx2zJQiiu8wJZOmILggwiF1wiLpxvCjid3zX3db0zjYiX/OR13/d7N2b+YfqCA0zWEvTeTxBuKpbTrUe2dmc/vzOdWahgU6tJpqHdaHpqyS3unGVEaXofpS12Ix04J2U1q6JDhn/CYePO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783894776; c=relaxed/simple;
	bh=SD0SnRUYnNBM4DfHrzLQZfj97JaPRR/4PEuUdonb4Eg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rcwKQh1bXg5Am6DTXgDfc2UZgow3YuuUu+oOCOFv3hIPtiVnvdu6W+WIRRTIQh73aEfVU7MMpLNOVdN01jW+Oh424L4mthQniMlaEFcsRc6uJn1Mj6mScY8Jqob4igES5NonQoGRx6phuN0MvDfMmAYvJtJvD6WtPXlBhE2EWpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JA3yXLJ6; arc=none smtp.client-ip=209.85.128.47
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493b27c7451so43207165e9.0
        for <linux-wireless@vger.kernel.org>; Sun, 12 Jul 2026 15:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783894773; x=1784499573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=U0JMbC9mAGQuyluxV6HwchVzP8XmhulJGLA0wpvxvJ8=;
        b=JA3yXLJ6M7BoJb1Mbk1i8NROXSKk72ltN2/BSfZ1W6tJ34JByV70DJUPt6lwlyThC3
         hl2BBghsDgS/9/RrQ2610h8nL1hbtJmuusyhiXmkbsqAMGMih6Q4yQYKiz/Dnw1FK6Nc
         Ft2dKYznwMe3vqi4R5qPBm8mq/EcTG6Zj4nS9PQF+/jS7DrrLuVflHSupA+Fck+Gx//S
         vgjrL3mt5lCzfkrjTxu9RryUwhclcbkhOxu961PAbxqKDCdPORoeg33EjhDFoSuPlgen
         AwFHI70nRkmPOG05GHcaJQJSCovR+ti42Xc+S9ckC3PKxKhjn3rmPmqqybXvLAbuTm1D
         Qd7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783894773; x=1784499573;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U0JMbC9mAGQuyluxV6HwchVzP8XmhulJGLA0wpvxvJ8=;
        b=rEw4HZpaczP3jm4g/5GYndwg3wU2EVcTj5g1FgFWFETHFiDojxjehLtZLn4a755Jb/
         YV/lJ/nrmSVEOCxvhaxhrkLZk6yVLkGg8oJQW5nE+R6r4go9Y6C/mLp1VBg0U1nz49Qs
         AF6P03bN5Axd6XdVMUkbEEmXY3b/M4ZuuAyjKvEkPHfYZ628ruyDxUD97hR5Y9+HjjkL
         V2yUxJ3Tsl8K3Y0w8I+DDhlhz0vvlv5gcBkMnpCSa1v3z9cxgegXhpT8so04ts/FgU87
         nOZCY+Uj44NWK0gQlwhJBnRhKoLeCFjJz/qxb8vNXfeDF/qXZl0nZwNeS3Cz9wqZXU/7
         4PIw==
X-Forwarded-Encrypted: i=1; AHgh+RoftT95VqTsxu9pTZEZ3Z1szrxNqaZS3DR+3NzD9Ss3PFJqtBPbSddqX/weQ70WhiWqLkci4MD0U8onQo+INw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzD7y075GLzcqJfByOsRzQ98HVMs5Za0lux0YIhd+E7Nzw/0dIe
	JZZPDjXRkK91+YrREcCdvTy+aqRoHePUfm8YSUWvnYKll0e9cudZ9xnR
X-Gm-Gg: AfdE7cmf2fyCnxZfUqkZZv1XdwTvaSEYT2MgErG8febhpdeShJOgql5XotoY9dnbqKj
	/FHeLL0G2QC2OJuZVoM5CUZoOBD/TJggOGmJmzTPwLNjKNiyCtkUM/Fl2jqaDiEFA8hiRmEJO9h
	uEw7UsqMNKmbKwCccNyk8F/DJNlxopaeEEcDbQI/1Nd9qFXZx/Vp+AbIX1frxwr3ZUDtL7f5iLW
	NQt0E5nwfvC/WXS0otRytApCBLE98X/hBvIiSD0F0us+L94jKR4e+jf9JU2pVEjgxzKt8SV1m+m
	/7M6K0KyPsGKPShw2+iUQis1h+Y+VAUSXUDEV49G60Mol4MIWb9qT5xhehSNeEH/Dv/H7DrKyw5
	/RJAKWZmE7vj0Yh0qXQJkljpCLX2w4W+gVolMSh/miqFoA27qF7R+qri7Ce5PDq88SIehHske3P
	6AWrc6P3BJxUTFQnHXjE5ifT4KqrvHju7ara/pl3pPeompUPcq5Hyz0NnberVDlaKJ7V3Fa8msr
	YwGcSro/ba2ocy55Q==
X-Received: by 2002:a7b:cc8a:0:b0:492:2fc8:21f2 with SMTP id 5b1f17b1804b1-493f2a969a8mr96658505e9.8.1783894772850;
        Sun, 12 Jul 2026 15:19:32 -0700 (PDT)
Received: from localhost.localdomain ([176.222.15.234])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039af67sm89829211f8f.17.2026.07.12.15.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 15:19:32 -0700 (PDT)
From: Georgi Valkov <gvalkov@gmail.com>
To: briannorris@chromium.org
Cc: francesco@dolcini.it,
	s.kerkmann@pengutronix.de,
	johannes.berg@intel.com,
	kees@kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gvalkov@gmail.com
Subject: [PATCH] wifi: mwifiex: fix freeze for 60 seconds caused by request_firmware
Date: Mon, 13 Jul 2026 01:17:09 +0300
Message-ID: <20260712221709.7099-1-gvalkov@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38917-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[dolcini.it,pengutronix.de,intel.com,kernel.org,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER(0.00)[gvalkov@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:briannorris@chromium.org,m:francesco@dolcini.it,m:s.kerkmann@pengutronix.de,m:johannes.berg@intel.com,m:kees@kernel.org,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gvalkov@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gvalkov@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2D684746217

Fix regression in rgpower table loading, caused by using
request_firmware(): when the requested firmware does not exist, e.g.
nxp/rgpower_WW.bin does not exist on OpenWRT builds for WRT3200ACM,
request_firmware() falls back to firmware_fallback_sysfs(), which expects
the firmware to be provided by user space using SYSFS. No such utility is
provided in this configuration, so the entire system locks up for 60
seconds, until the request times out. During this time, no other log
messages are observed, and the device does not respond to commands over
UART.

The request_firmware() call is performed in the following context:
current->comm kworker/1:2  in_task 1  irqs_disabled 0  in_atomic 0

Fixed by using request_firmware_direct(). This prevents fallback to SYSFS,
and avoids delay. The rgpower table is optional. The driver falls back
to the device tree power table if the firmware is not present.

The error code is printed for debugging and returned to the caller,
which only cares for success or failure, so there are no side effects.

Fixes: 7b6f16a25806 ("wifi: mwifiex: add rgpower table loading support")
Signed-off-by: Georgi Valkov <gvalkov@gmail.com>
---
 drivers/net/wireless/marvell/mwifiex/sta_ioctl.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c b/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
index a6550548d3b4..9460d5352b23 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
@@ -196,6 +196,7 @@ static int mwifiex_request_rgpower_table(struct mwifiex_private *priv)
 	struct mwifiex_adapter *adapter = priv->adapter;
 	char rgpower_table_name[30];
 	char country_code[3];
+	int ret;
 
 	strscpy(country_code, domain_info->country_code, sizeof(country_code));
 
@@ -214,16 +215,17 @@ static int mwifiex_request_rgpower_table(struct mwifiex_private *priv)
 		adapter->rgpower_data = NULL;
 	}
 
-	if ((request_firmware(&adapter->rgpower_data, rgpower_table_name,
-			      adapter->dev))) {
+	ret = request_firmware_direct(&adapter->rgpower_data, rgpower_table_name,
+				      adapter->dev);
+
+	if (ret) {
 		mwifiex_dbg(
 			adapter, INFO,
-			"info: %s: failed to request regulatory power table\n",
-			__func__);
-		return -EIO;
+			"info: %s: failed to request regulatory power table: %d\n",
+			__func__, ret);
 	}
 
-	return 0;
+	return ret;
 }
 
 static int mwifiex_dnld_rgpower_table(struct mwifiex_private *priv)
-- 
2.55.0


