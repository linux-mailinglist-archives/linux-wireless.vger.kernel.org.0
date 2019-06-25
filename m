Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E92C52296
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2019 07:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbfFYFKx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 01:10:53 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44182 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbfFYFKx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 01:10:53 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1429260117; Tue, 25 Jun 2019 05:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561439452;
        bh=q3RyeOqPGcPuNnUlE0ELDg52moofDQANOPp955Sbnwk=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=lOjTixxjXcWGxQSAeFunY3Cd/9De1Vam6mSRLEFmcMv2Bgbv1aFmNC2xQfyHGkC+f
         c1i45/XlXQyozXDkcUehDzMOZ+zXAd/z7ghLbhHoj7WVngtyIFEnGmk8sww8FfW2ok
         bpY61o0zn/id3kOQ19c8KpHR7Qt0LBv1On95rTRE=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,MISSING_DATE,MISSING_MID,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 224D160117;
        Tue, 25 Jun 2019 05:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561439451;
        bh=q3RyeOqPGcPuNnUlE0ELDg52moofDQANOPp955Sbnwk=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=Wa6/TR9Y/iD1Fc0wA90NCp6z8LiY5hVVPAZaGKyAVU4nC45h+H4hpruZElfE7PSzx
         PGJxEJQsHiKjWzPj8ssD1Jldx3VkRyX/nlWpeClMW+VKp3o9yxaC7xjz4bH+HyDzV3
         M2fxyKdM+NdkbzGDcx7KmtAOwuLcinbSvmtwCMGQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 224D160117
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/7] rt2x00: allow to specify watchdog interval
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190615100100.29800-2-sgruszka@redhat.com>
References: <20190615100100.29800-2-sgruszka@redhat.com>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     linux-wireless@vger.kernel.org,
        =?utf-8?q?Tomislav_Po=C5=BEega?= <pozega.tomislav@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Felix Fietkau <nbd@nbd.name>, Mathias Kresin <dev@kresin.me>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190625051052.1429260117@smtp.codeaurora.org>
Date:   Tue, 25 Jun 2019 05:10:51 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Stanislaw Gruszka <sgruszka@redhat.com> wrote:

> Allow subdriver to change watchdog interval by intialize
> link->watchdog_interval value before rt2x00link_register().
> 
> Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>

7 patches applied to wireless-drivers-next.git, thanks.

9f3e3323e996 rt2x00: allow to specify watchdog interval
2034afe4db4a rt2800: add helpers for reading dma done index
759c5b599cf4 rt2800: initial watchdog implementation
09db3b000619 rt2800: add pre_reset_hw callback
710e6cc1595e rt2800: do not nullify initialization vector data
e403fa31ed71 rt2x00: add restart hw
0f47aeeada2a rt2800: do not enable watchdog by default

-- 
https://patchwork.kernel.org/patch/10997029/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

