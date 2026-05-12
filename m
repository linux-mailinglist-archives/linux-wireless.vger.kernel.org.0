Return-Path: <linux-wireless+bounces-36276-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KO5jF2iGAmrVtwEAu9opvQ
	(envelope-from <linux-wireless+bounces-36276-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 03:46:16 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3225518655
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 03:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 381D230391EC
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 01:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021C32EBBAF;
	Tue, 12 May 2026 01:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtAlxA+G"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76F12C032E
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 01:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778550304; cv=none; b=Ypx+UzmEVrxfNDjVSrmiKRlV7msxCHSMgOvN6/tfiCHOcKMhSnQdhpFkStA05y1X58jtCFinEKjAb+53x5XvTOIWBEcdRbziFtMNq9naY1EEpRPGfWm+e77mfb6d/HGznl/yqTgL41m719NIzfZLViG8QHuTzwJnnJVH9iXeTuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778550304; c=relaxed/simple;
	bh=04mrtEa5PdHocCigzzaMYLeTA1Gx1ZWtCa5+sch8j3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R6cwMhA8VXizKj6JBgL4woGa/N6dx56P3Nt68hQ9cilrU3PqOWrzEB/WWjv3LSzNk+NVqF9jjM7kxHOqfelijcXTRpZ+4ia5+2oioFzBVEwNX7kRDmecM6UhxFurn9l8Qz+Xj7QqVOsepcCjNPLIJvm06OOqL0CnNHWlvQb2AJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dtAlxA+G; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2f03d6cf77bso5542953eec.0
        for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 18:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778550302; x=1779155102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8RsKAyjFR0CIqyuPNV+dz707ncCEoIu00NYQpJfyiZw=;
        b=dtAlxA+GUm8Z5RLovRDbklaGFHvQJT4TV5md+qyHbxo+wQbjj1hUZl8kFjgXHNHMr4
         WCqyYNKwGBOC8vC1H0Z4EATdgQB7XmfJPIxpHORv+MbTIFXw54XV2j0psVcMml8Ykpyy
         TReyZh42CczkuxuRCjaIfsvqo1uugrOl4P2Pto02mMghT8n0MnGa58w5KddccllBWWnf
         BHZiKYEstOUPlnvtyif5VouBzLaaHa7BbQsW1oRM4wXNZVkioqjJHTqA/D5NztgPlIB9
         UdKKOU4uYgp0q9LSR5cf/S2ZsTZYo4Qcguq7DGoDzxzyEk8UQaYg6pC4hA5xX5XX7cGt
         RXsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778550302; x=1779155102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8RsKAyjFR0CIqyuPNV+dz707ncCEoIu00NYQpJfyiZw=;
        b=N/iW81ioz7+mUUkmQhoomJIfV6U8foiXt3Yog7yCFvhdj5Zmbiff66odBM+QfebVS6
         Jz3gjtWGWk17YIZP3ZFZkC59KSyhV0L44WTNt12mkYoZveNqK/9XLRifMAWjxSuJ7FQY
         xwmCY4QSrO0hvbJxkplMabmyIQ93Mg9EI0/x7KgmkNZvS1sBxx7Aecn29ljzRK8GPXFt
         g0/Kom99PKQzlUMDQYmotPbQe5hcBIYDsCRtlfFQ/P3IRMp3la3hCp5Xlp5uMtvWbgsw
         UiyOGl/SmZqmMl5XB9+8JGfBURDj2Q//VC3RWxXfOGeAFScTOam79CW1qbtOlhdVJeuG
         X4DA==
X-Forwarded-Encrypted: i=1; AFNElJ8Gq1psFo0PjLNJ8MGc+OXH85yKgVb1njFRSLTTy1DlCuEtIIUNILGvUFLokDodVoNSd4RjAwuNr/hyNDpCGQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwT5IHMKWVN0RoYvTiw1496ndx056fduR0U+RQ4PjKpfoExGnBU
	vdv2UVyWO6sPXKQQawvFrnVSKi5b8tVVgg/YBQ/8rpUnsB6AG7lfLaCHSQWqNLHd
X-Gm-Gg: Acq92OGuO+PWbGqY7xo1qqUcrrDhPgg/lvWsBLV5jU9nwkCYZDfg5vd3SOlbPk74HYa
	OZFVGjHnoaxVZyyAG92nKAqyCYIZfeHJTmcwHUbT0Op+ihCK847+ggL6NfL/cj1hLmoh0P6sTDo
	6go9UxbeXgjA8crVYgmNOkvXH7+j90spAqJ9nn/QHvhfEVKfbvVozMGHDPSt0wJ9t9cyOZ0VpsH
	v/XKtmobHqid03eRiDFs9EFCDwSDWAYh/o0tTiBLIrvMoNhK7/JvTlCXVH27RZJAOfPVgMxUJwE
	bOyUco5aObTYlcI5Np7c/9LOgV7PRja00SwjH9XJXZB9AJkUVQgsWJ06dBTrUUZPWGxOYeK/W8o
	eGZrh9u7pFIqV1niPrjiPLVCGIXnAnqswZrxM9XQ8bnSzvJhjjNcYg+RBpVDkp1N0IuW8RYrhOe
	RpuyjEX2xCxBN+HOF6Bzs8ja+oOSEsmvQX89lQOC4pspJXIOIHz4MO4d1ydI+sg2wqrh+rYrUhy
	4zdrfmJ0fRGFsEfVw==
X-Received: by 2002:a05:7300:7244:b0:2ea:e93a:ff9b with SMTP id 5a478bee46e88-2ffd5cbbb6emr603958eec.13.1778550301525;
        Mon, 11 May 2026 18:45:01 -0700 (PDT)
Received: from localhost.localdomain ([50.231.3.67])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f888e4016asm15816499eec.28.2026.05.11.18.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 18:45:00 -0700 (PDT)
From: Shayaun Nejad <snejad123@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Shayaun Nejad <snejad123@gmail.com>
Subject: [PATCH 1/2] staging: rtl8723bs: fix use-after-free in validate_80211w_mgmt after decryptor()
Date: Mon, 11 May 2026 18:44:55 -0700
Message-ID: <0f4cbf05a7a594be4629ca4d7c108e6df1463321.1778550157.git.snejad123@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1778550157.git.snejad123@gmail.com>
References: <cover.1778550157.git.snejad123@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D3225518655
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-36276-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[snejad123@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

decryptor() can release precv_frame and return NULL when protected
management frame decryption fails.

validate_80211w_mgmt() still uses ptr and pattrib saved from that frame
for two memcpy() calls before checking the returned frame pointer.

Check the returned frame before any further access, then refresh ptr and
pattrib from the returned frame.

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Signed-off-by: Shayaun Nejad <snejad123@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_recv.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index f78194d508..0e1d248d8f 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -1433,6 +1433,13 @@ static signed int validate_80211w_mgmt(struct adapter *adapter, union recv_frame
 			if (!mgmt_DATA)
 				goto validate_80211w_fail;
 			precv_frame = decryptor(adapter, precv_frame);
+			if (!precv_frame) {
+				kfree(mgmt_DATA);
+				goto validate_80211w_fail;
+			}
+
+			pattrib = &precv_frame->u.hdr.attrib;
+			ptr = precv_frame->u.hdr.rx_data;
 			/* save actual management data frame body */
 			memcpy(mgmt_DATA, ptr + pattrib->hdrlen + pattrib->iv_len, data_len);
 			/* overwrite the iv field */
@@ -1440,8 +1447,6 @@ static signed int validate_80211w_mgmt(struct adapter *adapter, union recv_frame
 			/* remove the iv and icv length */
 			pattrib->pkt_len = pattrib->pkt_len - pattrib->iv_len - pattrib->icv_len;
 			kfree(mgmt_DATA);
-			if (!precv_frame)
-				goto validate_80211w_fail;
 		} else if (is_multicast_ether_addr(GetAddr1Ptr(ptr)) &&
 			(subtype == WIFI_DEAUTH || subtype == WIFI_DISASSOC)) {
 			signed int BIP_ret = _SUCCESS;
-- 
2.43.0


