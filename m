Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 436BC374639
	for <lists+linux-wireless@lfdr.de>; Wed,  5 May 2021 19:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238577AbhEERNF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 May 2021 13:13:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:38980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237019AbhEERDy (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 May 2021 13:03:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 90F4461411;
        Wed,  5 May 2021 16:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620232917;
        bh=AF0LyCzCHcFQbX1LKZxy0SltbwKtyd8cb5B1bo7RJ5E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QWV574uxF8V9L45bLW+czXPnNcR7AkQ483yypLsGfUl5wYjKDvXjesxv8Ve6MiCDM
         GUPpHliwq0D5F31NoXfF9QzqMxSfFoIJK/PQywEVeyWRdJS463j6+le2iexJ/4BQqk
         yHtRR2QvcutTr5UdjcK1ZC+v9RFqElrQYIEjiIos93E/y2xEw0z2xBjJjUiar+tBTQ
         N5WOPX4HlbIoUarIGaUJIGlv94mcHU9EHIpoyh9h6+DE10uYnqy2zts0lqlUo1NI16
         vuecMElRso8PFWX3gM7C2nMeY6llaVrAoSlPMcH8MJP1KbwtY8IAUFCf+xfQWtvDCl
         Wu6BQLEqzc59g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 19/22] wl3501_cs: Fix out-of-bounds warnings in wl3501_send_pkt
Date:   Wed,  5 May 2021 12:41:26 -0400
Message-Id: <20210505164129.3464277-19-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210505164129.3464277-1-sashal@kernel.org>
References: <20210505164129.3464277-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavoars@kernel.org>

[ Upstream commit 820aa37638a252b57967bdf4038a514b1ab85d45 ]

Fix the following out-of-bounds warnings by enclosing structure members
daddr and saddr into new struct addr, in structures wl3501_md_req and
wl3501_md_ind:

arch/x86/include/asm/string_32.h:182:25: warning: '__builtin_memcpy' offset [18, 23] from the object at 'sig' is out of the bounds of referenced subobject 'daddr' with type 'u8[6]' {aka 'unsigned char[6]'} at offset 11 [-Warray-bounds]
arch/x86/include/asm/string_32.h:182:25: warning: '__builtin_memcpy' offset [18, 23] from the object at 'sig' is out of the bounds of referenced subobject 'daddr' with type 'u8[6]' {aka 'unsigned char[6]'} at offset 11 [-Warray-bounds]

Refactor the code, accordingly:

$ pahole -C wl3501_md_req drivers/net/wireless/wl3501_cs.o
struct wl3501_md_req {
	u16                        next_blk;             /*     0     2 */
	u8                         sig_id;               /*     2     1 */
	u8                         routing;              /*     3     1 */
	u16                        data;                 /*     4     2 */
	u16                        size;                 /*     6     2 */
	u8                         pri;                  /*     8     1 */
	u8                         service_class;        /*     9     1 */
	struct {
		u8                 daddr[6];             /*    10     6 */
		u8                 saddr[6];             /*    16     6 */
	} addr;                                          /*    10    12 */

	/* size: 22, cachelines: 1, members: 8 */
	/* last cacheline: 22 bytes */
};

$ pahole -C wl3501_md_ind drivers/net/wireless/wl3501_cs.o
struct wl3501_md_ind {
	u16                        next_blk;             /*     0     2 */
	u8                         sig_id;               /*     2     1 */
	u8                         routing;              /*     3     1 */
	u16                        data;                 /*     4     2 */
	u16                        size;                 /*     6     2 */
	u8                         reception;            /*     8     1 */
	u8                         pri;                  /*     9     1 */
	u8                         service_class;        /*    10     1 */
	struct {
		u8                 daddr[6];             /*    11     6 */
		u8                 saddr[6];             /*    17     6 */
	} addr;                                          /*    11    12 */

	/* size: 24, cachelines: 1, members: 9 */
	/* padding: 1 */
	/* last cacheline: 24 bytes */
};

