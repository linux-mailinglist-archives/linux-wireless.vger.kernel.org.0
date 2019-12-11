Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFDE011A4C9
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2019 08:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfLKHFV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Dec 2019 02:05:21 -0500
Received: from ni.piap.pl ([195.187.100.5]:32816 "EHLO ni.piap.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbfLKHFU (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Dec 2019 02:05:20 -0500
X-Greylist: delayed 414 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Dec 2019 02:05:19 EST
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ni.piap.pl (Postfix) with ESMTPSA id 56EF744395F;
        Wed, 11 Dec 2019 07:58:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl 56EF744395F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=piap.pl; s=mail;
        t=1576047501; bh=BFS6xN/3hLjP/0lc1y+PV7Gn73ep48NKRu0MxUiCCjI=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=I6s+fdID+SeksYo02ECy1XG92biOLJMw9ej9XdI6XnF0e/5q+KK8XwnzbtabkouNU
         aZi7XGppuMpRTz/HDc/FBVku2ZwmcEjdbTE//xFUu/WIEQPsV5AxWr9irgZWIxG4km
         nlSAItIx2R5HLb/i9ObdwCQ0/wnjRNVOp9z0L8H8=
From:   khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
To:     Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>
Subject: Re: [RFC] Allow userspace to reset IBSS stations to fix aggregation issue
References: <m34l02mh71.fsf@t19.piap.pl>
        <20191209102808.12014-1-nicolas.cavallari@green-communications.fr>
Date:   Wed, 11 Dec 2019 07:58:20 +0100
In-Reply-To: <20191209102808.12014-1-nicolas.cavallari@green-communications.fr>
        (Nicolas Cavallari's message of "Mon, 9 Dec 2019 11:28:05 +0100")
Message-ID: <m3h827jqlv.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-KLMS-Rule-ID: 4
X-KLMS-Message-Action: skipped
X-KLMS-AntiSpam-Status: not scanned, whitelist
X-KLMS-AntiPhishing: not scanned, whitelist
X-KLMS-AntiVirus: Kaspersky Security 8.0 for Linux Mail Server, version 8.0.1.721, not scanned, whitelist
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Nicolas,

Nicolas Cavallari <nicolas.cavallari@green-communications.fr> writes:

> I encountered the same issue in an IBSS-RSN network, where quick reboot
> of a station would cause issues with aggregation because the kernel is
> not aware of the reboot.
>
> I figured out that since wpa_supplicant already detect reboots, the
> simplest way to fix it would be for wpa_supplicant to reset the entire
> state of the station in the kernel, instead of just resetting keys and
> port.

Just to make sure everybody is aware that it would only be a partial fix
- unencrypted ad hoc mode (the simplest thing available) doesn't need
any userspace and thus must be fixed in the kernel. Alternatively this
functionality may be moved to wpa_supplicant and only then userspace fix
could really fix it completely.
--=20
Krzysztof Halasa

=C5=81UKASIEWICZ Research Network
Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
