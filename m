Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81918BF48B
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2019 15:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfIZN6J (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Sep 2019 09:58:09 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42002 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbfIZN6J (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Sep 2019 09:58:09 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 95C64611BE; Thu, 26 Sep 2019 13:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569506288;
        bh=gs8p+1yjOS8sOPofcWc8Yqg6Lf3CwkoRj7uJbAnsvJ4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=fccpK79/leBRzeKSmnHdSPwRAEAUkF3W9UPN16OkoV9hqwbAeQOecHjv10wJdtqbq
         nyxl5YlNzk9YsaO3aZ4qUEMYBaagg6CRtG59TyeoU3KmsdNTY/sGfu59hj34QT71z5
         c50WEZZZ6Q7LKux0VhiNEpb3E1vge/fXpkZ5EdFo=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,MISSING_DATE,MISSING_MID,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C63C760BF5;
        Thu, 26 Sep 2019 13:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569506288;
        bh=gs8p+1yjOS8sOPofcWc8Yqg6Lf3CwkoRj7uJbAnsvJ4=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=mEXmtWah526aMF0UxnBaqmESNFMOh9f8C52TtOcoXel7YPEwVuSUiMcgLoAl22a6m
         hFagzV/AzzZwwtMNY7XFuopAcP54KQ5b+p5+MCDi1mwy7KM4NsMWR1DUFT3YVjpmTQ
         oQuyHZUltPchmJz+Xfvn+q5nroizHvd52xUvdzZk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C63C760BF5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k:New interface to get interface combinations from FW
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1562050742-8741-1-git-send-email-zhonglin@codeaurora.org>
References: <1562050742-8741-1-git-send-email-zhonglin@codeaurora.org>
To:     Zhonglin Zhang <zhonglin@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Zhonglin Zhang <zhonglin@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190926135808.95C64611BE@smtp.codeaurora.org>
Date:   Thu, 26 Sep 2019 13:58:08 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Zhonglin Zhang <zhonglin@codeaurora.org> wrote:

> New wmi event "WMI_TLV_IFACE_COMBINATION_EVENTID" is used.
> If WMI_SERVICE_IFACE_COMBINATION_SUPPORT service bit set and
> WMI_TLV_IFACE_COMBINATION_EVENTID event got from FW side, then
> interface combinations reported from FW will override the default
> combinations which is hard-coded in host drivers.
> 
> Tested HW: WCN3990
> Tested FW: WLAN.HL.3.1-01061-QCAHLSWMTPL-1
> 
> Signed-off-by: Zhonglin Zhang <zhonglin@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

This introduced a new warning:

drivers/net/wireless/ath/ath10k/wmi-tlv.c:556:41: warning: incorrect type in argument 1 (different base types)
drivers/net/wireless/ath/ath10k/wmi-tlv.c:556:41:    expected unsigned long [usertype] n
drivers/net/wireless/ath/ath10k/wmi-tlv.c:556:41:    got restricted __le32 [usertype] limits_n

I fixed that in the pending branch.

-- 
https://patchwork.kernel.org/patch/11027361/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

