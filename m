Return-Path: <linux-wireless+bounces-36277-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMgBIeOHAmrVtwEAu9opvQ
	(envelope-from <linux-wireless+bounces-36277-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 03:52:35 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B85D5187C1
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 03:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAA0C30895D0
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 01:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72844311967;
	Tue, 12 May 2026 01:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRMaQD+5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8522E2DEA75
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 01:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778550307; cv=none; b=g71oNfZaTkfDAtGcEvuKxP9XxDV3AhcuQ+goD8fosOl3KBbxOcA+ZN+CBwlOdLQupdIsJC0aA+ijjrxPzzwKktTjZGZO7h+jl76rhz6BYj/iCb49/On5SHk8Cnv1goYimLKxcdFSCGS6ZlDE+bzX7cEGtz+nfFpMOQXaH9Y8oqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778550307; c=relaxed/simple;
	bh=KqTQRneBMfvDtD0NGh/qnie7L+jkNNCpExxYKyw+jhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P8/MWtggBONt/h5wrkECwYGFJBbzbpwbxXVtBkquu+BzmEFtTqXV9al9F6d65sEuu9y/Q537NVCC2Tmkurz8DfvkNgtnSp3Vf1Sn0qWWhM/BG7EATHA4WPkA9WME/b8LIqdf7vNZTZ2A3XzqoKdQI0X83lKHFfZPPiZqoiKQTqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BRMaQD+5; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1334825de43so229002c88.0
        for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 18:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778550303; x=1779155103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yt10RUM2UXri9I9UIGCyRKsgv2xs4QwM0yEoyhATCiU=;
        b=BRMaQD+5wwXguex3EVGHXCScmPyYE/dProi+e8W9e4PQY6XHxEvBRQMSfusNSAO/G+
         /msatXHKYPXaz3QvF8PgQxmjhuRo+FYgENGX87yydUCT3n2B2jTUVXHMpLEbbsJBKYHm
         qoDwi0L1j+u+nJN0hlYixzwqsw6NFM0ndpFhBZpNGWFwoZXcTSDsx63S4HY5UxSywxTL
         IFKRczMPZjGv908KDpuWU+uT+afmggQ8jXyYjkn4z+fxz/+PdYjcEiXl1g4Zk5aqpOq7
         l1UHha39f97sGP5M/anaZ9L/W/LXmfAQLCFCanGxYBaLWgJ7jm4WnJMvzW2oQIdA+uoA
         sfVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778550303; x=1779155103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yt10RUM2UXri9I9UIGCyRKsgv2xs4QwM0yEoyhATCiU=;
        b=G3af+Ai4xEHxYOm+ykOwZs0j90SMQxNbJbIHX+y02J64OKljvuK1ORIFS+pq7pZFZB
         W8Qvej6XijA7TUfpMZWEeSjQE9b9Mq09sVvQgKuivhAkbeDv9rFUOShhAyIcTYPHQIQk
         qPHYrGsRLt5GVTNiSe9n2TAmcESwFwgsW+plfFwS+Es1h6DZ+aWAtDI1ysX1Akk2gM4B
         st5LT77Zb7wGDna7N2Mj5scYxN1rRA6Int5evkskXegJBCydolgNIXTizgbjceBnoFOI
         F9QDN05+vBvT7BZbAuNTNscCrpyMbvEvFzQ+SVoepIDCgHSQwpQRTf8Ku7WaTEJPIQ3I
         4evg==
X-Forwarded-Encrypted: i=1; AFNElJ8H7wvOgTiC/U/IubNDjew4fYBcxZM1lrjNzjkec3xz+5ryoQ/7JXWMjYy6yu1ROOZynF1lWWxAoVLbOnq0wg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxvDukIoQc/GGlfc2vfzTOdwO/WzagQ0TpPNMTn1B0LmqSTiMyi
	jt3D+JR0DuC+DArJM3v9nlaeGg/aLDbdx9Hm/t1HAu/ISkB6+0oKQxUZ
X-Gm-Gg: Acq92OG/zl3ZRPg36r4IWnH8DKrJRnn46gFThp321Ciw2QdfQ/ULxJsRXcWTLn0OxPD
	bn6tZ1t3c2bNbE8hw8tkyem0IG/632P9VznHoGw8HDYe518NWOHB8Cfsd7NsBIh736kmk3IB+Hp
	dZWZj0UHLBAqsgBuZgif0hZOmZHM1RV2u/8tDYoJpZeeeL5XdZKJ0foi46LbG1Gp8nR1cAk9aF5
	03ETiWF549EaZkArtrarUxn8JU6GGGQJD58q1kZ4/ZGWF6AryZG9KJZhEqziKeGbYcRy1p1F/w8
	JtHsRuLiLHvTOToTE5tCF142qcOY4UBcneYgJYttMvaEu0GhNhzsfc7T3OXxPlgIhGXjKwdiJUs
	ds/yssG8VLHzO0IEGnmAlLbzhmu2y4cCGnFn+sjalc4b5aC+aFQyqtrhnTJ/Vz56HO+k6RAn01x
	HibimRmeKrBoUuRDISe4uGi8UcCvmBhwEzmWt/ZnzUtciJ6zSNi/pioFwQgKhUrwIgtxCREfjTI
	JoH9AM=
X-Received: by 2002:a05:7301:1f18:b0:2d2:c60d:4fe5 with SMTP id 5a478bee46e88-2fb4b92173amr5138362eec.6.1778550303413;
        Mon, 11 May 2026 18:45:03 -0700 (PDT)
Received: from localhost.localdomain ([50.231.3.67])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f888e4016asm15816499eec.28.2026.05.11.18.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 18:45:02 -0700 (PDT)
From: Shayaun Nejad <snejad123@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Shayaun Nejad <snejad123@gmail.com>
Subject: [PATCH 2/2] staging: rtl8723bs: bound SUPP_RATES IE length in rtw_check_beacon_data
Date: Mon, 11 May 2026 18:44:56 -0700
Message-ID: <a56d8fa71dc6843e5096ce69d4c216c0ca99a7de.1778550157.git.snejad123@gmail.com>
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
X-Rspamd-Queue-Id: 1B85D5187C1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-36277-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[snejad123@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

rtw_check_beacon_data() copies SUPP_RATES and EXT_SUPP_RATES IE
payloads into a 16-byte support_rate[] buffer.

The IE lengths are used directly, so oversized rate IEs can overflow the
stack buffer.

Clamp the supported rates copy and the combined extended supported rates
copy to NDIS_802_11_LENGTH_RATES_EX.

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Signed-off-by: Shayaun Nejad <snejad123@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index 4b40124110..363ecb02b5 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -873,6 +873,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 		       &ie_len,
 		       (pbss_network->ie_length - _BEACON_IE_OFFSET_));
 	if (p) {
+		ie_len = min_t(uint, ie_len, NDIS_802_11_LENGTH_RATES_EX);
 		memcpy(support_rate, p + 2, ie_len);
 		support_rate_num = ie_len;
 	}
@@ -882,8 +883,11 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 		       WLAN_EID_EXT_SUPP_RATES,
 		       &ie_len,
 		       pbss_network->ie_length - _BEACON_IE_OFFSET_);
-	if (p)
+	if (p && support_rate_num < NDIS_802_11_LENGTH_RATES_EX) {
+		ie_len = min_t(uint, ie_len,
+			       NDIS_802_11_LENGTH_RATES_EX - support_rate_num);
 		memcpy(support_rate + support_rate_num, p + 2, ie_len);
+	}
 
 	network_type = rtw_check_network_type(support_rate, channel);
 
-- 
2.43.0


