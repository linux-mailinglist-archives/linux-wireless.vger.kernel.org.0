Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F121673B07
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jan 2023 15:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbjASODM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Jan 2023 09:03:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbjASODJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Jan 2023 09:03:09 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA157E4BD
        for <linux-wireless@vger.kernel.org>; Thu, 19 Jan 2023 06:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=tO2mv6zDdENUjSDZ19YwiIs1l98gAiiQ0I/1yF2xPuo=;
        t=1674136959; x=1675346559; b=nMjjmZsebWYpxcByYsjFZJknWkBPsnmOf5QA5HZW2Cy2dwE
        /K+CItN90Bn7qvL/6x30rljITeqC8yRe0OFCy86QZvlZlTb+Dm4VkW0ucsvqSEZFL0ZVjHY5iEhTM
        KQ8+IeY8ii2f4NBldvNO/yE0RObjroqrqcBdqBCW17Mnm/Uzv8rS4DV01X27lmMQkaDtORqtuFeIS
        e53P8A6+XwYnuXArGY0Y8kD6zz+fKdO+RtUBBeaboLryu3IjzvJbo51eOef7D2LNiC+geyz9cPu6E
        jcxtY9J4Xz7xK9s1qNMXd9sfj1sZuVrYja8o+YsER8tevqvydFPghV9D7NUjiN2A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pIVUl-006X7C-1z;
        Thu, 19 Jan 2023 15:02:23 +0100
Message-ID: <74c57dc34af10537f98f5bb9b6ce80e5676e09b0.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] nl80211: add support to enable/disable bss color
 collision detection
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 19 Jan 2023 15:02:22 +0100
In-Reply-To: <20221226083328.29051-2-quic_ramess@quicinc.com>
References: <20221226083328.29051-1-quic_ramess@quicinc.com>
         <20221226083328.29051-2-quic_ramess@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2022-12-26 at 14:03 +0530, Rameshkumar Sundaram wrote:
> As per 802.11ax-2021, STAs shall process BSS Color Change Announcement
> (BCCA) from AP and switch to new color, but some STAs aren't processing
> BCCA from AP and not doing color switch, causing them to drop data
> frames from AP post color change.
>=20
> Provide an option to disable color collision detection and therefore
> not to do BCCA to mitigate the same from AP. If it's required in case
> where STA supports BCCA handling, then it can enabled in AP using this
> option.
>=20

You should probably split this into cfg80211 and mac80211.

Also, this doesn't really seem to make a lot of _sense_ since nothing in
the kernel actually acts on detection of a color collision - hostapd is
acting on that.

So since you can easily make hostapd ignore the event, why do you even
need this?

johannes
