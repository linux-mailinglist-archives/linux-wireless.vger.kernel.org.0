Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8950FD0BC6
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2019 11:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbfJIJu6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Oct 2019 05:50:58 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:47800 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725935AbfJIJu6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Oct 2019 05:50:58 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iI8cR-0003o4-QC; Wed, 09 Oct 2019 12:50:56 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed,  9 Oct 2019 12:48:52 +0300
Message-Id: <1570614256-@changeid>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 0/2] iwlwifi: fixes intended for 5.4 2019-10-09
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

This is my second patchset with fixes for v5.4.  Just a couple more
patches I'd like to include in the pull-req I'll send you today.

The changes are:

* Fix initialization of 3168 devices (the infamous BAD_COMMAND bug);
* Fix recognition of some newer systems with integrated MAC;

As usual, I'm pushing this to a pending branch, for kbuild bot.  I
will send you a pull-req today with these plus the ones I sent a few
days ago.

Cheers,
Luca.


Luca Coelho (2):
  iwlwifi: exclude GEO SAR support for 3168
  iwlwifi: pcie: change qu with jf devices to use qu configuration

 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  16 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 274 +++++++++---------
 2 files changed, 146 insertions(+), 144 deletions(-)

-- 
2.23.0