The problem is that the original code is trying to copy data into a
couple of arrays adjacent to each other in a single call to memcpy().
Now that a new struct _addr_ enclosing those two adjacent arrays
is introduced, memcpy() doesn't overrun the length of &sig.daddr[0]
and &sig.daddr, because the address of the new struct object _addr_
is used, instead.

This helps with the ongoing efforts to globally enable -Warray-bounds
and get us closer to being able to tighten the FORTIFY_SOURCE routines
on memcpy().

Link: https://github.com/KSPP/linux/issues/109
Reported-by: kernel test robot <lkp@intel.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Link: https://lore.kernel.org/r/d260fe56aed7112bff2be5b4d152d03ad7b78e78.1618442265.git.gustavoars@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/wl3501.h    | 12 ++++++++----
 drivers/net/wireless/wl3501_cs.c | 10 ++++++----
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/wl3501.h b/drivers/net/wireless/wl3501.h
index 3fbfd19818f1..ba2a36cfb1c8 100644
--- a/drivers/net/wireless/wl3501.h
+++ b/drivers/net/wireless/wl3501.h
@@ -470,8 +470,10 @@ struct wl3501_md_req {
 	u16	size;
 	u8	pri;
 	u8	service_class;
-	u8	daddr[ETH_ALEN];
-	u8	saddr[ETH_ALEN];
+	struct {
+		u8	daddr[ETH_ALEN];
+		u8	saddr[ETH_ALEN];
+	} addr;
 };
 
 struct wl3501_md_ind {
@@ -483,8 +485,10 @@ struct wl3501_md_ind {
 	u8	reception;
 	u8	pri;
 	u8	service_class;
-	u8	daddr[ETH_ALEN];
-	u8	saddr[ETH_ALEN];
+	struct {
+		u8	daddr[ETH_ALEN];
+		u8	saddr[ETH_ALEN];
+	} addr;
 };
 
 struct wl3501_md_confirm {
diff --git a/drivers/net/wireless/wl3501_cs.c b/drivers/net/wireless/wl3501_cs.c
index 932f3f81e8cf..f49a44581ede 100644
--- a/drivers/net/wireless/wl3501_cs.c
+++ b/drivers/net/wireless/wl3501_cs.c
@@ -468,6 +468,7 @@ static int wl3501_send_pkt(struct wl3501_card *this, u8 *data, u16 len)
 	struct wl3501_md_req sig = {
 		.sig_id = WL3501_SIG_MD_REQ,
 	};
+	size_t sig_addr_len = sizeof(sig.addr);
 	u8 *pdata = (char *)data;
 	int rc = -EIO;
 
@@ -483,9 +484,9 @@ static int wl3501_send_pkt(struct wl3501_card *this, u8 *data, u16 len)
 			goto out;
 		}
 		rc = 0;
-		memcpy(&sig.daddr[0], pdata, 12);
-		pktlen = len - 12;
-		pdata += 12;
+		memcpy(&sig.addr, pdata, sig_addr_len);
+		pktlen = len - sig_addr_len;
+		pdata += sig_addr_len;
 		sig.data = bf;
 		if (((*pdata) * 256 + (*(pdata + 1))) > 1500) {
 			u8 addr4[ETH_ALEN] = {
@@ -979,7 +980,8 @@ static inline void wl3501_md_ind_interrupt(struct net_device *dev,
 	} else {
 		skb->dev = dev;
 		skb_reserve(skb, 2); /* IP headers on 16 bytes boundaries */
-		skb_copy_to_linear_data(skb, (unsigned char *)&sig.daddr, 12);
+		skb_copy_to_linear_data(skb, (unsigned char *)&sig.addr,
+					sizeof(sig.addr));
 		wl3501_receive(this, skb->data, pkt_len);
 		skb_put(skb, pkt_len);
 		skb->protocol	= eth_type_trans(skb, dev);
-- 
2.30.2

