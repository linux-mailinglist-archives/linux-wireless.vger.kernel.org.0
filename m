Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8446B3E26B3
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Aug 2021 11:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243914AbhHFJDi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Aug 2021 05:03:38 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:20092 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243794AbhHFJDh (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Aug 2021 05:03:37 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1628240602; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=X1qWQpq0Sf+GBW+SGHJTfGW1V3rTwlAwDVIchdBetig=; b=GIIjv8bi3x3SSj45fgAWWK1DDaF1U9m7h0cMznn0G/qVLOe2sGCatgmMeNFsfLfPSnisJc0+
 6KDtZT7/Lm/WGhzTLB09/Q/LTmjHGUhGL7yXdyQP0DkmXySCaj+lVyWI1ws7AyT6ssl/yWPb
 K5436xaYN8qavxraClPip7k3iUA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 610cfad8ad1af63949d8b8b0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 06 Aug 2021 09:03:20
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 345FEC4338A; Fri,  6 Aug 2021 09:03:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 30D6FC433F1;
        Fri,  6 Aug 2021 09:03:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 30D6FC433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     chris.chiu@canonical.com
Cc:     jes.sorensen@gmail.com, davem@davemloft.net, kuba@kernel.org,
        code@reto-schneider.ch, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rtl8xxxu: Fix the handling of TX A-MPDU aggregation
References: <20210804151325.86600-1-chris.chiu@canonical.com>
Date:   Fri, 06 Aug 2021 12:03:12 +0300
In-Reply-To: <20210804151325.86600-1-chris.chiu@canonical.com> (chris chiu's
        message of "Wed, 4 Aug 2021 23:13:25 +0800")
Message-ID: <87wnozaqsv.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

chris.chiu@canonical.com writes:

> From: Chris Chiu <chris.chiu@canonical.com>
>
> The TX A-MPDU aggregation is not handled in the driver since the
> ieee80211_start_tx_ba_session has never been started properly.
> Start and stop the TX BA session by tracking the TX aggregation
> status of each TID. Fix the ampdu_action and the tx descriptor
> accordingly with the given TID.
>
> Signed-off-by: Chris Chiu <chris.chiu@canonical.com>

Is this ok to take?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
