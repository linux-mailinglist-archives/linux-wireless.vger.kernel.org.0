Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57FCD278B1B
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Sep 2020 16:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbgIYOnS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Sep 2020 10:43:18 -0400
Received: from z5.mailgun.us ([104.130.96.5]:40668 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728148AbgIYOnR (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Sep 2020 10:43:17 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601044997; h=Date: Message-Id: Cc: To: Subject: From:
 Content-Transfer-Encoding: MIME-Version: Content-Type: Sender;
 bh=ISR6+Y5t1rmd7F2tL+mdzWI0qmu/3ZZOcbPmtJ79P2I=; b=eEcQ7RheB8yA///8mTBiykYXRn1+BlztQntjlZgJ/vsE4GEVUbXx0OmJNq7jH+kBoRIUUu5i
 wr7iaIq1VNswt2L0+H+ibZKID1woJ2qwW6TqdXE1/PMbMsksG5SquCu78b8OtoahxklLeTcM
 fRIhjjBPeoKYHaRYLz9BykAzNTw=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5f6e0202ebb17452ba8c30f4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 25 Sep 2020 14:43:14
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8E1D1C433C8; Fri, 25 Sep 2020 14:43:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9EC11C433CA;
        Fri, 25 Sep 2020 14:43:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9EC11C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   Kalle Valo <kvalo@codeaurora.org>
Subject: pull-request: wireless-drivers-2020-09-25
To:     netdev@vger.kernel.org
Cc:     linux-wireless@vger.kernel.org
Message-Id: <20200925144313.8E1D1C433C8@smtp.codeaurora.org>
Date:   Fri, 25 Sep 2020 14:43:13 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

here's a pull request to net tree, more info below. Please let me know if there
are any problems.

Kalle

The following changes since commit 1264c1e0cfe55e2d6c35e869244093195529af37:

  Revert "wlcore: Adding suppoprt for IGTK key in wlcore driver" (2020-09-07 11:39:32 +0300)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers.git tags/wireless-drivers-2020-09-25

for you to fetch changes up to efb1676306f664625c0c546dd10d18d33c75e3fc:

  mt76: mt7615: reduce maximum VHT MPDU length to 7991 (2020-09-24 16:12:22 +0300)

----------------------------------------------------------------
wireless-drivers fixes for v5.9

Second, and last, set of fixes for v5.9. Only one important regression
fix for mt76.

mt76

* fix a regression in aggregation which appeared after mac80211 changes

----------------------------------------------------------------
Felix Fietkau (1):
      mt76: mt7615: reduce maximum VHT MPDU length to 7991

 drivers/net/wireless/mediatek/mt76/mt7615/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
