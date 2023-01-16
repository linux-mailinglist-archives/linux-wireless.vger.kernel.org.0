Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A4266D020
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jan 2023 21:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbjAPUZB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Jan 2023 15:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233779AbjAPUYx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Jan 2023 15:24:53 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4BD026595
        for <linux-wireless@vger.kernel.org>; Mon, 16 Jan 2023 12:24:51 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id z13so3592706plg.6
        for <linux-wireless@vger.kernel.org>; Mon, 16 Jan 2023 12:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IiJYuOlBmU0RcgmFiitXKtaXart9FqS66MFzruNWBFs=;
        b=Nz5TVA75hXDA29BpynrmMSGzNhdUl+RnLMKdZBeGr6J4Ii0QUd8VfnafeC/o8a0Jr8
         +5XW5GgQuKLhKOAbgoFLTZgpQjAtS7OgJbe3usYnEeKCk7h3tamtuFk0kI32CRB9S3Ea
         XODJHodGHniG46XXU9Rrc4SeSLAQyjv6e2suo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IiJYuOlBmU0RcgmFiitXKtaXart9FqS66MFzruNWBFs=;
        b=LjMmdZbEXd2pBpw0dwzYtrmdS25Im/epmM9EMsV4ysbA5pEoUh0Fo+t92Vuva6NQ66
         dBCcDxGMHSL1xBdtYP3rmu5qbLwzwQgJi/Fwj5sXV6dUgrEcq7r2Q69F7UlhTMcmfCTC
         dxlLeqZDSgvTDEStGw8GggXz1iWQI6A5I6XesflGHxIi6gyXZc3w9hfhOhzCvHC4bOQr
         vMkFTvDLANg/6wWaVZJfqnJZ4drnBPJKORwU9dbLYdEKlMiiJOrFESR90D4TQV/QpcOA
         dvFd+0zJeKCLqGbgFe+wqHicb1XnBx0jN4vxwRmKmKxC+OAJNmu+Z/gVXS6n8GFDQieN
         wrcw==
X-Gm-Message-State: AFqh2kq0ZvWdpbvWWSMwUDARznJF9FhSYy2VwnbZ83DJoE3rg+/ADr/A
        pDopQQbutrHNlyCVJCsGg+VO4Q==
X-Google-Smtp-Source: AMrXdXvGOPZZRc6ofCTJypsCLJlt+Pdifreq0kL+dUOedTd8rZQkN+02QlQzCXY7XbVtrK90nD8XOw==
X-Received: by 2002:a17:902:8e88:b0:194:8ddc:7d0e with SMTP id bg8-20020a1709028e8800b001948ddc7d0emr7128790plb.65.1673900691385;
        Mon, 16 Jan 2023 12:24:51 -0800 (PST)
Received: from doug-ryzen-5700G.. ([192.183.212.197])
        by smtp.gmail.com with ESMTPSA id v11-20020a170902f0cb00b00180033438a0sm19782636pla.106.2023.01.16.12.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 12:24:50 -0800 (PST)
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
Subject: [PATCH v3 4/4] wifi: libertas: add support for WPS enrollee IE in probe requests
Date:   Mon, 16 Jan 2023 12:21:26 -0800
Message-Id: <20230116202126.50400-5-doug@schmorgal.com>
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

Add compatibility with WPS by passing on WPS enrollee information in
probe requests. Ignore other IEs supplied in the scan request. This also
has the added benefit of restoring compatibility with newer
wpa_supplicant versions that always add scan IEs. Previously, with
max_scan_ie_len set to 0, scans would always fail.

Suggested-by: Dan Williams <dcbw@redhat.com>
Signed-off-by: Doug Brown <doug@schmorgal.com>
---
 drivers/net/wireless/marvell/libertas/cfg.c | 48 +++++++++++++++++++--
 1 file changed, 45 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/marvell/libertas/cfg.c b/drivers/net/wireless/marvell/libertas/cfg.c
