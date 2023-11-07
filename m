Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8437E4399
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Nov 2023 16:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344020AbjKGPiX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Nov 2023 10:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235397AbjKGPiK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Nov 2023 10:38:10 -0500
Received: from forward101c.mail.yandex.net (forward101c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1EF199A
        for <linux-wireless@vger.kernel.org>; Tue,  7 Nov 2023 07:26:49 -0800 (PST)
Received: from mail-nwsmtp-smtp-production-main-19.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-19.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:4081:0:640:557:0])
        by forward101c.mail.yandex.net (Yandex) with ESMTP id EF21A60AF0;
        Tue,  7 Nov 2023 18:26:46 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-19.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id jQerFV7UleA0-DyzCOYWn;
        Tue, 07 Nov 2023 18:26:46 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1699370806; bh=ow/wc9GycQN176Q1ZwQgeyiCez1CbjSPVPJS31ewokk=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=T1bmOFkDq/Ql82ErucPO0YGTBWdj+m/eM9aVpoYDxtCpH1BEiIBUdSs13FyeR4y5+
         QVU+hb4khnXIsoADfZh9hwaYs+TLXrCkikF6R3Eo7b5xZpfj7YcuKZHgo3qjXNRfDn
         XmKaHvk6CNJEAWYlNZFKVfwSo+QT+B9r36HpawiA=
Authentication-Results: mail-nwsmtp-smtp-production-main-19.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Gregory Greenman <gregory.greenman@intel.com>
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: iwlwifi: add missing milliseconds to TUs conversion
Date:   Tue,  7 Nov 2023 18:26:00 +0300
Message-ID: <20231107152611.61952-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since 'max_delay' and 'duration' of 'struct iwl_time_event_cmd'
are in TUs rather than milliseconds, add missing 'MSEC_TO_TU()'
in 'iwl_mvm_protect_session()' and 'iwl_mvm_schedule_csa_period()'.
Compile tested only.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/intel/iwlwifi/mvm/time-event.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
index 218fdf1ed530..084fdc5fa186 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -656,10 +656,10 @@ void iwl_mvm_protect_session(struct iwl_mvm *mvm,
 	time_cmd.apply_time = cpu_to_le32(0);
 
 	time_cmd.max_frags = TE_V2_FRAG_NONE;
-	time_cmd.max_delay = cpu_to_le32(max_delay);
+	time_cmd.max_delay = cpu_to_le32(MSEC_TO_TU(max_delay));
 	/* TODO: why do we need to interval = bi if it is not periodic? */
 	time_cmd.interval = cpu_to_le32(1);
-	time_cmd.duration = cpu_to_le32(duration);
+	time_cmd.duration = cpu_to_le32(MSEC_TO_TU(duration));
 	time_cmd.repeat = 1;
 	time_cmd.policy = cpu_to_le16(TE_V2_NOTIF_HOST_EVENT_START |
 				      TE_V2_NOTIF_HOST_EVENT_END |
@@ -1249,7 +1249,7 @@ int iwl_mvm_schedule_csa_period(struct iwl_mvm *mvm,
 	time_cmd.id = cpu_to_le32(TE_CHANNEL_SWITCH_PERIOD);
 	time_cmd.apply_time = cpu_to_le32(apply_time);
 	time_cmd.max_frags = TE_V2_FRAG_NONE;
-	time_cmd.duration = cpu_to_le32(duration);
+	time_cmd.duration = cpu_to_le32(MSEC_TO_TU(duration));
 	time_cmd.repeat = 1;
 	time_cmd.interval = cpu_to_le32(1);
 	time_cmd.policy = cpu_to_le16(TE_V2_NOTIF_HOST_EVENT_START |
-- 
2.41.0

