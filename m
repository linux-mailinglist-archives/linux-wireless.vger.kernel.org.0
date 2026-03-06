Return-Path: <linux-wireless+bounces-32594-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GL/VIMaVqmkkUAEAu9opvQ
	(envelope-from <linux-wireless+bounces-32594-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 09:52:22 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B8021D5D3
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 09:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F3CF0301CC45
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2026 08:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DF7330659;
	Fri,  6 Mar 2026 08:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SEpDIqvv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2FBEEBA;
	Fri,  6 Mar 2026 08:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772787135; cv=none; b=rXb1DQbk6W2LYmTVbP3Vbz5II3214qufEwDkruTmTVcoqKzvTA6/KMbdjiwjNriY8P9SZkSvOiQGwy82aPwRdBMeMJXDoJkuR5Jv2SaZxpJqLK06/S6KUCQ2KHa+AY6UzpBDEGiYf5MX9g0oaEUrOobgkeUfAIWD+UAe9QMqlbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772787135; c=relaxed/simple;
	bh=BC9phG/uboNPNh++ClnGxy6uWEWlwbWxQo4UxGMm2EY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tElSrgjgBIzUFi2/Rx7jVHu8e/DjGqaR4sA/RUOBHw5JEls32atN5m5FPSfWTLgEA4LynCSnz3oY+9HCTr1xuJUImbLJJlaP5E7qMKJnbpiaCkvrXU1kHI+6KDGSfEUs6Zqf0PZg4kJvVGDRLpUXC4dUBAvCQbncO+Nblb2gWNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SEpDIqvv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7950BC19425;
	Fri,  6 Mar 2026 08:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772787135;
	bh=BC9phG/uboNPNh++ClnGxy6uWEWlwbWxQo4UxGMm2EY=;
	h=From:To:Cc:Subject:Date:From;
	b=SEpDIqvvLiMR0dN4BEG/ouA8ijTft3I0xY8V7JdWUkG2dhmRaImUsEP85u1Oz2Vv4
	 hw0Y938FmeJwem4wrq8hjbNDIS4JYsFTXgmgvEfFxSUMQTAlJJFm95PEbgJehmI7dq
	 QUFXauzPwW9EEIPr5cZ4Kky+iwmCysLFY1RoMwIEuGKT6LIhntfrGOm8pERW9siwHl
	 3xV3KFok7O6tWSai4GZ/CRLYbqTm8hCBplGE94Qp+VzxYxml1csNjeSPJczx9j6SO/
	 dl+qcA+SW3ixrGiqjINMh27vbkCmEsB2Ri0oOGq2gfnaeKKwGfpBuz+XvglwUyAtfd
	 bZpSVkAtlGHCQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vyQuq-000000003AJ-3KlN;
	Fri, 06 Mar 2026 09:52:12 +0100
From: Johan Hovold <johan@kernel.org>
To: linux-wireless@vger.kernel.org
Cc: Jeff Johnson <jjohnson@kernel.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Stanislaw Gruszka <stf_xl@wp.pl>,
	Hin-Tak Leung <hintak.leung@gmail.com>,
	Jes Sorensen <Jes.Sorensen@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	libertas-dev@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 00/18] wifi: drop redundant USB device references
Date: Fri,  6 Mar 2026 09:51:26 +0100
Message-ID: <20260306085144.12064-1-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 01B8021D5D3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,toke.dk,chromium.org,dolcini.it,nbd.name,mediatek.com,wp.pl,gmail.com,realtek.com,microchip.com,bootlin.com,tuxon.dev,collabora.com,linuxfoundation.org,lists.infradead.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32594-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Driver core holds a reference to the USB interface and its parent USB
device while the interface is bound to a driver and there is no need to
take additional references unless the structures are needed after
disconnect.

Drop redundant device references to reduce cargo culting, make it easier
to spot drivers where an extra reference is needed, and reduce the risk
of memory leaks when drivers fail to release them.

Note that I sent an ath9k patch separately here:

	https://lore.kernel.org/all/20260305105803.17011-1-johan@kernel.org/

but I included it here in v2 for completeness.

Also note that Greg had already sent a fix for rtw88 which has been
picked up by Ping-Ke, but who asked me to send a replacement. If an
incremental patch is preferred I can instead send a follow up for that
one later.

Johan


Changes in v2:
 - include ath9k, previously submitted separately
 - include ath6kl and ath10k
 - rename the ath6kl and ath10k disconnect callbacks
 - fix a reference leak in rtw88 previously reported (and fixed
   differently) by Greg


Johan Hovold (18):
  wifi: ath6kl: drop redundant device reference
  wifi: ath6kl: rename disconnect callback
  wifi: ath9k: drop redundant device reference
  wifi: ath10k: drop redundant device reference
  wifi: ath10k: rename disconnect callback
  wifi: at76c50x: drop redundant device reference
  wifi: libertas: drop redundant device reference
  wifi: libertas_tf: drop redundant device reference
  wifi: mwifiex: drop redundant device reference
  wifi: mt76: drop redundant device reference
  wifi: mt76x0u: drop redundant device reference
  wifi: mt76x2u: drop redundant device reference
  wifi: mt76: mt792xu: drop redundant device reference
  wifi: mt7601u: drop redundant device reference
  wifi: rt2x00: drop redundant device reference
  wifi: rtl818x: drop redundant device reference
  wifi: rtl8xxxu: drop redundant device reference
  wifi: rtw88: fix device leak on probe failure

 drivers/net/wireless/ath/ath10k/usb.c            |  8 ++------
 drivers/net/wireless/ath/ath6kl/usb.c            | 16 ++++------------
 drivers/net/wireless/ath/ath9k/hif_usb.c         |  4 ----
 drivers/net/wireless/atmel/at76c50x-usb.c        | 12 ++++--------
 drivers/net/wireless/marvell/libertas/if_usb.c   |  3 ---
 .../net/wireless/marvell/libertas_tf/if_usb.c    |  2 --
 drivers/net/wireless/marvell/mwifiex/usb.c       |  4 ----
 drivers/net/wireless/mediatek/mt76/mt7615/usb.c  |  3 ---
 drivers/net/wireless/mediatek/mt76/mt76x0/usb.c  |  3 ---
 drivers/net/wireless/mediatek/mt76/mt76x2/usb.c  |  4 ----
 drivers/net/wireless/mediatek/mt76/mt7921/usb.c  |  2 --
 drivers/net/wireless/mediatek/mt76/mt7925/usb.c  |  2 --
 drivers/net/wireless/mediatek/mt76/mt792x_usb.c  |  1 -
 drivers/net/wireless/mediatek/mt7601u/usb.c      |  3 ---
 drivers/net/wireless/ralink/rt2x00/rt2x00usb.c   | 12 +-----------
 .../net/wireless/realtek/rtl818x/rtl8187/dev.c   |  4 ----
 drivers/net/wireless/realtek/rtl8xxxu/core.c     | 11 +++--------
 drivers/net/wireless/realtek/rtw88/usb.c         |  3 +--
 18 files changed, 15 insertions(+), 82 deletions(-)

-- 
2.52.0


