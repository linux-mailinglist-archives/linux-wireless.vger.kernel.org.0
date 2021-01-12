Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31DED2F348B
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Jan 2021 16:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391683AbhALPrP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Jan 2021 10:47:15 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:53842 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391480AbhALPrO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Jan 2021 10:47:14 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610466414; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=cPVeuoGsg/YYpiHkUCPYFmOYLufDCXBoM4oRJNPO+qU=; b=RPaZA5G/q7DsLZ3iwU4mRZCQva3o0wCFBGWU0Ig0i6H35PDzZkVNfL/jqrfX2SQ9E0Zu1mFi
 TFsXmGsypE8wKVFVlA21ISpzWqldzUx8wOMrQ3w/i1QMEYQghdEVzQiRqtqeKnPnjzFRMWNb
 U8hy0KytlHuC6zCuAp6TK4ICopg=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-west-2.postgun.com with SMTP id
 5ffdc454d84bad354791ebac (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 12 Jan 2021 15:46:28
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 44339C433CA; Tue, 12 Jan 2021 15:46:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from x230.qca.qualcomm.com (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 91F8CC433C6;
        Tue, 12 Jan 2021 15:46:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 91F8CC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Michal Kubecek <mkubecek@suse.cz>, linux-wireless@vger.kernel.org,
        Mordechay Goodstein <mordechay.goodstein@intel.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arjen de Korte <suse+build@de-korte.org>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: Re: regression in iwlwifi: page fault in iwl_dbg_tlv_alloc_region() (commit ba8f6f4ae254)
References: <20201228115814.GA5880@lion.mk-sys.cz>
        <87v9c2qtj9.fsf@tynnyri.adurom.net> <s5ha6tes58m.wl-tiwai@suse.de>
        <87v9c2ias2.fsf@codeaurora.org> <s5h5z42s44x.wl-tiwai@suse.de>
Date:   Tue, 12 Jan 2021 17:46:21 +0200
In-Reply-To: <s5h5z42s44x.wl-tiwai@suse.de> (Takashi Iwai's message of "Tue,
        12 Jan 2021 13:58:54 +0100")
Message-ID: <8735z6taya.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Takashi Iwai <tiwai@suse.de> writes:

> On Tue, 12 Jan 2021 13:45:33 +0100,
> Kalle Valo wrote:
>> 
>> Takashi Iwai <tiwai@suse.de> writes:
>> 
>> > On Tue, 12 Jan 2021 12:33:14 +0100,
>> > Kalle Valo wrote:
>> >> 
>> >> (adding luca)
>> >> 
>> >> Michal Kubecek <mkubecek@suse.cz> writes:
>> >> 
>> >> > FYI, there is a regression in iwlwifi driver caused by commit
>> >> > ba8f6f4ae254 ("iwlwifi: dbg: add dumping special device memory")
>> >> > reported at
>> >> >
>> >> >   https://bugzilla.kernel.org/show_bug.cgi?id=210733
>> >> >   https://bugzilla.suse.com/show_bug.cgi?id=1180344
>> >> >
>> >> > The problem seems to be an attempt to write terminating null character
>> >> > into a string which may be read only. There is also a proposed fix.
>> >> 
>> >> Can someone submit a proper patch, please? See instructions below how to
>> >> submit.
>> >> 
>> >> And please add Fixes tag to the commit log:
>> >> 
>> >> Fixes: ba8f6f4ae254 ("iwlwifi: dbg: add dumping special device memory")
>> >
>> > OK, I'll do it for my own
>> 
>> Thanks.
>> 
>> > but really I hoped that someone would have reacted on the bugzilla
>> > report before the official patch submission. So far no one from the
>> > upstream devs showed interest in the bug at all, unfortunately.
>> 
>> Bugzilla is problematic as I don't know if anyone tracks it actively, at
>> least I don't have time for that. I recommend reporting all wireless
>> issues to mailing lists to make sure everyone see it.
>
> I share your feeling as a subsystem maintainer, but at the same time,
> I see it's a big problem if the whole bugzilla reports are just
> silently ignored.  If it's a void, shouldn't we rather shut it down?

I'm all for shutting down bugzilla.kernel.org as silent bug reports are
frustrating the users. But I don't know what others would think about
that, maybe some subsystems use it actively?

At least there should be a big warning for wireless bugs.

> And, although a mailing list is fine to report via only some texts or
> some patches, it's not suitable to attach large logs or such, which is
> often essential for debugging.  Thanks to lore, the archivability is
> no longer a problem with ML recently, but the lack of data assignment
> is another problem, IMO.

Sure, I fully agree on the benefits of a bug tracker. The issue here is
the lack of people managing bug reports, not the tool.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
