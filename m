Return-Path: <linux-wireless+bounces-10269-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7B5932F5E
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jul 2024 19:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA5FE280286
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jul 2024 17:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD501A00DF;
	Tue, 16 Jul 2024 17:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="nMXSASuN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward205b.mail.yandex.net (forward205b.mail.yandex.net [178.154.239.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F75C19FA6B;
	Tue, 16 Jul 2024 17:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721152213; cv=none; b=nxJyRyY5iC3TZoS74f0nQrS1gf7ULBS3VGBs8rHmoobu8hL3zSKVSS71V3imHTh1Zxi36TpHX9c7OB2JqaKh3rRftSr8S+LZNEQ6ElVUAy3sovHqZzN7UfImi/mf9AYdzeAEKEnpDGv9c06NuXCX80VtpVIMaYrSLTKAU3qxV6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721152213; c=relaxed/simple;
	bh=kOZIUp+7mOgkp0wgDzBOaf/49efLomQLDOPt3gEi1Fs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tONNQyMlRPSjYbLrXehLRNOqAU2qG5p3b2QeqlFjwpk5l0W2zz3D2hjJyxHIhSFx4HguD4ZXoB98tXqlnYVW/z+zW6yQgD71SiPnno/oL5JXWRAUvkkIFSH04gJfQIjuQRhO8g1huQfdqH7AdjonJMR8cjkG4U+Q9/kP+RpBj+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=nMXSASuN; arc=none smtp.client-ip=178.154.239.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d100])
	by forward205b.mail.yandex.net (Yandex) with ESMTPS id 42E4967014;
	Tue, 16 Jul 2024 20:42:07 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-25.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-25.sas.yp-c.yandex.net [IPv6:2a02:6b8:c1c:3099:0:640:f09b:0])
	by forward100b.mail.yandex.net (Yandex) with ESMTPS id 1CD6460030;
	Tue, 16 Jul 2024 20:41:59 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-25.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id ufL1En0RpW20-QBXoBI6w;
	Tue, 16 Jul 2024 20:41:58 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1721151718; bh=VBpeyVV4LcIg++K3/geizSkG0bnKgeREWv/ijcctgq8=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=nMXSASuNpFUW3SpVZksEwKBOoCcfoq701O2ADNZDsXJgEAYHquU4D0LLP+SyICgAB
	 u/yE/UpSvtxRQLRns33W6FE3UP1eOis/4vLEVaxTLQwWkYBq9o+UKanBCxkRrsTlJa
	 qqCbZbfjoP/ZIIDHUz8CliBhF5S1IFmD18mTv1qc=
Authentication-Results: mail-nwsmtp-smtp-production-main-25.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Johannes Berg <johannes.berg@intel.com>
Cc: Kees Cook <kees@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: wireless: fix more UBSAN noise in cfg80211_conn_scan()
Date: Tue, 16 Jul 2024 20:40:11 +0300
Message-ID: <20240716174011.236849-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Looking at https://syzkaller.appspot.com/bug?extid=d5dc2801166df6d34774
and trying to reproduce it with CONFIG_UBSAN enabled, I've noticed the
following:

UBSAN: array-index-out-of-bounds in net/wireless/sme.c:95:3
index 0 is out of range for type 'struct ieee80211_channel *[]'
CPU: 3 PID: 4993 Comm: repro Not tainted 6.10.0-01155-gd67978318827 #5
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS <...>
Call Trace:
 <TASK>
 dump_stack_lvl+0x1c2/0x2a0
 ? __pfx_dump_stack_lvl+0x10/0x10
 ? __pfx__printk+0x10/0x10
 ? __local_bh_enable_ip+0x12e/0x1c0
 __ubsan_handle_out_of_bounds+0x127/0x150
 cfg80211_conn_scan+0xd8e/0xf30
 cfg80211_connect+0x1400/0x1c30
 nl80211_connect+0x1549/0x1a70
 ...<the rest is not too useful...>

This is very similar to 92ecbb3ac6f3 ("wifi: mac80211: fix UBSAN noise
in ieee80211_prep_hw_scan()"), so just fix it in the same way by setting
'request->n_channels' early to help '__counted_by()' work as expected.
And the same 'kmalloc()' math adjustment is also applicable.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 net/wireless/sme.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index a8ad55f11133..f5da45331847 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -77,12 +77,16 @@ static int cfg80211_conn_scan(struct wireless_dev *wdev)
 	else
 		n_channels = ieee80211_get_num_supported_channels(wdev->wiphy);
 
-	request = kzalloc(sizeof(*request) + sizeof(request->ssids[0]) +
-			  sizeof(request->channels[0]) * n_channels,
-			  GFP_KERNEL);
+	request = kzalloc(struct_size(request, channels, n_channels) +
+			  sizeof(request->ssids[0]), GFP_KERNEL);
 	if (!request)
 		return -ENOMEM;
 
+	/* None of the channels are actually set
+	 * up but let UBSAN know the boundaries.
+	 */
+	request->n_channels = n_channels;
+
 	if (wdev->conn->params.channel) {
 		enum nl80211_band band = wdev->conn->params.channel->band;
 		struct ieee80211_supported_band *sband =
@@ -112,9 +116,9 @@ static int cfg80211_conn_scan(struct wireless_dev *wdev)
 			}
 			request->rates[band] = (1 << bands->n_bitrates) - 1;
 		}
-		n_channels = i;
+		request->n_channels = i;
 	}
-	request->n_channels = n_channels;
+
 	request->ssids = (void *)&request->channels[n_channels];
 	request->n_ssids = 1;
 
-- 
2.45.2


