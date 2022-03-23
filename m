Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACB04E52D9
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Mar 2022 14:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244183AbiCWNO3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Mar 2022 09:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244179AbiCWNO3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Mar 2022 09:14:29 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B517CDD3
        for <linux-wireless@vger.kernel.org>; Wed, 23 Mar 2022 06:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=SPmip9lMpVmYgjfGDBnQfDgtMXFGYCGm5aOrddI6sro=;
        t=1648041178; x=1649250778; b=XcvvAPYhGWm6zBtH94ZgzQu+Wm+WtsV6Bhn/vmNjxnEqh9E
        jgbvuOlQE5Zc4fWn7XR27j3TtK3JzliBQfvLrBcNrJ3/44pWpD3fVjlo6kRJREhuCMwVy/OdJqZzV
        b9g9+HmPlmVabbKsw86BGNdOffFxW/j9l68p/cPj/dCm+vlu1y8pDajoMDJlHg+UX8MdApQJcTFrU
        vedLFEVdhdSD4876YVXC6jWi+VbtTNis8/09nHteM9rs+2ibKgJDqbL7Qcd0WdM/JBYbJsI72GKm5
        w+4OYDsKvVbJzcL7YDTM9u0Cpk3TH25HjhFxZu7zwXkcLRnRlFC0gZfsKJ8DKgvA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nX0nJ-00H5tS-02;
        Wed, 23 Mar 2022 14:12:57 +0100
Message-ID: <326fa784a7bd10ed80a13e8734c51e48db1c9cde.camel@sipsolutions.net>
Subject: Re: Intel AX200 Not Working in 5.15+
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Robert Joslyn <robert.joslyn@redrectangle.org>,
        linux-wireless@vger.kernel.org
Date:   Wed, 23 Mar 2022 14:12:56 +0100
In-Reply-To: <ec6187952e1456a6b6efd9c4bb697eecf4fe9c19.camel@redrectangle.org>
References: <ec6187952e1456a6b6efd9c4bb697eecf4fe9c19.camel@redrectangle.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, 2022-02-27 at 17:21 -0800, Robert Joslyn wrote:
> I have laptop with an Intel AX200 Wi-Fi controller and everything works
> fine in a 5.14 kernel, but in 5.15 or later, the adapter does not work
> most of the time. In maybe 9 out of 10 boots in 5.15+, the wlan0
> interface does not get created. The hardware is detected and shows up
> in lspci, the iwlwifi driver is loaded, but no interface is created.

Do you see any deadlocks? Stuck tasks? Is the machine usable at this
point? Can you run "ip link" commands etc.?

It seems weird that such an obvious locking problem would have an "only"
90% failure rate...

> If I remove the call to rtnl_lock and rtnl_unlock added in those
> commits from 5.17.0-rc4, everything works again (but dmesg has a bunch
> of RTNL assertion failures from the missing lock). I assume there is a
> race or deadlock somewhere, but I've not been able to find it. I'm not
> at all familiar with this part of the kernel so perhaps that's not
> surprising :-)
> 
> Any thoughts as to what might be going wrong or suggestions on further
> debugging?
> 

See above - and maybe you can have lockdep in the kernel?

johannes
