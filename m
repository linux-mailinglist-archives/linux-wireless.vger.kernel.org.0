Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFDCA6EE93F
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Apr 2023 22:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236279AbjDYUwL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Apr 2023 16:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbjDYUvn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Apr 2023 16:51:43 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA7A13F99
        for <linux-wireless@vger.kernel.org>; Tue, 25 Apr 2023 13:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=SiR2wmWfgT2pgh/DP7jrZ4df0NHil/eT2CV8dj5Q6do=;
        t=1682455902; x=1683665502; b=rIJLU2MqOjOU8ZdVm0O0smyPaw0kT1MghBkk7ZXwwcXFzlf
        MDKLKhe+9lA0z7EpQBwwcNh1UYiwg0pg2sWat+j444dhjeG0rd8201cSx4Zr88EAHVrttTeTtzoRa
        cYxD4MDJ/W+WwqeXRciDrTBnC8U1Y4+bhvFPRjOYrNWcWyN2stawNa//PAJyrHV1UiQCxE1FVZ3cK
        KHg1V3ySeWirQHwKOkFEjv3+cfJudDzKnaLsCIcsgpEw8mId3Y/bIpSNhVns3vLyq9vJ2AoxeCM6R
        CgtocFvFLPK03gKbXyZJSlIGVu0bkCXUKaWkleVdejw6Rvmsx82MiFoVzYx4iAbA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1prPdU-008MJI-0F;
        Tue, 25 Apr 2023 22:51:40 +0200
Message-ID: <c5efcbd258282c05ba0d15210ea325c5bf36b94c.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: rtl8xxxu: Support new chip RTL8192FU
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
Date:   Tue, 25 Apr 2023 22:51:39 +0200
In-Reply-To: <90102fa5-5065-9598-d21f-3624629a0cb5@gmail.com>
References: <90102fa5-5065-9598-d21f-3624629a0cb5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2023-04-25 at 20:28 +0300, Bitterblue Smith wrote:
>=20
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/sched.h>
> +#include <linux/errno.h>
> +#include <linux/slab.h>
> +#include <linux/module.h>
> +#include <linux/spinlock.h>
> +#include <linux/list.h>
> +#include <linux/usb.h>
> +#include <linux/netdevice.h>
> +#include <linux/etherdevice.h>
> +#include <linux/ethtool.h>
> +#include <linux/wireless.h>
> +#include <linux/firmware.h>
> +#include <linux/moduleparam.h>
> +#include <net/mac80211.h>
> +#include "rtl8xxxu.h"
> +#include "rtl8xxxu_regs.h"
> +
> +static const struct rtl8xxxu_reg8val rtl8192f_mac_init_table[] =3D {

[...]

So I guess then this would be the place where we start moving this into
firmware files per=20

https://lore.kernel.org/r/20230421075404.63c04bca@kernel.org

:)

Though this one is smaller than the previous one in that thread.

Looks like you're adding rtlwifi/rtl8192fufw.bin and I guess that's
maintained by someone in Realtek, so perhaps it makes less sense to
attach the tables to the same file.

johannes
