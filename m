Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D008531997
	for <lists+linux-wireless@lfdr.de>; Mon, 23 May 2022 22:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbiEWUAB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 May 2022 16:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbiEWUAA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 May 2022 16:00:00 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB63279830
        for <linux-wireless@vger.kernel.org>; Mon, 23 May 2022 12:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=N2AxGM6pO2hJ7IYWnrgkbwTcd2hXsFSSUlCe7EYYIOA=;
        t=1653335999; x=1654545599; b=aFx3QjULxogWfA9hhS+HYWDhZqHaBmC5jg5EE+I67HKF0fw
        7iHvqeICE0eguoJKCnCAq8QBwB98tBftD/BUHihADvMpk92m1o4SkhrnBlsNcZrD/rMGs1KexChu6
        +Vic3z5gG/1pJXXXMpSn3M+KhldHSDHNrQAhAGSTXN6cZVOh4N8HfwWLI8e7Vf5/lxTce6v5zPWZe
        7zKnMPW6x7z4mgHZ19SdFYmtLFmD5Agd6E5SNDxCLzYcpfsxBg4KVK467yTkBDlfL1TqYtc7ATQ+I
        O0sS5iaPGHZvjAA/KHtXOe0cxl9NfCjz9rkN4CMW72NV3E17EXMOv3JAlDQDcnbQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ntEDX-002YEX-5H;
        Mon, 23 May 2022 21:59:51 +0200
Message-ID: <58716287e66cbd6df59f9b255a6f36a22d57a2e4.camel@sipsolutions.net>
Subject: Re: iwlwifi build warning on mips64
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jakub Kicinski <kuba@kernel.org>,
        Gregory Greenman <gregory.greenman@intel.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Date:   Mon, 23 May 2022 21:59:50 +0200
In-Reply-To: <20220523125906.20d60f1d@kernel.org>
References: <20220523125906.20d60f1d@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2022-05-23 at 12:59 -0700, Jakub Kicinski wrote:
> Hi folks,
>=20
> looks like I'm hitting this on a mips64 build:
>=20
> drivers/net/wireless/intel/iwlwifi/pcie/trans.c:1093: warning: "CAUSE" re=
defined
>  1093 | #define CAUSE(reg, mask)                                         =
       \
>       |=20
> In file included from ../arch/mips/include/asm/ptrace.h:19,
>                  from ../include/linux/sched/signal.h:14,
>                  from ../include/linux/rcuwait.h:6,
>                  from ../include/linux/percpu-rwsem.h:7,
>                  from ../include/linux/fs.h:33,
>                  from ../arch/mips/include/asm/elf.h:12,
>                  from ../include/linux/elf.h:6,
>                  from ../include/linux/module.h:19,
>                  from ../include/linux/device/driver.h:21,
>                  from ../include/linux/device.h:32,
>                  from ../include/linux/pci.h:37,
>                  from ../drivers/net/wireless/intel/iwlwifi/pcie/trans.c:=
7:
> arch/mips/include/uapi/asm/ptrace.h:18: note: this is the location of the=
 previous definition
>    18 | #define CAUSE           65
>       |=20
>=20
> Throw an IWL_ before it, maybe?
>=20
Oh, right, I think that came up before and I dropped the ball on it,
sorry. I'll add something.

johannes
