Return-Path: <linux-wireless+bounces-4117-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E0486A3FE
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 00:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E4E31F22E0E
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 23:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF51256749;
	Tue, 27 Feb 2024 23:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="RiN4iJcF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE9456479;
	Tue, 27 Feb 2024 23:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709078143; cv=none; b=try33HUKlqJ8bf64A2Zph3Q9A5No0Mnc5NuUlzKGxw3VE3iM7YHBb9m+/9Om2mYysa8MBqbRmNertcLX5eVkhXmLCs/Wwq9YxPVmV/Vvgg44k4/MCPUzSwcYaRinq+gYB0i1FKUxL/GnwRjriyirBw5seSfFIAZVcJTgmAxNBFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709078143; c=relaxed/simple;
	bh=nGh4bjjNOP8P6l8pArpBQ8TgZrojQb4caNCNjqgul3I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rsGCAWFLYY2Hd7izi02BEXcGx98iPHh2UNjWws4dZFjoVecf2rHwUt9GCvqe7AccwzgMu6jXuXkn1e2UsnOGqM3CLYj9igsNovJqb8cFRAamz3f9ifITx6nX0U4kl3d7lrbVT1jatPvsqv9TX8wIMWYvpmbJ7/UytyB2RxdBomU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b=RiN4iJcF; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1709078128; x=1709682928; i=fiona.klute@gmx.de;
	bh=nGh4bjjNOP8P6l8pArpBQ8TgZrojQb4caNCNjqgul3I=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=RiN4iJcF4DmtVbVTVdlgSsIpLGEi78CMu0/KeUNv5P266EM7ADI9cSHcFjKD38me
	 S8HTqdTFHJJMzlUdeKYalQoodVWNvSiNFNhLdiUlpoHpb0ZoNcOQC5MxZD2PA2d6u
	 Nf3FnjHoLDgpP2uRX5+bYrfQEi7om0iUoN+klQuvod9YHZT7zloI/yOZlzuvYBqrq
	 CS8meaR9hTQcuUobmCmVpPycaEn9s7WJ1nW1AyhPlgW/IF70HFFy/AltZ/g7uby7h
	 +CAcWAWiSs4HfkBWflfvuMepcy6O2HNyuoLttK9lgpCML4K3TIACijdZWmUr8bQ2G
	 EkIoyvWtYnNHvSxWTg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from haruka.lan ([85.22.29.223]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MVvPD-1rVNxt0yQf-00RmVe; Wed, 28
 Feb 2024 00:55:28 +0100
From: Fiona Klute <fiona.klute@gmx.de>
To: linux-wireless@vger.kernel.org,
	pkshih@realtek.com
Cc: Fiona Klute <fiona.klute@gmx.de>,
	kvalo@kernel.org,
	ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org,
	pavel@ucw.cz,
	megi@xff.cz
Subject: [PATCH v2 0/9] rtw88: Add support for RTL8723CS/RTL8703B
Date: Wed, 28 Feb 2024 00:54:54 +0100
Message-ID: <20240227235507.781615-1-fiona.klute@gmx.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wsPFUGmf12pruTaTgOX5LqhK/uXYaZFr1krmXMenPVDfXFTNJ7h
 Mq26y07ZMJBZaTIR5Ap1fTp56+gKrnOAFkeEnKmenCYjuf/goB1D/AictB/WgQaUfFO5oKE
 mAbIo+qatzrcfZUeht+j/UGCaP3gbWe3VRPGwVsjdvJ1lvyGyBjAQiZBsAR4F8nEzvzvvDO
 o9ImOpl3AJhDlfOF9OFYw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OE7hkR9x86w=;56YmgfpbVcuc9UufBoXk8+0H7U1
 dOVp5IRzybh9xgHO6VMmxdaV3bsUht7mmTBTTpAFD8+BkdMwN/WUiknSlzof6fj50caM6bQvz
 fBMsnRutizDbmAhyp37Nwr527Mf0CYcjzDdo+pU6NALCM88QMsEsoxFPv8BHgptUvgBIpK6Lk
 Uj+m2Eyi5WU4RDyvQEYQHl+LxWXiyoRlNYWChy5h17wcsrqC9e/NTVEOcJp0AuJFp1eJ6JdTF
 HDA/8eW64OX+7TzhrA7ZDCziCRJ+2J22fkgBnG3u0LDrluMaUxsQ1KbUPRcgSu4UTC8RxyAeJ
 f9+wr2upYlZQwYVcPb1pUc/4+06pK+99MzvOrc5dZdjuQdsoqvSXbM8cNbN8RRY4xXgN3ARyZ
 qbp6dumzKzLNRj4IFuQ7+VoRN9h2OPQ7gDJXhRiZmqDp57kmeBLSJrDxgUstp1M0ccAeb9zBI
 1UKSiZxGs17zDOsWJ59obXCZecAx3ovpa87g+8GoaAZ5GvUftcGa9NX+U7kNwS7R5eN89AyXZ
 he/gEOmF4JQ3/aLdIRcu6tNVyEjdIWBhjHwy7P7bEWO3P4imUC3fGNDklbkepuO//EEDpphEw
 Ze60YrZqdAhyzKiJxpEJv7KS3tiIab3TRd37E8xR8UoSdBOpwwxcE6FWPFDXyh8mOtjJx6WU/
 vppx2t/v40Cgl/LQTe9sm7aYw9kmclJaNU7oZ5LKophhaChw+jeuTg0BqE7HsXl3+YqYXaoQc
 aW7KyXWNWSqUEpgXv985Vmyv1m7XhUqQd1q9AT3TKqQUdpmst0JYngiY0ioKyao1kCcNNS8KV
 Zf0PwMQLQOQvf7/UAIzCl3GNGIYEt5o7A2JBm+9H/wqh4=

This patch set adds a driver for RTL8723CS, which is used in the
Pinephone and a few other devices. It is a combined wifi/bluetooth
device, the wifi part is called RTL8703B. There is already a mainline
driver for the bluetooth part. RTL8703B is similar to the RTL8723D
chip already supported by rtw88. I've been using the out-of-tree
rtl8723cs driver as reference.

Station and monitor mode work well enough for daily use on my
Pinephone, I have not tested other modes yet. WOW firmware is
declared, but WOW isn't implemented yet. RX rates stay fairly low
still.

Ping-Ke Shih kindly offered to add the required s-o-b for the firmware
and help get it into linux-firmware when it's time, for testing now
please see the code I used to extract firmware from the out-of-tree
driver [1].

I'm trying to follow the "one file per patch" rule for new drivers
while integrating with the existing rtw88 code, please let me know if
I should split it differently. I'll be including a few questions for
reviewers in the relevant patch mails.

Thanks to Ping-Ke Shih for advice, and Ond=C5=99ej Jirman for debug logs!

[1] https://github.com/airtower-luna/rtw8703b-fw-extractor

v2:
  * Parse PHY status using struct instead of macros
  * Prefer MAC from EFUSE if available, move retrieving MAC from DT to
    a separate function
  * Tidy up wait for IQK to be done, replace mdelay loop with
    read_poll_timeout
  * Set dual author for rtw88_8723x
  * Add missing "static" to rtw8723x function declarations, fixes
    build failure when not built as a module
  * Various style fixes

Fiona Klute (9):
  wifi: rtw88: Shared module for rtw8723x devices
  wifi: rtw88: Debug output for rtw8723x EFUSE
  wifi: rtw88: Add definitions for 8703b chip
  wifi: rtw88: Add rtw8703b.h
  wifi: rtw88: Add rtw8703b.c
  wifi: rtw88: Add rtw8703b_tables.h
  wifi: rtw88: Add rtw8703b_tables.c
  wifi: rtw88: Reset 8703b firmware before download
  wifi: rtw88: SDIO device driver for RTL8723CS

 drivers/net/wireless/realtek/rtw88/Kconfig    |   22 +
 drivers/net/wireless/realtek/rtw88/Makefile   |    9 +
 drivers/net/wireless/realtek/rtw88/mac.c      |    6 +
 drivers/net/wireless/realtek/rtw88/main.h     |    3 +
 drivers/net/wireless/realtek/rtw88/rtw8703b.c | 2112 +++++++++++++++++
 drivers/net/wireless/realtek/rtw88/rtw8703b.h |  103 +
 .../wireless/realtek/rtw88/rtw8703b_tables.c  |  901 +++++++
 .../wireless/realtek/rtw88/rtw8703b_tables.h  |   14 +
 .../net/wireless/realtek/rtw88/rtw8723cs.c    |   34 +
 drivers/net/wireless/realtek/rtw88/rtw8723d.c |  673 +-----
 drivers/net/wireless/realtek/rtw88/rtw8723d.h |  269 +--
 drivers/net/wireless/realtek/rtw88/rtw8723x.c |  721 ++++++
 drivers/net/wireless/realtek/rtw88/rtw8723x.h |  518 ++++
 include/linux/mmc/sdio_ids.h                  |    1 +
 14 files changed, 4486 insertions(+), 900 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8703b.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8703b.h
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8703b_tables.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8703b_tables.h
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8723cs.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8723x.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8723x.h

=2D-
2.43.0


