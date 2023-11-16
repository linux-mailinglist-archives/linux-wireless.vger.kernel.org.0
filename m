Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F1F7EE6A9
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Nov 2023 19:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345414AbjKPSZQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Nov 2023 13:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjKPSZQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Nov 2023 13:25:16 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC938195;
        Thu, 16 Nov 2023 10:25:12 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 591D720507;
        Thu, 16 Nov 2023 18:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1700159111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=82GRraZBW1WqfOlAqC5Ida9GyIWCqY+2MmQaziurGdw=;
        b=D52pd84C8LYLp8mrmLl5+1EzXV2lujZv0cTb1aHy45wSCP3qgSyC7BJFcophdS734lDwTM
        dQc1KqGEXjSla9QwsFt8F4gR8zQk4cs8fbgo5vzLPpGY7RJNYh/MQAaUKng/JXCd7vhC2I
        D/zoLRC+MrgqU8t4umcTGGCuWNY/OUI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1700159111;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=82GRraZBW1WqfOlAqC5Ida9GyIWCqY+2MmQaziurGdw=;
        b=FAR0N3ivyNbuus6yKNWFK4lDUs0NI7RcjC+8nLmNWA+tHHMUycBOqRqyY8efWCIbcxOtWl
        3yD1/OZl1FMsVWBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F3AB7139C4;
        Thu, 16 Nov 2023 18:25:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id paWNOoZeVmU/NgAAMHmgww
        (envelope-from <tiwai@suse.de>); Thu, 16 Nov 2023 18:25:10 +0000
Date:   Thu, 16 Nov 2023 19:25:10 +0100
Message-ID: <87h6llmu7t.wl-tiwai@suse.de>
From:   Takashi Iwai <tiwai@suse.de>
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc:     Zheng Hacker <hackerzheng666@gmail.com>,
        Kalle Valo <kvalo@kernel.org>, Zheng Wang <zyytlz.wz@163.com>,
        <aspriel@gmail.com>, <franky.lin@broadcom.com>,
        <hante.meuleman@broadcom.com>, <johannes.berg@intel.com>,
        <marcan@marcan.st>, <linus.walleij@linaro.org>,
        <jisoo.jang@yonsei.ac.kr>, <linuxlovemin@yonsei.ac.kr>,
        <wataru.gohda@cypress.com>, <linux-wireless@vger.kernel.org>,
        <brcm80211-dev-list.pdl@broadcom.com>,
        <SHA-cyfmac-dev-list@infineon.com>, <linux-kernel@vger.kernel.org>,
        <security@kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH v5] wifi: brcmfmac: Fix use-after-free bug in brcmf_cfg80211_detach
In-Reply-To: <18bd95c97f0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
References: <20231106141704.866455-1-zyytlz.wz@163.com>
        <87o7g7ueom.fsf@kernel.org>
        <CAJedcCytuGmvubqbSZgsU3Db=rg=xM+kSuLZn8BSvA18Yn+9Jw@mail.gmail.com>
        <18ba5520da0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
        <CAJedcCxoL+L1QPaZty27k6kqR2JRjxPVY=BV5xn7BSPojbxe=A@mail.gmail.com>
        <fa0e7536-9b05-42fb-9fff-acd2ffad9af9@broadcom.com>
        <CAJedcCzj9SFbx-=xDymqJyV2fu0xjmz2RH4+gT+Gxsqubg35ZA@mail.gmail.com>
        <18bd95c97f0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-2022-JP
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: 0.80
X-Spamd-Result: default: False [0.80 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         BAYES_SPAM(5.10)[100.00%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[163.com,gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         REPLY(-4.00)[];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-0.20)[-1.000];
         RCPT_COUNT_TWELVE(0.00)[19];
         MID_CONTAINS_FROM(1.00)[];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[gmail.com,kernel.org,163.com,broadcom.com,intel.com,marcan.st,linaro.org,yonsei.ac.kr,cypress.com,vger.kernel.org,infineon.com];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[]
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 16 Nov 2023 19:20:06 +0100,
Arend Van Spriel wrote:
> 
> On November 15, 2023 4:00:46 PM Zheng Hacker <hackerzheng666@gmail.com> wrote:
> 
> > Arend van Spriel <arend.vanspriel@broadcom.com> $BP2(B2023$BG/(B11$B7n(B13$BF|<~0l(B 17:18$B<LF;!'(B
> >> 
> >> On November 8, 2023 4:03:26 AM Zheng Hacker <hackerzheng666@gmail.com>
> >> wrote:
> >> 
> >>> Arend Van Spriel <arend.vanspriel@broadcom.com> $BP2(B2023$BG/(B11$B7n(B6$BF|<~0l(B 23:48$B<LF;!'(B
> >>>> 
> >>>> On November 6, 2023 3:44:53 PM Zheng Hacker <hackerzheng666@gmail.com> wrote:
> >>>> 
> >>>>> Thanks! I didn't test it for I don't have a device. Very appreciated
> >>>>> if anyone could help with that.
> >>>> 
> >>>> I would volunteer, but it made me dig deep and not sure if there is a
> >>>> problem to solve here.
> >>>> 
> >>>> brcmf_cfg80211_detach() calls wl_deinit_priv() -> brcmf_abort_scanning() ->
> >>>> brcmf_notify_escan_complete() which does delete the timer.
> >>>> 
> >>>> What am I missing here?
> >>> 
> >>> Thanks four your detailed review. I did see the code and not sure if
> >>> brcmf_notify_escan_complete
> >>> would be triggered for sure. So in the first version I want to delete
> >>> the pending timer ahead of time.
> >> 
> >> Why requesting a CVE when you are not sure? Seems a bit hasty to put it
> >> mildly.
> > 
> > I'm sure the issue exists because there's only cancler of timer but not woker.
> > As there's similar CVEs before like : https://github.com/V4bel/CVE-2022-41218,
> > I submit it as soon as I found it.
> 
> Ah, yes. The cancel_work_sync() can also be done in
> brcmf_notify_escan_complete().

AFAIUC, brcmf_notify_scan_complete() is called from the work itself,
too, hence you can't issue cancel_work_sync() there (unless you make
it conditional).


Takashi
