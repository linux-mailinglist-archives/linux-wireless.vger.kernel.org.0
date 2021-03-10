Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6BA033407E
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Mar 2021 15:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbhCJOkx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Mar 2021 09:40:53 -0500
Received: from mx2.freebsd.org ([96.47.72.81]:31442 "EHLO mx2.freebsd.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232785AbhCJOkb (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Mar 2021 09:40:31 -0500
Received: from mx1.freebsd.org (mx1.freebsd.org [96.47.72.80])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits))
        (Client CN "mx1.freebsd.org", Issuer "R3" (verified OK))
        by mx2.freebsd.org (Postfix) with ESMTPS id 4D6FF7B69E;
        Wed, 10 Mar 2021 14:40:28 +0000 (UTC)
        (envelope-from bz@FreeBSD.ORG)
Received: from smtp.freebsd.org (smtp.freebsd.org [IPv6:2610:1c1:1:606c::24b:4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "smtp.freebsd.org", Issuer "R3" (verified OK))
        by mx1.freebsd.org (Postfix) with ESMTPS id 4DwZW00y6xz3Ntq;
        Wed, 10 Mar 2021 14:40:28 +0000 (UTC)
        (envelope-from bz@FreeBSD.ORG)
Received: from mx1.sbone.de (mx1.sbone.de [IPv6:2a01:4f8:13b:39f::9f:25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mx1.sbone.de", Issuer "SBone.DE" (not verified))
        (Authenticated sender: bz/mail)
        by smtp.freebsd.org (Postfix) with ESMTPSA id F254F1C3D;
        Wed, 10 Mar 2021 14:40:27 +0000 (UTC)
        (envelope-from bz@FreeBSD.ORG)
Received: from mail.sbone.de (mail.sbone.de [IPv6:fde9:577b:c1a9:31::2013:587])
        (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.sbone.de (Postfix) with ESMTPS id A80DF8D4A157;
        Wed, 10 Mar 2021 14:40:25 +0000 (UTC)
Received: from content-filter.sbone.de (content-filter.sbone.de [IPv6:fde9:577b:c1a9:31::2013:2742])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.sbone.de (Postfix) with ESMTPS id 24448E707E0;
        Wed, 10 Mar 2021 14:40:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at sbone.de
Received: from mail.sbone.de ([IPv6:fde9:577b:c1a9:31::2013:587])
        by content-filter.sbone.de (content-filter.sbone.de [fde9:577b:c1a9:31::2013:2742]) (amavisd-new, port 10024)
        with ESMTP id 3zyRjR-U_wTf; Wed, 10 Mar 2021 14:40:23 +0000 (UTC)
Received: from nv.sbone.de (nv.sbone.de [IPv6:fde9:577b:c1a9:31::2013:138])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.sbone.de (Postfix) with ESMTPSA id 8E4FEE707DF;
        Wed, 10 Mar 2021 14:40:23 +0000 (UTC)
Date:   Wed, 10 Mar 2021 14:40:23 +0000 (UTC)
From:   "Bjoern A. Zeeb" <bz@FreeBSD.ORG>
To:     linux-wireless@vger.kernel.org
cc:     luciano.coelho@intel.com
Subject: [PATCH v2 iwlwifi-next] iwlwifi: iwl-eeprom-parse: mostly dvm only
Message-ID: <alpine.BSF.2.00.2103101358170.72241@ai.fobar.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Most of iwl-eeprom-parse.c is only used for dvm but not for mvm.
Hide the parts under #if IS_ENABLED(CONFIG_IWLDVM) to reduce size
and code surface for mvm-only builds.

Sponsored by:  The FreeBSD Foundation
Signed-off-by: Bjoern A. Zeeb <bz@FreeBSD.ORG>
---
changes since v1 - reduce diff context
---
  drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.c | 4 ++++
  1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.c
index f12b86563728..d7a7835b935c 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.c
@@ -10,6 +10,7 @@
  #include "iwl-modparams.h"
  #include "iwl-eeprom-parse.h"

+#if IS_ENABLED(CONFIG_IWLDVM)
  /* EEPROM offset definitions */

  /* indirect access definitions */
@@ -647,6 +648,7 @@ static int iwl_init_channel_map(struct device *dev, const struct iwl_cfg *cfg,

  	return n_channels;
  }
+#endif

  int iwl_init_sband_channels(struct iwl_nvm_data *data,
  			    struct ieee80211_supported_band *sband,
@@ -750,6 +752,7 @@ void iwl_init_ht_hw_capab(struct iwl_trans *trans,
  	}
  }

+#if IS_ENABLED(CONFIG_IWLDVM)
  static void iwl_init_sbands(struct iwl_trans *trans, const struct iwl_cfg *cfg,
  			    struct iwl_nvm_data *data,
  			    const u8 *eeprom, size_t eeprom_size)
@@ -873,3 +876,4 @@ iwl_parse_eeprom_data(struct iwl_trans *trans, const struct iwl_cfg *cfg,
  	return NULL;
  }
  IWL_EXPORT_SYMBOL(iwl_parse_eeprom_data);
+#endif
