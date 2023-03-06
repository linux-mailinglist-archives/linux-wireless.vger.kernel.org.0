Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8541E6ACF81
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Mar 2023 21:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjCFUt6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Mar 2023 15:49:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjCFUtx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Mar 2023 15:49:53 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E345DBDEA
        for <linux-wireless@vger.kernel.org>; Mon,  6 Mar 2023 12:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=viaYUWUNkg6P6ARbDd2+/3ED76bT5jTYNgAIskMeoGQ=;
        t=1678135792; x=1679345392; b=U15dbnXifD9pyO4eFcQWEMlHQy/KP75Iy6fxTeUpII6tfXR
        pL3RjNvyDlnr9m4Z2Ia3rA8aNRjLg4cx21YB5h9uYQnHELuziqKvGzXw9lOxJXxUpwkb1md/E4OIG
        3sddRotgMuidQudqBQ3mNWkumdBBsAtUuxV4y4kyG6qo7U64vHPAcK2eu+1a+uV+mufnbkOAZLD38
        3r5b7xEsAN8z05C6jX96fuNo29cp7VQWx82rwPp3am1qI0x//BJSkevb0cw0OXomqXGKfaiMJzJpm
        9GyWXlnRcM3iyyKregPoYulXiULCshnaDYpCdFonLJWflL65IndtoRde3gI7LRSw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pZHmH-00Dbj7-0M;
        Mon, 06 Mar 2023 21:49:49 +0100
Message-ID: <41b51fcc9e1ba560fbdad76d818d31167d73c265.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mt76: mt7921: introduce mt7921_get_mac80211_ops
 utility routine
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Lorenzo Bianconi <lorenzo@kernel.org>, nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Date:   Mon, 06 Mar 2023 21:49:48 +0100
In-Reply-To: <e52206331b479cc3089ec5c314a3327e67eb27b8.1678124807.git.lorenzo@kernel.org>
References: <e52206331b479cc3089ec5c314a3327e67eb27b8.1678124807.git.lorenzo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
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

On Mon, 2023-03-06 at 18:50 +0100, Lorenzo Bianconi wrote:
>=20
> +struct ieee80211_ops *
> +mt7921_get_mac80211_ops(struct device *dev, void *drv_data, u8 *fw_featu=
res)
> +{
> +	struct ieee80211_ops *ops;
> +
> +	ops =3D devm_kmemdup(dev, &mt7921_ops, sizeof(mt7921_ops), GFP_KERNEL);

It's kind of nice to have static const ops so they can't be a target for
overwriting and function pointer injection, maybe just declare two
copies with a macro or so, with and without chanctx, and return the
appropriate one? It won't even use more memory unless you never run a
device w/o chanctx ops.

johannes

