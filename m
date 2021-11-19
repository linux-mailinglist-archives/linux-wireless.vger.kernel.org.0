Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 904C6457022
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Nov 2021 14:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235605AbhKSN7t (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Nov 2021 08:59:49 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:40956 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234522AbhKSN7t (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Nov 2021 08:59:49 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 03D0C212C9;
        Fri, 19 Nov 2021 13:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637330207; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=85XTByKl5Pw3o1U01Reg7LSWSS4FBg2XIwmnhRDDDUk=;
        b=hQhJd3Fc8OpBwU0L0BDkqPIDw8mNgAjf4UwGdEFGaxtK7YM4nE5tI6WGyVNCWkh5CTot0w
        E6OjeoDbH+MciR/5CyxoVUlzXFe65eEputswwkg95qLdmt7hp7KLROYHPDWXi5NztWehzJ
        BT7Z20YdtxJYk+8mliBp5gkgsrsq2jI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637330207;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=85XTByKl5Pw3o1U01Reg7LSWSS4FBg2XIwmnhRDDDUk=;
        b=LQlzl7CSgDz1aq2Fb/TrDqtAAN/BCsK0s057bhW4ZiCUPgthpCWq6IuGiUVwyX8Z0hGhnD
        5tt7Hk6H6+WfbzBA==
Received: from alsa1.suse.de (alsa1.suse.de [10.160.4.42])
        by relay2.suse.de (Postfix) with ESMTP id 94242A3B83;
        Fri, 19 Nov 2021 13:56:46 +0000 (UTC)
Date:   Fri, 19 Nov 2021 14:56:46 +0100
Message-ID: <s5h7dd4fdup.wl-tiwai@suse.de>
From:   Takashi Iwai <tiwai@suse.de>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Ping-Ke Shih <pkshih@realtek.com>,
        <linux-wireless@vger.kernel.org>, <tiwai@suse.de>,
        <Larry.Finger@lwfinger.net>
Subject: Re: [PATCH v3 0/3] rtw89: fix crash when loading firmware file on certain platforms
In-Reply-To: <87ee7cwdsr.fsf@tynnyri.adurom.net>
References: <20211119054512.10620-1-pkshih@realtek.com>
        <87ee7cwdsr.fsf@tynnyri.adurom.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI/1.14.6 (Maruoka)
 FLIM/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL/10.8 Emacs/25.3
 (x86_64-suse-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI 1.14.6 - "Maruoka")
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 19 Nov 2021 13:05:56 +0100,
Kalle Valo wrote:
> 
> Ping-Ke Shih <pkshih@realtek.com> writes:
> 
> > First patch is to avoid writing "partition size" on read-only firmware
> > buffer, so it has to fix the crash.
> > The later two patches are used to make the semantics clear, but they don't
> > change the logic at all.
> >
> > I hope at least first patch can be taken into 5.16-rc, so people can avoid
> > this crash.
> 
> My plan is to take patch 1 to wireless-drivers. And, after patch 1
> trickles down to wireless-drivers-next, patch 2-3 to
> wireless-drivers-next. Sounds good to everyone?

Yes, sounds like a good plan.


thanks,

Takashi
