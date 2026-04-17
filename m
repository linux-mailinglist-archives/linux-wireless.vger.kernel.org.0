Return-Path: <linux-wireless+bounces-34929-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCmbNKkx4mkZ3QAAu9opvQ
	(envelope-from <linux-wireless+bounces-34929-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 15:12:09 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1FD41B788
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 15:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D16F430A0D51
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 13:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C07C3A1CE9;
	Fri, 17 Apr 2026 13:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="VvArZr1y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDDD396D0A
	for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2026 13:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776431489; cv=none; b=greVyPPXrjVHqQyLjzE03tMtQ64XvIJK4dvlGb8VjPnqMoH36vpyd2HMNBtvSnVMkq3sx9soSPdFByTPhRcLCI3+g79ctO2JqYyUsP6SqgFqVDtZipBuWRDbUjbJdfcTkcejw08IEaLt3rRiMZOF2XXdeWjoynUGXsgf/BUit5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776431489; c=relaxed/simple;
	bh=gRLZDYjP8rAyYDu/dxhxXrW55dQHWBhhz4Mp7s9yll4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HdoBGLNam/ubF4rWwKqM7Shh19VxFT/CHKXQg387bDK/wtN+H8MEes5JnYQMo9jz5Fjycf5HglXHZDwKFORaBYY17AWagGh9oqFtTjkcFk1H6VLYc8vkmYzuXY/KRvWnWfgwbT4XFjDHc3RLniJDHOmju4czoBoZNB3ovIZe3hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=VvArZr1y; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43cfd832155so486995f8f.1
        for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2026 06:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776431484; x=1777036284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KCc9El91v2tJeTyCQTpkqW7vYe/zKOnr7R5NXhlhOxk=;
        b=VvArZr1y+esjXP9Fkt1hwUdDRTxtksIGaH9R6ylZc+w3tKLPxsKo4koXmB3ViLSx7J
         pDgMuL5mdZGpicySRMr4Rtc7gEjES2CCcEENqzVf20iUq/gK8GJhG6q0uYR1yslK+gMC
         norEuIU8GkMmsZLGvKtJE1IxuckNnapfE6FiZqnpphtszWJUzRgLpQPBWGUk/spJxm+K
         bpyGeGSuLjPDhwfGajRuUT0rtRkzILhja3fO4Tl8kXzMnsGugCV3IExsETfD4pd3Ik+T
         CVS8oV4b6aLRUoTRoDmHS7+/X7yKUdRPv3gGC9lTk9/hCS0uVZVF2uRF5v5OWtRefNw8
         KfUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776431484; x=1777036284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KCc9El91v2tJeTyCQTpkqW7vYe/zKOnr7R5NXhlhOxk=;
        b=APKdhwPQnKUdqh4sWBlOGtdxNGTXHBKDwUeewG1ByJigzGYHY2ev2a6t0xuinpOH6Y
         fnQgYCb8xyyqpyain8V8v3QoLoMMpJfV1w4jjiqyHiXt2DnXvxcGfclT8MDmlUpANC4k
         4eCSgt1wXTqy3pyr0fst7GrrcokTJhS6m3hvZ4cXDpnINoHNX6N6HTcdyFll1cOh28S9
         S/sgEpsQ0tdiAEwnFOf6UvKyalgDq0SKfl8BbgUvDh3uh2u3EbI3AaliI+rGdWyD1DeV
         B1MDglVmW0ER6+5FP8JDDYUU1bG9Qtoo06dELHB2eTWSrwTuy1ULDNjpLQVQokh8xbPm
         OQMA==
X-Forwarded-Encrypted: i=1; AFNElJ8RwgiirMnsascMD/KZQeW1ZRofsK7gyYqRFQ2X8+lpyktrKKt6quYynBoXeggNQNreRJwJy0smupp9QdgBnQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy/jdryc53HhdR0NHKyKqHTIctm8OiOR5/SHeofcX/8vHiks4u
	6DBNUPoZpnWIzI/XCZ335SGdCkWgwmyQtW+C3Os+c0jxVTPl+3I+xzYY8voO32DxqO0=
X-Gm-Gg: AeBDiesjx4GyRm/+jD1zU9TsXwm7tArvrtc8RufEE5BFTY+vttTUEp13riAOrKwMw8U
	c80s2Snnczw3jBCNc9VZqGnv3d3g2J2EucG6NzNNob47TG4xK2R4QNmxWuiTQnlnVRmGbeShopL
	VErg8bVXR8M8j9SGRzfSaHYx60o2uVf8uX878sxYvIpqm/46M2bhg3pUkenxTrsVD2bCvskPIu8
	BLeoPbOgiN1PlN2V/WqXG7GrOSknh0/AmFfF8uaJ81SipnyQmdRF47opl/ckwMLowEn+xNzMewj
	/3U+S/L/rBKjAIKtWT2Nu8FlFtaFwAZ9KlFeIYBOXNdrPBlaq7NEuySEDcQeVogBQak9htRynAS
	o/qF1UM2n3NPqMDdKoeqAc9nHdoKTIjvRFyX7M3cwmRCHSuG3KR0ed1qR8OAMkJNe7gM6W9x9T2
	1J8AQboSs+vL1j2CwlMCu9DObAApGeVwYEB8V5I9zl1cHrQAQdby6S59uvUVAX0A/rhgJQHH1jj
	kBsPruxlcwRlNLI32ekR7Dw
X-Received: by 2002:a05:6000:2005:b0:43d:77a8:3ba7 with SMTP id ffacd0b85a97d-43fe3e12484mr4104740f8f.44.1776431484359;
        Fri, 17 Apr 2026 06:11:24 -0700 (PDT)
Received: from localhost (p200300f65f20eb08db61cfc60d8aa232.dip0.t-ipconnect.de. [2003:f6:5f20:eb08:db61:cfc6:d8a:a232])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-43fe4e3a7b4sm4356620f8f.22.2026.04.17.06.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 06:11:23 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: "Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>,
	linux-mmc@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-kernel@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-mediatek@lists.infradead.org,
	Ping-Ke Shih <pkshih@realtek.com>,
	linux-wireless@vger.kernel.org,
	Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 0/6] sdio: About pointers in sdio_device_id::driver_data
