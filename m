Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C22DC5C853
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2019 06:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbfGBE0Y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 Jul 2019 00:26:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46812 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbfGBE0Y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 Jul 2019 00:26:24 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A0DDE607CA; Tue,  2 Jul 2019 04:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1562041583;
        bh=YSdh6V8PtLxekYrCt+JmLsR1cBK83DOlcHyKX8k+NOA=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=Yti+xKcvmnEYuCCx/AZwzCe2FewT/t2cBTIIVqBlRdwckhPwq0bEDwKITAHYClnRI
         0jRoAfUP/VD8sMZ+uqS/8WwSptDO+u67ZdP0KwmcBDmwBz4apZtkUu1siLG8R97Zl3
         kqJczN1VHJL9S6kQkqfyH3FYa2Va8aEXGBR11SKk=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from dundi (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: dundi@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3AF3E604D4;
        Tue,  2 Jul 2019 04:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1562041583;
        bh=YSdh6V8PtLxekYrCt+JmLsR1cBK83DOlcHyKX8k+NOA=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=Yti+xKcvmnEYuCCx/AZwzCe2FewT/t2cBTIIVqBlRdwckhPwq0bEDwKITAHYClnRI
         0jRoAfUP/VD8sMZ+uqS/8WwSptDO+u67ZdP0KwmcBDmwBz4apZtkUu1siLG8R97Zl3
         kqJczN1VHJL9S6kQkqfyH3FYa2Va8aEXGBR11SKk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3AF3E604D4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=dundi@codeaurora.org
From:   <dundi@codeaurora.org>
To:     "'Stephen Rothwell'" <sfr@canb.auug.org.au>,
        "'Kalle Valo'" <kvalo@codeaurora.org>,
        "'Wireless'" <linux-wireless@vger.kernel.org>
Cc:     "'Linux Next Mailing List'" <linux-next@vger.kernel.org>,
        "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
References: <20190702073306.3bd439ab@canb.auug.org.au>
In-Reply-To: <20190702073306.3bd439ab@canb.auug.org.au>
Subject: RE: linux-next: Fixes tag needs some work in the wireless-drivers-next tree
Date:   Tue, 2 Jul 2019 09:56:18 +0530
Message-ID: <000a01d5308e$4dcb0e20$e9612a60$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQI9opsM3NZaPdwZufNLc2Z1a/FxMaXl1lxw
Content-Language: en-us
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Stephen,

You are correct, Its
Fixes: ba94c753ccb4 ("ath10k: add QMI message handshake for wcn3990 client")

My bad, I added last 12 digits instead of first 12 digits of SHA1.

Regards,
Dundi

-----Original Message-----
From: Stephen Rothwell <sfr@canb.auug.org.au> 
Sent: Tuesday, July 2, 2019 3:03 AM
To: Kalle Valo <kvalo@codeaurora.org>; Wireless
<linux-wireless@vger.kernel.org>
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>; Linux Kernel
Mailing List <linux-kernel@vger.kernel.org>; Dundi Raviteja
<dundi@codeaurora.org>
Subject: linux-next: Fixes tag needs some work in the wireless-drivers-next
tree

Hi all,

In commit

  c709df58832c ("ath10k: Fix memory leak in qmi")

Fixes tag

  Fixes: fda6fee0001e ("ath10k: add QMI message handshake for wcn3990
client")

has these problem(s):

  - Target SHA1 does not exist

Did you mean

Fixes: ba94c753ccb4 ("ath10k: add QMI message handshake for wcn3990 client")

-- 
Cheers,
Stephen Rothwell

