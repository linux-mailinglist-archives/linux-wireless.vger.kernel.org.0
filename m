Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE6A457D3
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2019 10:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbfFNItA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Jun 2019 04:49:00 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54490 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726530AbfFNItA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Jun 2019 04:49:00 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hbhtJ-00081c-TR; Fri, 14 Jun 2019 11:48:58 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 0/3] iwlwifi: fixes intended for 5.2 2019-06-14
Date:   Fri, 14 Jun 2019 11:48:48 +0300
Message-Id: <20190614084852.386-1-luca@coelho.fi>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

This is the second patchset with fixes for v5.2.

The changes are:

* Add some new cards and fix some structs for 22000 series;

As usual, I'm pushing this to a pending branch, for kbuild bot.  And
as we agreed, I'll delegate these patches to you in patchwork for you
to apply them directly.

Please review.

Cheers,
Luca.


Ihab Zhaika (3):
  iwlwifi: add new cards for 22000 and fix struct name
  iwlwifi: add new cards for 22000 and change wrong structs
  iwlwifi: change 0x02F0 fw from qu to quz

 .../net/wireless/intel/iwlwifi/cfg/22000.c    | 144 ++++++++++-
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  14 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 241 +++++++++---------
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |   4 +-
 4 files changed, 279 insertions(+), 124 deletions(-)

-- 
2.20.1

