Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0169B3F3DF6
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Aug 2021 07:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhHVFIW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 Aug 2021 01:08:22 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:40296 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbhHVFIV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 Aug 2021 01:08:21 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629608861; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: References: In-Reply-To: Subject: Cc:
 To: From: Sender; bh=K8Q2R58djEIFzc8hVtj2CSfp2RbYxFTm90tQxuUAO7Q=; b=Z5cf94rVA1yLaUpI15VzWRWbqBV8EDwmScVae/BttvDqUN2p/whVazkULiwqY283QMXeznQ5
 7oquadWgpOJucSZv3j+2q1WQfUqidESax+eRLRE1j2wsgzMP0ka9Lqm21gWBWYkNn1//Qt1Y
 Ol30EKW3dh0bA0jzGSz6mpLA+rU=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 6121db8f34bfa769798cb6ed (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 22 Aug 2021 05:07:27
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EC8ADC4360D; Sun, 22 Aug 2021 05:07:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 67650C4338F;
        Sun, 22 Aug 2021 05:07:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 67650C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-wireless@vger.kernel.org,
        Ugo =?utf-8?Q?R=C3=A9mery?= <ugo.remery@gmail.com>
Subject: Re: [PATCH v2] rtw88: add quirk to disable pci caps on HP Pavilion 14-ce0xxx
In-Reply-To: <20210821210505.20257-1-Larry.Finger@lwfinger.net> (Larry
        Finger's message of "Sat, 21 Aug 2021 16:05:05 -0500")
References: <20210821210505.20257-1-Larry.Finger@lwfinger.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Sun, 22 Aug 2021 08:07:21 +0300
Message-ID: <87bl5qrrsm.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Larry Finger <Larry.Finger@lwfinger.net> writes:

> From: Ugo R=C3=A9mery <ugo.remery@gmail.com>
>
>     8821CE causes random freezes on HP Pavilion 14-ce0019nf. Add a quirk
>     to disable pci ASPM capability.
>
> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>

If Ugo wrote this (which I assume he did as he is marked as the author
in the from line) his s-o-b is also needed. The order of s-o-b should be
first the author's (Ugo) and then the submitter's (Larry).

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes#signed-off-by_missing

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
