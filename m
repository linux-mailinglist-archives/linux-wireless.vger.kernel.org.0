Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94B4912D77C
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Dec 2019 10:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725875AbfLaJgQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 31 Dec 2019 04:36:16 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:16592 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725770AbfLaJgQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 31 Dec 2019 04:36:16 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1577784975; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=PgBVetFV5i/BVN9CTKkEURi7vaEtzmcR53n7QM3V48k=;
 b=K6tgzazvFDTKp1MS2SAjYd4B1LxGVzA7hstXBjVWrYxXzc6gFDFZCj3/bvZckFVel8CFoDP0
 VlxK0yFd1RWGdjiwscrjlbaQx6gc+ZTziGS44g6Q/ZffHR+B+OF0t5Ct6+x3yTjYpM41EjqR
 dDqs9cSGv+2yMr4skmkUjAqpB8U=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e0b168b.7f81591e4e30-smtp-out-n01;
 Tue, 31 Dec 2019 09:36:11 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4236AC4479C; Tue, 31 Dec 2019 09:36:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EDD0DC43383;
        Tue, 31 Dec 2019 09:36:10 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 31 Dec 2019 17:36:10 +0800
From:   wgong@codeaurora.org
To:     Justin Capella <justincapella@gmail.com>
Cc:     ath10k <ath10k@lists.infradead.org>, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] ath10k: select the min len of RX skb for sdio
In-Reply-To: <CAMrEMU94SDEP24XfFL-2R2KoK4NehwDY8p=MsNx1P7PBi111JQ@mail.gmail.com>
References: <20191220063829.11873-1-wgong@codeaurora.org>
 <CAMrEMU9cfYqgC_MvAuhJh5-pjqb_+WamHEkHf-t2ZW=nOR-8+w@mail.gmail.com>
 <c962d9a7401c4a3bbad71b01190fdce9@codeaurora.org>
 <CAMrEMU94SDEP24XfFL-2R2KoK4NehwDY8p=MsNx1P7PBi111JQ@mail.gmail.com>
Message-ID: <a57a6803397c5f5a97c64e7fc33de98c@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-12-20 20:11, Justin Capella wrote:
> If the data is invalid I think it should be discarded and a warning
> displayed, it is just as bad to pass too little data isn't it? Then
> you potentially have uninitialized data? Or pointers to nonsense?
> There is a good chance I am misunderstanding though, I just wanted to
> make sure you had considered those cases and the word alignment if
> that applies to this type of bus?
yes,
patch v2: https://patchwork.kernel.org/patch/11313849/
