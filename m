Return-Path: <linux-wireless+bounces-34028-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aP2JHz70xWnbEgUAu9opvQ
	(envelope-from <linux-wireless+bounces-34028-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 04:06:38 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 268C133EA9F
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 04:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 91F913011148
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 03:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295B3356A37;
	Fri, 27 Mar 2026 03:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oxB3BYy5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98F7347FDF
	for <linux-wireless@vger.kernel.org>; Fri, 27 Mar 2026 03:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774580796; cv=none; b=HecMc4OPFsLxzJ4fdBbyUDa1kT1KFcGuySp0r5sF/y2waCf19yAe3qvL77STvRpi3IrfepOUvSvp0F9Qo+gh5pUH9j9dLeuayyOXcinVMnlYZ1sQIItagY1eTJNRnAmeuyD6a6d2oU3zQ1DFkOKfruKrEN4+z3T+Wll80aduKAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774580796; c=relaxed/simple;
	bh=mFyJNCXuMqoBi2cg1k+mY8xKpvJpgPvXEUQH/AYZMzI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KA8UtasjEocwmInJOZmsggUioI5O5bfp8tKF2hTWY2yaUXmo0SgIcofIm5PXt5wXwfQ7hRDIIV8fPm9YtxJOOXd2AB3dox0tnBYlQtRo3IrPEGoCU1xaei6GTbjpAfoS/TX3OqhHhU+juH6X6Cco1IBK9O5bfNXK70KOBSYFQxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oxB3BYy5; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2adbfab4501so7968135ad.2
        for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 20:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774580794; x=1775185594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v78hEsPBvIeXcu1KmsE3aUxquOtVKXvSe1wiRNECZRE=;
        b=oxB3BYy5op3VP9OHY/xN9gmPqOKC8sPy82sgGTMMP+DXyjjV93jyokTnMEbJWbadib
         fnKe1oiYDhHPmzN03M1hZCFMEet+grZew4W1i0z7WkjNuZOpCH4eBjguU1qqx+Sw0tkb
         XaldpXV/+jVc4zMmr3++nFV3iqSsFiCbB0gh02lJFlgZskHuPX9igZ2iH8NnlufUu2m4
         A8HhL+fE34ecy+XCJz6qN8h9nWSiRww09e0zc+4esueIF1X3M4jD2TGTsaKQXOgDVFnV
         rfhLnSppnzImkHUMLGIdsqceh8ZUCYd6/kdUENeEV/Pund2U+WaWmGZUCd1fmIe3xdrn
         rOsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774580794; x=1775185594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v78hEsPBvIeXcu1KmsE3aUxquOtVKXvSe1wiRNECZRE=;
        b=FZM0ZFVeocm6f3vvM1KSCHns4weFGQQGn11+O7UfSPJqnWtpte3f9vAwGWFixkh8Uv
         N5EnZjgTIZtjOUjiZvtCGY54Rprl5ndFKeY+qpEEWyEcZgadFilxEd5ZpmRH2FkJlHxG
         oCna0YfJMihfqaOBxH8dNM9RR+JRVhSdKVXIs2zpY31nNZcRW7CwrjuRqRtyLbw/sBFd
         tNJDThNzOspBVX1kJnfb1BUPCGpjp+1vvWOBwcmn/CR7uXwQEZYY1YUr04lFmVWn0tK5
         7zUfEKJTDvUyGJYNi0A9g6OkmuzpwdPaeEcz+/MszkzCOwyFfADeCCxQcqzyCnXHz9zx
         4cEA==
X-Gm-Message-State: AOJu0YwRLbPPqoeiA0ZYbLIyqZpCpUJIxL+Tks8OLiizWrsA4jsurKjt
	DWI05zkGY5OHiYoLufTeyr4daySAamg+/Xwa/c64wMVmGrhLODR1XzMJaF/vvO8x
X-Gm-Gg: ATEYQzy9tjGjZvzUJy+BpAS6A1kQrs0JLiE09NMnXrAtjPHBBSKny2r7R0YOYUic6Zb
	UFxpBf39Bbgh/7kfi/5QxI8l+GY0Ru6RvJhSbPFXdtdi54iW39PPSHmxMaNtt5w538I0K5WnmnI
	bIiuWaFCX4ciURY4LcGnvCEqHCFN79SYVbBkxs1WMyPrKiPhmC1a/kRdRtNs6mAMOiQRK1V2DZu
	mxz8/tscJKNesWqsNvF17Ma7prjvt7DAifSpClKwBeIQrWsYKURq9fHpwj+X2Xb6hT9fjkTPKKy
	48B4lvu5qQKaCP0jQo99j4wkIm8MYquxb11k36QvrXP1pGkY0RbcJaoT5izZ4fp7YOgGishbJIV
	fAd0+1IuwfR/ztmmG/lPXpTO9V5mB/uK1KXIIiekptVih1ARAe+mOfMiYQYs/G0I6Q+9likGADO
	xkQFl6uU2MgfK43gm8TYLW4iWrXY6eTP8I/MR0t982L0l25PFYF4cD2kXYMaafuNGYIg==
X-Received: by 2002:a17:903:2f87:b0:2b0:74df:3c4c with SMTP id d9443c01a7336-2b0cdd12fb8mr8915105ad.42.1774580793830;
        Thu, 26 Mar 2026 20:06:33 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc8b5dcbsm43268905ad.57.2026.03.26.20.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 20:06:33 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Ajay Singh <ajay.kathat@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH wireless-next] wifi: wilc1000: use kzalloc_flex
