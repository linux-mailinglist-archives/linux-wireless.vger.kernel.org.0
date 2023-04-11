Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122C06DE351
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Apr 2023 20:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjDKSA5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Apr 2023 14:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjDKSA4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Apr 2023 14:00:56 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CA7526F
        for <linux-wireless@vger.kernel.org>; Tue, 11 Apr 2023 11:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=nFFsRWtVD/CNkj/qsHH4+ZCoif+5RQ9U7LxyMqRiHoA=;
        t=1681236051; x=1682445651; b=tntMpXd5MrokmSQcP9yH+t+SABXr8NwtEgUtvjNO8NHviEX
        DK5+IBIyVFUWVDJ9pYV6OeTVRlyFDB1DsKqA3TXIGVi1M35Ws8uuxSTMmRkCf4p/8DP5z/MowC/ep
        UCc+Tio0v28kj4mRY8r5Z7xVAAqT0qlzzsa8l5RNoukO/D363PZw22I9mT7MH2JsfLGHrnxl0blLV
        kpOHkPPau5pYXwT02LdBF5sOZ6XuZQCmkI8AqdKDmdCei0tDTRPUO6LHN6OmREMtj5qwpXRzTpWAP
        g9l9TPd4O2nqzpTDwjA0lkmYA/12vhcH4hSgwvqTAoQ0Cb9GWrbcmTtF5NCjKSyQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pmIIR-00CpkA-10;
        Tue, 11 Apr 2023 20:00:47 +0200
Message-ID: <14dacce8ccf2f6b69fbeb49b92f864de9bdd216d.camel@sipsolutions.net>
Subject: Re: ax200 reliable crash in 100Mbps bi-directional traffic test.
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ben Greear <greearb@candelatech.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Cc:     amol.jawale@candelatech.com,
        Gregory Greenman <gregory.greenman@intel.com>
Date:   Tue, 11 Apr 2023 20:00:46 +0200
In-Reply-To: <0ec935a0-175c-38ae-cf3c-c001989a3334@candelatech.com>
References: <0ec935a0-175c-38ae-cf3c-c001989a3334@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2023-04-11 at 10:09 -0700, Ben Greear wrote:
> Hello,
>=20
> Our test team reports that they get reliable firmware crashes on ax200 ra=
dios against multiple
> APs when running 100Mbps UL + DL traffic (100Mbps in both directions).
>=20
> This happens on 5.19-ish kernels as well as 6.2.9+.
> ax210 radios in same setup are much more stable.
>=20
> Please let us know if you would like additional debug information, includ=
ing binary
> crash dump files from the radio....
>=20
> [19241.588542] sta0001: Limiting TX power to 27 (30 - 3) dBm as advertise=
d by 28:80:88:f3:b2:00
> 4[19245.998099] iwlwifi 0000:12:00.0: Microcode SW error detected. Restar=
ting 0x0.
> 5[19246.004160] iwlwifi 0000:12:00.0: Start IWL Error Log Dump:
> 6[19246.008457] iwlwifi 0000:12:00.0: Transport status: 0x0000004B, valid=
: 6
> 7[19246.013867] iwlwifi 0000:12:00.0: Loaded firmware version: 72.daa0512=
5.0 cc-a0-72.ucode
> 8[19246.020573] iwlwifi 0000:12:00.0: 0x000022CE | ADVANCED_SYSASSERT
>=20

Pretty sure this means that the RX was faster than the CPU was
processing, but why would that happen at 100 Mbps?

johannes
