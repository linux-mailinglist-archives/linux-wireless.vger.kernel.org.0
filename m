Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDCB01D25A4
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2020 06:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbgENEDw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 May 2020 00:03:52 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:62872 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725765AbgENEDv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 May 2020 00:03:51 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589429031; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=6VUV2jxiudy46M2bnqN6cSym4Gnd8QGBTUIh+5yEfeE=; b=mu7w4lg9OADkhpj9AUr2zUHAiXeCZwgnNiX0/8/kM5QiN486US9Doa+PupwJn63sVVxAtFbj
 FztV3ml+jyRuug6hsywLU2fBx9VN4r4/pluHW3rG1cYAOBGQXV4Mnegos+DYTBNRDWv+KHaW
 7RG1Ern3y/ELQXwSYuQX55aVRDs=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ebcc326.7fd92b53f0d8-smtp-out-n05;
 Thu, 14 May 2020 04:03:50 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2989EC433D2; Thu, 14 May 2020 04:03:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 878FCC433F2;
        Thu, 14 May 2020 04:03:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 878FCC433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Jakub Kicinski <kubakici@wp.pl>
Cc:     Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Stanislaw Gruszka <sgruszka@redhat.com>
Subject: Re: [PATCH] mt76: fix different licenses in same driver
References: <3a5cb822eb4cd81d32b5480f1235c992ea4fbe06.1587193872.git.ryder.lee@mediatek.com>
        <d32134a6-9673-521f-22ee-871aa2284af0@nbd.name>
        <20200507100246.1e902bc8@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Date:   Thu, 14 May 2020 07:03:45 +0300
In-Reply-To: <20200507100246.1e902bc8@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        (Jakub Kicinski's message of "Thu, 7 May 2020 10:02:46 -0700")
Message-ID: <87pnb7go2m.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jakub Kicinski <kubakici@wp.pl> writes:

> On Thu, 7 May 2020 15:30:24 +0200 Felix Fietkau wrote:
>> Hi Ryder,
>> 
>> I think for this patch we need an explicit ACK from Stanislaw Gruszka
>> and Jakub Kicinski (both Cc'd), because mt76x0 was licensed under GPL.
>
> Thanks, yes, you definitely need an ack, especially from folks who have
> their copyright on the files :/
>
> My personal preference for the license was expressed clearly when the
> code was written and it is GPL-only. Felix, if you prefer the clean up
> I'm happy to ack, but I see no reason to downgrade the license at
> vendor's request.

I think it would be unfortunate to have different licenses in the same
driver. For example think of copying a function from one file to
another, how would we handle that? So my strong recommendation is to use
the same license throughout the driver. And in this case I consider mt76
directory and it's subdirectories as being one driver, please correct me
if that's not the case.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
