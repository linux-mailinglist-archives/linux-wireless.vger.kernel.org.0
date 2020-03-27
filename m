Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22BCE195012
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2020 05:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbgC0Ec5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Mar 2020 00:32:57 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:49896 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725857AbgC0Ec5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Mar 2020 00:32:57 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1585283577; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=8CXQInUnz58SrKnSyE6pMRPblAki/rGl/5dYbpFHvRg=;
 b=Vp9Ktp6wNHSnRH8as3fk/u2ei5tJYVSUcHfuIIFShXlxz/n+8ztTh2xTptbZoNhW4TpXpZh9
 c47fNk7yqjdf/mWjg7nUNlcWC4S2/WRKpZVPVEWsyibxM1Kc60sb9nztsZU4Wx45tdTQRe5c
 2bmvN7PD1ZlefX54EFsLUr4Y2yA=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e7d81f8.7f841eed9308-smtp-out-n05;
 Fri, 27 Mar 2020 04:32:56 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4A45CC433F2; Fri, 27 Mar 2020 04:32:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mkenna)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CFFF7C433D2;
        Fri, 27 Mar 2020 04:32:54 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 27 Mar 2020 10:02:54 +0530
From:   Maharaja Kennadyrajan <mkenna@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] ath11k: add pktlog checksum in trace events to support
 pktlog
In-Reply-To: <87k137oykt.fsf@tynnyri.adurom.net>
References: <1585234155-30574-1-git-send-email-mkenna@codeaurora.org>
 <87k137oykt.fsf@tynnyri.adurom.net>
Message-ID: <24d78270e4df4a336e4b9989415af7e1@codeaurora.org>
X-Sender: mkenna@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-03-26 22:14, Kalle Valo wrote:
> Maharaja Kennadyrajan <mkenna@codeaurora.org> writes:
> 
>> Pktlog data are different among the chipset & chipset versions.
>> As part of enhancing the user space script to decode the pktlog
>> trace events generated, it is desirable to know which chipset or
>> which chipset version has provided the events and thereby decode
>> the pktlogs appropriately.
>> 
>> Pktlog checksum helps to determine the chipset variant which is
>> given by the firmware in the struct wmi_ready_event.
>> 
>> Pktlog checksums are computed during the firmware build.
>> So, adding that pktlog checksum in the pklog trace events.
>> 
>> Signed-off-by: Maharaja Kennadyrajan <mkenna@codeaurora.org>
> 
> When you send a new version please always increase the version number
> (in this case this should be v2), even if just the email address has
> changed. That way I can immediately see which version to take.
> 
> But no need to resend just because of this.

[Maha]: Sure Kalle. Got it. Thanks for the clarification.

Regards,
Maha
