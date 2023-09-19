Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E593D7A5932
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Sep 2023 07:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjISFNY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Sep 2023 01:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjISFNX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Sep 2023 01:13:23 -0400
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [178.154.239.150])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045FEFC
        for <linux-wireless@vger.kernel.org>; Mon, 18 Sep 2023 22:13:12 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-31.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-31.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:d315:0:640:bb64:0])
        by forward103b.mail.yandex.net (Yandex) with ESMTP id 6845060085;
        Tue, 19 Sep 2023 08:12:40 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-31.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id dCd8eYGDXSw0-0wg9Cahr;
        Tue, 19 Sep 2023 08:12:39 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1695100359; bh=7OqRigO+KeCkxA9PS9V2o/mUw4aLnyYtyBAbzxXBekQ=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=cXS+ec1A0193FfrxV9F2mFl1hIZfvjTrDj7Fbo+YDv63wsF/kbbEHbhKV8ssT4JdA
         kVhccaInU+lBF3FOZOE8i5Z/ZYd8lh738pbkyLcaNzvcK3LadqIENakdQkNsd2x46t
         K+JKlZpSdd+CduGtpJRjDWdUgwdNeea8E0ZRfHTw=
Authentication-Results: mail-nwsmtp-smtp-production-main-31.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Arend van Spriel <aspriel@gmail.com>
Cc:     Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org, Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: brcmfmac: handle possible IE flags reset error
Date:   Tue, 19 Sep 2023 08:11:25 +0300
Message-ID: <20230919051130.16316-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In 'brcmf_vif_clear_mgmt_ies()', check for possible error returned
by 'brcmf_vif_set_mgmt_ie()' and issue appropriate message if needed.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 .../wireless/broadcom/brcm80211/brcmfmac/cfg80211.c  | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 9012456e1a18..cfa5fdd039fe 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -4999,15 +4999,23 @@ s32 brcmf_vif_set_mgmt_ie(struct brcmf_cfg80211_vif *vif, s32 pktflag,
 
 s32 brcmf_vif_clear_mgmt_ies(struct brcmf_cfg80211_vif *vif)
 {
+	struct brcmf_pub *drvr = vif->ifp->drvr;
 	static const s32 pktflags[] = {
 		BRCMF_VNDR_IE_PRBREQ_FLAG,
 		BRCMF_VNDR_IE_PRBRSP_FLAG,
 		BRCMF_VNDR_IE_BEACON_FLAG
 	};
+	s32 err;
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(pktflags); i++)
-		brcmf_vif_set_mgmt_ie(vif, pktflags[i], NULL, 0);
+	for (i = 0; i < ARRAY_SIZE(pktflags); i++) {
+		err = brcmf_vif_set_mgmt_ie(vif, pktflags[i], NULL, 0);
+		if (err) {
+			bphy_err(drvr, "Clear IE %d failed (error %d)\n",
+				 pktflags[i], err);
+			return err;
+		}
+	}
 
 	memset(&vif->saved_ie, 0, sizeof(vif->saved_ie));
 	return 0;
-- 
2.41.0

