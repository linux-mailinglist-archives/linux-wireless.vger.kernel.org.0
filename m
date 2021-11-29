Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFA4461011
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Nov 2021 09:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349462AbhK2I3P (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Nov 2021 03:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241217AbhK2I1O (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Nov 2021 03:27:14 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF2EC0613D7
        for <linux-wireless@vger.kernel.org>; Mon, 29 Nov 2021 00:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=jREAY2duNHHvUEBK41+fJAJ2O8NL0QDIsvdSbCwh7rc=; t=1638173996; x=1639383596; 
        b=agKRXo1k9QejlIw9B5JBKlc2ndW1QvwY2L/+JD8IZpL3Zbh7CXuf1D0UQdec2jCsxZCULQ2nMbs
        gKbSPXYDaTgg+EgeZi6KQKa2uyDvioVLRBbfXHHJefs6rh/CZ+PGRL0pDHRK7cUUHC37DULP9wbfH
        fzoL3fdogzlC2tXN18mhuAh9XnmDM/D0SRcSm50EqpRDAzC2nNKjy9fKkXqwaMUTATmLzcPb2VKPw
        6uunSGhhGzo1E3J2emOHEBoVmVRrngcdGV7bZSGvcowPWOnHvX2HggITxJJe9aVMP4thFNd0J6jaE
        DVlBJJ/rqrqFk1ZksWV//Sdd+rDhocrGjv+g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mrbtA-004LBD-0d;
        Mon, 29 Nov 2021 09:19:52 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] mac80211: add docs for ssn in struct tid_ampdu_tx
Date:   Mon, 29 Nov 2021 09:19:49 +0100
Message-Id: <20211129091948.1327ec82beab.Iecc5975406a3028d35c65ff8d2dec31a693888d3@changeid>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

As pointed out by Stephen, add the missing docs.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/sta_info.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index e7443fc4669c..379fd367197f 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -176,6 +176,7 @@ struct sta_info;
  * @failed_bar_ssn: ssn of the last failed BAR tx attempt
  * @bar_pending: BAR needs to be re-sent
  * @amsdu: support A-MSDU withing A-MDPU
+ * @ssn: starting sequence number of the session
  *
  * This structure's lifetime is managed by RCU, assignments to
  * the array holding it must hold the aggregation mutex.
-- 
2.33.1

