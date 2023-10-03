Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A687B6559
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Oct 2023 11:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbjJCJWi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Oct 2023 05:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239583AbjJCJWh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Oct 2023 05:22:37 -0400
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [178.154.239.150])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB4C90
        for <linux-wireless@vger.kernel.org>; Tue,  3 Oct 2023 02:22:31 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-17.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-17.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:94a4:0:640:b671:0])
        by forward103b.mail.yandex.net (Yandex) with ESMTP id 1CD216018B;
        Tue,  3 Oct 2023 12:21:59 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-17.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id vLSgouADTSw0-pdVi9OLn;
        Tue, 03 Oct 2023 12:21:58 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1696324918; bh=/eGTZwSu9AodXNyLUPRQiYyXJOBI/5tBl6qKTzfwBns=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=HiwtbyDHHId6pNHS1GBiFuidvmPrArc9VM+DkD9wzthUFQyeCwNKSKMaW1MehHBsH
         fPlKimqvlxKa7uT4+3eCeoDzEDPu3PwZyFUZKsMlK4l4p1ymUs4f/J+D2hdmaOqsIF
         FTCdOWK64d+hF90wuUgExPpF/S9jIA6b5tgJcskE=
Authentication-Results: mail-nwsmtp-smtp-production-main-17.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org, Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: iwlwifi: drop NULL pointer check in iwl_mvm_tzone_set_trip_temp()
Date:   Tue,  3 Oct 2023 12:20:46 +0300
Message-ID: <20231003092048.24998-1-dmantipov@yandex.ru>
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

Since 'tz_device' is an in-place member of 'struct iwl_mvm', it can't
be NULL and so relevant check may be dropped. Compile tested only.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
index 157e96fa23c1..dee9c367dcd3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
@@ -642,7 +642,6 @@ static int iwl_mvm_tzone_set_trip_temp(struct thermal_zone_device *device,
 				       int trip, int temp)
 {
 	struct iwl_mvm *mvm = thermal_zone_device_priv(device);
-	struct iwl_mvm_thermal_device *tzone;
 	int ret;
 
 	mutex_lock(&mvm->mutex);
@@ -658,12 +657,6 @@ static int iwl_mvm_tzone_set_trip_temp(struct thermal_zone_device *device,
 		goto out;
 	}
 
-	tzone = &mvm->tz_device;
-	if (!tzone) {
-		ret = -EIO;
-		goto out;
-	}
-
 	ret = iwl_mvm_send_temp_report_ths_cmd(mvm);
 out:
 	mutex_unlock(&mvm->mutex);
-- 
2.41.0