Date: Thu, 26 Mar 2026 20:06:16 -0700
Message-ID: <20260327030616.8774-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34028-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 268C133EA9F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Because key is a flexible array member, kzalloc_flex can be used to
handle the math properly and simplify the code slightly.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/wireless/microchip/wilc1000/hif.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/hif.c b/drivers/net/wireless/microchip/wilc1000/hif.c
index 944b2a812b63..009c4770a6f9 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.c
+++ b/drivers/net/wireless/microchip/wilc1000/hif.c
@@ -1123,7 +1123,7 @@ int wilc_add_ptk(struct wilc_vif *vif, const u8 *ptk, u8 ptk_key_len,
 		wid_list[0].size = sizeof(char);
 		wid_list[0].val = (s8 *)&cipher_mode;

-		key_buf = kzalloc(sizeof(*key_buf) + t_key_len, GFP_KERNEL);
+		key_buf = kzalloc_flex(*key_buf, key, t_key_len);
 		if (!key_buf)
 			return -ENOMEM;

@@ -1151,7 +1151,7 @@ int wilc_add_ptk(struct wilc_vif *vif, const u8 *ptk, u8 ptk_key_len,
 		struct wid wid;
 		struct wilc_sta_wpa_ptk *key_buf;

-		key_buf = kzalloc(sizeof(*key_buf) + t_key_len, GFP_KERNEL);
+		key_buf = kzalloc_flex(*key_buf, key, t_key_len);
 		if (!key_buf)
 			return -ENOMEM;

@@ -1186,7 +1186,7 @@ int wilc_add_igtk(struct wilc_vif *vif, const u8 *igtk, u8 igtk_key_len,
 	struct wid wid;
 	struct wilc_wpa_igtk *key_buf;

-	key_buf = kzalloc(sizeof(*key_buf) + t_key_len, GFP_KERNEL);
+	key_buf = kzalloc_flex(*key_buf, key, t_key_len);
 	if (!key_buf)
 		return -ENOMEM;

@@ -1217,7 +1217,7 @@ int wilc_add_rx_gtk(struct wilc_vif *vif, const u8 *rx_gtk, u8 gtk_key_len,
 	struct wilc_gtk_key *gtk_key;
 	int t_key_len = gtk_key_len + WILC_RX_MIC_KEY_LEN + WILC_TX_MIC_KEY_LEN;

-	gtk_key = kzalloc(sizeof(*gtk_key) + t_key_len, GFP_KERNEL);
+	gtk_key = kzalloc_flex(*gtk_key, key, t_key_len);
 	if (!gtk_key)
 		return -ENOMEM;

--
2.53.0


