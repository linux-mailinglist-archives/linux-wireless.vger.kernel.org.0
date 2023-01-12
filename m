Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D402A666FCC
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jan 2023 11:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjALKhy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Jan 2023 05:37:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbjALKhR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Jan 2023 05:37:17 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753012640
        for <linux-wireless@vger.kernel.org>; Thu, 12 Jan 2023 02:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=L5L6vyBzlzCV3hu2poVUhUM21hUUlhzA05FoZYU3Tec=;
        t=1673519482; x=1674729082; b=weBvp5uyMBrlVzjnFvl3qCcX/GYqbaiOhvo07mcW/2Ps4mW
        YCzR+/kGULXxbN/BrUmEZKpPcoUcuzw18YKxE3DroIJyC3j0tOqESfM8l9t6r+etT4RkHLw1hsV9W
        lTeiKREirH3c+PVCMwiQB2Yt8JKW53SOI8HIQUywh/StzgVDXTxu0N1DyAA9w4s07+3N/CYfrTQFx
        2/ygiXZzv6DalgBEswFTWhs7vf08H2aCAlStHSuy8ZmSy6zK5TmHeOfTs+2ayGl1+IB50VxGIAJ5V
        EMM+lgPD48EI/7Znp+vJ/xHVN5QZkxet8MPMidXCGIF5MOMtA/ZC8uza655QuGFA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pFurg-00H3J9-25;
        Thu, 12 Jan 2023 11:31:20 +0100
Message-ID: <65d136e7e83eac38efc10998cc03be58077169c3.camel@sipsolutions.net>
Subject: Re: [RFC v2 2/6] mac80211: add tx-power annotation in control path
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jonas Jelonek <jelonek.jonas@gmail.com>,
        linux-wireless@vger.kernel.org
Cc:     nbd@nbd.name, Thomas Huehn <thomas.huehn@hs-nordhausen.de>
Date:   Thu, 12 Jan 2023 11:31:19 +0100
In-Reply-To: <20220920104032.496697-3-jelonek.jonas@gmail.com>
References: <20220920104032.496697-1-jelonek.jonas@gmail.com>
         <20220920104032.496697-3-jelonek.jonas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
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

On Tue, 2022-09-20 at 12:40 +0200, Jonas Jelonek wrote:
>=20
>   * @rate_idx The actual used rate.
>   * @try_count How often the rate was tried.
> - * @tx_power_idx An idx into the ieee80211_hw->tx_power_levels list of t=
he
> - * 	corresponding wifi hardware. The idx shall point to the power level
> - * 	that was used when sending the packet.
> + * @tx_power_idx An idx into the the tx-power set described by
> + * 	ieee80211_hw->txpower_ranges for the corresponding wifi hardware.
> + * 	The idx shall point to the tx-power level that was used when sending
> + * 	the packet at this rate. A negative value is considered as 'invalid'
> + * 	or 'no power level reported by the driver'.

maybe fix the kernel-doc (at least for this entry) while at it and add
the missing colon.

johannes
