Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A48B18329A
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2020 15:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbgCLOPQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Mar 2020 10:15:16 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:30687 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727208AbgCLOPQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Mar 2020 10:15:16 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584022515; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=C9nSJfUTspKlSKDWoHkgbVZpuyu3orbRd82Ye52j2/o=; b=xEAV8x3yZcq8VFjX2/ZFNaqrd8oaLGG01VSehXaGP1utiqDjj2TmfGS6lBCKTKFvFZjKAC/w
 xlo5OmOfQpFOHuwHE5bVAT+xFtlSn/am8hYCCvi43+cZ1eCt1xwDxmjET0ujq3GJihc2hv9n
 l8Gwsrw5kuhgrlI/e695UyxkrGM=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e6a43f0.7f8b3fa483b0-smtp-out-n05;
 Thu, 12 Mar 2020 14:15:12 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D1DABC432C2; Thu, 12 Mar 2020 14:15:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from x230.qca.qualcomm.com (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 28D28C433D2;
        Thu, 12 Mar 2020 14:15:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 28D28C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Bastien Nocera <hadess@hadess.net>
Cc:     linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: [PATCH v2] rtl8188eu: Add rtw_led_enable module parameter
References: <869a61437edb52d60721ac8b2a7cccc43e3b0fb4.camel@hadess.net>
        <20200312133800.096EDC433CB@smtp.codeaurora.org>
        <8834172fd48be85552a201c6252fcc135492b16e.camel@hadess.net>
Date:   Thu, 12 Mar 2020 16:15:08 +0200
In-Reply-To: <8834172fd48be85552a201c6252fcc135492b16e.camel@hadess.net>
        (Bastien Nocera's message of "Thu, 12 Mar 2020 14:46:41 +0100")
Message-ID: <87r1xx64nn.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bastien Nocera <hadess@hadess.net> writes:

> On Thu, 2020-03-12 at 13:38 +0000, Kalle Valo wrote:
>> Bastien Nocera <hadess@hadess.net> wrote:
>> 
>> > Make it possible to disable the LED, as it can be pretty annoying
>> > depending on where it's located.
>> > 
>> > See also https://github.com/lwfinger/rtl8188eu/pull/304 for the
>> > out-of-tree version.
>> > 
>> > Signed-off-by: Bastien Nocera <hadess@hadess.net>
>> 
>> Please use "staging: " prefix for staging patches, easier for me to
>> filter that
>> way.
>
> Do you want me to resend it, or will you amend this patch?

Greg applies staging patches so it's up to him. Ah, only noticed now tha
you didn't CC him so he didn't see this patch. You should check how
staging patches are supposed to be sent, I don't know that subsystem
exactly works.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
