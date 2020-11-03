Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 219C62A45C7
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Nov 2020 13:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbgKCM6i (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Nov 2020 07:58:38 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:21819 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729139AbgKCM6g (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Nov 2020 07:58:36 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604408316; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=HRLt78uC83l0Og4T2L1No+cXdRB7kVouUKpsLrsLarU=; b=f5P5U0dZzVjolaFehCDE/q6pVHm865PqW8vkIYLhjtiSS1pE889TRBbzlcrT+mv1fxcgRwje
 W2ScB5v2KajFbQPtvZojpjQ2zq6T9v7CyjS1XizTKW9fCEYFiJwbKIIojA30yGOo0n8udaHB
 g3etz4leWO5Q48KH1+JEZrjgdPM=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5fa153eb75bebe827ae93a8f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 03 Nov 2020 12:58:19
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 12EDDC38523; Tue,  3 Nov 2020 07:00:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F098CC384E0;
        Tue,  3 Nov 2020 07:00:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F098CC384E0
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Kelvin Cheung <keguang.zhang@gmail.com>
Cc:     Daisy Zhang251 <daisy.zhang251@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Daisy Zhang1 <daisy.zhang1@unisoc.com>
Subject: Re: [PATCH] cfg80211: make wifi driver probe
References: <1602833787-4206-1-git-send-email-daisy.zhang251@gmail.com>
        <87a6vzpwt5.fsf@codeaurora.org>
        <CAJhJPsVmBD5S5gW9cwgtjZrQNrN7iGG7FF5WX+RwLH0UquKCMA@mail.gmail.com>
Date:   Tue, 03 Nov 2020 09:00:24 +0200
In-Reply-To: <CAJhJPsVmBD5S5gW9cwgtjZrQNrN7iGG7FF5WX+RwLH0UquKCMA@mail.gmail.com>
        (Kelvin Cheung's message of "Tue, 3 Nov 2020 10:51:08 +0800")
Message-ID: <87blgeudpz.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kelvin Cheung <keguang.zhang@gmail.com> writes:

> We are preparing the Wi-Fi driver for Unisoc WCN chips. Please ignore
> this draft version. There will be a formal version soon.

Ok, I'll drop this. But please don't use HTML in mails, more info in the
wiki page below. I recommend reading it all very carefully.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
