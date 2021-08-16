Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9794A3EDCBB
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Aug 2021 20:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbhHPSB2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Aug 2021 14:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232165AbhHPSB1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Aug 2021 14:01:27 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4CEC0613CF
        for <linux-wireless@vger.kernel.org>; Mon, 16 Aug 2021 11:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=fy+XSd4c1g3JehejpC/XclvscNcJ0LAVSRTnEHJ5EG8=;
        t=1629136856; x=1630346456; b=bYLVy3AJ/D1/2FBz5rup/ffIHFKVYi2+uwGo4l6+UwpMPJu
        W329YiFgKpETv477La+fRFZrt5cs9XAJHWjxuOsrjMht4t/qk5dP96AstKezIZNtSu4xzsFfj5fuJ
        T1lTRoxmVRzI+0rGkOvAvfc/bG1rcLlTVQ9c2med2qL93+tveqSLW1GnHWqaOBVytHpgWSCYHmmQQ
        CpVkM72bHckbIT2+VfXH09w06Fglk4hVPVVzx8tCGPTE3Y3+bc6RoxqPVgYycNYJ5PASitpcuf8yM
        BOaGolqe/iJdeg9IivVBezkGVIb0PCLQcZckw330Dqgh/SAANTzz6dzgN94w8/hg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mFgur-00BvHX-CP; Mon, 16 Aug 2021 20:00:53 +0200
Message-ID: <f234ab236affd3bc305d18218a83dc8e50028123.camel@sipsolutions.net>
Subject: Re: iwlwifi: OFMDA Sniffer not capturing actual data
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Milo Garcia <ing.eagm@gmail.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 16 Aug 2021 20:00:52 +0200
In-Reply-To: <CAAZjYukkV0iZ=94CtpqfhAiYUV4uK=HtKW9uMLyJi12ODWbtjA@mail.gmail.com>
References: <CAAZjYunwQ5UtjJuvrBNWU9qTf72WMRjoaYD+mgn7OaqmXXZ+fw@mail.gmail.com>
         <aa62f2ff1ae79089d63f25c3b215f7ed7196ae15.camel@sipsolutions.net>
         <CAAZjYumZQJud7y0nVXhO5RLCrx=MF3hLEv9T7U0bAWw=63WoKw@mail.gmail.com>
         <dd83ba70fd669b6bd5825b745e07ab331ba7184f.camel@sipsolutions.net>
         <CAAZjYukkV0iZ=94CtpqfhAiYUV4uK=HtKW9uMLyJi12ODWbtjA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2021-08-16 at 18:26 +0200, Milo Garcia wrote:
> > oh, but that's not the *data*, that's the RU allocation information.
> > 
> > Looks like we don't report that for 0-length PSDU, not sure,
> > probably
> > the DSP doesn't propagate it if there was nothing for the AID you
> > configured, or so.
> ok, so if that is the allocation and we are getting 0-length PSDU,
> then it means that I am sniffing with the wrong AID?
> 
> In practice then I will just need to select an AID to which data is
> being sent and then I will be able to see the HE_MU Data?

I think so. And also the data that was sent to that AID.

All only as long as the NIC is actually in sniffer mode, of course.

johannes

