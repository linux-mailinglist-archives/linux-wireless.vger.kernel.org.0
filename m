Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6AB07523BA
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jul 2023 15:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbjGMNac (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Jul 2023 09:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234574AbjGMNa1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Jul 2023 09:30:27 -0400
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [178.154.239.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D119E68
        for <linux-wireless@vger.kernel.org>; Thu, 13 Jul 2023 06:30:24 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-84.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-84.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:332f:0:640:4ab4:0])
        by forward102b.mail.yandex.net (Yandex) with ESMTP id 24D5460043;
        Thu, 13 Jul 2023 16:30:22 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-84.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id LUb8nu0DU4Y0-duGuLURI;
        Thu, 13 Jul 2023 16:30:21 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1689255021;
        bh=pQ/7B2s+wiHzYTGswyAw58YygajU2ErEZPpVCQuEwv0=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=Y8Q3JFzxKe8SO6i57erTqM0CuaU8BQ6BaWgfbtEXRajCECWFT/rNVoCPxt4sT+uD4
         j+STOB1AV9H50MVUKAVOQFxyAi8BYk58himmSOwxR/r13OfUHWQgP9SbnSohi8lksd
         Qt+IeA2NDb1F8Oygas74Gknbh9zWSS673BurD20g=
Authentication-Results: mail-nwsmtp-smtp-production-main-84.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     Jakub Kicinski <kuba@kernel.org>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: cfg80211: improve documentation for flag fields
Date:   Thu, 13 Jul 2023 16:29:36 +0300
Message-ID: <20230713132957.275859-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix and hopefully improve documentation for 'flag' fields of
a few types by adding references to relevant enumerations.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 include/net/cfg80211.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 7c7d03aa9d06..7f76f731e541 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -263,7 +263,7 @@ enum ieee80211_privacy {
  * are only for driver use when pointers to this structure are
  * passed around.
  *
- * @flags: rate-specific flags
+ * @flags: rate-specific flags from &enum ieee80211_rate_flags
  * @bitrate: bitrate in units of 100 Kbps
  * @hw_value: driver/hardware value for this rate
  * @hw_value_short: driver/hardware value for this rate when
@@ -1350,7 +1350,7 @@ struct cfg80211_unsol_bcast_probe_resp {
  * @twt_responder: Enable Target Wait Time
  * @he_required: stations must support HE
  * @sae_h2e_required: stations must support direct H2E technique in SAE
- * @flags: flags, as defined in enum cfg80211_ap_settings_flags
+ * @flags: flags, as defined in &enum nl80211_ap_settings_flags
  * @he_obss_pd: OBSS Packet Detection settings
  * @he_oper: HE operation IE (or %NULL if HE isn't enabled)
  * @fils_discovery: FILS discovery transmission parameters
@@ -2153,7 +2153,7 @@ enum mpath_info_flags {
  * @sn: target sequence number
  * @metric: metric (cost) of this mesh path
  * @exptime: expiration time for the mesh path from now, in msecs
- * @flags: mesh path flags
+ * @flags: mesh path flags from &enum mesh_path_flags
  * @discovery_timeout: total mesh path discovery timeout, in msecs
  * @discovery_retries: mesh path discovery retries
  * @generation: generation number for nl80211 dumps.
@@ -2493,7 +2493,7 @@ struct cfg80211_scan_6ghz_params {
  *	the actual dwell time may be shorter.
  * @duration_mandatory: if set, the scan duration must be as specified by the
  *	%duration field.
- * @flags: bit field of flags controlling operation
+ * @flags: control flags from &enum nl80211_scan_flags
  * @rates: bitmap of rates to advertise for each band
  * @wiphy: the wiphy this was for
  * @scan_start: time (in jiffies) when the scan started
@@ -2613,7 +2613,7 @@ struct cfg80211_bss_select_adjust {
  * @scan_width: channel width for scanning
  * @ie: optional information element(s) to add into Probe Request or %NULL
  * @ie_len: length of ie in octets
- * @flags: bit field of flags controlling operation
+ * @flags: control flags from &enum nl80211_scan_flags
  * @match_sets: sets of parameters to be matched for a scan result
  *	entry to be considered valid and to be passed to the host
  *	(others are filtered out).
@@ -8115,7 +8115,7 @@ void cfg80211_conn_failed(struct net_device *dev, const u8 *mac_addr,
  * @link_id: the ID of the link the frame was received	on
  * @buf: Management frame (header + body)
  * @len: length of the frame data
- * @flags: flags, as defined in enum nl80211_rxmgmt_flags
+ * @flags: flags, as defined in &enum nl80211_rxmgmt_flags
  * @rx_tstamp: Hardware timestamp of frame RX in nanoseconds
  * @ack_tstamp: Hardware timestamp of ack TX in nanoseconds
  */
-- 
2.41.0

