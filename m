Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59BF4673CD6
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jan 2023 15:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjASOzJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Jan 2023 09:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbjASOyx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Jan 2023 09:54:53 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A436974EA8
        for <linux-wireless@vger.kernel.org>; Thu, 19 Jan 2023 06:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=pbS/bX9VJ8VmQVK8TpueUPlWivBwz9nNw66dd1UfI8s=;
        t=1674140090; x=1675349690; b=udIHqE7bOG7dJgqgLcydt3K62cNhNK3leXvfKLZRY09WQZi
        wEGXX3X02a9Gwt4GEZ+1koHhafCdqUimEK7QNY85ghkoR/NaIlNh0E5VogaNmY90VGoqhhRg/tJxr
        hKD1mSl49ehW5vEwQFiYg8tAuSkMTiqcAdlhVOr/CllCrKHNDNKdk314CQqNHQ0bw0n2/sNtbQ5eO
        4QuRbmDnv5MHQGN7CvzXHQ4oBodEUhrvAuMfnh2Xn2eVoC7Rf6tY8UUW7euyVfcZtZHb6FcLwL1Z/
        dOdehwokk5z/1jmueQqUJqEqUDfXpi2wzpieGT4DBnuzuM3eqwndwYEv3BkDu4rw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pIWJM-006Y8W-2j;
        Thu, 19 Jan 2023 15:54:40 +0100
Message-ID: <2a2332211b2ca9daa968a3644006f5c9e0c88a00.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] nl80211: add support to enable/disable bss color
 collision detection
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Nicolas Cavallari <nicolas.cavallari@green-communications.fr>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        ath11k@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 19 Jan 2023 15:54:39 +0100
In-Reply-To: <1609a645-3e23-7e37-9aa1-94f970e481e2@green-communications.fr>
References: <20221226083328.29051-1-quic_ramess@quicinc.com>
         <20221226083328.29051-2-quic_ramess@quicinc.com>
         <74c57dc34af10537f98f5bb9b6ce80e5676e09b0.camel@sipsolutions.net>
         <1609a645-3e23-7e37-9aa1-94f970e481e2@green-communications.fr>
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

On Thu, 2023-01-19 at 15:52 +0100, Nicolas Cavallari wrote:
>=20
> This may not be related, but the software color collision detection=20
> sends a netlink message for every colliding frame and it can hose up the=
=20
> system if the other network is very active.
>=20
> Also, cfg80211_bss_color_notify() complains that the wdev lock isn't held=
.

Yay.

Lorenzo can you take a look at that?

johannes
