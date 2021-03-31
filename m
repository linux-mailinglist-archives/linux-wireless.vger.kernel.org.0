Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0BE3350A15
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Apr 2021 00:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbhCaWQU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 Mar 2021 18:16:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:48608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232690AbhCaWQS (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 Mar 2021 18:16:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4E4EC61078;
        Wed, 31 Mar 2021 22:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617228978;
        bh=xv2nMo0980+R4VBEMhqDRwLR+Gyzx7lAAhs5zECqVf8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EP5yEiZcPdBfm84R7Erudu4P+Ykp/t3sOH86Vqr+VESINUOLK3OjOsfbdMvs8ib1n
         vSbMEuECzJng0AkmVaTuFbbwjXURj5ETlCMyg89UVId+/1i1xnGQeahgQzTuNF5Kvl
         64Vv6l9lBFKPHfZP77MCPS2c7cXYq7cRWVbXf0FqBifqy8pUJ3tCqvpG3FwsIg02O/
         d7psiI+grrQF2qx6mNk1Ijl/mQLxR5ONRuhPH00NJWD5QAlGlBgVCYSCn2fYX84IjL
         Apj0P8H+B+VcxASA0RvXbk2+FmBo4rhU5zN0eD0Dx9UP2VjpGoi40ndyv8Ph2GRMaS
         UGUz2xA+UGeWw==
Date:   Wed, 31 Mar 2021 16:16:20 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 2/2][next] wl3501_cs: Fix out-of-bounds warning in
 wl3501_mgmt_join
Message-ID: <f8c3c434f6d728b63358123fb40e57386920be9f.1617223928.git.gustavoars@kernel.org>
References: <cover.1617223928.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617223928.git.gustavoars@kernel.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix the following out-of-bounds warning by enclosing
some structure members into new struct req:

arch/x86/include/asm/string_32.h:182:25: warning: '__builtin_memcpy' offset [39, 108] from the object at 'sig' is out of the bounds of referenced subobject 'beacon_period' with type 'short unsigned int' at offset 36 [-Warray-bounds]

Refactor the code, accordingly:

$ pahole -C wl3501_join_req drivers/net/wireless/wl3501_cs.o
struct wl3501_join_req {
	u16                        next_blk;             /*     0     2 */
	u8                         sig_id;               /*     2     1 */
	u8                         reserved;             /*     3     1 */
	struct iw_mgmt_data_rset   operational_rset;     /*     4    10 */
	u16                        reserved2;            /*    14     2 */
	u16                        timeout;              /*    16     2 */
	u16                        probe_delay;          /*    18     2 */
	u8                         timestamp[8];         /*    20     8 */
	u8                         local_time[8];        /*    28     8 */
	struct {
		u16                beacon_period;        /*    36     2 */
		u16                dtim_period;          /*    38     2 */
		u16                cap_info;             /*    40     2 */
		u8                 bss_type;             /*    42     1 */
		u8                 bssid[6];             /*    43     6 */
		struct iw_mgmt_essid_pset ssid;          /*    49    34 */
		/* --- cacheline 1 boundary (64 bytes) was 19 bytes ago --- */
		struct iw_mgmt_ds_pset ds_pset;          /*    83     3 */
		struct iw_mgmt_cf_pset cf_pset;          /*    86     8 */
		struct iw_mgmt_ibss_pset ibss_pset;      /*    94     4 */
		struct iw_mgmt_data_rset bss_basic_rset; /*    98    10 */
	} req;                                           /*    36    72 */

	/* size: 108, cachelines: 2, members: 10 */
	/* last cacheline: 44 bytes */
};

The problem is that the original code is trying to copy data into a
bunch of struct members adjacent to each other in a single call to
memcpy(). Now that a new struct _req_ enclosing all those adjacent
members is introduced, memcpy() doesn't overrun the length of
&sig.beacon_period, because the address of the new struct object
_req_ is used as the destination, instead.

Also, this helps with the ongoing efforts to enable -Warray-bounds and
avoid confusing the compiler.

Link: https://github.com/KSPP/linux/issues/109
Reported-by: kernel test robot <lkp@intel.com>
Build-tested-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/lkml/60641d9b.2eNLedOGSdcSoAV2%25lkp@intel.com/
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/wireless/wl3501.h    | 22 ++++++++++++----------
 drivers/net/wireless/wl3501_cs.c |  4 ++--
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/wl3501.h b/drivers/net/wireless/wl3501.h
index ef9d605d8c88..774d8cac046d 100644
--- a/drivers/net/wireless/wl3501.h
+++ b/drivers/net/wireless/wl3501.h
@@ -389,16 +389,18 @@ struct wl3501_join_req {
 	u16			    probe_delay;
 	u8			    timestamp[8];
 	u8			    local_time[8];
-	u16			    beacon_period;
-	u16			    dtim_period;
-	u16			    cap_info;
-	u8			    bss_type;
-	u8			    bssid[ETH_ALEN];
-	struct iw_mgmt_essid_pset   ssid;
-	struct iw_mgmt_ds_pset	    ds_pset;
-	struct iw_mgmt_cf_pset	    cf_pset;
-	struct iw_mgmt_ibss_pset    ibss_pset;
-	struct iw_mgmt_data_rset    bss_basic_rset;
+	struct {
+		u16			    beacon_period;
+		u16			    dtim_period;
+		u16			    cap_info;
+		u8			    bss_type;
+		u8			    bssid[ETH_ALEN];
+		struct iw_mgmt_essid_pset   ssid;
+		struct iw_mgmt_ds_pset	    ds_pset;
+		struct iw_mgmt_cf_pset	    cf_pset;
+		struct iw_mgmt_ibss_pset    ibss_pset;
+		struct iw_mgmt_data_rset    bss_basic_rset;
+	} req;
 };
 
 struct wl3501_join_confirm {
diff --git a/drivers/net/wireless/wl3501_cs.c b/drivers/net/wireless/wl3501_cs.c
index 384bf84dfa51..e4f467116bab 100644
--- a/drivers/net/wireless/wl3501_cs.c
+++ b/drivers/net/wireless/wl3501_cs.c
@@ -589,7 +589,7 @@ static int wl3501_mgmt_join(struct wl3501_card *this, u16 stas)
 	struct wl3501_join_req sig = {
 		.sig_id		  = WL3501_SIG_JOIN_REQ,
 		.timeout	  = 10,
-		.ds_pset = {
+		.req.ds_pset = {
 			.el = {
 				.id  = IW_MGMT_INFO_ELEMENT_DS_PARAMETER_SET,
 				.len = 1,
@@ -598,7 +598,7 @@ static int wl3501_mgmt_join(struct wl3501_card *this, u16 stas)
 		},
 	};
 
-	memcpy(&sig.beacon_period, &this->bss_set[stas].beacon_period, 72);
+	memcpy(&sig.req, &this->bss_set[stas].beacon_period, sizeof(sig.req));
 	return wl3501_esbq_exec(this, &sig, sizeof(sig));
 }
 
-- 
2.27.0

