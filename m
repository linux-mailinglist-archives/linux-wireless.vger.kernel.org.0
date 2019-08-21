Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36F7E976B7
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2019 12:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfHUKKc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Aug 2019 06:10:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59058 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbfHUKKb (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Aug 2019 06:10:31 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2BAA483F3D
        for <linux-wireless@vger.kernel.org>; Wed, 21 Aug 2019 10:10:31 +0000 (UTC)
Received: by mail-ed1-f69.google.com with SMTP id f11so1093750edb.16
        for <linux-wireless@vger.kernel.org>; Wed, 21 Aug 2019 03:10:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=8sBw1pzj3D8oNi/fIhRETMzxkmcUyKcDfjDtHp5hRqg=;
        b=GvKlgwRJwpUISV1V8ZMLKHKmhtRS+WKdXEbUK1FvnwNBsm7pd+qYey12o1oqcB4evr
         o8SSXPQ0xBiOnmdVX0nxj1GwE9LPRix2wj+Zx/ltz4hhXAuWlwZVyIop/UGQa3UPOB69
         CecxX5I1lxF4VRmEVG25g44S5l7pA33BFCBqAMHRuTaWql4l/qcEpvlOAVBlJSSSrXdT
         6BEWf+xu+HWuJxZHm2pBXVomC6XNMaQrboolMtHp6zqde+jNvP8y8gATQGnYVO7xX1TI
         QcciOHqyGSXzoSSCyYbdhaZwQVX+VQdkMdHuVUgaxlpT81RQ7D1bot5Scm06H8y43ynG
         EjGA==
X-Gm-Message-State: APjAAAW3w2IgsTrW6oZ1HpbsUeE183k0keEJ3UStLgp71mYYQe4dG9OB
        rpkizIfi/XCXyanDMoOQN6WDcxHRrOFgyh+7ajJAF5ky1ZVXoSoni5syqbTOcHX1KTf4JabMXRf
        0S3vfvsz4Y8e3eo2Dhm+49cko8wY=
X-Received: by 2002:a17:906:1b0d:: with SMTP id o13mr30067117ejg.96.1566382229491;
        Wed, 21 Aug 2019 03:10:29 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyd3E5HYBNShFpCV41jp08tnq1HHLUa5AYaE/M2Y8ba2T6CwiqUzX7t1gKN1O12nCIaKVeLPg==
X-Received: by 2002:a17:906:1b0d:: with SMTP id o13mr30067103ejg.96.1566382229316;
        Wed, 21 Aug 2019 03:10:29 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id w3sm3996451edu.4.2019.08.21.03.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 03:10:28 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id F212E181CEF; Wed, 21 Aug 2019 12:10:27 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Wen Gong <wgong@qti.qualcomm.com>, Wen Gong <wgong@codeaurora.org>,
        "ath10k\@lists.infradead.org" <ath10k@lists.infradead.org>
Cc:     "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 4/7] ath10k: disable TX complete indication of htt for sdio
In-Reply-To: <00992d0991704b0fae73a500bb2eb504@aptaiexm02f.ap.qualcomm.com>
References: <1566302108-18219-1-git-send-email-wgong@codeaurora.org> <1566302108-18219-5-git-send-email-wgong@codeaurora.org> <87blwkt480.fsf@toke.dk> <00992d0991704b0fae73a500bb2eb504@aptaiexm02f.ap.qualcomm.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 21 Aug 2019 12:10:27 +0200
Message-ID: <8736husub0.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@qti.qualcomm.com> writes:

>> -----Original Message-----
>> From: ath10k <ath10k-bounces@lists.infradead.org> On Behalf Of Toke
>> Høiland-Jørgensen
>> Sent: Tuesday, August 20, 2019 8:24 PM
>> To: Wen Gong <wgong@codeaurora.org>; ath10k@lists.infradead.org
>> Cc: linux-wireless@vger.kernel.org
>> Subject: [EXT] Re: [PATCH 4/7] ath10k: disable TX complete indication of htt
>> for sdio
>> 
>> Wen Gong <wgong@codeaurora.org> writes:
>> 
>> > Tx complete message from firmware cost bus bandwidth of sdio, and bus
>> > bandwidth is the bollteneck of throughput, it will effect the bandwidth
>> > occupancy of data packet of TX and RX.
>> >
>> > This patch disable TX complete indication from firmware for htt data
>> > packet, it results in significant performance improvement on TX path.
>> 
>> Wait, how does that work? Am I understanding it correctly that this
>> replaces a per-packet TX completion with a periodic one sent out of
>> band?
> When this patch applied, firmware will not indicate tx complete for tx
> Data, it only indicate HTT_T2H_MSG_TYPE_TX_CREDIT_UPDATE_IND,
> This htt msg will tell how many data tx complete without status(status maybe success/fail).

Ah, so this is basically a counter of how much data is currently queued
in the firmware?

>> And could you explain what the credits thing is for, please? :)
> For high latency bus chip, all the tx data's content(include ip/udp/tcp header
> and payload) will be transfer to firmware's memory via bus.
> And firmware has limited memory for tx data, the tx data's content must
> Saved in firmware memory before it tx complete, if ath10k transfer tx
> data more than the limit, firmware will occur error. The credit is used
> to avoid ath10k exceed the limit.

What's a typical limit in the firmware?

-Toke
