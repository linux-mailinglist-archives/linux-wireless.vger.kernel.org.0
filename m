Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0711185B6E
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2020 10:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbgCOJ1f (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 15 Mar 2020 05:27:35 -0400
Received: from the.earth.li ([93.93.131.124]:32966 "EHLO the.earth.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbgCOJ1f (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 15 Mar 2020 05:27:35 -0400
X-Greylist: delayed 23400 seconds by postgrey-1.27 at vger.kernel.org; Sun, 15 Mar 2020 05:27:34 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
         s=the; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=G1q++wL3ririgcEeSagYiQQcqI2rH+PGXUbjUOLutsA=; b=fHMyrNf45aLrtTJrH0Ajja5xZ7
        a3tLbe3diE8kYq+jjSGY0uCV//apNcFHpRAIZ5YhDe8bBwLIPBJqhpeyWkXOctpyNSVE9Hl+SKF1s
        /QwV0f6Zwh4iC/8SbJwEB1K4z+bT5iptsaThsWXskLchNTceUoLGsg0mjAFXz5PCu68PAyFLaL+hX
        njiwnkE3QzSYMXhkukbe+cx2hhCik3A/zJBTYdjG8ZtCIes0JG0iaLY4eYH7FJp89/aZ/m9Hqc9PF
        sJRwJofZ8VMnuREm7q4OfCTIK+4d6if2xQyiHl5/v0R9M6tLce07OJbm+7kg0RCa4W+mko53th9af
        VgtmxJXA==;
Received: from noodles by the.earth.li with local (Exim 4.92)
        (envelope-from <noodles@earth.li>)
        id 1jD4TU-0007aq-Lq; Sat, 14 Mar 2020 10:57:00 +0000
Date:   Sat, 14 Mar 2020 10:57:00 +0000
From:   Jonathan McDowell <noodles@earth.li>
To:     linux-wireless@vger.kernel.org
Cc:     Intel Linux Wireless <linuxwifi@intel.com>,
        Ihab Zhaika <ihab.zhaika@intel.com>, johannes.berg@intel.com,
        emmanuel.grumbach@intel.com, luciano.coelho@intel.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iwlwifi: mvm: Avoid use of GEO_TX_POWER_LIMIT when not
 supported
Message-ID: <20200314105700.GM311@earth.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Commit 39c1a9728f93 refactored the SAR table support and inadvertently
added a call to GEO_TX_POWER_LIMIT without checking that the firmware
supported it. This caused a regression for device + firmware
combinations lacking the support. Add a check in iwl_mvm_sar_init to
prevent this.

Fixes: 39c1a9728f93 (iwlwifi: refactor the SAR tables from mvm to acpi)
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=206395
Cc: stable@vger.kernel.org # 5.5
Signed-Off-By: Jonathan McDowell <noodles@earth.li>

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 54c094e88474..4a8a4cb2c553 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1007,6 +1007,13 @@ static int iwl_mvm_sar_init(struct iwl_mvm *mvm)
 	if (ret == -ENOENT)
 		return 1;
 
+	/*
+	 * If our firmware doesn't support GEO_TX_POWER_LIMIT then skip trying
+	 * to use it.
+	 */
+	if (!iwl_sar_geo_support(&mvm->fwrt))
+		return 1;
+
 	return ret;
 }
 

-- 
... Don't do it!
