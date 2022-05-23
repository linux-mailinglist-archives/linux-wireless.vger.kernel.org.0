Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C733C531277
	for <lists+linux-wireless@lfdr.de>; Mon, 23 May 2022 18:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238537AbiEWQCQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 May 2022 12:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238551AbiEWQCO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 May 2022 12:02:14 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D82362A08
        for <linux-wireless@vger.kernel.org>; Mon, 23 May 2022 09:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=uR/EWHwljyAgPuGfvVkQ3ZXqV9pP+5nYMuRx31WRMGk=; t=1653321732; x=1654531332; 
        b=cgJv+LAfRTCZefbL43Xg4RjSALNSkptL44gZg/anU4CrY5kHRzR1MIkcw65F6IMu2WlXnI7uOym
        IqGsM27PXkmP2Jtefev9R4m4zc0BdmMYDMTvxT6ya+daICI6sC+e8PrAf4AfRYSs7/vxCMOnx1K5P
        CfeKLcR+X3HQP81+hatESs577j5zmeFqu2Bd0NgoBO0AGhYRRlrNU8c//MIoHJtqBfx3uboW5H793
        vzidmzPtjmnswJjnve1kl1qoPGRJFBk5PH0WoFfTXdsKMtCRqFsK0Dx/Xwtwtb0Rr0/RjnXl6YwzE
        CWjYRowYqGF05HIoQRoMg4sJ3/tZIxrH68zw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ntAVT-002TwX-7C;
        Mon, 23 May 2022 18:02:07 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH] wifi: libertas: use variable-size data in assoc req/resp cmd
Date:   Mon, 23 May 2022 18:02:01 +0200
Message-Id: <20220523180200.115fa27fbece.Ie66d874b047e7afad63900aa2df70f031711147e@changeid>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The firmware has a 512 limit here, but we use less, so gcc
starts complaining about it:

drivers/net/wireless/marvell/libertas/cfg.c:1198:63: warning: array subscript ‘struct cmd_ds_802_11_associate_response[0]’ is partly outside array bounds of ‘unsigned char[203]’ [-Warray-bounds]
 1198 |                       "aid 0x%04x\n", status, le16_to_cpu(resp->statuscode),
      |                                                               ^~

Since we size the command and response buffer per our needs
and not per the firmware maximum, change to a variable size
data array and put the 512 only into a comment.

In the end, that's actually what the code always wanted, and
it simplifies the code that used to subtract the fixed size
buffer size in two places.

Reported-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/marvell/libertas/cfg.c  | 4 +---
 drivers/net/wireless/marvell/libertas/host.h | 6 ++++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/marvell/libertas/cfg.c b/drivers/net/wireless/marvell/libertas/cfg.c
index 4e3de684928b..b0b3f59dabc6 100644
--- a/drivers/net/wireless/marvell/libertas/cfg.c
+++ b/drivers/net/wireless/marvell/libertas/cfg.c
@@ -1053,7 +1053,6 @@ static int lbs_set_authtype(struct lbs_private *priv,
  */
 #define LBS_ASSOC_MAX_CMD_SIZE                     \
 	(sizeof(struct cmd_ds_802_11_associate)    \
-	 - 512 /* cmd_ds_802_11_associate.iebuf */ \
 	 + LBS_MAX_SSID_TLV_SIZE                   \
 	 + LBS_MAX_CHANNEL_TLV_SIZE                \
 	 + LBS_MAX_CF_PARAM_TLV_SIZE               \
@@ -1130,8 +1129,7 @@ static int lbs_associate(struct lbs_private *priv,
 	if (sme->ie && sme->ie_len)
 		pos += lbs_add_wpa_tlv(pos, sme->ie, sme->ie_len);
 
-	len = (sizeof(*cmd) - sizeof(cmd->iebuf)) +
-		(u16)(pos - (u8 *) &cmd->iebuf);
+	len = sizeof(*cmd) + (u16)(pos - (u8 *) &cmd->iebuf);
 	cmd->hdr.size = cpu_to_le16(len);
 
 	lbs_deb_hex(LBS_DEB_ASSOC, "ASSOC_CMD", (u8 *) cmd,
diff --git a/drivers/net/wireless/marvell/libertas/host.h b/drivers/net/wireless/marvell/libertas/host.h
index ceff4b92e7a1..a202b716ad5d 100644
--- a/drivers/net/wireless/marvell/libertas/host.h
+++ b/drivers/net/wireless/marvell/libertas/host.h
@@ -528,7 +528,8 @@ struct cmd_ds_802_11_associate {
 	__le16 listeninterval;
 	__le16 bcnperiod;
 	u8 dtimperiod;
-	u8 iebuf[512];    /* Enough for required and most optional IEs */
+	/* 512 permitted - enough for required and most optional IEs */
+	u8 iebuf[];
 } __packed;
 
 struct cmd_ds_802_11_associate_response {
@@ -537,7 +538,8 @@ struct cmd_ds_802_11_associate_response {
 	__le16 capability;
 	__le16 statuscode;
 	__le16 aid;
-	u8 iebuf[512];
+	/* max 512 */
+	u8 iebuf[];
 } __packed;
 
 struct cmd_ds_802_11_set_wep {
-- 
2.36.1

