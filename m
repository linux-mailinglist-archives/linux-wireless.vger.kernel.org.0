Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA7E317B6A9
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2020 07:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbgCFG1z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Mar 2020 01:27:55 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:16554 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725829AbgCFG1y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Mar 2020 01:27:54 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1583476074; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=OVQJmYtvpMtsQkLA1AznKeLEBf/lzh6TSc5k9bWmwhw=; b=o8+WrO0GEWd53sAwqrI0T1m/fi/WHs3dpmbl6OtUfD5ur+Qeu8Gt+F7fJpaOO21Fe8QHi+LG
 pAhYGgHGnSobR6xa7I7U8sXR61IsEevcDd05BmzSxxkKF5t2nvxTu5X2QGNjqP+hSHZ9Xyzb
 /NFM9vfFPmT7lZXXgvSXikKlQ4k=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e61ed61.7f935b606500-smtp-out-n03;
 Fri, 06 Mar 2020 06:27:45 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 66B61C433A2; Fri,  6 Mar 2020 06:27:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1866DC43383;
        Fri,  6 Mar 2020 06:27:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1866DC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: update web URL for iwlwifi
References: <iwlwifi.20200305142622.3b1f9018cd2e.Iccbce3e78befd4ac39735b26617cfb6a12a2ae5a@changeid>
        <87ftemq2ik.fsf@kamboji.qca.qualcomm.com>
        <39c51b932b8a5588ea6ec8a040255fb56b498214.camel@coelho.fi>
Date:   Fri, 06 Mar 2020 08:27:40 +0200
In-Reply-To: <39c51b932b8a5588ea6ec8a040255fb56b498214.camel@coelho.fi> (Luca
        Coelho's message of "Thu, 05 Mar 2020 18:44:33 +0200")
Message-ID: <877dzyov4z.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> On Thu, 2020-03-05 at 16:50 +0200, Kalle Valo wrote:
>> Luca Coelho <luca@coelho.fi> writes:
>> 
>> > From: Luca Coelho <luciano.coelho@intel.com>
>> > 
>> > The current URL mentioned in iwlwifi's W entry is outdated and
>> > currently pointing to a dead link.  Change it so that it points to the
>> > correct Wiki page directly.
>> > 
>> > Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
>> 
>> I'll queue this for v5.6, ok?
>
> Sure, if you think it's worth it.

I usually try to get changes to MAINTAINERS file to Linus as fast as
possible to avoid any conflicts.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
