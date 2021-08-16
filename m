Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEF13EDA91
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Aug 2021 18:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbhHPQKf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Aug 2021 12:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhHPQKf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Aug 2021 12:10:35 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96ADBC061764
        for <linux-wireless@vger.kernel.org>; Mon, 16 Aug 2021 09:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=bLe8VXQq482OGSx7yyb+cSm/119tdxc4SX0i99iZbLI=;
        t=1629130203; x=1630339803; b=l6tbcsymvk0OXRYnEP8tA9G7FuK45GE7Ga3YOnXgxeKZdVJ
        E8PMFrpVXUJcOWF0TBJMoMfzvjDw3zLIvBO4B8iTXm1TnyLpAfi+8KEWg2G1nW3QXmPNw4PLtanqZ
        NNOtFoPVBH1iBpEgLkk9eoQO4DCPX/LLg6n01EZLyIkvF1mgspm3mISs3cTNGO4dv1eqmqHZrs4AK
        TzqCcJLOgotYJnKoQsbwc4bfCcNR7c6UL1OVLwzhExWxszBiTuFvK5ptdvbN5dwqFXyo8tuGlJ4Lm
        +FhnnC16PoMYVgX8kMu0SuC528ybMkoYnL8A2NpANpVzcIh0VG7NT81iw4s+kQ7Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mFfBZ-00BsqV-PH; Mon, 16 Aug 2021 18:10:01 +0200
Message-ID: <dd83ba70fd669b6bd5825b745e07ab331ba7184f.camel@sipsolutions.net>
Subject: Re: iwlwifi: OFMDA Sniffer not capturing actual data
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Milo Garcia <ing.eagm@gmail.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 16 Aug 2021 18:10:01 +0200
In-Reply-To: <CAAZjYumZQJud7y0nVXhO5RLCrx=MF3hLEv9T7U0bAWw=63WoKw@mail.gmail.com>
References: <CAAZjYunwQ5UtjJuvrBNWU9qTf72WMRjoaYD+mgn7OaqmXXZ+fw@mail.gmail.com>
         <aa62f2ff1ae79089d63f25c3b215f7ed7196ae15.camel@sipsolutions.net>
         <CAAZjYumZQJud7y0nVXhO5RLCrx=MF3hLEv9T7U0bAWw=63WoKw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2021-08-16 at 18:04 +0200, Milo Garcia wrote:
> > What exactly are you seeing?
> https://imgur.com/N7DdDS3
> 
> I was expecting to see the data in the RU but Wireshark only shows
> packet length of 86 bytes

oh, but that's not the *data*, that's the RU allocation information.

Looks like we don't report that for 0-length PSDU, not sure, probably
the DSP doesn't propagate it if there was nothing for the AID you
configured, or so.

johannes

