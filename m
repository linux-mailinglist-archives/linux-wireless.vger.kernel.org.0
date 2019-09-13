Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B99F4B1DD2
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2019 14:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729760AbfIMMmJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Sep 2019 08:42:09 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60426 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbfIMMmJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Sep 2019 08:42:09 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 328FB6083E; Fri, 13 Sep 2019 12:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568378528;
        bh=3JyKM7QLNfs8cE2S9rwNkGLcRkTSx0TOHJc5XmhFRRA=;
        h=From:To:Cc:Subject:Date:From;
        b=eX4A9h5v+uLyjQAR3m16An0QFtmIFr2ubNaDgOUg+ymsjmmwfC4DklOLapgp8V6Z6
         BTJdhEauosKhoUW9nRJVIuCmV+pchkCEuy9NuUk73fus1/bi+rdTpbHMv9txUPMb/C
         qZEPOn2Zt3KlYcmf0Nxx3B0GZ0eo6TPKiLTUA8B8=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from usdutt-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: usdutt@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 72ABF60767;
        Fri, 13 Sep 2019 12:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568378527;
        bh=3JyKM7QLNfs8cE2S9rwNkGLcRkTSx0TOHJc5XmhFRRA=;
        h=From:To:Cc:Subject:Date:From;
        b=DjsHxB8GfEdaXpgeX6aPLh+PuznHFnOGppqg3LN1laQQuPJ1t6kV4PZsaKSDK5AV4
         7i8s8/yshdnrHcdR9LI6wOAt6A9QnZQZjfvIMzlv8fZxrsm2QPFiegPSDIWq6kxH/1
         2OplAxKAfAmO1Bp2GXmxN6f/drGrkFnwdUSnWNGU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 72ABF60767
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=usdutt@codeaurora.org
From:   Sunil Dutt <usdutt@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Sunil Dutt <usdutt@codeaurora.org>
Subject: [PATCH] nl80211: Document the expectation for NL80211_ATTR_IE in NL80211_CMD_CONNECT
Date:   Fri, 13 Sep 2019 18:11:44 +0530
Message-Id: <1568378504-15179-1-git-send-email-usdutt@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This commit documents the expectation for NL80211_ATTR_IE when included
in NL80211_CMD_CONNECT, as following.

Driver shall not modify the IEs specified through NL80211_ATTR_IE if
NL80211_ATTR_MAC is included. However, if NL80211_ATTR_MAC_HINT is
included, these IEs through NL80211_ATTR_IE are specified by the user
space based on the best possible BSS selected. Thus, if the driver ends
up selecting a different BSS, it can modify these IEs accordingly (e.g.
userspace asks the driver to perform PMKSA caching with BSS1 and the
driver ends up selecting BSS2 with different PMKSA cache entry. RSNIE
has to get updated with the apt PMKID).

Signed-off-by: Sunil Dutt <usdutt@codeaurora.org>
---
 include/uapi/linux/nl80211.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index beee59c..325aaf1 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -571,6 +571,14 @@
  *	set of BSSID,frequency parameters is used (i.e., either the enforcing
  *	%NL80211_ATTR_MAC,%NL80211_ATTR_WIPHY_FREQ or the less strict
  *	%NL80211_ATTR_MAC_HINT and %NL80211_ATTR_WIPHY_FREQ_HINT).
+ *	Driver shall not modify the IEs specified through %NL80211_ATTR_IE if
+ *	%NL80211_ATTR_MAC is included. However, if %NL80211_ATTR_MAC_HINT is
+ *	included, these IEs through %NL80211_ATTR_IE are specified by the user
+ *	space based on the best possible BSS selected. Thus, if the driver ends
+ *	up selecting a different BSS, it can modify these IEs accordingly (e.g.
+ *	userspace asks the driver to perform PMKSA caching with BSS1 and the
+ *	driver ends up selecting BSS2 with different PMKSA cache entry. RSNIE
+ *	has to get updated with the apt PMKID).
  *	%NL80211_ATTR_PREV_BSSID can be used to request a reassociation within
  *	the ESS in case the device is already associated and an association with
  *	a different BSS is desired.
-- 
1.9.1

