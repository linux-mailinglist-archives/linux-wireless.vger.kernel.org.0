Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1AD66D01B
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jan 2023 21:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbjAPUYu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Jan 2023 15:24:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbjAPUYr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Jan 2023 15:24:47 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4EA925286
        for <linux-wireless@vger.kernel.org>; Mon, 16 Jan 2023 12:24:46 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id u1-20020a17090a450100b0022936a63a21so8485210pjg.4
        for <linux-wireless@vger.kernel.org>; Mon, 16 Jan 2023 12:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A0fz9zHVDO2m4yGb0WkSftssKbcC8YshpBpIYHhLj7c=;
        b=XPqlqsns1l0j2dj0kGma04Dysnk7syDzq9rj51Ig7hKcPXe/eVEomVWcx81kHre3AT
         K18P2DubkZjaxqj4vLRdpmGY+t3bV0eFsD8ZUchZehwL5PMPDXL2gl80emQods+1lxb+
         WFWayssPMtJKHHm1fGBjOtGyUCx4AwINGok+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A0fz9zHVDO2m4yGb0WkSftssKbcC8YshpBpIYHhLj7c=;
        b=UQZ8RarKqIgc82JjhlCq5IjXJv5O2V4gqhPTGm4AupLlvA39iCtiRgpuuIWPYX2D+2
         gaZwKG6QHMfkPcJ5UU6MfcMu54A0A75JWnDvFgmjFWjgB9N+HRLu1cwEdhclrMa6IKpW
         Sd1hN5P6cDXbA9zflHcQhua4Lq7ZSHD1HPio2I/1vJ4tIOshscqc5ZqwXp0Zr4EiMfKC
         CfXTzrXNm9hq29L9ZRgauTzxDbrrH9tSBU+1stDMNmRec+bDT+xlOXzt1rQaW7+yt463
         FD4wOw5p7CZEqx+nDAQjopONJvfrjCaK6ws1C5b2SgIG+FsxmJd/NjlEOFnH0SuHk++N
         x0cg==
X-Gm-Message-State: AFqh2kp0uts0bxEc7dHXPDfR4Fb8hhLX9zjSiCczMgmAzn9BBR6ljFbN
        2l7kanFAQt4Zmd2oYXikzul7Q7RNyeG2Ov8A6xFDmg==
X-Google-Smtp-Source: AMrXdXuVB+N82WcfVUCAm6fO+qNeYUUV5/9FiGcTtRz8c5rfqb8OdC7lNiVla3ptxpkgTY36/Y0MMQ==
X-Received: by 2002:a17:902:b587:b0:193:6520:73a4 with SMTP id a7-20020a170902b58700b00193652073a4mr872975pls.61.1673900686217;
        Mon, 16 Jan 2023 12:24:46 -0800 (PST)
Received: from doug-ryzen-5700G.. ([192.183.212.197])
        by smtp.gmail.com with ESMTPSA id v11-20020a170902f0cb00b00180033438a0sm19782636pla.106.2023.01.16.12.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 12:24:45 -0800 (PST)
From:   Doug Brown <doug@schmorgal.com>
To:     Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Dan Williams <dcbw@redhat.com>,
        Simon Horman <simon.horman@corigine.com>,
        libertas-dev@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Doug Brown <doug@schmorgal.com>
Subject: [PATCH v3 2/4] wifi: libertas: only add RSN/WPA IE in lbs_add_wpa_tlv
Date:   Mon, 16 Jan 2023 12:21:24 -0800
Message-Id: <20230116202126.50400-3-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230116202126.50400-1-doug@schmorgal.com>
References: <20230116202126.50400-1-doug@schmorgal.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The existing code only converts the first IE to a TLV, but it returns a
value that takes the length of all IEs into account. When there is more
than one IE (which happens with modern wpa_supplicant versions for
example), the returned length is too long and extra junk TLVs get sent
to the firmware, resulting in an association failure.

Fix this by finding the first RSN or WPA IE and only adding that. This
has the extra benefit of working properly if the RSN/WPA IE isn't the
first one in the IE buffer.

While we're at it, clean up the code to use the available structs like
the other lbs_add_* functions instead of directly manipulating the TLV
buffer.

Signed-off-by: Doug Brown <doug@schmorgal.com>
---
 drivers/net/wireless/marvell/libertas/cfg.c | 28 +++++++++++++--------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/marvell/libertas/cfg.c b/drivers/net/wireless/marvell/libertas/cfg.c
index 3e065cbb0af9..3f35dc7a1d7d 100644
--- a/drivers/net/wireless/marvell/libertas/cfg.c
+++ b/drivers/net/wireless/marvell/libertas/cfg.c
@@ -416,10 +416,20 @@ static int lbs_add_cf_param_tlv(u8 *tlv)
 
 static int lbs_add_wpa_tlv(u8 *tlv, const u8 *ie, u8 ie_len)
 {
-	size_t tlv_len;
+	struct mrvl_ie_data *wpatlv = (struct mrvl_ie_data *)tlv;
+	const struct element *wpaie;
+
+	/* Find the first RSN or WPA IE to use */
+	wpaie = cfg80211_find_elem(WLAN_EID_RSN, ie, ie_len);
+	if (!wpaie)
+		wpaie = cfg80211_find_vendor_elem(WLAN_OUI_MICROSOFT,
+						  WLAN_OUI_TYPE_MICROSOFT_WPA,
+						  ie, ie_len);
+	if (!wpaie || wpaie->datalen > 128)
+		return 0;
 
 	/*
-	 * We need just convert an IE to an TLV. IEs use u8 for the header,
+	 * Convert the found IE to a TLV. IEs use u8 for the header,
 	 *   u8      type
 	 *   u8      len
 	 *   u8[]    data
@@ -428,14 +438,12 @@ static int lbs_add_wpa_tlv(u8 *tlv, const u8 *ie, u8 ie_len)
 	 *   __le16  len
 	 *   u8[]    data
 	 */
-	*tlv++ = *ie++;
-	*tlv++ = 0;
-	tlv_len = *tlv++ = *ie++;
-	*tlv++ = 0;
-	while (tlv_len--)
-		*tlv++ = *ie++;
-	/* the TLV is two bytes larger than the IE */
-	return ie_len + 2;
+	wpatlv->header.type = cpu_to_le16(wpaie->id);
+	wpatlv->header.len = cpu_to_le16(wpaie->datalen);
+	memcpy(wpatlv->data, wpaie->data, wpaie->datalen);
+
+	/* Return the total number of bytes added to the TLV buffer */
+	return sizeof(struct mrvl_ie_header) + wpaie->datalen;
 }
 
 /*
-- 
2.34.1