index 3f35dc7a1d7d..b700c213d10c 100644
--- a/drivers/net/wireless/marvell/libertas/cfg.c
+++ b/drivers/net/wireless/marvell/libertas/cfg.c
@@ -446,6 +446,41 @@ static int lbs_add_wpa_tlv(u8 *tlv, const u8 *ie, u8 ie_len)
 	return sizeof(struct mrvl_ie_header) + wpaie->datalen;
 }
 
+/* Add WPS enrollee TLV
+ */
+#define LBS_MAX_WPS_ENROLLEE_TLV_SIZE		\
+	(sizeof(struct mrvl_ie_header)		\
+	 + 256)
+
+static int lbs_add_wps_enrollee_tlv(u8 *tlv, const u8 *ie, size_t ie_len)
+{
+	struct mrvl_ie_data *wpstlv = (struct mrvl_ie_data *)tlv;
+	const struct element *wpsie;
+
+	/* Look for a WPS IE and add it to the probe request */
+	wpsie = cfg80211_find_vendor_elem(WLAN_OUI_MICROSOFT,
+					  WLAN_OUI_TYPE_MICROSOFT_WPS,
+					  ie, ie_len);
+	if (!wpsie)
+		return 0;
+
+	/* Convert the WPS IE to a TLV. The IE looks like this:
+	 *   u8      type (WLAN_EID_VENDOR_SPECIFIC)
+	 *   u8      len
+	 *   u8[]    data
+	 * but the TLV will look like this instead:
+	 *   __le16  type (TLV_TYPE_WPS_ENROLLEE)
+	 *   __le16  len
+	 *   u8[]    data
+	 */
+	wpstlv->header.type = cpu_to_le16(TLV_TYPE_WPS_ENROLLEE);
+	wpstlv->header.len = cpu_to_le16(wpsie->datalen);
+	memcpy(wpstlv->data, wpsie->data, wpsie->datalen);
+
+	/* Return the total number of bytes added to the TLV buffer */
+	return sizeof(struct mrvl_ie_header) + wpsie->datalen;
+}
+
 /*
  * Set Channel
  */
@@ -672,14 +707,15 @@ static int lbs_ret_scan(struct lbs_private *priv, unsigned long dummy,
 
 
 /*
- * Our scan command contains a TLV, consting of a SSID TLV, a channel list
- * TLV and a rates TLV. Determine the maximum size of them:
+ * Our scan command contains a TLV, consisting of a SSID TLV, a channel list
+ * TLV, a rates TLV, and an optional WPS IE. Determine the maximum size of them:
  */
 #define LBS_SCAN_MAX_CMD_SIZE			\
 	(sizeof(struct cmd_ds_802_11_scan)	\
 	 + LBS_MAX_SSID_TLV_SIZE		\
 	 + LBS_MAX_CHANNEL_LIST_TLV_SIZE	\
-	 + LBS_MAX_RATES_TLV_SIZE)
+	 + LBS_MAX_RATES_TLV_SIZE		\
+	 + LBS_MAX_WPS_ENROLLEE_TLV_SIZE)
 
 /*
  * Assumes priv->scan_req is initialized and valid
@@ -728,6 +764,11 @@ static void lbs_scan_worker(struct work_struct *work)
 	/* add rates TLV */
 	tlv += lbs_add_supported_rates_tlv(tlv);
 
+	/* add optional WPS enrollee TLV */
+	if (priv->scan_req->ie && priv->scan_req->ie_len)
+		tlv += lbs_add_wps_enrollee_tlv(tlv, priv->scan_req->ie,
+						priv->scan_req->ie_len);
+
 	if (priv->scan_channel < priv->scan_req->n_channels) {
 		cancel_delayed_work(&priv->scan_work);
 		if (netif_running(priv->dev))
@@ -2114,6 +2155,7 @@ int lbs_cfg_register(struct lbs_private *priv)
 	int ret;
 
 	wdev->wiphy->max_scan_ssids = 1;
+	wdev->wiphy->max_scan_ie_len = 256;
 	wdev->wiphy->signal_type = CFG80211_SIGNAL_TYPE_MBM;
 
 	wdev->wiphy->interface_modes =
-- 
2.34.1

