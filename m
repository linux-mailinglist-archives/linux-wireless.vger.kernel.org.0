Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2617F41632B
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Sep 2021 18:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242135AbhIWQ0h (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Sep 2021 12:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242117AbhIWQ0f (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Sep 2021 12:26:35 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE13C061574
        for <linux-wireless@vger.kernel.org>; Thu, 23 Sep 2021 09:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=3M/yF4tCbpXryxf3K6u+YHqyPlX4SwshdQnE4FL6Cyo=;
        t=1632414304; x=1633623904; b=NY4wFFVfklP0TM1ut5XQwxgF3zdFUEtrUIrdMnkqFR+naFw
        XjNX7TR/RsKQqv9FMPDUIfqCghqDSJ7lWMUnpiGi/J0gs+so/VyknGR3ziN7cNkKpjzv74zk1ML8J
        DtXaphSrYuq/YHBbryRoBb9rx5/kiWvrlHZoZ3A5o9R4mryy66d+h4ShSZ/rP1Mu79Y5sO40LB+KF
        6JdhwB/vXuJVWClaCSTY9uf8i+6rqlo3E+vZVN2zRhV8iti7CGmKIkOyv2MiS0gq6vkqXFH1AUg5w
        a6FN2oA3mIVMUjsqXfCh6/XaVVhmN/vEgPp+xG9CX5Dd1omDG7coSOZGhoJA9LlA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95-RC2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mTRWw-00AoiG-Eg;
        Thu, 23 Sep 2021 18:25:02 +0200
Message-ID: <e6b516a1ff05aaf46d3a5b2e12a219a557c82642.camel@sipsolutions.net>
Subject: Re: [PATCH iw 1/4] iw: nl80211: add NLA_F_NESTED to
 nla_nest_start() with older libnl versions
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Gokul Sivakumar <gokulkumar792@gmail.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 23 Sep 2021 18:25:01 +0200
In-Reply-To: <20210923162354.GB3812520@lattitude>
References: <20210910141618.1594617-1-gokulkumar792@gmail.com>
         <10ea557f9dfdf92083b9816d7370926e4222f333.camel@sipsolutions.net>
         <20210923155308.GA3760174@lattitude>
         <64776c93e7f98c34821042b6864e81b7c3ab6443.camel@sipsolutions.net>
         <20210923162354.GB3812520@lattitude>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2021-09-23 at 21:53 +0530, Gokul Sivakumar wrote:
> On Thu, Sep 23, 2021 at 05:56:40PM +0200, Johannes Berg wrote:
> > On Thu, 2021-09-23 at 21:23 +0530, Gokul Sivakumar wrote:
> > > The symbol NL_CAPABILITY_VERSION_3_5_0 is part of the libnl library and
> > > this will be defined when using the libnl library version >= 3.5.0.
> > > From libnl 3.5.0, the library itself handles setting NLA_F_NESTED flag
> > > when using nla_nest_start() lib function. Please refer the
> > > commit 7de65a0 ("attr: mark nested attributes as NLA_F_NESTED") in libnl
> > > gitub tree (https://github.com/thom311/libnl/commit/7de65a0).
> > > 
> > 
> > Huh ok, I guess I missed the memo on the (official?) tree moving ...
> > 
> > johannes
> > 
> 
> I beleive https://github.com/thom311/libnl/ is the official tree for libnl
> and I see Pull Requests are getting accepted in Github. Others can confirm!

Yeah, debian seems to be shipping from that tree too.

johannes

