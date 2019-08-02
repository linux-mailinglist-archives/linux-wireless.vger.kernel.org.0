Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C35DD7F604
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Aug 2019 13:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392379AbfHBLb2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Aug 2019 07:31:28 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:49824 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732737AbfHBLbY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Aug 2019 07:31:24 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.224.233])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id A6A4430C03C;
        Fri,  2 Aug 2019 04:31:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com A6A4430C03C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1564745482;
        bh=gaOlaNzDs92SPfiE5cFW9fbJpfQKUwXR9yLVoXOFWoE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J0m1k7yQWSHyPEOe3TRNb3Qx3ZMxrYX+8gvb1YNWkf2M7J7+/89mCqYfdmdISoAAG
         4ZKNyHWe2FGwN8Nptck0wGFULjNuKu3nnD18kFcHhaO4JW8GTfePIQYAtn8JLMMEvU
         XwpruagdSKsMfPnkfHiP2/pe+pPcniW+vrhjsERk=
Received: from bld-bun-01.bun.broadcom.com (bld-bun-01.bun.broadcom.com [10.176.128.83])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id CDA2B60985;
        Fri,  2 Aug 2019 04:31:22 -0700 (PDT)
Received: by bld-bun-01.bun.broadcom.com (Postfix, from userid 25152)
        id 4EEB5B02E32; Fri,  2 Aug 2019 13:31:20 +0200 (CEST)
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH V3 8/8] cfg80211: apply same mandatory rate flags for 5GHz and 6GHz
Date:   Fri,  2 Aug 2019 13:31:05 +0200
Message-Id: <1564745465-21234-9-git-send-email-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1564745465-21234-1-git-send-email-arend.vanspriel@broadcom.com>
References: <1564745465-21234-1-git-send-email-arend.vanspriel@broadcom.com>
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

