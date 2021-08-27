Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8A083F9920
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Aug 2021 14:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245141AbhH0Mmi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Aug 2021 08:42:38 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:34372 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245153AbhH0Mmi (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Aug 2021 08:42:38 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1630068109; h=Content-Type: MIME-Version: Message-ID: Date:
 References: In-Reply-To: Subject: Cc: To: From: Sender;
 bh=b9Fs60pLSXTvTqPUF2uqiMW7Z/NF+y6eSb2SKhiwPfk=; b=MKH3mD/a+Nuy38e6ASJ7dshzl/veRWKGUmg0qGWf0dEZdIoC5XIsNjR0901rAuaCx3OfoU+I
 z59hJ+IUzCbgqy5X94U583CWEb2wOhBrifU65lmJtmt2904bs+FUfScdwIwQ81jVCKkyWz14
 s3Dusje/PfZ2ADJdz+icsb1XGvs=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 6128dd8cfc1f4cb6925b1bf1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 27 Aug 2021 12:41:48
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1E883C43635; Fri, 27 Aug 2021 12:41:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 64C85C4360C;
        Fri, 27 Aug 2021 12:41:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 64C85C4360C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Wren Turkal <wt@penguintechs.org>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org, regressions@lists.linux.dev,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Hemant Kumar <hemantk@codeaurora.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Nicolas Schichan <nschichan@freebox.fr>
Subject: Re: [regression] Re: 5.14 rc6 broken for QCA6390 on Dell XPS 13 9310
In-Reply-To: <20210826111207.364d0ba5@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        (Jakub Kicinski's message of "Thu, 26 Aug 2021 11:12:07 -0700")
References: <a8cddf24-ecfc-088e-27f4-98cbbb5fb67c@penguintechs.org>
        <87y28sqq4l.fsf@codeaurora.org>
        <843e7689-fa1e-441b-c49a-ed7291046d5f@freebox.fr>
        <87tujgqcth.fsf@codeaurora.org> <87mtp47073.fsf_-_@codeaurora.org>
        <YSenaxWzxRkYkucv@kroah.com>
        <20210826074850.16768dee@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        <87eeag6yjr.fsf@codeaurora.org> <87y28o5cw4.fsf@codeaurora.org>
        <20210826111207.364d0ba5@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Fri, 27 Aug 2021 15:41:39 +0300
Message-ID: <87sfyv5abg.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jakub Kicinski <kuba@kernel.org> writes:

> On Thu, 26 Aug 2021 20:33:47 +0300 Kalle Valo wrote:
>> >> Also no objections here. FWIW I'm about to send the last PR for
>> >> networking, still waiting on BPF. You can send the revert to netdev, 
>> >> or directly to Linus as you prefer. LMK.  
>> >
>> > I prefer take it via the net tree if possible, so if you can wait ~2h
>> > and I'll send it to you.  
>> 
>> I now submitted the revert, please take it into the net tree if you
>> still can:
>> 
>> https://patchwork.kernel.org/project/netdevbpf/patch/20210826172816.24478-1-kvalo@codeaurora.org/
>> 
>> I also tested the build with various QRTR options and didn't see any
>> build errors.
>
> Done, thank you!

Thank you waiting for me :)

I just tested commit 7e9965cddea8 from Linus' tree on Dell XPS 13 9310
laptop with QCA6390 and ath11k works without problems. So the issue
should be solved in the final v5.14 release.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
