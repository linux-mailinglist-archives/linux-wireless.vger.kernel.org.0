Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D06FF2ADCF9
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Nov 2020 18:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729361AbgKJReg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Nov 2020 12:34:36 -0500
Received: from z5.mailgun.us ([104.130.96.5]:62315 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbgKJRef (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Nov 2020 12:34:35 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605029675; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=S4vIyjJlTrRKjf4Zg9NLssEHh5XPrU4sl8ZkKBXrdG4=; b=eBWD1+AiofKcrHN++ls5KuZegAg/q5vHL5x4lDGGD7IlYtxo10h7FzOmnG6UR9pQONYmp/jM
 +oY6NHhtOI6wb6y3RF8Wh15EciMjeNC58rXt3QY4DGsmmK23mgzb9rxJQmPS22XOz8qKtQHD
 tR9httEnNHyc/Xgn9kmqFudSXOQ=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5faaceff24ba9b3b02ec1b4c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 10 Nov 2020 17:33:51
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B2E60C433C8; Tue, 10 Nov 2020 17:33:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 309F5C433C8;
        Tue, 10 Nov 2020 17:33:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 309F5C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Abhishek Kumar <kuabhs@chromium.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Rakesh Pillai <pillair@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        ath10k <ath10k@lists.infradead.org>
Subject: Re: [PATCH] ath10k: add option for chip-id based BDF selection
References: <20201020000506.1.Ifbc28707942179f1cefc7491e995814564495270@changeid>
        <20201106071107.D7CE3C433C6@smtp.codeaurora.org>
        <CACTWRwtjvQYUvbWHrajNRkK_sDZRv1hr0kp+o1=6504qv64qKQ@mail.gmail.com>
Date:   Tue, 10 Nov 2020 19:33:46 +0200
In-Reply-To: <CACTWRwtjvQYUvbWHrajNRkK_sDZRv1hr0kp+o1=6504qv64qKQ@mail.gmail.com>
        (Abhishek Kumar's message of "Tue, 10 Nov 2020 09:19:20 -0800")
Message-ID: <87imadce11.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Abhishek Kumar <kuabhs@chromium.org> writes:

> Apologies for the delay, was busy so could not work on V2 . I have
> started working on V2 patch. Will upload by today/tomorrow.

Thanks, I'll then drop this v1.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
