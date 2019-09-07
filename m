Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92BDFAC51F
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Sep 2019 09:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391990AbfIGHYZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 7 Sep 2019 03:24:25 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44540 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfIGHYZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 7 Sep 2019 03:24:25 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 357EB6083C; Sat,  7 Sep 2019 07:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567841064;
        bh=xfKZACvxOz1qy4pEkB4fvLHfjSHHHVf+HxKFwp04Ihw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=hm4qhEYm6Wfsh2Z2h8Z24hy7nj7JReq1hf5yKoL9Iy3e/UrANtfQdoH3CFOiQwDb1
         o2PYiggwICmsYXsDrg2fxEI0E2i350hrs2ZAYQPc1xn7tA68E02wMdLo4FUiGBJ1YQ
         MFRHs8wcq9NEHbtKEXEhVAhVEaFIfH1cVkvoVqQw=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from x230.qca.qualcomm.com (37-130-177-42.bb.dnainternet.fi [37.130.177.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0FE19607F1;
        Sat,  7 Sep 2019 07:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567841063;
        bh=xfKZACvxOz1qy4pEkB4fvLHfjSHHHVf+HxKFwp04Ihw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=GsUnN0n5LlQO7qcRPoRPrD011BEBg6OFO2pw/WID3uTXT9O9HW9OdYK14sQ5rueWh
         uOYly75PUDlnwZDmWxxgbktE5Q9sCgIHsM5DKAn2WyQoGA7j4CKOjA1drjKIfkC8t5
         SZkoiyToU5OpYByWSmpYm+3CpIeRuQzNysXVE5s0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0FE19607F1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org, linuxwifi@intel.com,
        david.e.box@intel.com, joe.konno@intel.com
Subject: Re: pull-request: iwlwifi-next 2019-09-06
References: <ed169588021b846217aa86cbf2576a1375653065.camel@coelho.fi>
Date:   Sat, 07 Sep 2019 10:24:16 +0300
In-Reply-To: <ed169588021b846217aa86cbf2576a1375653065.camel@coelho.fi> (Luca
        Coelho's message of "Fri, 06 Sep 2019 16:22:36 +0300")
Message-ID: <87h85owov3.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> Here's a batch of patches intended for v5.4.  This includes the last
> patchset 4 patchsets I sent.  Usual development work.  More details
> about the contents in the tag
> description.
>
> I pushed this to my pending branch and I got results from kbuildbot to
> some of the series, but I didn't get any results yet from the two last
> v2 series I sent.  I'll let you know if I get any results in the next
> couple of days.

Yesterday evening I pulled this to my pending branch and I did get a
success report from kbuildbot.

> Please let me know if there are any issues.
>
> Cheers,
> Luca.
>
>
> The following changes since commit a18da8f6194978c2b32a8367fb0df81cc6417848:
>
>   Merge tag 'mt76-for-kvalo-2019-09-05' of https://github.com/nbd168/wireless (2019-09-06 11:59:32 +0300)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git tags/iwlwifi-next-for-kalle-2019-09-06

Pulled, thanks Luca.

-- 
Kalle Valo
