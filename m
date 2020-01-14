Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA4B13AC74
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2020 15:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbgANOjo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Jan 2020 09:39:44 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:50219 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726197AbgANOjo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Jan 2020 09:39:44 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1579012784; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=ZkztEpCYEhA5aKlShnTRK8rmUDN6DAkVLfMmBsKZpVM=; b=g2aS8vKImjmY2mC9JcXTo/O//+MFOTtArrJGPUURQaH3sQYE0ixkrT8exv0iZVWVf00sRP+5
 pJXc1IPS/eyypws4FunupDkM8g99rT8SMLbyDK4THWRrGsu97NBzQHFlyet0ECC2RyyEZyA0
 /RtiVRedO9Z2Tvk1PA8kb+zk1LI=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e1dd2ae.7f78b7c2e458-smtp-out-n03;
 Tue, 14 Jan 2020 14:39:42 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E4102C433A2; Tue, 14 Jan 2020 14:39:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from x230.qca.qualcomm.com (85-76-19-103-nat.elisa-mobile.fi [85.76.19.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7205AC4479C;
        Tue, 14 Jan 2020 14:39:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7205AC4479C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com,
        linux-wireless@vger.kernel.org, Sean.Wang@mediatek.com
Subject: Re: [PATCH v2 01/18] mt76: mt76u: check tx_status_data pointer in mt76u_tx_tasklet
References: <cover.1578226544.git.lorenzo@kernel.org>
        <abcddd40dcf003980e1d095d6cbd40b22ac98a43.1578226544.git.lorenzo@kernel.org>
        <87muaq15x8.fsf@tynnyri.adurom.net>
        <20200114143131.GA29696@localhost.localdomain>
Date:   Tue, 14 Jan 2020 16:39:36 +0200
In-Reply-To: <20200114143131.GA29696@localhost.localdomain> (Lorenzo
        Bianconi's message of "Tue, 14 Jan 2020 15:31:31 +0100")
Message-ID: <878smap0ev.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> writes:

> On Jan 14, Kalle Valo wrote:
>> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>> 
>> > New devices (e.g. mt7663u) do not rely on stats workqueue to load tx
>> > statistics but will be reported by the firmware. Check tx_status_data
>> > pointer in mt76u_tx_tasklet in order to reuse tx tasklet for new devices
>> >
>> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
>> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>> 
>> Why is Sean's s-o-b first? Lorenzo is marked as the author so his s-o-b
>> should be first.
>
> Hi Kalle,
>
> my bad, I did not pay attention on it, I should put my SoB first.
>
>> 
>> Also I recommend taking a look at the new Co-Developed-by tag.
>
> I think Co-Developed-by fits better.

Do note that you still need s-o-b as well:

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by

> @Felix and Kalle: do you prefer to resubmit?

I prefer to resubmit, but not a strong requirement and don't know if
Felix already applied this.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
