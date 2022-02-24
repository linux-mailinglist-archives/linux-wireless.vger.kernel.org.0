Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0ADA4C292D
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Feb 2022 11:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbiBXKUF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Feb 2022 05:20:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232322AbiBXKUE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Feb 2022 05:20:04 -0500
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06B328A11F
        for <linux-wireless@vger.kernel.org>; Thu, 24 Feb 2022 02:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1645697969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vYJqqUocECM9Hk86yzStCi+K6tyGJI/Kwj8g34mbC7c=;
        b=1CcefIP/19K2U25MWS84ALRWHITWEcFCwScTOeLamFknK9+VsywGbrrdFXY1Ez/5iSU+eN
        jZU7sBALnY4jp3bLE1eLeu4qGricv9FdFUdpKrdUJDQvwEiLL0HXKc8+xgIh3irME63puX
        0RZ0iNlLavkwq/cCnV9JhGJatQd/wJA=
From:   Sven Eckelmann <sven@narfation.org>
To:     nbd@nbd.name, lorenzo.bianconi@redhat.com, sean.wang@mediatek.com
Cc:     sean.wang@mediatek.com, Soul.Huang@mediatek.com,
        YN.Chen@mediatek.com, Leon.Yen@mediatek.com,
        Eric-SY.Chang@mediatek.com, Mark-YW.Chen@mediatek.com,
        Deren.Wu@mediatek.com, km.lin@mediatek.com,
        jenhao.yang@mediatek.com, robin.chiu@mediatek.com,
        Eddie.Chen@mediatek.com, ch.yeh@mediatek.com,
        posh.sun@mediatek.com, ted.huang@mediatek.com,
        Eric.Liang@mediatek.com, Stella.Chang@mediatek.com,
        Tom.Chou@mediatek.com, steve.lee@mediatek.com, jsiuda@google.com,
        frankgor@google.com, jemele@google.com, abhishekpandit@google.com,
        shawnku@google.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/2] mt76: mt7921: fix up the monitor mode
Date:   Thu, 24 Feb 2022 11:19:25 +0100
Message-ID: <3314617.b7RZopmeeF@ripper>
In-Reply-To: <7dcfc62d67f1f51e6627cc24000393844aa2b649.1645655280.git.objelf@gmail.com>
References: <7dcfc62d67f1f51e6627cc24000393844aa2b649.1645655280.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1809828.CJMapn5LVL"; micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart1809828.CJMapn5LVL
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: nbd@nbd.name, lorenzo.bianconi@redhat.com, sean.wang@mediatek.com
Cc: sean.wang@mediatek.com, Soul.Huang@mediatek.com, YN.Chen@mediatek.com, Leon.Yen@mediatek.com, Eric-SY.Chang@mediatek.com, Mark-YW.Chen@mediatek.com, Deren.Wu@mediatek.com, km.lin@mediatek.com, jenhao.yang@mediatek.com, robin.chiu@mediatek.com, Eddie.Chen@mediatek.com, ch.yeh@mediatek.com, posh.sun@mediatek.com, ted.huang@mediatek.com, Eric.Liang@mediatek.com, Stella.Chang@mediatek.com, Tom.Chou@mediatek.com, steve.lee@mediatek.com, jsiuda@google.com, frankgor@google.com, jemele@google.com, abhishekpandit@google.com, shawnku@google.com, linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/2] mt76: mt7921: fix up the monitor mode
Date: Thu, 24 Feb 2022 11:19:25 +0100
Message-ID: <3314617.b7RZopmeeF@ripper>
In-Reply-To: <7dcfc62d67f1f51e6627cc24000393844aa2b649.1645655280.git.objelf@gmail.com>
References: <7dcfc62d67f1f51e6627cc24000393844aa2b649.1645655280.git.objelf@gmail.com>

On Wednesday, 23 February 2022 23:34:17 CET sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Properly set up the monitor mode the firmware can support to fix up
> RTS/CTS and beacon frames cannot be captured and forwarded to the host.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Tested-by: Sven Eckelmann <sven@narfation.org>

Tests were performed on

    mt7921e 0000:05:00.0: ASIC revision: 79610010
    mt7921e 0000:05:00.0: HW/SW Version: 0x8a108a10, Build Time: 20220110230855a
    mt7921e 0000:05:00.0: WM Firmware Version: ____010000, Build Time: 20220110230951

Thanks,
	Sven
--nextPart1809828.CJMapn5LVL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmIXW60ACgkQXYcKB8Em
e0YjQw/9EnPdFv2OwQvh6Bwr68rYnACaXHR4tJ9VLvQ6Mwynr9B0mnvxIkWb0V0F
lp6aZQyij1m8MKvwqvya66gYo51JK6CU5Wcdb9XCZuBBUgllfWYQ8eDe4uykzcpF
Z5KGfqLlIIwL52KQhkqOkMt0R6i+Rou326wCgjAKKFbpkC41Z/i7LucK+sI6hHfo
WGFW2N/uIUpvQLYz8vGYwzsUZ9Oy6ZbCmzsT06C326lAu2VqHLWmpcMXlqHVmrwN
dava2zNWxK9x2U2AJLzb/qb427X4h3DrS6jDuYK+Tj6PV5yOQevfIPEY00/BANUV
DFVz4avbBThxMnqiX7sUMGGz9UJVsyGC3+QyMGUuTO9m7xcPW/2Ab6wi4Z05WJrp
u0ZRt9HBR57Ocpgr5RUH/x1jvqn2iZmQ6AmxI5BSEf0nliv9q0jSRCigQthmVDC7
KvLma5AxQPNPjbKVA/OzkqpJHAX1Ao3wtnH6Rt/32+prxShJR+APP5mfBDVICGEx
ZDTa4kTdi0tGTFybWs+sSvBx56rPkU85SODPjvkGjw2Z4OUKPqMFxA+FCfP5wqW2
Sh3gq5I606pDAjCAh0zd15gcX76KcDvv3Wy345/ibttpsk80sRq9pEucC98mFJ7Z
iQ6GbaO16M1IBlc/N1JXsvyf4PazJsBzSZEVOPHxW7ZRlL3AfO0=
=mWVG
-----END PGP SIGNATURE-----

--nextPart1809828.CJMapn5LVL--



