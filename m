Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C47A221835
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jul 2020 01:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgGOXFj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Jul 2020 19:05:39 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:64626 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726578AbgGOXFj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Jul 2020 19:05:39 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594854338; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=53cGYSM8uY4jfeXy+EYGCa0iHjd8RkyABxLd7Fas/BQ=; b=iq3XZaf26bwfGy3Rm5nRqlOknEi4umtFffKXYnmrGX2bWSPQ5b1/Ig6tm7sRsY37sDipmMtg
 D9EEa0UlhGOBOM32o+cIQiHKgkB9htDKR3aseMObQyfNVx/qYVctaFYTdeaA5qRyoZq7p/46
 HnVUs/Z5BI+cuw/R4yILKOhR49w=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n18.prod.us-east-1.postgun.com with SMTP id
 5f0f8bb08423214e137ba240 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 15 Jul 2020 23:05:20
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7B7D1C433CB; Wed, 15 Jul 2020 23:05:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DB3EEC433CA;
        Wed, 15 Jul 2020 23:05:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DB3EEC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=alokad@codeaurora.org
From:   Aloka Dixit <alokad@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Aloka Dixit <alokad@codeaurora.org>
Subject: [PATCH v3 0/2] Unsolicited broadcast probe resp support
Date:   Wed, 15 Jul 2020 16:05:12 -0700
Message-Id: <20200715230514.26792-1-alokad@codeaurora.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Unsolicited broadcast probe response tranmission is used for in-band
discovery in 6GHz band (IEEE P802.11ax/D6.0 26.17.2.3.2, AP behavior for
fast passive scanning).

v3: Rebased. Removed check for 6Ghz, drivers should add that check.

v2: Removed flag 'enabled' and changed 6GHz frequency range as per
    IEEE P802.11ax/D6.1.

Aloka Dixit (2):
  nl80211: Unsolicited broadcast probe response support
  mac80211: Unsolicited broadcast probe response support

 include/net/cfg80211.h       | 18 ++++++++++++++
 include/net/mac80211.h       | 21 ++++++++++++++++
 include/uapi/linux/nl80211.h | 32 ++++++++++++++++++++++++
 net/mac80211/cfg.c           | 42 ++++++++++++++++++++++++++++++++
 net/mac80211/ieee80211_i.h   |  7 ++++++
 net/mac80211/tx.c            | 26 ++++++++++++++++++++
 net/wireless/nl80211.c       | 47 ++++++++++++++++++++++++++++++++++++
 7 files changed, 193 insertions(+)

-- 
2.25.0