Date: Fri, 17 Apr 2026 15:10:46 +0200
Message-ID: <cover.1776429984.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3816; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=gRLZDYjP8rAyYDu/dxhxXrW55dQHWBhhz4Mp7s9yll4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBp4jFWdaRCcbA6UCRSVtfbncEwOSti40CoPsvF+ vdIuFxTidWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaeIxVgAKCRCPgPtYfRL+ Ts32B/9u8msCou5BwhNaY0DlL45F+7qpQKpSsQuRk2gI42hvAESq9kyeVN/MZWif44tjir6LK2z uIl/GDbOQMK01aikDbfuVOtkDDghRBSTEB7Jka+OjfPnDumnNigRsaaBGNvsAFjIJkLhEy6qJDP Tn8woM7fN22cukUBpxin+S+kcXgM00Q8TjTUzEfguVA/yR/5l3z2E6JOyddLE7skD3BcWZth7gw bSohFR1HxMGAwUA7mKVNzLdYdPXW7y8rKtYwlVFZUsZmtrNFbfl9Br+UBebFAMyx3Rll6Um30xM RwO7mqAqqwH8Ox2CRHpiyR61s3V9bmt+/v2tLxnaw2vhp3PI
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34929-lists,linux-wireless=lfdr.de];
	DMARC_NA(0.00)[baylibre.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[baylibre-com.20251104.gappssmtp.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[codasip.com,vger.kernel.org,linuxfoundation.org,sang-engineering.com,holtmann.org,gmail.com,collabora.com,lists.infradead.org,realtek.com,nbd.name,kernel.org,mediatek.com,chromium.org,dolcini.it,linux.intel.com];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,renesas];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,baylibre-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 7E1FD41B788
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

<linux/mod_devicetable.h> contains several device_id structs for various
device types.

Most of them have one of:

 - kernel_ulong_t driver_data (sometimes called "driver_info")
 - unsigned long driver_data
 - const void *data (sometimes called "driver_data" or "context", sometimes not const)

Taking sdio_device_id as an arbitrary[1] example (which has
kernel_ulong_t driver_data), there are drivers that store integer values
in it (e.g.  drivers/media/mmc/siano/smssdio.c) and others use pointers
(e.g.  drivers/net/wireless/realtek/rtw88/rtw8723ds.c). The latter
involves explicit casting, both for initialisation and for usage.

In the past I tried to address this using i2c as discussion case[2].
Back then the motivation was just to get rid of the ugly casts. Today
I'm working on CHERI which is an architecture extension (currently for
arm and riscv) that uses 128 bit pointers to store additional
information, implementing e.g. read-only pointers and preventing out of
bounds access on the hardware level.

