Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB8E61867DA
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2020 10:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730444AbgCPJ2b (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Mar 2020 05:28:31 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:10018 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730293AbgCPJ2b (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Mar 2020 05:28:31 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584350911; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=K0B0rHJIbN6Ed+c7ebgqy/5mGLfxfu1SAA13EJqQtS4=; b=S9GuOSzOgjOOLW/MWUDEnW24j7KKjgpEkDlY0MCkHGeqb3taH7w+Kt5EYEY5K8VnYQMh2ovL
 3/DLv1tbRNqLZ9lvC+GWcvJZ8Rs3jaCD70OKkdCAd2Pb7hJB3D+m8diwdoNFokwAXdpBTDLN
 gihfUto5xGIUsaZU11FRz6K6ZQo=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e6f46a9.7f8eb41cf810-smtp-out-n03;
 Mon, 16 Mar 2020 09:28:09 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8B0EEC433BA; Mon, 16 Mar 2020 09:28:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from checstp253621-lin.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: srirrama)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BBF29C433D2;
        Mon, 16 Mar 2020 09:28:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BBF29C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=srirrama@codeaurora.org
From:   Sriram R <srirrama@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, Sriram R <srirrama@codeaurora.org>
Subject: [PATCHv3 0/2] Support hash based reo destination ring selection 
Date:   Mon, 16 Mar 2020 14:57:42 +0530
Message-Id: <1584350864-20622-1-git-send-email-srirrama@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently, reo destination ring selection is based on pdev,
i.e each pdev is allocated a static reo destintaion ring and
rx packets for the pdev is always received on the ring.
This allows use of only 3 out of 4 reo destination rings at the
max when all pdev's are active and when only one pdev is active
we utilize only one ring and other 3 rings remain idle.
To make effective use of all the reo rings, this patchset enables
hash based reo destination ring selection where the hash is computed
based on the 5-tuple ( src/dst ip, src/dst port, protocol) info
from each packet and is used by hw for destination ring selection.

Also, current implementation of amsdu list based processing is replaced
with per msdu based handling since the received subframe could be
pushed to different rings after decap based on hash value computed.

This patchset is based on patchset "ath11k: offload PN verification to the HW"

v3: Fixed kbuild test bot warnings

Sriram R (2):
  ath11k: Configure hash based reo destination ring selection
  ath11k: Perform per-msdu rx processing

 drivers/net/wireless/ath/ath11k/ahb.c    |   5 -
 drivers/net/wireless/ath/ath11k/core.h   |   5 +-
 drivers/net/wireless/ath/ath11k/dp.c     |  35 ++-
 drivers/net/wireless/ath/ath11k/dp.h     |   4 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c  | 513 +++++++++++++------------------
 drivers/net/wireless/ath/ath11k/dp_rx.h  |   4 +-
 drivers/net/wireless/ath/ath11k/dp_tx.c  |   2 +-
 drivers/net/wireless/ath/ath11k/hal.h    |  12 +-
 drivers/net/wireless/ath/ath11k/hal_rx.c |  15 +-
 drivers/net/wireless/ath/ath11k/mac.c    |  12 +-
 drivers/net/wireless/ath/ath11k/mac.h    |   1 +
 drivers/net/wireless/ath/ath11k/peer.c   |   3 +
 drivers/net/wireless/ath/ath11k/peer.h   |   2 +
 drivers/net/wireless/ath/ath11k/wmi.c    |  35 +++
 drivers/net/wireless/ath/ath11k/wmi.h    |  13 +
 15 files changed, 339 insertions(+), 322 deletions(-)

-- 
2.7.4
