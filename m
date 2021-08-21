Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8EB83F3C03
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Aug 2021 20:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbhHUSST (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 21 Aug 2021 14:18:19 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:15753 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232207AbhHUSSS (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 21 Aug 2021 14:18:18 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629569858; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=6jM6Tcu7b03+DyLNo1tN4dfPn6HBIgxRCL0CyHJ9Wsc=;
 b=FoQe6VF9Ea+bLXz12e9XAK3kraVuEBPFtbSrCs1y+w2I6zfEnE3NL1t2bxrtXKJxidoYWcTo
 742DSMgZawn1Edjdswy145tafm64C7o7+tu/NhImigSCQUKgjTxHpkW/P/mGQMP3Vx7y2k7m
 SSKZKldnAjhmf2Yp//b9gx+CYMs=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 6121433f89fbdf3ffeb47e8c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 21 Aug 2021 18:17:35
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A3E87C4360C; Sat, 21 Aug 2021 18:17:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 28A59C4338F;
        Sat, 21 Aug 2021 18:17:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 28A59C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] rtl8xxxu: Fix the handling of TX A-MPDU aggregation
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210804151325.86600-1-chris.chiu@canonical.com>
References: <20210804151325.86600-1-chris.chiu@canonical.com>
To:     chris.chiu@canonical.com
Cc:     jes.sorensen@gmail.com, davem@davemloft.net, kuba@kernel.org,
        code@reto-schneider.ch, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Chiu <chris.chiu@canonical.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210821181734.A3E87C4360C@smtp.codeaurora.org>
Date:   Sat, 21 Aug 2021 18:17:34 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

chris.chiu@canonical.com wrote:

> From: Chris Chiu <chris.chiu@canonical.com>
> 
> The TX A-MPDU aggregation is not handled in the driver since the
> ieee80211_start_tx_ba_session has never been started properly.
> Start and stop the TX BA session by tracking the TX aggregation
> status of each TID. Fix the ampdu_action and the tx descriptor
> accordingly with the given TID.
> 
> Signed-off-by: Chris Chiu <chris.chiu@canonical.com>

Patch applied to wireless-drivers-next.git, thanks.

95a581ab3592 rtl8xxxu: Fix the handling of TX A-MPDU aggregation

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210804151325.86600-1-chris.chiu@canonical.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

