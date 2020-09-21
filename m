Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77C9D27249D
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Sep 2020 15:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgIUNIc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Sep 2020 09:08:32 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:33294 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726584AbgIUNIb (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Sep 2020 09:08:31 -0400
X-Greylist: delayed 349 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Sep 2020 09:08:30 EDT
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600693711; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=db41zdzYe9Oi5weBkQXr2AXdoiKQCyrCWhDRhZQxaxs=;
 b=BF1Ob5nhD69lq5VSE8O4+RJria0X12F7U48CxFbQmqD3BDZm8rfFEtvUQkvTe8icqg2yEM0l
 Evnyp9kBpClGI0yo+v5DDJEzlmw8JDCpD9g8ozZvab42sjlmVTw/t1FPQttfiSdvxqkl3QKz
 fIXxnSfsQoItFj/ZZ4uFF0NCUHM=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5f68a537ae7ca421d2cb1339 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 21 Sep 2020 13:05:59
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F092DC43385; Mon, 21 Sep 2020 13:05:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EBC15C433CA;
        Mon, 21 Sep 2020 13:05:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EBC15C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wireless: ath9k: hif_usb: fix race condition between
 usb_get_urb() and usb_kill_anchored_urbs()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200911071427.32354-1-brookebasile@gmail.com>
References: <20200911071427.32354-1-brookebasile@gmail.com>
To:     Brooke Basile <brookebasile@gmail.com>
Cc:     davem@davemloft.net, kuba@kernel.org, gregkh@linuxfoundation.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        ath9k-devel@qca.qualcomm.com, syzkaller-bugs@googlegroups.com,
        Brooke Basile <brookebasile@gmail.com>,
        syzbot+89bd486af9427a9fc605@syzkaller.appspotmail.com
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200921130558.F092DC43385@smtp.codeaurora.org>
Date:   Mon, 21 Sep 2020 13:05:58 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Brooke Basile <brookebasile@gmail.com> wrote:

> Calls to usb_kill_anchored_urbs() after usb_kill_urb() on multiprocessor
> systems create a race condition in which usb_kill_anchored_urbs() deallocates
> the URB before the completer callback is called in usb_kill_urb(), resulting
> in a use-after-free.
> To fix this, add proper lock protection to usb_kill_urb() calls that can
> possibly run concurrently with usb_kill_anchored_urbs().
> 
> Reported-by: syzbot+89bd486af9427a9fc605@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?id=cabffad18eb74197f84871802fd2c5117b61febf
> Signed-off-by: Brooke Basile <brookebasile@gmail.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

03fb92a432ea ath9k: hif_usb: fix race condition between usb_get_urb() and usb_kill_anchored_urbs()

-- 
https://patchwork.kernel.org/patch/11769845/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

