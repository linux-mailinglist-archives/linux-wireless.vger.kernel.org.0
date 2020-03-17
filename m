Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA821187B43
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2020 09:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbgCQI3q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Mar 2020 04:29:46 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:20232 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725962AbgCQI3q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Mar 2020 04:29:46 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584433785; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=AJ1sbLDL7neO9w+ssQWSvnpFi4VgK5dJ0fFRUXIC/Y8=; b=QQz9caCHeFuVev9OtLn/ek0Sft8AypfHNK1tIQJ2ExwDvsFpKBxXak9bQRTL/HJkWLOJNSB7
 8K/hYcMVr7uCnR7pgGDT/+U9ViRsLZcDt/sfK/U65DAGN1XanjoPvsHjjDWN7Lr5pqUo9aE/
 zXMORbGgdp/ls3zpgmt61JOqO+E=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e708a77.7f220790cca8-smtp-out-n03;
 Tue, 17 Mar 2020 08:29:43 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9E2BDC00448; Tue, 17 Mar 2020 08:29:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 13985C0451C;
        Tue, 17 Mar 2020 08:29:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 13985C0451C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Network Development <netdev@vger.kernel.org>,
        linux-wireless@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        CI Notify <ci_notify@linaro.org>, ath11k@lists.infradead.org
Subject: Re: [PATCH] ath11k: Silence clang -Wsometimes-uninitialized in ath11k_update_per_peer_stats_from_txcompl
References: <20200130015905.18610-1-natechancellor@gmail.com>
        <20200211142431.243E6C433A2@smtp.codeaurora.org>
        <CAKwvOdkcT6jdFu2Mj5ZKErKmm+MyGAoJ=R_0LatR+_A0j7OtYw@mail.gmail.com>
Date:   Tue, 17 Mar 2020 10:29:35 +0200
In-Reply-To: <CAKwvOdkcT6jdFu2Mj5ZKErKmm+MyGAoJ=R_0LatR+_A0j7OtYw@mail.gmail.com>
        (Nick Desaulniers's message of "Mon, 16 Mar 2020 14:15:17 -0700")
Message-ID: <87a74fl6z4.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Nick Desaulniers <ndesaulniers@google.com> writes:

> Hi Kalle, I still see this warning in KernelCI builds of linux-next.
> Is ath-next flowing into linux-next?  I just want to triple check that
> this fix gets sent along.

ath-next is not pulled to linux-next. But this commit is in
wireless-drivers-next now and that tree is pulled to linux-next.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
