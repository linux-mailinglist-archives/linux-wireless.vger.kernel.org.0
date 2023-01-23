Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027DF678232
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jan 2023 17:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbjAWQvd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Jan 2023 11:51:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbjAWQvc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Jan 2023 11:51:32 -0500
X-Greylist: delayed 11902 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 23 Jan 2023 08:51:25 PST
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [185.125.25.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8152B29169
        for <linux-wireless@vger.kernel.org>; Mon, 23 Jan 2023 08:51:25 -0800 (PST)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4P0x2K5MMfzMqpyM;
        Mon, 23 Jan 2023 17:51:21 +0100 (CET)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4P0x2K2sB6zMq6jr;
        Mon, 23 Jan 2023 17:51:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fls.name; s=20200831;
        t=1674492681; bh=ndOHD9S37jX58kMQcMfPEu4PZPuOq0IE6gEOXIittL0=;
        h=Date:Subject:From:Reply-To:To:Cc:References:In-Reply-To:From;
        b=W37vdiFBBX3q0CVrBUTukIj/0+ZFYSL3xkCoaetbPKpBznzv5sO39IzIMrTgN0m3U
         XU/NvPwIDAC/ENER8U9qmMWmwYqaqsb9XZp1TIdg0pYf7ioWrCfSqXZ8GpUJOh4Dko
         TzECl2JtB2p8uyh57E8mBark6lciNPNgR9gfqcJA=
Message-ID: <60c8e47cf87eb0320587c92dae6680b5@mail.infomaniak.com>
Date:   Mon, 23 Jan 2023 17:51:21 +0100
Subject: Re: wifi: mt76: mt7915e: mt7916 5GHz and 6GHz stopped working
From:   Florian Schmidt <florian@fls.name>
Reply-To: Florian Schmidt <florian@fls.name>
To:     Ben Greear <greearb@candelatech.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-WS-User-Origin: eyJpdiI6InhERDlJT1ZiVWNQczBzY2hJVDdvZkE9PSIsInZhbHVlIjoiK1ViVEIybldvY3owOG00aE9TWHNmZz09IiwibWFjIjoiZjlmYzJmM2EyNWJjMDJjMzEwYWFkZDI5ZDhmN2U2NmZmMTkwZjViNGM5MWNjMTdhYjMxNzk2M2M4NGM5ZDI2MSIsInRhZyI6IiJ9
X-WS-User-Mbox: eyJpdiI6IkE5VWEvcGJKMmphRmhGS2VIc0tKZHc9PSIsInZhbHVlIjoiUklDbUtaUWlYWloxSnhtYTFrdjFCUT09IiwibWFjIjoiYzcyZTYwMjIyNGJhZjU2ODExMWQxZGRiYjU4YzNmZDBlMDRhMmQ1ZThlNDZlOTg2ZjdhMTBmNDVjM2FkN2FmNyIsInRhZyI6IiJ9
X-WS-Location: eJxzKUpMKykGAAfpAmU-
X-Mailer: Infomaniak Workspace (1.3.429)
References: <c7fc198f2a4ed9c1345a05c0397a9fc5@mail.infomaniak.com>
 <519290aa-3b88-2c21-7ca3-10186d9e807a@candelatech.com>
In-Reply-To: <519290aa-3b88-2c21-7ca3-10186d9e807a@candelatech.com>
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

>  On 1/23/23 5:32 AM, Florian Schmidt wrote:
>=20
> >    Hi all,
> > =20
> >  Using current firmware and kernel 6.1 (or 6.2-rc4 from wireless-testin=
g), the 5 and 6GHz stopped working on MT7916  (from AsiaRF). It used to wor=
k with older firmware and kernel.
> > =20
> >  As a workaround, reverting to the older firmware seems to work. I can =
also get the 5GHz (but not the 6GHz!) to work building the driver using the=
 workaround described on this dd-wrt bug report: https://github.com/openwrt=
/mt76/issues/720
> > =20
> >  How can I be of any assist investigating and fixing this issue?
> > =20
> >  Thanks,
> >  Florian
> > =20
>  On 2023-01-23T15:43:08.000+01:00, Ben Greear <greearb@candelatech.com> w=
rote:
>
> We have a patch to hack the driver to allow one or the other with new
> firmware.  Can post a version for 5.19 kernel soon, and we'll rebase on
> something newer at some point soon.
>=20
> Looks like root cause is that the mtk firmware added restrictions and can=
not
> be made to properly calibrate on both bands without a reboot.
>=20
> Thanks,
> Ben
>=20
> --=20
> Ben Greear <greearb@candelatech.com>
> Candela Technologies Inc  http://www.candelatech.com

Thanks Ben, that's great news. Please let me know if I can be of any assist=
 testing your patch.

Florian
