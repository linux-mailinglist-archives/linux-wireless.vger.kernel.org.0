Return-Path: <linux-wireless+bounces-11766-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB42395A684
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 23:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 183F11C22589
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 21:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDF01779A4;
	Wed, 21 Aug 2024 21:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XBfwm/Ad"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7FC13B297;
	Wed, 21 Aug 2024 21:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724275434; cv=none; b=W0mjudWcK4trmVjz+yyswx6uULxmqHBqhjoagSxQEtrIHrzCwF6dpbaKIpPSrNacg/lWB42yojzoOK8HbZpgPwUinNbskn+eMP6LOH2GGJge4EdIw7AbLIYARe8JBuPU0J6cKdCzFfP2zpCei/URuyc4rYCtnVbGCLVOvsOV/SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724275434; c=relaxed/simple;
	bh=PzLqGHvOXwyQLTg41anHtMxB0A7b4fkuaaKAj8ko3cg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=P4DZjy/JYsj2hTaZ3QWqPIxu5IFhbY2T8YKG3VUyUVYfnZnk303fxWOhf7NyWFIdeSYGDOG+djbR8rw41HJw1nLfmPXoRvwEXa6sbfuoGVgS3sQ4fG6CBz2BwQl+P8YSOJ7pguvrZpK260gAqdsyDBXrl46MnOzzT8Cx50aAxI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XBfwm/Ad; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 852E3C4AF0E;
	Wed, 21 Aug 2024 21:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724275434;
	bh=PzLqGHvOXwyQLTg41anHtMxB0A7b4fkuaaKAj8ko3cg=;
	h=Date:From:To:Cc:Subject:From;
	b=XBfwm/Ad2XGco1F1AbKBrDg8sGhv6ECLhpjFQ+0UfMT/JhtU/URGvBt/04QcSkCef
	 IArAwA8+q13w3k6U7b6MwDjxJ/kweJI0HuHRgizDG6PhyHy+ektI/E3OpOy155EVq0
	 8vpYK9wMW0+M8+7DVA2pul9UU93b6yKQ9lS0t45CtWkeOvv5zV6nCI+E0qpSE4mMlI
	 jfnAbbBtL6DMAVrwXP8voc1/buEtT5SYw9Tk1vp97c+J0GZUYOEeuDU5PXxekR0VYH
	 AwNk3OI7JsCUTsq5ocQz/oeZo0bKZd3Tp9gKFwqjmt5dE83u8VspeXnNK4xJbUNDXE
	 X0vf1DdB+9CAA==
Date: Wed, 21 Aug 2024 15:23:51 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Kalle Valo <kvalo@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] wifi: mwifiex: Fix memcpy() field-spanning write
 warning in mwifiex_cmd_802_11_scan_ext()
Message-ID: <ZsZa5xRcsLq9D+RX@elsanto>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Replace one-element array with a flexible-array member in
`struct host_cmd_ds_802_11_scan_ext`.

With this, fix the following warning:

elo 16 17:51:58 surfacebook kernel: ------------[ cut here ]------------
elo 16 17:51:58 surfacebook kernel: memcpy: detected field-spanning write (size 243) of single field "ext_scan->tlv_buffer" at drivers/net/wireless/marvell/mwifiex/scan.c:2239 (size 1)
elo 16 17:51:58 surfacebook kernel: WARNING: CPU: 0 PID: 498 at drivers/net/wireless/marvell/mwifiex/scan.c:2239 mwifiex_cmd_802_11_scan_ext+0x83/0x90 [mwifiex]

Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Closes: https://lore.kernel.org/linux-hardening/ZsZNgfnEwOcPdCly@black.fi.intel.com/
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/wireless/marvell/mwifiex/fw.h   | 2 +-
 drivers/net/wireless/marvell/mwifiex/scan.c | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/fw.h b/drivers/net/wireless/marvell/mwifiex/fw.h
index e91def0afa14..d03129d5d24e 100644
--- a/drivers/net/wireless/marvell/mwifiex/fw.h
+++ b/drivers/net/wireless/marvell/mwifiex/fw.h
@@ -1627,7 +1627,7 @@ struct host_cmd_ds_802_11_scan_rsp {
 
 struct host_cmd_ds_802_11_scan_ext {
 	u32   reserved;
-	u8    tlv_buffer[1];
+	u8    tlv_buffer[];
 } __packed;
 
 struct mwifiex_ie_types_bss_mode {
diff --git a/drivers/net/wireless/marvell/mwifiex/scan.c b/drivers/net/wireless/marvell/mwifiex/scan.c
index e782d652cb93..f7153472e2a2 100644
--- a/drivers/net/wireless/marvell/mwifiex/scan.c
+++ b/drivers/net/wireless/marvell/mwifiex/scan.c
@@ -2536,8 +2536,7 @@ int mwifiex_ret_802_11_scan_ext(struct mwifiex_private *priv,
 	ext_scan_resp = &resp->params.ext_scan;
 
 	tlv = (void *)ext_scan_resp->tlv_buffer;
-	buf_left = le16_to_cpu(resp->size) - (sizeof(*ext_scan_resp) + S_DS_GEN
-					      - 1);
+	buf_left = le16_to_cpu(resp->size) - (sizeof(*ext_scan_resp) + S_DS_GEN);
 
 	while (buf_left >= sizeof(struct mwifiex_ie_types_header)) {
 		type = le16_to_cpu(tlv->type);
-- 
2.34.1


