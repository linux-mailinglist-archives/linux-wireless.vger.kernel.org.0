Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 369843265EB
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Feb 2021 17:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhBZQzb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Feb 2021 11:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbhBZQza (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Feb 2021 11:55:30 -0500
Received: from mx2.freebsd.org (mx2.freebsd.org [IPv6:2610:1c1:1:606c::19:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C5CC061574
        for <linux-wireless@vger.kernel.org>; Fri, 26 Feb 2021 08:54:47 -0800 (PST)
Received: from mx1.freebsd.org (mx1.freebsd.org [96.47.72.80])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits))
        (Client CN "mx1.freebsd.org", Issuer "R3" (verified OK))
        by mx2.freebsd.org (Postfix) with ESMTPS id 8E9E0761E5;
        Fri, 26 Feb 2021 16:54:05 +0000 (UTC)
        (envelope-from bz@FreeBSD.ORG)
Received: from smtp.freebsd.org (smtp.freebsd.org [IPv6:2610:1c1:1:606c::24b:4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "smtp.freebsd.org", Issuer "R3" (verified OK))
        by mx1.freebsd.org (Postfix) with ESMTPS id 4DnG2j3CKTz4YKK;
        Fri, 26 Feb 2021 16:54:05 +0000 (UTC)
        (envelope-from bz@FreeBSD.ORG)
Received: from mx1.sbone.de (cross.sbone.de [195.201.62.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mx1.sbone.de", Issuer "SBone.DE" (not verified))
        (Authenticated sender: bz/mail)
        by smtp.freebsd.org (Postfix) with ESMTPSA id 4BE472132;
        Fri, 26 Feb 2021 16:54:05 +0000 (UTC)
        (envelope-from bz@FreeBSD.ORG)
Received: from mail.sbone.de (mail.sbone.de [IPv6:fde9:577b:c1a9:31::2013:587])
        (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.sbone.de (Postfix) with ESMTPS id 2F0458D4A169;
        Fri, 26 Feb 2021 16:54:04 +0000 (UTC)
Received: from content-filter.sbone.de (content-filter.sbone.de [IPv6:fde9:577b:c1a9:31::2013:2742])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.sbone.de (Postfix) with ESMTPS id C47BDE707FE;
        Fri, 26 Feb 2021 16:54:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at sbone.de
Received: from mail.sbone.de ([IPv6:fde9:577b:c1a9:31::2013:587])
        by content-filter.sbone.de (content-filter.sbone.de [fde9:577b:c1a9:31::2013:2742]) (amavisd-new, port 10024)
        with ESMTP id mkO9D2CH-Wkq; Fri, 26 Feb 2021 16:54:02 +0000 (UTC)
Received: from nv.sbone.de (nv.sbone.de [IPv6:fde9:577b:c1a9:31::2013:138])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.sbone.de (Postfix) with ESMTPSA id 52C9BE707D9;
        Fri, 26 Feb 2021 16:54:02 +0000 (UTC)
Date:   Fri, 26 Feb 2021 16:54:01 +0000 (UTC)
From:   "Bjoern A. Zeeb" <bz@FreeBSD.ORG>
To:     linux-wireless@vger.kernel.org
cc:     luciano.coelho@intel.com
Subject: [PATCH iwlwifi-next] iiwlwifi: move open ended iwl_mvm_internal_rxq_notif
 to end of struct
Message-ID: <alpine.BSF.2.00.2102261653460.72241@ai.fobar.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In struct iwl_mvm_rss_sync_notif, metadata is of type
struct iwl_mvm_internal_rxq_notif which is "open ended" [] and
hence should not be at the beginning but at the end of
struct iwl_mvm_rss_sync_notif.

Sponsored-by:  The FreeBSD Foundation
Signed-off-by: Bjoern A. Zeeb <bz@FreeBSD.ORG>
---
  drivers/net/wireless/intel/iwlwifi/mvm/sta.h | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
index 35a18b96aac5..6cbe45bc1914 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
@@ -291,15 +291,15 @@ struct iwl_mvm_nssn_sync_data {
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
   * struct iwl_mvm_rxq_dup_data - per station per rx queue data
   * @last_seq: last sequence per tid for duplicate packet detection
   * @last_sub_frame: last subframe packet
   */
