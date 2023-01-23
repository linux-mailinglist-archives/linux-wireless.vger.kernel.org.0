Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 415C9677CB0
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jan 2023 14:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjAWNjh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Jan 2023 08:39:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbjAWNjg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Jan 2023 08:39:36 -0500
X-Greylist: delayed 392 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 23 Jan 2023 05:39:33 PST
Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [IPv6:2001:1600:3:17::bc0b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B3BD52F
        for <linux-wireless@vger.kernel.org>; Mon, 23 Jan 2023 05:39:33 -0800 (PST)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4P0rdQ4Hr4zMqjyZ
        for <linux-wireless@vger.kernel.org>; Mon, 23 Jan 2023 14:32:58 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4P0rdQ20m0zc88
        for <linux-wireless@vger.kernel.org>; Mon, 23 Jan 2023 14:32:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fls.name; s=20200831;
        t=1674480778; bh=hRZJYzZaYsUYIDD81g+QOOPOxAdXF2uLB2vFmG7YgYY=;
        h=Date:Subject:From:Reply-To:To:From;
        b=lAEIbq+TMAb/IccyTEViv55gk2TODQsstkKKHIkPNN4slRILAB/i/XYkcjrWBlKig
         C/Jg8kbjqWrYx2JH7aMwpyz85Iiaz2Olau50Y6/w7bTtiayNIgsbsXt81GJ/Cxhdac
         UbH8/+1a9OcDPDCR5lUfJzHmkmvBjSdnr75cL+Xo=
Message-ID: <c7fc198f2a4ed9c1345a05c0397a9fc5@mail.infomaniak.com>
Date:   Mon, 23 Jan 2023 14:32:58 +0100
Subject: wifi: mt76: mt7915e: mt7916 5GHz and 6GHz stopped working
From:   Florian Schmidt <florian@fls.name>
Reply-To: Florian Schmidt <florian@fls.name>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-WS-User-Origin: eyJpdiI6Im13RDIraVkxbmpBY3F2dWFhMWl5TXc9PSIsInZhbHVlIjoibWxJREFrbUtCcTNlUGFuMzVWc3V3UT09IiwibWFjIjoiMTQ5Y2ZhOTk4MGYyYjU1NmYzZGEwNTJlM2Y1OTRiMTEwNzdjMDNlOTFmZGM4ZmI1M2MzODM3ZThlNmE1NjljZSIsInRhZyI6IiJ9
X-WS-User-Mbox: eyJpdiI6IkQzWjA0TnJMOXkyeUR0OUNZU3lSOGc9PSIsInZhbHVlIjoiRGdUNWUzSlIyTHQ2cktObHdIL1JnZz09IiwibWFjIjoiNTIwMzJmMmI2MGQ5OTczYWJmZDU5MWYxNmM3YzMwNzI2ODZlYmFjNGQ5YzU4ZTY0MGU5OTI2YTFiNTRmZjYyNSIsInRhZyI6IiJ9
X-WS-Location: eJxzKUpMKykGAAfpAmU-
X-Mailer: Infomaniak Workspace (1.3.429)
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi all,

Using current firmware and kernel 6.1 (or 6.2-rc4 from wireless-testing), t=
he 5 and 6GHz stopped working on MT7916  (from AsiaRF). It used to work wit=
h older firmware and kernel.

As a workaround, reverting to the older firmware seems to work. I can also =
get the 5GHz (but not the 6GHz!) to work building the driver using the work=
around described on this dd-wrt bug report:=C2=A0https://github.com/openwrt=
/mt76/issues/720

How can I be of any assist investigating and fixing this issue?

Thanks,
Florian
