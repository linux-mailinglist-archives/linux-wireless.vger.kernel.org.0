Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A529F64BE40
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Dec 2022 22:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236288AbiLMVQl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Dec 2022 16:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235112AbiLMVQj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Dec 2022 16:16:39 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE5522291
        for <linux-wireless@vger.kernel.org>; Tue, 13 Dec 2022 13:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670966198; x=1702502198;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wutIuhJXADgcp6849lC/HVvOwY1qXDl19M5ZK3UW/M0=;
  b=EJqOVNrJEBqRlsapyu/CVrGWgX6JIp7U5VOCU7A2RpNbJJpVTocG5ljE
   rs3v7ZUz58bBlGJW56Pfvy6eNZxoVqm/aH+aGRM+YBZJOjSreW7y9MAOW
   CB+tP4s8YVobxQsOYyKqjYoN0v//5JmrXxGIIcMSFKYCYWj4z4LAfXS1v
   DsFQAJd4Y99Wo2o2UoNtYbzTJn4m7SctmfEox2rV80XOb7eAUFogK1s0N
   PxcMhchyXcNM5Ns1UgpMMx+DuSN62nAV5isb7KsrTszs66rX6hP12x9YG
   OoXtDJ8ntzrRw5W3faZvuc8N7Gcu08vgiuk/6p4dYrUtpgV1TV3MfJU2P
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="345305506"
X-IronPort-AV: E=Sophos;i="5.96,242,1665471600"; 
   d="scan'208";a="345305506"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 13:16:19 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="679436154"
X-IronPort-AV: E=Sophos;i="5.96,242,1665471600"; 
   d="scan'208";a="679436154"
Received: from szamir-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.251.183.161])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 13:16:16 -0800
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        =?UTF-8?q?=C3=8D=C3=B1igo=20Huguet?= <ihuguet@redhat.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH] wifi: iwlwifi: fw: skip PPAG for JF
Date:   Tue, 13 Dec 2022 23:15:04 +0200
Message-Id: <20221213225723.2a43415d8990.I9ac210740a45b41f1b2e15274e1daf4284f2808a@changeid>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

For JF RFs we don't support PPAG, but many firmware
images lie about it. Always skip support for JF to
avoid firmware errors when sending the command.

Reported-and-tested-by: Íñigo Huguet <ihuguet@redhat.com>
Link: https://lore.kernel.org/linux-wireless/CACT4oufQsqHGp6bah2c4+jPn2wG1oZqY=UKa_TmPx=F6Lxng8Q@mail.gmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---

This is a fix for a firmware assert. It can wait until the next RC of v6.2.
Kalle - should I send a pull request for it? Thanks!

 drivers/net/wireless/intel/iwlwifi/fw/acpi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index e6d64152c81a..a02e5a67b706 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -1106,6 +1106,11 @@ int iwl_read_ppag_table(struct iwl_fw_runtime *fwrt, union iwl_ppag_table_cmd *c
         int i, j, num_sub_bands;
         s8 *gain;
 
+	/* many firmware images for JF lie about this */
+	if (CSR_HW_RFID_TYPE(fwrt->trans->hw_rf_id) ==
+	    CSR_HW_RFID_TYPE(CSR_HW_RF_ID_TYPE_JF))
+		return -EOPNOTSUPP;
+
         if (!fw_has_capa(&fwrt->fw->ucode_capa, IWL_UCODE_TLV_CAPA_SET_PPAG)) {
                 IWL_DEBUG_RADIO(fwrt,
                                 "PPAG capability not supported by FW, command not sent.\n");
-- 
2.38.1

