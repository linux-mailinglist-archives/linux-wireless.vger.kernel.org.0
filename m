Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB893EDA19
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Aug 2021 17:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbhHPPor (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Aug 2021 11:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236637AbhHPPop (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Aug 2021 11:44:45 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE7DC06179A
        for <linux-wireless@vger.kernel.org>; Mon, 16 Aug 2021 08:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=7RwvPakb32FoC9CoEoRsic/KE2fciXfycNs7oDBCXZ4=;
        t=1629128654; x=1630338254; b=gL67O/kWStTvrq1ZTTpDxDawla6o4yNiy7tuNmNIaRP3wmc
        MTtHeBUkqAArNSsWS1dGOJeRcdL1zOr9EGw2prdu1CuBmDjb7L4UhiO63WN1NWJ8giEwDDiYUtQzf
        unYJWvrIRVoqDw41/pQ99VEsjGkQDL+qrLTeDLI3U8wLEBnFjfztGhIBBBVzTK/Ux08sVw4avqv0k
        JdEkeKDm0lNCf3ZspREsJN2SF2FWtXqAZpiiaXE4qhOFsMVAstNmfnlfP9rxOFIueDAQAfeG2wPs5
        7kp6NdJqVk4YduogE1RZc4ebq1MwEQ2yAX1/TcQgMjF3+ALQl11xIlYd860z720w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mFemZ-00BsM3-Ns; Mon, 16 Aug 2021 17:44:11 +0200
Message-ID: <aa62f2ff1ae79089d63f25c3b215f7ed7196ae15.camel@sipsolutions.net>
Subject: Re: iwlwifi: OFMDA Sniffer not capturing actual data
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Milo Garcia <ing.eagm@gmail.com>, linux-wireless@vger.kernel.org
Date:   Mon, 16 Aug 2021 17:44:10 +0200
In-Reply-To: <CAAZjYunwQ5UtjJuvrBNWU9qTf72WMRjoaYD+mgn7OaqmXXZ+fw@mail.gmail.com>
References: <CAAZjYunwQ5UtjJuvrBNWU9qTf72WMRjoaYD+mgn7OaqmXXZ+fw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2021-08-16 at 17:34 +0200, Milo Garcia wrote:
> 
> I am able to see HE_MU packets but they don't contain the actual data
> in the RUs. Wireshark says "NOT CAPTURED BY CAPTURE SOFTWARE"

That *should* work, for the AID you specified.

What exactly are you seeing?

johannes