The complication here is that a kernel_ulong_t (which is still 64 bit with
CHERI) cannot store a pointer.

The obvious way to fix that is to replace the kernel_ulong_t by an anonymous
union that contains the original unsigned long and a pointer. This doesn't 
change the size (or layout) of the device id struct for archs where 
sizeof(long) >= sizeof(void *) [3] and gets rid of the casting. On CHERI archs 
this is an ABI change, but as a new architecture changing ABI isn't an
issue there.

I was surprised that changing struct sdio_device_id didn't require
preparation in the various drivers as they all already use named
initializers.

So the first patch expands struct sdio_device_id and the 5 following
patches implement cleanups that can be done then.

Patches 2 to 6 all depend on the first patch (only). This is not urgent
and thus merge window material. I guess merging of this series has to
happen in 3 steps:

 1) patch #1 via mmc
 2) patches #2 and #3 via bluetooth
 3) patches #4 - #6 via wireless

(where 2) and 3) are independent).

The series was build tested on arm64.

[1] well, one that isn't used as much as spi_device_id or i2c_device_id to have  get a manageable POC.
[2] https://lore.kernel.org/lkml/20240426213832.915485-2-u.kleine-koenig@pengutronix.de
[3] As of now this is true on all architectures running Linux even with s/>=/==/


Uwe Kleine-König (The Capable Hub) (6):
  sdio: Add syntactic sugar to store a pointer in sdio_driver_id
  Bluetooth: btmrvl_sdio: Make use of driver data pointer in
    sdio_device_id
  Bluetooth: btmtksdio: Make use of driver data pointer in
    sdio_device_id
  wifi: rtw88: Benefit from sdio_device_id::driver_data_ptr
  wifi: mt76: mt7921-sdio: Make use of driver data pointer in
    sdio_device_id
  wifi: mwifiex: Make use of driver data pointer in sdio_device_id

 drivers/bluetooth/btmrvl_sdio.c               | 22 ++++++++---------
 drivers/bluetooth/btmtksdio.c                 |  8 +++----
 drivers/net/wireless/marvell/mwifiex/sdio.c   | 24 +++++++++----------
 .../net/wireless/mediatek/mt76/mt7921/sdio.c  |  4 ++--
 drivers/net/wireless/mediatek/mt76/mt792x.h   |  2 +-
 .../net/wireless/mediatek/mt76/mt792x_core.c  |  2 +-
 .../net/wireless/realtek/rtw88/rtw8723cs.c    |  2 +-
 .../net/wireless/realtek/rtw88/rtw8723ds.c    |  4 ++--
 .../net/wireless/realtek/rtw88/rtw8821cs.c    |  2 +-
 .../net/wireless/realtek/rtw88/rtw8822bs.c    |  2 +-
 .../net/wireless/realtek/rtw88/rtw8822cs.c    |  2 +-
 drivers/net/wireless/realtek/rtw88/sdio.c     |  2 +-
 include/linux/mod_devicetable.h               |  5 +++-
 13 files changed, 42 insertions(+), 39 deletions(-)


base-commit: 028ef9c96e96197026887c0f092424679298aae8
-- 
2.47.3


