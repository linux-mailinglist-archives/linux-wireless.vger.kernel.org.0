Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E786A3FD3B4
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Sep 2021 08:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242180AbhIAGRT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Sep 2021 02:17:19 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:18642 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242085AbhIAGRR (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Sep 2021 02:17:17 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1630476981; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=6kjc4doou825Vr0319Q2SefiVl4ZE4jeQN5zzgpaxVU=; b=GXAUTBbmlQE5oN9+LUO3ulNDVpPtPUpkdSWNFRLAuNEwkN1Pb48JH4vud/AgVVHdgjU/aUqQ
 3u0ectn0eksL+NlZ034KTgN8nDaTmIR+VE2PJFPjh86zEOin9bzVdenQZMA91pCQctQPAsCn
 z7MB9xPS5hTVVZ2tseWyQXovTSE=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 612f1ab5d15f4d68a2c2e24e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 01 Sep 2021 06:16:21
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1971DC43460; Wed,  1 Sep 2021 06:16:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 074A3C4338F;
        Wed,  1 Sep 2021 06:16:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 074A3C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: pull-request: iwlwifi-next 2021-08-26
References: <c0d6e33d5f9e113e59ee34ca65a4fb45cd89f33b.camel@coelho.fi>
        <87wno44i8k.fsf@codeaurora.org>
        <e048218dbe3338124ba09908cb1e49ec89214a96.camel@coelho.fi>
Date:   Wed, 01 Sep 2021 09:16:18 +0300
In-Reply-To: <e048218dbe3338124ba09908cb1e49ec89214a96.camel@coelho.fi> (Luca
        Coelho's message of "Sun, 29 Aug 2021 19:15:59 +0300")
Message-ID: <87k0k03jnx.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

>> As the merge window most likely starts today, and I didn't want to
>> unnecessarily delay rest of iwlwifi patches, I decided to pull from a
>> commit before that DHC stuff:
>> 
>> git pull
>> git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git
>> e257d969f36503b8eb1240f32653a1afb3109f86
>> 
>> So pulled, thanks.
>
> Thanks for pulling! But we also need at least the top patch in my pull-
> req, the one that bumps the FW API...

Can you submit that patch again and assign it to me? And don't forget
document in the commit log why it's needed.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
