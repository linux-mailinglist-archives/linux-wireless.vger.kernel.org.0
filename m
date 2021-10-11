Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48C63428B40
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Oct 2021 12:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236045AbhJKKzW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Oct 2021 06:55:22 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:38621 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236095AbhJKKyy (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Oct 2021 06:54:54 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633949573; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=WVd92FptqqBV05n6PQyiTo86Zsm9VC9QcmJD+K6YU0c=; b=fVbr2IIgq7P7ENOlWi+URHHHDEG06HnG7JFNZkjd8CZZ1TFSA9gNuAepDSFw8F/OlAgjyovR
 tvHekgh0hlcu+3heV9qJzD5Fjy0F2GPcoP9Bl6y9DLq/N8ST/XXNjX21rljrGpPyNRzPDEvy
 rTAJA9iYgaWOYU1xEO3EcKCRkag=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 61641777f3e5b80f1fab4a13 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 11 Oct 2021 10:52:39
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B13FEC4360C; Mon, 11 Oct 2021 10:52:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 43FABC4338F;
        Mon, 11 Oct 2021 10:52:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 43FABC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Thomas Graf <post@thomas-graf.de>
Cc:     linux-wireless@vger.kernel.org, nbd@nbd.name
Subject: Re: [PATCH 5.10 2/3] mac80211: minstrel: remove deferred sampling code
References: <20201111183359.43528-1-nbd@nbd.name>
        <20201111183359.43528-2-nbd@nbd.name>
        <5a3c06de-0970-643f-e895-869dfb376fb9@thomas-graf.de>
Date:   Mon, 11 Oct 2021 13:52:36 +0300
In-Reply-To: <5a3c06de-0970-643f-e895-869dfb376fb9@thomas-graf.de> (Thomas
        Graf's message of "Wed, 28 Jul 2021 16:04:28 +0200")
Message-ID: <87ee8r25qj.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Thomas Graf <post@thomas-graf.de> writes:

> I tracked down an issue with using the Kernel 4.9.277 and 5.4.131 back
> to this patch.
>
> In 802.11bg mode the effective transmit rate drops to 3MBit/s.
> With that patch and perfect SNR (> 45dB) I get and rc_stats:
>
> *********************
> best   __________rate_________    ________statistics________
> ________last_______    ______sum-of________
> rate  [name idx airtime max_tp]  [avg(tp) avg(prob) sd(prob)]
> [prob.|retry|suc|att]  [#success | #attempts]
>         1     0    9738    0.9       0.9      93.7      0.5      75.0
> 1     3 4           562   572
>         2     1    4922    1.6       1.6      97.0      1.5     100.0
> 1     2 2           559   576
>         5.5   2    1858    4.7       4.7      99.9      0.0     100.0
> 2     2 2           542   565
>        11     3     982    9.1       9.1      94.9      1.2     100.0
> 4     3 3           560   578
>         6     4    1648    5.3       5.3      95.3      1.3     100.0
> 3     3 3           538   595
>         9     5    1112    8.0       8.0      97.5      1.8     100.0
> 4     2 2           560   596
>        12     6     844   10.5      10.5      92.4      2.0      75.0
> 5     3 4           572   615
>        18     7     576   15.5      15.4      89.0      1.4      66.6
> 5     2 3           559   609
>    D   24     8     440   20.4      20.4      99.4      1.1     100.0
> 6     2 2           560   604
>   C    36     9     308   29.1      29.1      98.7      1.6     100.0
> 6     2 2           565   600
>  B     48    10     240   37.3      36.3      87.3      1.4      66.6
> 6     2 3           608   671
> A   P  54    11     216   41.6      41.6      97.3      1.7     100.0
> 6     3 3           565   620
>
> Total packet count::    ideal 6111      lookaround 652
> *********************
>
> After reverting that patch the transmit rate is back to 20MBit/s:
> *********************
> best   __________rate_________    ________statistics________
> ________last_______    ______sum-of________
> rate  [name idx airtime max_tp]  [avg(tp) avg(prob) sd(prob)]
> [prob.|retry|suc|att]  [#success | #attempts]
>         1     0    9738    0.9       0.9      99.8      0.6     100.0
> 1     0 0            41   44
>         2     1    4922    1.6       1.6     100.0      0.0     100.0
> 1     0 0            45   45
>         5.5   2    1858    4.7       4.7      99.9      0.0     100.0
> 2     0 0            43   44
>        11     3     982    9.1       9.1      97.0      1.4     100.0
> 4     0 0            44   45
>         6     4    1648    5.3       5.3      99.9      0.0     100.0
> 3     0 0            43   44
>         9     5    1112    8.0       8.0      99.9      0.0     100.0
> 4     0 0            45   47
>        12     6     844   10.5       8.8      74.9      0.7       0.0
> 5     0 0            43   47
>        18     7     576   15.5      15.5     100.0      0.0     100.0
> 5     0 0            42   42
>    D   24     8     440   20.4      20.4      99.9      0.0     100.0
> 6     0 0            60   62
>   C P  36     9     308   29.1      29.1      99.9      0.0     100.0
> 6     0 0            44   46
> A      48    10     240   37.3      37.3      93.8      1.2     100.0
> 6     1 1           587   618
>  B     54    11     216   41.6      32.3      69.8      2.1      33.3
> 6     0 0         24506   25849
>
> Total packet count::    ideal 4962      lookaround 552
> *********************
>
> I'm using the ath9k driver with a sparklan WPEA-121N card.
>
> For my case reverting that patch is enough.
> What I see is that IEEE80211_TX_CTL_RATE_CTRL_PROBE is set but not
> used anywhere in the code. Maybe there is an easy and better fix than
> just reverting.

I lost track, is this regression resolved now or is it still open?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
