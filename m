Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 765F145F041
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Nov 2021 16:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353942AbhKZPEo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Nov 2021 10:04:44 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:33060 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345231AbhKZPCn (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Nov 2021 10:02:43 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637938770; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: In-Reply-To: Date: References: Subject: Cc:
 To: From: Sender; bh=StYlqTb15X6YGhw/Vj+LDYvapQ+Uug6X0G9mLjV2ZMI=; b=X38UIs7GlpD7QJPDSrUzU0mngg7/Zb12WAcYsAtAG960H5FR7ZGbRDRxR9P5OVFIzt2LNHLx
 wSxxWcdM1d41wX2HOmwlTaY8m9qOhqC1zC519effd7xe3T+q9ysmYCSc+4lAOOdKVIffbBKv
 htMd0MqGYB4qMeAren7YxML8iD4=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 61a0f64fdb3ac5552a2dc605 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 26 Nov 2021 14:59:27
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 56868C43617; Fri, 26 Nov 2021 14:59:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6AB48C4338F;
        Fri, 26 Nov 2021 14:59:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 6AB48C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Jonas Jelonek <jelonek.jonas@gmail.com>
Cc:     Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "nbd\@nbd.name" <nbd@nbd.name>,
        Thomas Huehn <thomas.huehn@hs-nordhausen.de>
Subject: Re: [PATCH] ath9k: switch to rate table based lookup
References: <20211125121652.6073-1-jelonek.jonas@gmail.com>
        <878rxcb4q2.fsf@toke.dk> <87a6hrwg1f.fsf@tynnyri.adurom.net>
        <CAChE-vTktHRW1JR8s1NNnLOqfBihd=5T2qXDsQDyBeecw95U0g@mail.gmail.com>
Date:   Fri, 26 Nov 2021 16:59:23 +0200
In-Reply-To: <CAChE-vTktHRW1JR8s1NNnLOqfBihd=5T2qXDsQDyBeecw95U0g@mail.gmail.com>
        (Jonas Jelonek's message of "Fri, 26 Nov 2021 15:49:53 +0100")
Message-ID: <878rxb3qus.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jonas Jelonek <jelonek.jonas@gmail.com> writes:

>> And how did you test this? Are both PCI and USB devices affected?
>
> I tested this on a 8devices Rambutan with QCA9558 SoC, but didn=E2=80=98t
> explicitly test this with a USB device. I am not sure whether the
> ath9k_htc is affected. First I tested this without the patch to get a
> reference for comparison. I connected three devices via WiFi 2.4GHz
> and 5GHz, generated traffic multiple times with iperf3 and captured
> the rc_stats for each station. Then I applied the patch and did the
> same again. The throughput was overall the same like without the
> patch, compared to the first run of each station. Rate selection
> worked fine, the stats were nearly identical, same rates selected in
> both runs.

Thanks. Can someone review this from ath9k_htc point of view?

Also please don't use HTML in your emails, our lists drop all HTML
mails.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
