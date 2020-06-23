Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4B1204B77
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2020 09:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731663AbgFWHoO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Jun 2020 03:44:14 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:55182 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731630AbgFWHoL (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Jun 2020 03:44:11 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592898250; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=CjpaCCnx1y01srgBqMleGMp4v872X4zSWhjF8eJ6Aa0=;
 b=qhlJW0e2GSFUQAu0G9vmjTe0NC/qLxq8L9lUhosT8xwR6XhPGlsv0x112/MBzV3NCHycFnHo
 DcQnwIvqfRMGDxSHz44mQMwT3qo0Y8kDbpmv2k2umYJL1WR26n+j3jI78ebs+JHPQN0Ch0Wc
 HaQgZU6rBQ1SBXDh1BtGW9nGoog=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-east-1.postgun.com with SMTP id
 5ef1b2c98fe116ddd9c3fab4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 23 Jun 2020 07:44:09
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 65E75C433CA; Tue, 23 Jun 2020 07:44:08 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 21B84C433C8;
        Tue, 23 Jun 2020 07:44:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 21B84C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] net: ath10k: fix memcpy size from untrusted input
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200616132544.17478-1-bruceshenzk@gmail.com>
References: <20200616132544.17478-1-bruceshenzk@gmail.com>
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
Message-Id: <20200623074408.65E75C433CA@smtp.codeaurora.org>
Date:   Tue, 23 Jun 2020 07:44:08 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Zekun Shen <bruceshenzk@gmail.com> wrote:

> A compromized ath10k peripheral is able to control the size argument
> of memcpy in ath10k_pci_hif_exchange_bmi_msg.
> 
> The min result from previous line is not used as the size argument
> for memcpy. Instead, xfer.resp_len comes from untrusted stream dma
> input. The value comes from "nbytes" in ath10k_pci_bmi_recv_data,
> which is set inside _ath10k_ce_completed_recv_next_nolock with the line
> 
> nbytes = __le16_to_cpu(sdesc.nbytes);
> 
> sdesc is a stream dma region which device can write to.
> 
> Signed-off-by: Zekun Shen <bruceshenzk@gmail.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

aed95297250f ath10k: pci: fix memcpy size of bmi response

-- 
https://patchwork.kernel.org/patch/11607461/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

