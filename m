Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82F1E4286D3
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Oct 2021 08:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234093AbhJKGaA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Oct 2021 02:30:00 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:36206 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234080AbhJKG37 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Oct 2021 02:29:59 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633933680; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=PuKFXpZ5yIKUfFnyn3NCW0SRGP3tPAEcee0I2yEU7Us=; b=xEi/BQJZQtRmvl7l0hYoUjixEkqHe/v/grtUWU3nvrZXsk0FTVE2fWnD6qK0OmS71xnJHI7y
 sJjA2iunqgxUkGrGxXkUv4ICEz4EjbE84fYovpG8kO5b50nLMHXAjEtIsNa/VrT7ULiYy4ud
 dagiNTAm0LfJI4UrN4HGP9tg2Cs=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 6163d96fab9da96e64399794 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 11 Oct 2021 06:27:59
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 15E76C43460; Mon, 11 Oct 2021 06:27:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D1F1AC4338F;
        Mon, 11 Oct 2021 06:27:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org D1F1AC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Christian Lamparter <chunkeey@gmail.com>
Cc:     linux-wireless@vger.kernel.org, ath9k-devel@qca.qualcomm.com
Subject: Re: [PATCH v1] ath9k: support DT ieee80211-freq-limit property to limit channels
References: <20211009212847.1781986-1-chunkeey@gmail.com>
Date:   Mon, 11 Oct 2021 09:27:55 +0300
In-Reply-To: <20211009212847.1781986-1-chunkeey@gmail.com> (Christian
        Lamparter's message of "Sat, 9 Oct 2021 23:28:47 +0200")
Message-ID: <87zgrg3wk4.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Christian Lamparter <chunkeey@gmail.com> writes:

> The common DT property can be used to limit the available channels
> but ath9k has to manually call wiphy_read_of_freq_limits().
>
> Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
>
> ---
>
> I would have put this into ath9k_of_init(). But it didn't work there.
> The reason is that in ath9k_of_init() the channels and bands are not yet
> registered in the wiphy struct. So there isn't any channel to flag as
> disabled.

I think this is good info to have in the commit log, so in the pending
branch I did that.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
