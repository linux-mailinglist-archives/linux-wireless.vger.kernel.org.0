Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAB26CA07D
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Mar 2023 11:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjC0JvN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Mar 2023 05:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbjC0JvL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Mar 2023 05:51:11 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE3249DC
        for <linux-wireless@vger.kernel.org>; Mon, 27 Mar 2023 02:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=kr3eZdhWRPlRHk5Q1eR2+2zifEAi9CmH+3+FELJP+rU=;
        t=1679910670; x=1681120270; b=p67nv5DbujY+ltFsM/CsNsnYwNbECNXvCdfxwTPrzHujEKm
        fAXHPGiKqnUDA8dJj5c0XXApl16M2MTBx6RfSF1GWGPYyFBt4YtqLUHKC474e2xBaGv1GRXwEX9nI
        H8kNq6OkGmQIS5C5D2xs/M0Idj/SsQsvrLyKxlQoD7KsRzGIqny03kLbqi54uti8X4QRJRWyMwBLi
        KNpJpBkuG9N3aTb7mdvLjGdxnjUN43wXiMXMRv2zDhfjh04atSGYn9arad5KEsECjrc5eWVul/1ck
        tuFPdqhL1j58ll1Vxx9Xg93dJfOKsLsF78OFbOWb0dU3kYTqghhQz6f7M0CU1BVg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pgjVE-00Fdx5-0O;
        Mon, 27 Mar 2023 11:51:00 +0200
Message-ID: <569b7058d6a9807a98777bf7a0cfc4b3846477d8.camel@sipsolutions.net>
Subject: Re: iwlwifi "memcpy: detected field-spanning write" kernel oops
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Hans de Goede <hdegoede@redhat.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Benjamin Berg <benjamin.berg@intel.com>
Cc:     Kalle Valo <kvalo@kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Date:   Mon, 27 Mar 2023 11:50:59 +0200
In-Reply-To: <68760035-7f75-1b23-e355-bfb758a87d83@redhat.com>
References: <68760035-7f75-1b23-e355-bfb758a87d83@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2023-03-27 at 11:12 +0200, Hans de Goede wrote:
> Hi All,
>=20
> I have noticed the following iwlwifi oops with kernel 6.2.0 and newer (1)=
:

Yes, this was noted before and Kees was working on a fix:

https://lore.kernel.org/linux-wireless/20230218191056.never.374-kees@kernel=
.org/

but the discussion was still ongoing and I don't think he posted a final
version yet.

johannes
