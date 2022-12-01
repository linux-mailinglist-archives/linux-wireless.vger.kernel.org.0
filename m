Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A655763F68D
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Dec 2022 18:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbiLARqK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Dec 2022 12:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbiLARpg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Dec 2022 12:45:36 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8846CBA089
        for <linux-wireless@vger.kernel.org>; Thu,  1 Dec 2022 09:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1669916702; bh=UEc43+C947dpGkLHkEC83wgTpGJFZ+9h39uIokk+3YM=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=XRK0swUWRruL9TbknTlosdjwPQi4gjM2xed6Y5dBso12caTdzRlKiGoJi8uEQZKYD
         +fJS2HTdqnDswOlZxV7WtaYUs9/ObZy92QC0OQ88DN6PGlnCRGPxf6lmpin+PQlFek
         AqqIDmmYQOgtiODECldVeFkshppoLuaKH8geXBXtOsMupSyEmDdWT/o5SYMUT1gSJR
         m1P1rk8LxwjCvSYU4nlBgPIBRgKNwtiGoY+KT+Y6mq/wM2nDnc2h9Y5vgZsnhXurMn
         wwca4bTzx19NSr5MSiy7bSbBZJ2Y6M3c2jgDVNEQr6NP+hZY65kS9JFEwranD2RzWr
         xc/xuaTJ5Fivg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.157] ([185.211.19.185]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MtwUm-1ohtHm1OhA-00uHKx; Thu, 01
 Dec 2022 18:45:02 +0100
Message-ID: <f8dea92e4fa8e26bd1cc7ff8c6ba6ccd4843d8eb.camel@gmx.de>
Subject: Re: Bug report: Can connect with 'wext', but not 'nl80211'
From:   "Matthias G." <maps4711@gmx.de>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Cc:     hostap@lists.infradead.org
Date:   Thu, 01 Dec 2022 18:45:01 +0100
In-Reply-To: <f694e9d9dbf36b870f278f8eabed14d5dede55aa.camel@sipsolutions.net>
References: <1235df2ba1757a5917dc21455fa8c1d0a48bb2c4.camel@gmx.de>
         <f694e9d9dbf36b870f278f8eabed14d5dede55aa.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1 
MIME-Version: 1.0
X-Provags-ID: V03:K1:Q2q11gecbhCMXJlwDO+ZBQrbPG/0Fx4IoAaqkBwfxC2fGjH0QaI
 4ozbGuPzhfjGnQ5IvJcWLu6CgXykZTm6Q0MqlVsIRxUDAojtm9VPT4jQ5sqQIspGYxWDCag
 8o1dTIFoqzW2x2CxdF0lgB41nPO33oP7WdroKZ+qVVkDv9VLDxQxGi4ajDJ8ShbOeSEZv9+
 MuMvf9jKn0VSw5wNA9jNg==
UI-OutboundReport: notjunk:1;M01:P0:hyzn3L3ZAJc=;eOugMRZlkX2x7mq1tzjwTwsu8UU
 xlEbE4jss0yL02HkSaneg0oZ1f9Bjmrk7WP07E1EotQo7VbGvXL/+0mSBQEXnwDo0eLQjMCeG
 d7fm56eQQ4epbSX1tWFyBMzAd+Qxf4AMFRe2kvnDBrOpusD+jfRjmS4LxFzBDp0oL9GiXeAIq
 LdBz9Vgygt4joxUUAsjyAbgupirFmtqj2X4Nmhp8eccaZqcp9JEXRu7Q9fIodf3ONaUxw5rOB
 hk9qBVFgN/2dgv+eywXh+XIwjQcP+bdH/YBA9MIhm6n6+r0QZQ9eSFdVBwA42mYK9MFFrvSdT
 m4ECqoNQH+5XUc4cBGi+9iE8VMlOVpD5zeASmG1H38Mc7R8xNKmKulek58MrJ31FQFAKD+gc+
 MFGciBTMEYIdl9FlD7ub0R9e+heue0sLIzEPyQ/BZE69oXDgjCQNNBGL1qkBbG+qcDJloDEjF
 R5+le1/GZsoR8A357gPea7Omw86tt72AffWXvl7pHKFYR1bynr5vgaQIHEBNW4QjuoMpzkEhS
 ZMotKO4B9U50gf/vIMyvSHZmDj0G3QMtNkg63wcoZKQmoVZC93o1/Nu97/VoxeCc1DCE0u9he
 0xIjJESWkc09yveSJO8FwD8M5uiSbdVHk4nlE+fdDfsoM5Hef5JSqIK8uLmoNDyOUh6SLQFtL
 xlxnAB1e8SfWn8vB6398V5cwL53Bh+gwW1lsoBxTuIK1BwCyB5+8N8hLAB0E0ueVpQ4AiTmHp
 yHq7m4xyUdbZWuei3fnE1gpfWEXjm+aOc3fZfRzhiF8nq2ICFldp+BCUBVbQ3F7Bps7UpI0iK
 intn0sbDTXGNaK4aO8AB/U6ElRrOpoexGqGfl9oIwOMzogYBD4IvVmdxNPTHYpJcphT/QNQfX
 JvnZGBOBeagzveZ/el6g6HAmzp0tILuu8tHkGddB4fA+eGzqJOawXWgvQRbNUkqBkj4xPiUHO
 ow5hcg==
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2022-11-30 at 21:29 +0100, Johannes Berg wrote:
> Sounds like the AP is broken and doesn't like some elements wpa_s
> includes when nl80211 has certain capabilities ...
>=20
> Not sure what we can do about that - maybe there's a way to
> selectively
> disable certain capabilities in wpa_s?
>=20
> johannes

Just for reference, both my Windows 10 and my Android phone can connect
to this 'Congstar'-labelled device without further configuration. I
don't know what Windows and Android are doing behind the scenes though.

Also, I'm not subscribed to either mailing list, so if you'd like more
information please answer directly.

Regards,
Matthias


