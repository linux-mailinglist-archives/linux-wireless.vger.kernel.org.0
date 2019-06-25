Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C329154D52
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2019 13:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729185AbfFYLPf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 07:15:35 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:44900 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728773AbfFYLPf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 07:15:35 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.224.233])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 3073430C009;
        Tue, 25 Jun 2019 04:10:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 3073430C009
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1561461031;
        bh=gaOlaNzDs92SPfiE5cFW9fbJpfQKUwXR9yLVoXOFWoE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nvX3W/78oqpT+rSygYtR0mRkp/55NvMfPWDdKk2SPPYmSS1uQ/F0ALCSAsVnwpEti
         +JNHhyM+a1qL/v5zbs+tLoo8IaZe+Wg1oX/arHXdmtfxqRHhUuizvVJtPi6jhDPK7s
         7rnId0SIRd2wjQehqOf+G18CKdF7wqrqdF0BWT04=
Received: from bld-bun-01.bun.broadcom.com (bld-bun-01.bun.broadcom.com [10.176.128.83])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id 7A43560D34;
        Tue, 25 Jun 2019 04:10:31 -0700 (PDT)
Received: by bld-bun-01.bun.broadcom.com (Postfix, from userid 25152)
        id CCD4CB02B44; Tue, 25 Jun 2019 13:10:29 +0200 (CEST)
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [RFC V2 8/8] cfg80211: apply same mandatory rate flags for 5GHz and 6GHz
Date:   Tue, 25 Jun 2019 13:10:27 +0200
Message-Id: <1561461027-10793-9-git-send-email-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1561461027-10793-1-git-send-email-arend.vanspriel@broadcom.com>
References: <1561461027-10793-1-git-send-email-arend.vanspriel@broadcom.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For the new 6GHz band the same rules apply for mandatory rates so
add it to set_mandatory_flags_band() function.

Reviewed-by: Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>
Reviewed-by: Leon Zegers <leon.zegers@broadcom.com>
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 net/wireless/util.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/wireless/util.c b/net/wireless/util.c
index 4462837..f0558e7 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -156,6 +156,7 @@ static void set_mandatory_flags_band(struct ieee80211_supported_band *sband)
 
 	switch (sband->band) {
 	case NL80211_BAND_5GHZ:
+	case NL80211_BAND_6GHZ:
 		want = 3;
 		for (i = 0; i < sband->n_bitrates; i++) {
 			if (sband->bitrates[i].bitrate == 60 ||
-- 
1.9.1

