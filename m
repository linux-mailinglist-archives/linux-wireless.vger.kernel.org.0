Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50802216AB
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2019 12:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbfEQKFY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 May 2019 06:05:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37412 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728036AbfEQKFX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 May 2019 06:05:23 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EBF9D60DB3; Fri, 17 May 2019 10:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558087522;
        bh=RhoZniTLHAOJJh2V56DAGGJFLkn/pmisfD3dz2o7UeY=;
        h=From:To:Cc:Subject:Date:From;
        b=kpo53WMYK0zA116C5B4ChpKTM7YrP0lo50iIHIFnod5YtO40BLwe+pjeGZiazb6eD
         h12DEDANWil8cYupFUWm/NjdtFJuj18eaL/83UCCt++dOqFzuHVX6i41LbU4WhvWpN
         1by8gHcJsu9cJLxHtPKt+irJuhZ4pYQVv45AXdOI=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from aambure-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: aambure@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4864A60128;
        Fri, 17 May 2019 10:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558087522;
        bh=RhoZniTLHAOJJh2V56DAGGJFLkn/pmisfD3dz2o7UeY=;
        h=From:To:Cc:Subject:Date:From;
        b=kpo53WMYK0zA116C5B4ChpKTM7YrP0lo50iIHIFnod5YtO40BLwe+pjeGZiazb6eD
         h12DEDANWil8cYupFUWm/NjdtFJuj18eaL/83UCCt++dOqFzuHVX6i41LbU4WhvWpN
         1by8gHcJsu9cJLxHtPKt+irJuhZ4pYQVv45AXdOI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4864A60128
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=aambure@codeaurora.org
From:   Abhishek Ambure <aambure@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Abhishek Ambure <aambure@codeaurora.org>
Subject: [PATCH 0/2] correction in pktlog service connect and pktlog enable command
Date:   Fri, 17 May 2019 15:35:14 +0530
Message-Id: <1558087516-666-1-git-send-email-aambure@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

WCN3990 firmware supports htc pktlog service through which host driver
gets pktlog information. Pktlog service should be connected before htc
start command, hence pktlog connect is moved before htc start. 

WCN3990 firwmare expects pdev_id along with filter and reserved params to
enable pktlog htc service. So adding pdev_id in pktlog enable comamnd
params.

Tested HW: WCN3990
Tested FW: WLAN.HL.3.1-00963-QCAHLSWMTPL-1


Abhishek Ambure (2):
  ath10k: move pktlog connect service before htc start
  ath10k: correct wmi_tlv command params to enable pktlog for WCN3990

 drivers/net/wireless/ath/ath10k/htc.c     | 16 ++++++++--------
 drivers/net/wireless/ath/ath10k/wmi-tlv.c |  2 ++
 drivers/net/wireless/ath/ath10k/wmi-tlv.h |  1 +
 3 files changed, 11 insertions(+), 8 deletions(-)

-- 
1.9.1

