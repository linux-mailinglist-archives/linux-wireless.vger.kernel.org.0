Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC2AF105D9
	for <lists+linux-wireless@lfdr.de>; Wed,  1 May 2019 09:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbfEAHUD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 May 2019 03:20:03 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35568 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfEAHUD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 May 2019 03:20:03 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BAECF607DF; Wed,  1 May 2019 07:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556695202;
        bh=J3iYLEnQcPcmeOXn16+DGhfwHJNVhBVI5TebS9xsYe8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ohr5dRFjSnr84UJC6/mkMdLCjBHJBRkBQT65WtRVo7AsaO9hCDntLxGpXDsj/iH15
         YU27sPM0hyrx56WernkqgaJ3o+uXHC2/1EQI0y2ORps35UBkDjBL25Ja81qhLIdHQo
         dAJiCg62iWH6o3QgvlmoEFaMhf64PUe6TrSVT7bA=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from purkki.adurom.net (purkki.adurom.net [80.68.90.206])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B660E602F8;
        Wed,  1 May 2019 07:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556695202;
        bh=J3iYLEnQcPcmeOXn16+DGhfwHJNVhBVI5TebS9xsYe8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ohr5dRFjSnr84UJC6/mkMdLCjBHJBRkBQT65WtRVo7AsaO9hCDntLxGpXDsj/iH15
         YU27sPM0hyrx56WernkqgaJ3o+uXHC2/1EQI0y2ORps35UBkDjBL25Ja81qhLIdHQo
         dAJiCg62iWH6o3QgvlmoEFaMhf64PUe6TrSVT7bA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B660E602F8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     whiteheadm@acm.org
Cc:     Christian Lamparter <chunkeey@googlemail.com>,
        linux-wireless@vger.kernel.org
Subject: Re: carl9170 crash
References: <CAP8WD_bTvWWTeh6BP_qgByiuWLbSN==CTBY1KD-v8XpWZkf_Rw@mail.gmail.com>
Date:   Wed, 01 May 2019 10:19:59 +0300
In-Reply-To: <CAP8WD_bTvWWTeh6BP_qgByiuWLbSN==CTBY1KD-v8XpWZkf_Rw@mail.gmail.com>
        (tedheadster@gmail.com's message of "Tue, 30 Apr 2019 22:46:49 -0400")
Message-ID: <87k1fawsio.fsf@purkki.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tedheadster <tedheadster@gmail.com> writes:

>   I am getting this crash for the carl9170 in recent kernels, though I
> have not yet bisected it. It hangs the networking system completely
> (ifconfig -a never returns) and it prevents a reboot. I have to use
> sysrq-b to 'cleanly' reboot the system.
>
> I can apply and test any patches.

What was the last working version?

-- 
Kalle Valo
