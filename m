Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40FB71C6842
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2020 08:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbgEFGQl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 May 2020 02:16:41 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:12368 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726495AbgEFGQk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 May 2020 02:16:40 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588745800; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=zOYcodX2zufi1O4DAs4Ff2J1gtq0GyHGmKcHBgp0oGw=;
 b=BP9Zdxui5SCkeNskdzGFJpvCzTcaJsl6YYfdMNto9SUSoMqJ397iugrJZ8zbYkM32X9r0gcT
 hqKQcDomTLCvJWmx8RuFLZsdhFuJVhws8h6MlKi5zaL0uloqy2WncrEVaXfW2kYZn75GWqh+
 bTjVYth0LVrfsRLCGnPcHxoVb9E=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb2563c.7f95c4ea5420-smtp-out-n02;
 Wed, 06 May 2020 06:16:28 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D0DC2C433F2; Wed,  6 May 2020 06:16:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 70621C433CB;
        Wed,  6 May 2020 06:16:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 70621C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: fix kernel panic by freeing the msdu received
 with
 invalid length
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1588611568-20791-1-git-send-email-tamizhr@codeaurora.org>
References: <1588611568-20791-1-git-send-email-tamizhr@codeaurora.org>
To:     Tamizh Chelvam <tamizhr@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Tamizh Chelvam <tamizhr@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200506061628.D0DC2C433F2@smtp.codeaurora.org>
Date:   Wed,  6 May 2020 06:16:28 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tamizh Chelvam <tamizhr@codeaurora.org> wrote:

> In certain scenario host receives the packets with invalid length
> which causes below kernel panic. Free up those msdus to avoid
> this kernel panic.
> 
>  2270.028121:   <6> task: ffffffc0008306d0 ti: ffffffc0008306d0 task.ti: ffffffc0008306d0
>  2270.035247:   <2> PC is at skb_panic+0x40/0x44
>  2270.042784:   <2> LR is at skb_panic+0x40/0x44
>  2270.521775:   <2> [<ffffffc0004a06e0>] skb_panic+0x40/0x44
>  2270.524039:   <2> [<ffffffc0004a1278>] skb_put+0x54/0x5c
>  2270.529264:   <2> [<ffffffbffcc373a8>] ath11k_dp_process_rx_err+0x320/0x5b0 [ath11k]
>  2270.533860:   <2> [<ffffffbffcc30b68>] ath11k_dp_service_srng+0x80/0x268 [ath11k]
>  2270.541063:   <2> [<ffffffbffcc1d554>] ath11k_hal_rx_reo_ent_buf_paddr_get+0x200/0xb64 [ath11k]
>  2270.547917:   <2> [<ffffffc0004b1f74>] net_rx_action+0xf8/0x274
>  2270.556247:   <2> [<ffffffc000099df4>] __do_softirq+0x128/0x228
>  2270.561625:   <2> [<ffffffc00009a130>] irq_exit+0x84/0xcc
>  2270.567008:   <2> [<ffffffc0000cfb28>] __handle_domain_irq+0x8c/0xb0
>  2270.571695:   <2> [<ffffffc000082484>] gic_handle_irq+0x6c/0xbc
> 
> Signed-off-by: Tamizh Chelvam <tamizhr@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

d7d43782d541 ath11k: fix kernel panic by freeing the msdu received with invalid length

-- 
https://patchwork.kernel.org/patch/11526757/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
