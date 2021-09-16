Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7582F40DA17
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Sep 2021 14:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239539AbhIPMkp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Sep 2021 08:40:45 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:31692 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239739AbhIPMkl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Sep 2021 08:40:41 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1631795961; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=FWlDZB+/GDVY45adt3uihbENulBfzrai+xdADQpKrz0=; b=nTiG02G4O5sSHJvqubTo4+D5C8HuXCY2J+cxYBHQEWDt6T9SaP+Z5/yeyDc7klLKx+PKpIvz
 6A9J7u0ZDO+YFV8QMllwTMQ1XI0hwYCj7m+FbsGNYGJRfT3NwoS1kXeJQFqLi3i25a2pdt0f
 FakZZagDIKe50yJ5fClRGgfcN/k=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 61433ae5507800c8802c2c75 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 16 Sep 2021 12:39:01
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4AAE8C4361C; Thu, 16 Sep 2021 12:39:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8054DC4338F;
        Thu, 16 Sep 2021 12:38:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 8054DC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Fabio Estevam <festevam@denx.de>, ath10k@lists.infradead.org,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, erik.stromdahl@gmail.com,
        Peter Oh <peter.oh@eero.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Marek Vasut <marex@denx.de>, alagusankar@silex-india.com
Subject: Re: [PATCH v3] ath10k: high latency fixes for beacon buffer
References: <20210818232627.2040121-1-festevam@denx.de>
        <CAOMZO5CJC0=iH4zzJGj0e82GexBN7suOehz8ajKK8bK3ZcMOSg@mail.gmail.com>
Date:   Thu, 16 Sep 2021 15:38:52 +0300
In-Reply-To: <CAOMZO5CJC0=iH4zzJGj0e82GexBN7suOehz8ajKK8bK3ZcMOSg@mail.gmail.com>
        (Fabio Estevam's message of "Thu, 26 Aug 2021 09:01:27 -0300")
Message-ID: <871r5ozodf.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fabio Estevam <festevam@gmail.com> writes:

> Hello Kalle,
>
> On Wed, Aug 18, 2021 at 8:27 PM Fabio Estevam <festevam@denx.de> wrote:
>>
>> From: Alagu Sankar <alagusankar@silex-india.com>
>>
>> Beacon buffer for high latency devices does not use DMA. other similar
>> buffer allocation methods in the driver have already been modified for
>> high latency path. Fix the beacon buffer allocation left out in the
>> earlier high latency changes.
>>
>> Signed-off-by: Alagu Sankar <alagusankar@silex-india.com>
>> Signed-off-by: Erik Stromdahl <erik.stromdahl@gmail.com>
>> [fabio: adapt it to use ar->bus_param.dev_type ]
>> Signed-off-by: Fabio Estevam <festevam@denx.de>
>> ---
>> Changes since v2:
>> - Pick Alagu's patch:
>> https://patchwork.kernel.org/project/ath10k/patch/20190417191503.18814-3-erik.stromdahl@gmail.com/
>
> A gentle ping on this one.

This is on my queue, it's just that the queue is quite long at the
moment.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
