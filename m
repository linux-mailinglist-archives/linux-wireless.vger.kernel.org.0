Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2CD40C3EC
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Sep 2021 12:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbhIOKst (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Sep 2021 06:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbhIOKst (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Sep 2021 06:48:49 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75FEC061574
        for <linux-wireless@vger.kernel.org>; Wed, 15 Sep 2021 03:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=eWHoA9HNzXpPkmvdZUKZsiAXv900IyJN82Br85TVsAg=;
        t=1631702850; x=1632912450; b=iUehqBqcIkczqtPBGIFol9IA7erbykSVKcFwfAPJVDPcSoj
        U38SSSRct85Be6OsLg4O7Z7vjnWoflv6179OVAJSzMi/K65my/9PwTrxK5yJYIoDMHHuTuf39vKen
        lt7RWmMcEfNVJj2urYE66VJhXfTXhs0GTiKMPbHX3cNO9i6shLJU141RDr+8pkHWqmYaX7cGKhLH7
        FASrZOu1hT6wmrgZGXrQXrbYTRSYh9MMWmfmfSv8lkZxqyAqt1iANFAxlBI+w3l4j7ShgVsU1ffUr
        hbMfXLQGBImevwd5nau78qsD+2PJzx09/AcZa0qr3pLATfFxdih6uN6HQU351sRg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95-RC2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mQSRt-007G5Q-1k;
        Wed, 15 Sep 2021 12:47:29 +0200
Message-ID: <4c5314e8d15565759fec3edf0729e8d4f2e28319.camel@sipsolutions.net>
Subject: Re: [PATCH v11 0/4] multiple bssid and EMA support in AP mode
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <alokad@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 15 Sep 2021 12:47:28 +0200
In-Reply-To: <8263a758863ac8fcd2d4ae6b36668bc8@codeaurora.org>
References: <20210715070745.5033-1-alokad@codeaurora.org>
         <849e2cf64fbf774fec9c30003e828aaf2d12a6d7.camel@sipsolutions.net>
         <8263a758863ac8fcd2d4ae6b36668bc8@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2021-09-14 at 20:47 -0700, Aloka Dixit wrote:
> On 2021-08-17 03:35, Johannes Berg wrote:
> > On Thu, 2021-07-15 at 00:07 -0700, Aloka Dixit wrote:
> > > This patchset adds support for multiple BSSID and
> > > enhanced multi-BSSID advertisements for AP mode.
> > > Individual patches describe the changes in this version.
> > 
> > How about adding the trivial advertisement to hwsim so we can have some
> > tests in hostapd?
> > 
> > johannes
> 
> Hi Johannes,
> Yes, I plan to add hwsim advertisement separately once kernel
> changes are accepted. Will also add hostapd testcases at the
> same time.

OK, great! But adding it in hwsim is a kernel change, so why not just
send that patch together?

johannes

