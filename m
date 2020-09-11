Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B44D8266971
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Sep 2020 22:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725811AbgIKUPm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Sep 2020 16:15:42 -0400
Received: from a27-186.smtp-out.us-west-2.amazonses.com ([54.240.27.186]:59692
        "EHLO a27-186.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725787AbgIKUPm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Sep 2020 16:15:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gbvhytky6xpx7itkhb67ktsxbiwpnxix; d=codeaurora.org; t=1599855341;
        h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID;
        bh=i4YCS0kqus+HF4RM63dNexEjv/MaODY0FA8Tn/K6VF0=;
        b=j8NxWEE+6zNanzdwVGJ5MJonducBvlyvoEgJbYtaMOo9C7rr5RKQY56wQzJLP/V6
        4f309/v30BuRvN/B8kPf0BiXC12/uTkdtIKRKMSXxoyYId4wG1EmRdx7eBlMlHApSCV
        3/umtDdEkwLK7IgJ6vrr2pL7hKhsYVI8Or1xR5PA=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599855341;
        h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:Feedback-ID;
        bh=i4YCS0kqus+HF4RM63dNexEjv/MaODY0FA8Tn/K6VF0=;
        b=Jb1cSXvNY81dGEKVIdrs+vVFZleTwrynPCrmotrzaQqGlpEM/cSC4maGrLfd7l+l
        JpL31+Ldd2ac7FC3EbWLYu43qtwaVjsl6XlXkTG/MtFCGXNbb5KxrV8gTbhWpFVXfK/
        Q3s0+dGU5k/xwh1seD67rz/jEZ8rM/YxIQ4yljtw=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 11 Sep 2020 20:15:41 +0000
From:   Aloka Dixit <alokad@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     John Crispin <john@phrozen.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        Miles Hu <milehu@codeaurora.org>,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH V6 2/2] ath11k: add support for setting fixed HE
 rate/gi/ltf
In-Reply-To: <010101746c53c3fc-6b47ad5d-f740-4029-9a89-2ba9bef427f3-000000@us-west-2.amazonses.com>
References: <20200804081630.2013619-2-john@phrozen.org>
 <010101746c53c3fc-6b47ad5d-f740-4029-9a89-2ba9bef427f3-000000@us-west-2.amazonses.com>
Message-ID: <010101747ecf2dd5-f7b93051-8f7e-4046-ada3-de2beee06f74-000000@us-west-2.amazonses.com>
X-Sender: alokad@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
X-SES-Outgoing: 2020.09.11-54.240.27.186
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-09-07 23:07, Kalle Valo wrote:
> John Crispin <john@phrozen.org> wrote:
> 
>> From: Miles Hu <milehu@codeaurora.org>
>> 
>> This patch adds ath11k support for setting fixed HE rate/gi/ltf values 
>> that
>> we are now able to send to the kernel using nl80211. The added code is
>> reusing parts of the existing code path already used for HT/VHT. The 
>> new
>> helpers are symmetric to how we do it for HT/VHT.
>> 
>> Signed-off-by: Miles Hu <milehu@codeaurora.org>
>> Signed-off-by: John Crispin <john@phrozen.org>
> 
> Depends on:
> 
> eb89a6a6b7a1 nl80211: add support for setting fixed HE rate/gi/ltf
> 
> Currently in net-next.

Hi Kalle and John,
This patch includes auto-rate support as well which is part of the CAF 
changes John mentioned in v55 change-log.
Auto-rate part was added by me into CAF.
Please add my sign-off on this patch.
Or let me know if you decide to remove that particular portion, then I 
will send a separate patch.
Thanks.
