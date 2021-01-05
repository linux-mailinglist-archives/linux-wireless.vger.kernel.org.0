Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D47092EA3BF
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Jan 2021 04:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbhAEDId (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Jan 2021 22:08:33 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:39363 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbhAEDIc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Jan 2021 22:08:32 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1609816087; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=E5vRSnPU8vgOjh0v7w/gEpMKWkN8/JBU7M/qzImgpwg=; b=FYsAiDeuCCWLxxPyysu4Uf7UcEYpchoYu8oGtswwtjKM6lUX+nSTF7yZl18f+gQwNuUoo5de
 CftB1PFuC4jLgpz4AzE3abH0YPEKT7lWqOW+9VyWMco4FaHme8sv8rinteaSCvN7vZ5u8ady
 /MwfGu9ZdaK09rlGD0Y0NmIkLKE=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5ff3d7fdd3eb3c36b41ad566 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 05 Jan 2021 03:07:41
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E0A4EC433ED; Tue,  5 Jan 2021 03:07:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from gongwen-ThinkPad-T420.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3342DC433ED;
        Tue,  5 Jan 2021 03:07:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3342DC433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath11k@lists.infradead.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, wgong@codeaurora.org
Subject: [PATCH v3 0/2] mac80211: set NSS correct for supported HE-MCS and NSS set
Date:   Tue,  5 Jan 2021 11:08:38 +0800
Message-Id: <1609816120-9411-1-git-send-email-wgong@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The NSS number should be the intersection of peer and own capbility.

v3: added "mac80211: remove NSS number of 160MHz if not support 160MHz for HE"

v2: fix build warning

Wen Gong (2):
  mac80211: remove NSS number of 160MHz if not support 160MHz for HE
  mac80211: do intersection with he mcs and nss set of peer and own

 net/mac80211/he.c          | 94 ++++++++++++++++++++++++++++++++++++++
 net/mac80211/ieee80211_i.h |  5 ++
 net/mac80211/vht.c         |  9 +++-
 3 files changed, 107 insertions(+), 1 deletion(-)

-- 
2.23.0

