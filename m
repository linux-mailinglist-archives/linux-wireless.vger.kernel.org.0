Return-Path: <linux-wireless+bounces-15604-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C749D630C
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2024 18:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 667D2282A66
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2024 17:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B971DED7F;
	Fri, 22 Nov 2024 17:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="spyhUFMy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1771DF258
	for <linux-wireless@vger.kernel.org>; Fri, 22 Nov 2024 17:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732296499; cv=none; b=cHZpzPchelscvZB8kKVLH77abDrauJkIbC+okJZrgfb2rdgZVxjHBskgFPD9KqzIhLlP6GQ8e1cQm8NOiaXImpTDjO5nbph1Pp+O/7RJJRzkvzEwt3R8JxgHuuqMMlIcrbEDRpaRErVcmUx7c1ku8SRdbOiFBgXs4FpmOzSNXiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732296499; c=relaxed/simple;
	bh=DUu/kV/sj7/aNSCD2H7UD0jl9+pbegGBYOcEKXVStkg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gjaIqYeALuBBjpYyQLAsafk6Tuu1t7j0gQsCa73IrApPj5IEWWgOnDP6OztcKYKy6C0d6yAVrJYZ9/oBPnYdJ1L4vMQvE/W/6F9qASGhRGisNkZuWpiZiXHAEopp7UfX6yaxfV2WeqKIaxsnq4ZGAKg44P1p/Xw8APLCASNw9Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=spyhUFMy; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=zY/VFU48EGZA2yl1fWCJwihiakJ0uqVijBFwTZQqS4Y=; b=spyhUFMyF1nXVMrLX2p539lWtX
	uOlKWFrh4cXDWaCMqxV+hb89bLWRmah1Hb+f71QOmsx2x/uYD0JqivWGoeyJx35fWJEyj4tH9iAyC
	m7M8hzRXpcNwOiVLO6spS3t79bei4Me3X/XwlpygmqAHAjj1/5dYdNMZVP2ELf2GCTpyZGVM6aKA+
	Oiaqwnq8vcyoHSDtXt+eA837JvfWgJIQIQeToC65MXkB27mGJby0oSHvSHm1WnHhdiSfOp2ii4JD9
	hY1CGkuqvPapJkYmmsVDKKQ/YFwaHeCvqIM685fV/qxxd4JxVdYeCLq7AptM/2u71Aw/Fc+v3lXMs
	4lyj28jQ==;
Received: from 179-125-75-203-dinamico.pombonet.net.br ([179.125.75.203] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tEXRx-00B3IM-K6; Fri, 22 Nov 2024 18:28:10 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: linux-wireless@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	kernel-dev@igalia.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 0/4] wifi: rtlwifi probe error path fixes
Date: Fri, 22 Nov 2024 14:27:14 -0300
Message-Id: <20241122172718.465539-1-cascardo@igalia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These fix different bugs when the probe fails. One of them is the addition
to a global list, which is not removed during the error path. That list has
been removed.

Then, some memory leaks are fixed, which require a change in where the
workqueue is destroyed.

Finally, the firmware completion is waited to prevent its callback from
accessing freed data.

These were tested against an "emulated" rtl8192se. It was a changed rtl8139
device under qemu with the rtl8192se PCI ID. Memory allocation failures
were injected over 4 different places: init_sw_vars, rtl_pci_init,
rtl_init_core and ieee80211_register_hw.

Thadeu Lima de Souza Cascardo (4):
  wifi: rtlwifi: remove unused check_buddy_priv
  wifi: rltwifi: destroy workqueue at rtl_deinit_core
  wifi: rtlwifi: fix memory leaks and invalid access at probe error path
  wifi: rtlwifi: pci: wait for firmware loading before releasing memory

 drivers/net/wireless/realtek/rtlwifi/base.c | 12 ++---
 drivers/net/wireless/realtek/rtlwifi/base.h |  1 -
 drivers/net/wireless/realtek/rtlwifi/pci.c  | 60 ++++-----------------
 drivers/net/wireless/realtek/rtlwifi/usb.c  |  5 --
 drivers/net/wireless/realtek/rtlwifi/wifi.h | 12 -----
 5 files changed, 14 insertions(+), 76 deletions(-)

-- 
2.34.1


