Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562EE4A9B0E
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Feb 2022 15:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359350AbiBDOeh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Feb 2022 09:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233084AbiBDOeg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Feb 2022 09:34:36 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8113AC061714
        for <linux-wireless@vger.kernel.org>; Fri,  4 Feb 2022 06:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=3yRUhvoCuCe6t1zwhVrcDBPFiXUWr7uCbTOSuyvdOc4=;
        t=1643985276; x=1645194876; b=Yc3yvRc+rmb71LSstMJ2s5HRT3bnK4Ktw/7naagcokIppRK
        sc2pd4q2VEE1QrCiVpNf6hG8lqDaNZHsab5YfnyC41Ar1HPD1luSY7pcmIZyDWa8yB7dVHb9ui3pF
        dcgKQwe7lR3vXyV0mmdEYmGB3qu6SCgPfPPainxb72GHnZZfYZW1SKS5CYTP/uUvs+uOIA9B90DLN
        iMH7znLebJk3ZbbAJDqIRL9IMBZ5BlLzHNqiNtTD6uGu5nN2M4YP4P6y8oPha8gcOueTWs11SNF+N
        b7ddOIT7jD000135eBZGKNMD+MBl0BpJ3cSma3QVyd5qQx2id5hLEY6SQXs6R/XQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nFzfW-00EVoy-1V;
        Fri, 04 Feb 2022 15:34:34 +0100
Message-ID: <f0bd183125c2773afbfc9563cb4949ad055b7075.camel@sipsolutions.net>
Subject: Re: Fw: Regression/boot failure on 5.16.3
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jason Self <jason@bluehome.net>, linux-wireless@vger.kernel.org
Date:   Fri, 04 Feb 2022 15:34:33 +0100
In-Reply-To: <20220204061104.5851831a@valencia>
References: <20220204061104.5851831a@valencia>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> 
> The computer (amd64) fails to boot. The init was stuck at the
> synchronization of the time through the network. This began between
> 5.16.2 (good) and 5.16.3 (bad.) This continues on 5.16.4 and 5.16.5.
> Git bisect revealed the following. In this case the nonfree firmwre is
> not present on the system. Blacklisting the iwflwifi module works as a
> workaround for now.
> 
> 6b5ad4bd0d78fef6bbe0ecdf96e09237c9c52cc1 is the first bad commit
> commit 6b5ad4bd0d78fef6bbe0ecdf96e09237c9c52cc1
> 

I checked out this commit and ran a test with no firmware present, but
couldn't reproduce any crash.

Could you take a picture when it crashes? Perhaps boot without 'quiet'
on the command line, or boot into recovery mode or such where you
actually see the output?

johannes
