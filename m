Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09A5B3A7C33
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jun 2021 12:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbhFOKnG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Jun 2021 06:43:06 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:48812 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231469AbhFOKnE (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Jun 2021 06:43:04 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623753660; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=vDtGoG4ESr3xkYa9OGgjFSeF8fMq4d5QmvhAIKTqziQ=;
 b=CIoJ8JTNbIkKDzlwdHuWTM+d6GSOlg+PX3/qH/CkXYyAy+zPHE4OyzTeE7ptNQadCFyFuZP6
 Grzp8pMlinjFBoF5vQIm0yqx6ZYzi2o6G4/WHx3JkkYOyEcLYpoaVVqgBx6yyZLvHzP6Bz+g
 nygvcgTxBwD4m1KiyA/MZMaqhD4=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 60c883a9e27c0cc77f281349 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 15 Jun 2021 10:40:41
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F10DEC43217; Tue, 15 Jun 2021 10:40:40 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 426AAC433F1;
        Tue, 15 Jun 2021 10:40:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 426AAC433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: brcmsmac: improve readability on addresses copy
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210511070257.7843-1-ihuguet@redhat.com>
References: <20210511070257.7843-1-ihuguet@redhat.com>
To:     =?utf-8?b?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210615104040.F10DEC43217@smtp.codeaurora.org>
Date:   Tue, 15 Jun 2021 10:40:40 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Íñigo Huguet <ihuguet@redhat.com> wrote:

> A static analyzer identified as a potential bug the copy of
> 12 bytes from a 6 bytes array to a 6 bytes array. Both
> arrays are 6 bytes addresses.
> 
> Although not being a real bug, it is not immediately clear
> why is done this way: next 6 bytes address, contiguous to
> the first one, must also be copied to next contiguous 6 bytes
> address of the destination.
> 
> Copying each one separately will make both static analyzers
> and reviewers happier.
> 
> Signed-off-by: Íñigo Huguet <ihuguet@redhat.com>

Patch applied to wireless-drivers-next.git, thanks.

c0277e25d28f brcmsmac: improve readability on addresses copy

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210511070257.7843-1-ihuguet@redhat.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

