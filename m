Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28A46F6D29
	for <lists+linux-wireless@lfdr.de>; Thu,  4 May 2023 15:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbjEDNpu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 May 2023 09:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjEDNps (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 May 2023 09:45:48 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F637EF5
        for <linux-wireless@vger.kernel.org>; Thu,  4 May 2023 06:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683207946; x=1714743946;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VNpvCM9AnnndilVmYjOjmpd9Or0rHNq28oq9MTMxOVs=;
  b=flWS81vFZLVk+Qfpff7yLJkr6t0g+4IojeGVA9Gim6C7dU7di36vb8Yo
   bFsQhqMqvUGZAgwNtdJJh4a9KyKRG8+tWIUO2aO6ojtP2ZWkgk3iojc5p
   jrQppXSOZ2QSCIQVm1GccFE2sP0ff0mitcbMgqRSn2EgCKw6khosltm5H
   UMbbmGUos+jUU7xpWdIcEVmVL7sYROdvC4HL2+gK2ScrrLzmKCl19ae9p
   WuDBWycosW6gC1NGxE+DGqKf4iHbyg3ac4rRGurjpTW7dLsq38bDmAPiD
   YT9xJ56duc+/7/vB5k4xX2umqOhNLJnh7XawK/PjlhRf+CngSTLr580Ni
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="435242677"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="435242677"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 06:45:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="766591828"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="766591828"
Received: from haddadra-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.238.144])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 06:45:44 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 09/11] wifi: cfg80211: Add null check for ie data
Date:   Thu,  4 May 2023 16:45:09 +0300
Message-Id: <20230504134511.828474-10-gregory.greenman@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230504134511.828474-1-gregory.greenman@intel.com>
References: <20230504134511.828474-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

It's valid to pass NULL "ies" pointer to cfg80211_sme_get_conn_ies().
Add the corresponding NULL-check to avoid NULL pointer access.

Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/wireless/sme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index 7bdeb8eea92d..77277e4bca50 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -513,7 +513,7 @@ static int cfg80211_sme_get_conn_ies(struct wireless_dev *wdev,
 	if (!buf)
 		return -ENOMEM;
 
-	if (ies_len) {
+	if (ies) {
 		static const u8 before_extcapa[] = {
 			/* not listing IEs expected to be created by driver */
 			WLAN_EID_RSN,
-- 
2.38.1

