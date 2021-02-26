Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8A23265E0
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Feb 2021 17:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhBZQxH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Feb 2021 11:53:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbhBZQxH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Feb 2021 11:53:07 -0500
Received: from mx2.freebsd.org (mx2.freebsd.org [IPv6:2610:1c1:1:606c::19:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCB9C061574
        for <linux-wireless@vger.kernel.org>; Fri, 26 Feb 2021 08:52:24 -0800 (PST)
Received: from mx1.freebsd.org (mx1.freebsd.org [96.47.72.80])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits))
        (Client CN "mx1.freebsd.org", Issuer "R3" (verified OK))
        by mx2.freebsd.org (Postfix) with ESMTPS id 7FFE0760BE;
        Fri, 26 Feb 2021 16:51:37 +0000 (UTC)
        (envelope-from bz@FreeBSD.ORG)
Received: from smtp.freebsd.org (smtp.freebsd.org [96.47.72.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "smtp.freebsd.org", Issuer "R3" (verified OK))
        by mx1.freebsd.org (Postfix) with ESMTPS id 4DnFzs2w41z4Y7F;
        Fri, 26 Feb 2021 16:51:37 +0000 (UTC)
        (envelope-from bz@FreeBSD.ORG)
Received: from mx1.sbone.de (mx1.sbone.de [IPv6:2a01:4f8:13b:39f::9f:25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mx1.sbone.de", Issuer "SBone.DE" (not verified))
        (Authenticated sender: bz/mail)
        by smtp.freebsd.org (Postfix) with ESMTPSA id 1CF562126;
        Fri, 26 Feb 2021 16:51:37 +0000 (UTC)
        (envelope-from bz@FreeBSD.ORG)
Received: from mail.sbone.de (mail.sbone.de [IPv6:fde9:577b:c1a9:31::2013:587])
        (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.sbone.de (Postfix) with ESMTPS id 12E498D4A15C;
        Fri, 26 Feb 2021 16:51:33 +0000 (UTC)
Received: from content-filter.sbone.de (content-filter.sbone.de [IPv6:fde9:577b:c1a9:31::2013:2742])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.sbone.de (Postfix) with ESMTPS id 941EDE707FE;
        Fri, 26 Feb 2021 16:51:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at sbone.de
Received: from mail.sbone.de ([IPv6:fde9:577b:c1a9:31::2013:587])
        by content-filter.sbone.de (content-filter.sbone.de [fde9:577b:c1a9:31::2013:2742]) (amavisd-new, port 10024)
        with ESMTP id VS7MjP2k-0lp; Fri, 26 Feb 2021 16:51:29 +0000 (UTC)
Received: from nv.sbone.de (nv.sbone.de [IPv6:fde9:577b:c1a9:31::2013:138])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.sbone.de (Postfix) with ESMTPSA id 3DF90E707D9;
        Fri, 26 Feb 2021 16:51:29 +0000 (UTC)
Date:   Fri, 26 Feb 2021 16:51:28 +0000 (UTC)
From:   "Bjoern A. Zeeb" <bz@FreeBSD.ORG>
To:     linux-wireless@vger.kernel.org
cc:     luciano.coelho@intel.com
Subject: [PATCH iwlwifi-next] iwlwifi: iwl-eeprom-parse: mostly dvm only
Message-ID: <alpine.BSF.2.00.2102261650380.72241@ai.fobar.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Most of iwl-eeprom-parse.c is only used for dvm but not for mvm.
Hide the parts under #if IS_ENABLED(CONFIG_IWLDVM) to reduce size
and code surface for mvm-only builds.

Sponsored-by:  The FreeBSD Foundation
Signed-off-by: Bjoern A. Zeeb <bz@FreeBSD.ORG>
---
  drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.c | 4 ++++
  1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.c
index f12b86563728..d7a7835b935c 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.c
@@ -1,50 +1,51 @@
  // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
  /*
   * Copyright (C) 2005-2014, 2018-2020 Intel Corporation
   * Copyright (C) 2015 Intel Mobile Communications GmbH
   */
  #include <linux/types.h>
  #include <linux/slab.h>
  #include <linux/export.h>
  #include "iwl-drv.h"
  #include "iwl-modparams.h"
  #include "iwl-eeprom-parse.h"

+#if IS_ENABLED(CONFIG_IWLDVM)
  /* EEPROM offset definitions */

  /* indirect access definitions */
  #define ADDRESS_MSK                 0x0000FFFF
  #define INDIRECT_TYPE_MSK           0x000F0000
  #define INDIRECT_HOST               0x00010000
  #define INDIRECT_GENERAL            0x00020000
  #define INDIRECT_REGULATORY         0x00030000
  #define INDIRECT_CALIBRATION        0x00040000
  #define INDIRECT_PROCESS_ADJST      0x00050000
  #define INDIRECT_OTHERS             0x00060000
  #define INDIRECT_TXP_LIMIT          0x00070000
  #define INDIRECT_TXP_LIMIT_SIZE     0x00080000
  #define INDIRECT_ADDRESS            0x00100000

  /* corresponding link offsets in EEPROM */
  #define EEPROM_LINK_HOST             (2*0x64)
  #define EEPROM_LINK_GENERAL          (2*0x65)
  #define EEPROM_LINK_REGULATORY       (2*0x66)
  #define EEPROM_LINK_CALIBRATION      (2*0x67)
  #define EEPROM_LINK_PROCESS_ADJST    (2*0x68)
  #define EEPROM_LINK_OTHERS           (2*0x69)
  #define EEPROM_LINK_TXP_LIMIT        (2*0x6a)
  #define EEPROM_LINK_TXP_LIMIT_SIZE   (2*0x6b)

  /* General */
  #define EEPROM_DEVICE_ID                    (2*0x08)	/* 2 bytes */
  #define EEPROM_SUBSYSTEM_ID		    (2*0x0A)	/* 2 bytes */
  #define EEPROM_MAC_ADDRESS                  (2*0x15)	/* 6  bytes */
  #define EEPROM_BOARD_REVISION               (2*0x35)	/* 2  bytes */
  #define EEPROM_BOARD_PBA_NUMBER             (2*0x3B+1)	/* 9  bytes */
  #define EEPROM_VERSION                      (2*0x44)	/* 2  bytes */
  #define EEPROM_SKU_CAP                      (2*0x45)	/* 2  bytes */
  #define EEPROM_OEM_MODE                     (2*0x46)	/* 2  bytes */
  #define EEPROM_RADIO_CONFIG                 (2*0x48)	/* 2  bytes */
  #define EEPROM_NUM_MAC_ADDRESS              (2*0x4C)	/* 2  bytes */

  /* calibration */
@@ -512,141 +513,142 @@ static void iwl_mod_ht40_chan_info(struct device *dev,
  static int iwl_init_channel_map(struct device *dev, const struct iwl_cfg *cfg,
  				struct iwl_nvm_data *data,
  				const u8 *eeprom, size_t eeprom_size)
  {
  	int band, ch_idx;
  	const struct iwl_eeprom_channel *eeprom_ch_info;
  	const u8 *eeprom_ch_array;
  	int eeprom_ch_count;
  	int n_channels = 0;

  	/*
  	 * Loop through the 5 EEPROM bands and add them to the parse list
  	 */
  	for (band = 1; band <= 5; band++) {
  		struct ieee80211_channel *channel;

  		iwl_init_band_reference(cfg, eeprom, eeprom_size, band,
  					&eeprom_ch_count, &eeprom_ch_info,
  					&eeprom_ch_array);

  		/* Loop through each band adding each of the channels */
  		for (ch_idx = 0; ch_idx < eeprom_ch_count; ch_idx++) {
  			const struct iwl_eeprom_channel *eeprom_ch;

  			eeprom_ch = &eeprom_ch_info[ch_idx];

  			if (!(eeprom_ch->flags & EEPROM_CHANNEL_VALID)) {
  				IWL_DEBUG_EEPROM(dev,
  						 "Ch. %d Flags %x [%sGHz] - No traffic\n",
  						 eeprom_ch_array[ch_idx],
  						 eeprom_ch_info[ch_idx].flags,
  						 (band != 1) ? "5.2" : "2.4");
  				continue;
  			}

  			channel = &data->channels[n_channels];
  			n_channels++;

  			channel->hw_value = eeprom_ch_array[ch_idx];
  			channel->band = (band == 1) ? NL80211_BAND_2GHZ
  						    : NL80211_BAND_5GHZ;
  			channel->center_freq =
  				ieee80211_channel_to_frequency(
  					channel->hw_value, channel->band);

  			/* set no-HT40, will enable as appropriate later */
  			channel->flags = IEEE80211_CHAN_NO_HT40;

  			if (!(eeprom_ch->flags & EEPROM_CHANNEL_IBSS))
  				channel->flags |= IEEE80211_CHAN_NO_IR;

  			if (!(eeprom_ch->flags & EEPROM_CHANNEL_ACTIVE))
  				channel->flags |= IEEE80211_CHAN_NO_IR;

  			if (eeprom_ch->flags & EEPROM_CHANNEL_RADAR)
  				channel->flags |= IEEE80211_CHAN_RADAR;

  			/* Initialize regulatory-based run-time data */
  			channel->max_power =
  				eeprom_ch_info[ch_idx].max_power_avg;
  			IWL_DEBUG_EEPROM(dev,
  					 "Ch. %d [%sGHz] %s%s%s%s%s%s(0x%02x %ddBm): Ad-Hoc %ssupported\n",
  					 channel->hw_value,
  					 (band != 1) ? "5.2" : "2.4",
  					 CHECK_AND_PRINT_I(VALID),
  					 CHECK_AND_PRINT_I(IBSS),
  					 CHECK_AND_PRINT_I(ACTIVE),
  					 CHECK_AND_PRINT_I(RADAR),
  					 CHECK_AND_PRINT_I(WIDE),
  					 CHECK_AND_PRINT_I(DFS),
  					 eeprom_ch_info[ch_idx].flags,
  					 eeprom_ch_info[ch_idx].max_power_avg,
  					 ((eeprom_ch_info[ch_idx].flags &
  							EEPROM_CHANNEL_IBSS) &&
  					  !(eeprom_ch_info[ch_idx].flags &
  							EEPROM_CHANNEL_RADAR))
  						? "" : "not ");
  		}
  	}

  	if (cfg->eeprom_params->enhanced_txpower) {
  		/*
  		 * for newer device (6000 series and up)
  		 * EEPROM contain enhanced tx power information
  		 * driver need to process addition information
  		 * to determine the max channel tx power limits
  		 */
  		iwl_eeprom_enhanced_txpower(dev, data, eeprom, eeprom_size,
  					    n_channels);
  	} else {
  		/* All others use data from channel map */
  		int i;

  		data->max_tx_pwr_half_dbm = -128;

  		for (i = 0; i < n_channels; i++)
  			data->max_tx_pwr_half_dbm =
  				max_t(s8, data->max_tx_pwr_half_dbm,
  				      data->channels[i].max_power * 2);
  	}

  	/* Check if we do have HT40 channels */
  	if (cfg->eeprom_params->regulatory_bands[5] ==
  				EEPROM_REGULATORY_BAND_NO_HT40 &&
  	    cfg->eeprom_params->regulatory_bands[6] ==
  				EEPROM_REGULATORY_BAND_NO_HT40)
  		return n_channels;

  	/* Two additional EEPROM bands for 2.4 and 5 GHz HT40 channels */
  	for (band = 6; band <= 7; band++) {
  		enum nl80211_band ieeeband;

  		iwl_init_band_reference(cfg, eeprom, eeprom_size, band,
  					&eeprom_ch_count, &eeprom_ch_info,
  					&eeprom_ch_array);

  		/* EEPROM band 6 is 2.4, band 7 is 5 GHz */
  		ieeeband = (band == 6) ? NL80211_BAND_2GHZ
  				       : NL80211_BAND_5GHZ;

  		/* Loop through each band adding each of the channels */
  		for (ch_idx = 0; ch_idx < eeprom_ch_count; ch_idx++) {
  			/* Set up driver's info for lower half */
  			iwl_mod_ht40_chan_info(dev, data, n_channels, ieeeband,
  					       eeprom_ch_array[ch_idx],
  					       &eeprom_ch_info[ch_idx],
  					       IEEE80211_CHAN_NO_HT40PLUS);

  			/* Set up driver's info for upper half */
  			iwl_mod_ht40_chan_info(dev, data, n_channels, ieeeband,
  					       eeprom_ch_array[ch_idx] + 4,
  					       &eeprom_ch_info[ch_idx],
  					       IEEE80211_CHAN_NO_HT40MINUS);
  		}
  	}

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
@@ -870,6 +873,7 @@ iwl_parse_eeprom_data(struct iwl_trans *trans, const struct iwl_cfg *cfg,
  	return data;
   err_free:
  	kfree(data);
  	return NULL;
  }
  IWL_EXPORT_SYMBOL(iwl_parse_eeprom_data);
+#endif
