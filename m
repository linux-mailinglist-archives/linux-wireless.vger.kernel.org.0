Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4B5EDEFA5
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2019 16:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfJUOdZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Oct 2019 10:33:25 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51994 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfJUOdZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Oct 2019 10:33:25 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 63CBC6079D; Mon, 21 Oct 2019 14:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571668404;
        bh=KMDUFdljanvngNy/CGgHd1p8m9cZpuOnap9ONx+d/w0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=g+HadGiiA95b9uw7F4J/zt1XMfRm1Sdkiomtl5lf62oYMjlA29kQD6dnKslWV85jF
         XH9L2TV5i4LnF/c986KTZHoRpIZp0uzwM0yeKK9w7JZUlqdJX0u3xF8sV1N2NN1Ov+
         uuozX8lmtjMZ75sMPx5b1iXXEGjv0EICXb0RkS0I=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4E4EA6081E;
        Mon, 21 Oct 2019 14:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571668401;
        bh=KMDUFdljanvngNy/CGgHd1p8m9cZpuOnap9ONx+d/w0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ISBcQlbWwowObyPEsmQ2QV5k7VSgxhYZRffAlnYpxxS4kP/GfvD0nmIeFSuixIKW9
         0Kud269HqJ90exG3gg52fxXxWPuIvPdiIY+SUOYSiNfG5J/MVqW2R2BUJNEp8lRBtF
         GAIMcaa/7943cK5XO5iS2gEPmdn7RCnl36uk5ipY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4E4EA6081E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Kan Yan <kyan@google.com>
Cc:     make-wifi-fast@lists.bufferbloat.net,
        Toke =?utf-8?Q?H=C3=B8iland-J?= =?utf-8?Q?=C3=B8rgensen?= 
        <toke@redhat.com>, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, Yibo Zhao <yiboz@codeaurora.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH v4 0/2] Implement Airtime-based Queue Limit (AQL)
References: <20191011022413.176208-1-kyan@google.com>
        <87wod7y9ui.fsf@kamboji.qca.qualcomm.com>
        <87sgnvy9c2.fsf@kamboji.qca.qualcomm.com>
        <CA+iem5uLYFVQjPaE1QDKc6c+eKz8Xd4LbwczYXOBKP3q+HHdBg@mail.gmail.com>
Date:   Mon, 21 Oct 2019 17:33:16 +0300
In-Reply-To: <CA+iem5uLYFVQjPaE1QDKc6c+eKz8Xd4LbwczYXOBKP3q+HHdBg@mail.gmail.com>
        (Kan Yan's message of "Mon, 14 Oct 2019 16:58:04 -0700")
Message-ID: <87r236tbgz.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

(please don't top post)

Kan Yan <kyan@google.com> writes:

> I believe Toke will integrate this with his version and move the
> estimating pending airtime part to mac80211, so maybe in the next
> version, ath10k change is no longer required.

What do you mean? Are you saying that I can drop this patch:

[v4,2/2] ath10k: Enable Airtime-based Queue Limit (AQL)

https://patchwork.kernel.org/patch/11184783/

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
