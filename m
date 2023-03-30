Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4AB6D0049
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Mar 2023 11:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjC3Jzy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Mar 2023 05:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjC3Jzv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Mar 2023 05:55:51 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9445B0
        for <linux-wireless@vger.kernel.org>; Thu, 30 Mar 2023 02:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=63BxINwI8cQnu8X0gC6j3I6zyxlDVHYwlDkREo7jCCA=;
        t=1680170148; x=1681379748; b=v6C/04l5DO0z1Pw7zVcv11wzCRg/tZHo8cJNUedDLhgzFw8
        qwhw4PtEpp823D6AuL1kQUTgBmQGd0Ns7cpxu1YcE/77RuvKYo7xWBDaheeHgD6C8QEMan+5qS/h6
        qa+QEdbJk5EPVInkPzJRCB3Sla7t5bM6Zz5ioGNASt+dKy+Baw9R2kGegw6VbkdZr5ZGyS28X19TT
        gdpeDqsPDckMnUhnwJoScq/tWdCFXo5xVH4LyGd4mdnhVFfLPBZqLZX61vh5h1WU6ldUByjqzaPpX
        xPXbAaXWvFZjKL7iOZlkSBRLZqxDkNrfAFiCR8IOcUgVvFbD+pdx/tcqBgDDY5mQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1php0S-000yc6-3C;
        Thu, 30 Mar 2023 11:55:45 +0200
Message-ID: <f2f75ad57f3dfc2e3cf0c7930c1c348597be287b.camel@sipsolutions.net>
Subject: Re: [PATCH v3 1/4] wifi: cfg80211: Add short_beacon_tail/head/period
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
Cc:     linux-wireless@vger.kernel.org, quic_jjohnson@quicinc.com,
        Kieran Frewen <kieran.frewen@morsemicro.com>
Date:   Thu, 30 Mar 2023 11:55:44 +0200
In-Reply-To: <20221116020700.3907453-1-gilad.itzkovitch@morsemicro.com>
References: <20221116020700.3907453-1-gilad.itzkovitch@morsemicro.com>
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

Hi,

Hmm. This was on my list forever, and somehow I always went past it.
Sorry.

> Support variables to handle short beacon period and adding a
> separate tail/head for them.
>=20

I don't think this really needs to be a separate patch? Should be
squashed with the nl80211 one.

johannes
