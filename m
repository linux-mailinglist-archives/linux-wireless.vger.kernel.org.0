Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C523DCBA98
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2019 14:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387579AbfJDMhW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Oct 2019 08:37:22 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:46524 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387542AbfJDMhV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Oct 2019 08:37:21 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iGMpj-0000k1-Lj; Fri, 04 Oct 2019 15:37:20 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Fri,  4 Oct 2019 15:37:04 +0300
Message-Id: <20191004123706.15768-1-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 0/2] cfg80211/mac80211 patches from our internal tree 2019-10-04
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

A couple of patches with mac80211 and cfg80211 changes from our
internal tree.

Please review, though you have already reviewed most if not all of
them ;)

Cheers,
Luca.


Johannes Berg (1):
  mac80211: accept deauth frames in IBSS mode

Sara Sharon (1):
  cfg80211: fix a bunch of RCU issues in multi-bssid code

 net/mac80211/rx.c   | 11 ++++++++++-
 net/wireless/scan.c | 23 +++++++++++++----------
 2 files changed, 23 insertions(+), 11 deletions(-)

-- 
2.23.0

