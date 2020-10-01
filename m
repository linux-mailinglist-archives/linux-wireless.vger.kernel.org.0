Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA6A2807C8
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Oct 2020 21:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730172AbgJATci (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Oct 2020 15:32:38 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:18068 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730073AbgJATch (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Oct 2020 15:32:37 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601580757; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=eEmL1s/e/4v2tNXuTLk8qt/lT9Y3JX8FaMgwUdudC5E=;
 b=l1I9xzffkCY233pUvuMZGilpUDfFT3P4hup9xhRf6zmvs5sXScJ6WmPyY0JzvV8m8sa989ig
 zcNEXBmQTtOSuEFRC7wEwYMnBuASQsjQnPOwllJexRMYvkzCvcU+GcozFrL8TM+9Va8j/Amz
 TA7WXNrFnOfZsL+aSshUl7wLziE=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5f762ed5e89f7b4c7846a960 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 01 Oct 2020 19:32:37
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6B0F1C433CA; Thu,  1 Oct 2020 19:32:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3500DC433F1;
        Thu,  1 Oct 2020 19:32:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3500DC433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/5] ath11k: add packet log support for QCA6390
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1601463073-12106-2-git-send-email-kvalo@codeaurora.org>
References: <1601463073-12106-2-git-send-email-kvalo@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201001193236.6B0F1C433CA@smtp.codeaurora.org>
Date:   Thu,  1 Oct 2020 19:32:36 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> wrote:

> Add packet log support for QCA6390, otherwise the data connection will stall
> within a minute or so.  Enable it via debugfs and use trace-cmd to capture the
> pktlogs.
> 
> echo 0xffff 1 > /sys/kernel/debug/ath11k/qca6390\ hw2.0/mac0/pktlog_filter
> 
> The mon status ring doesn't support interrupt so far, so host starts
> a timer to reap this ring. The timer handler also reaps the
> rxdma_err_dst_ring in case of monitor mode.
> 
> As QCA6390 requires bss created ahead of starting vdev, so check
> vdev_start_delay for monitor mode.
> 
> For QCA6390, it uses wbm_desc_rel_ring to return descriptors.
> It also uses rx_refill_buf_ring to fill mon buffer instead of
> rxdma_mon_buf_ring.
> 
> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
> 
> Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

5 patches applied to ath-next branch of ath.git, thanks.

701e48a43e15 ath11k: add packet log support for QCA6390
6fbd8898b301 ath11k: pci: fix rmmod crash
7fd85517c359 ath11k: mac: remove unused conf_mutex to solve a deadlock
2f588660e34a ath11k: fix warning caused by lockdep_assert_held
089ba909f8d7 ath11k: debugfs: fix crash during rmmod

-- 
https://patchwork.kernel.org/patch/11808825/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

