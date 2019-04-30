Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C38AF28D
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2019 11:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfD3JLs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Apr 2019 05:11:48 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59518 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfD3JLs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Apr 2019 05:11:48 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 93F33608CE; Tue, 30 Apr 2019 09:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556615507;
        bh=eQ3LEZH3WTxxr22THEBdYrergFVi8MykX/kJvuJx2EI=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=RRQvq2HvOzsbpgNzOx0A63lF8oH2/utNHpjhikk2/82KaVnaKwVF3nU0kE2Ndw6Bf
         TdfYKkLoxKls2lJrwUA07qX4xpixhnDgFH7l4LqZ3snM3wgyWx5JGkhjaAcV/IrncG
         dJdG2SMrb4hvT//+d6j+PzBsGjsPw+Zhhug8giEE=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BF0E2608CE;
        Tue, 30 Apr 2019 09:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556615506;
        bh=eQ3LEZH3WTxxr22THEBdYrergFVi8MykX/kJvuJx2EI=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=cWELrSjGuwv3HudvVWzqhsHDpkAt76V5KiiphEpxM6Q/WI8qV4mIS2br9oY2v14D/
         AgJZ/whzlzBVAE9y90K0/0ks/+2LLy56Bpv3bmFjGw04+QPHkbrZabUWoDasU879Ds
         krWtuJxb4AyphqUJzRT7prfedViGafm8+p65442U=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BF0E2608CE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     John Crispin <john@phrozen.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        Shashidhar Lakkavalli <slakkavalli@datto.com>
Subject: Re: [PATCH V2 1/3] mac80211: dynamically enable the TWT requester support on STA interfaces
References: <20190430070338.4006-1-john@phrozen.org>
        <20190430070338.4006-2-john@phrozen.org>
Date:   Tue, 30 Apr 2019 12:11:42 +0300
In-Reply-To: <20190430070338.4006-2-john@phrozen.org> (John Crispin's message
        of "Tue, 30 Apr 2019 09:03:36 +0200")
Message-ID: <871s1jsvqp.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

John Crispin <john@phrozen.org> writes:

> Turn TWT for STA interfaces when they associate and/or receive a
> beacon where the twt_responder bit has changed.
>
> Signed-off-by: Shashidhar Lakkavalli <slakkavalli@datto.com>
> Signed-off-by: John Crispin <john@phrozen.org>

Nothing important, but nowadays we have Co-developed-by which is a nice
way to document multiple authors (I'm assuming that's the case here):

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by

-- 
Kalle Valo
