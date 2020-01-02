Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9D8612E26D
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2020 05:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbgABEuw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Jan 2020 23:50:52 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:10390 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726234AbgABEuv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Jan 2020 23:50:51 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1577940651; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=Vl2TJjve/ZNE8M6Hh/rQdJBS0YSOBXXynVTBeeNsyjU=;
 b=BRCo08UuZOmX7wyjnzIGFUiVpYFnJnRRo7fsu9XfJQRCllZmks+gEwjX8bnDrRV90vffqnoz
 L+XWoJFj3rB3+ZPNSXsXRtbJgWeZA6l19NyFMO5kC/HIlbEfM36Bm05KsviEvs02VkX0JTGu
 +tX1ayWnP+U3UBCoK69/trDUJPo=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e0d76aa.7f437bf7e538-smtp-out-n01;
 Thu, 02 Jan 2020 04:50:50 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8A585C447A2; Thu,  2 Jan 2020 04:50:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED autolearn=ham
        autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 57766C4479F;
        Thu,  2 Jan 2020 04:50:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 01 Jan 2020 20:50:49 -0800
From:   wgong@codeaurora.org
To:     Justin Capella <justincapella@gmail.com>
Cc:     ath10k <ath10k@lists.infradead.org>, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ath10k: start recovery process when payload length
 exceeds max htc length for sdio
In-Reply-To: <CAMrEMU9ZVV-yotvH2Odn+sb1HiiL_tN_GASSeSnhAOzCUjLZ7Q@mail.gmail.com>
References: <20191225120002.11163-1-wgong@codeaurora.org>
 <20191225120002.11163-3-wgong@codeaurora.org>
 <CAMrEMU9ZVV-yotvH2Odn+sb1HiiL_tN_GASSeSnhAOzCUjLZ7Q@mail.gmail.com>
Message-ID: <8ad12580aae4ed23778693dd483144db@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-12-25 14:56, Justin Capella wrote:
> Does the SDIO bus require addresses to be word aligned like the PCI
> bus does? I'm thinking of how netdev alloc uses skb_push to ensure
> that the payload is aligned.
> 
> 
>>> if (ar->state == ATH10K_STATE_ON)
> 
> What about the other STATEs: RESTARTED/ING
> 
> The value you mentioned 57005, is 0xDEAD is that a special case?
> Perhaps a result of fw crash? Maybe a lookahead gone wong? I see its
> the WMI PEER ALIVE/DEAD indicator but I'm not sure why it would be
> trailer of the other
> 
i have removed "if (ar->state == ATH10K_STATE_ON)"
and v3 sent:
patch v3:
https://patchwork.kernel.org/patch/11313853/
https://patchwork.kernel.org/patch/11313859/

>> 2.23.0
