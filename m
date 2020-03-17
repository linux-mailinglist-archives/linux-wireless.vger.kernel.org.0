Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49055187B14
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2020 09:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbgCQIVz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Mar 2020 04:21:55 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:13385 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725536AbgCQIVz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Mar 2020 04:21:55 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584433314; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=lcMjkModPfHCY4xb3Mo5RqUlC1uH126BYmn9dAA8jNk=;
 b=qVoU6n2Oj5lPH7zO+fx7fBgmmHb0vnO04Myo6BvRv8NIm4qdubDx5MoV3Qe7KTN0t7UwmPmV
 gImdVD6ae4o/I86gvtlvGi2DOgGPV93HezStrOKfx2+ZaIPBhqe0zcyPLplZt2lrGJi3tgbf
 jL7WgltKlC4TXKw/mJcLZNrTCpA=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e708891.7fd2b0a886f8-smtp-out-n02;
 Tue, 17 Mar 2020 08:21:37 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BC8F6C433BA; Tue, 17 Mar 2020 08:21:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 086C9C433CB;
        Tue, 17 Mar 2020 08:21:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 086C9C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: ath10k: Fill GCMP MIC length for PMF
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1584426499-27819-1-git-send-email-ssreeela@codeaurora.org>
References: <1584426499-27819-1-git-send-email-ssreeela@codeaurora.org>
To:     Sowmiya Sree Elavalagan <ssreeela@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Yingying Tang <yintang@codeaurora.org>,
        Sowmiya Sree Elavalagan <ssreeela@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200317082136.BC8F6C433BA@smtp.codeaurora.org>
Date:   Tue, 17 Mar 2020 08:21:36 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sowmiya Sree Elavalagan <ssreeela@codeaurora.org> wrote:

> From: Yingying Tang <yintang@codeaurora.org>
> 
> GCMP MIC length is not filled for GCMP/GCMP-256 cipher suites in
> PMF enabled case. Due to mismatch in MIC length, deauth/disassoc frames
> are unencrypted.
> This patch fills proper MIC length for GCMP/GCMP-256 cipher suites.
> 
> Tested HW: QCA9984, QCA9888
> Tested FW: 10.4-3.6-00104
> 
> Signed-off-by: Yingying Tang <yintang@codeaurora.org>
> Signed-off-by: Sowmiya Sree Elavalagan <ssreeela@codeaurora.org>

Failed to build:

drivers/net/wireless/ath/ath10k/mac.c: In function 'ath10k_mac_tx_h_fill_cb':
drivers/net/wireless/ath/ath10k/mac.c:3611:6: error: 'sta' undeclared (first use in this function); did you mean 'stat'?
  if (sta) {
      ^~~
      stat
drivers/net/wireless/ath/ath10k/mac.c:3611:6: note: each undeclared identifier is reported only once for each function it appears in
drivers/net/wireless/ath/ath10k/mac.c:3612:3: error: 'arsta' undeclared (first use in this function)
   arsta = (struct ath10k_sta *)sta->drv_priv;
   ^~~~~
make[5]: *** [drivers/net/wireless/ath/ath10k/mac.o] Error 1
make[5]: *** Waiting for unfinished jobs....
make[4]: *** [drivers/net/wireless/ath/ath10k] Error 2
make[3]: *** [drivers/net/wireless/ath] Error 2
make[2]: *** [drivers/net/wireless] Error 2
make[1]: *** [drivers/net] Error 2
make: *** [drivers] Error 2

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/patch/11441863/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
