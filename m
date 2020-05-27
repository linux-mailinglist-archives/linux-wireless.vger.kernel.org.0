Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A06EB1E4D3A
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2020 20:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgE0Sqi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 May 2020 14:46:38 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:37089 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725306AbgE0Sqi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 May 2020 14:46:38 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590605197; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=0p5muAHp78RZFJjopYN0hBJCyOqsRiNGIRg2whNHCI0=;
 b=I1qi+md/rO4bM4ZEcrJVUinXnOQN8NcPw2sksT13VjvaYS4NdekH0L2qJfsQsX+VopS8iaVl
 9DDQrra87M9PCdFOs+bjX++ybThgYeuYZ0GHJdnVrLUF4V6vdYWczxiRhrm0vpN+8sTm6kr0
 YjY3PU5QgIH796DqKVI49CFXJv4=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5eceb2a3b4f0a9ae22f5f5cd (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 27 May 2020 18:34:11
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3713CC433CA; Wed, 27 May 2020 18:34:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rmanohar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B99A3C433C9;
        Wed, 27 May 2020 18:34:10 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 27 May 2020 11:34:10 -0700
From:   Rajkumar Manoharan <rmanohar@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org
Subject: Re: [PATCH v3 10/11] mac80211: determine chantype from HE operation
 in 6 GHz
In-Reply-To: <6383af0eec17c942c20361d237c298f8a8ceaa54.camel@sipsolutions.net>
References: <1589399105-25472-1-git-send-email-rmanohar@codeaurora.org>
 <1589399105-25472-10-git-send-email-rmanohar@codeaurora.org>
 <74232fe9a140a15306c04f0509e6c615b8e329de.camel@sipsolutions.net>
 (sfid-20200527_164156_614875_57253EF5)
 <6383af0eec17c942c20361d237c298f8a8ceaa54.camel@sipsolutions.net>
Message-ID: <61b5ee51619e8cc676e644bb25463d3b@codeaurora.org>
X-Sender: rmanohar@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-05-27 07:44, Johannes Berg wrote:
> Oh, that was the last patch, ok.
> 
> So let's hear what you want to say regarding my comments - but please
> don't respin.
> 
> I will put some order into our patches tomorrow and post them, or
> perhaps better, post a combined series of yours and mine.
> 
> Sounds OK?
> 
Sounds great. There is one more followup patch I posted later. Sorry for 
that..
This is needed to propagate HE 6 GHz cap to user space.

https://patchwork.kernel.org/patch/11569921/

As you aware that the related hostapd series were submitted.

http://patchwork.ozlabs.org/project/hostap/list/?series=179527

-Rajkumar
