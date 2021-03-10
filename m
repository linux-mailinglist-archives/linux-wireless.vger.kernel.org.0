Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D714733407C
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Mar 2021 15:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbhCJOkU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Mar 2021 09:40:20 -0500
Received: from mx2.freebsd.org ([96.47.72.81]:30972 "EHLO mx2.freebsd.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232251AbhCJOkN (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Mar 2021 09:40:13 -0500
Received: from mx1.freebsd.org (mx1.freebsd.org [96.47.72.80])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits))
        (Client CN "mx1.freebsd.org", Issuer "R3" (verified OK))
        by mx2.freebsd.org (Postfix) with ESMTPS id E8B8E7B942;
        Wed, 10 Mar 2021 14:40:12 +0000 (UTC)
        (envelope-from bz@FreeBSD.ORG)
Received: from smtp.freebsd.org (smtp.freebsd.org [96.47.72.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "smtp.freebsd.org", Issuer "R3" (verified OK))
        by mx1.freebsd.org (Postfix) with ESMTPS id 4DwZVh1xHfz3NsZ;
        Wed, 10 Mar 2021 14:40:12 +0000 (UTC)
        (envelope-from bz@FreeBSD.ORG)
Received: from mx1.sbone.de (mx1.sbone.de [IPv6:2a01:4f8:13b:39f::9f:25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mx1.sbone.de", Issuer "SBone.DE" (not verified))
        (Authenticated sender: bz/mail)
        by smtp.freebsd.org (Postfix) with ESMTPSA id 174121B25;
        Wed, 10 Mar 2021 14:40:12 +0000 (UTC)
        (envelope-from bz@FreeBSD.ORG)
Received: from mail.sbone.de (mail.sbone.de [IPv6:fde9:577b:c1a9:31::2013:587])
        (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.sbone.de (Postfix) with ESMTPS id DE1938D4A157;
        Wed, 10 Mar 2021 14:40:09 +0000 (UTC)
Received: from content-filter.sbone.de (content-filter.sbone.de [IPv6:fde9:577b:c1a9:31::2013:2742])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.sbone.de (Postfix) with ESMTPS id 7500FE707DF;
        Wed, 10 Mar 2021 14:40:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at sbone.de
Received: from mail.sbone.de ([IPv6:fde9:577b:c1a9:31::2013:587])
        by content-filter.sbone.de (content-filter.sbone.de [fde9:577b:c1a9:31::2013:2742]) (amavisd-new, port 10024)
        with ESMTP id p94CU9mrvFWe; Wed, 10 Mar 2021 14:40:08 +0000 (UTC)
Received: from nv.sbone.de (nv.sbone.de [IPv6:fde9:577b:c1a9:31::2013:138])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.sbone.de (Postfix) with ESMTPSA id 40F7EE707DE;
        Wed, 10 Mar 2021 14:40:08 +0000 (UTC)
Date:   Wed, 10 Mar 2021 14:40:07 +0000 (UTC)
From:   "Bjoern A. Zeeb" <bz@FreeBSD.ORG>
To:     linux-wireless@vger.kernel.org
cc:     luciano.coelho@intel.com
Subject: [PATCH v2 iwlwifi-next] iiwlwifi: move open ended iwl_mvm_internal_rxq_notif
 to end of struct
Message-ID: <alpine.BSF.2.00.2103101440030.72241@ai.fobar.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In struct iwl_mvm_rss_sync_notif, metadata is of type
struct iwl_mvm_internal_rxq_notif which is "open ended" [] and
hence should not be at the beginning but at the end of
struct iwl_mvm_rss_sync_notif.

Sponsored by:  The FreeBSD Foundation
Signed-off-by: Bjoern A. Zeeb <bz@FreeBSD.ORG>
---
changes since v1 - reduce diff context
---
  drivers/net/wireless/intel/iwlwifi/mvm/sta.h | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
index 35a18b96aac5..6cbe45bc1914 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
@@ -291,11 +291,11 @@ struct iwl_mvm_nssn_sync_data {
  } __packed;

  struct iwl_mvm_rss_sync_notif {
-	struct iwl_mvm_internal_rxq_notif metadata;
  	union {
  		struct iwl_mvm_delba_data delba;
  		struct iwl_mvm_nssn_sync_data nssn_sync;
  	};
+	struct iwl_mvm_internal_rxq_notif metadata;
  } __packed;

  /**
