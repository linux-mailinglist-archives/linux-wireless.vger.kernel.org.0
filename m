Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A659D25396
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2019 17:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbfEUPPa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 May 2019 11:15:30 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34448 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727969AbfEUPP3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 May 2019 11:15:29 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3A4246087A; Tue, 21 May 2019 15:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558451729;
        bh=xUKabVGuFyr4+KzPMh6yYHNL6Aqbci7ENH//WgNekIQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=goWTjT9Kr1beCm1oD1hOAcqRcFM4oVct2YePMtLVR0oyUzslBcRE9fpw8+70xipwi
         AOGL9sbSTRSrdchYDhGsFtJgYrRCLTxPrW18hZYAl19gWawCJngqIgNh7C5HlIfy+Q
         o8/V+T3Y9y46DYL7pkiSDOQWrKIrR9rGePDeuoR4=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from purkki.adurom.net (purkki.adurom.net [80.68.90.206])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 154F360128;
        Tue, 21 May 2019 15:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558451728;
        bh=xUKabVGuFyr4+KzPMh6yYHNL6Aqbci7ENH//WgNekIQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=lD28yS8xX7Sf91skzmU/FHCkD0bHnb1mNBoTWn8l8aioy+V2bleDjSQ/sEcZB5ORs
         /UcyAp728NQCkYotDo8Ma4FO3uFA9tiLnDXOyJ23uNQ1ArMn7yO7Z5pkwIg9k0NQi1
         nn0HakoZITraAFePOYRJPA9L9sZrTRzu1SUzemTU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 154F360128
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Alexei Avshalom Lazar <ailizaro@codeaurora.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com
Subject: Re: [PATCH v3 0/2] Add support for new channels on 60GHz band
References: <1558364020-11064-1-git-send-email-ailizaro@codeaurora.org>
Date:   Tue, 21 May 2019 18:15:25 +0300
In-Reply-To: <1558364020-11064-1-git-send-email-ailizaro@codeaurora.org>
        (Alexei Avshalom Lazar's message of "Mon, 20 May 2019 17:53:38 +0300")
Message-ID: <87ftp7vnxu.fsf@purkki.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Alexei Avshalom Lazar <ailizaro@codeaurora.org> writes:

> The following set of patches add support for new channels on
> 60GHz band and EDMG channels:
> -Nl80211 support for EDMG channels
> -Wil6210 support for EDMG channels
>
> Alexei Avshalom Lazar (2):
>   nl80211: Add support for EDMG channels
>   wil6210: Add EDMG channel support

Please always add a changelog to help the reviewers:

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches#changelog_missing

-- 
Kalle Valo
