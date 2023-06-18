Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7857347C1
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Jun 2023 20:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjFRSud (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Jun 2023 14:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjFRSub (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Jun 2023 14:50:31 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38911A4
        for <linux-wireless@vger.kernel.org>; Sun, 18 Jun 2023 11:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687114230; x=1718650230;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X9+cRppIYgnqwc2gBMU0AO1JD2MZ90XEGQc5CZz9FdI=;
  b=XkQiOuQEZ0WHLJi0g/D3tuteOpDU91hsErEaDToh4q6nVB6q3rOsS+kY
   edlbsKrYVOkVa5o0LdiNP9qVmdG//o1ddVo/4D63zUMueK7tEgTL0gR2W
   Tch1u0les25MH5ymsCPSeOCJHk9YY9SVHwhyVnH/j7tkqBwZrgHhqMNQE
   zDHZYA/Rw1yR0WWwS1GWD6AGRQt8rIP68cbbuX4+iB1A6MD7Y6S0j6QzA
   9viKjbWF5hgJRSR0s3cBFVX3XG0cwz9Kbzdmn9QlKbcpJhb0rjaGyuGAo
   7nBn4M+RdGM8UBtFx3Ix2TB9CC/lPEF8AW+uyYT3W+itgQCL2aOcslicu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="339116638"
X-IronPort-AV: E=Sophos;i="6.00,253,1681196400"; 
   d="scan'208";a="339116638"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2023 11:50:30 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="747233891"
X-IronPort-AV: E=Sophos;i="6.00,253,1681196400"; 
   d="scan'208";a="747233891"
Received: from aflumen-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.178.161])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2023 11:50:28 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Benjamin Berg <benjamin.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 06/20] wifi: cfg80211: Always ignore ML element
Date:   Sun, 18 Jun 2023 21:49:48 +0300
Message-Id: <20230618214435.c0e17989b4ed.I7cecb5ab7cd6919e61839b50ce5156904b41d7d8@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230618185002.817236-1-gregory.greenman@intel.com>
References: <20230618185002.817236-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Benjamin Berg <benjamin.berg@intel.com>

The element should never be inherited, so always exclude it.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/wireless/scan.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index dc71c6ac5bf5..095dc9db8750 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -218,6 +218,10 @@ bool cfg80211_is_element_inherited(const struct element *elem,
 	if (elem->id == WLAN_EID_MULTIPLE_BSSID)
 		return false;
 
+	if (elem->id == WLAN_EID_EXTENSION && elem->datalen > 1 &&
+	    elem->data[0] == WLAN_EID_EXT_EHT_MULTI_LINK)
+		return false;
+
 	if (!non_inherit_elem || non_inherit_elem->datalen < 2)
 		return true;
 
-- 
2.38.1

