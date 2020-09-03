Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3FCA25B938
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Sep 2020 05:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgICDal (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Sep 2020 23:30:41 -0400
Received: from mga09.intel.com ([134.134.136.24]:39110 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbgICDak (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Sep 2020 23:30:40 -0400
IronPort-SDR: ysxhkXAfRyuHdhBNAr+tE6IqxctWG9cY3NEIvvJ/G2PB2o/ZnYP6WEa7B/ucNyaH/kwRkOrdOw
 iNf7/slVCMHw==
X-IronPort-AV: E=McAfee;i="6000,8403,9732"; a="158499128"
X-IronPort-AV: E=Sophos;i="5.76,385,1592895600"; 
   d="scan'208";a="158499128"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2020 20:30:40 -0700
IronPort-SDR: n0Xg9xQVODTXyop4id9uWYS2ujZonXgZUANQWoYN2mKDIqfemekZl6JMzBuWjjrjuXwoONeHiA
 Yo+5r76yTA2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,385,1592895600"; 
   d="scan'208";a="326046526"
Received: from lkp-server01.sh.intel.com (HELO f1af165c0d27) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 02 Sep 2020 20:30:37 -0700
Received: from kbuild by f1af165c0d27 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kDfxM-00001y-Ui; Thu, 03 Sep 2020 03:30:36 +0000
Date:   Thu, 3 Sep 2020 11:30:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Wright Feng <wright.feng@cypress.com>,
        linux-wireless@vger.kernel.org
Cc:     kbuild-all@lists.01.org, wright.feng@cypress.com,
        brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>, chi-hsien.lin@cypress.com,
        Jia-Shyr Chuang <joseph.chuang@cypress.com>
Subject: [RFC PATCH] brcmfmac: brcmf_add_sta can be static
Message-ID: <20200903033004.GA86348@155f13fc43c6>
References: <20200901063237.15549-4-wright.feng@cypress.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901063237.15549-4-wright.feng@cypress.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


Signed-off-by: kernel test robot <lkp@intel.com>
---
 core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
index 595795e8cf6ac..c71c07e1f245a 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
@@ -1591,7 +1591,7 @@ brcmf_find_sta(struct brcmf_if *ifp, const u8 *ea)
 }
 
 /** Add STA into the interface's STA list. */
-struct brcmf_sta *
+static struct brcmf_sta *
 brcmf_add_sta(struct brcmf_if *ifp, const u8 *ea)
 {
 	struct brcmf_sta *sta;
