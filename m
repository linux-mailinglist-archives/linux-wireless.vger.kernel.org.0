Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8F51C9AE4
	for <lists+linux-wireless@lfdr.de>; Thu,  7 May 2020 21:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgEGTWV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 May 2020 15:22:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:43186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbgEGTWV (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 May 2020 15:22:21 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC549208D6;
        Thu,  7 May 2020 19:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588879341;
        bh=cpk19YX7Aez2b3mVwHp6mHxj7I9/DZSqMJ91G22Vfuw=;
        h=Date:From:To:Cc:Subject:From;
        b=AIUqiOSqMD+IbcKBnyrPQHUA15R8Vwt80WMpmUWte5KgIG+EoDtDpGP8hpwpG7p75
         ph5gkgWPo0Jf4iTdULngqZrg2xMhTx9PQq9CnclBl/j3K7H8Hk9db96tH0GEXl4E4F
         FZZHnZDpyr0iFzrpuCxA62lxrSz5UwmVfY2nkoqs=
Date:   Thu, 7 May 2020 14:26:47 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jussi Kivilinna <jussi.kivilinna@iki.fi>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rndis_wlan: Replace zero-length array with flexible-array
Message-ID: <20200507192647.GA16710@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

sizeof(flexible-array-member) triggers a warning because flexible array
members have incomplete type[1]. There are some instances of code in
which the sizeof operator is being incorrectly/erroneously applied to
zero-length arrays and the result is zero. Such instances may be hiding
some bugs. So, this work (flexible-array member conversions) will also
help to get completely rid of those sorts of issues.

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/wireless/rndis_wlan.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/rndis_wlan.c b/drivers/net/wireless/rndis_wlan.c
index c8f8fe5497a8..52375f3e430a 100644
--- a/drivers/net/wireless/rndis_wlan.c
+++ b/drivers/net/wireless/rndis_wlan.c
@@ -201,7 +201,7 @@ struct ndis_80211_pmkid_candidate {
 struct ndis_80211_pmkid_cand_list {
 	__le32 version;
 	__le32 num_candidates;
-	struct ndis_80211_pmkid_candidate candidate_list[0];
+	struct ndis_80211_pmkid_candidate candidate_list[];
 } __packed;
 
 struct ndis_80211_status_indication {
@@ -246,12 +246,12 @@ struct ndis_80211_bssid_ex {
 	__le32 net_infra;
 	u8 rates[NDIS_802_11_LENGTH_RATES_EX];
 	__le32 ie_length;
-	u8 ies[0];
+	u8 ies[];
 } __packed;
 
 struct ndis_80211_bssid_list_ex {
 	__le32 num_items;
-	struct ndis_80211_bssid_ex bssid[0];
+	struct ndis_80211_bssid_ex bssid[];
 } __packed;
 
 struct ndis_80211_fixed_ies {
@@ -333,7 +333,7 @@ struct ndis_80211_bssid_info {
 struct ndis_80211_pmkid {
 	__le32 length;
 	__le32 bssid_info_count;
-	struct ndis_80211_bssid_info bssid_info[0];
+	struct ndis_80211_bssid_info bssid_info[];
 } __packed;
 
 /*

