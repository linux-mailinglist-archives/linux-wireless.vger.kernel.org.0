Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE4D31C62FE
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2020 23:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729170AbgEEVXn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 May 2020 17:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726350AbgEEVXm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 May 2020 17:23:42 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93EF1C061A0F
        for <linux-wireless@vger.kernel.org>; Tue,  5 May 2020 14:23:42 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id l18so4436658wrn.6
        for <linux-wireless@vger.kernel.org>; Tue, 05 May 2020 14:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=nU+A5TMfpnhcyGzbsuMUAVDKxSLjs8/9QIBpNm3kqMo=;
        b=mB6xLdxBFVdspDqi17lt9VZI3EAv/VRjLHnt1uPx+R5eOLxbJZcuFCJv5w287cZh+g
         ePaRVKxNasKWSGgwLpsw+urQwK5PDCNTHsaDFq//nvXQmtaCWAf5EZkiW+JfK6sH+v2U
         TDh8VKYVCOtGrkJN27PSWahuAVVWMndC5KRYPYKvRGTeKMTwwvRQslv6OTK5ESPZCs93
         Lwq2WgLB1/xUyaZq+/R/jNfwud53nHWCYbOaXDvMW62T7csiMNXSLwGd0iWvdcLX/NAx
         uJKxayEC24igSdWhVSiLZNOVOfRfolYDhNyB58NL4riTIAcMCkKMB4+1VVfS1mt4KyEf
         OkVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=nU+A5TMfpnhcyGzbsuMUAVDKxSLjs8/9QIBpNm3kqMo=;
        b=rrTvGdDZbF10rD8lL3oiOkE7ZwiQ2pddApvH6U4g/p3aD+vZMHRhBZOLBH+M9oOd+Y
         0jD0wfmnFGbsVQXt+Cs0MbQxYD0INFnFKaKnjeyVaNWSkcj1jk7vuJY2o40WH9QXrcdI
         UHpSjsv4P98+tm0i6+F+kibvsHv9SBzcNEcm0VChux0qso6KajBkZzOJpTLSV7NW3fmt
         dLF1RwWR35McMe2higGbvc9bXXlawuPJmqFeQ8PpqdTUqK7piLio2MXAmnRDRG8T9vKU
         RoZUsbocEFcWxGM2YsMKTfg0Ce0H/tj+iO4mioHcJTzpWuyZKq4i8FtQRiRa1hHt+cw0
         CTJg==
X-Gm-Message-State: AGi0PuYlsA3MfkECPeGehOHym17yCtG+ngKopnUtebDcWQSJTRgeCIcK
        d/vFRjL4JaR7DXakiZ7qElA=
X-Google-Smtp-Source: APiQypLj/aYuGd1u09nc2v/HP1xojnf3KnNRLT3WwofJoP+DSQEKNLYanQZX0DDOrOTpJXyhGEwWmw==
X-Received: by 2002:a5d:6692:: with SMTP id l18mr6125761wru.423.1588713821365;
        Tue, 05 May 2020 14:23:41 -0700 (PDT)
Received: from [192.168.43.18] (188.29.165.117.threembb.co.uk. [188.29.165.117])
        by smtp.gmail.com with ESMTPSA id a9sm5573954wmm.38.2020.05.05.14.23.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2020 14:23:41 -0700 (PDT)
From:   Malcolm Priestley <tvboxspy@gmail.com>
Subject: [PATCH 6/6] staging: vt6656: remove difs / sifs adjustments.
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        linux-wireless@vger.kernel.org, Oscar Carter <oscar.carter@gmx.com>
Message-ID: <034e445c-b245-52c4-c855-431b9783bcff@gmail.com>
Date:   Tue, 5 May 2020 22:23:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Now mac89211 is doing frame timing in rxtx these vendor adjustments need
to be removed.

Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>
---
 drivers/staging/vt6656/card.c | 32 --------------------------------
 1 file changed, 32 deletions(-)

diff --git a/drivers/staging/vt6656/card.c b/drivers/staging/vt6656/card.c
index 3cb97c4daeb8..10f3dfda83b5 100644
--- a/drivers/staging/vt6656/card.c
+++ b/drivers/staging/vt6656/card.c
@@ -149,38 +149,6 @@ int vnt_update_ifs(struct vnt_private *priv)
 
 	priv->eifs = C_EIFS;
 
-	switch (priv->rf_type) {
-	case RF_VT3226D0:
-		if (priv->bb_type != BB_TYPE_11B) {
-			priv->sifs -= 1;
-			priv->difs -= 1;
-			break;
-		}
-		/* fall through */
-	case RF_AIROHA7230:
-	case RF_AL2230:
-	case RF_AL2230S:
-		if (priv->bb_type != BB_TYPE_11B)
-			break;
-		/* fall through */
-	case RF_RFMD2959:
-	case RF_VT3226:
-	case RF_VT3342A0:
-		priv->sifs -= 3;
-		priv->difs -= 3;
-		break;
-	case RF_MAXIM2829:
-		if (priv->bb_type == BB_TYPE_11A) {
-			priv->sifs -= 5;
-			priv->difs -= 5;
-		} else {
-			priv->sifs -= 2;
-			priv->difs -= 2;
-		}
-
-		break;
-	}
-
 	data[0] = (u8)priv->sifs;
 	data[1] = (u8)priv->difs;
 	data[2] = (u8)priv->eifs;
-- 
2.25.1
