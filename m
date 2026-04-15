Return-Path: <linux-wireless+bounces-34833-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDGvKPwQ4Gk4cQAAu9opvQ
	(envelope-from <linux-wireless+bounces-34833-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:28:12 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 07172408A02
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1F1A310C759
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 22:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D9B396D1F;
	Wed, 15 Apr 2026 22:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rUId50H3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C7D3939A6
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 22:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776291817; cv=none; b=baMulsO7rR52Ec+H8Z+g0b3ExoFfJaCIn2lsWKtFhN1OwMjlFSBYZN3+rgn6HeNMbg7Wq6mSlOXLk5hCRD+3CQ86JNadpXmyE2mlXXY+0Lcqrwx/wk9CILzP7CaHHpUuDRlvc/pHkYrcI4u22oRbw1iwATut7iYUdvjQlO2Y65k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776291817; c=relaxed/simple;
	bh=PxwwPq9nkDueG6TLNZISNg+W3JzNwekG6JdXfqPDMSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L/4OE2ECDQEBg44ZtGd/Pw79zxcx38c7/uX3/AdlXiLsdXhRIRd5x9yKHnBtvoF6EqLT9Fhzw3UFKbrhJV8wMY5daFqrwa93JhbeS0Q67qSQdHrk/+K6i5Hj+Ie1KPcSJyo74gE3tBVEdkHrzdLJVCMCLMqLb819YOEeCbkhyjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rUId50H3; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488a29e6110so77760045e9.3
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 15:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776291814; x=1776896614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XyyC/++Ur8xzJ3EzHxXqn8n/Dy2H2hU9GGsPdWifNWE=;
        b=rUId50H3hpxesoE+nO+JeWeuZh9pTX9ObtqW+/j7HYQ9RHu8V20t5uUA2kxIYCD2tO
         Vk1vVTLOf2O7RYA0DboENNQ/ETjYquuKK/jcLZwRvsn9BjeMyskMxreKdsLOdHoS6sdo
         9DTCCxudGiaUaluWgkQyRXBNYw1eeqpjqr9Qc9LtGEqBQzTkaN6Z5f5WuF/oxXegFM4r
         fHSmpEJbipr++1Irjvic0+jy8FIR2WsqH3fyZ2t1wqHyk/FsRkmH42XqTov9nmC7+Quq
         UHcJQpuW0mIGyRC1i4qjRe3+xyorRQ4iFm1exbXjh8Z2xdl2ZU4a21aGQ3PE1EUOQjVl
         fMDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776291814; x=1776896614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XyyC/++Ur8xzJ3EzHxXqn8n/Dy2H2hU9GGsPdWifNWE=;
        b=C+wTudIjoPIGuALIpxfF/pA8jI3uK4yP5PWlB7oJ0Kd16apAZu7Kiggu3rvVhG48ZF
         2y/8P8Yy7Fj9Inr0z/dHzIL+9p+B5Gl4zjbJbsY0ZdDk1HADU8YC5k+B/KT5SQl2fg7e
         OTfvG0i2lF8owZStTo6JRt9AQwXUecHpdik4xmU4ODDTEQHYq5zyklO/GU3USCpN+EUF
         M2Kmwcdd2COtKMhDYV6YMB3XHgMng/AjMK1wjwS4dp7hVQkaiZse/OJNsrLm20d4IJrI
         Kxk/u4pRapowLxDkxJMKlbODj1LkaScIk+cmAGoQ0IKWELq3YsSQGBReVedUkm+AigI8
         LeCA==
X-Forwarded-Encrypted: i=1; AFNElJ/rc7R8YmF2O8agmUnCW9Rvz502rQSlL1P5sO3//heTEca4EIdjL7LBUTf9pzsa/Mv5paTUigPzNfbg0OzOQA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWbDI2Hn7q1w4v4huJ2sAHjhUzerd+VXNXoBparyqGO06XmtzQ
	LP202hvZSqHrseGXTHRiETitMj47O99kwTqY4jg//R9vvxWqiFfY/tI=
X-Gm-Gg: AeBDiesoVwdQbVPBvos2+9XMW5sQkR2/J6qxBq9QcaybIsoaXNaNCEXcopnTAODefYA
	rsj+748Q6+Il0idyErwejwoLIZW1OTX/KOXqXZiMQ8q/LfWBql+21mlo50rJjplPogNzsHLKIWp
	H3kS/ixYQdGoblu6qPfmAwlZM/3EHlCuOwy2UUsQ2Zne9XNNvDEfVEfkzZvvJB9MrXgnr8Wmebt
	ivX1of5nBWY7RQvPXSYhnrVDLVn1zFNLJzJmRfJYegSHwrLMq8ZBzF16LfLrb/TRhjmo2cVBe0K
	mchS1YstxWtN9Ag3x0ZyUlcSxSY+GQJdGTPVgR0QDTYDdZp1iw+nuSMozOui3VUwsW5v9bYtVGf
	wZyF/CazW9kffPxG3Qx4fsr6rejW4VOKRBFKF6T0J75ZptAtFZqnjUYFhIr0W/0+QGKO10MN5VT
	iLI1A=
X-Received: by 2002:a05:600c:4f56:b0:480:690e:f14a with SMTP id 5b1f17b1804b1-488d68765fcmr350038225e9.14.1776291814462;
        Wed, 15 Apr 2026 15:23:34 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f0eb3842sm30160995e9.24.2026.04.15.15.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 15:23:33 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Brian Norris <briannorris@chromium.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] wifi: mwifiex: fix OOB read in scan response from mismatched TLV data sizes
Date: Wed, 15 Apr 2026 22:23:25 +0000
Message-ID: <20260415222327.1539269-5-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260415222327.1539269-1-tristmd@gmail.com>
References: <20260415222327.1539269-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34833-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[talencesecurity.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 07172408A02
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

The TSF and ChanBand TLV arrays are indexed by the firmware-controlled
number_of_sets without cross-checking against the TLV header length
fields. When number_of_sets exceeds the TLV data, the loop reads past
the TLV data into adjacent command response memory.

Stop using the TLV data once the index exceeds its reported length.

Fixes: 5e6e3a92b9a4 ("wireless: mwifiex: initial commit for Marvell mwifiex driver")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
drivers/net/wireless/marvell/mwifiex/scan.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/scan.c b/drivers/net/wireless/marvell/mwifiex/scan.c
index XXXXXXX..XXXXXXX 100644
--- a/drivers/net/wireless/marvell/mwifiex/scan.c
+++ b/drivers/net/wireless/marvell/mwifiex/scan.c
@@ -2188,10 +2188,12 @@ static int mwifiex_ret_802_11_scan(struct mwifiex_private *priv,
 		 * received.
 		 */
 		if (tsf_tlv)
-			memcpy(&fw_tsf, &tsf_tlv->tsf_data[idx * TSF_DATA_SIZE],
+			if ((idx + 1) * TSF_DATA_SIZE <=
+			    le16_to_cpu(tsf_tlv->header.len))
+				memcpy(&fw_tsf, &tsf_tlv->tsf_data[idx * TSF_DATA_SIZE],
 			       sizeof(fw_tsf));

-		if (chan_band_tlv) {
+		if (chan_band_tlv && (idx + 1) * sizeof(*chan_band) <=
+		    le16_to_cpu(chan_band_tlv->header.len)) {
 			chan_band = &chan_band_tlv->chan_band_param[idx];
 			radio_type = &chan_band->radio_type;
 		} else {


