Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B43006AAB31
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Mar 2023 17:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjCDQnS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 Mar 2023 11:43:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCDQnR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 Mar 2023 11:43:17 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CFCE053
        for <linux-wireless@vger.kernel.org>; Sat,  4 Mar 2023 08:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=FdSd5pI+NEDxXpxC1KnpL+D4XeNGYlMR8HiSe6m8i0Q=;
        t=1677948196; x=1679157796; b=aHSHCDNuTo+tC3VcBWn/vlVX9Hl1PwDCgZTb4Ecyue38dNh
        8H/V37IF21Bvj7lvs5TBL0zdQbAz0eJ2d9OE5/KDrFjAMroaz0hN8Hkmx5LXCwEnN/vqO+H6qFMMF
        wdSn1ImiDYJ32/evTzhzWbAUZobeM3oHDTe/o4EJGSBW/r7pUXt3zX4/JvMLt5/o7TEls1GT43/kV
        hviftGooaCNfT6G2pSKgz8RZGUHawDdhp1j3egBtZqd1b3hTtjCnJGuE8pmTGxTcp+uVd+ykNgr74
        2ZqdSA1tWRCpU6Cycg6GdZJoUvcFNH6jAX2odqJkWfC1wTEYLl/3PpXZdDE9o1vA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pYUyX-00BnBf-0q;
        Sat, 04 Mar 2023 17:43:13 +0100
Message-ID: <f8708f82419949fabdf03883c821261c4a45e2b7.camel@sipsolutions.net>
Subject: Re: WARNING in nla_get_range_unsigned
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Shigeru Yoshida <syoshida@redhat.com>,
        linux-wireless@vger.kernel.org
Cc:     quic_alokad@quicinc.com, quic_msinada@quicinc.com
Date:   Sat, 04 Mar 2023 17:43:12 +0100
In-Reply-To: <ZANfZ6wHQOUObgh4@kernel-devel>
References: <ZANfZ6wHQOUObgh4@kernel-devel>
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

>=20
> I investigated this issue and found that the issue relates to the
> following commit:
>=20
> d7c1a9a0ed18 wifi: nl80211: validate and configure puncturing bitmap
>=20

There's a fix in the queue for this, I'll get it in soon.

https://patchwork.kernel.org/project/linux-wireless/patch/20230224133656.b5=
3b1fea182c.Ifa95124e8851df90e69776bcc3b0e3ebd1cf1687@changeid/

johannes
