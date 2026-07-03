Return-Path: <linux-wireless+bounces-38597-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rSwSFIfaR2pRgQAAu9opvQ
	(envelope-from <linux-wireless+bounces-38597-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 17:51:35 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A5883704046
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 17:51:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=baylibre.com header.s=google header.b="X4lg/cIF";
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38597-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38597-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E64D4303582D
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2026 15:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1392882DE;
	Fri,  3 Jul 2026 15:47:40 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123B0233939
	for <linux-wireless@vger.kernel.org>; Fri,  3 Jul 2026 15:47:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783093660; cv=none; b=eu+u+MeIVVa9t4uHoDMU9yuJk4fI1QRdlbOpTSs0CaWGwxfmH0Xc8pY6EY4FHwj3WUwWedV2+BeyjBd/32VrDU961cycTLA63PF1ZTNhiLP+2wnVkxbaIF2gkQWS1gUpwztMj1pnMNsRAL6z4HByPSY6OdSpsi/cvJjM9fKb/DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783093660; c=relaxed/simple;
	bh=AESz4kz8frXFTeTkqEQyF5UVy4ndePzOcC5upXuxz/I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EZGvLQNdo/mjuecGV65mUcBaERCNnk92kS8FqoZHCNLG6LaQXZ8g71JS3RwbZk9Jfv+C/Koux3a5ETVb7VGLpwZoPp/oXW+9yz+xEOrTGCr1k5tPqlzCf3VbNQsozequCSfWcmQpVnGKneQP7Bx2mQ4veayPaeiwA7NmIhGCBg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=X4lg/cIF; arc=none smtp.client-ip=209.85.128.50
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493b1710405so3947925e9.2
        for <linux-wireless@vger.kernel.org>; Fri, 03 Jul 2026 08:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783093655; x=1783698455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AyC5/dv58nEZH7BfzhhlRnGtfxHwGoglKrz5jjPqm78=;
        b=X4lg/cIFkkWa3P/SO0KstlUaDn5tLY+XIWWSiB+pWXDRGbuQ7GhM7g5dY8XJjD7X7N
         xsWFfoHL2siNEh5b5vhhRa4ZJsmlxiblv5XvrMxNPZzYPju3F4nTYOZfyuImfBR+6BSe
         /TapZr1DPuNgT3/tCWYxWLnUPpBqs4RlxFurv8DM6BYBDxJ4Fb/hUhDGHYPCZRm9k0WT
         KfkXZp8sJDuF43fVlMk02zoswLxP/+NYm0Qg8aTe8TOenOmtwp74ahABZYl1PGp/cGeU
         9nH/rjm6WZa/uefvFofovGc9xYIeN6bTiZcpQco6+KQ7BsTXKP75unQduLdUOoRc3ZH3
         +mDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783093655; x=1783698455;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AyC5/dv58nEZH7BfzhhlRnGtfxHwGoglKrz5jjPqm78=;
        b=fCvN90BQme6BvpJv/e3V+/cSo6Zj6w1L45d59R2XBQjS0Xp437MmNmighpJoIGfVYH
         N3iwjDo8DlbR8e3kyZYfu8uH8LVbliK23x8Z2NoYDacE8ai5HOaYdAXy1p1R1Sa8QDdx
         cLLGNyuDHlqVrdlcK9f8UjMcIERI7k1CAcaJKl7p+gJMfz/yNPxghagY7fZYM4DtGQtW
         Mej8ZS/4f/3dKiQOjXY5Ua8srs7IFPJu4InUXOEyXE+3HctlaXGbBMsx93+FhGkPbqBK
         mHliJtXbnfc7S0UQMESfdYV+kCeZPJQlbXjEXv/Wv4L2Vy5mfnKMq+YPszMBQFq+L3NP
         jVuQ==
X-Forwarded-Encrypted: i=1; AFNElJ+sG9/3aUsx3/+YtEvnvA6Pb9tBnLYrRSUQuZrFoH1GLofNM4uYGZ4ZpaioprJLhahVOkf7a+x07r1m5SztnA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwzZYJlyu9jbEEucCFdqRtNZIXsyCzCMVF9fOfytDk/1JEA+l9J
	LjImrrPngtgeNCEC/trRm/KirXz8NIk+7N19f9THStCDVQhadW98EgiFkRSH3smr0NI=
X-Gm-Gg: AfdE7clIQoLuhI8FmY1kaNpuNb1Y7Gs9vzLTVurdXAlwPf5TE/ezW/Rn0HJgbY/JRmM
	uRDA4joGRRBt4/XJAuwFSdq4ET6lZd91SgkTGszG1BPqNgG2Kty09mK7j1N+LodEjIcW8o2yeSl
	55fgrDlG4FOYChrXgYSfMkNPjBezOpkhjuW7rWES5oZfw+SXdT4ap5G3WSs7XFUnc6AsKJKH6Yr
	iJCxPShAtWb+Ff2AxYfuQrqtxqhtDOpbTtkxIPkQD2JIMpqV44r+gJImSmnXkRQNdfYuuOdWQfY
	w0gsYPuE12ZSFjVWsl0NoTshumLaOp+4LmGHluV++lHpWM6s9Li1AdyVBUffhXyR8yhXU6Y7KUm
	LpV2KMPKLQtcidM8ImCMLWz4kO+5orxXgUTBAwDLzMpuGNNmFs1lPKiPnlUFeCcfGX22WKqOCYj
	fyyoig9WFvsNTh0AtaLQKRnXk8hm2UHLv9Q5UF4XIyL7cAR1e6uw4ophZuGhIu2bg5KCUdfN7lS
	jx4
X-Received: by 2002:a05:600c:198a:b0:492:45a0:dcef with SMTP id 5b1f17b1804b1-493d0f0978dmr4377045e9.5.1783093655545;
        Fri, 03 Jul 2026 08:47:35 -0700 (PDT)
Received: from localhost (p200300f65f47db0472e4f1e98703de96.dip0.t-ipconnect.de. [2003:f6:5f47:db04:72e4:f1e9:8703:de96])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-493cce1947bsm60309585e9.14.2026.07.03.08.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 08:47:34 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: David Heidelberg <david@ixit.cz>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Tomasz Unger <tomasz.unger@yahoo.pl>,
	Carl Lee <carl.lee@amd.com>,
	Ian Ray <ian.ray@gehealthcare.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Mark Greer <mgreer@animalcreek.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Kees Cook <kees@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Linus Walleij <linusw@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Jialu Xu <xujialu@vimux.org>
Cc: oe-linux-nfc@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH v1 00/12] nfc: Various cleanups around device_id arrays
Date: Fri,  3 Jul 2026 17:46:14 +0200
Message-ID: <cover.1783091699.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2240; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=AESz4kz8frXFTeTkqEQyF5UVy4ndePzOcC5upXuxz/I=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqR9lQMT3PR8NKnniKF2TQinPW6MQDj+Lz0++B9 CEb1392jSyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCakfZUAAKCRCPgPtYfRL+ TlBiCACjQyKRcLsLCwS9/Vy0/lTVfQuf5I7DmyVfo+sQxFJ/+EUzZ9klq981bu5wW286CPciTap 4j41RWytP2MtVKtWfzK3CVFtr2Q/lZQh4VjJYzkuDZaHf4V5V0WkJ5ArMo80SnsNs1gZl8yZkIj PLPO1YjFXu5Cuc7Gv92tHU5m+e03mf3R6TQCu3ZxXeQXbU0RW0UhSYhDPQDt8nkyKumXyVRluhn bW6KAbqPRt7dTTYWB+byLD7Bb9MGFEXhjthTZ1030k07NPz4H6kV7U8Tw/2PE6XuesckFD3pQ0F mriJiwJ6khoIZcOQ2brWW240rVb4uRG541iEhyOVZ0YL2O4c
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:david@ixit.cz,m:krzysztof.kozlowski@oss.qualcomm.com,m:horms@kernel.org,m:kuba@kernel.org,m:tomasz.unger@yahoo.pl,m:carl.lee@amd.com,m:ian.ray@gehealthcare.com,m:o-takashi@sakamocchi.jp,m:bhelgaas@google.com,m:dakr@kernel.org,m:krzk@kernel.org,m:mgreer@animalcreek.com,m:pabeni@redhat.com,m:pengpeng@iscas.ac.cn,m:kees@kernel.org,m:bartosz.golaszewski@oss.qualcomm.com,m:linusw@kernel.org,m:johan@kernel.org,m:xujialu@vimux.org,m:oe-linux-nfc@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[u.kleine-koenig@baylibre.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_TO(0.00)[ixit.cz,oss.qualcomm.com,kernel.org,yahoo.pl,amd.com,gehealthcare.com,sakamocchi.jp,google.com,animalcreek.com,redhat.com,iscas.ac.cn,vimux.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[baylibre.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-38597-lists,linux-wireless=lfdr.de];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,baylibre.com:from_mime,baylibre.com:dkim,baylibre.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A5883704046

Hello,

this series's objective is to convert device_id arrays of various
different device types to named initialisation. It contains a few
cleanups left and right that I spotted while working on these changes.

The follow up change is to replace .driver_data by an anonymous union,
see
https://lore.kernel.org/all/cover.1780048925.git.u.kleine-koenig@baylibre.com/
for the idea.

The changes here are not strictly necessary for my quest, but they align
the device_id structures to how they look and will look for other
subsystems.

Best regards
Uwe

Uwe Kleine-König (The Capable Hub) (12):
  nfc: Drop __maybe_unused from acpi_device_id tables
  nfc: Drop unused assignment of acpi_device_id driver data
  nfc: Initialize acpi_device_id arrays using member names
  nfc: Unify style of acpi_device_id arrays
  nfc: pn544: Drop empty line between i2c_device_id array and
    MODULE_DEVICE_TABLE()
  nfc: Initialize mei_cl_device_idarrays using member names
  nfc: Drop __maybe_unused from of_device_id tables
  nfc: Unify style of of_device_id arrays
  nfc: Drop unused assignment of spi_device_id driver data
  nfc: Initialize spi_device_idarrays using member names
  nfc: Unify style of spi_device_id arrays
  nfc: Unify style of usb_device_id arrays

 drivers/nfc/fdp/i2c.c       |  4 ++--
 drivers/nfc/microread/mei.c | 10 ++++++----
 drivers/nfc/nfcmrvl/i2c.c   |  6 +++---
 drivers/nfc/nfcmrvl/spi.c   |  8 ++++----
 drivers/nfc/nfcmrvl/usb.c   |  1 -
 drivers/nfc/nxp-nci/i2c.c   | 10 +++++-----
 drivers/nfc/pn533/i2c.c     | 10 +++++-----
 drivers/nfc/pn533/uart.c    |  4 ++--
 drivers/nfc/pn544/i2c.c     | 14 ++++++--------
 drivers/nfc/pn544/mei.c     | 10 ++++++----
 drivers/nfc/port100.c       |  4 ++--
 drivers/nfc/s3fwrn5/i2c.c   |  6 +++---
 drivers/nfc/s3fwrn5/uart.c  |  4 ++--
 drivers/nfc/st-nci/i2c.c    | 18 +++++++++---------
 drivers/nfc/st-nci/spi.c    | 18 +++++++++---------
 drivers/nfc/st21nfca/i2c.c  | 14 +++++++-------
 drivers/nfc/st95hf/core.c   |  8 ++++----
 drivers/nfc/trf7970a.c      | 12 +++++-------
 18 files changed, 80 insertions(+), 81 deletions(-)


base-commit: 6eb8711ece2ce27e52e327a5b7a628ed39b97f45
-- 
2.55.0.11.g153666a7d9bb


