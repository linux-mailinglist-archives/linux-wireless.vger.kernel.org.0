Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 036EE29421F
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Oct 2020 20:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390271AbgJTSbb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Oct 2020 14:31:31 -0400
Received: from z5.mailgun.us ([104.130.96.5]:36470 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390119AbgJTSbb (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Oct 2020 14:31:31 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1603218690; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=YtwqTPCBOjlFahWyDGLlrnl1BzAkhJUBAps9aMRFdEY=; b=VavNEym5UN3BkecVkXzGIBdVwbT7+mOuxDiXn7V7YLLUUr+Z3Bu7x4X6hHHlFpCkXu5yoIuw
 DmC8LFEdNPuGZ3tQ0S3Fjj9k9d098913TjQvkKNY/Z7Uk+t9+4qoZTUnFusCRyo/rfTwtGHR
 8fMFouW/eM5hOWfqfb2gASZqToQ=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5f8f2cf842f9861fb116c57c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 20 Oct 2020 18:31:20
 GMT
Sender: pradeepc=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8CB52C433FE; Tue, 20 Oct 2020 18:31:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from pradeepc2-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pradeepc)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ECFCEC433CB;
        Tue, 20 Oct 2020 18:31:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ECFCEC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=pradeepc@codeaurora.org
From:   Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>,
        ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Subject: [PATCH v2 0/4] ath11k: add support for 256 bitmap in Block ack and duration based RTS threshold
Date:   Tue, 20 Oct 2020 11:31:07 -0700
Message-Id: <20201020183111.25458-1-pradeepc@codeaurora.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This series adds support for the configuration of following in
HE capable ath11k APs:
1. TXOP duration based RTS threshold using HE Operation parameters in
   beacons for AP and mesh modes.
2. BlockAck's bitmap to support upto 256 bits in mesh mode. Without
   this maximum of 64 bits are supported in BlockAck bitmap.

mac80211 patch sets he_support flag for mesh BSS and addresses
previous review comments from https://patchwork.kernel.org/patch/11664077/

changes in v2:
 - fix incorrect bandwidth sanity checks before setting he_support
   flag (Peter Oh).
 - rebased

Pradeep Kumar Chitrapu (4):
  mac80211: save HE oper info in BSS config for mesh
  ath11k: fix incorrect wmi param for configuring HE operation
  ath11k: support TXOP duration based RTS threshold
  ath11k: mesh: add support for 256 bitmap in blockack frames in 11ax

 drivers/net/wireless/ath/ath11k/mac.c | 40 +++++++++++++++++----------
 drivers/net/wireless/ath/ath11k/wmi.h |  2 +-
 include/net/mac80211.h                |  3 +-
 net/mac80211/mesh.c                   | 30 ++++++++++++++++++++
 4 files changed, 58 insertions(+), 17 deletions(-)


base-commit: 9ff9b0d392ea08090cd1780fb196f36dbb586529
-- 
2.17.1

