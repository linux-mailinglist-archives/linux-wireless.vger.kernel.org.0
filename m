Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 233F5ABA73
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2019 16:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390748AbfIFONs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Sep 2019 10:13:48 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48024 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731142AbfIFONr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Sep 2019 10:13:47 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EA0766119C; Fri,  6 Sep 2019 14:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567779226;
        bh=LU42f2KCFXni2GQke/nD4lFRlGm5RXFt+euOnQ2h1H4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=bm3vwo2Jt45t+/GI3egsW0Qwl9U4kknhgG7buQLtC+0g9tftmZ2pEpKvlK6Mz86DU
         B18uCAjQJ9Y+JCr+OZACxlYGiRd7X1Y18zy+hTcPK08TZo5pJh6/VYmid2H8WuqAr8
         JP8pPokip3oSfi+OJLyVH8hJxMe9IVeH83XE3U+U=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from x230.qca.qualcomm.com (37-130-177-42.bb.dnainternet.fi [37.130.177.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E83EE6030B;
        Fri,  6 Sep 2019 14:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567779226;
        bh=LU42f2KCFXni2GQke/nD4lFRlGm5RXFt+euOnQ2h1H4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=bm3vwo2Jt45t+/GI3egsW0Qwl9U4kknhgG7buQLtC+0g9tftmZ2pEpKvlK6Mz86DU
         B18uCAjQJ9Y+JCr+OZACxlYGiRd7X1Y18zy+hTcPK08TZo5pJh6/VYmid2H8WuqAr8
         JP8pPokip3oSfi+OJLyVH8hJxMe9IVeH83XE3U+U=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E83EE6030B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "briannorris\@chromium.org" <briannorris@chromium.org>,
        "sgruszka\@redhat.com" <sgruszka@redhat.com>
Subject: Re: [PATCH 4/8] rtw88: 8822c: add FW IQK support
References: <1565174405-2689-5-git-send-email-yhchuang@realtek.com>
        <20190903125324.4CDC76085C@smtp.codeaurora.org>
        <F7CD281DE3E379468C6D07993EA72F84D18C6B3B@RTITMBSVM04.realtek.com.tw>
Date:   Fri, 06 Sep 2019 17:13:42 +0300
In-Reply-To: <F7CD281DE3E379468C6D07993EA72F84D18C6B3B@RTITMBSVM04.realtek.com.tw>
        (Tony Chuang's message of "Wed, 4 Sep 2019 02:31:42 +0000")
Message-ID: <878sr1y0kp.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tony Chuang <yhchuang@realtek.com> writes:

>> 
>> <yhchuang@realtek.com> wrote:
>> 
>> > From: Yan-Hsuan Chuang <yhchuang@realtek.com>
>> >
>> > Add support for doing IQK in firmware
>> >
>> > Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
>> 
>> The commit log does not answer "Why?". What is IQK and how does it help?
>> 
>> No need to resend, I can update the commit log but just let me know what to
>> add.
>> 
>
> Ideally the RF component's I/Q vectors should be orthogonal, but usually they are not.
> So we need to calibrate for the RF components, ex. PA/LNA, ADC/DAC.
>
> And if the I/Q vectors are more orthogonal, the mixed signal will have less deviation.
> This helps with those rates with higher modulation (MCS8-9), because they have more
> strict EVM/SNR requirement. Also the better of the quality of the signal, the longer it
> can propagate, and the better throughput performance we can get.

I added this to patch 4 but there were some warnings so I had drop the
patches. So please send v2 and remember to add this description to patch
4.

-- 
Kalle Valo
