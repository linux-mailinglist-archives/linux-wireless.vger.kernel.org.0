Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4616CA1F2
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Mar 2023 13:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbjC0LBl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Mar 2023 07:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbjC0LBj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Mar 2023 07:01:39 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FA8110
        for <linux-wireless@vger.kernel.org>; Mon, 27 Mar 2023 04:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=yLI8RKxxwDcFyvb/6yKBpMl3aFwGUxUksN2VCDR+H/A=;
        t=1679914897; x=1681124497; b=EMpdQFv/MSxT5S4FOEfploVqdSBi+qiftJ/mb3thuF8ZHKn
        DZ6mtCrDoS95xdtdwEdagDwDrZCfT4MJj4dbzHv+DqRfB9Ee+Z8maWpawUtVlRKK9Jrn4RsIBwXd2
        P+jFzpR5iTJikotzTNqQpSMLnDio+4v984wEsf3eDuxkckh/ZsY+iZnGmSMy2kcU7cON8Y20F2mtp
        9PLHoqck4x1wf/T7u3W5GkroKYThzdbmYkJQsIopN0uDm1VMbwliHdTWCbUubl50Nw8pEpuj0n1XM
        5xDNGbav6L9IQ+8PQ6Y+e6eG9mU3fMtEMZvsLATMqWK9D5grTAH4t/8xQlcxt1aw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pgkbK-00Ff5d-1f;
        Mon, 27 Mar 2023 13:01:22 +0200
Message-ID: <8104db6eba0907be02759348eaf14e0512b44a63.camel@sipsolutions.net>
Subject: Re: iwlwifi "memcpy: detected field-spanning write" kernel oops
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Hans de Goede <hdegoede@redhat.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Benjamin Berg <benjamin.berg@intel.com>
Cc:     Kalle Valo <kvalo@kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Date:   Mon, 27 Mar 2023 13:01:21 +0200
In-Reply-To: <1c71e611-42d0-daf6-3ef2-c404561b42f7@redhat.com>
References: <68760035-7f75-1b23-e355-bfb758a87d83@redhat.com>
         <569b7058d6a9807a98777bf7a0cfc4b3846477d8.camel@sipsolutions.net>
         <1c71e611-42d0-daf6-3ef2-c404561b42f7@redhat.com>
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

On Mon, 2023-03-27 at 12:54 +0200, Hans de Goede wrote:
>=20
> Reading the thread I see that this seems to be an actual bug and there ar=
e=20
> some ideas how to fix this, but it needs someone to actually test the fix=
es.

There's kind of a bug, yes, but just applying the second hunk of Kees's
patch would squash the issue as well.

> I hit the reported oops whenever one of my laptops at home connects
> to my home router access-point.

Ok, that probably means you should upgrade your AP security settings ;-)

> So I can reproduce this at will; and given that I hit the oops I assume
> that my home network also actually uses the keys setup by the given path,
> so I should also be able to test that a fix does not break the wifi
> connection by misconfiguring the keys.

Right.

> So I'm hereby volunteering to test a fix on my setup.

You can just change the memcpy() that triggers the warning to copy only
16 bytes instead of key->keylen.

johannes
