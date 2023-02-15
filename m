Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1196698273
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Feb 2023 18:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjBORmS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Feb 2023 12:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjBORmR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Feb 2023 12:42:17 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6E837726
        for <linux-wireless@vger.kernel.org>; Wed, 15 Feb 2023 09:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=L0qMuhWArbdGbqeRbzGWUeQkLwd0+Zp9mTMMqnSX4L4=;
        t=1676482930; x=1677692530; b=WCdwh96oSctVHFRJuztGepkYH7FjSIlDjpObC6QVfrXFbSu
        GOlJWBsKMnV7BdL7O3hOP2wCOQBazq4m+HdzhSOq5TMj7A/lC2pbr+/+4iVZgcf/OM2adnsOHSBLk
        vPGFV0j+BGbv+q3J63W37ZtobvsnIPc2hdDB9Ijv0t6cV3Fvb1HEXl5CNJI3LZFS9ymDodneSH2Kn
        TakD95GDHmxBqbHWkEkwr/4E2RksJS6bzc4S338TAFJagTH6zHmTkQZ7DCCJA96hljrEKb2vt4MCr
        RABTB51L9FC25opASQvHIGANLK2EVprqDsTUyJIDSmpLx09/jLSpszzbtwxEqyrQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pSLnC-00D9Rw-27;
        Wed, 15 Feb 2023 18:42:06 +0100
Message-ID: <26c62285825010dc9947c9a8c147f60da5db004a.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] wifi: mac80211: add EHT MU-MIMO related flags in
 ieee80211_bss_conf
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ryder Lee <ryder.lee@mediatek.com>, linux-wireless@vger.kernel.org
Cc:     Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek@lists.infradead.org
Date:   Wed, 15 Feb 2023 18:42:05 +0100
In-Reply-To: <c1a6ef2f42e26a6e0473d4fb2ce1b572f8448d87.1675893838.git.ryder.lee@mediatek.com>
References: <c1a6ef2f42e26a6e0473d4fb2ce1b572f8448d87.1675893838.git.ryder.lee@mediatek.com>
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

On Thu, 2023-02-09 at 06:09 +0800, Ryder Lee wrote:
> Simliar to VHT/HE. This is utilized to pass MU-MIMO configurations

Typo - similar

> from user space (i.e. hostap) to driver.

^^ hostapd

> + * @eht_su_beamformer: in AP-mode, does this BSS support operation as an=
 EHT SU
> + *	beamformer
> + * @eht_su_beamformee: in AP-mode, does this BSS support operation as an=
 EHT SU
> + *	beamformee
> + * @eht_mu_beamformer: in AP-mode, does this BSS support operation as an=
 EHT MU
> + *	beamformer

Is that really about _supporting_ it rather than _using_ it? Or
_enabling_ it?

johannes

