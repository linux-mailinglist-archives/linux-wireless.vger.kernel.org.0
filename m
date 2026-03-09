Return-Path: <linux-wireless+bounces-32771-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPcPFe35rmnZKgIAu9opvQ
	(envelope-from <linux-wireless+bounces-32771-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 17:48:45 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FE023D0CA
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 17:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E890530F3D6E
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Mar 2026 16:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7D13BE14A;
	Mon,  9 Mar 2026 16:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=aerlync.com header.i=@aerlync.com header.b="kXflbBf8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F8B3A9D8A
	for <linux-wireless@vger.kernel.org>; Mon,  9 Mar 2026 16:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773074452; cv=none; b=Hew6A474jeVcg4Mol02BokIZNUvE6iCSKtwGMcKqY9OeKiHQ4n/Phf6hfCLDtEILsr9v5KH/q8apj8ELC0eYDVFy6qWVDWpUPMf0FrL27x7FMX3kAK1I6cCNbMZgqRUXlPMj9NcNBSK8Rd7Eh11MZcAjkpUwzhQeRFw9LbpgjKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773074452; c=relaxed/simple;
	bh=eXeIwJMHheR/8Bix+vP/U/KQfuj30eVi/sFej4Xz+ko=;
	h=From:To:Cc:Subject:Date:Message-Id; b=FxAyyrJFTrCU7Fg+c+jhtK8qJwJZG67fOIbmip3Ak+3N7IFsa6bi/SInSj5whuU7qI864AK7anmn2Wg9YUk4Z/vdl2YjuRUXSVEgE0bPkNxfT1qMM/+vuhQfQdDrVkAbj6HzNDOGfDKoZ7r8W9DaGzTwa7He/AWowR1M3fT3+7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aerlync.com; spf=pass smtp.mailfrom=aerlync.com; dkim=fail (0-bit key) header.d=aerlync.com header.i=@aerlync.com header.b=kXflbBf8 reason="key not found in DNS"; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aerlync.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aerlync.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ae3a2f6007so66365195ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 09 Mar 2026 09:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aerlync.com; s=google; t=1773074450; x=1773679250; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hOCmtBQwd2C+ycH7Sq1zpnPSsTJcZUkSR7ex89A0XhE=;
        b=kXflbBf8bqRMVYkIrfmJpoxWwHDbhCnSWh7uIC8YTio09GloaLgBsP2HVbzFp+1qWo
         lJ4Yx68QdzwsP7PNKXfr8GV7LQYzxFDWBt8/A1autGUAG/LJxdymy6UZtsO8w0Ulbt3v
         /xVnpetGbD4JsteJHkcCXLG95wB/luHPjCvmR5Ym5PIXQouBugBRMlnJwQ2ZENUy/MGj
         f8WICPnsQ9j1S6Np5mz49bGQj6ogcI4dlKtjmskEOm5yfVjbvsxAUDSyE5REB+OZDm64
         EzVns4mbkNLXaWEDW1ZgfEkLasPSQYa0KB72e41ixmPXkjZh05jS2Yc04s/URw6GGMnE
         hbCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773074450; x=1773679250;
        h=message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hOCmtBQwd2C+ycH7Sq1zpnPSsTJcZUkSR7ex89A0XhE=;
        b=uVnXykYD3lHDPjVH3EcUhg76Itp4g/iBAQmI9R8zUmNBVXuUpKCH4wgX8/plnAsXXI
         3lY/3LBWaFUUA4bz6g0K30ZvF4BB8lIpz8jf8hIqOfZb27Przk9e0BgSlDXiNiyiHK1j
         yVKKw0iFmEVaMfC7ETdL9XrVgZXBmdcpEj7Tz9uPauN1sbQhk7LxRIEYZUmEODspe6p7
         d8TqVRXWzD54ihcW86JxV0SeUz+WwfyzDSEJR8+BhF0JSAe2Q42MzTN36b9OJmI9nnER
         pVAIwTtwnyWG/DY9UjCfcvcplba2hCsQzIciVt91/pOSq5DIYhDl6NIsGJyABSkHmkZk
         NNlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVq6+lUDai3vpXUUIy2++eb42O8n2etSLRbDVagImbNEkrelz0JVZX6M/ea7iZfrKAWwgHklWzZPKJsZXKzCQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzqpj2VrwoPf/SrNyS8Z8XCosc2FXa6NZlTwUX+NIQOurDjHQ0
	PU0nXlprDLb9ZoQN6rJvRZRX5pI7BFzTSlenUEmnIWrpW3KGGXR0JSTZ1QGivOy9cg8=
X-Gm-Gg: ATEYQzwadmAucDi4Ikpzgh8aMd+evATJcA/l8F83KIu3KyyrNN0g/G6pTlo/bPkLEr4
	x9A2BXi7bHgLMK8x/nD7Gc2fGsUWwFTpRHNTfPO9vildNXXelbol9dheZ9uOAVBGV1d0lunMUiw
	XVRwGH8mL191nAjWh+Hvnbk+oKH6kHt7vI3CRibCfX+pw9tzp5rTeZnLMj+IK5Yna6pvQ7OzJar
	kul0l3s0b4eHQwjaRITh/89JIUjP6PK1UdettYrZP2KjioAI7371HANPe5A5tRLxK1sYeHrPrz8
	ClU6wio8IZVVToZpU1w54RUpzRAbapiXUHgITcQ9W0EbhlikAc2mUrK1FfQSv0GH+/Y8V+8c+NO
	PBdL3Al8PpeqZwbyp3uNX0Zxh6LEVvCjz7q8F/pE4vjC3MZzNIXEJAFM/Z0WgqXPR6G5K3Kygse
	7eTndaICQZ8jgZ+cgbOhnWf4FkfmpePJDqza5flMuBRLe0bgMFgF08TDQyTDWmon2c73D+7shg7
	MOu+wyhnW5pw15uueomhOUuJpBfs9l/uAgy0syUN9/98As=
X-Received: by 2002:a17:902:c401:b0:2ad:9b86:ddc2 with SMTP id d9443c01a7336-2ae82455273mr122083595ad.22.1773074449642;
        Mon, 09 Mar 2026 09:40:49 -0700 (PDT)
Received: from aerlync06-VirtualBox.aerlync.home ([210.18.157.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83f9d4d3sm114956505ad.69.2026.03.09.09.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 09:40:49 -0700 (PDT)
From: Ramakrishnan Rathinasamy <ramakrishnan@aerlync.com>
To: jjohnson@kernel.org
Cc: ath10k@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ramakrishnan Rathinasamy <ramakrishnan@aerlync.com>
Subject: [PATCH] wifi: ath10k: add chain mask and spatial stream params for qca988x
Date: Mon,  9 Mar 2026 22:10:43 +0530
Message-Id: <20260309164043.24859-1-ramakrishnan@aerlync.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: C6FE023D0CA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[aerlync.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32771-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_PERMFAIL(0.00)[aerlync.com:s=google];
	DKIM_TRACE(0.00)[aerlync.com:~];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_SPAM(0.00)[0.009];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ramakrishnan@aerlync.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,aerlync.com:mid,aerlync.com:email]
X-Rspamd-Action: no action

For QCA988x, the tx_chain_mask, rx_chain_mask, and max_spatial_stream
hardware parameters are not initialized when using the 10.4 firmware.
However, the hardware announces its max_spatial_stream capabilities
during the WMI ready event. The driver compares this against the
uninitialized (zero) value, which triggers the following warning:

"hardware advertises support for more spatial streams than it should (3 > 0)"

Consequently, the driver's max_spatial_stream evaluates to zero. This
prevents the device from associating with modern Access Points in
station mode, causing the AP to reject the association with reason
code 18 (Association denied).

Fix this issue by properly populating the tx_chain_mask, rx_chain_mask,
and max_spatial_stream hardware parameters for QCA988x.

Signed-off-by: Ramakrishnan Rathinasamy <ramakrishnan@aerlync.com>
---
 drivers/net/wireless/ath/ath10k/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 7c2939cbde5f..ead9c601f018 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -75,6 +75,9 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.otp_exe_param = 0,
 		.channel_counters_freq_hz = 88000,
 		.max_probe_resp_desc_thres = 0,
+		.tx_chain_mask = 0x7,
+		.rx_chain_mask = 0x7,
+		.max_spatial_stream = 3,
 		.cal_data_len = 2116,
 		.fw = {
 			.dir = QCA988X_HW_2_0_FW_DIR,
-- 
2.17.1


