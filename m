Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE67412E4F
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Sep 2021 07:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbhIUFuz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Sep 2021 01:50:55 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:48295 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229590AbhIUFuz (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Sep 2021 01:50:55 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632203367; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=wVVoFUw4tdLcj7GekZ6OmjzAKrX0b/ozYb0puAytqdE=; b=E021Avw7ynSxxusNgG+Rbmsbrts7tWULRhzVHKa14lyvHuCFSYp7O58i8HKdtA/1Zp7Lf55N
 CQY65dx7IOXxCJdhjIuRPgR3Lnw2Mx6ivO6LeHkFKzgANU/ts1E/z9bipiaHFYRcA4A3RS7Z
 BaR9WRzvRimJ6T0gl6SSTbcoqL4=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 6149725ae0f78151d6e5186e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 21 Sep 2021 05:49:14
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 559D8C43460; Tue, 21 Sep 2021 05:49:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D52E9C4338F;
        Tue, 21 Sep 2021 05:49:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org D52E9C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Martin Fuzzey <martin.fuzzey@flowbird.group>
Cc:     linux-wireless@vger.kernel.org,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Siva Rebbagondla <siva8118@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Prameela Rani Garnepudi <prameela.j04cs@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] rsi: fix startup and P2P mode
References: <1630337206-12410-1-git-send-email-martin.fuzzey@flowbird.group>
Date:   Tue, 21 Sep 2021 08:49:05 +0300
In-Reply-To: <1630337206-12410-1-git-send-email-martin.fuzzey@flowbird.group>
        (Martin Fuzzey's message of "Mon, 30 Aug 2021 17:26:43 +0200")
Message-ID: <875yuuwka6.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Martin Fuzzey <martin.fuzzey@flowbird.group> writes:

> This series fixes an occasional startup failure when BT
> coexistence is enabled and makes P2P mode work
> (the two are unrelated but sending as a series since the same files
> are modified).
>
> Tested on RS9116 in P2P client mode against an Android phone (S8, Android 9)
>
> For an unknown reason GO mode does not work against the phone but it
> does work against a second RS9116 device.
> In this case Android does not send a response to the 3rd WPA handshake
> packet. It is difficult to debug this without the phone wpa_supplicant
> logs which I don't have.
>
> Regression tested OK for STA and AP modes.
>
> V2:
>   * rebase against wireless-drivers-next
>   * add cc: stable to patches 2 & 3
>
> Martin Fuzzey (3):
>   rsi: fix occasional initialisation failure with BT coex
>   rsi: fix key enabled check causing unwanted encryption for vap_id > 0
>   rsi: fix rate mask set leading to P2P failure

BTW thanks for the outstanding cover letter and commit logs in the
patches, it was so easy for me to understand the background and the
level of testing these patches have had. If everyone would write their
patches like this my job would be a lot easier :)

I'm going to use this patchset as an example in the submittingpatches
wiki page.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
