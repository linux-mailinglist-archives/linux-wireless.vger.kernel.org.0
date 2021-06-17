Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 115243ABA4F
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 19:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbhFQRNL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 13:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbhFQRNK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 13:13:10 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63822C061767
        for <linux-wireless@vger.kernel.org>; Thu, 17 Jun 2021 10:11:01 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id bb10-20020a17090b008ab029016eef083425so6100516pjb.5
        for <linux-wireless@vger.kernel.org>; Thu, 17 Jun 2021 10:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=THyXgCl+/VLw3FN9PWQYnLIIdZwbsOot+/12m2pLZlY=;
        b=g4EEdUPwW+b9mL8UNx5CjZq3x7m7HAxr1SW3Ic3Ug9BDb+d9X+IMGlRDY/tjrUxuWv
         ztJVDHtsLiz0DGgc0POI6RnssCfMQJm+ebPeeSYbTlCHavvGZZRMPO3R413COkVGzo/7
         WKFE6AVn8MHHgSWDZmm5a2TGF94dIHOPBd2ew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=THyXgCl+/VLw3FN9PWQYnLIIdZwbsOot+/12m2pLZlY=;
        b=J2Ch/D5qaeKr+HxwSq4sHYEEQinaZc1J+mvczqfof374lfrVrQBhvoqKfQyBXy8NYg
         FSXV63E4MtFtMrgXlaurGuLED51I4NtveVVnuP8zYmGuKyYzg0HHnjhpxdRVwDkPd87p
         6gNfd7sdhc6mRDUpiYIgBkjdqfm+XTKfM7v8ksc7Dq5Eg4xMP9GXzsI6C/A2FPCtcu1j
         kvRQEk3MXr2OnHO9w1YRgRHHAzHuKcYsHiplRNcdQxoZ/LoPRCtOkt6ORbTZwJRVQS8s
         qtQWzV36L4WnDGgggF0409TmmKA4v1Xi4DkBqzq4VqVPId7uBYxzS1ogrkvxE0q4+Pz4
         obZQ==
X-Gm-Message-State: AOAM532vYSFby4XhER6PENlm0qR5KlD0H+Hq7G1d1kgnD/sow6loNFMD
        OVTS6EvS0b/E7A/GsEYmFR7Ylg==
X-Google-Smtp-Source: ABdhPJzdACvbMXnVPGIrxxnbd5Bb/c0fcJX064+TUUdqkjoTucP5FHRvPftG7jPOe/HYsGERGOhLfg==
X-Received: by 2002:a17:90a:c397:: with SMTP id h23mr17706498pjt.101.1623949861035;
        Thu, 17 Jun 2021 10:11:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ls13sm5631016pjb.23.2021.06.17.10.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 10:11:00 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Kees Cook <keescook@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] wcn36xx: Avoid memset() beyond end of struct field
Date:   Thu, 17 Jun 2021 10:10:58 -0700
Message-Id: <20210617171058.3410494-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=d2dd7d45b161d7c8a9329c5a8b75525e820a8c46; i=Edz8jhuXuQ6wfwSNfGvEB9SGPd5eZN+nH8oppZ9YUF4=; m=dq0ACCynqzLx07HlxuFYrIrrlO3EnmhT1nG2nGfdDCE=; p=q86YgQ2o199u+8UL8Yc1oxLTwQpOhWxEuOiMHII0TtU=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmDLgiIACgkQiXL039xtwCYtvQ/8Cb0 sLxpN9+ykUVmXYnSytjXPDVjkMOo9ndEUnU4KeKEBe4LmSwyDPY7vKbBbhUopf09U0ljUORb06LqY OxRBirA0qa/RTthtpyQpd3yMRmPFCwQ/UdgtG4oeMORQWBihX4wyOlRtIvzhWUvgUN/VCaeGkBhbL /suFSGf/DzR85VaZWc2D+dFJSaLt5vr9953FYSlk/XuurO+OeAjLglCBWeun42tQJXBhaJaAsjBwl u345+rQJeewnJ8/sbmtfugefw37dzuudhlMGcNMKv1+77YVU7xDiGczsUAyGvZDDfibRCj8lQnDBv 1RH+pl9aTVmAtmjhjlWRIsypvVICupIWvJCIzgDMm/mqLd1CJctISDmK8x3Tt1EfPFJbOiDB4hLGz zuzY1C2r2BuHXlPf1uk+O4674PT/VWgsSXgVU1vW85flDexh+hmXIEyHr8ba/LnMN2wDI+VdcjtDl 7RAiqWOEZ9wy6UCazxPwJx+Crb3sOwhSvUkHa2k9Vmz/AW0VvjvwOXchXrTwox+lyFmjgAgpBCfyF /uuIrDL9wEf5e1jS93x0qWuwZ1mP5nYEbJDHrb6dilgrj+hM49XuZAadhOM/n9sgh6x/8viFc8gUK s1/xAfqaw/kZd5IWHQ1DxeQcKmdFzrFEaUgaeI2gDJ4kpA8L1QXCjt6HAifaD0NU=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memset(), avoid intentionally writing across
neighboring array fields.

Instead of writing past the end of the header to reach the rest of
the body, replace the redundant function with existing macro to wipe
struct contents and set field values. Additionally adjusts macro to add
missing parens.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index d0c3a1557e8d..b3bea07d0641 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -445,22 +445,12 @@ static int wcn36xx_smd_send_and_wait(struct wcn36xx *wcn, size_t len)
 	return ret;
 }
 
-static void init_hal_msg(struct wcn36xx_hal_msg_header *hdr,
-			 enum wcn36xx_hal_host_msg_type msg_type,
-			 size_t msg_size)
-{
-	memset(hdr, 0, msg_size + sizeof(*hdr));
-	hdr->msg_type = msg_type;
-	hdr->msg_version = WCN36XX_HAL_MSG_VERSION0;
-	hdr->len = msg_size + sizeof(*hdr);
-}
-
 #define __INIT_HAL_MSG(msg_body, type, version) \
 	do {								\
-		memset(&msg_body, 0, sizeof(msg_body));			\
-		msg_body.header.msg_type = type;			\
-		msg_body.header.msg_version = version;			\
-		msg_body.header.len = sizeof(msg_body);			\
+		memset(&(msg_body), 0, sizeof(msg_body));		\
+		(msg_body).header.msg_type = type;			\
+		(msg_body).header.msg_version = version;		\
+		(msg_body).header.len = sizeof(msg_body);		\
 	} while (0)							\
 
 #define INIT_HAL_MSG(msg_body, type)	\
@@ -2729,8 +2719,7 @@ int wcn36xx_smd_set_mc_list(struct wcn36xx *wcn,
 
 	msg_body = (struct wcn36xx_hal_rcv_flt_pkt_set_mc_list_req_msg *)
 		   wcn->hal_buf;
-	init_hal_msg(&msg_body->header, WCN36XX_HAL_8023_MULTICAST_LIST_REQ,
-		     sizeof(msg_body->mc_addr_list));
+	INIT_HAL_MSG(*msg_body, WCN36XX_HAL_8023_MULTICAST_LIST_REQ);
 
 	/* An empty list means all mc traffic will be received */
 	if (fp)
-- 
2.25.1

