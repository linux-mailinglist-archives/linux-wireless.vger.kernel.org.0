Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB39203A20
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2020 16:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729231AbgFVO6z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Jun 2020 10:58:55 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:56104 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729072AbgFVO6z (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Jun 2020 10:58:55 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592837935; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=k4vKW+B8QI0TEg+kuFp2I2cdAtAz0jJwU/E6DXh/POk=; b=hOmvtx+cFh5YeklyL2iEmxzADRIDH1RGuM6ktUSkgrLZCyrAQkqzU6mQJmlYFctL46LYzjNB
 I7FDM6Yi6y0tjzaYFfSBQRnxuXIluvgO7Rq5L/JBNFZ+AfmBbFycWKr2axuOJj2DId55hb0K
 HFJDzOjc+pXOsMy9Q6uERLs0HrM=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5ef0c723ad153efa34105bbe (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 22 Jun 2020 14:58:43
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2F25DC433CA; Mon, 22 Jun 2020 14:58:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A4D20C433C8;
        Mon, 22 Jun 2020 14:58:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A4D20C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-wireless@vger.kernel.org, nbd@nbd.name,
        sean.wang@mediatek.com
Subject: Re: [PATCH v2 wireless-drivers] mt76: mt7663u: fix memory leaks in mt7663u_probe
References: <e4098f0c8a9ac51997de07f38c2bcdf7042d6db1.1592755166.git.lorenzo@kernel.org>
        <87sgenfagl.fsf@codeaurora.org>
        <20200622144018.GA27892@localhost.localdomain>
Date:   Mon, 22 Jun 2020 17:58:38 +0300
In-Reply-To: <20200622144018.GA27892@localhost.localdomain> (Lorenzo
        Bianconi's message of "Mon, 22 Jun 2020 16:40:18 +0200")
Message-ID: <871rm7f8pt.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo.bianconi@redhat.com> writes:

>> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>> 
>> > Fix the two following memory leaks in mt7663u_probe:
>> > 1- if device power-own times out, remove ieee80211 hw device.
>> > 2- if mt76u queues allocation fails, remove pending urbs.
>> 
>> One logical change per patch, please. If you have to create a list of
>> changes in the commit log that's a good sign that you need to split the
>> patch :)
>
> both of them are memory leaks in the error path of the same routine (mt7663u_probe()).
> Do I need to split them even in this case? If so I am fine with it.
> Do I need to send a v3?

Oh, I didn't notice that they were in the same function. So I guess this
sort of gray area and no need to send v3 because of this.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
