Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B01FB18E800
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Mar 2020 11:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbgCVKWj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 Mar 2020 06:22:39 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:21947 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726897AbgCVKWj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 Mar 2020 06:22:39 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584872558; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=bhceEIlhB/5Z3VaRzMEBxGOjOYuAVhiDx+9jhnKdg5w=;
 b=jNMSEhf9oRuKL8nwIN9RGoon1qXIUwFiMwb9jUqbwjSeshpYtx9pRxQbTC/f/DpvAs3lf6hw
 cTlyhhlPsqakuzsh+iKk0J1kof456+hbenHNzizNh6Kgn7rpC07a5tqpopkgy/cAPLNEGo9p
 UrNxjAQ0MuiN1ukCUFC25QfAhYY=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e773c65.7f14bf8b6340-smtp-out-n04;
 Sun, 22 Mar 2020 10:22:29 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5E0ADC432C2; Sun, 22 Mar 2020 10:22:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 97DF9C433CB;
        Sun, 22 Mar 2020 10:22:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 97DF9C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] ath10k: Fill GCMP MIC length for PMF
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1584540911-4267-1-git-send-email-ssreeela@codeaurora.org>
References: <1584540911-4267-1-git-send-email-ssreeela@codeaurora.org>
To:     Sowmiya Sree Elavalagan <ssreeela@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Yingying Tang <yintang@codeaurora.org>,
        Sowmiya Sree Elavalagan <ssreeela@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200322102228.5E0ADC432C2@smtp.codeaurora.org>
Date:   Sun, 22 Mar 2020 10:22:28 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sowmiya Sree Elavalagan <ssreeela@codeaurora.org> wrote:

> GCMP MIC length is not filled for GCMP/GCMP-256 cipher suites in
> PMF enabled case. Due to mismatch in MIC length, deauth/disassoc frames
> are unencrypted.
> This patch fills proper MIC length for GCMP/GCMP-256 cipher suites.
> 
> Tested HW: QCA9984, QCA9888
> Tested FW: 10.4-3.6-00104
> 
> Signed-off-by: Yingying Tang <yintang@codeaurora.org>
> Co-developed-by: Sowmiya Sree Elavalagan <ssreeela@codeaurora.org>
> Signed-off-by: Sowmiya Sree Elavalagan <ssreeela@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

95a568c4a461 ath10k: Fill GCMP MIC length for PMF

-- 
https://patchwork.kernel.org/patch/11445331/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
