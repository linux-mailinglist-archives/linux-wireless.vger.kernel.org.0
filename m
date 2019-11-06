Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58B23F1CFC
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2019 18:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbfKFR52 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Nov 2019 12:57:28 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:37022 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729288AbfKFR52 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Nov 2019 12:57:28 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 088AA60134; Wed,  6 Nov 2019 17:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573063046;
        bh=c1XEG8EEgt1gzkA+1hGzc4wkwAen/kvfB1Azr15+2GI=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=fS9kyTKUp6nCFQAWdh3kunX9uY6Fjqadjdt6eJSgdnVhCG+EiZHSpqhFQeM4i4Iun
         fkq8bU08xHpyMn3l+AB9HxLQ1ceiSwmBdqL9GSA+oPmxD5J2YHCLa0FTGe3r75Eo11
         rZwsbBEnDN6VcK/6gDtFQNZYnk9/WcUnF4u5QJuA=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8A24360134;
        Wed,  6 Nov 2019 17:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573063043;
        bh=c1XEG8EEgt1gzkA+1hGzc4wkwAen/kvfB1Azr15+2GI=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=MZAnB6x9Q2va3DxF9/tNhFvRwUbf1swSKkreB2J8Yx4NpI+QBh/AeW2hRh2x24jvq
         SKEO04C7oMqLDrZ5JMGykFVD6IUP6z7zcgedOJrCwBN5FYv1bmmP86bxLhe37CCEkA
         t6VuH+3kszfm6z0QGZh3q+wEPNzy2rhSCOFWvKiQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8A24360134
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] rt2800: remove errornous duplicate condition
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191102174701.GA1489@makrotopia.org>
References: <20191102174701.GA1489@makrotopia.org>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Stanislaw Gruszka <sgruszka@redhat.com>,
        linux-wireless@vger.kernel.org, Roman Yeryomin <roman@advem.lv>,
        wbob <wbob@jify.de>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191106175726.088AA60134@smtp.codeaurora.org>
Date:   Wed,  6 Nov 2019 17:57:25 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Daniel Golle <daniel@makrotopia.org> wrote:

> On 2019-10-28 06:07, wbob wrote:
> > Hello Roman,
> >
> > while reading around drivers/net/wireless/ralink/rt2x00/rt2800lib.c
> > I stumbled on what I think is an edit of yours made in error in march
> > 2017:
> >
> > https://github.com/torvalds/linux/commit/41977e86#diff-dae5dc10da180f3b055809a48118e18aR5281
> >
> > RT6352 in line 5281 should not have been introduced as the "else if"
> > below line 5291 can then not take effect for a RT6352 device. Another
> > possibility is for line 5291 to be not for RT6352, but this seems
> > very unlikely. Are you able to clarify still after this substantial time?
> >
> > 5277: static int rt2800_init_registers(struct rt2x00_dev *rt2x00dev)
> > ...
> > 5279:  } else if (rt2x00_rt(rt2x00dev, RT5390) ||
> > 5280:         rt2x00_rt(rt2x00dev, RT5392) ||
> > 5281:         rt2x00_rt(rt2x00dev, RT6352)) {
> > ...
> > 5291:  } else if (rt2x00_rt(rt2x00dev, RT6352)) {
> > ...
> 
> Hence remove errornous line 5281 to make the driver actually
> execute the correct initialization routine for MT7620 chips.
> 
> As it was requested by Stanislaw Gruszka remove setting values of
> MIMO_PS_CFG and TX_PIN_CFG. MIMO_PS_CFG is responsible for MIMO
> power-safe mode (which is disabled), hence we can drop setting it.
> TX_PIN_CFG is set correctly in other functions, and as setting this
> value breaks some devices, rather don't set it here during init, but
> only modify it later on.
> 
> Fixes: 41977e86c984 ("rt2x00: add support for MT7620")
> Reported-by: wbob <wbob@jify.de>
> Reported-by: Roman Yeryomin <roman@advem.lv>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> Acked-by: Stanislaw Gruszka <sgruszka@redhat.com>

Patch applied to wireless-drivers-next.git, thanks.

a1f7c2cabf70 rt2800: remove errornous duplicate condition

-- 
https://patchwork.kernel.org/patch/11224189/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

