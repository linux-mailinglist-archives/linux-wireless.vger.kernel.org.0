Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5422B542A0E
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jun 2022 10:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbiFHIzU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Jun 2022 04:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbiFHIy0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Jun 2022 04:54:26 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B340307216
        for <linux-wireless@vger.kernel.org>; Wed,  8 Jun 2022 01:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=QuiuH8bsKzoFqBGf6cF/rDdrmAo45idRj64/C8aHK/g=;
        t=1654676103; x=1655885703; b=U6evwd+kMZdpj0X9VRGXkd6Ba+f3NiKJO8SK7HifMCb3+u1
        IzSR/a9yrXo1KIrHkn7ISil0OJqOWTfU+N4+ScFct/b/7kWFD8hJ/Ax25V2x96kzfX82FfSS52Jim
        /PDZvVi+knxb9MRj87XEuPLkSQVvVQ7zzgceuM6/Ix86n6pK7b9myYkMFi9CvB2+9FEteyCxuoixh
        PdCK44MUfC/m5OA3tHm9dzcjitsbjGnheeRSm634SMR7dQGrMn/BWUvGjk1VlCVSfL0bYPWYXQqTV
        xyUCiXgnnRf0/Nk9Xr4JqeMhdZSpTNokCR2+6tT/sWUyVRgTzVW6lBzZJ33kRqdw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nyqqC-00Gqm7-N6;
        Wed, 08 Jun 2022 10:15:00 +0200
Message-ID: <7a2f5d0430c86fe7baeb68d1479f09b504f0eed4.camel@sipsolutions.net>
Subject: Re: [PATCH 1/3] ieee80211: add trigger frame definition
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Eric Huang <echuang@realtek.com>,
        Bernie Huang <phhuang@realtek.com>
Date:   Wed, 08 Jun 2022 10:14:59 +0200
In-Reply-To: <edc136dc78b142c5a8f4c73e5464d994@realtek.com>
References: <20220601013917.18814-1-pkshih@realtek.com>
         <20220601013917.18814-2-pkshih@realtek.com> <87h74vshno.fsf@kernel.org>
         <edc136dc78b142c5a8f4c73e5464d994@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
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

On Wed, 2022-06-08 at 08:13 +0000, Ping-Ke Shih wrote:
>=20
>=20
> This is because common_info in ieee80211_trigger is __le64:
>=20
> +struct ieee80211_trigger {
> 	...
> +	__le64 common_info;
> 	...
> +}
>=20
> Then,=20
> 	type =3D le64_get_bits(tf->common_info,
> IEEE80211_TRIGGER_TYPE_MASK);
> is used to access trigger type of common_info in patch 2/3.

Yep, but you have (after macro expansion)

static __always_inline u64 le64_get_bits(__le64 v, u64 field)
{
	return ...;
}


so you can easily pass any number as the 'field' argument, it doesn't
need to already be ULL :-)

johannes
