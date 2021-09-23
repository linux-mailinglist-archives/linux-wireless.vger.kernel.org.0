Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A02D341628B
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Sep 2021 17:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242263AbhIWP6Q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Sep 2021 11:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242239AbhIWP6P (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Sep 2021 11:58:15 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7393FC061574
        for <linux-wireless@vger.kernel.org>; Thu, 23 Sep 2021 08:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=94l6H5wQs13Y2THDXFSFcQcV6To/tRs3WjPuvJ5LWD0=;
        t=1632412603; x=1633622203; b=cFMRj45stlWU72yxwY4iQxq7989nWSiVAKnDrsJ/G0UhwQu
        3S5tZRWps7eL/hXpMgq60jXtrDycNTCaHSxotYdfY4/hZKfyR/PrZTA/LuYdZ2BCqy3VZBgFEL+co
        /XBxEPcMhmlalMttkwJT82dcyc8LPYCC8puwf3rFcdK9p9l473tkaNzdmbUec6h50pvaHe4prEXI6
        7QPMyqHiosuRiytfsftJiKSq1YvIt6GkL6m1JdjOwVtRv1h+A+hpBpY7hxrekwxUmD3rqAJHJ/6MZ
        T4bb6xtvOXFR+EI6epG4hYIEE7GMKohmKG0qByg6HB39ZCMt3q5luG0Txc9lMysg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95-RC2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mTR5V-00Anuw-7b;
        Thu, 23 Sep 2021 17:56:41 +0200
Message-ID: <64776c93e7f98c34821042b6864e81b7c3ab6443.camel@sipsolutions.net>
Subject: Re: [PATCH iw 1/4] iw: nl80211: add NLA_F_NESTED to
 nla_nest_start() with older libnl versions
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Gokul Sivakumar <gokulkumar792@gmail.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 23 Sep 2021 17:56:40 +0200
In-Reply-To: <20210923155308.GA3760174@lattitude>
References: <20210910141618.1594617-1-gokulkumar792@gmail.com>
         <10ea557f9dfdf92083b9816d7370926e4222f333.camel@sipsolutions.net>
         <20210923155308.GA3760174@lattitude>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2021-09-23 at 21:23 +0530, Gokul Sivakumar wrote:
> The symbol NL_CAPABILITY_VERSION_3_5_0 is part of the libnl library and
> this will be defined when using the libnl library version >= 3.5.0.
> From libnl 3.5.0, the library itself handles setting NLA_F_NESTED flag
> when using nla_nest_start() lib function. Please refer the
> commit 7de65a0 ("attr: mark nested attributes as NLA_F_NESTED") in libnl
> gitub tree (https://github.com/thom311/libnl/commit/7de65a0).
> 

Huh ok, I guess I missed the memo on the (official?) tree moving ...

johannes

