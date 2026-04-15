Return-Path: <linux-wireless+bounces-34851-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oD2fAIkR4Gk4cQAAu9opvQ
	(envelope-from <linux-wireless+bounces-34851-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:30:33 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A26408A7B
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B178331AF784
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 22:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CC73932CD;
	Wed, 15 Apr 2026 22:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AmjuqL+V"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422CE39D6C8
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 22:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776291863; cv=none; b=pg+d93EvXnG6FlEjmURxQ9Q3FREgXTYEozmYXlWrfxp+8b63CZnz9vijgEBB8GF2VI3mTL5YRyFp+2MLEhGnaLCsVj6iiATCDQrO3RQiEqYyAvXLBLLrOxSMp4Gy+7xTjCksKSvM++O6Yaj/gsMWHvca9NAiMVY8gotgUZqloCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776291863; c=relaxed/simple;
	bh=m/VzyHT4vuprIKq4IpG1sBTLIdieid/ssyPjAOfBgNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QExHaCGqrbHOQRBaYEJ0FAA1ngc4teGr7f6SNNI4RY+x+9HSARFsYAgOTKEKwOXFKt/s3x4ZMiZ3uBEeH/X3wRXGGaaAJrn2I9iCz/CISP8THBM/Ua07o2UdBAJJOi693mo+xRMy7wTRY7l0wPbAB3cfsZND8Wlwc2lz5lGv3Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AmjuqL+V; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso68235255e9.3
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 15:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776291861; x=1776896661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SnqMIjiLCUCNTh5FmZDiuIaFUxp5jhQc4QflEtGRWbY=;
        b=AmjuqL+V5qV2lxf/52ZFLLJKus06l00vKNDj1/j05iby532DH2va4oSrvIYEKYnvfB
         3rAyxvucrQ1OmZJzUV9s6DRLVFzoDBOMagh0dYPSBkbGef/AfrTe4euVTRebg/D43/vX
         Y2Azlgi2sEYjogysfuBJUaRXMdrXiYOG1H6SLaf8/Ud/fMaefEvPeJBrtHxfrCl+7I2k
         fPIdy4L80IM4Lp+WGqwCYs32f2NfitmhnVHbthUNs41a3CiuiX+gjO5ICeiTxR+Hbf8G
         kKN8YhPRTfY1SUgJ8qmZ9f30ykuET6bjlvJ0BWOx57mRpkU4DtZZ29I8vOszEYDJRYG/
         bBmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776291861; x=1776896661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SnqMIjiLCUCNTh5FmZDiuIaFUxp5jhQc4QflEtGRWbY=;
        b=I9vHKclFPkOhgvz68DOyJ3DuSBnJu0024v+kgXyTuBAe+XEtz96QT0kF7gAOyY+X05
         YIoNbvwRFTCPJlJ2WkdgDGGkYYBUza/URu5XHfGIE3DnbfYiX7fbFsuS/6oXqwXGRbMW
         Fm2pcdth6ihphOY7jw2DkaZaf5VYYDvrT8kTLiPy9WBseN4xs3HiYWTL1LQVtg1lwEvg
         Bquogqo0E5yuE4Dyki1EVlBOE0ZM8X6keIR2BLYbXd+a+Ntbbd7dnyvcOFVxESL5VzIo
         Mjstbb4t0y8gGEL0C8pnvM77NFwE65wjMqDQlOMzpjPqFcFFkrci/99MNHClL+CaRTkY
         RODg==
X-Forwarded-Encrypted: i=1; AFNElJ+w9qHq3/jDgH1e17snPmxoy0LuFEJ7QJbjlOYsskmnAEz98ofkJL6kIIqmrpfAMIgKQAnvO3+W+R/43sJuSA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxeFbl4rT3Q+vVsJAVRa04hPkOExtByEyPUSkesRUEL1nqu7FUH
	3TmkgdSnUH+zLD8Jn+MJQ2pmzzSU+irgOuVcVuIAFeYmTmWQEgIHp3M=
X-Gm-Gg: AeBDievYO/whYT3Pii86o111BG0r+sFZtIpumVDO8r43lD10SoeMlGQmATp27buBf0n
	WfFfo5fTNI5XGpz/2/mTaUfPSdGFqmgHklY0l71kDgujvvhN3iMRTZBnIB8Oni7wRfeEjjkOBfh
	4MevLlHPETBJw98lSses6Lqi0ImgRr2e4MIyCk0dlw8O/JCSL/Qh8O6tOhuhNZzmWjVmUwqJbnW
	57c8A6gDx6Boj3453+5kX5GBy/nz3aggiFX1XhAgPryUlGeC6wDur2blo0uh86/vvFpVMuKeJ/b
	aiRZjuDft/U3kLkcYhXiM2gNcZt7/KtiplWXiSFIYdLysL1MOrqzqWNAvSJc585S1fhj48uxRrO
	kl8I2woagGXfi8KdKj3KGOxsv6exwXfp2H11RckMTHPm3qiimiW0x9W/HryyBfdG/d60Bubi9GU
	5loaSBQxWOq9zPwQ==
X-Received: by 2002:a05:600c:a404:b0:487:1108:48b8 with SMTP id 5b1f17b1804b1-488d67b8d97mr278034375e9.2.1776291860629;
        Wed, 15 Apr 2026 15:24:20 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f5813954sm1890655e9.3.2026.04.15.15.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 15:24:20 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Ajay Singh <ajay.kathat@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org
Subject: [PATCH v2 2/2] wifi: wilc1000: fix OOB read from firmware RX packet header fields
Date: Wed, 15 Apr 2026 22:24:17 +0000
Message-ID: <20260415222418.1543832-3-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260415222418.1543832-1-tristmd@gmail.com>
References: <20260415222418.1543832-1-tristmd@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34851-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[talencesecurity.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 86A26408A7B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

The firmware-controlled pkt_len, tp_len, and pkt_offset fields from RX
frame headers are used without validation against the buffer size. This
allows a malicious or malfunctioning firmware to cause out-of-bounds
reads from the RX buffer via wilc_frmw_to_host() and
wilc_wfi_mgmt_rx() memcpy operations.

Add bounds checks to ensure tp_len does not exceed remaining buffer
space, and pkt_len + pkt_offset fits within tp_len.

Fixes: c5c77ba18ea6 ("staging: wilc1000: Add SDIO/SPI 802.11 driver")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
drivers/net/wireless/microchip/wilc1000/wlan.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/wireless/microchip/wilc1000/wlan.c
index XXXXXXX..XXXXXXX 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.c
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
@@ -1122,6 +1122,12 @@ static void wilc_wlan_handle_rx_buff(struct wilc *wilc, u8 *buffer, int size)
 		if (pkt_len == 0 || tp_len == 0)
 			break;

+		if (tp_len > size - offset || pkt_len > tp_len) {
+			dev_err(wilc->dev, "invalid RX header: tp=%u pkt=%u remain=%d\n",
+				tp_len, pkt_len, size - offset);
+			break;
+		}
 		if (pkt_offset & IS_MANAGMEMENT) {
 			buff_ptr += HOST_HDR_OFFSET;
 			wilc_wfi_mgmt_rx(wilc, buff_ptr, pkt_len,


