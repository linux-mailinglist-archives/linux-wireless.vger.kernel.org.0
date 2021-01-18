Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA062FA5C3
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Jan 2021 17:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406294AbhARQNO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Jan 2021 11:13:14 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:16349 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406081AbhARQNL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Jan 2021 11:13:11 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610986371; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=Q9RgQi1NfhSWcXWKXnEXRNmguhniM+q+vJm2+2IGXLY=;
 b=FAR/AXrUe0SW1qYz9u3xlV0/Do6G4WVuwJ1BMv4vmrRPgFyPJQqGoYgQ+iysFnMCHrbY4pXr
 kqpOMsm/VFTeKMifWb/w9J7LudbTrQxMKsTHSdzU2YfOEUKF5RbtpwN3cxusvQhDPU8/i1hA
 Sbig/S/8h5Sjqr/LJ0FV72wfGn4=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 6005b36475e5c01cba7e865b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 18 Jan 2021 16:12:20
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4429CC43464; Mon, 18 Jan 2021 16:12:20 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 81B13C433CA;
        Mon, 18 Jan 2021 16:12:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 81B13C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] net: ath10k: santity check for ep connectivity
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200622022055.16028-1-bruceshenzk@gmail.com>
References: <20200622022055.16028-1-bruceshenzk@gmail.com>
To:     Zekun Shen <bruceshenzk@gmail.com>
Cc:     unlisted-recipients:; (no To-header on input)
        Zekun Shen <bruceshenzk@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
        Cc:     unlisted-recipients:; (no To-header on input)Zekun Shen <bruceshenzk@gmail.com>
                                                                     ^-missing end of address
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210118161220.4429CC43464@smtp.codeaurora.org>
Date:   Mon, 18 Jan 2021 16:12:20 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Zekun Shen <bruceshenzk@gmail.com> wrote:

> Function ep_rx_complete is being called without NULL checking
> in ath10k_htc_rx_completion_handler. Without such check, mal-
> formed packet is able to cause jump to NULL.
> 
> ep->service_id seems a good candidate for sanity check as it is
> used in usb.c.
> 
> Signed-off-by: Zekun Shen <bruceshenzk@gmail.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

d18ba9f1351c ath10k: sanitity check for ep connectivity

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20200622022055.16028-1-bruceshenzk@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

