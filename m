Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7945D442D76
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Nov 2021 13:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbhKBMGZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 Nov 2021 08:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbhKBMGX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 Nov 2021 08:06:23 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B748BC061714
        for <linux-wireless@vger.kernel.org>; Tue,  2 Nov 2021 05:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=h86VFtteEYl1f49xP1kVJB7134MIOfx/y5uzcAuQtDM=;
        t=1635854628; x=1637064228; b=Y1rI2R33dAVVM9VMRTFMaotwUNuTd3RHsMuDB2pV/IK5o+A
        TKbdwvW1y41ABqGWx/hcZ/o3iG5IZ5/5HtxInQv4uCW3/IlDjGtOFYIONEmVXrZnFzfJ9rWNGj5LA
        6vUd/CtY2GSilp3U01PbHtfBhy6imvmdSk/Da9VunfLRIbtb+HJ05F86FSTKmS4zCUt91Er7WAc07
        pPLNn0HANTgI2ZlJv4PmO4hHMUygEWM9Y18Q+A5f2nM8UPYfhyXmgJfdNeuOJWNzR2t6I1k2fJQkA
        pPFg493ATXhmBZtHi0onO0XT/V1Jw5iszi9zRx8QhzLiOq+ctLA2T+fkhB0+1a1A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mhsW2-009zp3-HQ;
        Tue, 02 Nov 2021 13:03:46 +0100
Message-ID: <4e39709c536e3b3c533a55f0bd4a536c49de8b34.camel@sipsolutions.net>
Subject: Re: [PATCH] nl80211: fix radio statistics in survey dump
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Sven Eckelmann <sven@narfation.org>, linux-wireless@vger.kernel.org
Cc:     Jan Fuchs <jf@simonwunderlich.de>
Date:   Tue, 02 Nov 2021 13:03:45 +0100
In-Reply-To: <2007334.cWPf2AUjKI@ripper>
References: <20211029092539.2851b4799386.If9736d4575ee79420cbec1bd930181e1d53c7317@changeid>
         <2494935.OLRZgKR7aK@ripper> <2007334.cWPf2AUjKI@ripper>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2021-11-02 at 12:12 +0100, Sven Eckelmann wrote:
> 
> Sorry, wanted to write more about it last week but forgot about it. If I
> basically filter out the upper 32 bit in mvm->radio_stats.on_time_rf then it 
> didn't look that bad on a AX210. It seems like the upper bits is sometimes 
> 0x00000001 for unknown reasons. Like it would be some kind of flag which 
> should indicate some kind of change/event. So maybe the firmware team could 
> check what this means.

Well, I checked, and it *is* just a u64 value.

However, I suspect it sometimes underflows when powersave time is
accounted into it, or something?

johannes

