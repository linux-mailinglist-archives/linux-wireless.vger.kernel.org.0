Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3021B7D0C38
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Oct 2023 11:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376639AbjJTJrp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Oct 2023 05:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376601AbjJTJro (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Oct 2023 05:47:44 -0400
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net [178.154.239.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6ED4C2
        for <linux-wireless@vger.kernel.org>; Fri, 20 Oct 2023 02:47:40 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:4110:0:640:2904:0])
        by forward100b.mail.yandex.net (Yandex) with ESMTP id 37AA160AC0;
        Fri, 20 Oct 2023 12:47:38 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id alGG179BWiE0-RvFXWgPA;
        Fri, 20 Oct 2023 12:47:37 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1697795257; bh=99ILjnymD6K9eHN3YTVFkRNsRBbzguUt9Nx43RNVsco=;
        h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=mkZhKh9ufaxZ35VtbB8WCOeKyHyQHBcwtBw98r4CNlyHk5+/1sX8SIBitGFsDmikx
         UFT3ktbmEo+I+W3BMz7dSJh2/oOA8s+wd+ubxDY5lKLF0gyV/RsjnzfvqmAX3bvJ+Q
         xMf+GKh2+omLN1lmvT/gBwMIKRD68eC1EPtu0zHY=
Authentication-Results: mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org, Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 2/2] wifi: mwifiex: remove unreachable code in mwifiex_sec_ioctl_set_wpa_key()
Date:   Fri, 20 Oct 2023 12:46:29 +0300
Message-ID: <20231020094654.33258-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020094654.33258-1-dmantipov@yandex.ru>
References: <20231020094654.33258-1-dmantipov@yandex.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since 'remove_key' is always false, remove unreachable block
in 'mwifiex_sec_ioctl_set_wpa_key()'. Compile tested only.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/marvell/mwifiex/sta_ioctl.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c b/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
index a2ad2b53f016..1b375a70cd1a 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
@@ -989,7 +989,6 @@ static int mwifiex_sec_ioctl_set_wpa_key(struct mwifiex_private *priv,
 			      struct mwifiex_ds_encrypt_key *encrypt_key)
 {
 	int ret;
-	u8 remove_key = false;
 	struct host_cmd_ds_802_11_key_material *ibss_key;
 
 	/* Current driver only supports key length of up to 32 bytes */
@@ -1031,14 +1030,9 @@ static int mwifiex_sec_ioctl_set_wpa_key(struct mwifiex_private *priv,
 	if (!encrypt_key->key_index)
 		encrypt_key->key_index = MWIFIEX_KEY_INDEX_UNICAST;
 
-	if (remove_key)
-		ret = mwifiex_send_cmd(priv, HostCmd_CMD_802_11_KEY_MATERIAL,
-				       HostCmd_ACT_GEN_SET,
-				       !KEY_INFO_ENABLED, encrypt_key, true);
-	else
-		ret = mwifiex_send_cmd(priv, HostCmd_CMD_802_11_KEY_MATERIAL,
-				       HostCmd_ACT_GEN_SET,
-				       KEY_INFO_ENABLED, encrypt_key, true);
+	ret = mwifiex_send_cmd(priv, HostCmd_CMD_802_11_KEY_MATERIAL,
+			       HostCmd_ACT_GEN_SET,
+			       KEY_INFO_ENABLED, encrypt_key, true);
 
 	return ret;
 }
-- 
2.41.0

