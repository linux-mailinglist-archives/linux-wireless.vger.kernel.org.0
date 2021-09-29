Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB4341C031
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Sep 2021 09:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244268AbhI2IBT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Sep 2021 04:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243331AbhI2IBS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Sep 2021 04:01:18 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F326AC06161C
        for <linux-wireless@vger.kernel.org>; Wed, 29 Sep 2021 00:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=2ZKp51s15uoNIFh+hvjd+EX+5UY0Wg1Fop4dUszImz0=;
        t=1632902378; x=1634111978; b=lPO8NDxyqfVm9vrS0b+T2jIP18GYT2dNLQM+5PmPZwXUDOi
        FluopcrM8c3dSrIzGjIUzt1p74WeoNOwsMW7fPzvJ09ZctgwfSZKxIbT6R493VQM+Oo38lgdOkw6J
        qhqkzBfETzcMV+P64/6BNVOAhjun+iV8IVgiJlSaPIZmJXkC9OFl/F0Xd2houaRb0/+MqDueuC0jj
        057jTngPOijzqO0BtJiMY22l9Nnljb+7R+Td5p/laCLszqYa7BI2dz5rAHA/S2Etw17JOLW5el6vb
        Il7fvENbl6Zt+qe0zoDEOgvqliKndmWH9ku3Y2m7RjZoZcOqpKq+kcTFo9PsWWkg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95-RC2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mVUV5-00DEIs-Gg;
        Wed, 29 Sep 2021 09:59:35 +0200
Message-ID: <7d5f49ca19369d3ed53faf14be07816d98690bf6.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 1/1] Add control path virtualization in virt_wifi
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Guillaume Hetier <Guillaume.Hetier@microsoft.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "schuffelen@google.com" <schuffelen@google.com>,
        Shwetha Bhat <shwbhat@microsoft.com>,
        Andrew Beltrano <anbeltra@microsoft.com>,
        Brian Perkins <Brian.Perkins@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Matteo Croce <mcroce@microsoft.com>
Date:   Wed, 29 Sep 2021 09:59:34 +0200
In-Reply-To: <MWHPR21MB1547EB364EFA35799C3B69A38FA89@MWHPR21MB1547.namprd21.prod.outlook.com>
References: <MWHPR21MB1547EB364EFA35799C3B69A38FA89@MWHPR21MB1547.namprd21.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2021-09-28 at 20:44 +0000, Guillaume Hetier wrote:
> Hi,
> 
> > Are there any specific applications you're thinking of?
> 
> Our main targets are programs setting up IOT devices: we want to give
> the guest the capacity to connect to specific networks created by the
> IOT device for the duration of their setup.
> For that, we want to be able to scan, connect and reflect network
> properties precisely enough to let the guest programs go forward with
> the setup.


Makes sense. But are there such tools on Linux today? And if so, how do
they work? I certainly haven't seen one on a general purpose Linux,
obviously Android is a different matter (and if you wanted to support
Android you could have a special network manager that mostly defers to
the host)

> We would like to make our solution as generic as possible to be
> extendable and potentially support for complex use cases if possible,
> but we are not aiming for generic network management from the guest.

:)

johannes

