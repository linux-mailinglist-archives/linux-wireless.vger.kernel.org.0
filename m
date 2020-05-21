Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3B21DCE04
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2020 15:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729393AbgEUNbR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 May 2020 09:31:17 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:57697 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728208AbgEUNbQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 May 2020 09:31:16 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590067876; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=KUrn5olUR7M5w0XTKxtAX1FUxUHoRAnTPZ9KpZFVk5M=; b=abbi6wQVizNrZDYBEip19h8O92ULhusevIm0gWeE5Z3SOoedKARTcVNh7pmcDR/sxhw41+YW
 2SCeyRXzBDnJZbys+khMWF2aDCRbjUcgxeki/u8TJiIB0+ud+l46PqBvNEERLwZD+Mkz5EFh
 hKKelCp/Cp5F0aSq2gIz4uJUlkc=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5ec682948cd231c40308cb46 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 21 May 2020 13:31:00
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4859DC433C8; Thu, 21 May 2020 13:30:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from CHECSTP344574-LIN.qca.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkenna)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AA8A4C433C6;
        Thu, 21 May 2020 13:30:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AA8A4C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mkenna@codeaurora.org
From:   Maharaja Kennadyrajan <mkenna@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Maharaja Kennadyrajan <mkenna@codeaurora.org>
Subject: [PATCH 0/3] ath11k: vdev and peer delete synchronization with firmware
Date:   Thu, 21 May 2020 19:00:26 +0530
Message-Id: <1590067829-26109-1-git-send-email-mkenna@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When add an interface immediately after removing the interface,
vdev deletion in firmware might not have been completed.
add vdev_delete_resp_event and wait_event_timeout to synchronize
with firmware.

Peer creation in firmware fails if last peer deletion is still in
progress, add wait for the event after deleting every peer from host
driver to synchronize with firmware.

1) add vdev delete resp event and wait event to get ack from firmware
2) add wait event timeout for peer delete to get ack from firmware
3) code clean up and replace the api 'ath11k_mac_get_ar_vdev_stop_status'
   with 'ath11k_mac_get_ar_by_vdev_id'

Ritesh Singh (3):
  ath11k: vdev delete synchronization with firmware
  ath11k: peer delete synchronization with firmware
  ath11k: remove "ath11k_mac_get_ar_vdev_stop_status" references

 drivers/net/wireless/ath/ath11k/core.c |  2 +
 drivers/net/wireless/ath/ath11k/core.h |  9 ++--
 drivers/net/wireless/ath/ath11k/mac.c  | 80 +++++++++++++++------------------
 drivers/net/wireless/ath/ath11k/mac.h  |  2 -
 drivers/net/wireless/ath/ath11k/peer.c | 44 ++++++++++++++++--
 drivers/net/wireless/ath/ath11k/peer.h |  2 +
 drivers/net/wireless/ath/ath11k/wmi.c  | 81 +++++++++++++++++++++++++++++++---
 drivers/net/wireless/ath/ath11k/wmi.h  |  4 ++
 8 files changed, 164 insertions(+), 60 deletions(-)

-- 
1.9.1

