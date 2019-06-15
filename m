Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B867F46D23
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Jun 2019 02:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfFOAN6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Jun 2019 20:13:58 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42504 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbfFOAN5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Jun 2019 20:13:57 -0400
Received: by mail-pg1-f194.google.com with SMTP id l19so2389714pgh.9
        for <linux-wireless@vger.kernel.org>; Fri, 14 Jun 2019 17:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z8Sr3wwef/63KELNe4jUJaKB5wCZ2YTUwefjWC3YKWA=;
        b=dsc/F7g2uIm7KIaNWINoPbXEKXEF+qrsta0rCrMTJ3HTQAlFdVy7t6i557mgCbrynO
         ufA2pqxjJyc1/F2fpZKpMkbKNlUj95WoPq95c2aPaODVcYcqEvjlT/2CMntRk6FrXUYr
         kbNBP8McMPLivkpcZdP7OZfk3Eq78x3UCzDL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z8Sr3wwef/63KELNe4jUJaKB5wCZ2YTUwefjWC3YKWA=;
        b=Zzrtw8jKxiZUVb+mLC+wdy/wd1JI0JMGpJYOa8rQw6ViTD9yduwjulXLls+xRT/Z0m
         bvB8S1MFZiC8+JLfXYT0VOKRUuNMTml/sf/zR/O2N4GDDUK0FoOoc7Yp+rLVkAf7waxe
         4wVKyz0kBTM8tkTN18LoWo8Op7PC+VEHMXWT1zBF+9Sl3zpdTfh19u0mrGmkmLyBPaNj
         Ipf3HUyhhBhkDRd1tscss/IBy7kz8SsF9TIp+VCO3m4SOYPythIi8XVtFYbHBP2vRACV
         OZNaCzhKQwrDDHO0z3gLQKhlcsajv3oUtBrYV4v+5rHqdtRsnxRgBe+cFz6LdfYER1jy
         s93g==
X-Gm-Message-State: APjAAAWIIIZrbBhuU1rK05/DEUQRemWUNewWFvD0iwNZMYWYp4WaR6sW
        QX01bWd6nKo2JjnDSzILdC94rg==
X-Google-Smtp-Source: APXvYqx99nlTn0yxCc0/LUOCwLtM405Jzo+91yDOaKTrB2/qezmNV06q9avSDDvLHEMrmliA60WlkA==
X-Received: by 2002:a17:90a:b908:: with SMTP id p8mr13640504pjr.94.1560557636959;
        Fri, 14 Jun 2019 17:13:56 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id n2sm3708253pgp.27.2019.06.14.17.13.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 17:13:56 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Ganapathi Bhat <gbhat@marvell.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>
Cc:     <linux-kernel@vger.kernel.org>, linux-wireless@vger.kernel.org,
        Takashi Iwai <tiwai@suse.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 2/2] mwifiex: use 'total_ie_len' in mwifiex_update_bss_desc_with_ie()
Date:   Fri, 14 Jun 2019 17:13:21 -0700
Message-Id: <20190615001321.241808-2-briannorris@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190615001321.241808-1-briannorris@chromium.org>
References: <20190615001321.241808-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is clearer than copy/pasting the magic number '+ 2' around, and it
even saves the need for one existing comment.

Cc: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 drivers/net/wireless/marvell/mwifiex/scan.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/scan.c b/drivers/net/wireless/marvell/mwifiex/scan.c
index e2786ab612ca..707e5159262f 100644
--- a/drivers/net/wireless/marvell/mwifiex/scan.c
+++ b/drivers/net/wireless/marvell/mwifiex/scan.c
@@ -1269,7 +1269,7 @@ int mwifiex_update_bss_desc_with_ie(struct mwifiex_adapter *adapter,
 			break;
 
 		case WLAN_EID_FH_PARAMS:
-			if (element_len + 2 < sizeof(*fh_param_set))
+			if (total_ie_len < sizeof(*fh_param_set))
 				return -EINVAL;
 			fh_param_set =
 				(struct ieee_types_fh_param_set *) current_ptr;
@@ -1279,7 +1279,7 @@ int mwifiex_update_bss_desc_with_ie(struct mwifiex_adapter *adapter,
 			break;
 
 		case WLAN_EID_DS_PARAMS:
-			if (element_len + 2 < sizeof(*ds_param_set))
+			if (total_ie_len < sizeof(*ds_param_set))
 				return -EINVAL;
 			ds_param_set =
 				(struct ieee_types_ds_param_set *) current_ptr;
@@ -1292,7 +1292,7 @@ int mwifiex_update_bss_desc_with_ie(struct mwifiex_adapter *adapter,
 			break;
 
 		case WLAN_EID_CF_PARAMS:
-			if (element_len + 2 < sizeof(*cf_param_set))
+			if (total_ie_len < sizeof(*cf_param_set))
 				return -EINVAL;
 			cf_param_set =
 				(struct ieee_types_cf_param_set *) current_ptr;
@@ -1302,7 +1302,7 @@ int mwifiex_update_bss_desc_with_ie(struct mwifiex_adapter *adapter,
 			break;
 
 		case WLAN_EID_IBSS_PARAMS:
-			if (element_len + 2 < sizeof(*ibss_param_set))
+			if (total_ie_len < sizeof(*ibss_param_set))
 				return -EINVAL;
 			ibss_param_set =
 				(struct ieee_types_ibss_param_set *)
@@ -1459,10 +1459,8 @@ int mwifiex_update_bss_desc_with_ie(struct mwifiex_adapter *adapter,
 			break;
 		}
 
-		current_ptr += element_len + 2;
-
-		/* Need to account for IE ID and IE Len */
-		bytes_left -= (element_len + 2);
+		current_ptr += total_ie_len;
+		bytes_left -= total_ie_len;
 
 	}	/* while (bytes_left > 2) */
 	return ret;
-- 
2.22.0.410.gd8fdbe21b5-goog

