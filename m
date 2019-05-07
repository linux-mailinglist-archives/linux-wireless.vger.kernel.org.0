Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD19164AE
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2019 15:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfEGNiZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 May 2019 09:38:25 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47882 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbfEGNiZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 May 2019 09:38:25 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 19E47608FC; Tue,  7 May 2019 13:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557236305;
        bh=l90A5lWNxnGFAyhwY4bPw3WYsZLGBUjPIk18dw3ufRQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Ui00QRoQxoyIDS79yYA7PpfgZTtoEEDo0c7A5k6qdc7v6OfRUqxRtctXg0dQiVqiY
         6qkm+YSdH7/ByPoFJFZ464iIVYTI68ndpmYWcUCIx28Do1whjP6hFwXtCTHF9WVY5s
         Tj62hGuowkQTHWj6kAfhDXhb7aL0eDWcMdxKrXV4=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,MISSING_DATE,MISSING_MID autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4F27960AA2;
        Tue,  7 May 2019 13:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557236304;
        bh=l90A5lWNxnGFAyhwY4bPw3WYsZLGBUjPIk18dw3ufRQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=ZbRBxtZz9Q/riUOPaqIlh7gqapB9UwqzY7AmHzTjfngxJZSHuLju7f94allHXPw46
         FhrZyiSngYgoVPdqIENt0MuPma3SEOIzWUObD3hCSbul5Ue0Tj7NIwdYLTktPz68oK
         Ah5ck4DT0ByqHl1BLCO0wMXZOPfybsWJseMpAUiU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4F27960AA2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] ath10k: Extended the HTT stats support to retrieve
 Mu-MIMO related stats
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1551266682-32073-1-git-send-email-mkenna@codeaurora.org>
References: <1551266682-32073-1-git-send-email-mkenna@codeaurora.org>
To:     Maharaja Kennadyrajan <mkenna@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        vikpatel@codeaurora.org, arnagara@codeaurora.org,
        Maharaja Kennadyrajan <mkenna@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190507133825.19E47608FC@smtp.codeaurora.org>
Date:   Tue,  7 May 2019 13:38:25 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Maharaja Kennadyrajan <mkenna@codeaurora.org> wrote:

> Extended the bit mask value of the HTT stats to get the Mu-MIMO
> related stats via tracing.
> 
> Signed-off-by: Maharaja Kennadyrajan <mkenna@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

2 patches applied to ath-next branch of ath.git, thanks.

14bf9217d66d ath10k: Extended the HTT stats support to retrieve Mu-MIMO related stats
473a4084e19e ath10k: Added support to reset HTT stats in debugfs

-- 
https://patchwork.kernel.org/patch/10831589/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

