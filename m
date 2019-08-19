Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3589291CD9
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2019 08:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfHSGG2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Aug 2019 02:06:28 -0400
Received: from mail.kapsi.fi ([91.232.154.25]:42703 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbfHSGG1 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Aug 2019 02:06:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References
        :In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=QrRTUIO5SSrV2cx2Gh2fDWiFfV5dRDRQV9nQULTcTvg=; b=xn5KYuNlGfTBZIqk5oEYIPg/Cx
        x8gw+a+JxtKP5x9SwfCj026d1pwRyc/Qtp16rShdE3MK+w7b5Vx5BjIPnQarEono1Um353Sl/6QNF
        RZEpH/0zJoB8amcp3Ht7+/0zdFsw9h548CJXGHiR8ONuWBmG0RdHsnZg3zXMIkMuLeSqNbGM3Rb4L
        hFZDDWAio0jVviR/UqBA6CJ0ybEHIfFpvBhlyxEhleBbL6UuXUnkBn74zqNiLzQKahc0Acd4eGmaT
        Ryhfw5X31NAMx32WBpZYJ1p1Omm8MbtDzoRObVTSbigOHET3cyjrplZeEZbnygTTgIZ5oyutcVzpL
        3Tj5iaww==;
Received: from dsl-hkibng41-56730e-69.dhcp.inet.fi ([86.115.14.69] helo=lettuce)
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <jekarl@iki.fi>)
        id 1hzao9-0001od-7W; Mon, 19 Aug 2019 09:06:21 +0300
Date:   Mon, 19 Aug 2019 09:06:19 +0300
From:   Emil Karlson <jekarl@iki.fi>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org
Subject: Re: Ap mode regression in linux-5.3-rc1 in rt2800usb
Message-ID: <20190819090619.54f523cb@lettuce>
In-Reply-To: <20190816093302.GA2158@redhat.com>
References: <20190813215000.6cc27ade@lettuce>
        <20190814085018.GA29199@redhat.com>
        <20190816110012.63982001@lettuce>
        <20190816093302.GA2158@redhat.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 86.115.14.69
X-SA-Exim-Mail-From: jekarl@iki.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi

On Fri, 16 Aug 2019 11:33:02 +0200
Stanislaw Gruszka <sgruszka@redhat.com> wrote:

> > > > After upgrading my ap running rt2800usb to linux-5.3-rc1 I
> > > > noticed an unusual problem of not being able to connect to my
> > > > ap with my android devices (nexus7/flo and nexus5x/bullhead),
> > > > from tcpdump it seemed ap was receiving packets from the
> > > > android devices after successful association, but android
> > > > devices were not seeing the dhcp replies.
> > > > 
> > > > I reverted drivers/net/wireless/ralink to the state it is in
> > > > v5.2.8 and android clients can connect again normally. I did not
> > > > explicitly set watchdog parameter to any value.
> > 
> > > Most suspicious are 710e6cc1595e and 41a531ffa4c5 .
> > 
> > It seems to me that reverting only
> > 710e6cc1595e25378c4b9977f7a8b4ad4a72a109
> > allows all my android devices to successfully connect to the
> > internet.
> 
> Please test attached patch as proposed fix for
> 710e6cc1595e25378c4b9977f7a8b4ad4a72a109 and report back. Thanks.

After some testing it seems attached patch fixes the regression with no
observed negative side effects. Thanks.

Best Regards
-Emil
