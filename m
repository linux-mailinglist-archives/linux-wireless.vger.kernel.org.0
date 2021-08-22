Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5DE3F3DFB
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Aug 2021 07:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbhHVFKL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 Aug 2021 01:10:11 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:26558 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbhHVFKJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 Aug 2021 01:10:09 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629608969; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=zKVD0rIumcaUEyKT6fk1eYHnfashqgh8+7h5noVF3iU=; b=H4VWfOXbJ9H3cv+O01gL363RAkK3d8YZsntXKaqSCL34c95onU5eOcepj5wY/y8LMOPuz5kG
 Dqq6jwUblBWHLQi0kIvv8x8qVmgs6haGKTdIsF8JSpDhrvsjoMoRzqhk4X5O8OFtUwB/estC
 ZuwSG9F94f5x+c5V+oJ5nE5sNa8=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 6121dc072b9e91b6882a3bb0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 22 Aug 2021 05:09:27
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D3F39C43616; Sun, 22 Aug 2021 05:09:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0AED0C4338F;
        Sun, 22 Aug 2021 05:09:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 0AED0C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Christian Lamparter <chunkeey@gmail.com>
Cc:     linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        ath9k-devel@qca.qualcomm.com, Rob Herring <robh+dt@kernel.org>
Subject: Re: [RFC PATCH v1 1/3] dt-bindings:net:wireless:qca,ath9k: add nvmem-cells for calibration data
References: <91e68ca7f65bee7197ed5829ef91bc526df16e8a.1629508039.git.chunkeey@gmail.com>
        <87ilzz9wzf.fsf@tynnyri.adurom.net>
        <cf25eb4a-197d-161a-5902-64830c383746@gmail.com>
Date:   Sun, 22 Aug 2021 08:09:22 +0300
In-Reply-To: <cf25eb4a-197d-161a-5902-64830c383746@gmail.com> (Christian
        Lamparter's message of "Sat, 21 Aug 2021 22:02:57 +0200")
Message-ID: <8735r2rrp9.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Christian Lamparter <chunkeey@gmail.com> writes:

> On 21/08/2021 07:40, Kalle Valo wrote:
>> Christian Lamparter <chunkeey@gmail.com> writes:
>>
>>> On most embedded ath9k devices (like range extenders,
>>> routers, accesspoints, ...) the calibration data for
>>> the RF/PHY is simply stored in a MTD partition named
>>> "ART", "caldata"/"calibration", etc.
>>>
>>> Any mtd partition is automatically registered in the
>>> nvmem subsystem. This makes is possible to fetch the
>>> necessary calibration directly from there at the low
>>> cost of adding nvmem cell information via the
>>> device-tree or via similar means.
>>>
>>> This speeds up the driver's initialization a lot,
>>> because the driver doesn't have to wait for userspace
>>> to provide the data via helpers.
>>>
>>> Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
>>
>> The series looks good to me. But I'm curious, why you marked this as
>> RFC? Is there something controversial I missed?
>
> yeah. Last night (it was already really late) I was tunnel-visioning
> at the thought that device-tree binding update was a must there.
> ... And ath9k's qca,ath9k.txt is still in that .txt and not .yaml
> format. So, I'm not sure if that file has to be converted first.
> (I couldn't get Rob's tools to work. And without them, I've no idea
> what error messages a converted .yaml of it will pop up)
>
> However... since then, I had the change to re-read:
> <https://www.kernel.org/doc/Documentation/nvmem/nvmem.txt>
>
> And found that nvmem cells and lookups can be specified in
> the old platform data way as well... So that binding patch
> 1/3 is optional.
>
> So, yeah. If nobody has an comment until next week, I'll post this
> series with only patches 2/3 and 3/3.

Sounds good, thanks for the background.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
