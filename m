Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8DF4E597
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2019 16:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbfD2O6a (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Apr 2019 10:58:30 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49678 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728339AbfD2O6a (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Apr 2019 10:58:30 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9A631607DF; Mon, 29 Apr 2019 14:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556549909;
        bh=BTLBZUIFq71XcZdnfFWdjD6D+tY/ZRYotydmR6+Em2Q=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Ag5xCIpQwkl5Tlnymn9GMNjfkLkv8sq9hhg8LYqvZFID7A5Pj/9uskfbpNKU/TdFd
         XD0IkidmyLVvqSc+tE43PeXligCuxfaXFJ5r+lgurBg+lXPYK8+qrLnmWIEgedLoLd
         lBqlHljjA3mMRo61ZNZQWrHnlJnLcu1cqBNNLcOc=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,MISSING_DATE,MISSING_MID autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BE6B56029B;
        Mon, 29 Apr 2019 14:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556549909;
        bh=BTLBZUIFq71XcZdnfFWdjD6D+tY/ZRYotydmR6+Em2Q=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=KftbArpbgk5abLdgNDqtcDKnvDm056qm3/EKF29MNcg9Mh5gkMVNo1Z0kDD90Ue1e
         Gw8xFyAlphSUIjPAg2oobyaCRNfWsWhZ67aafvPCjYpAZpi/Mf8DEmySH5VcldXzXh
         YRBuGLiAIUuhSLNTXHUWgawWGEdm74+527nUQnRk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BE6B56029B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/2] ath: drop duplicated define
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1552572470-2656-1-git-send-email-pozega.tomislav@gmail.com>
References: <1552572470-2656-1-git-send-email-pozega.tomislav@gmail.com>
To:     =?utf-8?q?Tomislav_Po=C5=BEega?= <pozega.tomislav@gmail.com>
Cc:     linux-wireless@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190429145829.9A631607DF@smtp.codeaurora.org>
Date:   Mon, 29 Apr 2019 14:58:29 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tomislav Požega wrote:

> Remove duplicate NO_CTL that is just 2 lines below.
> 
> Signed-off-by: Tomislav Požega <pozega.tomislav@gmail.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

2 patches applied to ath-next branch of ath.git, thanks.

b50fd29c5268 ath: drop duplicated define
d3c2be9022d6 ath9k: drop redundant code in ar9003_hw_set_channel

-- 
https://patchwork.kernel.org/patch/10852929/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

